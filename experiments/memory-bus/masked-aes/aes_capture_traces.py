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

import capture_traces

def bytesFromHex(h):
    s = h
    if(s.startswith("0x")):
        s = s[2:]
    return bytes.fromhex(s)

argparser = None

KEY_RAND_DATA_MASK          = "key-rand-data-mask"
KEY_CONST_DATA_RAND_MASK    = "key-const-data-rand-mask"

data_pattern_choices = [
    "key-rand-data-mask",
    "key-const-data-rand-mask",
]

class AESTraceCapture(scass.trace.TraceCapture):
    """
    Custom Trace Capture Class.
    """

    def __init__(self, 
                 target,
                 scope,
                 trigger_channel,
                 signal_channel,
                 trace_set,
                 num_traces = 1000,
                 num_samples= 1000):
        
        self.key = bytesFromHex("0xbd59c1df6f73cf9d4d6a2add7f92b478")

        self.data_pattern = argparser.parse_args().data_pattern

        scass.trace.TraceCapture.__init__(
            self, target, scope, trigger_channel, signal_channel,
            trace_set, num_traces, num_samples
        )
    
    def getNewData(self):
        """
        Called for each acquision. Generates the input data for the
        device.
        """

        if(self.data_pattern == KEY_RAND_DATA_MASK):
            rblen = self.input_data_len - len(self.key)
            randombytes = secrets.token_bytes(rblen)
            nd = self.key + randombytes 
            return nd
        elif(self.data_pattern == KEY_CONST_DATA_RAND_MASK):
            rblen = 2
            randombytes = secrets.token_bytes(rblen)
            nd = self.key + bytes(16) + randombytes 
            return nd



if(__name__ == "__main__"):

    argparser = capture_traces.parse_args()

    argparser.add_argument("--data-pattern",choices=data_pattern_choices)

    sys.exit(
        capture_traces.main(
            argparser,
            AESTraceCapture
        )
    )

