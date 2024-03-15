^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package marine_acoustic_msgs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

2.1.0 (2024-03-15)
------------------

* Update CMake files to follow established standards
* Add Roland Arsenault as maintainer
* Update ros2 CI to use current ROS2 distributions (`#56 <https://github.com/apl-ocean-engineering/marine_msgs/issues/56>`_)
* Updated ros2 branch to be in line with revisions in main (`#44 <https://github.com/apl-ocean-engineering/marine_msgs/issues/44>`_)
* Contributors: Roland Arsenault, Sean Fish, Laura Lindzey


1.1.0 (2022-11-30)
------------------
* Fix ProjectedSonarImage comments about frame (`#26 <https://github.com/apl-ocean-engineering/hydrographic_msgs/issues/26>`_)
* Add CI, pre-commit, prerelease and dependabot (`#27 <https://github.com/apl-ocean-engineering/hydrographic_msgs/issues/27>`_)
  Co-authored-by: Laura Lindzey <lindzey@uw.edu>
* Merge pull request `#25 <https://github.com/apl-ocean-engineering/hydrographic_msgs/issues/25>`_ from apl-ocean-engineering/add_migration_rule
  Add migration rule from v0.0.1 to 28ec6a7
* Add migration rule from v0.0.1 to 28ec6a7
* Merge pull request `#22 <https://github.com/apl-ocean-engineering/hydrographic_msgs/issues/22>`_ from rolker/fix_variable_name
* Rename num_beams to beam_count.
* Merge pull request `#21 <https://github.com/apl-ocean-engineering/hydrographic_msgs/issues/21>`_ from CaptKrasno/acoustic_msg_devel
* Contributors: CaptKrasno, Laura Lindzey, Roland Arsenault, Vatan Aksoy Tezer, lauralindzey

1.0.0 (2022-05-05)
------------------
* Merge pull request `#20 <https://github.com/apl-ocean-engineering/hydrographic_msgs/issues/20>`_ from CaptKrasno/acoustic_msg_devel
  Acoustic msg devel
* Removed unused (old) sonarImage message
* Merge remote-tracking branch 'apl-ocean-engineering/main' into acoustic_msg_devel
* added ping info to sonar ranges
* Number of beams has been added to sonarImageData so it can be decoded independently
* Update README.md
* Merge remote-tracking branch 'origin/main' into acoustic_msg_devel
* committing changes from meeting
* Update README.md
* Changes after pull request discussion
* update internal documentation
* Merge branch 'main' into acoustic_msg_devel
* Add multibeam detections and watercolumn
* Contributors: CaptKrasno, Kristopher Krasnosky, lauralindzey

0.0.1 (2021-11-23)
------------------
* Merge pull request `#13 <https://github.com/apl-ocean-engineering/hydrographic_msgs/issues/13>`_ from amarburg/feature/revise-sonar-image-comment
  Feature/revise sonar image comment
* Revised comments based on PR feedback.
* Revised based on comments on PR
  Removed language on 2D sonars
  Revised language on azimuth and elevation angles
  Revised language on header timestamp.
* Added note on sound speed.
* Very minor update in spelling.
* Significant rewrite of the explanatory comment in SonarImage.msg
* Merge pull request `#10 <https://github.com/apl-ocean-engineering/hydrographic_msgs/issues/10>`_ from valschmidt/main
  Fixed broken links for proposed messages.
* Merge pull request `#1 <https://github.com/apl-ocean-engineering/hydrographic_msgs/issues/1>`_ from valschmidt/valschmidt-fixed_broken_msg_links
  Fixed broken links to proposed messages.
* Fixed broken links to proposed messages.
* Create Contributing.md
  First pass at the contributing doc adapted from MBARI's LRAUV contributing guide
* Move acoustic_msgs package out of repo's root directory.
* Contributors: Aaron Marburg, CaptKrasno, Laura Lindzey, braanan, lauralindzey, valschmidt
