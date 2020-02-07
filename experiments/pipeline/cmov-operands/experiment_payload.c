
#include <stdint.h>

/*!
@brief Declaration for the experiment payload function in ldst-byte.S
@details Based on select, result is set to either d1 or d2.
*/
uint8_t experiment_payload(
    uint8_t result,
    uint8_t d1,
    uint8_t d2,
    uint8_t select
){
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    
    result = select ? d1 : d2;

    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    __asm__ volatile ("nop;"); __asm__ volatile ("nop;");
    return result;
}

