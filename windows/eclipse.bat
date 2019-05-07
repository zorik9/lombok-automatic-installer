@echo off 

FOR /F "tokens=1,2 delims==" %%G IN (config.properties) DO (set %%G=%%H)  
set m2_repo=%USERPROFILE%\.m2
set lombok_jar=%m2_repo%\repository\org\projectlombok\lombok\%lombok_version%\lombok-%lombok_version%.jar

start /B /D%eclipse_home% eclipse.exe -clean -data %workspace_dir% -vm %JAVA_HOME%\bin\javaw -vmargs -Dosgi.requiredJavaVersion=1.8 -Xms256m -Xmx2048m -javaagent:%lombok_jar% -Xbootclasspath/a:%lombok_jar%