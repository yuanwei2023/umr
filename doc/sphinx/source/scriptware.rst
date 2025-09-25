===================
Scriptware Commands
===================

UMR provides a variety of 'scriptware' commands that make writing shell scripts
around UMR easier.  They are all invoked with the *--script* command and take a
variable number of arguments per command.

---------
instances
---------

The *instances* command lists all of the available AMDGPU DRI instances in the
system in space delimited format.

::

    $ umr --script instances
    1 2

In this example instance 1 and 2 are valid AMDGPU devices.  This can be used in for instance
a bash 'for' loop to iterate over all of the AMDGPU devices.

::

    $ for i in `umr --script instances`; do umr -i ${i} -r *.*.RB_BASE; done

Would read any registers matching the partial text RB_BASE from every AMDGPU device in the system.

-------------
pci-instances
-------------

This command lists all of the AMDGPU instances that match a given PCI device ID (did) in space delimited format.

::

    $ umr --script pci-instances 0x7448
    1

Indicates that only device instance 1 has the PCI device ID of 0x7448.

-------
pci-did
-------

This command outputs the PCI device ID of a given DRI instance device.

::

    $ umr --script pci-did 1
    0x7448

-------
pci-bus
-------

This command outputs the PCI bus address given a DRI instance as input.

::

    $ umr --script pci-bus 1
    0000:03:00.0

-------------------
pci-bus-to-instance
-------------------

This command translates a PCI bus address back to a DRI instance number.  Useful when
logs emit the PCI bus address but not the DRI instance.

::

    $ umr --script pci-bus-to-instance 0000:03:00.0
    1


------------------
pci-bus-to-instxcc
------------------

This command translates a PCI bus address that also includes the XCC id encoded as a the PCI bus function
back to a DRI instance number.  Useful when logs emit the PCI bus address but not the DRI instance.

::

    $ umr --script pci-bus-to-instxcc 0000:03:00.2
    -i 1 -vmp 2

Because this command outputs two values it also includes the umr command line syntax to specify them.

----
xcds
----

This command lists all of the XCDs of a given ASIC (the parameter you pass into -vmp when selecting
a GC or MMHUB instance) in space delimited format.  If the device has no partitioning it will emit -1 to
be compatible with the *-vmp* input required on those hosts.

::

    $ umr --script xcds 1
    -1

In this case this device has only one GC and no partitioning so it emits -1.

-------
gfxname
-------

This command emits the IP name of the GC (gfx) block for a given DRI instance.

::

    $ umr --script gfxname 1
    gfx1100

Which is useful if you want to read only from GC blocks in a script.  On partitioned hosts
this will not emit any curly brace syntax.

