#!/bin/python3

from urllib.request import pathname2url
import rclpy
import sys
import numpy as np
from time import sleep
import threading
from python_interface.drone_interface import DroneInterface
from as2_msgs.srv import SetSpeed
from as2_msgs.msg import TrajectoryWaypoints
import os

drone_id = "drone_0"


def drone_run(drone_interface):

    takeoff_height = 1.0
    takeoff_speed = 0.5
    
    dim = 10.0
    height = 2.0
    speed = 10.0
    
    print(f"Start mission {drone_id}")

    print(f"Take Off {drone_id}")
    drone_interface.follow_path([[0.1, 0.0, takeoff_height]], speed=takeoff_speed)
    print(f"Take Off {drone_id} done")

    print("Clean exit")


if __name__ == '__main__':
    rclpy.init()
    n_uavs = DroneInterface(drone_id, verbose=True)

    drone_run(n_uavs)

    n_uavs.shutdown()
    rclpy.shutdown()
    exit(0)
