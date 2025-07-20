# GoogleStreetViewScripts
 Scripts for converting videos before uploading to Google Street View

2025-07-19 - I recently begain experimenting with uploading 360 video recordings taken with my Insta360 X5 camera to Google Street View. At 30 fps, these 8K video files can be HUGE, taking a long time to upload and process. Google does not ask for 30 fps, and instead recommends:

* Under 5 mph or 8 km/h for 1 FPS.
* Under 30 mph or 45 km/h for 5 FPS.
* Under 45 mph or 70 km/h for 7 FPS.

See: https://support.google.com/maps/answer/7662671?hl=en&ref_topic=6275604

I began using **ffmpeg** to convert my videos down to 1fps (for the walking videos) or 5fps (for ones recorded while riding a bike or scooter). To automate this process a bit, I had this simple shell script created. Now I can type:

./make1fps *.mp4

...and have the script run ffmpeg on each mp4 video file in that directory.

More to come...
