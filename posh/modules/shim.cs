namespace Rice {
using System;
using System.IO;
using System.Linq;
using System.Diagnostics;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.ComponentModel;
using System.Reflection;

internal class ShimAgent {
    // Static hardcoding shim configurations
    // Replace fileds before compiling
    #if (BUILTIN)
    private Func<ShimConfig> Config = () =>{
        return new ShimConfig() {
            path = "{{PathToExe}}",
            args = "{{ExeExecutionArgs}}",
            wait = "{{WaitForExit}}",
            cwd = Environment.CurrentDirectory,
            valid = true
        };
    };
    // Dynamic configure through config file
    #else
    private Func<ShimConfig> Config = () => {
        string shimConfigExt = ".shim";
        string shimConfigPattern = @"(?<key>\S[^=]*\S)\s*=\s*(?<value>\S.*\S)";
        string shimPath = Assembly.GetExecutingAssembly().Location;
        string shimConfigPath = Path.ChangeExtension(shimPath, shimConfigExt);
        // Check if config exists before continuing
        if (!File.Exists(shimConfigPath))
            return new ShimConfig() { valid = false };
        // Read and process line by line
        Regex reg = new Regex(shimConfigPattern, RegexOptions.IgnoreCase);
        var configDict = File.ReadAllLines(shimConfigPath)
                            .Select(line => reg.Match(line))
                            .Where(m => m.Success)
                            .ToDictionary(m => m.Groups["key"].Value,
                                          m => m.Groups["value"].Value);
        return new ShimConfig() {
            path = configDict.Get("path", ""),
            args = configDict.Get("args", ""),
            wait = configDict.Get("wait", bool.TrueString),
            cwd = Environment.CurrentDirectory,
            valid = true
        };
    };
    #endif
    private ShimConfig _config;

    public ShimAgent(string[] argv) {
        _config = Config();
        if (_config.valid)
            // Combine passed arguments with pre-defined arguments
            _config.args += " " + string.Join(" ", argv);
    }

    public int Execute(bool evaluated = false) {
        if (!_config.valid)
            throw new FileNotFoundException(".shim file not found!");
        // Set startup arguemnts
        ProcessStartInfo psinfo = new ProcessStartInfo() {
            FileName = _config.path,
            Arguments = _config.args,
            // Additional arguments for evaluated privilege
            UseShellExecute = evaluated ? true : false,
            Verb = evaluated ? "runas" : ""
        };
        using (Process ps = new Process()) {
            ps.StartInfo = psinfo;
            ps.Start();
            if (bool.Parse(_config.wait)) {
                ps.WaitForExit();
                return ps.ExitCode;
            }
            // Default exit code
            return 0;
        }
    }
}

internal struct ShimConfig {
    public string path;
    public string args;
    public string cwd;
    // string for boolean value true/false
    public string wait;
    public bool valid;
}

internal enum ErrorCode: uint {
    NORMAL = 0,
    // http://msdn.microsoft.com/en-us/library/windows/desktop/ms681388(v=vs.85).aspx
    ERROR_ELEVATION_REQUIRED = 740,
    // http://msdn.microsoft.com/en-us/library/windows/desktop/ms681383(v=vs.85).aspx
    ERROR_CANCELLED = 1223
}

internal static class Extensions {
    public static TValue Get<TKey, TValue>(
        this IDictionary<TKey, TValue> source,
        TKey key,
        TValue default_value) {
        if (source.ContainsKey(key))
            return source[key];
        return default_value;
    }
}

internal class Shim {
    public static int Main(string[] argv) {
        int exit_code = -1;
        ShimAgent agent = new ShimAgent(argv);
        try {
            exit_code = agent.Execute();
        } catch (Win32Exception ex) {
            // Try to run as admin if evaluated privilege required
            if ((ErrorCode)ex.NativeErrorCode == ErrorCode.ERROR_ELEVATION_REQUIRED) {
                try {
                    Console.WriteLine("Evaluation required");
                    exit_code = agent.Execute(true);
                } catch (Win32Exception ex1) {
                    if ((ErrorCode)ex1.NativeErrorCode == ErrorCode.ERROR_CANCELLED)
                        Console.WriteLine("Evaluation cancelled by user.");
                    else
                        Console.WriteLine($"Unknown error: {ex.ToString()}");
                }
            } else {
                Console.WriteLine($"Unknown error: {ex.ToString()}");
            }
        } catch (Exception ex) {
            Console.WriteLine($"Unknown error: {ex.ToString()}");
        }
        return exit_code;
    }
}

}
