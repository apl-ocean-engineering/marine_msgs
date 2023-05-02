# A collection of marine radar rays, typically covering a contiguous
# arc of a full circle.

Header header            # timestamp in the header is the acquisition time of 
                         # the first ray in the sector.
                         #
                         # in frame frame_id, angles are measured around 
                         # the positive Z axis (counterclockwise, if Z is up)
                         # with zero angle being forward along the x axis

float32 angle_start      # start angle of this sector [rad]
float32 angle_increment  # angular distance between measurements [rad]

duration time_increment  # time between rays [seconds] - if your scanner
                         # is moving, this will be used in interpolating
                         # position of 3d points
duration scan_time       # time between two consecutive complete scans 
                         # or revolutions [seconds]

                         # Warning: On hardware that doesn't provide a timestamp
                         # time-related fields may be estimated and vary
                         # from sector to sector as estimates are updated

float32 range_min        # range of first sample in each ray [m]
float32 range_max        # range of last sample in each ray [m]

RadarEcho[] intensities  # intensity data [device-specific units].
