# A collection of marine radar rays, typically covering a contiguous
# arc of a full circle.

# timestamp in the header is the acquisition time of
# the first ray in the sector.
#
# In frame frame_id, angles are measured around
# the positive Z axis (counterclockwise, if Z is up)
# with zero angle being forward along the X axis
std_msgs/Header header

# start angle of this sector [rad]
float32 angle_start

# angular distance between rays [rad]
float32 angle_increment

# time between rays [seconds] - if your scanner
# is moving, this can be used in interpolating
# position of 3d points
builtin_interfaces/Duration time_increment

# time between two consecutive complete scans
# or revolutions [seconds]
# Warning: On hardware that doesn't provide a timestamp,
# time-related fields may be estimated and vary
# from sector to sector as estimates are updated
builtin_interfaces/Duration scan_time

# range of the first sample in each ray [m]
float32 range_min

# range of the last sample in each ray [m]
float32 range_max

# intensity data [device-specific units].
RadarEcho[] intensities
