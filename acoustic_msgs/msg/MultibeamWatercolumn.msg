# Single ping from a profiling sonar.
#
# This message is modeled after WHOI's MultibeamRaw.msg, from the
# ds_multibeam_msgs package (released under a BSD license).
# Modifications were made by UW-APL.

# The header time should be the time the ping was transmitted, not
# the time the message was received.
# Note that these two could potentially be several seconds apart,
# especially in deep water.
std_msgs/Header header

float32 sound_speed   # m/s

float32 sample_rate   # hz

uint32  num_beams

uint32  samples_per_beam

# Multi-sector multibeams can transmit different sectors at different times
# The Reson doesn't but we include a TX delay for each beam anyway.
#
# Overall, therefore, our overall time is:
#
# header.stamp: TX cycle starts
# Each beam's TX time: header.stamp + txDelay[i]
# Each beam's RX time: header.stamp + txDelay[i] + twowayTravelTime[i]
float32[] transmit_delay

# Many sonars have some kind of upper gate for water column data
# this represeents the sample number of the first non empty sample
# for beam n
uint32[] sample0

# Steering angle applied to tx beam
# reported in radians
float32[] tx_angle

# Steering angle applied to rx beam
# reported in radians
float32[] rx_angle

# Sonar reported -3db beamwidths
# May be empty if not reported
# reported in radians
float32[] tx_beamwidth
float32[] rx_beamwidth

bool      is_bigendian

uint32  DTYPE_UINT8 = 0
uint32  DTYPE_INT8 = 1
uint32  DTYPE_INT16 = 2
uint32  DTYPE_UINT32 = 4
uint32  DTYPE_INT32 = 5
uint32  DTYPE_UINT64 = 6
uint32  DTYPE_INT64 = 7
uint32  DTYPE_FLOAT32 = 21
uint32  DTYPE_FLOAT64 = 23

uint32  dtype

uint8[] data
