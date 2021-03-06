@echo off
start "" /D c:\ "d:\Program Files\MongoDB\Server\3.4\bin\mongod.exe"
start "" /D c:\redis "c:\redis\redis-server.exe"
net start mysql57
net start mssqlserver

cd ..
dotnet restore
cd test

cd Audit.Mvc.UnitTest
dotnet build
dotnet test --logger:"console;verbosity=normal"
echo continue...
pause > nul

cd ..

cd Audit.UnitTest
dotnet test --logger:"console;verbosity=normal"
echo continue...
pause > nul
cd ..

cd Audit.WebApi.UnitTest
dotnet test --logger:"console;verbosity=normal"
echo continue...
pause > nul

cd ..

cd Audit.DynamicProxy.UnitTest
dotnet test --logger:"console;verbosity=normal"
echo continue...
pause > nul
cd ..

cd Audit.EntityFramework.UnitTest
"C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"
..\..\packages\NUnit.ConsoleRunner.3.7.0\tools\nunit3-console.exe bin\Debug\Audit.EntityFramework.UnitTest.dll --noresult
echo continue...
pause > nul
cd ..

cd Audit.Redis.UnitTest
dotnet test --logger:"console;verbosity=normal"
echo continue...
pause > nul
cd ..

cd Audit.IntegrationTest
dotnet test --logger:"console;verbosity=normal"
echo continue...
pause > nul
cd ..

del TestResult.xml /s

net stop mssqlserver
net stop mysql57
taskkill /f /im mongod.exe
taskkill /f /im redis-server.exe