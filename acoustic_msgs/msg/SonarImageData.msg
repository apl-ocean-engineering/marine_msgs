bool    is_bigendian

uint32  DTYPE_UINT8 = 0
uint32  DTYPE_INT8 = 1
uint32  DTYPE_UINT16 = 2
uint32  DTYPE_INT16 = 3
uint32  DTYPE_UINT32 = 4
uint32  DTYPE_INT32 = 5
uint32  DTYPE_UINT64 = 6
uint32  DTYPE_INT64 = 7
uint32  DTYPE_FLOAT32 = 8
uint32  DTYPE_FLOAT64 = 9

uint32  dtype

# the number of beams associated with the image
uint32 beam_count

# The actually pixel data in row-major (beam_index major) format
uint8[] data
