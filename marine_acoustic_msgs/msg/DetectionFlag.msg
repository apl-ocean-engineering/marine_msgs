# Beam is OK
uint8 DETECT_OK = 0
# Beam is flagged as bad by the sonar.  Think hard before second-guessing
uint8 DETECT_BAD_SONAR = 1
# Beam is flagged as bad by some automated filter applied during processing.
uint8 DETECT_BAD_FILTER = 2
# Beam is flagged as bad by the user. This is probably not happening in
# realtime, but is included here so the same message can be used throughout
# a post-processing pipeline.
uint8 DETECT_BAD_USER = 4

# These arrays should have the same dimensions, and should match
# the number of beams for this sonar.
#
# Some fields are optional.  Those should have 0 length.

# Flag values for every beam
uint8 flag
