
#include "uas_prng.h"

//! The current value of the PRNG
static uint32_t prng_val = 0xF0F0F0F0;

/*!
@brief Update the PRNG value
@details Implemented as a 32-bit ShiftXOR LFSR.
@notes See https://en.wikipedia.org/wiki/Xorshift
*/
static void prng_update() {
    prng_val ^= prng_val << 13;
    prng_val ^= prng_val >> 17;
    prng_val ^= prng_val <<  5;
}

void uas_prng_seed(
    uint32_t seed
){
    prng_val = seed;
}


uint8_t uas_prng_uint8(){

    prng_update();
    
    return (uint8_t)prng_val;

}

uint16_t uas_prng_uint16() {
    
    prng_update();
    
    return (uint16_t)prng_val;

}

uint32_t uas_prng_uint32() {
    
    prng_update();
    
    return prng_val;

}

