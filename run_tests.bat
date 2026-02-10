@echo off
echo Installing dependencies...
pip install -r requirements.txt -q
echo Running Robot Framework tests...
robot --outputdir results --loglevel INFO tests/
echo.
echo Open results\report.html to view the report.
pause
