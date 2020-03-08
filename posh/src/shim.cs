//#define HARDCODED
#undef HARDCODED

namespace Rice {
using System;
using System.IO;
using System.Linq;
using System.Diagnostics;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.ComponentModel;
using System.Reflection;

internal class Shim {
    // Hardcoding shim configurations
    // Replace fileds before compiling
    #if (HARDCODED)
    private static Func<ShimConfig> Config = () =>{
        return new ShimConfig() {
            path = @"{{PathToExe}}",
            args = @"{{ExeExecutionArgs}}",
            wait = @"{{WaitForExit}}",
            cwd = Environment.CurrentDirectory,
            valid = true
        };
    };
    // Dynamic configure through config file
    #else
    private static Func<ShimConfig> Config = () => {
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
            path = configDict.TryGet("path", ""),
            args = configDict.TryGet("args", ""),
            wait = configDict.TryGet("wait", bool.TrueString),
            cwd = Environment.CurrentDirectory,
            valid = true
        };
    };
    #endif

    public static IEnumerable<string> HandleCli(string[] argv) {
        IList<string> args_list = new List<string>(argv);
        // Extract shim cli arguments
        if (args_list.Remove("--shim-debug")) {
            Logger.Enable = true;
        }
        // If any argument has whitespace. Make sure they are quoted properly
        return args_list.Select(arg => arg.Contains(' ') ?
                                       string.Format("\"{0}\"", arg) : arg);
    }

    public static int Main(string[] argv) {
        int exit_code = -1;
        // Get default configuration
        ShimConfig config = Shim.Config();
        if (!config.valid) {
            Logger.Debug("shim", ".shim file not found!");
            return exit_code;
        }
        // Handle shim cli arguments first
        // Then combine passed arguments with pre-defined arguments
        config.args += " " + string.Join(" ", Shim.HandleCli(argv));
        ShimAgent agent = new ShimAgent(config);
        // Start delegated process
        try {
            exit_code = agent.Execute();
        } catch (Win32Exception ex) {
            // Try to run as admin if evaluated privilege required
            if ((ErrorCode)ex.NativeErrorCode == ErrorCode.ERROR_ELEVATION_REQUIRED) {
                try {
                    Logger.Debug("shim", "Evaluation required");
                    exit_code = agent.Execute(true);
                } catch (Win32Exception ex1) {
                    if ((ErrorCode)ex1.NativeErrorCode == ErrorCode.ERROR_CANCELLED)
                        Logger.Debug("shim", "Evaluation cancelled by user.");
                    else
                        Logger.Debug("shim", "Unknown error: {0}".FormatWith(ex.ToString()));
                }
            } else {
                Logger.Debug("shim", "Unknown error: {0}".FormatWith(ex.ToString()));
            }
        } catch (Exception ex) {
            Logger.Debug("shim", "Unknown error: {0}".FormatWith(ex.ToString()));
        }
        return exit_code;
    }
}

internal class ShimAgent {

    public ShimConfig Conf { get; set; }

    public ShimAgent(ShimConfig config) {
        Conf = config;
    }

    public int Execute(bool evaluated = false) {
        // Set startup arguemnts
        ProcessStartInfo psinfo = new ProcessStartInfo(Conf.path, Conf.args);
        // Additional arguments for evaluated privilege
        if (evaluated) {
            psinfo.UseShellExecute = true;
            psinfo.Verb = "runas";
        } else {
            psinfo.UseShellExecute = false;
            psinfo.Verb = "";
        }
        using (Process ps = new Process()) {
            ps.StartInfo = psinfo;
            if (bool.Parse(Conf.wait)) {
                ps.Start();
                ps.WaitForExit();
                return ps.ExitCode;
            }
            ps.Start();
        }
        // Default exit code
        return 0;
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
    public static TValue TryGet<TKey, TValue>(
        this IDictionary<TKey, TValue> source,
        TKey key,
        TValue default_value) {
        if (source.ContainsKey(key))
            return source[key];
        return default_value;
    }

    public static string FormatWith(this string source, params object[] values) {
        return String.Format(source, values);
    }
}

internal static class Logger {
    public static bool Enable { get; set; }

    static Logger() {
        Enable = false;
    }
    public static void Debug(string source, string message) {
        if (!Logger.Enable)
            return;
        if (string.IsNullOrWhiteSpace(source))
            Console.WriteLine(message);
        else
            Console.WriteLine("[{0}] {1}".FormatWith(source, message));
    }
}

}
