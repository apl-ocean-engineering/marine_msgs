#! /usr/bin/env python3

"""
Create test bags for migration.

One message from each message type present in v1.1.0
to re-run:
~~~
git checkout 1.1.0
catkin clean
catkin build
./make_v1_1_0.py
~~~

They're filled with non-zero (but nonsense) data.

I'm not sure whether the component messages need to be
explicitly migrated, but I figure it wouldn't hurt.
* DetectionFlag
* PingInfo
* SonarImageData
"""

import numpy as np
import rosbag
import rospy

import acoustic_msgs.msg
import environmental_msgs.msg

import geometry_msgs.msg


def make_TurbidityNTU():
    msg = environmental_msgs.msg.TurbidityNTU()
    msg.header.frame_id="sensor"
    msg.header.stamp = rospy.Time.now()
    msg.ntu = 13.7

    return msg


def make_DetectionFlag():
    msg = acoustic_msgs.msg.DetectionFlag()
    msg.flag = msg.DETECT_BAD_SONAR
    return msg

def make_Dvl():
    msg = acoustic_msgs.msg.Dvl()
    msg.header.frame_id = "sensor"
    msg.header.stamp = rospy.Time.now()
    msg.velocity_mode = msg.DVL_MODE_BOTTOM
    msg.dvl_type = msg.DVL_TYPE_PISTON

    msg.velocity = geometry_msgs.msg.Vector3()
    msg.velocity.x = 1.0
    msg.velocity.y = 2.0
    msg.velocity.z = 3.0

    msg.velocity_covar = 9*[-1]

    msg.altitude = 2.6
    msg.course_gnd = 1.1
    msg.speed_gnd = 2.2

    msg.num_good_beams = 4
    msg.sound_speed = 1510

    msg.beam_ranges_valid = True
    msg.beam_velocities_valid = True
    msg.beam_unit_vec = [geometry_msgs.msg.Vector3(4,5,6) for _ in range(4)]
    msg.range = [3.8, 3.9, 4.1, 4.2]
    msg.range_covar = 4*[-1]
    msg.beam_quality = [.5, .5, .5, .5]
    msg.beam_velocity = [2.5, 2.5, 2.5, 2.5]
    msg.beam_velocity_covar = 4*[-1]
    return msg

def make_PingInfo(num_beams):
    msg = acoustic_msgs.msg.PingInfo()
    msg.frequency = 2100000
    msg.sound_speed = 1510
    msg.tx_beamwidths = num_beams * [.0044]
    msg.rx_beamwidths = num_beams * [.21]
    return msg

def make_SonarImageData(num_beams, num_ranges):
    msg = acoustic_msgs.msg.SonarImageData()

    msg.is_bigendian = False
    msg.dtype = msg.DTYPE_UINT8

    msg.beam_count = num_beams
    msg.data = [np.random.randint(256) for _ in range(num_beams * num_ranges)]

    return msg

def make_ProjectedSonarImage():
    msg = acoustic_msgs.msg.ProjectedSonarImage()
    msg.header.frame_id = "sonar"
    msg.header.stamp = rospy.Time.now()
    nbeams = 10
    msg.ping_info = make_PingInfo(nbeams)

    msg.beam_directions = nbeams * [geometry_msgs.msg.Vector3(4,5,6)]
    nranges = 10
    msg.ranges = [2.5 * ii for ii in range(nranges)]

    msg.image = make_SonarImageData(nbeams, nranges)

    return msg

def make_RawSonarImage():
    msg = acoustic_msgs.msg.RawSonarImage()
    msg.header.frame_id = "sonar"
    msg.header.stamp = rospy.Time.now()
    nbeams = 10
    msg.ping_info = make_PingInfo(nbeams)

    nranges = 10
    msg.sample_rate = 6000
    msg.samples_per_beam = nranges
    msg.sample0 = 3

    msg.tx_delays = [0.001 * ii for ii in range(nbeams)]
    msg.tx_angles = [0.05*ii - 0.25 for ii in range(nbeams)]
    msg.rx_angles = [0.01*ii - 0.05 for ii in range(nbeams)]
    msg.image = make_SonarImageData(nbeams, nranges)

    return msg

def make_SonarDetections():
    msg = acoustic_msgs.msg.SonarDetections()
    msg.header.frame_id = "sonar"
    msg.header.stamp = rospy.Time.now()
    nbeams = 10
    msg.ping_info = make_PingInfo(nbeams)
    msg.flags = nbeams * [make_DetectionFlag()]
    msg.two_way_travel_times = [np.random.rand() for _ in range(nbeams)]
    msg.tx_delays = [0.001 * ii for ii in range(nbeams)]
    # TODO: The comment for this should be clarified:
    #  "Sonar-reported intensity for each Beam. ..."
    msg.intensities = [np.random.rand() for _ in range(nbeams)]
    msg.tx_angles = [0.05*ii - 0.25 for ii in range(nbeams)]
    msg.rx_angles = [0.01*ii - 0.05 for ii in range(nbeams)]

    return msg


def make_SonarRanges():
    msg = acoustic_msgs.msg.SonarRanges()
    msg.header.frame_id = "sonar"
    msg.header.stamp = rospy.Time.now()
    nbeams = 10
    msg.ping_info = make_PingInfo(nbeams)
    msg.flags = nbeams * [make_DetectionFlag()]
    # TODO: Why doesn't this name match SonarDetections.tx_delays?
    msg.transmit_delays = [0.001 * ii for ii in range(nbeams)]
    # TODO: Also update this comment ...
    msg.intensities = [np.random.rand() for _ in range(nbeams)]
    msg.beam_unit_vec = [geometry_msgs.msg.Vector3(1,2,3) for _ in range(nbeams)]
    msg.ranges = [10*np.random.rand() for _ in range(nbeams)]

    return msg


if __name__ == "__main__":
    rospy.init_node("bag_renaming")
    with rosbag.Bag("test_migration_v1_1_0.bag", 'w') as bag:
        turbidity_ntu = make_TurbidityNTU()
        bag.write("turbidity_ntu", turbidity_ntu)

        detection_flag = make_DetectionFlag()
        bag.write("detection_flag", detection_flag)

        dvl = make_Dvl()
        bag.write("dvl", dvl)

        ping_info = make_PingInfo(3)
        bag.write("ping_info", ping_info)

        sonar_image_data = make_SonarImageData(10, 10)
        bag.write("sonar_image_data", sonar_image_data)

        projected_sonar_image = make_ProjectedSonarImage()
        bag.write("projected_sonar_image", projected_sonar_image)

        raw_sonar_image = make_RawSonarImage()
        bag.write("raw_sonar_image", raw_sonar_image)

        sonar_detections = make_SonarDetections()
        bag.write("sonar_detections", sonar_detections)

        sonar_ranges = make_SonarRanges()
        bag.write("sonar_ranges", sonar_ranges)
