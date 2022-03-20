
# The header time should be the time the ping was transmitted, not
# the time the message was received.
# Note that these two could potentially be several seconds apart,
# especially in deep water.
std_msgs/Header header

# Center frequency of sonar in Hz
# Set to 0 if unavailable
float32 frequency

float32 sound_speed   # measured at the head in m/s

float32 sample_rate   # hz

uint32  num_beams  # number of beams in the return

uint32  samples_per_beam  # the number of samples in each beam

# Multi-sector multibeams can transmit different sectors at different times
# The Reson doesn't but we include a TX delay for each beam anyway.
#
# Overall, therefore, our overall time is:
#
# header.stamp: TX cycle starts
# Each beam's TX time: header.stamp + transmit_delay[i]
# Each beam's RX time: header.stamp + transmit_delay[i] + sample_rate*image_row
float32[] transmit_delay

# Many sonars have some kind of upper gate for water column data
# this represeents the sample number of the first non empty sample
# for beam n   TODO:  this could possibly be a single value  not sure if each beam needs one
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

SonarImageData image_data
