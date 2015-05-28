#!/bin/bash

# enable the sensors
echo 1 > /sys/bus/i2c/drivers/INA231/3-0045/enable
echo 1 > /sys/bus/i2c/drivers/INA231/3-0040/enable
echo 1 > /sys/bus/i2c/drivers/INA231/3-0041/enable
echo 1 > /sys/bus/i2c/drivers/INA231/3-0044/enable

# settle two seconds to the sensors get fully enabled and have the first reading
sleep 2

# print this stuff once
echo "Freq: MHz, Temp: C, Volt: V, Current: Amp, Power: W"
echo "A7 CPU0 Freq, A7 CPU1 Freq, A7 CPU2 Freq, A7 CPU3 Freq, A15 CPU0 Freq, A15 CPU1 Freq, A15 CPU2 Freq, A15 CPU3 Freq, A15 CPU0 Temp, A15 CPU1 Temp, A15 CPU2 Temp, A15 CPU3 Temp, A15 Volt, A15 Current, A15 Power, A7 Volt, A7 Current, A7 Power, Mem Volt, Mem Current, Mem Power, GPU Volt, GPU Curr, GPU Power, GPU Freq, GPU Temp"


# Main infinite loop
while true; do

# ----------- CPU DATA ----------- #

# Node Configuration for CPU Frequency
CPU0_FREQ=$((`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq`/1000))
CPU1_FREQ=$((`cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq`/1000))
CPU2_FREQ=$((`cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq`/1000))
CPU3_FREQ=$((`cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq`/1000))
CPU4_FREQ=$((`cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq`/1000))
CPU5_FREQ=$((`cat /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq`/1000))
CPU6_FREQ=$((`cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq`/1000))
CPU7_FREQ=$((`cat /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq`/1000))

# CPU Governor
CPU_GOVERNOR=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`

# Note Configuration for CPU Core Temperature
# This file is written on the following format:
# CPU0 CPU1 CPU2 CPU3
TMU_FILE=`cat /sys/devices/10060000.tmu/temp`

# We need to slip those in nice variables...
CPU0_TEMP=$((`echo $TMU_FILE | awk '{printf $3}'`/1000))
CPU1_TEMP=$((`echo $TMU_FILE | awk '{printf $6}'`/1000))
CPU2_TEMP=$((`echo $TMU_FILE | awk '{printf $9}'`/1000))
CPU3_TEMP=$((`echo $TMU_FILE | awk '{printf $12}'`/1000))
GPU_TEMP=$((`echo $TMU_FILE | awk '{printf $15}'`/1000))

# Now lets get CPU Power Comsumption
# Letter Values are:
# V = Volts
# A = Amps
# W = Watts

# A7 Nodes
A7_V=`cat /sys/bus/i2c/drivers/INA231/3-0045/sensor_V`
A7_A=`cat /sys/bus/i2c/drivers/INA231/3-0045/sensor_A`
A7_W=`cat /sys/bus/i2c/drivers/INA231/3-0045/sensor_W`

# A15 Nodes
A15_V=`cat /sys/bus/i2c/drivers/INA231/3-0040/sensor_V`
A15_A=`cat /sys/bus/i2c/drivers/INA231/3-0040/sensor_A`
A15_W=`cat /sys/bus/i2c/drivers/INA231/3-0040/sensor_W`


# --------- MEMORY DATA ----------- # 
MEM_V=`cat /sys/bus/i2c/drivers/INA231/3-0041/sensor_V`
MEM_A=`cat /sys/bus/i2c/drivers/INA231/3-0041/sensor_A`
MEM_W=`cat /sys/bus/i2c/drivers/INA231/3-0041/sensor_W`

# ---------- GPU DATA ------------- # 
GPU_V=`cat /sys/bus/i2c/drivers/INA231/3-0044/sensor_V`
GPU_A=`cat /sys/bus/i2c/drivers/INA231/3-0044/sensor_A`
GPU_W=`cat /sys/bus/i2c/drivers/INA231/3-0044/sensor_W`
GPU_FREQ=`cat /sys/devices/11800000.mali/clock`

# ---------- FAN Speed ------------- # 
FAN_SPEED=$((`cat /sys/bus/platform/devices/odroid_fan.15/pwm_duty` * 100 / 255))"%"

# ---------- DRAW Screen ----------- #

echo -n "$CPU0_FREQ, "
echo -n "$CPU1_FREQ, "
echo -n "$CPU2_FREQ, "
echo -n "$CPU3_FREQ, "
echo -n "$CPU4_FREQ, "
echo -n "$CPU5_FREQ, "
echo -n "$CPU6_FREQ, "
echo -n "$CPU7_FREQ, "
echo -n "$CPU0_TEMP, "
echo -n "$CPU1_TEMP, "
echo -n "$CPU2_TEMP, "
echo -n "$CPU3_TEMP, "

#echo "Governor: $CPU_GOVERNOR"
#echo "Fan Speed: $FAN_SPEED"
echo -n "$A15_V, "
echo -n "$A15_A, "
echo -n "$A15_W, "
echo -n "$A7_V, "
echo -n "$A7_A, "
echo -n "$A7_W, "
echo -n "$MEM_V, "
echo -n "$MEM_A, "
echo -n "$MEM_W, "
echo -n "$GPU_V, "
echo -n "$GPU_A, "
echo -n "$GPU_W, "
echo -n "$GPU_FREQ, "
echo "$GPU_TEMP"

sleep 0.3
clear
done
