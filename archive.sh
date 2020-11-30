# prune previous images	
echo "Starting archiver, first pruning previous docker images..."
docker system prune --filter "label=htarchive" --force

# build the image
echo "Now building docker images from scratch..."
docker build --tag htarchive:1.0 .

# run it
echo "Firing up the docker image, let's crawl it..."
docker run -it --volume $(pwd):/app --env-file httrack.env htarchive:1.0
