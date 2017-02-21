#!/bin/bash

set -xeu

echo '__________      .__  .__ __________     __________       '
echo '\______   \__ __|  | |  |\______   \__ _\______   \__ __ '
echo ' |     ___/  |  \  | |  | |    |  _/  |  \       _/  |  \'
echo ' |    |   |  |  /  |_|  |_|    |   \  |  /    |   \  |  /'
echo ' |____|   |____/|____/____/______  /____/|____|_  /____/ '
echo '                                 \/             \/       '

SVN_USERNAME=$1
SVN_PASSWORD=$2
SVN_PROJECT_ID=$3
SVN_BRANCH=$4

TARGET_IMAGE=mydocker/myimage
TEAMSERVER_URL=https://teamserver.sprintr.com/$SVN_PROJECT_ID

# PULL
git clone git@github.com:mendix/docker-mendix-buildpack.git
cd docker-mendix-buildpack
svn checkout --username=$SVN_USERNAME --password=$SVN_PASSWORD $TEAMSERVER_URL/branches/$SVN_BRANCH  temp_dir
SOURCE_DIR=temp_dir

# BUILD
docker build \
	--build-arg BUILD_PATH=$SOURCE_DIR \
	-t $TARGET_IMAGE .

# RUN
docker-compose up
