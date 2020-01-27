#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    xor t0,a1,a0

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    xor t0,t1,t1

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    test_0:

        j test_1

        xor t0,a1,a0

    test_1:

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        xor t0,t1,t1

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        j test_2
        nop;

        xor t0,a1,a0

    test_2:

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        xor t0,t1,t1

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        j test_3
        nop;
        nop;

        xor t0,a1,a0

    test_3:

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        xor t0,t1,t1

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        j test_4
        nop;
        nop;
        nop;

        xor t0,a1,a0

    test_4:

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        xor t0,t1,t1

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        j test_end
        nop;
        nop;
        nop;
        nop;

        xor t0,t0,a0

    test_end:

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    xor t1,t1,t1

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
