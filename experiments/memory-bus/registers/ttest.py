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

class RegistersTTestcapture(scass.ttest.TTestCapture):
    """
    Specialised TTest capture variant for the registers experiment.
    """
    
    def update_target_random_data(self):
        """
        This function should be overriden by inheriting classes, and
        is responsible for updating the target data to "random" values.

        Returns: The random data value as a byte string.
        """
        randb = secrets.token_bytes(self.input_data_len)
        
        rdata = self._fixed_value[0:4] + randb[4:]
        
        assert(len(rdata) == self.input_data_len),"%d != %d"%(
            len(rdata),self.input_data_len)

        #print(rdata.hex())

        return rdata

    def prepareTTest(self):
        """
        Override default preparation function.
        """
        
        args = argparser.parse_args()

        log.info("---")
        log.info("NOTE: Using custom RegistersTTestcapture class")
        log.info("---")

        # Call original function
        tr = scass.ttest.TTestCapture.prepareTTest(self)

        return tr


if(__name__ == "__main__"):
    
    argparser = ttest_capture.parse_args()

    ttest_capture.main(
        argparser,
        RegistersTTestcapture
    )

