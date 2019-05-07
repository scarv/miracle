
/*!
@file uas_prng.h
@brief The interface to the Pseudo Random Number Generator.
*/

#include <stdint.h>

#ifndef UAS_PRNG_H
#define UAS_PRNG_H

//! Seed the PRNG.
void uas_prng_seed(
    uint32_t seed   //!< The new seed value for the PRNG.
);

//! Return a random 8-bit value
uint8_t uas_prng_uint8();

//! Return a random 16-bit value
uint16_t uas_prng_uint16();

//! Return a random 32-bit value
uint32_t uas_prng_uint32();

#endif
