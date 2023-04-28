cmake_minimum_required(VERSION 3.0.2)

get_filename_component(PACKAGE_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME)
message("Creating Package: ${PACKAGE_NAME}")

project(${PACKAGE_NAME})

find_package(catkin REQUIRED COMPONENTS geometry_msgs message_generation
                                        std_msgs)

file(
  GLOB rosMsgFiles
  RELATIVE "${${PROJECT_NAME}_SOURCE_DIR}/msg"
  "${${PROJECT_NAME}_SOURCE_DIR}/msg/*.msg")

foreach(rosMsg ${rosMsgFiles})
  message(STATUS "Processing message file: ${rosMsg}")
  add_message_files(FILES ${rosMsg})
endforeach(rosMsg)

generate_messages(DEPENDENCIES geometry_msgs std_msgs)

catkin_package(CATKIN_DEPENDS message_runtime std_msgs geometry_msgs)
