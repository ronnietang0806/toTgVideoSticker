# toTgVideoSticker
Windows Batch Script for user to convert video or gif to webm (Telegram Video Sticker format)

path/location setup
1. open the toTgVideoSticker.bat in text editor
2. edit mylocation which contain your gif/video (recommend putting all your gif/video in one folder)
3. webm would be outputed in your preset location

run step
1. run toTgVideoSticker.bat
2. enter your file name (e.g. 123456.gif/123456.mp4)
3. enter your output file name (e.g. 123456)
4. enter start time and end time for trim if over 3 seconds
5. wait until convert end

config
1.mylocation:
- default in C:\Users\user\Downloads
2.myOutputLocation
- default same as your mylocation
- ***this batch script file create folder for you, please modify it carefully
3.fps: affect fps of the webm file
- default 30
- fps better around 20 ~ 30
4.quality: affect file size of the webm file
- file size should below 256KB
- default 800K
- can set it low if over size, 500K ~ 800K recommended
x.width, height
- default 512x512, fit and crop center if not square