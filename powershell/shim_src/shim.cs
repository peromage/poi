using System;
using System.IO;
using System.Collections.Generic;
using System.Diagnostics;
using System.ComponentModel;
using System.Reflection;
using System.Text.RegularExpressions;

namespace Rice {
    public class Shim {
        public static int Main(string[] args) {
            var cmdArgs = GetArgs(Environment.CommandLine); // args passed by command line
            var config = new Config(Assembly.GetExecutingAssembly().Location);
            // check if shim file exists
            if (!config.Read())
                return 1;

            using (var process = new Process())
            {
                // Disable ShellExecute() to redirect stdout to current shell.
                // But a console window still pops up when directly executing shim.
                process.StartInfo.FileName = config.ExecPath;
                process.StartInfo.Arguments = (config.ExecArgs + " " + cmdArgs).Trim();
                process.StartInfo.UseShellExecute = false;
                try
                {
                    process.Start();
                }
                catch (Win32Exception e)
                {
                    Console.Error.WriteLine("Failed to start process: " + e.Message);
                    return e.ErrorCode;
                }
                process.WaitForExit();
                return process.ExitCode;
            }
        }

        // strips the program name from the command line, returns just the arguments
        static string GetArgs(string cmdLine) {
            if(cmdLine.StartsWith("\"")) {
                var endQuote = cmdLine.IndexOf("\" ", 1);
                if(endQuote < 0) return "";
                return cmdLine.Substring(endQuote + 1);
            }
            var space = cmdLine.IndexOf(' ');
            if(space < 0 || space == cmdLine.Length - 1) return "";
            return cmdLine.Substring(space + 1);
        }

        private class Config
        {
            public Config(string exePath)
            {
                ExePath = exePath;
            }

            public bool Read()
            {
                if(!File.Exists(ConfigPath))
                {
                    Console.Error.WriteLine("Couldn't find " + Path.GetFileName(ConfigPath) + " in " + Dir);
                    return false;
                }
                
                var config = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
                foreach(var line in File.ReadAllLines(ConfigPath)) {
                    var m = Regex.Match(line, @"([^=]+)=(.*)");
                    if(m.Success) {
                        config[m.Groups[1].Value.Trim()] = m.Groups[2].Value.Trim();
                    }
                }
                string path, args;
                config.TryGetValue("path", out path);
                config.TryGetValue("args", out args);
                ExecPath = path;
                ExecArgs = args;
                return true;
            }

            public string ExePath { get; private set; }
            public string Dir { get { return Path.GetDirectoryName(ExePath); }}
            public string Name { get { return Path.GetFileNameWithoutExtension(ExePath); }}
            public string ConfigPath { get { return Path.Combine(Dir, Name+".shim"); }}
            public string ExecPath { get; private set; }
            public string ExecArgs { get; private set; }
        }
    }
}