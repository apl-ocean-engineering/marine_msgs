cmake_minimum_required(VERSION 3.0.2)

project(marine_acoustic_msgs)

find_package(catkin REQUIRED COMPONENTS geometry_msgs message_generation
                                        std_msgs)

add_message_files(
  FILES
  DetectionFlag.msg
  Dvl.msg
  PingInfo.msg
  ProjectedSonarImage.msg
  RawSonarImage.msg
  SonarDetections.msg
  SonarImageData.msg
  SonarRanges.msg)

generate_messages(DEPENDENCIES geometry_msgs std_msgs)

catkin_package(CATKIN_DEPENDS message_runtime std_msgs geometry_msgs)
