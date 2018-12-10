#!/bin/sh
git clone -b llvm-4.0 https://github.com/obfuscator-llvm/obfuscator
mkdir build 
cd build
cmake -DCMAKE_BUILD_TYPE=Release ../obfuscator/
make -j8

NDK=$ANDROID_NDK
if [ ! -n "$NDK" ];then
	echo 'ndk is not set'
	exit -1
fi
toolcharin=$NDK/toolchains/ollvm-4.0/prebuilt/darwin-x86_64
mkdir -p $toolcharin
mv bin $toolcharin
mv lib $toolcharin

sed -i "" 's/\$(call __ndk_error,Expected two items in TARGET_TOOLCHAIN_LIST/#&/' $NDK/build/core/setup-toolchain.mk
sed -i "" 's/\found "\$(TARGET_TOOLCHAIN_LIST/#&/' $NDK/build/core/setup-toolchain.mk

mkdir -p $NDK/build/core/toolchains/arm-linux-androideabi-clang_ollvm4.0
cp $NDK/build/core/toolchains/arm-linux-androideabi-clang/* $NDK/build/core/toolchains/arm-linux-androideabi-clang_ollvm4.0
mkdir -p $NDK/build/core/toolchains/aarch64-linux-android-clang_ollvm4.0
cp $NDK/build/core/toolchains/aarch64-linux-android-clang/* $NDK/build/core/toolchains/aarch64-linux-android-clang_ollvm4.0
mkdir -p $NDK/build/core/toolchains/x86-clang_ollvm4.0
cp $NDK/build/core/toolchains/x86-clang/* $NDK/build/core/toolchains/x86-clang_ollvm4.0
mkdir -p $NDK/build/core/toolchains/x86_64-clang_ollvm4.0
cp $NDK/build/core/toolchains/x86_64-clang/* $NDK/build/core/toolchains/x86_64-clang_ollvm4.0


function addContent(){
	sed -i "" "/^TOOLCHAIN_PREFIX/a\\
	TARGET_CXX := \$(LLVM_TOOLCHAIN_PREFIX)clang++\\
	" $1

	sed -i "" "/^TOOLCHAIN_PREFIX/a\\
	TARGET_CC := \$(LLVM_TOOLCHAIN_PREFIX)clang\\
	" $1

	sed -i "" "/^TOOLCHAIN_PREFIX/a\\
	LLVM_TOOLCHAIN_PREFIX := \$(LLVM_TOOLCHAIN_PREBUILT_ROOT)/bin/\\
	" $1

	sed -i "" "/^TOOLCHAIN_PREFIX/a\\
	LLVM_TOOLCHAIN_PREBUILT_ROOT := \$(call get-toolchain-root,\$(LLVM_TOOLCHAIN_ROOT))\\
	" $1

	sed -i "" "/^TOOLCHAIN_PREFIX/a\\
	LLVM_TOOLCHAIN_ROOT := \$(LLVM_NAME)\\
	" $1

	sed -i "" "/^TOOLCHAIN_PREFIX/a\\
	LLVM_NAME := ollvm-\$(LLVM_VERSION)\\
	" $1

	sed -i "" "/^TOOLCHAIN_PREFIX/a\\
	LLVM_VERSION := 4.0\\
	" $1
}

addContent $NDK/build/core/toolchains/arm-linux-androideabi-clang_ollvm4.0/setup.mk
addContent $NDK/build/core/toolchains/aarch64-linux-android-clang_ollvm4.0/setup.mk
addContent $NDK/build/core/toolchains/x86-clang_ollvm4.0/setup.mk
addContent $NDK/build/core/toolchains/x86_64-clang_ollvm4.0/setup.mk
