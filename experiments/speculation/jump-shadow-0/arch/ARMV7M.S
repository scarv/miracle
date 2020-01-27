#include "kernel-macros.h"

.text

.global experiment_payload
experiment_payload:

    FUNC_ENTER

    mov r7, r1

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;
    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    eor r1,r0

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    mov r1, r7

    eor r4,r5

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    test_0:

        b test_1

        eor r1,r0

    test_1:

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        mov r1, r7

        eor r4,r5

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        b test_2
        nop;

        eor r4,r0

    test_2:

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        mov r1, r7

        eor r4,r5

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        b test_3
        nop;
        nop;

        eor r4,r0

    test_3:

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        mov r1, r7

        eor r4,r5

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        b test_4
        nop;
        nop;
        nop;

        eor r4,r0

    test_4:

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        mov r1, r7

        eor r4,r5

        nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

        b test_end
        nop;
        nop;
        nop;
        nop;

        eor r4,r0

    test_end:

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    mov r1, r7

    eor r5,r5

    nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;

    FUNC_RETURN

.global experiment_payload_end
experiment_payload_end:
