"C:\Program Files\Git\git-bash.exe" -c "/c/Users/toolsadmin/Documents/Github/githubreports/githubreport.sh %GITHUB_ACCESS_TOKEN%"
if %errorlevel% neq 0 exit /b %errorlevel%
