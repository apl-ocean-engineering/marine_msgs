# marine_msgs

This repo is a collection of ROS packages defining common messages that are needed for underwater and surface vehicles.

If you are using these messages, please contact the maintainers so we know to keep your use case in mind and to tag you on any PRs that might affect you.

**Current Maintainers**:
* Laura Lindzey (UW APL)
* Kris Krasnosky (USF)
* Brian Bingham (NPS)
- Roland Arsenault (UNH CCOM)


## Conventions

We welcome community contributions! Please see [Contributing.md](Contributing.md) for more information on how get involved.


## Repo Structure

Messages are currently split into packages.

* marine_acoustic_msgs -- data from acoustic sensors
  * Dvl.msg
  * Imaging Sonars -- any fan-shaped sonar with intensity/range data.
    * RawSonarImage.msg -- raw angles
    * ProjectedSonarImage.msg -- raytraced data
  * Profiling Sonars -- any fan-shaped sonar returning angle/range data.
    * SonarDetections.msg -- raw angles/TWTT
    * SonarRanges.msg -- raytraced data

* marine_sensor_msgs -- standalone messages from individual sensors
  * Turbidity
  * oxygen (TODO)
  * CTD (TODO)
  * Optical Backscatter (TODO)
  * etc.

We anticipate the potential need to create additional marine_*_msgs packages.  The threshold for doing so should be (1) a group of closely related messages and/or (2) the need to define sub-messages.

We do not plan to incorporate any acoustic communication messages at this point -- instead, we recommend people consider standardizing around [ros_acomms](https://git.whoi.edu/acomms/ros_acomms).


## Motivation

In the past few years, the community has had a number of discussions about standardizing
UUV messages in ROS, starting at the [2018 BTS workshop](https://discourse.ros.org/t/bts-2018-workshop-adoption-of-conventions-in-the-underwater-ros-community/5389)
and then at [WHOI’s 2019 ROS workshop](https://www2.whoi.edu/staff/ckaiser/ros-workshop/),
following up with discussion in the [marine_ros_conventions repository](https://github.com/udgcirs/marine_ros_conventions_discussion).


While the overall discussion has been fairly broad, we decided to start with sensor
messages because they are more mature and have the highest payoff for standardizing. E.g.:
* Shared drivers
* Shared bagfiles
* Shared RVIZ plugins
* Prerequisite for shared perception pipelines
