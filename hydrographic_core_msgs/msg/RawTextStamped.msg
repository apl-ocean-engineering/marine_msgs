# message to contain raw ASCII data from a sensor.

# this message should be timestamped at the receive time of the first character of the message.

# the frame_id should be that of the sensor which sent the message

std_msgs/Header header
string data
