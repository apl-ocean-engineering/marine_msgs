# This message is a submessage of RadarSector and is not intended
# to be used separately. It represents intensities from a
# single ray.

# Series of intensities from closest to farthest
# along a given angle increment. For interoperability,
# values should be normalized from 0.0 to 1.0.
# Exceptions to using normalized values should be well
# documented in the device driver and supporting software.
# [device-specific units]
float32[] echoes
