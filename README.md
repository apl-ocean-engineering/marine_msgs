# hydrographic_msgs

This repo is a collection of ROS packages defining common messages that are needed for underwater and surface vehicles.

It is not yet stable -- we are actively seeking out use cases and modifying proposed messages to work better for a larger number of potential users.

If you are using these messages, please contact the maintainers so we know to keep your use case in mind and to tag you on any PRs that might affect you.

**Current Maintainers**:
* Laura Lindzey (APL) (lindzey@uw.edu)
* Kris Krasnosky (URI)
* Brian Bingham (NPS)


## Conventions

(TODO: Link to CoordinateFrames.md once that PR goes through.)

We welcome community contributions! Please see [Contributing.md](Contributing.md) for more information on how get involved.


## Repo Structure

Messages are split into packages based on the following categories:

* acoustic_msgs -- data from acoustic sensors
  * Dvl.msg 
  * SonarRanges.msg -- any fan-shaped sonar returning angle/range data.
  * SonarImage.msg -- any fan-shaped sonar with intensity/range data.
  
* environmental_msgs -- in-situ measurements of water properties
  * oxygen
  * CTD
  * Optical Backscatter
  * etc.

* hydrographic_core_msgs -- utility messages common across multiple sensors
  * raw data  
