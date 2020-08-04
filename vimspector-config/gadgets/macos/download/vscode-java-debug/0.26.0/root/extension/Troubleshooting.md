# Troubleshooting

This document provides the information needed to troubleshoot common errors of Debugger for Java (the debugger). If it does not cover the problem you are seeing, please [log an issue](https://github.com/Microsoft/vscode-java-debug/issues) instead.

## Java Language Support extension fails to start.
The debugger works with [Language Support for Java(TM) by Red Hat](https://marketplace.visualstudio.com/items?itemName=redhat.java) (the language server) for source mapping and project support. If the language server fails to start, the debugger will not work as expected. Here is a simple way to check whether the language server is started. Open a .java or a Java project folder in VS Code, and then check the icon at the right side of the status bar. You should see the 👍 icon if the language server is loaded correctly.

 ![status indicator](https://raw.githubusercontent.com/redhat-developer/vscode-java/master/images/statusMarker.png).

### Try:
1. If you get the error *"The JAVA_HOME environment variable points to a missing folder"* or *"Java runtime could not be located"*, please make sure that the environment variable JAVA_HOME points to a valid JDK. Otherwise, ignore this step.
2. Open your Maven *pom.xml* file or Gradle *build.gradle* file, then run VS Code command *"Java: Update project configuration"* to force the language server to update the project configuration/classpath.
3. Run VS Code command *"Java: Clean the Java language server workspace"* to clean the stale workspace cache.
4. Try more [troubleshooting guide](https://github.com/redhat-developer/vscode-java/wiki/Troubleshooting) from the language server product site.

## Build failed, do you want to continue?
### Reason:
The error indicates your workspace has build errors. There are two kinds of build errors. One is compilation error for source code, the other is project error.

### Try:
1. Open VS Code PROBLEMS View, and fix the errors there.
2. Run VS Code command *"Java: Open Java language server log file"*, search keyword `build/building workspace` to find more details for the build errors.
3. If still cannot find out what errors, then reference the [language server troubleshooting](#try) paragraph to [2]update project configuration, and [3]clean workspace cache.

## x.java isn't on the classpath. Only syntax errors will be reported
### Reason:
This error indicates the Java file you opened isn't on the classpath of any project, and no .class file will be generated because Java language server only auto builds Java source files on the project classpath. If you try to run or debug this Java file, you may get the error "Could not find or load main class".

### Try:
1. Go to *File Explorer*, right click the folder containing your Java file, and run the menu *"Add Folder to Java Source Path"* to mark the containing folder as a Java source root.
2. Run VS Code command *"Java: List all Java source paths"* to check whether the containing folder is added as a Java source root.

## Program Error: Could not find or load main class x
### Reason:
You configure the incorrect main class name in `mainClass` of *launch.json*, or your Java file is not on the classpath.

### Try:
1. Check whether the class name specified in `mainClass` exists and is in the right form.
2. Run VS Code command *"Java: List all Java source paths"* to show all source paths recognized by the workspace.
3. Check the Java file you are running is under any source path? If not, go to *File Explorer*, right click the folder containing your Java file, and run the menu *"Add Folder to Java Source Path"* to mark the containing folder as a Java source root.
4. Run VS Code command *"Java: Force Java compilation"* to rebuild your workspace.
5. If the problem persists, it's probably because the language server doesn't load your project correctly. Please reference the [language server troubleshooting](#try) paragraph for more troubleshooting info.

## Program throws ClassNotFoundException
### Reason:
This error indicates your application attempts to reference some classes which are not found in the entire classpaths.

### Try:
1. Check whether you configure the required libraries in the dependency settings file (e.g. *pom.xml*).
2. If you have recently modified the *pom.xml* or *build.gradle* config file, you need right click on *pom.xml* or *build.gradle* file and then run the menu *"Update project configuration"* to force the language server to update the project configuration/classpath.
3. Run VS Code command *"Java: Force Java compilation"* to force the language server to rebuild the current project.
4. If the problem persists, it's probably because the language server doesn't load your project correctly. Please reference the [language server troubleshooting](#try) paragraph for more troubleshooting info.

## Program throws UnsupportedClassVersionError
Below is a typical error message.

![image](https://user-images.githubusercontent.com/14052197/78854443-ed47c780-7a53-11ea-8317-d8b097dfba99.png)

### Reason:
The compiled classes are not compatible with the runtime JDK.

The class file version `57.65535` stands for Java 13 preview, where the major version `57` stands for Java 13, the minor version `65535` stands for preview feature. Similarly `58.65535` stands for Java 14 preview.

The error says the compiled class is `57.65535`, but the runtime JDK only recognizes class file versoin `58.65535`. That's because the preview feature is not backward compatible, i.e. JVM 14 doesn't support 13 preview feature. The [openjdk](https://openjdk.java.net/jeps/12) website has claimed the reason that it would be costly for JDK 14 to support preview features from JDK 13 which were changed or dropped in response to feedback.

One possible root cause for this error is your runtime JDK is the latest JDK but the upstream [Language Support for Java](https://marketplace.visualstudio.com/items?itemName=redhat.java) extension doesn't catch up the support yet.

### Try:
1. Try to update [Language Support for Java](https://marketplace.visualstudio.com/items?itemName=redhat.java) to the latest, and then try step 3 to rebuild the workspace.
2. If it doesn't work, then try to install an older JDK version, set its installation folder to "java.home" user setting in _.vscode/settings.json_ and reopen your VS Code workspace.
3. Click **F1** -> **Java: Force Java compilation** -> **Full** to rebuild the workspace.
4. If it still doesn't work, then try **F1** -> **Java: Clean the Java language server workspace** to clean the cache.

## Failed to complete hot code replace:
### Reason:
This error indicates you are doing `Hot Code Replace`. The `Hot Code Replace` feature depends on the underlying JVM implementation. If you get this error, that indicates the new changes cannot be hot replaced by JVM.

### Try:
1. Check the HCR limitation from the [wiki](https://github.com/microsoft/vscode-java-debug/wiki/Hot-Code-Replace).
2. Restart your application to apply the new changes. Or ignore the message, and continue to debug.
3. You can disable the hot code replace feature by changing the user setting `"java.debug.settings.hotCodeReplace": "never"`.

## Please specify the host name and the port of the remote debuggee in the launch.json.
### Reason:
This error indicates you are debugging a remote Java application. The reason is that you don't configure the remote machine's host name and debug port correctly.

### Try:
1. Check whether the remote Java application is launched in debug mode. The typical command to enable debug mode is like *"java -agentlib:jdwp=transport=dt_socket,address=5005,server=y,suspend=n -classpath \<classpath list\> MyMainClass"*, where the parameter *"address=5005"* represents the target JVM exposes *5005* as the debug port.
2. Check the debug port is not blocked by the remote machine's firewall.

## Failed to evaluate. Reason: Cannot evaluate because the thread is resumed.
### Reason:
There are two possible reasons for this error. 
- Reason 1: you try to evaluate an expression when the target thread is running. Evaluation only works when your program is on suspend, for example, stopping at a breakpoint or stepping in/out/over.
- Reason 2: you take the VS Code DEBUG CONSOLE view for program input by mistake. DEBUG CONSOLE only accepts input for evaluation, not for program console input.

### Try:
1. For Reason 1, try to add a breakpoint and stop your program there, then evaluate the expression.
2. For Reason 2, try to change the `console` option in the *launch.json* to `externalTerminal` or `integratedTerminal`. This is the official solution for program console input.

## Cannot find a class with the main method
### Reason:
When the `mainClass` is unconfigured in the *launch.json*, the debugger will resolve a class with main method automatically. This error indicates the debugger doesn't find any main class in the whole workspace.

### Try:
1. Check at least one main class exists in your workspace.
2. If no main class exists, please create a main class first. Otherwise, it's probably because the language server fails to start. Please reference the [language server troubleshooting](#try) paragraph for more troubleshooting info.

## No delegateCommandHandler for vscode.java.startDebugSession when starting Debugger
### Reason:
Cause of error is for now unknown, but something caused vscode java support and debugger to not be configured correctly.

### Try:
1. Restart VS Code and the issue should disappear 
2. If it continues to error try restart again, and if still a problem open an issue at [vscode-java-debug](https://github.com/Microsoft/vscode-java-debug)

## Failed to resolve classpath:
### Reason:
Below are the common failure reasons.
- 'C:\demo\com\microsoft\app\Main.java' is not a valid class name.
- Main class 'com.microsoft.app.Main' doesn't exist in the workspace.
- Main class 'com.microsoft.app.Main' isn't unique in the workspace.
- The project 'demo' is not a valid java project.

In launch mode, the debugger resolves the classpaths automatically based on the given `mainClass` and `projectName`. It looks for the class specified by `mainClass` as the entry point for launching an application. If there are multiple classes with the same name in the current workspace, the debugger uses the one inside the project specified by `projectName`.

### Try:
1. Check whether the class name specified in `mainClass` exists and is in the right form. The debugger only works with fully qualified class names, e.g. `com.microsoft.app.Main`.
2. Check whether the `projectName` is correct. The actual project name is not always the same to the folder name you see in the File Explorer. Please check the value specified by `projectDescription/name` in the *.project* file, or the `artificatId` in the *pom.xml* for maven project, or the folder name for gradle project.
3. If the problem persists, please try to use the debugger to regenerate the debug configurations in *launch.json*. Remove the existing *launch.json* file and press F5. The debugger will automatically generate a new *launch.json* with the right debug configurations.

## Request type "xyz" is not supported. Only "launch" and "attach" are supported.
### Reason:
The value specified in `request` option of *launch.json* is incorrect.

### Try:
1. Reference the VS Code official document [launch configurations](https://code.visualstudio.com/docs/editor/debugging#_launch-configurations) about how to configure *launch.json*.
2. Try to use the debugger to regenerate the debug configurations in *launch.json*. Remove the existing *launch.json* file and press F5. The debugger will automatically generate a new *launch.json* with the right debug configurations.
