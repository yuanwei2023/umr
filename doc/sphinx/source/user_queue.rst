===========
User Queues
===========

UMR supports the ability to bind to both KFD and KGD client user queues.  By doing this,
UMR adopts the client virtual memory space and can not only decode packets from the queues
but also support virtual memory commands (such as *-vm*, *-vr*, *-vdis*, *--dump-ib*, etc).

--------------
Kernel Support
--------------

**NOTE:** User queue support in UMR is a relatively new feature requiring kernel support for the
debugfs interfaces used to attach to a clients virtual memory space.  These features were added to the
AMD's linux tree in late August 2025.  If you are using an upstream kernel (likely pre 6.17) chances
are you do not have the functionality required unless you fetch a Linux kernel that has these patches.

UMR should print out error messages if it can't open the requisite client files from debugfs.  If this happens
it means your kernel lacks the patches required.

--------------
Queue Bindings
--------------

To bind to a queue you have to specify a client string which is a comma separated list of
three things: (optionally) a client type, a client identifier, and a queue identifier.

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

For example the string: kfd,comm=ollama,queue=2 would tell umr to bind to the first instance of the
application 'ollama' that is running with a KFD client, and then to the queue #2 of that client.

------------------
Binding to a queue
------------------

To use user queues you must specify the *--user-queue* command:

::

    $ umr --user-queue kfd,comm=ollama,queue=2

After this commands that use the clients virtual memory space or access the queues themselves
(such as *--dump-uq*) can be used.

-------------------------------
Printing User Queue Information
-------------------------------

To print out information about the user queues in a given a client the *--print-uq* command can
be used.

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
along with associated paramaterS (levels, block size, etc).

In each queue we also see a variety of parameters that are useful.  For simplicity sake the register names
are left as the GFX queue versions but they serve similar purposes.  The *hqd_base_addr* represents the virtual
address of the queue's ring buffer.  The *hqd_rptr_addr* and *rb_wptr_poll_addr* represent the virtual
addresses of the queues read and write pointers respectively.  Here we see the read pointer is at virtual
address **0x752248514080** and currently has the value **0xe8a4**.

For each queue we also get a complete dump of the MQD (memory queue descriptor).

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