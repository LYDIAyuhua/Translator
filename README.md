# Translator
A translator application that utilizes voice recognition API and speech API for simultaneous translation where users speak and app displays the result of translation in text.

## 11/2/2017 (contributor: Yitong Wu)
- first commit translator project
- simple UI with single-page view 
- use Apple API *AVAudioRecorder* for recording
- detials about *AVAudioRecorder* can be found [here](https://developer.apple.com/reference/avfoundation/avaudiorecorder)
- for future expansion (of passing audio to other APIs), the actual audio file can be found using [audioRecorder.url](https://developer.apple.com/reference/avfoundation/avaudiorecorder/1389050-url), where 
audioRecorder is an instance of *AVAudioRecorder*
