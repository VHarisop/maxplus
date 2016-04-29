#!/usr/bin/env sh
create_maxplus() {
	# Creates the maxplus package
	echo 'Creating maxplus.tgz package...'
	tar -cvzf maxplus.tgz maxplus/ --exclude='.git'
	[ $? -ne 0 ] && echo "Unknown error occured!" \
		&& exit 1
	echo 'Completed!'
}

create_maxpoly() {
	# Creates the maxpoly package
	echo 'Creating maxpoly.tgz package...'
	tar -cvzf maxpoly.tgz maxpoly/ --exclude='.git'
	[ $? -ne 0 ] && echo "Unknown error occured!" \
		&& exit 1
	echo 'Completed!'
}

# Place calls to create other packages here
create_maxplus
create_maxpoly
