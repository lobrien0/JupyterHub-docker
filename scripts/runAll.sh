#!/bin/bash

#Runs all .sh files
for dir in $(pwd)/*.sh; do
	if [ "${dir}" != "$(pwd)/runAll.sh" ]; then
		bash "${dir}"
	fi
done
