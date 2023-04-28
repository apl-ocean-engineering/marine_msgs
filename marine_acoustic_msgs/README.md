## marine_acoustic_msgs

This package includes messages for three commonly used sensors for research in underwater autonomy:
* DVL
* Multibeam
* Imaging Sonar

Each of the proposed messages is based on an existing
message that is currently in use across a variety of manufacturers of the
same instrument type. This gives us confidence that they are mature enough
to be indexed in the ROS debs and that they will generalize across other sensors.

## Coordinate Frame Conventions
![cordiante_conventions](https://user-images.githubusercontent.com/23006525/167165812-008ccccb-31a7-4c13-b2da-6235d37a7a3b.png)

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
    * If not supported at all, the array may be left empty.
    * If value is constant across the data frame, array may be length 1.
    * Otherwise, the length of each array should match the length of the data.
* "raw/temporal" Underwater acoustic messages should include the speed of sound
  (field will be called sound_speed) that was used by the sensor, as well as any
  information required to raytrace the data with a new sound velocity profile.
* "processed/spatial" acoustic messages will have the ray-tracing already performed.
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

https://github.com/apl-ocean-engineering/marine_msgs/blob/main/marine_acoustic_msgs/msg/Dvl.msg

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

## Multibeam and Forward Looking Sonar (FLS) messages

### Organization
![data_structure](https://user-images.githubusercontent.com/23006525/160207155-eb9c003e-8a9a-460e-8c1d-6240924e81e6.png)



Multibeam and FLS sonar data (referred to as sonar data for brevity) are broken into two type categories, detections and images.   Images are intended to represent Watercolumn or FLS imaging data.   Detections represent a detection reported by the sonar for a given beam.

Sonar data is also organized into two domain categories,  temporal and spatial.  Messages are intended to be initially reported in the temporal domain by the sonar drive then converted to the spatial domain through a processing pipeline.   However, some sonars report images and detections directly in the spatial domain.  In this case, sensor drivers may report directly with the appropriate spatial message.

### Data structure
the Sonar messages consist of top level messages:
* RawSonarImage
* ProjectedSonarImage
* SonarDetection
* SonarRanges

These messages share common data in the following sub-messages:
* DetectionFlag
* PingInfo
* SonarImageData

#### SonarImageData packing

It's worth mentioning how the data is packed in the sonar image message as it may not be obvious.

* the actual pixel data is in row-major (i.e beam_no major) order.
* the pixel data is stored as an array of bytes (uint8). It should be cast as the type specified in dtype flag. They are enumerated in the message
* to find the range for each cell: (sample_number + sample0) * sound_speed / (2.0 * sample_rate)

The image details details how image data is stored.

![wcl_def](https://user-images.githubusercontent.com/23006525/160203744-7fc6b06a-ac3d-4419-b6a9-fec83e07cef7.png)


### Geometry Conventions
![rx_tx_detail](https://user-images.githubusercontent.com/23006525/167165995-ce578962-be79-4219-89a0-920953ca6cb2.png)


* angles/beam directions in the spatial domain shall:
  * be reported as unit vectors according to the coordinate frame convention specified above.
  * be reported at time reported in the header timestamp.  (at or before transmit time)
* angles/beam directions in the temporal domain shall be reported as transmit (Tx) and receive (Rx) angles according to the diagram above
  * rx_angle is defined as the elevation from the X-Z plane at receive time. This elevation is positive toward the Y axis.  This elevation defines a cone of possible return directions for a given return beam.
  * tx_angle is defined as the elevation from the Y-Z plane at transmit time. This elevation is positive toward the X axis.  This elevation defines a cone that represents the area insonified by the tx pulse.



### Style Conventions
These messages were designed to comply with the conventions set forth by the [ROS/Patterns/Conventions guide](http://wiki.ros.org/ROS/Patterns/Conventions#Messages).   Beyond that, we have set the following conventions:
* All vector quantities should have plural names
* Variable length message components should be represented as vectors of core ros messages like std_msgs or geometry_msgs.  Avoid variable length arrays of custom message types.  * In otherwords, favor "structures of arrays" rather than "arrays of structures". One exception is the case where data must be grouped to be interpreted properly AND is shared across multiple messages.  (eg. an int with an associated enum.  See PingInfo.msg)
* Message components common to several top-level messages should be split into sub-messages.  (eg. PingInfo is shared by SonarRanges, SonarDetections and RawSonarImage)
* **(PROVISIONAL)** Vector quantities may be of length zero.  This shall be interpreted as "unreported".  (see internal MSG documentation for more details)
