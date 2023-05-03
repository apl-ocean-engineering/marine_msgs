# marine_sensor_msgs

Messages from common marine sensors. Many of these messages are for
for quantitative data e.g., temperature, turbidity, or dissolved
oxygen.  These are "simple" messages that publish the measured quantity
in a common unit or metric.

## marine_sensor_msgs/RadarSector

The RadarSector message is for use with marine radars that typically scan
along the horizontal plane by rotating an antenna around the vertical axis.
A series of return intensities are reported along each ray at a given angle.

A RadarSector message can contain data from one or more rays. A full scan
covering 360 degrees can be represented by one or more RadarSector messages.
