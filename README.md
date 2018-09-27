BUILD SCRIPT FOR ANDROID NDK USING CMAKE
======

# how to use
+ copy files to the path where CMakesLists.txt located
+ sh build.sh

# issue
if you use diff NDK version to build.please set LOCAL_ANDROID_NDK in config.sh

# config_info
here is config info 

ABIS=(armeabi armeabi-v7a arm64-v8a x86 x86_64)

BUILD_TYPE=(Debug Release)

BUILD_TYPE=Release

PLATFORM=android-22

LOCAL_ANDROID_NDK=/Users/xxx/Downloads/android-ndk-r16b

