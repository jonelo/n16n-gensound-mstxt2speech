@echo off
:: author Johann Loefflmann (htts://johann.loefflmann.net)
::
:: patches the original ptts.vbs from 
:: http://jampal.sourceforge.net/ptts.html in order to get
:: the .wav filename dependent on the text input when using
:: ptts with option -m (poor man's sed on Windows ;-)
setlocal enableDelayedExpansion
set "FIND=                fileName = pFileName & fnNumber & ".wav""
set "REPL=                fileName = textLine ^& ".wav""
for /f "tokens=* delims=" %%L in (ptts.vbs) do (
    if "%FIND%"=="%%L" (echo %REPL%) else (echo %%L)	
)
