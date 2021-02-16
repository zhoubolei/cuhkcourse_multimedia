# Breif Introduction to ffmpeg

### What is ffmpeg
(from wiki) FFmpeg is a free and open-source software project consisting of a large suite of libraries and programs for handling video, audio, and other multimedia files and streams. At its core is the FFmpeg program itself, designed for command-line-based processing of video and audio files. It is widely used for format transcoding, basic editing (trimming and concatenation), video scaling, video post-production effects and standards compliance (SMPTE, ITU). FFmpeg includes libavcodec, an audio/video codec library used by many commercial and free software products, libavformat (Lavf), an audio/video container mux and demux library, and the core ffmpeg command-line program for transcoding multimedia files.

### Command lines
It is super easy to use ffmpeg through the idiot-proof command lines (just copy and paste the line template). Please refer to [20+ FFmpeg Commands For Beginners](https://ostechnix.com/20-ffmpeg-commands-beginners/) and [Useful FFmpeg Commands for Working with Audio and Video Files](https://www.labnol.org/internet/useful-ffmpeg-commands/28490/). You will see how versatile and easy it is! 

Please follow [download instruction](https://ffmpeg.org/download.html) to install ffmpeg. Then download [demo video](http://bzhou.ie.cuhk.edu.hk/demo_ffmpeg.mp4) or save your own video to local path.
Then you can try the following examples:
* get multimedia file information
```
    ffmpeg -i demo_ffmpeg.mp4
```
* convert video files to different formats
```
    ffmpeg -i demo_ffmpeg.mp4 demo_ffmpeg.avi
```
* check list of supported formats by ffmpeg
```
    ffmpeg -formats
```
* change resolution of video files
```
    ffmpeg -i demo_ffmpeg.mp4 -filter:v scale=1280:720 -c:a copy output.mp4
```
* extract images from the video
```
    ffmpeg -i demo_ffmpeg.mp4 -r 1 frames/image-%4d.jpg
```
* crop videos
```
    ffmpeg -i demo_ffmpeg.mp4 -filter:v "crop=w:h:x:y" output.mp4
```
