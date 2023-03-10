# the frame id of the acoustic center of the receiver
# the transmitter frame is assumed to be that specified
# in the message header
string rx_frame_id

# the ping number reported by the sonar.
# useful for matching multiple message types for a given ping
uint64 ping_no

# Center frequency of sonar in Hz
# Set to 0 if unavailable
float32 frequency

# the width of the transmittd pulse in seconds
float32 tx_pulse_width

# Speed of sound (m/s) used to calculate ranges;
# Set to 0 if unavailable
float32 sound_speed

# The number of samples per second that the reciever collects
float32 sample_rate

# Sonar reported -3db beamwidths
# May be empty if not reported
# reported in radians
float32[] tx_beamwidths
float32[] rx_beamwidths
