#!/usr/bin/python3

import os
import sys
import glob
import logging as log
import secrets
import argparse
import subprocess

import numpy as np
import matplotlib.pyplot as plt

from tqdm import tqdm

acq_path = os.path.expandvars("$UAS_ROOT/external/fw-acquisition")
sys.path.append(acq_path)

import scass
from scass.cpa.AES import sbox as aes_sbox

argparser = argparse.ArgumentParser()

def parse_args(parser):
    """
    Parse command line arguments to the script
    """
    parser.add_argument("--log", type=str, default="",
        help="Log file path for the attack")
    parser.add_argument("--save-path", type=str, default=".",
        help="Where to save figures too.")
    parser.add_argument("--expected-key",type=str, default="",
        help="A hex string representing the expected key value to find in the attack")
    parser.add_argument("--trace-set",type=str,
        help="File path to load trace set from")

    return parser


def main(args):
    """
    Main function.
    """
    launch_rset_collection(args)
    fileset = gather_r_files(args)

    # Guesses for byte 0 of the key.
    all_0 = fileset[0]

    process_byte(all_0)


def process_byte(fileset):

    fig     = plt.figure()
        
    rfile   = fileset[0]
    R       = np.load(rfile) + 1.0

    guess_hist = [0]*256
    guess_conf = [0.0]*256
    
    for i in tqdm(fileset.keys()):
        rfile = fileset[i]

        Rn = np.load(rfile) + 1.0
        
        best_k = Rn.max() 
        ind_k  = np.where(Rn==Rn.max())[0][0]

        guess_hist[ind_k] += 1
        guess_conf[ind_k]  = max(guess_conf[ind_k],best_k)

        R  = np.multiply(R,Rn)

    print("Best Guess: %s" % str(np.argmax(guess_conf)))

    sorted_guesses = np.argsort(guess_conf)

    for i in sorted_guesses:
        if(guess_conf[i] > 0.0):
            print("%03d - %f" % (i, guess_conf[i]))

    plt.subplot(411)
    plt.plot(R,linewidth=0.2)

    plt.subplot(412)
    plt.plot(R.transpose(),linewidth=0.2)
    
    plt.subplot(413)
    plt.plot(guess_hist,linewidth=0.2)
    
    plt.subplot(414)
    plt.plot(guess_conf,linewidth=0.2)

    plt.show()


def launch_rset_collection(args):
    """
    Compute corrolation matricies for each mask guess.
    """

    script = "./experiments/memory-bus/masked-aes/aes_cpa_worker.py"
    
    log.info("Running corrolations for each mask guess.")
    
    for mask_guess in tqdm(range(0,256)):
        
        cmd  = [script,
                "--threads-byte"        , "1",
                "--threads-corrolation" , "4",
                "--only-guess-first"    , "1",
                "--max-traces"          , "50000",
                "--trim-last"           , "5000",
                "--trace-set"           , args.trace_set,
                "--save-path"           , args.save_path,
                "--mask-guess"          , str(mask_guess)
                ]

        result = subprocess.run(cmd)


def gather_r_files(args):
    """
    Gather the set of corrolation matricies.
    """

    input_r_files = glob.glob(args.save_path+"/R-*-*.npy")

    # dict of dicts.
    # - Initial key is byte of key being attacked
    # - Next level is mask hypothesis
    # - This goes to value, which is file path.
    fileset = {}

    log.info("Input R files:")
    for f in input_r_files:

        tokens = f.split("/")[-1].partition(".")[0].split("-")
        kbyte  = int(tokens[1])
        maskg  = int(tokens[2])

        if(not kbyte in fileset):
            fileset[kbyte] = {}

        fileset[kbyte][maskg] = f
        
        #log.info("- byte=%d, mask guess=%d - %s" % (kbyte,maskg,f))
    
    return fileset


if(__name__ == "__main__"):
    
    argparser = parse_args(argparser)
    args      = argparser.parse_args()
    
    
    if(args.log != ""):
        log.basicConfig(filename=args.log,filemode="w",level=log.INFO,
            format='%(asctime)s %(levelname)-8s %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S')
    else:
        log.basicConfig(level=log.INFO,
            format='%(asctime)s %(levelname)-8s %(message)s',
          datefmt='%Y-%m-%d %H:%M:%S')

    main(args)

