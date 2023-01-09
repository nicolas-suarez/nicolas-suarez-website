cd C:\Users\nsuar\Dropbox\github\nicolas-suarez-website
hugo -d public
cd public
git add .
@echo off
set /p comment="Description of commit: "
git commit -m "%comment%"
git push