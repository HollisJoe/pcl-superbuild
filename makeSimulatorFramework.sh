#!/bin/bash

#------------------------------------------------------------------------------
install=./CMakeExternals/Install
if [ ! -d $install ]; then
  echo "Install directory not found.  This script should be run from the top level build directory that contains CMakeExternals/Install."
  exit 1
fi

#------------------------------------------------------------------------------
make_pcl_framework ()
{
  pcl_sim_libs=`find $install/pcl-ios-simulator $install/flann-ios-simulator $install/boost-ios-simulator -name *.a`

  pcl_header_dir=$install/pcl-ios-device/include/pcl-1.8

  pcl_framework=$install/frameworks/pcl.framework
  mkdir -p $pcl_framework
  rm -rf $pcl_framework/*
  mkdir $pcl_framework/Headers
  cp -r $pcl_header_dir/* $pcl_framework/Headers/

  libtool -static -o $pcl_framework/pcl $pcl_sim_libs
}



#------------------------------------------------------------------------------
if [ "$1" == "pcl" ]; then
  make_pcl_framework
else
  echo "Usage: $0 pcl"
  exit 1
fi
