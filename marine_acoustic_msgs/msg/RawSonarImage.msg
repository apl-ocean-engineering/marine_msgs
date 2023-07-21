
# The header time should be the time the ping was transmitted, not
# the time the message was received.
# Note that these two could potentially be several seconds apart,
# especially in deep water.
std_msgs/Header header

PingInfo ping_info

float32 sample_rate   # hz

uint32  samples_per_beam  # the number of samples in each beam

# Many sonars have some kind of upper gate for water column data
# this represents the sample number of the first non empty sample
# for beam n
uint32 sample0

# Multi-sector multibeams can transmit different sectors at different times
# The Reson doesn't but we include a TX delay for each beam anyway.
#
# Overall, therefore, our overall time is:
#
# header.stamp: TX cycle starts
# Each beam's TX time: header.stamp + transmit_delay[i]
# Each beam's RX time: header.stamp + transmit_delay[i] + sample_rate*image_row
float32[] tx_delays
# Steering angle applied to tx beam
# reported in radians
float32[] tx_angles

# Steering angle applied to rx beam
# reported in radians
float32[] rx_angles

SonarImageData image
