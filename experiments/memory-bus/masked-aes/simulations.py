#!/usr/bin/python3

import os
import sys
import logging as log
import secrets
import argparse

import numpy as np
import matplotlib.pyplot as plt

acq_path = os.path.expandvars("$UAS_ROOT/external/fw-acquisition")
sys.path.append(acq_path)

import scass
from scass.cpa.AES import sbox as aes_sbox

def hw(x):
    """Return hamming weight of x"""
    c = 0
    while x:
        c  += 1
        x &= x-1
    return c

plt.figure()
ax1 = plt.subplot(321)
ax1.set_title("Hamming weight sum\nfor sbox[k^d]^m1 forall d,m1")

hist_8 = [0]*256

for d in range(0,256):

    for m1 in range(0,256):
        
        sbo     = aes_sbox[d]
        masked  = sbo ^ m1
        weight  = hw(masked)
        hist_8[d] += weight

plt.plot(hist_8)


ax2 = plt.subplot(322)
ax2.set_title("Hamming weight sum\n for sbox words, forall d,m1")

hist_32 = [0] * 64

for d in range(0,64):

    for m1 in range(0,256):
        
        sbo1    = aes_sbox[4*d + 0] ^ m1
        sbo2    = aes_sbox[4*d + 1] ^ m1
        sbo3    = aes_sbox[4*d + 2] ^ m1
        sbo4    = aes_sbox[4*d + 3] ^ m1
        weight  = hw(sbo1)
        weight += hw(sbo2)
        weight += hw(sbo3)
        weight += hw(sbo4)
        hist_32[d] +=weight 

plt.plot(hist_32)

ax4 = plt.subplot(323)
ax4.set_title("Hamming weight Histogram\n for sbox bytes, forall d")

hist_32 = [0] * 32

for d in range(0,256):

    sbo1    = aes_sbox[d]
    weight  = hw(sbo1)
    hist_32[weight] += 1

plt.plot(hist_32)

ax4 = plt.subplot(324)
ax4.set_title("Hamming weight Histogram\n for sbox words, forall d")

hist_32 = [0] * 32

for d in range(0,64):

    sbo1    = aes_sbox[4*d + 0]
    sbo2    = aes_sbox[4*d + 1]
    sbo3    = aes_sbox[4*d + 2]
    sbo4    = aes_sbox[4*d + 3]
    weight  = hw(sbo1)
    weight += hw(sbo2)
    weight += hw(sbo3)
    weight += hw(sbo4)
    hist_32[weight] += 1

plt.plot(hist_32)

ax5 = plt.subplot(325)
ax5.set_title("Hamming weight Histogram\n for masked sbox bytes, forall d,m1")

for d in range(0,256):

    hist_32 = [0] * 32

    for m1 in range(0,256):
        
        # Here, d = data ^ key ^ mask2
        sbo1    = aes_sbox[d] ^ m1
        weight  = hw(sbo1)
        hist_32[weight] += 1

    plt.plot(hist_32)


ax6 = plt.subplot(326)
ax6.set_title("Hamming weight Histogram\n for masked sbox words, forall d,m1")

for d in range(0,64):

    hist_32 = [0] * 32

    for m1 in range(0,256):
        
        # Here, d = data ^ key ^ mask2
        sbo1    = aes_sbox[4*d + 0] ^ m1
        sbo2    = aes_sbox[4*d + 1] ^ m1
        sbo3    = aes_sbox[4*d + 2] ^ m1
        sbo4    = aes_sbox[4*d + 3] ^ m1
        weight  = hw(sbo1)
        weight += hw(sbo2)
        weight += hw(sbo3)
        weight += hw(sbo4)
        hist_32[weight] += 1

    plt.plot(hist_32)

plt.tight_layout(1)
plt.show()
