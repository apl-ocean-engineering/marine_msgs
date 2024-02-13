cmake_minimum_required(VERSION 3.5)
project(marine_acoustic_msgs)

find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(std_msgs REQUIRED)
find_package(geometry_msgs REQUIRED)

set(MSG_FILES)

file(
  GLOB rosMsgFiles
  RELATIVE "${${PROJECT_NAME}_SOURCE_DIR}"
  "${${PROJECT_NAME}_SOURCE_DIR}/msg/*.msg")

foreach(rosMsg ${rosMsgFiles})
  message(STATUS "Processing message file: ${rosMsg}")
  set(MSG_FILES ${MSG_FILES} ${rosMsg})
endforeach(rosMsg)

rosidl_generate_interfaces(${PROJECT_NAME} ${MSG_FILES} DEPENDENCIES std_msgs
                           geometry_msgs)

ament_export_dependencies(rosidl_default_runtime)

ament_package()
