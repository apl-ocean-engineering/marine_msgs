cmake_minimum_required(VERSION 3.5)

project(marine_acoustic_msgs)

# Default to C++17
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 17)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()
if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(ament_cmake REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(std_msgs REQUIRED)

# cmake-format: off
set(MSG_FILES
  "msg/DetectionFlag.msg"
  "msg/Dvl.msg"
  "msg/PingInfo.msg"
  "msg/ProjectedSonarImage.msg"
  "msg/RawSonarImage.msg"
  "msg/SonarDetections.msg"
  "msg/SonarImageData.msg"
  "msg/SonarRanges.msg"
)

rosidl_generate_interfaces(${PROJECT_NAME}
  ${MSG_FILES}
  DEPENDENCIES geometry_msgs std_msgs
)
# cmake-format: on

ament_export_dependencies(rosidl_default_runtime)

ament_package()
