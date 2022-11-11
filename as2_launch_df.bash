#!/bin/bash

if [ "$#" -le 0 ]; then
	echo "usage: $0 [drone_namespace] "
	exit 1
fi

# Arguments
drone_namespace=$1

source ./launch_tools.bash

new_session $drone_namespace
new_window 'pixhawk interface' "ros2 launch pixhawk_platform pixhawk_platform_launch.py \
    drone_id:=$drone_namespace \
    config:=config/DF/platform_default.yaml "

new_window 'RTPS interface' "micrortps_agent  -d /dev/ttyUSB0 -n $drone_namespace"

new_window 'controller_manager' "ros2 launch controller_manager controller_manager_launch.py \
    drone_id:=$drone_namespace \
    namespace:=$drone_namespace \
    use_bypass:=true \
    config:=config/DF/controller.yaml" 

new_window 'state_estimator' "ros2 launch basic_state_estimator mocap_state_estimator_launch.py \
    namespace:=$drone_namespace"

new_window 'basic_behaviours' "ros2 launch as2_basic_behaviours all_basic_behaviours_launch.py \
    drone_id:=$drone_namespace \
    config_follow_path:=config/DF/follow_path_behaviour.yaml \
    config_takeoff:=config/DF/takeoff_behaviour.yaml \
    config_land:=config/DF/land_behaviour.yaml \
    config_goto:=config/DF/goto_behaviour.yaml "

new_window 'traj_generator' "ros2 launch trajectory_generator trajectory_generator_launch.py  \
    drone_id:=$drone_namespace "



