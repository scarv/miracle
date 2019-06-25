#!/usr/bin/python3

import os
import sys
import logging as log
import secrets

acq_path = os.path.expandvars("$UAS_ROOT/external/fw-acquisition")
sys.path.append(acq_path)

import scass
import ttest_capture

# Used to get access to command line arguments.
argparser = None

class BusWidthTTestcapture(scass.ttest.TTestCapture):
    """
    Specialised TTest capture variant for the bus-width experiment.
    """
    
    def update_target_random_data(self):
        """
        This function should be overriden by inheriting classes, and
        is responsible for updating the target data to "random" values.

        Returns: The random data value as a byte string.

        BusWidthTTestcapture functionality:
        - The first N bytes of data in any randomly generated value always
          match the first N bytes of the fixed value.
        - By varying N from 0 to about 8, we can see how many extra
          bytes of data are loaded with a byte based on when leakage
          starts and stops appearing.
        """
        randb = secrets.token_bytes(self.input_data_len)
        rdata = randb

        # The first N bytes of random data always match the first
        # N bytes of the fixed value.
        if(self._num_fixed_bytes > 0):
            rdata = self._fixed_value[0:self._num_fixed_bytes] + \
                    randb[self._num_fixed_bytes:]
        assert(len(rdata) == self.input_data_len)

        return rdata

    def prepareTTest(self):
        """
        Override default preparation function.
        """
        
        # Get the number of bytes in the fixed value to match in the
        # random one.
        args = argparser.parse_args()
        self._num_fixed_bytes = args.fixed_byte_len

        log.info("---")
        log.info("NOTE: Using custom BusWidthTTestcapture class")
        log.info("---")

        # Call original function
        tr = scass.ttest.TTestCapture.prepareTTest(self)

        if(self._num_fixed_bytes > self.input_data_len):

            log.error("!! Input data length is %d bytes long, but %d fixed bytes specified" % (self.input_data_len,self._num_fixed_bytes))

            log.error("Setting fixed bytes to input data length")

            return False

        else:

            log.info("Number of fixed/random match bytes: %d" % (self._num_fixed_bytes))

        return tr


if(__name__ == "__main__"):
    
    argparser = ttest_capture.parse_args()
    argparser.add_argument("--fixed-byte-len",type=int,default=0,
        help="Number of random bytes to set as equal to the fixed value.")

    ttest_capture.main(
        argparser,
        BusWidthTTestcapture
    )

