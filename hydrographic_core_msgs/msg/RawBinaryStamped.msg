# message to contain raw binary data from a sensor.

# this message should be timestamped at the receive time of the first byte of the message.

# the frame_id should be that of the sensor which sent the message

std_msgs/Header header
uint8[] data
