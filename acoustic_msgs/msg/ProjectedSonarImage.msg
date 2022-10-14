# Single scan from an imaging sonar
#
# The Z-axis is centered in the plane of the fan ("forward"), with X up,
# in order to be consistent with the NED for traditional multibeam profilers.
#
# For sonars with a 1D array, the beams lie on the Y-Z plane, and
# and each beam has an azimuth (rotation about X) value.  Zero azimuth
# is in the direction of the Z-axis, typically "straight out" from the sonar.
# Elevation is the orthogonal direction (rotation about Y),
# often termed the "vertical aperture"

# The meaning of the header timestamp relative to the sonar's data
# acquisition cycle is defined by the sonar driver. It is taken to be
# a best estimate of the time when the sonar data is valid, which will
# the timing information available from the sonar hardware.
std_msgs/Header header

PingInfo ping_info

geometry_msgs/Vector3[] beam_directions

# Center of each range bin in meters. Note this these may not be equally
# spaced, and do not necessarily start at zero range.
float32[] ranges

SonarImageData image
