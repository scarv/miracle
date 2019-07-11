#!/usr/bin/python3

import os
import sys
import logging as log
import secrets
import random

acq_path = os.path.expandvars("$UAS_ROOT/external/fw-acquisition")
sys.path.append(acq_path)

import scass
import ttest_capture

# Used to get access to command line arguments.
argparser = None

class AESSBoxTTestcapture(scass.ttest.TTestCapture):
    """
    Specialised TTest capture variant for the aes-sbox experiment.
    """

    def update_mask(self):
        # Update the mask according to the refresh probability.
        if(random.random() < self._mask_refresh_rate):
            self._mask = secrets.token_bytes(self._mask_bytes)
            self.mask_refresh_count += 1
    
    
    def preTraceAcquire(self):
        """
        Called prior to each trace acquisition and selection of
        data for that trace.
        """
        self.update_mask()
    
    def getFixedValue(self):
        """
        Returns the "fixed" value for the TTest. Can be overriden
        to update the fixed value to be sent with things like new
        mask values
        """
        new_fixed_value = self._fixed_value[0:-self._mask_bytes] + \
                          self._mask
        self._fixed_value = new_fixed_value
        return self._fixed_value
    
    def update_target_random_data(self):
        """
        This function should be overriden by inheriting classes, and
        is responsible for updating the target data to "random" values.

        Returns: The random data value as a byte string.

        AESSBoxTTestcapture functionality:
        - The first N bytes of data in any randomly generated value always
          match the first N bytes of the fixed value.
        - By varying N from 0 to about 8, we can see how many extra
          bytes of data are loaded with a byte based on when leakage
          starts and stops appearing.
        """
        
        num_rand_bytes = self.input_data_len - self._mask_bytes - self._keylen

        rdata = self._key + \
                secrets.token_bytes(num_rand_bytes) + \
                self._mask

        assert(len(rdata) == self.input_data_len), "Expected %d bytes, got %d bytes" % (self.input_data_len,len(rdata))

        return rdata

    def prepareTTest(self):
        """
        Override default preparation function.
        """
        
        # Get the number of bytes in the fixed value to match in the
        # random one.
        args                  = argparser.parse_args()

        if(args.key.startswith("0x")):
            args.key = args.key[2:]
        if(args.fixed_value.startswith("0x")):
            args.fixed_value = args.fixed_value[2:]

        self._keylen          = 16
        self._key             = bytes.fromhex(args.key.strip())
        self._mask_bytes      = 2
        self._mask            = bytes(self._mask_bytes)
        self._mask_refresh_rate = args.mask_refresh_rate
        self.mask_refresh_count = 0

        log.info("---")
        log.info("NOTE: Using custom AESSBoxTTestcapture class")

        # Call original function
        tr = scass.ttest.TTestCapture.prepareTTest(self)

        self._fixed_value = self._key + self._fixed_value + self._mask

        log.info("Fixed Value      : %s" % self._fixed_value.hex())
        log.info("Key   Value      : %s" % self._key.hex())
        log.info("Initial mask     : %s" % self._mask.hex())
        log.info("Mask Refresh Rate: %f" % self._mask_refresh_rate)

        assert(len(self._key) == self._keylen), \
            "Key must be %d bytes long!" % (self._keylen)

        assert(len(self._fixed_value) == self.input_data_len), \
            "Fixed value should be %d bytes, not %d" % (
            self.input_data_len, len(self._fixed_value))
        
        log.info("---")

        return tr

    def runTTest(self):
        """
        Overriden so we can print the number of masks we used.
        """
        self.progress_bar = True
        scass.ttest.TTestCapture.runTTest(self)

        log.info("Mask refereshes: %d" % self.mask_refresh_count)


if(__name__ == "__main__"):
    
    argparser = ttest_capture.parse_args()
    argparser.add_argument("--key",type=str, default="",
        help="A hex string representing the 'key' value to use. If not set, a random value is generated.")
    argparser.add_argument("--mask-refresh-rate",type=float,default=0.0,
        help="Probability of the mask being updated on each trace")

    ttest_capture.main(
        argparser,
        AESSBoxTTestcapture
    )

