# Single ping from a multibeam sonar.
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

# Truly raw multibeam data uses travel times rather than ranges.
# reported in seconds
float32[] two_way_travel_times

# Multi-sector multibeams can transmit different sectors at different times
# The Reson doesn't but we include a TX delay for each beam anyway.
#
# Overall, therefore, our overall time is:
#
# header.stamp: TX cycle starts
# Each beam's TX time: header.stamp + txDelay[i]
# Each beam's RX time: header.stamp + txDelay[i] + twowayTravelTime[i]
# reported in seconds
float32[] tx_delays

# Sonar-reported intensity.  Usually uncalibrated and crude
float32[] intensities

# Sonar-reported along-track steering angle (applied to tx beam)
# + forward, - aft for a downlooking sonar
# reported in radians
float32[] tx_angles

# Sonar-reported across-track steering angle (applied to rx beam)
# + to starboard, - to port for a downlooking sonar
# reported in radians
float32[] rx_angles
