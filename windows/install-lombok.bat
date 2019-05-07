@echo off

FOR /F "tokens=1,2 delims==" %%G IN (config.properties) DO (set %%G=%%H)

set m2_repo=%USERPROFILE%\.m2
set eclipse_ini_file_name=eclipse.ini
set lombok_jar_original_name=lombok-%lombok_version%.jar
set lombok_jar_name=lombok.jar
set lombok_parent_dir=%m2_repo%\repository\org\projectlombok\lombok
set lombok_dir=%lombok_parent_dir%\%lombok_version%
set lombok_original_jar=%lombok_dir%\%lombok_jar_original_name%


set groupId=org.projectlombok
set artifactId=lombok
set repo_url=http://download.java.net/maven/2/

if not exist %lombok_original_jar% (
	echo Downloading%lombok_jar_name% from %repo_url%
	call mvn dependency:get -DrepoUrl=%repo_url% -DartifactId=%artifactId% -DgroupId=%groupId% -Dlombok_version=%lombok_version%

	if %errorlevel% == 0 (
		echo %lombok_original_jar% has been successfully downloaded from %repo_url%
	) else (
		echo Failed to download %lombok_original_jar% from %repo_url%
		exit 1
	)
) else (
	echo %lombok_original_jar% is already exist in local maven repository
)


set config_file=config.properties
if not exist %eclipse_home%\config.properties (
	cp .\config.properties %eclipse_home%\%config_file%
	if %errorlevel%==0 (
		echo %config_file% has been successfully copied to %eclipse_home%
	) else (
		echo Failed to copy %config_file% to %eclipse_home%
		exit 1
	)
)

set eclipse_start_script=eclipse.bat
if not exist %eclipse_home%\%eclipse_start_script% (
	cp .\config.properties %eclipse_home%\%eclipse_start_script%
	if %errorlevel%==0 (
		echo %eclipse_start_script% has been successfully copied to %eclipse_home%
	) else (
		echo Failed to copy %eclipse_start_script% to %eclipse_home%
		exit 1
	)
)

if not exist %eclipse_home%\%lombok_jar_original_name% (
	if not exist %eclipse_home%\%lombok_jar_name% (
	echo copy %lombok_original_jar% to %eclipse_home%
		cp %lombok_original_jar% %eclipse_home%\
		
		if %errorlevel%==0 (
			echo %lombok_original_jar% has been successfully copied to %eclipse_home%
		) else (
			echo Failed to copy %lombok_original_jar% to %eclipse_home%
			exit 1
		)
	)
)

set lombok_java_agent=-javaagent:%eclipse_home%\%lombok_jar_name%

if not exist %eclipse_home%\%lombok_jar_name% (
	echo rename %eclipse_home%\%lombok_jar_original_name% to %lombok_jar_name%
	ren %eclipse_home%\%lombok_jar_original_name% %lombok_jar_name%
	
	if %errorlevel%==0 (
	echo %eclipse_home%\%lombok_jar_original_name% has been successfully renamed to %lombok_jar_name%
	) else (
		echo Failed to rename %eclipse_home%\%lombok_jar_original_name% to %lombok_jar_name%
		exit 1
	)
)

>nul find "%lombok_java_agent%" %eclipse_home%\%eclipse_ini_file_name%
if %errorlevel%==0 (
	echo lombok agent is already configured in %eclipse_ini_file_name% file
) else (
	echo configuring lombok agent in %eclipse_ini_file_name% file
	ECHO %lombok_java_agent%>>%eclipse_home%\%eclipse_ini_file_name%
)

