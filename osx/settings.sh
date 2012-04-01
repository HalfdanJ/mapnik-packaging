#!/usr/bin/env bash

export ROOTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

XCODE_PREFIX=$( xcode-select -print-path )
if [[ $XCODE_PREFIX == "/Developer" ]]; then
    export SDK_PATH="${XCODE_PREFIX}/SDKs/MacOSX10.6.sdk" ## Xcode 4.2
    export PATH=/Developer/usr/bin:$PATH
    export CORE_CXX="/Developer/usr/bin/clang++"
    export CORE_CC="/Developer/usr/bin/clang"
else
    export CORE_CXX="/usr/bin/clang++"
    export CORE_CC="/usr/bin/clang"
    # /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer
    export SDK_PATH="${XCODE_PREFIX}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.6.sdk" ## >= 4.3.1 from MAC
fi

#declare -A PY_VERSIONS
#PY_VERSIONS["2.7"]="2.7"

# needed for Coda.app terminal to act sanely
# otherwise various tests fail oddly
#export LANG=en_US.UTF-8

# settings
#export MAPNIK_INSTALL=/opt/mapnik
export MAPNIK_INSTALL=/Library/Frameworks/Mapnik.framework/unix
export MAPNIK_SOURCE=${ROOTDIR}/mapnik
export MAPNIK_DIST=${ROOTDIR}/dist
export PACKAGES=${ROOTDIR}/packages
export BUILD=${ROOTDIR}/build
export MAPNIK_TAR_DIR="mapnik"
export OPTIMIZATION="-O3"
export JOBS=`sysctl -n hw.ncpu`
if [ $JOBS > 4 ]; then
    export JOBS=$(expr $JOBS - 2)
fi
# -arch i386 breaks icu Collator::createInstance
export ARCH_FLAGS="-arch x86_64"
#export ARCH_FLAGS="-arch x86_64 -arch i386"
export ARCHFLAGS=${ARCH_FLAGS}
export CXX=${CORE_CXX}
export CC=${CORE_CC}
export CPPFLAGS="-DU_CHARSET_IS_UTF8=1" # to reduce icu library size (18.3)
export CORE_CFLAGS="${OPTIMIZATION} ${ARCH_FLAGS} -D_FILE_OFFSET_BITS=64"
export CORE_CXXFLAGS=${CORE_CFLAGS}
export CORE_LDFLAGS="${OPTIMIZATION} ${ARCH_FLAGS} -Wl,-search_paths_first -headerpad_max_install_names"

# breaks distutils
#export MACOSX_DEPLOYMENT_TARGET=10.6
export OSX_SDK_CFLAGS="-mmacosx-version-min=10.6 -isysroot ${SDK_PATH}"
export OSX_SDK_LDFLAGS="-mmacosx-version-min=10.6 -isysroot ${SDK_PATH}"
#export OSX_SDK_LDFLAGS="-mmacosx-version-min=10.6 -Wl,-syslibroot,${SDK_PATH}"
export LDFLAGS="-L${BUILD}/lib $CORE_LDFLAGS $OSX_SDK_LDFLAGS"
export CFLAGS="-I${BUILD}/include $CORE_CFLAGS $OSX_SDK_CFLAGS"
export CXXFLAGS="-I${BUILD}/include $CORE_CXXFLAGS $OSX_SDK_CFLAGS"

export DYLD_LIBRARY_PATH="${BUILD}/lib"
export PKG_CONFIG_PATH="${BUILD}/lib/pkgconfig"
export PATH="${BUILD}/bin:$PATH"

# versions
export ICU_VERSION="49.1"
export ICU_VERSION2="49_1"
export ICU_MAJOR_VER="48"
export BOOST_VERSION="1.49.0"
export BOOST_VERSION2="1_49_0"
export SQLITE_VERSION="3071100"
export FREETYPE_VERSION="2.4.9"
export PROJ_VERSION="4.8.0"
export PROJ_GRIDS_VERSION="1.5"
# 0.24.4 will not compile:
#"_lcg_seed", referenced from:
#      _main in region-test.o     
#export PIXMAN_VERSION="0.24.4"
export PIXMAN_VERSION="0.22.2"
export CAIRO_VERSION="1.10.2"
export CAIROMM_VERSION="1.10.0"
export SIGCPP_VERSION="2.2"
export SIGCPP_VERSION2="2.2.10"
export LIBPNG_VERSION="1.5.9"
export LIBTIFF_VERSION="4.0.1"
export JPEG_VERSION="8d"
export GDAL_VERSION="1.9.0"
export GETTEXT_VERSION="0.18.1.1"
export PKG_CONFIG_VERSION="0.25"
export FONTCONFIG_VERSION="2.8.0"
export POSTGRES_VERSION="9.1.3"

