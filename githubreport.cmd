"C:\Program Files\Git\git-bash.exe" -c "/c/AutoSys/GitHub/githubreports/githubreport.sh %GITHUB_ACCESS_TOKEN%"
if %errorlevel% neq 0 exit /b %errorlevel%
