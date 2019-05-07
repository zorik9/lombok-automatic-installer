# Lombok Automatic Installer
Lombok Automatic Installer, is a utility tool for installing lombok in eclipse development environment without GUI installers. Instead of running the standard lombok GUI installer, You can run this automatic installer directly from an installation script. 

## Assumptions
1. You are using maven as a build tool.
2. Your eclipse.ini file does not contains java agent, or you don't care to override the existing java agent.

## Installation

### Configuration
Configure the following properties, in config.properties file:
lombok_version=[The requested lombok version]
eclipse_home=[The home directory of eclipse installation]
workspace_dir=[The workspace to be loaded when eclipse starts]

If you would like to choose the workspace from eclipse startup screen,
then leave the workspace_dir property empty

The other properties are mandatory.

### Installation script

Run the install-lombok script that matches your operating system.

in case of windows, the installation script is: install-lombok.bat

### After Installation

After running the install-lombok the following configurations will be applied:
1. A java agent will be added (or updated) to eclipse.ini file
[```-javaagent:[eclipse_home]\lombok.jar```]
2. lombok.jar will be added to eclipse_home directory. This jar has been renamed from lombok-[lombok_version].jar to lombok.jar
3. config.properties file will be copied to eclipse_home directory.
4. eclipse.bat (for windows users) will be copied to eclipse_home directory.



## Usage

You would like to open eclipse without encountering compilation errors, due to lombok (such as missing setters, missing getters and so on)

At the first time you open eclipse, use the eclipse.bat (for windows users) script.

After the first time, you can run eclipse in 2 ways:
1. eclipse.bat (for windows users) script
2. eclipse.exe (normal execution of eclipse)

The expected result:
No compilation errors in open projects with lombok dependency

## Advanced Usage

You can automate development environments setup on the cloud, by installing it from scripts instead of GUI installers. In case of eclipse automatic setup with lombok - Connect your CI/CD pipeline to the installation script 

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to to test your code before opening pull requests.

Right now we support only windows machines. I would like to extend the support to UNIX and MAC machines, as well.
