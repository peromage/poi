//#define HARDCODE

namespace RiceShim {
using System;
using System.IO;
using System.Linq;
using System.Diagnostics;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.ComponentModel;
using System.Reflection;

public class ShimApp {
    // Main entry
    public static int Main(string[] argv) {
        // Handle shim cli arguments first
        // Extract shim cli arguments
        ShimApp app = new ShimApp();
        IList<string> args_list = new List<string>(argv);
        // Enable logging
        if (args_list.Remove("--shim-debug")) {
            ShimHelper.EnableLog = true;
            string info = "{0,-20}: {1}";
            ShimHelper.LogD("----- Shim Info -----");
            ShimHelper.LogD(info.FormatWith("Target", app.Config.Target));
            ShimHelper.LogD(info.FormatWith("Arguments", app.Config.Arguments));
            ShimHelper.LogD(info.FormatWith("Is GUI App", app.Config.Gui));
            ShimHelper.LogD(info.FormatWith("Working Directory", app.Config.Cwd));
            ShimHelper.LogD(info.FormatWith("Valid Configuration", app.Config.Valid.ToString()));
            ShimHelper.LogD(info.FormatWith("Hardcoded", app.Config.Hardcode.ToString()));
            ShimHelper.LogD("--- End Shim Info ---");
        }
        // Print shim debug info and exit
        if (args_list.Remove("--shim-dry-run")) {
            return 0;
        }

        // Validate configuration
        if (!app.Config.Valid) {
            ShimHelper.LogE("Configuration for shim is not valid");
            return 1;
        }
        // Then combine passed arguments with pre-defined arguments
        app.Config.Arguments += " " + string.Join(" ", args_list.Select(
            arg => arg.Contains(' ') ? string.Format("\"{0}\"", arg) : arg));

        // Start delegated process
        int exit_code = 1;
        try {
            exit_code = app.Execute();
            ShimHelper.LogD("Shim executed successfully");
            ShimHelper.LogD("Return code {0}".FormatWith(exit_code.ToString()));
        } catch (Win32Exception ex) {
            // Try to run as admin if evaluated privilege required
            if ((ErrorCode)ex.NativeErrorCode == ErrorCode.ERROR_ELEVATION_REQUIRED) {
                try {
                    ShimHelper.LogD("Evaluation required");
                    exit_code = app.Execute(true);
                } catch (Win32Exception ex1) {
                    if ((ErrorCode)ex1.NativeErrorCode == ErrorCode.ERROR_CANCELLED) {
                        ShimHelper.LogD("Evaluation cancelled by user.");
                    } else {
                        ShimHelper.LogE("Unknown error: {0}".FormatWith(ex.ToString()));
                    }
                }
            } else {
                ShimHelper.LogE("Unknown error: {0}".FormatWith(ex.ToString()));
            }
        } catch (Exception ex) {
            ShimHelper.LogE("Unknown error: {0}".FormatWith(ex.ToString()));
        }
        return exit_code;
    }

    // ShimApp executes the target binary
    private ShimConfig _config;
    public ShimConfig Config {
        get { return _config; }
        set { _config = value; }
    }

    public ShimApp() {
        _config = new ShimConfig();
    }

    public int Execute(bool evaluated = false) {
        // Set startup arguemnts
        ProcessStartInfo psinfo = new ProcessStartInfo(Config.Target, Config.Arguments);
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
            if (bool.Parse(Config.Gui)) {
                ps.Start();
                return 0; // Default exit code
            } else {
                ps.Start();
                ps.WaitForExit();
                return ps.ExitCode;
            }
        }
    }
} // End class ShimApp

public class ShimConfig {
    private string _target;
    private string _arguments;
    private string _gui;
    private string _cwd;
    private bool _valid;
    private bool _hardcode;
    public string Target {
        get { return _target; }
        set { _target = value; }
    }
    public string Arguments {
        get { return _arguments; }
        set { _arguments = value; }
    }
    public string Gui {
        get { return _gui; }
        set { _gui = value; }
    }
    public string Cwd {
        get { return _cwd; }
        set { _cwd = value; }
    }
    public bool Valid {
        get { return _valid; }
        set { _valid = value; }
    }
    public bool Hardcode {
        get { return _hardcode; }
        set { _hardcode = value; }
    }

    // Hardcoding shim configurations
    // Replace fileds before compiling
    #if (HARDCODE)
    public ShimConfig() {
        Target = @"{{PathToExe}}";
        Arguments = @"{{ExeArgs}}";
        Gui = @"{{IsGuiApp}}";
        Cwd = Environment.CurrentDirectory;
        Valid = true;
        Hardcode = true;
    }
    // Dynamically configure through config file
    #else
    public ShimConfig() {
        string shimConfigPath = Path.ChangeExtension(Assembly.GetExecutingAssembly().Location, ".shim");
        // Check if config exists before continuing
        if (!File.Exists(shimConfigPath)) {
            Target = string.Empty;
            Arguments = string.Empty;
            Gui = string.Empty;
            Cwd = Environment.CurrentDirectory;
            Valid = false;
            Hardcode = false;
        } else {
            // Read and process line by line
            Regex reg = new Regex(@"(?<key>\S[^=]*\S)\s*=\s*(?<value>\S.*\S)", RegexOptions.IgnoreCase);
            var configDict = File.ReadAllLines(shimConfigPath)
                                 .Select(line => reg.Match(line))
                                 .Where(m => m.Success)
                                 .ToDictionary(m => m.Groups["key"].Value,
                                               m => m.Groups["value"].Value);
            Target = configDict.TryGet("target", string.Empty);
            Arguments = configDict.TryGet("arguments", string.Empty);
            Gui = configDict.TryGet("gui", bool.FalseString);
            Cwd = Environment.CurrentDirectory;
            Valid = true;
            Hardcode = false;
        }
    }
    #endif
} // End class ShimConfig

internal static class ShimHelper {
    private static bool _enableLog;
    public static bool EnableLog {
        get { return _enableLog; }
        set { _enableLog = value; }
    }

    static ShimHelper() {
        EnableLog = false;
    }

    // Logger functions
    public static void LogD(string message) {
        if (ShimHelper.EnableLog) {
            Console.WriteLine("[ShimDebug] {0}".FormatWith(message));
        }
    }
    public static void LogE(string message) {
        if (ShimHelper.EnableLog) {
            Console.WriteLine("[ShimError] {0}".FormatWith(message));
        }
    }

    // Extensions
    public static TValue TryGet<TKey, TValue>(this IDictionary<TKey, TValue> source,
                                                TKey key,
                                                TValue default_value) {
        if (source.ContainsKey(key)) {
            return source[key];
        }
        return default_value;
    }

    public static string FormatWith(this string source, params object[] values) {
        return String.Format(source, values);
    }
} // End class ShimHelper

internal enum ErrorCode: uint {
    NORMAL = 0,
    // http://msdn.microsoft.com/en-us/library/windows/desktop/ms681388(v=vs.85).aspx
    ERROR_ELEVATION_REQUIRED = 740,
    // http://msdn.microsoft.com/en-us/library/windows/desktop/ms681383(v=vs.85).aspx
    ERROR_CANCELLED = 1223
} // End enum ErrorCode
} // End namespace Shim
