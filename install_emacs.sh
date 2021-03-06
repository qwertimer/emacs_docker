#!/bin/bash


#Check if docker is installed
if ! type docker >/dev/null 2>&1; then
  echo "Install requires Docker to build"
  exit 1
fi
#Run docker build of doom-emacs
docker build -t doom-emacs -t qwertimer/doom-emacs emacs-docker/.


#docker push qwertimer/doom-emacs

## Check if alias exists in bashrc-personal


if [ -f ~/.bashrc-personal ]; then 
    if grep "demacs()" ~/.bashrc-personal
    then
       echo "function already exists" 
    else 
        
        echo -e 'demacs() { \n
        docker run -it --rm -v "$PWD:/tmp" doom-emacs:latest $1 
        \n } && export -f demacs' >> ~/.bashrc-personal
    fi
else
    echo "bashrc-personal doesn't exist adding it now"
    echo "Adding bashrc-personal as an extension to current bashrc"

    echo -n > ~/.bashrc-personal

    echo -e 'demacs() { \n
    docker run -it --rm -v "$PWD:/tmp" doom-emacs:latest $1 
    \n } && export -f demacs' >> ~/.bashrc-personal
fi

## re-source bashrc
source ~/.bashrc
