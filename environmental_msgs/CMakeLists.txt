cmake_minimum_required(VERSION 3.5)
project(environmental_msgs)

find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(std_msgs REQUIRED)

set(MSG_FILES "msg/TurbidityNTU.msg")

rosidl_generate_interfaces(${PROJECT_NAME} ${MSG_FILES} DEPENDENCIES std_msgs)

ament_export_dependencies(rosidl_default_runtime)

ament_package()
