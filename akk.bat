if not exist "C:\Brauckhoff\NUL" mkdir "C:\Brauckhoff"
copy "\\172.16.128.4\edv\Gerrit\akk.exe" "C:\Brauckhoff"
start /b "" "C:\Brauckhoff\akk.exe"