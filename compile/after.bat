@echo off
echo Running After >> %3
move "%2_tidy.txt" "tidy\%2_tidy.txt" >> %3
move "%2_stripped.au3" "stripped\%2_stripped.au3" >> %3
echo Ended >> %3