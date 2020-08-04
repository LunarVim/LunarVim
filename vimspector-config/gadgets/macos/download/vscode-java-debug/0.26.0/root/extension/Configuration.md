# Java Debug Configuration

## Table of Contents
* [Auto generate the launch.json](#auto-generate-the-launchjson)
* [Modify the launch.json](#modify-the-launchjson)
  * [Main](#main)
    * mainClass
    * projectName
  * [Arguments](#arguments)
    * args
    * vmArgs
  * [Environment](#environment)
    * console
    * env
  * [Don't step into the specified classes or methods](#dont-step-into-the-specified-classes-or-methods)
    * stepFilters
  * [Attach to a debuggee](#attach-to-a-debuggee)
    * hostName
    * port
    * [Attach to mvn task](#attach-to-mvn-task)
    * [Attach to embedded maven tomcat server](#attach-to-embedded-maven-tomcat-server)
    * [Use javac as the builder and attach to java process](#use-javac-as-the-builder-and-attach-to-java-process)
* [Modify the settings.json (User Setting)](#modify-the-settingsjson-user-setting)
  * java.debug.settings.console
  * java.debug.settings.forceBuildBeforeLaunch
  * java.debug.settings.hotCodeReplace
  * java.debug.settings.enableRunDebugCodeLens
* [FAQ](#faq)


The debugger provides two kinds of configuration: *launch.json* and *settings.json* (User Settings), see the [README](https://github.com/Microsoft/vscode-java-debug#options) for the supported configuration list. launch.json is used to control the configuration per debug session, and the user setting is shared by the whole workspace or VS Code.

## Auto generate the launch.json
When you run the program via `Run|Debug` CodeLens or `Run`/`Debug` context menu, the debugger automatically generates the launching configuration for you.
![runMenu](https://user-images.githubusercontent.com/14052197/67181889-715bb380-f410-11e9-9aef-c27ce697daa0.gif)

## Modify the launch.json
On the other hand, the debugger provides multiple configuration templates to help you to easily add a new configuration. When you type `"java"` or `""` in launch.json, it will trigger auto-completion suggestions.
![launchConfig](https://user-images.githubusercontent.com/14052197/67182212-3908a500-f411-11e9-9467-48ba2f6e0e39.gif)

In case you want to manually edit the configuration, below are the explanation and samples about the common debug configurations.
### Main
* `mainClass` - mainClass is used to define your program entry, and it's the most important configuration. The debugger provides three options to help you configure this key, see the samples below.
  * `"mainClass": ""`  
  If you have no idea about what to set here, just leave it empty. The debugger will search all possible main classes from the workspace, then prompt you the list to choose for launch.  
![emptyMainClass](https://user-images.githubusercontent.com/14052197/67261011-25bd0e80-f4d1-11e9-966d-3e82a4e261ce.gif)

  * `"mainClass": "${file}"`  
  If you have multiple main Java files, use this to auto switch to your current focus program. The debugger will resolve the main class from current active Java file, and set it as the launching main class.
![currentFile](https://user-images.githubusercontent.com/14052197/67183367-d7960580-f413-11e9-9773-7df735710054.gif)

  * `"mainClass": "com.microsoft.app.myApp"`  
  The fully qualified class name, generally it's filled by the debugger's auto generation.  
![mainClass](https://user-images.githubusercontent.com/14052197/67190742-17181e00-f423-11e9-98ab-1c568f220ba7.gif)

* `projectName` - The preferred project in which the debugger searches for classes. It's required for the evaluation feature. Most of the time, the debugger will auto generate the configuration for you. In case you want to manually configure it, here are the rules.
  * When you open a maven project, the project name is the `artifactId`.
  * When you open a gradle project, the project name is the `baseName` or the root folder name.
  * When you open other Java files, leave the launch.json empty and allow the debugger auto generates the project name for you.

  Pro Tip: The easiest way to get the project name is to install [Java Dependency Viewer](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-dependency) extension, the top node in the JAVA DEPENDENCIES view is your project name.  
![java-dependency-viewer](https://user-images.githubusercontent.com/14052197/67185034-7cfea880-f417-11e9-8a3b-a3af1a9e86bb.png)

### Arguments
* `args` - Program arguments which are used to pass application configuration to your program, and they are accessible via "args" String array parameter in your main method `public static void main(String[] args)`. It accepts three kinds of value, see the samples below.
  * `"args": "arg0 arg1"`  
  Space separated String value.
  ![programArgs](https://user-images.githubusercontent.com/14052197/67191536-5abf5780-f424-11e9-9664-6cc5805225bb.gif)

  * `"args": ["arg0", "arg1"]`  
  An array of String.
  * `"args": "${command:SpecifyProgramArgs}"`  
  The debugger will prompt you with an input box to type the args value before launching the program. This is convenient when you have a program running against multiple data set.  
  ![specifyArgs](https://user-images.githubusercontent.com/14052197/67191890-0ff20f80-f425-11e9-8df2-5fd98e61c204.gif)

* `vmArgs` - VM arguments are used to configure JVM options and platform properties. Most of these arguments have a prefix (-D, -X, -XX). For example, *-Xms256m* arguments defines the initial Java heap size to 256MB. And you can also use *-DpropertyName=propertyValue* to configure system properties for your program. These properties are read via API *System.getProperty(propertyName)*. It accepts a String or an array of String, see the samples below.
  * `"vmArgs": "-Xms256m -Xmx1g -Dserver=production"`  
  Space separated String value.
  * `"vmArgs": ["-Xms256m", "-Xmx1g", "-Dserver=production"]`  
  An array of String.

### Environment
- `console` - The specified console to launch the current program. Current default value is `integratedTerminal`. You could customize it via the global user setting `java.debug.settings.console` for the whole workspace, or `console` in launch.json for each debug session. The `console` option in launch.json (if provided) takes precedence over `java.debug.settings.console` in user settings.
  * `"console": "internalConsole"`  
  VS Code debug console (input stream not supported). If you're developing backend application, `internalConsole` is recommended.
  ![internalConsole](https://user-images.githubusercontent.com/14052197/67193516-fef6cd80-f427-11e9-8a97-9014470c3a4d.gif)

  * `"console": "integratedTerminal"`  
  VS Code integrated terminal. If you're developing console application with io input requirements, you must use the terminal to accept user input. For example, use *Scanner* class for user input.  
  ![integratedTerminal](https://user-images.githubusercontent.com/14052197/67195762-251e6c80-f42c-11e9-89d0-9545560beea9.gif)

  * `"console": "externalTerminal"`  
  External terminal that can be configured in user settings. The user scenario is same as integrated terminal. The difference is opening an external terminal window to run your program.  
  ![externalTerminal](https://user-images.githubusercontent.com/14052197/67196194-eccb5e00-f42c-11e9-9d4c-6baa5eec18bc.gif)

- `env` - The extra environment variables for the program. It's accessible via `System.getenv(key)`. It accepts key-value pairs.
  ```json
    "env": {
        "HOST": "127.0.0.1",
        "PORT": 8080
    }
  ```

### Don't step into the specified classes or methods

- `stepFilters` - Skip the specified classes or methods you don't want to step into. Class names should be fully qualified. Wildcard is supported.
  - Skip the class loader.
    ```json
    "stepFilters": {
        "classNameFilters": [
            "java.lang.ClassLoader",
        ]
    }
    ```
    ![skipClassLoader](https://user-images.githubusercontent.com/14052197/67254877-ff3bab00-f4b1-11e9-8da0-22b49935bd57.gif)

  - Skip the JDK classes.
    ```json
    "stepFilters": {
        "classNameFilters": [
            "java.*",
            "javax.*",
            "com.sun.*",
            "sun.*",
            "sunw.*",
            "org.omg.*"
        ]
    }
    ```
    ![skipJDK](https://user-images.githubusercontent.com/14052197/67255028-9dc80c00-f4b2-11e9-9113-bef0c0bdf5cb.gif)

  - Skip the constructors and the synthetic methods.
    ```json
    "stepFilters": {
        "skipSynthetics": true,
        "skipStaticInitializers": true,
        "skipConstructors": true
    }
    ```
    ![skipMethods](https://user-images.githubusercontent.com/14052197/67255209-83daf900-f4b3-11e9-8533-70f6ff941e8d.gif)

### Attach to a debuggee
- `hostName` - The host name or ip address of the debuggee you want to attach.
- `port` - The port of the debuggee you want to attach.

Before attaching to a debuggee, your debuggee program must be started with debug mode. The standard command line for debug mode is like `java -agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005 -cp bin MyApp`, and then the debug port of your debuggee is *5005*.
```json
{
    "type": "java",
    "name": "Debug (Attach)",
    "request": "attach",
    "hostName": "localhost",
    "port": 5005
}
```

In some cases, you may want to start your program with the external builder and launcher, then you can configure these jobs in [tasks.json](https://code.visualstudio.com/docs/editor/tasks) and attach to it. For example, launching springboot application via mvn command, and then attach a debugger.
#### Attach to mvn task
1) Configure your command in .vscode/tasks.json - The mvn task is a background task, you should use *problemMatcher* filter to tell VS Code it's ready.  
   ```json
    {
        "label": "mvnDebug",
        "type": "shell",
        "command": "mvn spring-boot:run -Dspring-boot.run.jvmArguments=\"-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005\"",
        "isBackground": true,
        "problemMatcher": [{
            "pattern": [{
                "regexp": "\\b\\B",
                "file": 1,
                "location": 2,
                "message": 3
            }],
            "background": {
                "activeOnStart": true,
                "beginsPattern": "^.*Attaching agents:.*",
                "endsPattern": "^.*Listening for transport dt_socket at address.*"
            }
        }]
    }
    ```
2) Configure `preLaunchTask` and the debug port in .vscode/launch.json.  
    ```json
    {
        "type": "java",
        "name": "Debug (Attach)",
        "request": "attach",
        "hostName": "localhost",
        "port": 5005,
        "preLaunchTask": "mvnDebug"
    }
    ```
3) <b>F5</b> will launch the mvn task, and attach the debugger. See the demo.  
![attachToMvn](https://user-images.githubusercontent.com/14052197/67262705-4f2d6880-f4d8-11e9-9e2d-9c35a6613c08.gif)

#### Attach to embedded maven tomcat server
  - pom.xml sample for embedded tomcat server.  
  ```xml
    ...
    <plugin>
        <groupId>org.apache.tomcat.maven</groupId>
        <artifactId>tomcat7-maven-plugin</artifactId>
        <version>2.2</version>
    </plugin>
    ...
  ```
  - The steps to attach to the embedded maven tomcat server.  
  1) Use .vscode/tasks.json to configure *run-tomcat* and *stop-tomcat* tasks.  
  ```json
    {
        "version": "2.0.0",
        "tasks": [
            {
                "label": "run-tomcat",
                "type": "shell",
                "command": "MAVEN_OPTS=\"$MAVEN_OPTS -agentlib:jdwp=transport=dt_socket,address=5005,server=y,suspend=n\" ./mvnw tomcat7:run",
                "group": "build",
                "isBackground": true,
                "problemMatcher": [{
                    "pattern": [{
                        "regexp": "\\b\\B",
                        "file": 1,
                        "location": 2,
                        "message": 3
                    }],
                    "background": {
                        "activeOnStart": true,
                        "beginsPattern": "^.*Listening for",
                        "endsPattern": "^.*transport dt_socket at address.*"
                    }
                }]
            },
            {
                "label": "stop-tomcat",
                "type": "shell",
                "command": "echo ${input:terminate}}",
                "problemMatcher": []
            }
        ],
        "inputs": [
            {
                "id": "terminate",
                "type": "command",
                "command": "workbench.action.tasks.terminate",
                "args": "run-tomcat"
            }
        ]
    }
  ```
  2) Use .vscode/launch.json to configure the attach configuration. Use `preLaunchTask` to run tomcat before the attach, and `postDebugTask` to stop tomcat after the debug ends.  
  ```json
    {
        "version": "0.2.0",
        "configurations": [
            {
                "type": "java",
                "name": "Debug (Attach)",
                "request": "attach",
                "hostName": "localhost",
                "port": 5005,
                "preLaunchTask": "run-tomcat",
                "postDebugTask": "stop-tomcat"
            }
        ]
    }
  ```
  3) <b>F5</b> will auto start the tomcat server and attach the debugger. The demo below will show how to debug spring mvc in tomcat.  
  ![attachToEmbeddedTomcat](https://user-images.githubusercontent.com/14052197/67541153-80957680-f71a-11e9-9d59-e9aaa752fe33.gif)

  > If you want to try to debug your Java webapps in a standalone tomcat server, please try VS Code [Tomcat for Java](https://marketplace.visualstudio.com/items?itemName=adashen.vscode-tomcat) extension.

  > If you want to try to debug embedded tomcat server with gradle plugin, see the [gradle sample](https://github.com/microsoft/vscode-java-debug/issues/140#issuecomment-343656398).

#### Use javac as the builder and attach to java process
1) Configure the javac builder and java runner jobs in .vscode/tasks.json.
    ```json
    {
        "version": "2.0.0",
        "tasks": [
            {
                "label": "build",
                "type": "shell",
                "command": "javac -g -sourcepath ./**/*.java -d ./bin"
            },
            {
                "label": "debug",
                "dependsOn": "build",
                "type": "shell",
                "command": "java -agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005 -cp bin app.SimpleCalc",
                "isBackground": true,
                "problemMatcher": [{
                    "pattern": [{
                        "regexp": "\\b\\B",
                        "file": 1,
                        "location": 2,
                        "message": 3
                    }],
                    "background": {
                        "activeOnStart": true,
                        "beginsPattern": "^.*Listening for",
                        "endsPattern": "^.*transport dt_socket at address.*"
                    }
                }]
            }
        ]
    }
    ```
2) Configure `preLaunchTask` and the debug port in .vscode/launch.json.  
    ```json
    {
        "version": "0.2.0",
        "configurations": [
            {
                "type": "java",
                "name": "Debug (Attach)",
                "request": "attach",
                "hostName": "localhost",
                "port": 5005,
                "preLaunchTask": "debug"
            }
        ]
    }
    ```
3) <b>F5</b> will run the tasks and attach the debugger. See the demo.  
![attachToJava](https://user-images.githubusercontent.com/14052197/67263956-3cb52e00-f4dc-11e9-9c78-6e66cb3d7c2b.gif)

## Modify the settings.json (User Setting)
- `java.debug.settings.console` - The specified console to launch Java program, defaults to `integratedTerminal`. If you want to customize the console for a specific debug session, please use `console` option in launch.json instead.
  ![terminal](https://user-images.githubusercontent.com/14052197/67256063-cf8fa180-f4b7-11e9-9455-77daad2f0ec9.gif)

- `java.debug.settings.forceBuildBeforeLaunch` - Force building the workspace before launching java program, defaults to `true`. Sometimes you may be bothered with the message *"Build failed, do you want to continue?"*, you could disable this setting to suppress the message.

- `java.debug.settings.hotCodeReplace` - Reload the changed Java classes during debugging, defaults to `manual`. It supports `manual`, `auto`, `never`.
  - `manual` - Click the toolbar to apply the changes.  
  ![hcr](https://user-images.githubusercontent.com/14052197/67256313-f5697600-f4b8-11e9-9db6-54540b6350ad.png)
  - `auto` - Automatically apply the changes after saved.
  - `never` - Never apply the changes.

- `java.debug.settings.enableRunDebugCodeLens` - Enable the code lens provider for the *Run* and *Debug* buttons over main entry points, defaults to `true`.
  - `true` - Show the code lens.  
  ![codelens](https://user-images.githubusercontent.com/14052197/67256585-83922c00-f4ba-11e9-883f-2b3de3db2dfa.png)
  - `false` - Show the Run/Debug link in the hover.  
  ![hover](https://user-images.githubusercontent.com/14052197/67256539-2ac29380-f4ba-11e9-8a5b-e5e1d0a27f0e.png)

## FAQ
### 1. No way to take input.  
If you are using *Scanner(System.in)* to get the user input, you need change the user setting `java.debug.settings.console` to `integratedTerminal` or `externalTerminal`.

### 2. Code output is not in the DEBUG CONSOLE panel but Terminal.  
By default, the debugger uses the terminal to launch your program for better accepting user input. And you will see the original command line is displayed at the top of the terminal. If you want a cleaner console to show your code output, you could try to change the user setting `java.debug.settings.console` to `internalConsole`. Please notice that the internal console (VS Code built-in DEBUG CONSOLE) doesn't support user input.

### 3. The classpath changed when using terminal.
In order to avoid the command line being too long, the debugger will shorten your classpath into classpath.jar (for JDK 8 only) or argsfile (for JDK 9 and above) by default. If your program need read the original classpath value (for example, *System.getProperty("java.class.path")*), you could try to change the console to `internalConsole`, or use a higher JDK (9 and above) to launch your program.

### 4. Failed to launch debuggee in terminal with TransportTimeoutException.  
When launching failed in terminal, then you could try to change the user setting `java.debug.settings.console` to `internalConsole`.
