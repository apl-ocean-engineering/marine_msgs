We were not consistent with migration rules before v1.1.0.
After that, all PRs must come with a migration rule.

The script "make_v1_1_0.py" creates valid messages with bogus data for
the message definitions in v1.1.0. Its output should be used as a starting point to confirm that all rules successfully chain:
~~~
git checkout 1.1.0
catkin clean
catkin build
./make_v1_1_0.py
git checkout [new_branch]
catkin clean
catkin build
rosbag fix test_migration_v1_1_0.bag test_migration_v1_1_0.fixed.bag
~~~

When new messages are added, a new "make_vX_Y_Z.py" script should be
created that includes them, and that will be used as a starting point.
