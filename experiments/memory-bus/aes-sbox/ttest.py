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

class AESSBoxTTestcapture(scass.ttest.TTestCapture):
    """
    Specialised TTest capture variant for the aes-sbox experiment.
    """
    
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

        rdata = self._key + \
                secrets.token_bytes(self.input_data_len - self._keylen)

        assert(len(rdata) == self.input_data_len)

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

        log.info("---")
        log.info("NOTE: Using custom AESSBoxTTestcapture class")

        # Call original function
        tr = scass.ttest.TTestCapture.prepareTTest(self)

        self._fixed_value = self._key + self._fixed_value

        print("Fixed Value: %s" % self._fixed_value.hex())
        print("Key   Value: %s" % self._key.hex())

        assert(len(self._key) == self._keylen), \
            "Key must be %d bytes long!" % (self._keylen)

        assert(len(self._fixed_value) == self.input_data_len), \
            "Fixed value should be %d bytes, not %d" % (
            self.input_data_len, len(self._fixed_value))
        
        log.info("---")

        return tr


if(__name__ == "__main__"):
    
    argparser = ttest_capture.parse_args()
    argparser.add_argument("--key",type=str, default="",
        help="A hex string representing the 'key' value to use. If not set, a random value is generated.")

    ttest_capture.main(
        argparser,
        AESSBoxTTestcapture
    )

