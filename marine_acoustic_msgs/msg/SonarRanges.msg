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

PingInfo ping_info

# Constants declaring whether each beam is good or bad.
# This is implemented as an 8-bit masked value; it is possible for more
# than one thing to flag beams as bad. To check if a beam is good, simply
# check if it is zero.

DetectionFlag[] flags

# Multi-sector multibeams can transmit different sectors at different times
# The Reson doesn't but we include a TX delay for each beam anyway.
#
# Overall, therefore, our overall time is:
#
# header.stamp: TX cycle starts
# Each beam's TX time: header.stamp + txDelay[i]
# Each beam's RX time: header.stamp + txDelay[i] + twowayTravelTime[i]
float32[] transmit_delays

# Sonar-reported intensity.  Usually uncalibrated and crude
float32[] intensities

geometry_msgs/Vector3[] beam_unit_vec

float32[] ranges
