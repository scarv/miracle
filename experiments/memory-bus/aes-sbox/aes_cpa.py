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

    def __init__(self, traces, K = 256, keyBytes = 16, messageBytes=16):
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
        
        self.type_V = np.uint8

        # Which intermediate AES variable should we try to attack?
        self.var_to_attack = argparser.parse_args().var

    def _computeV(self, d, k_guess, V,i,msgbyte):
        """
        Computes the intermedate value for a given message byte d
        and key byte k.
        """

        if(self.var_to_attack == "sbox_word"):

            index = d^k_guess
            word  = index & 0xFC

            b3    = self.hw(aes_sbox[word + 3])
            b2    = self.hw(aes_sbox[word + 2])
            b1    = self.hw(aes_sbox[word + 1])
            b0    = self.hw(aes_sbox[word + 0])
            lb    = self.hw(aes_sbox[index   ])

            return sum([b0, b1, b2, b3, lb]) 

        elif(self.var_to_attack =="sbox_byte"):
            
            return self.hw(aes_sbox[d^k_guess])

        else:

            raise ValueError("Unknow target variable: %s" % self.var_to_attack)

    
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

    # Add some extra option choices
    args.add_argument("-v","--var",choices=["sbox", "enhanced_sbox"],
        default="sbox",
        help="Which intermediate variables should we attack?")

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

