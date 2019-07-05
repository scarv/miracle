
#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:
    
    FUNC_ENTER

    ANOP;ANOP;ANOP;ANOP;

#if ARCH_ARMV6M
    #include "sbox_armv6m.S"
#elif ARCH_ARMV7M
    #include "sbox_armv7m.S"
#elif ARCH_MICROBLAZE
    #include "sbox_mb.S"
#elif ARCH_RV32IMC
    #include "sbox_rv32imc.S"
#else
    .error "No known architecture defined"
#endif
    
    ANOP;ANOP;ANOP;ANOP;
    ANOP;ANOP;ANOP;ANOP;
    ANOP;ANOP;ANOP;ANOP;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:

