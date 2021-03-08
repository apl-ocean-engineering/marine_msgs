## acoustic_msgs

Messages for DVLs, multibeams, and imaging sonars.

## Motivation

In the past few years, the community has had a number of discussions on standardizing 
UUV messages in ROS, starting at the [2018 BTS workshop](https://discourse.ros.org/t/bts-2018-workshop-adoption-of-conventions-in-the-underwater-ros-community/5389)
and then at [WHOI’s 2019 ROS workshop](https://www2.whoi.edu/staff/ckaiser/ros-workshop/), 
following up with discussion in the [marine_ros_conventions repository](https://github.com/udgcirs/marine_ros_conventions_discussion). 
The overall discussion has been fairly broad, but I propose starting with the sensor 
messages because they are more mature and have the highest payoff for standardizing. E.g.:
* Shared drivers 
* Shared bagfiles
* Shared RVIZ plugins
* Prerequisite for shared perception pipelines

This proposal includes messages for three commonly used sensors for research in underwater autonomy: 
* DVL 
* Multibeam
* Imaging Sonar 

Each of the proposed messages is a slightly modified version of an existing 
message that is currently in use across a variety of manufacturers of the 
same instrument type. This gives us confidence that they are mature enough 
for inclusion in sensor_msgs and that they will generalize across other sensors.

## Design decisions common across multiple acoustic messages

Looking at the differences among existing open source UUV messages for 
acoustic sensors, there are a number of overarching design decisions to be 
made before defining individual messages. The proposed set of messages 
adheres to these guidelines:

* The messages should be suitable for use across a wide variety of hardware. 
  - Any sensor-specific metadata fields should be published in a separate message. 
    Standards for defining these additional messages are beyond the scope of this PR. 
    However, options include:
    * Capture all raw bytes sent to / received from a sensor (e.g. WHOI’s RawData.msg)
    * Publish a separate message corresponding exactly to the datagrams 
      sent by the sensor (e.g. PD0.msg)
    * Publish a separate message with the additional data, but no duplication 
      of the standard message, following the Image/CameraInfo pattern.
  - In order to support generality for a wide range of sensors, there will be some 
    fields that are not applicable to some sensors. 
    (e.g. per-beam elevation angles; per-beam beamwidth)
    * If not supported at all, leave that array empty
    * If value is constant across the data frame, array should be length 1
    * Otherwise, the length of each array should match the length of the data.
* Underwater acoustic messages should include the speed of sound 
  (field will be called sound_speed) that was used by the sensor, as well as any 
  information required to raytrace the data with a new sound velocity profile. 
* The beam geometry is specified as a per-beam vector relative to the frame in 
  the header. This is an alternative to other approaches that have been used, including: 
  * additional TF frames for individual beams, which will quickly become unwieldy
  * an array of beam messages, where each beam includes its geometry relative 
    to the sensor. Abstracting out the individual beams doesn’t serve to simplify 
    the interpretation of the data, and doesn’t enable using an empty vector to 
    indicate that a field isn’t applicable. 
  * follow LaserScan convention and derive the geometry from min/max/step, 
    which doesn’t generalize across sonars, since they do not all have beams 
    spaced equiangualarly.
* For sensors that generate data in a fan, the X-axis is considered to be 
  centered in the plane of the fan, with Z down, in order to be consistent 
  with the NED convention. Message fields use azimuth (rotation about Z) 
  and elevation (rotation about Y) to specify beam widths and directions.
* Individual message types should be based on how the data is used, rather 
  than similarities in data format. For example: 
  * DVL and ADCP messages should not be combined, even though there is 
    significant overlap in hardware and provided data. Consumers of DVL 
    data expect a single velocity. Consumers of ADCP data expect velocities 
    at an array of ranges. 
  * There is a need for a difference between SonarImage and SonarRanges 
    (aka multibeam), since they are not typically interchangeable in 
    downstream processing algorithms, even though the newer sensors are 
    blurring the lines. A sonar image consists of intensities-vs-time, 
    while sonar ranges identify discrete returns. 
* In order to be consistent with other messages in sensor_msgs, message 
  types should be named after the type of data rather than type of sensor:
  * SonarImage.msg instead of ImagingSonar.msg
  * SonarRanges.msg instead of Multibeam.msg or ProfilingSonar.msg. 
  
## DVL 
### Existing Messages

The most widely used messages appear to be:
* WHOI’s [ds_sensor_msgs/Dvl.msg](https://bitbucket.org/whoidsl/ds_msgs/src/master/ds_sensor_msgs/msg/Dvl.msg). 
  It is currently in use with both RDI and Nortek instruments.
* UUV Simulator’s [uuv_sensor_ros_plugins_msgs/DVL.msg](https://github.com/uuvsimulator/uuv_simulator/blob/master/uuv_sensor_plugins/uuv_sensor_ros_plugins_msgs/msg/DVL.msg)
  (This was used as the base for [marine_ros_conventions_discussion/DVL.msg](https://github.com/udgcirs/marine_ros_conventions_discussion/blob/master/sensor_msgs/DVL.msg)) 
  The main implementation difference between ds_sensor_msgs and uuv_simulator is 
  whether the top-level DVL message includes the beam data in an array, 
  or whether there is an array of DvlBeam messages.
* UWSim’s [underwater_sensor_msgs/DVL.msg](https://github.com/uji-ros-pkg/underwater_simulation/blob/melodic-devel/underwater_sensor_msgs/msg/DVL.msg).  
  It is not particularly idiomatic for a ROS message: Rather than using a 
  Vector3 for velocity, it has individual fields (wi_{x,y,z}_axis); and 
  rather than using TF to transform between frames, it includes the data in 
  instrument-referenced and vehicle-referenced frames within the same message.

While all options agree that the DVL message should include aggregate data 
from the instrument (estimated altitude and velocity), they differ in what else is included:
* Per-beam data (range, velocity, and their covariances): WHOI & UUV Simulator
* Both bottom-track and water-track velocities: WHOI & UWSim
* Additional details about the sensor configuration: WHOI

### DVL-specific design decisions
* Is there broad support for including water-track velocity in addition to ground-track in the same message definition?
  * NPS is currently interleaving DVL & ADCP messages from the same driver for an instrument that provides both an ADCP profile and a DVL bottom-track velocity. I like this approach.
  * If the same message type supports both bottom track and water track (single reading, not profile), maybe there should be a convention that bottom track / water track are published on different topics so subscribing nodes can ignore water track velocities if they don’t use them.
* Whether the additional information about the sensor configuration (DVL_TYPE) belongs in the top-level message. Other messages in sensor_msgs do not tend to have similar flags; however, this depends on whether we want to be able to perform sound velocity corrections using the data in the DVL message.
* Does a quality flag belong in the standardized message?

### Proposed Message

https://github.com/apl-ocean-engineering/hydrographic_msgs/blob/main/acoustic_msgs/msg/Dvl.msg
 
This message started with WHOI’s definition, which has been used in 
drivers for Nortek and RDI DVLs. There are also corresponding rviz 
and gazebo plugins. (I have trivial forks of those plugins supporting the proposed message.)

I propose the following changes from WHOI’s original message:
* Remove the ds_header -- DsHeader was an attempt to add some hardware-specific 
  metadata to the sensor processing pipeline. It was never fully implemented, 
  and isn’t consistent with other definitions in sensor_msgs. 
* Remove dvl_time -- this was originally intended to support integration of 
  DVL messages from instruments that only provide a monotonic count rather 
  than fully-synchronized timestamps. With modern instruments, `header.stamp` 
  should capture a posix time suitable for integrating the reported velocity. 
* Replace coordinate_mode with beams_valid flag. The 3D velocity and altitude 
  should always be reported in the instrument frame which is specified in the 
  header, and beam ranges/velocities are scalars measured along the corresponding `beam_unit_vec`.
* speed_sound -> sound_speed for consistency across acoustic messages

## Multibeam
### Background/Discussion

For many applications, a pointcloud is well suited for representing 
multibeam data. However, there are cases where we want to take 
advantage of the structure of the scan, for example, with raytracing 
to infer freespace. The LaserScan message is unsuitable for multibeam 
usage due to its assumption of a planar fan with equiangular beams. 
So, I think a generic multibeam message is worth discussing.

There’s a good discussion of multibeam messages here, and this comment 
about how data is represented for non-robotic bathymetric mapping 
provides great context. 

### Multibeam-specific design decisions:
* Should the message flag bad points (as expected in standard multibeam processing pipelines) or remove them? 

### Existing message definitions:
* WHOI’s [ds_multibeam_msgs/MultibeamRaw.msg](https://bitbucket.org/whoidsl/ds_msgs/src/master/ds_multibeam_msgs/msg/MultibeamRaw.msg) 
  It is known to be suitable for Kongsberg EM2040, Reson and Norbit instruments
* A proposed message in [marine_ros_conventions_discussion/ProfilingSonar.msg](https://github.com/udgcirs/marine_ros_conventions_discussion/blob/master/sensor_msgs/ProfilingSonar.msg)

Given that the message in the marine_ros_conventions repository makes 
the same basic assumptions that LaserScan does (planar fan + equiangular), 
I think that WHOI’s message is an appropriate starting point.

### Proposed Message

https://github.com/apl-ocean-engineering/hydrographic_msgs/blob/main/acoustic_msgs/msg/SonarRanges.msg

This message started with WHOI’s definition, which has been used on a Reson, 
a Norbit, and a Kongsberg EM2040. I’ve updated some comments and propose 
the following changes to message fields:
* **Remove the ds_header** -- DsHeader was an attempt to add some hardware-specific metadata to the sensor processing pipeline. It was never fully implemented, and isn’t consistent with other definitions in sensor_msgs. 
* **soundspeed -> sound_speed** for consistency
* **angle{Along,Across}Track -> {elevation, azimuth}_angle**
* **beamwidth{Along,Acros}Track -> {elevation, azimuth}_beamwidth** -- not all 
  multibeam sensors will be mounted with the fan perpendicular to the vehicle’s 
  motion and be used for bathymetric survey, so the field names shouldn’t 
  have those assumptions baked in. 
* **twowayTravelTime -> two_way_travel_time, txDelay -> transmit_delay**: 
  Message fields are typically underscored, not camelcase.
* **beamflag -> flag** none of the other per-beam arrays have the beam prefix

## Imaging Sonar

### Background/Discussion

Similar to the DVL vs. ADCP question, there’s a question as to where 
the line is between an imaging sonar and a multibeam.

For the purposes of defining messages, I think the important thing 
is what type of data you’re getting: a 2D array of intensities at 
different bearings/ranges vs. a 1D array of ranges at different bearings.
* There’s no assumption that a SonarImage.msg will have beams that are 
  much wider across-scan than along-scan, even though that is the traditional
  configuration for an imaging sonar.
* A “multibeam” could publish both a SonarRanges.msg and a SonarImage.msg; 
  one with the range maxima extracted, and the other with full water column intensity data.


### Existing messages:
* APL’s [SonarImage.msg](https://gitlab.com/apl-ocean-engineering/imaging_sonar_msgs/-/blob/master/msg/ImagingSonar2.msg) 
* Proposed message in [marine_ros_conventions repo](https://github.com/udgcirs/marine_ros_conventions_discussion/blob/master/sensor_msgs/ImagingSonar.msg); 
  this differs from APL’s in that it uses min/max/step to specify angles and 
  ranges, and uses a nested array of SonarBeam message rather than a flat intensities array. 

### Proposed Message
https://github.com/apl-ocean-engineering/hydrographic_msgs/blob/main/acoustic_msgs/msg/SonarImage.msg

This is identical to APL’s updated definition; it has been used with an Oculus M1200D and a Blueview multibeam.


