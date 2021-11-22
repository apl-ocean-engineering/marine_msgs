# A single scan from an imaging sonar
#
# Imaging sonars produce either a 1- or 2-D array of sonar beams
# radiating from a common center.  Data in this message must be in 
# a North-East-Down coordinate frame.  For the most common case of a 1-D
# imaging sonar, the array of beams lay on the X-Y plane, and each beam
# then has an associated azimuth (rotation around the Z-axis).  The
# definition of the zero azimuth is dependent on the sonar's data format,
# but for most common sensors, zero azimuth is the middle of the sensor's
# azimuth range, typically "straight ahead" from the physical sensor.
# Regardless of the zero azimuth convention, the data much conform with
# the NED format, with azimuth increasing to starboard.
#
# The azimuth of each beam is given in the vector "azimuth_angles",
# which allows for unevenly distributed sets of beams.
#
# Elevation is defined as rotation around the +Y axis, with negative
# elevations "pitched down" and positive elevations "pitched up".  1-D
# sonars have a single elevation value, typically assumed to be zero.
#
# 2-D sonars *can* have multiple elevation values.   In the case of 2-D
# sonar, the "elevation_angles" and "azimuth_angles" are assumed to be
# fully unzipped s.t. 
#     len(azimuth_angles)    == number of elevations * number of azimuths
#     len(elevations_angles) == number of elevations * number of azimuths
#
# For each beam, the sonar collects a time sequence of acoustic returns.
# We assume an estimate of speed of sound, even if only a constant,
# is available to convert those round trip travel times to ranges in meters,
# which are quantized into a fixed number of range bins.   Distance from the
# sensor to the center of each range bin is reported in the "ranges" vector.
#
# The measured acoustic return is stored for each range bin, for each 
# azimuthal beam, in the "intensities[]" array, as an azimuth-major array.
# That is, the array contains returns for every range in sequence for the
# first azimuth value, then the returns for every range for the second azimuth
# value, and so on.   The precise interpretation or units of the intensities 
# will vary by sensor manufacturer.

# The relationship between the header timestamp and the sonar data
# acquisition process is left to each sonar driver's author.
# Absent other information, it can be taken as the best estimate of
# the time when the sonar data is valid.
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

# Azimuth for center of each beam in radians
# Unless otherwise specified, zero azimuth is assumed to be "straight ahead"
# from the sensor
float32[] azimuth_angles

# Elevation for each "row" of beams in radians. 
# If left empty, the sensor is assumed to be a 1D sonar with an
# all beams having an elevation of { 0.0 }
float32[] elevation_angles

# Center of each range bin in meters. 
# Note ranges may not be equally spaced, and may not necessarily start 
# at zero range.
float32[] ranges

# True if data is big endian.
bool      is_bigendian

# Size of each datum (in bytes)
uint8     data_size

# intensity data [in device-specific units].
#
# Intensities is a dense data array, analogous to an image.  For a 1-D 
# sonar:
#
# len(intensities) =
#           len(ranges)
#         * len(azimuth_angles)
#         * data_size
#
# Intensities are stored in *azimuth-major* order.
uint8[]   intensities
