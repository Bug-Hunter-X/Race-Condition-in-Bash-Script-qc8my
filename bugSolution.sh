#!/bin/bash

# This script demonstrates a solution to the race condition bug.

# Create two files
touch file1.txt
touch file2.txt

# Use a lock file to synchronize access to the files
lockfile="lock.txt"

# Process 1
(flock "$lockfile" ; echo "Process 1 writing to file1" > file1.txt) &

# Process 2
(flock "$lockfile" ; echo "Process 2 writing to file2" > file2.txt) &

# Wait for both processes to finish
wait

# Print the contents of the files
cat file1.txt
cat file2.txt

# Remove lock file
rm "$lockfile"