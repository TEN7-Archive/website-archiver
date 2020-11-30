# Website Archiver
An easy way to archive any publicly accessible website locally.

## How to use this archiver

1. Make sure you have [Docker Desktop](https://www.docker.com/get-started) installed on your computer. This has been tested on macOS and Linux, but it should work on Windows too.
2. Clone the website-archiver repo from [https://github.com/ivanstegic/website-archiver.git](https://github.com/ivanstegic/website-archiver.git)
3. Edit the `httrack.env` file and replace any instance of the text `example.com` with the domain name of the website you are crawling. This is where you configure the site you're crawling. It's ok to include subfolders here.
4. Get into a terminal on your computer, and run the file `archive.sh`
5. All files that are downloaded will be in the `public/` folder of this repo, browse the `index.html` file in there with your browser to see what you crawled.

## Tools
This archiver uses [Docker](https://www.docker.com/) and [HTTrack](http://www.httrack.com) to make a mirror of the site you are trying to archive.
