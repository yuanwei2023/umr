===========
User Queues
===========

UMR supports the ability to bind to both KFD and KGD client user queues.  By doing this,
UMR adopts the client virtual memory space and can not only decode packets from the queues
but also support virtual memory commands (such as *-vm*, *-vr*, *-vdis*, *--dump-ib*, etc).

---------------
Quick reference
---------------

Bind with *--user-queue* or *-uq* using a comma-separated client string (tokens may appear in any order; see `Queue Bindings`_).

* *--list-uq* — list clients and queues for the selected GPU instance.
* *--print-uq* — decoded client and MQD/HQD state (requires a prior *--user-queue* / *-uq*).
* *--dump-uq* or *-du* — decode the bound queue’s submission buffer (same idea as *-RS uq*, but as a dedicated command).
* *-RS uq[...]* — ring-stream decode using the synthetic ring name ``uq`` (see `Reading the Command Submission from a User Queue`_).

If the queue’s read and write pointers are equal, *--dump-uq* and *-RS uq* may refuse to decode; try *-O use_full_user_queue* to read the full ring buffer instead.
If UMR reports failures reading the HQD read/write pointers from memory, try disabling GFXOFF with *-go 0*.

User-queue paths live under ``/sys/kernel/debug/dri/<instance>/`` (and KFD under ``/sys/kernel/debug/kfd/``).  On multi-GPU systems, select the card with *--instance* / *-i* (or *--gpu* / *--pci* as elsewhere in UMR).  Opening these debugfs files normally requires root.

--------------
Kernel Support
--------------

**NOTE:** User queue support in UMR is a relatively new feature requiring kernel support for the
debugfs interfaces used to attach to a client's virtual memory space.  These features were added to the
AMD Linux tree in late August 2025.  If you are using an upstream kernel (likely pre 6.17) chances
are you do not have the functionality required unless you fetch a Linux kernel that has these patches.

UMR should print out error messages if it can't open the requisite client files from debugfs.  If this happens
it means your kernel lacks the patches required, or the process lacks permission to read debugfs (try as root).

--------------
Queue Bindings
--------------

To bind to a queue you have to specify a client string which is a comma separated list of
three things (*in any order*): (optionally) a **client type**, a **client** identifier, and a **queue** identifier.

The **client type** is either 'kfd' or 'kgd' depending on the type of client you are debugging.
'kgd' clients can include compute queues as well as graphics queues. The client type is optional
if umr detects the process id in the KFD debugfs tree it will assume it's a KFD client otherwise
it will assume it's a KGD client by default.

The **client** identifier can take on several formats:

+------------------+----------------------------------------------------------------------------------+
| client=<integer> | An integer selecting a specific client under /sys/kernel/debug/client-${integer} |
+------------------+----------------------------------------------------------------------------------+
| pid=<integer>    | An integer specifying which PID to look for a client matching this PID           |
+------------------+----------------------------------------------------------------------------------+
| comm=<string>    | A string of the command name that created the queue                              |
+------------------+----------------------------------------------------------------------------------+

The **queue** identifier can take on several formats:

+------------------+-------------------------------------------------------------------------+
| queue=<integer>  | An integer specifying the queue to select from the client               |
+------------------+-------------------------------------------------------------------------+
| type=<string>    | Select the first queue matching the type (gfx, compute, sdma) specified |
+------------------+-------------------------------------------------------------------------+

**Queue numbers (KGD vs KFD).**  For **KGD** clients, queue ids follow the ``queue_N`` directories under
``/sys/kernel/debug/dri/client-<id>/`` and are **1-based** (the first queue is ``queue=1``).
For **KFD** clients, queues are enumerated from ``/sys/kernel/debug/kfd/mqds`` for the process and
``queue=<integer>`` is a **0-based** index in that list (the first queue is ``queue=0``).
Examples in this document use KFD-style numbering where ``queue=0`` is the first queue.

**type= selection.**  The *type=* token picks the first queue whose internal type matches *gfx*, *compute*, or *sdma*.
After MQD parsing, some compute queues are classified as PM4-style compute; that type uses a different
numeric id than plain AQL compute, so *type=compute* matches the AQL compute class only—if binding fails,
use *--list-uq* and *queue=* with the reported id.

**KFD and multiple GPUs.**  Queue discovery for KFD may list queues for a process without tying each queue
to a specific AMDGPU instance; on multi-GPU hosts, verify you are using the intended *--instance* / *-i*.

For example the string: kfd,comm=ollama,queue=2 would tell umr to bind to the first instance of the
application 'ollama' that is running with a KFD client, and then to the queue #2 of that client.

-------------------
Listing User Queues
-------------------

To list out all of the user queues visible for the selected GPU instance, the *--list-uq* command can be used.

::

    $ umr --list-uq

This will print out a list of clients and queues for that instance (see *--instance* / *-i* when more than one GPU exists).  For example,

::

    $ umr --list-uq
    Client #20: comm=[test] tgid=2757 type=kfd
    **   queue=0 type=1 mqd_gpu_addr=0x1745200 rptr=0x0 wptr=0x2

Here the client is PID **2757** with command name **test**, and the queue line shows ``type=1`` (AQL compute).
The numeric *type* column is UMR’s internal queue-type enum:

+-------+------------------+
| type  | Meaning          |
+=======+==================+
| 0     | GFX              |
+-------+------------------+
| 1     | Compute (AQL)    |
+-------+------------------+
| 2     | Compute (PM4)    |
+-------+------------------+
| 3     | SDMA             |
+-------+------------------+

The MQD GPU address is **0x1745200** and the read pointer is **0x0** and the write pointer is **0x2**.
The leading ``**`` indicates that the read and write pointers differ—a quick way to spot queues that may be active or hung.

--------------------------------
Listing User Queue Information
--------------------------------

To print information from a given client use the *--print-uq* command by first binding to the client and queue with the *--user-queue* or *-uq* command.

::

    $ umr --user-queue client=${client},queue=${queue} --print-uq

This will print out information about the user queue specified.  For example,

::

        $ umr --user-queue client=20,queue=0 --print-uq
        User Queue info for client: 'client=20,queue=0' (qidx=0)
                command: test
                tgid: 2757
                dev: 128
                master: n
                a: n
                uid: 1000
                magic: 0
                name: <unset>
                id: 20

                pid: 2757, comm: test

                pd_address: 0x3f7dff001
                max_pfn: 0x1000000000
                num_level: 0x3
                block_size: 0x9
                fragment_size: 0x9

                Registers:
                        PAGE_TABLE_START_ADDR_LO32: 0x0
                        PAGE_TABLE_START_ADDR_HI32: 0x0
                        PAGE_TABLE_END_ADDR_LO32: 0xffffffff
                        PAGE_TABLE_END_ADDR_HI32: 0xf
                        PAGE_TABLE_BASE_ADDR_LO32: 0xf7dff001
                        PAGE_TABLE_BASE_ADDR_HI32: 0x3

        Queue #0:
                queue_id: 0
                queue_type: 1 (compute)
                mqd_gpu_address: 0x1745200
                HQD state:
                        hqd_base_addr: 0x7a0823e00000
                        hqd_rptr_addr: 0x7a0942efe080 (0x0)
                        rb_wptr_poll_addr: 0x7a0942efe038 (0x2)
                        hqd_active: 0x0
                        rb_buf_size: 0x40000

                MQD Contents (512 words):
                        queue.0.MQD[000] == 0xc0310800 (header)
                        queue.0.MQD[001] == 0x00000000 (compute_dispatch_initiator)
        ...<snip>...

Here we see that the client is running as PID **2757** and the command name is **test**.  The queue is
type **1** which is a compute queue.  The MQD GPU address is **0x1745200** and the read pointer is **0x0**
and the write pointer is **0x2**. 

In each queue we also see a variety of parameters that are useful.  For simplicity sake the register names
are left as the GFX queue versions but they serve similar purposes.  The *hqd_base_addr* represents the virtual
address of the queue's ring buffer.  The *hqd_rptr_addr* and *rb_wptr_poll_addr* represent the virtual
addresses of the queues read and write pointers respectively.  Here we see the read pointer is at virtual
address **0x7a0942efe080** and currently has the value **0x0**.

For each queue we also get a complete dump of the MQD (memory queue descriptor).

The *hqd_active* flag is **0x0** which indicates that the queue is not active.  The *rb_buf_size* is **0x40000**
which is the size of the ring buffer.

The *MQD Contents* section is a complete dump of the MQD.  This is useful for seeing the contents of the MQD
and can be used to decode the contents of the MQD.

As another example here's a non-contrived application using --print-uq to print out information about the user queues in a given a client.

::

    $ umr --user-queue kfd,comm=ollama,queue=2 --print-uq
    User Queue info for client: 'kfd,comm=ollama,queue=2'
            command: ollama
            tgid: 2691
            dev: 128
            master: n
            a: n
            uid: 997
            magic: 0
            name: <unset>
            id: 8

            pid: 2691, comm: ollama

            pd_address: 0x3daaf1001
            max_pfn: 0x1000000000
            num_level: 0x3
            block_size: 0x9
            fragment_size: 0x9

            Registers:
                    PAGE_TABLE_START_ADDR_LO32: 0x0
                    PAGE_TABLE_START_ADDR_HI32: 0x0
                    PAGE_TABLE_END_ADDR_LO32: 0xffffffff
                    PAGE_TABLE_END_ADDR_HI32: 0xf
                    PAGE_TABLE_BASE_ADDR_LO32: 0xdaaf1001
                    PAGE_TABLE_BASE_ADDR_HI32: 0x3

    Queue #0:
            queue_id: 0
            queue_type: 1 (compute)
            mqd_gpu_address: 0xf2e200
            HQD state:
                    hqd_base_addr: 0x752030000000
                    hqd_rptr_addr: 0x752248504080 (0x9ec)
                    rb_wptr_poll_addr: 0x752248504038 (0x9ec)
                    hqd_active: 0x0
                    rb_buf_size: 0x40000

            MQD Contents:
                    queue.0.MQD[000] == 0xc0310800 (header)
                    queue.0.MQD[001] == 0x0000d064 (compute_dispatch_initiator)
                    queue.0.MQD[002] == 0x00002000 (compute_dim_x)
                    queue.0.MQD[003] == 0x00000001 (compute_dim_y)
                    queue.0.MQD[004] == 0x00000001 (compute_dim_z)
                    queue.0.MQD[005] == 0x00000000 (compute_start_x)
                    queue.0.MQD[006] == 0x00000000 (compute_start_y)
                    queue.0.MQD[007] == 0x00000000 (compute_start_z)
                    queue.0.MQD[008] == 0x00000100 (compute_num_thread_x)
                    queue.0.MQD[009] == 0x00000001 (compute_num_thread_y)
    ...<snip>...
    Queue #2:
            queue_id: 2
            queue_type: 1 (compute)
            mqd_gpu_address: 0xf2c200
            HQD state:
                    hqd_base_addr: 0x75207c800000
                    hqd_rptr_addr: 0x752248514080 (0xe8a4)
                    rb_wptr_poll_addr: 0x752248514038 (0xec88)
                    hqd_active: 0x0
                    rb_buf_size: 0x40000

            MQD Contents:
                    queue.2.MQD[000] == 0xc0310800 (header)
                    queue.2.MQD[001] == 0x0000d064 (compute_dispatch_initiator)
                    queue.2.MQD[002] == 0x00028000 (compute_dim_x)
                    queue.2.MQD[003] == 0x00000001 (compute_dim_y)
                    queue.2.MQD[004] == 0x00000001 (compute_dim_z)
                    queue.2.MQD[005] == 0x00000000 (compute_start_x)
                    queue.2.MQD[006] == 0x00000000 (compute_start_y)
                    queue.2.MQD[007] == 0x00000000 (compute_start_z)
    ...<snip>...

In this example we attached to a running Ollama process and specified queue #2.  The *--print-uq*
command will print out information about every queue in that client not just the one selected.  The one
selected though ultimately impacts other commands (such as *--dump-uq* and *--waves*).

Here we see that the process is found with PID **2691**, the page table base address for the virtual
memory space is found at **0x3daaf1001** (this is the first level PDE when decoding virtual addresses),
along with associated parameters (levels, block size, etc).

In each queue we also see a variety of parameters that are useful.  For simplicity sake the register names
are left as the GFX queue versions but they serve similar purposes.  The *hqd_base_addr* represents the virtual
address of the queue's ring buffer.  The *hqd_rptr_addr* and *rb_wptr_poll_addr* represent the virtual
addresses of the queues read and write pointers respectively.  Here we see the read pointer is at virtual
address **0x752248514080** and currently has the value **0xe8a4**.

For each queue we also get a complete dump of the MQD (memory queue descriptor).

-------------------------------
Reading Waves from a User Queue
-------------------------------

To read waves from a user queue use the *--waves* command by first binding to the client and queue with the *--user-queue* or *-uq* command.

::

    $ umr --user-queue client=${client},queue=${queue} -O halt_waves --waves uq

This will print out information about the waves in the user queue specified.  For example,

::

        $ umr --user-queue client=20,queue=0 -O halt_waves --waves uq
        ------------------------------------------------------
        se1.sa0.wgp0.simd0.wave0 


        Main Registers:
                ixSQ_WAVE_STATUS: 10010040 |      ixSQ_WAVE_PC_LO: 44aa5604 |      ixSQ_WAVE_PC_HI: 00007a09 |    ixSQ_WAVE_EXEC_LO: 00000001 | 
                ixSQ_WAVE_EXEC_HI: 00000000 |     ixSQ_WAVE_HW_ID1: 20040000 |     ixSQ_WAVE_HW_ID2: 08000112 |  ixSQ_WAVE_GPR_ALLOC: 00001000 | 
                ixSQ_WAVE_LDS_ALLOC: 00000000 |     ixSQ_WAVE_IB_STS: 00000000 |    ixSQ_WAVE_IB_STS2: 70000000 |    ixSQ_WAVE_IB_DBG1: 01000000 | 
                ixSQ_WAVE_M0: 0b6c9ae0 |       ixSQ_WAVE_MODE: 000000f0 | ixSQ_WAVE_STATE_PRIV: 00004000 | ixSQ_WAVE_EXCP_FLAG_PRIV: 00000000 | 
                ixSQ_WAVE_EXCP_FLAG_USER: 00000000 |  ixSQ_WAVE_TRAP_CTRL: 00000000 |     ixSQ_WAVE_ACTIVE: 00000000 | ixSQ_WAVE_VALID_AND_IDLE: 00000001 | 
                ixSQ_WAVE_DVGPR_ALLOC_LO: bebebeef | ixSQ_WAVE_DVGPR_ALLOC_HI: bebebeef | ixSQ_WAVE_SCHED_MODE: 00000000 | 

        >SGPRS[0..3] = { 7944dbed, ccb6f62e, 38c88f11, 8411930d }
        >SGPRS[4..7] = { 6250ff8b, e917f460, 1fce4581, f5471aae }
        >SGPRS[8..11] = { f4ca7da8, 3cc5555c, 53382d17, 4b99139c }
        >SGPRS[12..15] = { 0d810191, 4ceb9181, e9baeaff, 488b8e6b }
        >SGPRS[16..19] = { 79e30fde, c433ed1f, faf47d33, dd2df02f }
        >SGPRS[20..23] = { e10c8e23, f0bf03ef, c7c35eab, 6859e7ff }
        >SGPRS[24..27] = { 87d9f9ef, 80898fd1, fbb59c5e, 2b7da031 }
        >SGPRS[28..31] = { f1486304, 4c6b8e4c, bfbadc29, 78cb6f7f }
        >SGPRS[32..35] = { 284c53f0, 4d5cfb42, 87f22660, 54020e40 }
        >SGPRS[36..39] = { e1249273, b87ec734, 04924a4b, 74ad681f }
        >SGPRS[40..43] = { 0090e33a, 41128cb8, 33108784, 175e190b }
        >SGPRS[44..47] = { bde781b2, 3bcae8ff, fff606b4, 6416219c }
        >SGPRS[48..51] = { 9b749d57, ad7c93d6, c5d137be, ba13a44f }
        >SGPRS[52..55] = { 10e6786a, 4a00e133, 79cca9b3, d34f761d }
        >SGPRS[56..59] = { 6056be64, cc935d78, 7e3d9be6, 61bffbea }
        >SGPRS[60..63] = { f8a80840, 63a640e5, 931a1a97, 3e934a1b }
        >SGPRS[64..67] = { 6194dbd2, 3e0172c0, 4ef4f499, 804170e3 }
        >SGPRS[68..71] = { 48ef2829, 7f1f3dbc, 7ef4016c, 81c82da0 }
        >SGPRS[72..75] = { 1e380403, 5dfe32fd, 02191995, 80c7fbd0 }
        >SGPRS[76..79] = { ac1d913f, 1dba1b34, 62d0800a, 51ec2879 }
        >SGPRS[80..83] = { fa03b932, 5561f8cf, 9975fbdf, dd1799d7 }
        >SGPRS[84..87] = { 7cd53663, 1356f00d, 57fd9ad9, 3b98e8d9 }
        >SGPRS[88..91] = { ab8df7b6, feb7193e, a8c1abc3, 21ec7f7a }
        >SGPRS[92..95] = { 7920628e, 14152f3a, cbfb1bac, a0de6fa0 }
        >SGPRS[96..99] = { 46d0af4a, 4ca86000, c12630c8, ac840824 }
        >SGPRS[100..103] = { 44c5eb77, 867423d1, 17519bc9, b0d2fd0c }
        >SGPRS[104..107] = { 1c111970, 18cdad90, 00000001, 3602e720 }
        >SGPRS[108..111] = { 0a052f67, 0af54a85, 7c980c39, 8a4548c3 }
        >SGPRS[112..115] = { 0ca1ff7d, 17080276, 4f42fcf2, c5ef21fd }
        >SGPRS[116..119] = { 00000000, 00000000, ff8767bd, 6d61ff20 }
        >SGPRS[120..123] = { 58084bcf, 3afd54be, 20d30955, 354367e0 }
        >TTMP[0..3] = { 0a052f67, 0af54a85, 7c980c39, 8a4548c3 }
        >TTMP[4..7] = { 0ca1ff7d, 17080276, 4f42fcf2, c5ef21fd }
        >TTMP[8..11] = { 00000000, 00000000, ff8767bd, 6d61ff20 }
        >TTMP[12..15] = { 58084bcf, 3afd54be, 20d30955, 354367e0 }

        VGPRS:        t00      (t01)    (t02)    (t03)    (t04)    (t05)    (t06)    (t07)    (t08)    (t09)    (t10)    (t11)    (t12)    (t13)    (t14)    (t15)    (t16)    (t17)    (t18)    (t19)    (t20)    (t21)    (t22)    (t23)    (t24)    (t25)    (t26)    (t27)    (t28)    (t29)    (t30)    (t31)    (t32)    (t33)    (t34)    (t35)    (t36)    (t37)    (t38)    (t39)    (t40)    (t41)    (t42)    (t43)    (t44)    (t45)    (t46)    (t47)    (t48)    (t49)    (t50)    (t51)    (t52)    (t53)    (t54)    (t55)    (t56)    (t57)    (t58)    (t59)    (t60)    (t61)    (t62)    (t63)   
        [  0] = { 00000000 8a8711d0 3a98182a cb30eddc 57f1b34d 415dc31f 80864357 8f6a2dbf 7c1fe1bd d9a1d8dc f1621409 fc3855b6 0ea4477d 85def3bf 13a797ef 0fd645e4 e47bdf6f 1f09857d 53b8275b 3d19b17e 675fd9a9 6f110d10 74fcb157 1a8a0365 a6ff2074 36b69c53 d0a396d8 caab374c 93555037 a77bfece 40e70bf6 0995e6b4 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 }
        [  1] = { 66462e09 557fb7fb 78481fdc 1e5d3e2e 9cecdba7 a6a5ed6e ca7c50cd ff31989f 9ac0b8a7 1c1462ff c8482773 7d7ec412 7556cdc7 e8833537 1f097ce1 974caef3 bf6e0cfe 9e4dc203 f518b0dd 7e48719d 6563cc43 4d079ccb 313bf2e2 f368647f 4749c5ef 525c5d34 3bc96052 a74e57b3 ca799b7e 31dd7b0d 69519f7b d8b64354 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 }
        [  2] = { cb6e2889 d46cf0ca 312fe651 7ea00fc4 3f8d4361 7136b48d 1ff89b5f ca86c361 b5deae07 4beb7e6e 9f393f2e 6ef2b6e5 7cf3dc14 e458dd76 abaf647b b8b97cea f1c135f8 6703a72b d82aa7d0 8626fa99 9312f0ed 693af7c9 eb157a2d eeef35a4 788573ab 18f936cc c83c9dee 3345ef65 5ccd6efa 1b8a3876 9c8c6d43 35f402f5 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 }
        [  3] = { 53402807 d0e0d0b2 3f66456e ca6c7fd8 7e21f31a da3f6b7e 571752a9 f3052b4a f82c0577 5e793456 8a8bf1cf b87c660b 14e86ac5 0cec8ee5 ebf847ef 8d55afb6 c2514cac d8d16164 5129bfd0 ed86911e 19a8df0c 867af62f 425de0ef f28bb778 ebdd230a 2456ef13 b4738d07 d5af99fb 845a24e3 2792df80 6efb51d3 30b1bc60 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 }
        [  4] = { 2d755bc9 cd504991 f2fba4b1 6694f2bd 0b2552cc d272e6e5 7d62f948 019d3057 be67cb28 e3f8fb9d b67745c6 fc4caa7b 1e9302df fd543c8b 7105fad3 d117c9ab b8345b85 0d806740 e33d0755 9c529928 8315c7f9 ae025b08 20074ed3 fdd39d6a 5874b5ac da860d3b bf38fdb7 9edc16ee 69a13ce7 f67e3354 296af1ce 26b171a1 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 }
        [  5] = { c5814f87 6fb9f7b1 52722cb8 57e5ffa3 eb2e13d3 372b05e8 1e0df911 98a709e1 c63f0255 0bee21c6 6b2cd752 6259dde5 91f17da4 7ccf22b4 355b3b87 d413a9da 96e94cba 4582ed77 cc8c907f 4d2267c6 cc53cf6e d3e9341b ceb96958 6d66ec72 1cb7283b 6a2c9f1d 1e9bc8c3 c299b11d 65fdde88 f5b49d66 f80adecb 2c7b3bad 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 }
        [  6] = { ef41be24 46a573ee ca0f78b2 ada27082 5ce1202f dadf56f7 a46a39e6 9de56c14 99d84486 9f8b9904 63a16cd3 9e67251e 215ef836 2ebd3d5b 30df1e94 fce87a4e 350eba32 a8adcb7d d67cc8c3 79fcbe29 5dcd2c2c 0bd8db29 dd11a241 babbefcd 1adbb53b 948f6746 ee1b7486 22476304 a1ff7dd5 6a537d79 b910b159 1f5e90c5 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 }
        [  7] = { 6d8349dc 81da7823 97afb369 1b9a561b 2daad40a f1ccbd9e 36413da2 86289e70 a9fec2c6 7d1f1e69 61e82b47 4f9cf15b 2cafee53 7efc5e6c 7ec1878b 03ab6a4c 7ca47cbe b97a5a51 5b1b25ae de9c434f 3fc63e0b af71b09d 4191c2b7 cfd33e19 7eb7de3f 85a1c09f 20f726b2 9569f537 4a4d0458 d2e6c831 fb6786bc 27be3059 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 }


        PGM_MEM: (found shader at: 0@0x7a0944aa5600 of 12 bytes)
           Shader registers:
              gfx1201.regCOMPUTE_PGM_RSRC1(0@0x7a0944aa4540) == 0xe00f0000
              gfx1201.regCOMPUTE_PGM_RSRC2(0@0x7a0944aa4540) == 0x80
              gfx1201.regCOMPUTE_PGM_RSRC3(0@0x7a0944aa4540) == 0x0

            pgm[8@0x7a0944aa5600 + 0x0   ] = 0xbeea007e         s_mov_b32 vcc_lo, exec_lo                                       
          * pgm[8@0x7a0944aa5600 + 0x4   ] = 0xbfa4ffff         s_cbranch_vccnz 65535                                           
            pgm[8@0x7a0944aa5600 + 0x8   ] = 0xbfb00000         s_endpgm                                                        
        End of disassembly.

Here we see our test app is running a simple three opcode shader kernel that is programmed by an AQL packet at virtual address **0x7a0944aa5600**.

------------------------------------------------
Reading the Command Submission from a User Queue
------------------------------------------------

To read the command submission from a specific user queue, first bind with *--user-queue* or *-uq*, then either:

* use *--dump-uq* or *-du* to decode the bound queue’s buffer (no ring-path syntax), or
* use the normal ring-stream command *-RS* with ``uq`` as the ring name.

Both paths refuse to decode when the queue’s read and write pointers are equal (nothing queued between them); in that case pass *-O use_full_user_queue* so UMR reads the entire ring buffer.  Pointer read errors may improve with GFXOFF disabled (*-go 0*).

*--dump-uq* example:

::

        $ umr --user-queue client=20,queue=0 --dump-uq

*-RS* with the synthetic ``uq`` ring (same binding); ``[.]`` means from read pointer to write pointer:

::

        $ umr --user-queue client=20,queue=0 -RS uq[.]
        Decoding IB at 0x0@0x7a0823e00000 from 0x0@0x0 of 0 words (type 0)
        [0x0@0x7a0823e00000 + 0x0000]   [        0x00000b02]    Opcode 0x2 [HSA_KERNEL_DISPATCH] (32 words, type: 0, hdr: 0xb02)
        [0x0@0x7a0823e00000 + 0x0002]   [            0x0003]    |---> setup_dimensions=3
        [0x0@0x7a0823e00000 + 0x0004]   [            0x0001]    |---> workgroup_size_x=1
        [0x0@0x7a0823e00000 + 0x0006]   [            0x0001]    |---> workgroup_size_y=1
        [0x0@0x7a0823e00000 + 0x0008]   [            0x0001]    |---> workgroup_size_z=1
        [0x0@0x7a0823e00000 + 0x000a]   [            0x0000]    |---> reserved0=0
        [0x0@0x7a0823e00000 + 0x000c]   [        0x00000001]    |---> grid_size_x=1
        [0x0@0x7a0823e00000 + 0x0010]   [        0x00000001]    |---> grid_size_y=1
        [0x0@0x7a0823e00000 + 0x0014]   [        0x00000001]    |---> grid_size_z=1
        [0x0@0x7a0823e00000 + 0x0018]   [        0x00000000]    |---> private_segment_size=0
        [0x0@0x7a0823e00000 + 0x001c]   [        0x00000000]    |---> group_segment_size=0
        [0x0@0x7a0823e00000 + 0x0020]   [0x00007a0944aa4540]    |---> kernel_object=0x7a0944aa4540
        [0x0@0x7a0823e00000 + 0x0028]   [0x00007a0821e00000]    |---> kernarg_address=0x7a0821e00000
        [0x0@0x7a0823e00000 + 0x0030]   [0x0000000000000000]    |---> reserved2=0x0
        [0x0@0x7a0823e00000 + 0x0038]   [0x0000000000000000]    |---> completion_signal=0x0
        [0x0@0x7a0823e00000 + 0x0040]   [        0x00001503]    Opcode 0x3 [HSA_BARRIER_AND] (32 words, type: 0, hdr: 0x1503)
        [0x0@0x7a0823e00000 + 0x0042]   [            0x0000]    |---> reserved0=0
        [0x0@0x7a0823e00000 + 0x0044]   [        0x00000000]    |---> reserved1=0
        [0x0@0x7a0823e00000 + 0x0048]   [0x0000000000000000]    |---> dep_signal[0]=0x0
        [0x0@0x7a0823e00000 + 0x0050]   [0x0000000000000000]    |---> dep_signal[1]=0x0
        [0x0@0x7a0823e00000 + 0x0058]   [0x0000000000000000]    |---> dep_signal[2]=0x0
        [0x0@0x7a0823e00000 + 0x0060]   [0x0000000000000000]    |---> dep_signal[3]=0x0
        [0x0@0x7a0823e00000 + 0x0068]   [0x0000000000000000]    |---> dep_signal[4]=0x0
        [0x0@0x7a0823e00000 + 0x0070]   [0x0000000000000000]    |---> reserved2=0x0
        [0x0@0x7a0823e00000 + 0x0078]   [0x00007a093a1fd600]    |---> completion_signal=0x7a093a1fd600
        Done decoding IB

        Shader from 0x0@[0x7a0823e00000 + 0x0] at 0x0@0x7a0944aa5600, type COMPUTE (2), size 12
        Shader registers (unfiltered):
                gfx1201.regCOMPUTE_PGM_RSRC1(0@0x7a0944aa4540) == 0xe00f0000
                gfx1201.regCOMPUTE_PGM_RSRC2(0@0x7a0944aa4540) == 0x80
                gfx1201.regCOMPUTE_PGM_RSRC3(0@0x7a0944aa4540) == 0x0

        Shader program:
        pgm[0@0x7a0944aa5600 + 0x0   ] = 0xbeea007e         s_mov_b32 vcc_lo, exec_lo
        pgm[0@0x7a0944aa5600 + 0x4   ] = 0xbfa4ffff         s_cbranch_vccnz 65535
        pgm[0@0x7a0944aa5600 + 0x8   ] = 0xbfb00000         s_endpgm
        Done disassembly of shader

        KERNEL_DISPATCH kernarg (size 0 bytes) from AQL packet 0x0@[0x7a0823e00000 + 0x0]:
        End of kernarg.

Here we see the command submission is a simple three opcode shader kernel that is programmed by an AQL packet at virtual address **0x7a0823e00000**.  We can
see the command processor hasn't finished this packet (because the kernel is a never ending loop) and the next packet is a barrier AND operation.

------------------
VMID specification
------------------

When UMR binds to a client space it no longer reads virtual memory page table configurations out of MMIO registers.
But for the lack of inventing a new syntax you must still specify a VMID to commands that need it.  It's ignored
other than to acknowledge UMR isn't performing a linear access.

For instance:

::

    $ umr --user-queue kfd,comm=test,queue=0 -vr 0@0x7fb2a928a080 8 | xxd -e
    00000000: 00000001 00000000                     ........

Is reading the *hqd_rptr_addr* of a test application using a KFD client.  We could just as easily specify any (8-bit) VMID
value here.