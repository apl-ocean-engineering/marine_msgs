# Message for single ground-track ping from a DVL.
#
# This message is modeled after WHOI's Dvl.msg from the ds_sensor_msgs
# repository, which was released under a BSD license.
# Modifications were made by UW-APL.

# ENUM: Velocity mode
uint8 DVL_MODE_BOTTOM=1
uint8 DVL_MODE_WATER=2

# ENUM: DVL Type; used in sound velocity corrections

# Standard (Janus) array with one piston transducer for each beam.
# If you have 4-5 individual disks on your DVL, use this one.
# Examples include Sonardyne Syrinx, Nortek DVLs, and RDI Workhorse
uint8 DVL_TYPE_PISTON=0

# Phased-array DVL.  If you have one giant disk with complicated stuff
# on it, probably this one.
# Examples include newer RDI DVLs such as pathfinder, pioneer, and tasman.
uint8 DVL_TYPE_PHASED_ARRAY=1

# The standard ROS header.
# Timestamp is neither transmit nor receive time -- it is the time that
# the velocity should be considered valid at.
# Frame convention:
# * z-axis in direction DVL is pointing
# * x-axis aligned with vehicle forward
std_msgs/Header header

# Velocity mode (see above)
uint8 velocity_mode

# Type of DVL array employed (see above).  Necessary when
# deciding how to apply sound velocity corrections
uint8 dvl_type

# Velocities [m/s]
geometry_msgs/Vector3 velocity

# row-major, xyz axes.  Set to "-1" if not known.
float64[9] velocity_covar

# Average altitude of all good beam returns.
# For 30-deg sensor, altitude = (sqrt(3) / 2) * sum(range) / num_good_beams
float64 altitude
# Calculated from xy velocities: course_gnd = atan2(velocity.y, velocity.x)
float64 course_gnd
# Calculated from xy velocities: speed_gnd = sqrt(velocity.x^2 + velocity.y^2)
float64 speed_gnd

uint8 num_good_beams

# Speed of sound (m/s) used by the DVL
float32 sound_speed

# Beam data
# Some DVLs/DVL configurations only report the derived velocities.
bool beam_ranges_valid
bool beam_velocities_valid

# Geometry of each of the 4 beams
geometry_msgs/Vector3[4] beam_unit_vec

# beam_unit_vec[i] * range[i] is the point where the beam hits the seafloor.
# For a 30-deg sensor, multiply by sqrt(3)/2 to get altitude.
float64[4] range
float32[4] range_covar

# Beam quality flag.
# The meaning of this flag is DVL-specific (at least for now).
float32[4] beam_quality

# Raw velocities for each beam [m/s].
# Will be beam 1,2,3,4 velocity in beam coordinates
float32[4] beam_velocity
# Covariance, as always, should be -1 if unknown
float32[4] beam_velocity_covar
