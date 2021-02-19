# Single scan from an imaging sonar
#
# The X-axis is centered in the plane of the fan ("forward"), with Z down,
# in order to be consistent with the NED convention.
#
# For sonars with a 1D array, the beams lie on the X-Y plane, and
# and each beam has an azimuth (rotation about Z) value.  Zero azimuth
# is in the direction of the X-axis, typically "straight out" from the sonar.
# Elevation is the orthogonal direction (rotation about Y),
# often termed the "vertical aperture"

# The meaning of the header timestamp relative to the sonar's data
# acquisition cycle is defined by the sonar driver. It is taken to be
# a best estimate of the time when the sonar data is valid, which will
# the timing information available from the sonar hardware.
Header header

# Center frequency of sonar in Hz
# Set to 0 if unavailable
float32 frequency

# Speed of sound (m/s) used to calculate ranges;
# Set to 0 if unavailable
float32 sound_speed


# Beam width (as defined by the vendor) of a single sonar beam in the
# azimuth direction, in radians
float32 azimuth_beamwidth

# Beam width (as defined by the vendor) of a single sonar beam in the
# elevation direction, in radians
float32 elevation_beamwidth

# Azimuth for center of each beam in radians. Zero bearing is straight
# ahead with positive to starboard or up, depending on the orientation
# of the sensor
float32[] azimuth_angles

# Elevation for each "row" of beams in radians. If left empty, the
# source is assumed to be a 1D sonar with an elevation of { 0.0 }.
float32[] elevation_angles

# Center of each range bin in meters. Note this these may not be equally
# spaced, and do not necessarily start at zero range.
float32[] ranges

# True if data is big endian.
bool      is_bigendian

# Size of each datum (in bytes)
uint8     data_size

# intensity data [device-specific units].
#
# len(intensities) =
#           len(ranges)
#         * len(azimuth_angles)
#         * data_size
#
# Intensities are stored azimuth-major order.
# In analogy to an image array, bearing is "x", range is "y".
uint8[]   intensities
