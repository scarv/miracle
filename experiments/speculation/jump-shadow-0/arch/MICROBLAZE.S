#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    xor r9,r6,r5

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    xor r9,r10,r10

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    test_0:

        bri test_1

        xor r9,r6,r5

    test_1:

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        xor r9,r10,r10

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        bri test_2
        nop;

        xor r9,r6,r5

    test_2:

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        xor r9,r10,r10

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        bri test_3
        nop;
        nop;

        xor r9,r6,r5

    test_3:

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        xor r9,r10,r10

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        bri test_4
        nop;
        nop;
        nop;

        xor r9,r6,r5

    test_4:

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        xor r9,r10,r10

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        bri test_end
        nop;
        nop;
        nop;
        nop;

        xor r9,r9,r5

    test_end:

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    xor r10,r10,r10

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
