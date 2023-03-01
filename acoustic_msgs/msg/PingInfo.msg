# the frame id of the acoustic center of the receiver
# the transmitter frame is assumed to be that specified
# in the message header
string rx_frame_id

# the ping number reported by the sonar.
# useful for matching multiple message types for a given ping
uint64 ping_no

# Acoustic array geometry 

# linear arrays are found in most MBES for both TX and RX
# implications for processing:  
# 	- Beam widths grow with obliquity
#	- Beam pattern is represented as a cone defined by the tx/rx angle
uint8 ARRAY_GEOMETRY_LINEAR=0 

# Circular/Barrel arrays are found in some MBES and FLS as both tx and 
# rx arrays.   They are defined by an array of elements equally spaced
# on the rim of a circle
# implications for processing:  
#	- Beam widths are constant with obliquity
#	- Beam pattern is represented as a plane defined by the tx/rx angle
uint8 ARRAY_GEOMETRY_CIRCULAR=1

uint8 tx_geometry
uint8 rx_geometry

# The steering angles represent how far off an effective linear array 
# the beam was steered.  This angle will define how conical the tx/rx
# beam is.  
# For the linear portion of an array tx/rx_steering_angle = tx/rx_angle
# For the circular portion of an array tx/rx_sterring_angle = 0
uint8[] tx_steering_angles
uint8[] rx_steering_angles

# Center frequency of sonar in Hz
# Set to 0 if unavailable
float32 frequency

# Speed of sound (m/s) used to calculate ranges;
# Set to 0 if unavailable
float32 sound_speed

float32 sample_rate   # hz
float32 tx_pulse_width



# Sonar reported -3db beamwidths
# May be empty if not reported
# reported in radians
float32[] tx_beamwidths
float32[] rx_beamwidths
