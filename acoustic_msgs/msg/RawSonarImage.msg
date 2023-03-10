# All values in the header are associated the transmitter:
# 	- stamp references the transmit time or the start of the
#	  transmit cycle.
#	- frame_id references the transmitter's acoustic center
std_msgs/Header header

PingInfo ping_info

uint32  samples_per_beam  # the number of samples in each beam

# Many sonars have some kind of upper gate for water column data
# this represents the sample number of the first non empty sample
# for beam n
uint32 sample0

# if the image is not reported at the full resolution
# ping_info.sample_rate != image_sample_rate
# for a given sample:
#   2-way travel time = image_sample_rate*(sample_no+sample0)

float32 image_sample_rate

# Multi-sector multibeams can transmit different sectors at different times
#
# Overall, therefore, our overall time is:
#
# header.stamp: TX cycle starts
# Each beam's TX time: header.stamp + transmit_delay[i]
# Each beam's RX time: header.stamp + transmit_delay[i] + sample_rate*image_row
float32[] tx_delays

# The angle reported for the transmitted pulse
# reported in radians
float32[] tx_angles

# The angle reported for the received pulse
# reported in radians
float32[] rx_angles

SonarImageData image
