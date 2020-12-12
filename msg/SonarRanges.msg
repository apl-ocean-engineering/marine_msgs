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

# Constants declaring whether each beam is good or bad.
# This is implemented as an 8-bit masked value; it is possible for more
# than one thing to flag beams as bad. To check if a beam is good, simply
# check if it is zero.

# Beam is OK
uint8 BEAM_OK = 0
# Beam is flagged as bad by the sonar.  Think hard before second-guessing
uint8 BEAM_BAD_SONAR = 1
# Beam is flagged as bad by some automated filter applied during processing.
uint8 BEAM_BAD_FILTER = 2
# Beam is flagged as bad by the user. This is probably not happening in
# realtime, but is included here so the same message can be used throughout
# a post-processing pipeline.
uint8 BEAD_BAD_USER = 4

# Multibeams require a sound velocity to beamform properly.  This may
# be helpful for subsequent processing, so we include it here
float32 sound_speed

# These arrays should have the same dimensions, and should match
# the number of beams for this sonar.
#
# Some fields are optional.  Those should have 0 length.

# Flag values for every beam
uint8[] flag

# Truly raw multibeam data uses travel times rather than ranges.
float32[] two_way_travel_time

# Multi-sector multibeams can transmit different sectors at different times
# The Reson doesn't but we include a TX delay for each beam anyway.
#
# Overall, therefore, our overall time is:
#
# header.stamp: TX cycle starts
# Each beam's TX time: header.stamp + txDelay[i]
# Each beam's RX time: header.stamp + txDelay[i] + twowayTravelTime[i]
float32[] transmit_delay

# Sonar-reported intensity.  Usually uncalibrated and crude
float32[] intensity

# Sonar-reported along-track steering angle (applied to tx beam)
# + forward, - aft for a downlooking sonar
# Always in radians
float32[] elevation_angle

# Sonar-reported across-track steering angle (applied to rx beam)
# + to starboard, - to port for a downlooking sonar
# Always in radians
float32[] azimuth_angle

# Sonar reported -3db beamwidths
# May be empty if not reported
# Always in radians
float32[] azimuth_beamwidth
float32[] elevation_beamwidth
