@echo off
:: author Johann Loefflmann (https://johann.loefflmann.net)
::
:: This batch file generates a ncsound-german.jar (8.5 MB) for the 
:: NumericalChameleon (http://NumericalChameleon.net) in order to
:: enable the feature to speak numbers in German via the audio card.
::
::
:: n16n-gensound-mstxt2speech.bat is free software: you can redistribute it and/or modify
:: it under the terms of the GNU General Public License as published by
:: the Free Software Foundation, either version 3 of the License, or
:: (at your option) any later version.
::
:: n16-gensound-mstxt2speech.bat is distributed in the hope that it will be useful,
:: but WITHOUT ANY WARRANTY without even the implied warranty of
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
:: GNU General Public License for more details.
::
:: You should have received a copy of the GNU General Public License
:: along with nc16-gensound-mstxt2speech.bat.  If not, see <http://www.gnu.org/licenses/>.

:: config start
set PTTS=C:\Program Files\Jampal\ptts.vbs
set SOX=C:\Applications\sox-14.4.2\sox.exe
set JAR=C:\Program Files\Java\jdk8\bin\jar.exe
set VOICE=Microsoft Hedda Desktop
set GENDER=female
set LANGUAGE=german
:: config end

set FOLDER=data\sounds\%LANGUAGE%
copy "%PTTS%" ptts.vbs
call .\patch-ptts.bat > ptts-patched.vbs
del ptts.vbs
mkdir "%FOLDER%"
call cscript ptts-patched.vbs -voice "%VOICE%" -m mywavs < "%LANGUAGE%.txt"
echo format=.wav > "%FOLDER%\info"
echo voice=%GENDER% >>  "%FOLDER%\info"
::copy info "%FOLDER%"
for /f "delims=|" %%f in ('dir /b *.wav') do (

    :: trim silence at the beginning
    call "%SOX%" "%%f" temp.wav silence 1 0.01 0%
	
	:: trim silence at the end
    call "%SOX%" temp.wav "%%f" reverse
    call "%SOX%" "%%f" temp.wav silence 1 0.01 0%
    call "%SOX%" temp.wav "%%f" reverse
	
    del temp.wav
	move "%%f" "%FOLDER%"
)
call "%JAR%" cfvM ncsound-%LANGUAGE%.jar "%FOLDER%"
