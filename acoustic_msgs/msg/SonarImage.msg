# A single scan from an imaging sonar
#
# Imaging sonars produce an array of sonar beams radiating from a 
# common center. 
# 
# Data in this message must be in a North-East-Down (NED) coordinate frame.
# In the most common configuration where the sonar produces a fan-shaped 
# array of beams, the central axis of each beam lies on the X-Y axis, with 
# each beam having an azimuth (rotation around the Z-axis) specified
# in the vector "azimuth_angles".  Zero azimuth is typically "straight 
# ahead" from the physical sensor, and azimuth angles follow the NED 
# convention, with angles increasing to starboard.   Azimuth angles do 
# not need to be evenly spaced.
#
# Elevation is defined as rotation around the +Y axis, with negative
# elevations "pitched down" and positive elevations "pitched up".  
# For the majority of sonars, all beams are centered in elevation on the 
# X-Y plane, such that all have an elevation of 0.  In this case
# "elevation_angles" can be left empty.  If the elevation
# differs on a beam-by-beam basis, values can be provided in the 
# "elevation_angles" field, however in that case "elevations_angles"
# must be the same length as "azimuth_angles" -- equal to the number of
# beams.
#
# For each beam, the sonar collects a sequence of acoustic returns
# which are quantized into a fixed number of range bins by the sensor.
# Radial distance from the sensor to the center of each range bin is reported 
# in the "ranges" vector.  Depending on the sensor's minimum range,
# the "ranges" vector may start at a non-zero distance, and range bins need not
# be equally spaced.   The speed of sound used by the sensor to calculate
# the ranges, if known, can be included in the field "sound_speed"
#
# The measured acoustic return is stored for each range bin, for each 
# azimuthal beam, in the "intensities[]" array, as an azimuth-major array.
# That is, the array contains returns for every range in sequence for the
# first azimuth value, then the returns for every range for the second azimuth
# value, and so on.   The interpretation or units for the intensities 
# will vary by sensor manufacturer.

# The header timestamp gives the best estimate of the time for which the data
# is valid. The exact relationship between timestamp and the sonar's data 
# acquisition cycle is determined by the sonar driver.
Header header

# Center frequency of sonar in Hz
# Set to 0 if unavailable/unknown
float32 frequency

# Speed of sound (m/s) used to calculate ranges;
# Set to 0 if unavailable/unknown
float32 sound_speed

# Beam width (as defined by the vendor) of a single sonar beam in the
# azimuth direction, in radians
float32 azimuth_beamwidth

# Beam width (as defined by the vendor) of a single sonar beam in the
# elevation direction, in radians
float32 elevation_beamwidth

# Azimuth for each beam, in radians.
float32[] azimuth_angles

# Elevation for each beam, in radians. 
# This vector can be left empty if all beams have an elevation 
# of 0.   If set, it must be the same length as azimuth_angles.
float32[] elevation_angles

# Center of each range bin in meters. 
# Rranges may not be equally spaced, and may not necessarily start 
# at zero range.
float32[] ranges

# True if data is big endian.
bool      is_bigendian

# Size of each datum (in bytes)
uint8     data_size

# intensity data [in device-specific units].
#
# Intensities is a dense data array, analogous to an image, with:
#
# len(intensities) =
#           len(ranges)
#         * len(azimuth_angles)
#         * data_size
#
# Intensities are stored in *azimuth-major* order.
uint8[]   intensities
