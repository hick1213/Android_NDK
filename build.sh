source config.sh
rm -rf outputlibs
if [ -z "$ABIS" ];then
	echo 'please set ABIS in PATH in config.sh'
	exit;
fi
if [ -z "$BUILD_TYPE" ];then
	echo 'please set BUILD_TYPE in PATH in config.sh'
	exit;
fi
for abi in ${ABIS[@]}
do
	for type in ${BUILD_TYPE[@]}
	do
		echo $type
		rm -rf CMakeCache.txt CMakeFiles/ Makefile cmake_install.cmake
		dst=outputlibs/$type/$abi
		mkdir -p $dst
		platform=android-21
		if [ $PLATFORM ];then
			platform=$PLATFORM
		fi
		
		NDK_PATH=$ANDROID_NDK
		if [ $LOCAL_ANDROID_NDK ];then
			NDK_PATH=$LOCAL_ANDROID_NDK
		fi
		if [ -z "$NDK_PATH" ];then
		    echo 'please set ANDROID_NDK in PATH or LOCAL_ANDROID_NDK in config.sh'
            exit;
        fi
		cmake \
		-DANDROID_ABI="$abi" \
		-DANDROID_PLATFORM=$platform \
		-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=$dst \
		-DCMAKE_BUILD_TYPE=$type \
		-DCMAKE_CXX_FLAGS="-frtti -fexceptions -fvisibility=hidden" \
		-DCMAKE_SHARED_LINKER_FLAGS="-s" \
		-DANDROID_NDK=$NDK_PATH \
		-DANDROID_TOOLCHAIN=clang \
		-DCMAKE_TOOLCHAIN_FILE=$NDK_PATH/build/cmake/android.toolchain.cmake \
		-DANDROID_STL=c++_shared >>/dev/null
		make -j8
		cp $NDK_PATH/sources/cxx-stl/llvm-libc++/libs/$abi/libc++_shared.so $dst
	done
done
rm -rf CMakeCache.txt CMakeFiles/ Makefile cmake_install.cmake