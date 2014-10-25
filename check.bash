#!/bin/bash

# Build the program
xcodebuild -project Paranormal/Paranormal.xcodeproj/ -scheme Paranormal
BUILD=$?

# Run the tests
xcodebuild -project Paranormal/Paranormal.xcodeproj/ -scheme Paranormal test
TEST=$?

echo "==== Running Tidy ===="
# Ensure things have no whitespace
python tools/tidy.py `find . -name *.swift`
TIDY=$?

echo -e "\n======================\n"

if [ $TIDY != 0 ]
then
  echo -e "Tidy: \x1B[0;31mFail\x1B[0m"
else
  echo -e "Tidy: \x1B[0;32mPass\x1B[0m"
fi

if [ $BUILD != 0 ]
then
  echo -e "Build: \x1B[0;31mFail\x1B[0m"
else
  echo -e "Build: \x1B[0;32mPass\x1B[0m"
fi

if [ $TEST != 0 ]
then
  echo -e "Test: \x1B[0;31mFail\x1B[0m"
else
  echo -e "Test: \x1B[0;32mPass\x1B[0m"
fi