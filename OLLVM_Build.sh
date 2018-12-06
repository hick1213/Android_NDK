#!/bin/sh
NDK=$ANDROID_NDK
if [ ! -n "$NDK" ];then
	echo 'ndk is not set'
	exit -1
fi
toolcharin=$NDK/toolchains/ollvm-4.0/prebuilt/drawin-x86_64
mkdir -p $toolcharin
mv * $toolcharin

mkdir -p $NDK/build/core/toolchains/arm-linux-androideabi-clang-ollvm4.0
cp $NDK/build/core/toolchains/arm-linux-androideabi-clang/* $NDK/build/core/toolchains/arm-linux-androideabi-clang-ollvm4.0
mkdir -p $NDK/build/core/toolchains/aarch64-linux-android-clang-ollvm4.0
cp $NDK/build/core/toolchains/aarch64-linux-android-clang/* $NDK/build/core/toolchains/aarch64-linux-android-clang-ollvm4.0
mkdir -p $NDK/build/core/toolchains/x86-clang-ollvm4.0
cp $NDK/build/core/toolchains/x86-clang/* $NDK/build/core/toolchains/x86-clang-ollvm4.0
mkdir -p $NDK/build/core/toolchains/x86_64-clang-ollvm4.0
cp $NDK/build/core/toolchains/x86_64-clang/* $NDK/build/core/toolchains/x86_64-clang-ollvm4.0


sed -i "" 's/^TOOLCHAIN_NAME.*/TOOLCHAIN_NAME := ollvm-4.0/' $NDK/build/core/toolchains/arm-linux-androideabi-clang-ollvm4.0/setup.mk
sed -i "" 's/^TOOLCHAIN_ROOT.*/TOOLCHAIN_ROOT := $(call get-toolchain-root,$(OLLVM_NAME))/' $NDK/build/core/toolchains/arm-linux-androideabi-clang-ollvm4.0/setup.mk
sed -i "" 's/^TOOLCHAIN_PREFIX.*/TOOLCHAIN_PREFIX := $(TOOLCHAIN_ROOT)\/bin/' $NDK/build/core/toolchains/arm-linux-androideabi-clang-ollvm4.0/setup.mk

sed -i "" 's/^TOOLCHAIN_NAME.*/TOOLCHAIN_NAME := ollvm-4.0/' $NDK/build/core/toolchains/aarch64-linux-android-clang-ollvm4.0/setup.mk
sed -i "" 's/^TOOLCHAIN_ROOT.*/TOOLCHAIN_ROOT := $(call get-toolchain-root,$(OLLVM_NAME))/' $NDK/build/core/toolchains/aarch64-linux-android-clang-ollvm4.0/setup.mk
sed -i "" 's/^TOOLCHAIN_PREFIX.*/TOOLCHAIN_PREFIX := $(TOOLCHAIN_ROOT)\/bin/' $NDK/build/core/toolchains/aarch64-linux-android-clang-ollvm4.0/setup.mk

sed -i "" 's/^TOOLCHAIN_NAME.*/TOOLCHAIN_NAME := ollvm-4.0/' $NDK/build/core/toolchains/x86-clang-ollvm4.0/setup.mk
sed -i "" 's/^TOOLCHAIN_ROOT.*/TOOLCHAIN_ROOT := $(call get-toolchain-root,$(OLLVM_NAME))/' $NDK/build/core/toolchains/x86-clang-ollvm4.0/setup.mk
sed -i "" 's/^TOOLCHAIN_PREFIX.*/TOOLCHAIN_PREFIX := $(TOOLCHAIN_ROOT)\/bin/' $NDK/build/core/toolchains/x86-clang-ollvm4.0/setup.mk

sed -i "" 's/^TOOLCHAIN_NAME.*/TOOLCHAIN_NAME := ollvm-4.0/' $NDK/build/core/toolchains/x86_64-clang-ollvm4.0/setup.mk
sed -i "" 's/^TOOLCHAIN_ROOT.*/TOOLCHAIN_ROOT := $(call get-toolchain-root,$(OLLVM_NAME))/' $NDK/build/core/toolchains/x86_64-clang-ollvm4.0/setup.mk
sed -i "" 's/^TOOLCHAIN_PREFIX.*/TOOLCHAIN_PREFIX := $(TOOLCHAIN_ROOT)\/bin/' $NDK/build/core/toolchains/x86_64-clang-ollvm4.0/setup.mk
