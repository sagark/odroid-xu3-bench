#!/bin/sh

sudo mv /usr/lib/arm-linux-gnueabihf/mali-egl/libOpenCL.so /usr/lib/arm-linux-gnueabihf/mali-egl/libOpenCL.soBAK2
sudo ln -s /usr/lib/arm-linux-gnueabihf/mali-egl/libmali.so /usr/lib/arm-linux-gnueabihf/mali-egl/libOpenCL.so
sudo ln -s /usr/lib/arm-linux-gnueabihf/mali-egl/libOpenCL.so /usr/lib/libOpenCL.so
sudo ldconfig
