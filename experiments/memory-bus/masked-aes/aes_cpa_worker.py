#!/usr/bin/python3

import os
import sys
import logging as log
import secrets
import argparse

import numpy as np
import matplotlib.pyplot as plt

from tqdm import tqdm

acq_path = os.path.expandvars("$UAS_ROOT/external/fw-acquisition")
sys.path.append(acq_path)

import scass
from scass.cpa.AES import sbox as aes_sbox

import ttest_capture
import cpa


# Used to get access to command line arguments.
argparser = argparse.ArgumentParser()


class AESSboxCorrolationAnalysis(scass.cpa.CorrolationAnalysis):
    """
    Custom class for generating corrolation analysis data for the
    AES SBOX transformation
    """

    def __init__(self, 
                 traces,
                 K           = 256,
                 keyBytes    = 16,
                 messageBytes= 16):
        """
        Overriden init function.
        """
        
        self.mask_guess = argparser.parse_args().mask_guess

        assert(self.mask_guess in range(0,256))

        log.info("SBOX output mask guess: 0x%x (%d)" % (
            self.mask_guess,self.mask_guess))

        # Parent __init__ function
        scass.cpa.CorrolationAnalysis.__init__(
            self,
            traces,
            K,
            keyBytes,
            messageBytes
        )
    
    
    def _computeV(self, d, k_guess, V,i,j):
        """
        Computes the intermedate value for a given message byte d
        and key byte guess k_guess.
        """

        k_xor_d  = k_guess ^ d
        m2_guess = self.mask_guess

        sbox_in = (k_xor_d) & 0xFC

        ha = self.hw(aes_sbox[k_xor_d    ]^m2_guess)
        h0 = self.hw(aes_sbox[sbox_in + 0]^m2_guess)
        h1 = self.hw(aes_sbox[sbox_in + 1]^m2_guess)
        h2 = self.hw(aes_sbox[sbox_in + 2]^m2_guess)
        h3 = self.hw(aes_sbox[sbox_in + 3]^m2_guess)
    
        return sum([ha,h0,h1,h2,h3])

    
    def computeH(self, V, msgbyte):
        """
        Compute the hypothesised power consumption values from
        the V matrix.
        """
        #  Direct copy.
        H       = V

        return H
    

def byteCallbackFunc(b, guess, confidence, R, savepath, cpa):
    """
    Callback function for analysing things per byte,
    b:
        The byte index within the message
    guess:
        The guessed byte for the key
    confidence:
        Corrolation coefficient for the key.
    R:
        Corrolation matrix. K*T
    savepath:
        Where to put saved graphs
    cpa:
        Corrolation analysis object. Gives access to the traces.
    """

    mask_guess = argparser.parse_args().mask_guess

    # Save the computed corrolation matrix.
    keycorr_path   = "%s/R-%d-%d.npy" % (savepath,b,mask_guess)
    R.dump(keycorr_path)
    
    # Write out the corrolation graph.
    #fig = plt.figure()
    #plt.clf()

    #plt.suptitle("Key guess byte: %s (%d)" % (\
    #    hex(guess),guess,))
    #
    #plt.subplot(211)
    #plt.plot(R, linewidth=0.2)
    #
    #plt.subplot(212)
    #plt.plot(R.transpose(), linewidth=0.2)
    #
    #fig.set_size_inches(20,10,forward=True)
    #plt.savefig("%s/%d-%d.png" % (savepath,b, mask_guess))

    #fig.clf()
    #plt.close(fig)

# ------------------------------------------------------------

if(__name__ == "__main__"):
    
    # Add extra mask_guess value to command line arguments.
    argparser.add_argument("--mask-guess", type=int, default=0,
        help="Hypothesis for SBOX output mask",
        required=True)

    # Get default corrolation power analysis command line arguments.
    args        = cpa.parse_args(argparser)
    args        = args.parse_args()
    
    if(args.log != ""):
        print("Logging to: %s" % args.log)
        log.basicConfig(filename=args.log,filemode="w",level=log.INFO,
            format='%(asctime)s %(levelname)-8s %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S')
    else:
        log.basicConfig(level=log.INFO,
            format='%(asctime)s %(levelname)-8s %(message)s',
          datefmt='%Y-%m-%d %H:%M:%S')

    # Pass power model and analysis class types
    analyser    = AESSboxCorrolationAnalysis

    result      = cpa.main(
        args,
        analyser,
        scass.cpa.CPAModelHammingDistance,
        byteCallback = byteCallbackFunc
    )

    sys.exit(result)

