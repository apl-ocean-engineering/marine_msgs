
# Contributing

We welcome community contributions, and expect that most discussion of these messages will happen via Github issues and pull requests.

There are many ways to contribute to our goal of developing standardized ROS messages for hydrographic applications:

* If one of the existing messages doesn't work for your use case, open an issue describing what the problem is. Optionally, include a PR with a suggested fix.
* If you have an open-source package using any of these messages, post a link and description [on the wiki](https://github.com/apl-ocean-engineering/hydrographic_msgs/wiki)
* If you have a message definition that you think fills a gap in the current set of proposals, submit a pull request. In order to keep discussion grounded in actual use cases, any proposed messages should already be in use on at least one system, or the PR should describe how it unifies multiple existing in-use messages.


*The maintainers of this repo are:*
- Laura Lindzey (APL)
- Brian Bingham (NPS)
- Kris Krasnosky (URI)

## Branching model

This repository only has two branches: while `main` branch supports ROS1 Noetic, `ros2` branch supports ROS2 Foxy, Humble and Rolling.

Rather than feature branches, we expect all development and proposals to occur via pull requests from forks.


## Releases / Review Process

There are no releases =)

A PR will be merged when there is a critical mass of people supporting it.
When applicable, this includes commitments from owners of several repos using the affected message to update their code to match.

Additionally, changes to message definitions are expected to include bag migration rules.

### Styleguide

* Message field names are lowercase, with words separated by underscore. (from the [ROS style guide](http://wiki.ros.org/ROS/Patterns/Conventions))
* We use pre-commit to check for formmating and styling:

**pre-commit**

pre-commit is a tool that is used in hydrographic_msgs to check and apply style guidelines automatically. To install pre-commit into your system:

    pip3 install pre-commit

Then under hydrographic_msgs directory install the git hooks like this:

    cd $CATKIN_WS/src/hydrographic_msgs && pre-commit install

With this pre-commit will automatically run and check a list of styling including clang-format, end of files and trailing whitespaces whenever you run `git commit`. To run pre-commit any time other than `git commit`:

    cd $CATKIN_WS/src/hydrographic_msgs && pre-commit run -a

### Git commit messages

1. Commit messages should succinctly describe the changes you're introducing
2. Use the present tense ("Add feature" not "Added feature")
3. Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
4. Limit the first line to 72 characters or less
