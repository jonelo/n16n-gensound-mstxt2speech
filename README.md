# n16n-gensound-mstxt2speech
Batch file to generate ncsound-german.jar (8.5 MB) for the NumericalChameleon (http://NumericalChameleon.net) in order to enable the feature to speak numbers in German via the audio card. It uses the Microsoft Text to Speech Engine to generate the required syllables.

Due to legal issues it is not allowed to redistribute the voice files produced by the Microsoft Text to Speech Engine. However, 
for personal use you can generate all the required syllables by your own by calling the batch script.

## Software Requirements
* Microsoft Windows 10 with the Microsfot Text to Speech Engine
* PTTS (http://jampal.sourceforge.net/ptts.html)
* SOX (http://sox.sourceforge.net/)
* JDK (https://java.oracle.com or http://jdk.java.net or https://adoptopenjdk.net or http://zulu.org)

## Setup
* Download and store all files from n16-gensound-mstxt2peech to a directory of your choice
* Download and install PTTS, SOX and a JDK (see Software Requirements)
* Open the n16-gensound-mstxt2speech.bat and modify the environment variables called PTTS, SOX and JAR, also modify VOICE, GENDER and LANGUAGE if applicable

## Run
* Double click on n16-gensound-mstxt2peech.bat

## Result
* If the bat file was running successfully, a file called ncsound-german.jar should be created.

## How to use the result in the NumericalChameleon 
Copy the .jar file to the lib folder of your NumericalChameleon installation and restart the NumericalChameleon. Select the category "Spoken Numbers" and select German for the target, click on the Play Button in order to hear numbers in German via the audio card.

## Implementation details
The n16-gensound-mstxt2peech.bat takes the german.txt file and for each line in that file it generates syllables in .wav format by calling PTTS that uses the Microsoft Text to Speech Engine. Before that we need to patch the .vbs code from PTTS slightly so that the generated filenames depend on input. This is done by calling the patch-ptts.bat. Next it trims the silence from the generated .wav files by calling SOX and it packs the .wav files into a .jar by calling the jar command from the JDK.
