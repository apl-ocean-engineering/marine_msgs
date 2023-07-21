# Contributing

We welcome community contributions, and expect that most discussion of these messages will happen via Github issues and pull requests.

There are many ways to contribute to our goal of developing standardized ROS messages for hydrographic applications:

* If one of the existing messages doesn't work for your use case, open an issue describing what the problem is. Optionally, include a PR with a suggested fix.
* If you have an open-source package using any of these messages, post a link and description [on the wiki](https://github.com/apl-ocean-engineering/marine_msgs/wiki)
* If you have a message definition that you think fills a gap in the current set of proposals, submit a pull request. In order to keep discussion grounded in actual use cases, any proposed messages should already be in use on at least one system, or the PR should describe how it unifies multiple existing in-use messages.


## Branching model

This repository only has two branches:
1) `main` supports ROS1 Noetic
2) `ros2` supports ROS2 Foxy, Humble and Rolling

Rather than encouraging feature branches, we expect most development and proposals to occur via pull requests from forks.


## Releases / Review Process

We are working on getting these message packages released via rosdistro.

A PR adding messages/fields will be merged into HEAD when there is a critical mass of people supporting it.
Edits that are not backwards-compatible (removing/renaming fields) will have a (much) higher threshold.
When applicable, approval requires commitments from owners of several repos using the affected message to update their code to match.

Additionally, changes to message definitions are expected to include bag migration rules.


### Styleguide

* Message field names are lowercase, with words separated by underscore. (Following the [ROS style guide](http://wiki.ros.org/ROS/Patterns/Conventions))
* We use pre-commit to check for formmating and styling

**pre-commit**

pre-commit is a tool that is used in marine_msgs to check and apply style guidelines automatically. To install pre-commit into your system:

    pip3 install pre-commit

Then under marine_msgs directory install the git hooks:

    cd $CATKIN_WS/src/marine_msgs && pre-commit install

With this, pre-commit will automatically run and check a list of styling including clang-format, end of files and trailing whitespaces whenever you run `git commit`. To run pre-commit any time other than `git commit`:

    cd $CATKIN_WS/src/marine_msgs && pre-commit run -a
