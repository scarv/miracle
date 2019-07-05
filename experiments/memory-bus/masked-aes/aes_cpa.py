#!/usr/bin/python3

import os
import sys
import logging as log
import secrets
import argparse

import numpy as np

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
        K = 256*256,
        keyBytes = 16,
        messageBytes=16):
        """
        Overriden init function.
        """
        
        # Upstream __init__ function
        scass.cpa.CorrolationAnalysis.__init__(
            self,
            traces,
            K,
            keyBytes,
            messageBytes
        )

    def _computeV(self, d, k_guess, V,i,msgbyte):
        """
        Computes the intermedate value for a given message byte d
        and key byte k.
        """
        k = int(k_guess/256)
        m2= int(k_guess%256)
        return self.hw(aes_sbox[k^d] ^ m2)

    
    def computeH(self, V):
        """
        Compute the hypothesised power consumption values from
        the V matrix.
        """
        H_shape = (self.D, self.K)
        H       = np.empty(H_shape, dtype=self.type_H, order='C')
        
        for i in range(0,self.D):
            for j in range(0,self.K):
                H[i,j] = V[i,j]

        return H


class AESSboxPowerModel(scass.cpa.CPAModelHammingDistance):
    """
    Custom class for generating power models to attack the AES SBox with.
    """



if(__name__ == "__main__"):
    
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
    
    log.getLogger().addHandler(log.StreamHandler(sys.stdout))

    # Pass power model and analysis class types
    analyser    = AESSboxCorrolationAnalysis
    powermodel  = AESSboxPowerModel

    result      = cpa.main(
        args,
        analyser,
        powermodel
    )

    sys.exit(result)

