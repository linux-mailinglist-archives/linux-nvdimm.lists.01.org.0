Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8976619A7A9
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 10:48:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D04410FC377E;
	Wed,  1 Apr 2020 01:48:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4543F10FC3614
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 01:48:53 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id v1so28669121edq.8
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 01:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=27j6VOHEN5abqfLUwHu2SUdHdnQ7RO6LLcreMfYvKIk=;
        b=0aOYzkkFCHlhPPBSFA9ftRmMVqxIUoVOZ2nuK2tuzZLn/kJodwKhEEmUJwySyzIf+V
         47ggJtw8A1kYuN6XYtPYA1OIssdKIJLJkEixjaZeZpRLmn+OszOv4cighkQWl3rNzmsa
         Jg2aQsBo6oLYT1bRfTHInLtN2VKfWadiPZCSQ4fnwwKRLJ+vEVc5MGc/uLz4NmjSk0BT
         I9qcv4YTCddWd2WpEn1jbSQ50M8HFFqkdgxFuvffbVW4KlgvXXolmSah8i1pz3NjaHkH
         WSktk/+rkEmBYReTN2jA1dg5gv9kj65r/x3se8c3vkQ8wFpYyGmAkJJuGyEeBDyiEWXm
         z5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=27j6VOHEN5abqfLUwHu2SUdHdnQ7RO6LLcreMfYvKIk=;
        b=fZRugxUNUTILFF/023NE9X5Yt188gfNS0eO0OoOq7W1lCdsX1xZcpCQSXLFInWMCai
         oBiSf9apic8A9y+/q6YHrnmNEMQI070RnxrlLV/a1GhFcAzdUcLwvPRZmIawBnHwV9jb
         Q3TNkRH9ZaAfzXnDCxDUoONUXfFVrsj/T+etApmF0t5W/dFGnlLeT4FP7MsnzhdZz+w2
         ATKeiB/Lk9pyV8t7U5ne1jIrk9lfuZXIP4VB9lUSP8Smfv31Em+2hRQOMXENDW4ISiKf
         hT3xraKJ/Z/dw/QOeALjvsKLNmacOZGqK0IRjgi4BFtpISl3vz35H01MWTn+LxGyXJwT
         fIJw==
X-Gm-Message-State: ANhLgQ2KaZdWUdnZnkQL1XajHw1+6S1gE8nsPYq8dbCxnaBUf2uEB3ih
	yPLVGOSEOmLYs3Aa835mxMM+ZBHOiaDPTsLhssb2Zw==
X-Google-Smtp-Source: ADFU+vskHWy2y5NskM/bhRbptM3/aO8iMNCLTQ/IJ5NKTHGIF9YrarhvDoWkU6lHQARpkNrTguWMRaS25XopBDw6Q+A=
X-Received: by 2002:a05:6402:3044:: with SMTP id bu4mr20556399edb.123.1585730882014;
 Wed, 01 Apr 2020 01:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2020 01:47:50 -0700
Message-ID: <CAPcyv4iJYZBVhV1NW7EB6-EwETiUAy6r1iiE+F+HvFXfGZt9Aw@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] Add support for OpenCAPI Persistent Memory devices
To: "Alastair D'Silva" <alastair@d-silva.org>
Message-ID-Hash: 35FZJ3FDYECPKOZZDTCK7CQHIE7ODONW
X-Message-ID-Hash: 35FZJ3FDYECPKOZZDTCK7CQHIE7ODONW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/35FZJ3FDYECPKOZZDTCK7CQHIE7ODONW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> This series adds support for OpenCAPI Persistent Memory devices on bare metal (arch/powernv), exposing them as nvdimms so that we can make use of the existing infrastructure. There already exists a driver for the same devices abstracted through PowerVM (arch/pseries): arch/powerpc/platforms/pseries/papr_scm.c
>
> These devices are connected via OpenCAPI, and present as LPC (lowest coherence point) memory to the system, practically, that means that memory on these cards could be treated as conventional, cache-coherent memory.
>
> Since the devices are connected via OpenCAPI, they are not enumerated via ACPI. Instead, OpenCAPI links present as pseudo-PCI bridges, with devices below them.
>
> This series introduces a driver that exposes the memory on these cards as nvdimms, with each card getting it's own bus. This is somewhat complicated by the fact that the cards do not have out of band persistent storage for metadata, so 1 SECTION_SIZE's (see SPARSEMEM) worth of storage is carved out of the top of the card storage to implement the ndctl_config_* calls.

Is it really tied to section-size? Can't that change based on the
configured page-size? It's not clear to me why that would be the
choice, but I'll dig into the implementation.

> The driver is not responsible for configuring the NPU (NVLink Processing Unit) BARs to map the LPC memory from the card into the system's physical address space, instead, it requests this to be done via OPAL calls (typically implemented by Skiboot).

Are OPAL calls similar to ACPI DSMs? I.e. methods for the OS to invoke
platform firmware services? What's Skiboot?

>
> The series is structured as follows:
>  - Required infrastructure changes & cleanup
>  - A minimal driver implementation
>  - Implementing additional features within the driver

Thanks for the intro and the changelog!

>
> Changelog:
> V4:
>   - Rebase on next-20200320

Do you have dependencies on other material that's in -next? Otherwise
-next is only a viable development baseline if you are going to merge
through Andrew's tree.

>   - Bump copyright to 2020
>   - Ensure all uapi headers use C89 compatible comments (missed ocxlpmem.h)
>   - Move the driver back to drivers/nvdimm/ocxl, after confirmation
>     that this location is desirable
>   - Rename ocxl.c to ocxlpmem.c (+ support files)
>   - Rename all ocxl_pmem to ocxlpmem
>   - Address checkpatch --strict issues
>   - "powerpc/powernv: Add OPAL calls for LPC memory alloc/release"
>         - Pass base address as __be64
>   - "ocxl: Tally up the LPC memory on a link & allow it to be mapped"
>         - Address checkpatch spacing warnings
>         - Reword blurb
>         - Reword size description for ocxl_link_add_lpc_mem()
>         - Add an early exit in ocxl_link_lpc_release() to avoid triggering
>           bogus warnings if called after ocxl_link_lpc_map() fails
>   - "powerpc/powernv: Add OPAL calls for LPC memory alloc/release"
>         - Reword blurb
>   - "powerpc/powernv: Map & release OpenCAPI LPC memory"
>         - Reword blurb
>   - Move minor_idr init from file_init() to ocxlpmem_init() (fixes runtime error
>     in "nvdimm: Add driver for OpenCAPI Persistent Memory")
>   - Wrap long lines
>   - "nvdimm: Add driver for OpenCAPI Storage Class Memory"
>         - Remove '+ 1' workround from serial number->cookie assignment
>         - Drop out of memory message for ocxlpmem in probe()
>         - Fix leaks of ocxlpmem & ocxlpmem->ocxl_fn in probe()
>         - remove struct ocxlpmem_function0, it didn't value add
>         - factor out err_unregistered label in probe
>         - Address more checkpatch warnings
>         - get/put the pci dev on probe/free
>         - Drop ocxlpmem_ prefix from static functions
>         - Propogate errors up from called functions in probe()
>         - Set MODULE_LICENSE to GPLv2
>         - Add myself as module author
>         - Call nvdimm_bus_unregister() in remove() to release references
>         - Don't call devm_memunmap on metadata_address, the release handler on
>          the device already deals with this
>   - "nvdimm/ocxl: Read the capability registers & wait for device ready"
>         - Fix mask for read_latency
>         - Fold in is_usable logic into timeout to remove error message race
>         - propogate bad rc from read_device_metadata
>   - "nvdimm/ocxl: Add register addresses & status values to the header"
>         - Add comments for register abbreviations where names have been
>           expanded
>         - Add missing status for blocked on background task
>         - Alias defines for firmware update status to show that the duplication
>           of values is intentional
>   - "nvdimm/ocxl: Register a character device for userspace to interact with"
>         - Add lock around minors IDR, delete the cdev before device_unregister
>         - Propogate errors up from called functions in probe()
>   - "nvdimm/ocxl: Add support for Admin commands"
>         - Fix typo in setup_command_data error message, and drop 'ocxl' from it
>         - Drop vestigial CHI read from admin_command_request
>         - Change command ID mismatch message to dev_err, and return an error
>         - Use jiffies to implement admin_command_complete_timeout()
>         - Flesh out blurb
>         - Create a wrapper to issue the command & wait for timeout
>   - "nvdimm/ocxl: Add support for near storage commands"
>         - dropped (will submit with the patches for nvdimm overwrite)
>   - "nvdimm/ocxl: Implement the Read Error Log command"
>         - Remove stray blank line
>         - change misplaced goto to an early exit in read_error_log
>         - Inline error_log_offset_0x08
>         - Read WWID data as LE rather than host endian
>         - Move the include of nvdimm/ocxlpmem.h to ocxl.c
>         - Add padding after fwrevision in struct ioctl_ocxl_pmem_error_log
>         - Register IOCTL magic
>         - Coerce pointers to __u64 in IOCTLs
>   - "nvdimm/ocxl: Add controller dump IOCTLs"
>         - Coerce pointers to __u64 in IOCTLs
>         - Document expected IOCTL usage in blurb
>         - Add missing rc check
>         - Only populate up to the number of bytes returned by the card,
>           and return this length to the caller
>         - Add missing header check
>   - "nvdimm/ocxl: Add an IOCTL to report controller statistics"
>         - Update to match the latest version of the spec
>         - Verify that parametr block IDs & lengths match what we expect
>         - Use defines for offsets
>   - "nvdimm/ocxl: Forward events to userspace"
>         - Don't enable NSCRA doorbell
>         - return -EBUSY if the event context is already used
>         - return -ENODEV if IRQs cannot be mapped
>         - Tag IRQ pointers with __iomem
>         - Drop ocxlpmem_ prefix from static functions
>         - Propogate error from eventfd_ctx_fdget
>         - Fix error check in copy_to_user
>         - Drop GLOBAL_MMIO_CHI_NSCRA (this should be in the overwrite patch)
>         - Drop unused irq_pgmap
>         - Don't redef BIT_ULL
>   - "nvdimm/ocxl: Add debug IOCTLs"
>         - Eliminate clearing loop (now done in admin_command_execute()
>         - Drop dummy IOCTLs if CONFIG_OCXL_PMEM_DEBUG is not set
>         - Group debug IOCTLs together & comment that they may not be available
>   - "nvdimm/ocxl: Expose SMART data via ndctl"
>         - Drop 'rc = 0; goto out;'
>         - Propogate errors from ndctl_smart()
>   - "nvdimm/ocxl: Expose the serial number in sysfs" & "nvdimm/ocxl: Expose the firmware version in sysfs"
>         - Squash these 2 patches together
>         - Expose data as a DIMM attribute rather than an ocxlpmem
>           attribute
>   - "nvdimm/ocxl: Add an IOCTL to request controller health & perf data"
>         - Reword blurb
>   - "nvdimm/ocxl: Implement the heartbeat command"
>         - Propogate rc in probe()
>
> V3:
>   - Rebase against next/next-20200220
>   - Move driver to arch/powerpc/platforms/powernv, we now expect this
>     driver to go upstream via the powerpc tree
>   - "nvdimm/ocxl: Implement the Read Error Log command"
>         - Fix bad header path
>   - "nvdimm/ocxl: Read the capability registers & wait for device ready"
>         - Fix overlapping masks between readiness_timeout & memory_available_timeout
>   - "nvdimm: Add driver for OpenCAPI Storage Class Memory"
>         - Address minor review comments from Jonathan Cameron
>         - Remove attributes
>         - Default to module if building LIBNVDIMM
>         - Propogate errors up from called functions in probe()
>   - "nvdimm/ocxl: Expose SMART data via ndctl"
>         - Pack attributes in struct
>         - Support different size SMART buffers for compatibility with newer
>           ndctls that may want more SMART attribs than we provide
>         - Rework to to use ND_CMD_CALL instead of ND_CMD_SMART
>   - drop "ocxl: Free detached contexts in ocxl_context_detach_all()"
>   - "powerpc: Map & release OpenCAPI LPC memory"
>         - Remove 'extern'
>         - Only available with CONFIG_MEMORY_HOTPLUG_SPARSE
>   - "ocxl: Tally up the LPC memory on a link & allow it to be mapped"
>         - Address minor review comments from Jonathan Cameron
>   - "ocxl: Add functions to map/unmap LPC memory"
>         - Split detected memory message into a separate patch
>         - Address minor review comments from Jonathan Cameron
>         - Add a comment explaining why unmap_lpc_mem is in deconfigure_afu
>   - "nvdimm/ocxl: Add support for Admin commands"
>         - use sizeof(u64) rather than 0x08 when iterating u64s
>   - "nvdimm/ocxl: Implement the heartbeat command"
>         - Fix typo in blurb
>   - Address kernel doc issues
>   - Ensure all uapi headers use C89 compatible comments
>   - Drop patches for firmware update & overwrite, these will be
>     submitted later once patches are available for ndctl
>   - Rename SCM to OpenCAPI Persistent Memory
>
> V2:
>   - "powerpc: Map & release OpenCAPI LPC memory"
>       - Fix #if -> #ifdef
>       - use pci_dev_id to get the bdfn
>       - use __be64 to hold be data
>       - indent check_hotplug_memory_addressable correctly
>       - Remove export of check_hotplug_memory_addressable
>   - "ocxl: Conditionally bind SCM devices to the generic OCXL driver"
>       - Improve patch description and remove redundant default
>   - "nvdimm: Add driver for OpenCAPI Storage Class Memory"
>       - Mark a few funcs as static as identified by the 0day bot
>       - Add OCXL dependancies to OCXL_SCM
>       - Use memcpy_mcsafe in scm_ndctl_config_read
>       - Rename scm_foo_offset_0x00 to scm_foo_header_parse & add docs
>       - Name DIMM attribs "ocxl" rather than "scm"
>       - Split out into base + many feature patches
>   - "powerpc: Enable OpenCAPI Storage Class Memory driver on bare metal"
>       - Build DEV_DAX & friends as modules
>   - "ocxl: Conditionally bind SCM devices to the generic OCXL driver"
>       - Patch dropped (easy enough to maintain this out of tree for development)
>   - "ocxl: Tally up the LPC memory on a link & allow it to be mapped"
>       - Add a warning if an unmatched lpc_release is called
>   - "ocxl: Add functions to map/unmap LPC memory"
>       - Use EXPORT_SYMBOL_GPL
>
>
> Alastair D'Silva (25):
>   powerpc/powernv: Add OPAL calls for LPC memory alloc/release
>   mm/memory_hotplug: Allow check_hotplug_memory_addressable to be called
>     from drivers
>   powerpc/powernv: Map & release OpenCAPI LPC memory
>   ocxl: Remove unnecessary externs
>   ocxl: Address kernel doc errors & warnings
>   ocxl: Tally up the LPC memory on a link & allow it to be mapped
>   ocxl: Add functions to map/unmap LPC memory
>   ocxl: Emit a log message showing how much LPC memory was detected
>   ocxl: Save the device serial number in ocxl_fn
>   nvdimm: Add driver for OpenCAPI Persistent Memory
>   powerpc: Enable the OpenCAPI Persistent Memory driver for
>     powernv_defconfig
>   nvdimm/ocxl: Add register addresses & status values to the header
>   nvdimm/ocxl: Read the capability registers & wait for device ready
>   nvdimm/ocxl: Add support for Admin commands
>   nvdimm/ocxl: Register a character device for userspace to interact
>     with
>   nvdimm/ocxl: Implement the Read Error Log command
>   nvdimm/ocxl: Add controller dump IOCTLs
>   nvdimm/ocxl: Add an IOCTL to report controller statistics
>   nvdimm/ocxl: Forward events to userspace
>   nvdimm/ocxl: Add an IOCTL to request controller health & perf data
>   nvdimm/ocxl: Implement the heartbeat command
>   nvdimm/ocxl: Add debug IOCTLs
>   nvdimm/ocxl: Expose SMART data via ndctl
>   nvdimm/ocxl: Expose the serial number & firmware version in sysfs
>   MAINTAINERS: Add myself & nvdimm/ocxl to ocxl
>
>  .../userspace-api/ioctl/ioctl-number.rst      |    1 +
>  MAINTAINERS                                   |    3 +
>  arch/powerpc/configs/powernv_defconfig        |    5 +
>  arch/powerpc/include/asm/opal-api.h           |    2 +
>  arch/powerpc/include/asm/opal.h               |    2 +
>  arch/powerpc/include/asm/pnv-ocxl.h           |   42 +-
>  arch/powerpc/platforms/powernv/ocxl.c         |   43 +
>  arch/powerpc/platforms/powernv/opal-call.c    |    2 +
>  drivers/misc/ocxl/config.c                    |   74 +-
>  drivers/misc/ocxl/core.c                      |   61 +
>  drivers/misc/ocxl/link.c                      |   60 +
>  drivers/misc/ocxl/ocxl_internal.h             |   45 +-
>  drivers/nvdimm/Kconfig                        |    2 +
>  drivers/nvdimm/Makefile                       |    1 +
>  drivers/nvdimm/ocxl/Kconfig                   |   21 +
>  drivers/nvdimm/ocxl/Makefile                  |    7 +
>  drivers/nvdimm/ocxl/main.c                    | 1975 +++++++++++++++++
>  drivers/nvdimm/ocxl/ocxlpmem.h                |  197 ++
>  drivers/nvdimm/ocxl/ocxlpmem_internal.c       |  280 +++
>  include/linux/memory_hotplug.h                |    5 +
>  include/misc/ocxl.h                           |  122 +-
>  include/uapi/linux/ndctl.h                    |    1 +
>  include/uapi/nvdimm/ocxlpmem.h                |  127 ++
>  mm/memory_hotplug.c                           |    4 +-
>  24 files changed, 2983 insertions(+), 99 deletions(-)
>  create mode 100644 drivers/nvdimm/ocxl/Kconfig
>  create mode 100644 drivers/nvdimm/ocxl/Makefile
>  create mode 100644 drivers/nvdimm/ocxl/main.c
>  create mode 100644 drivers/nvdimm/ocxl/ocxlpmem.h
>  create mode 100644 drivers/nvdimm/ocxl/ocxlpmem_internal.c
>  create mode 100644 include/uapi/nvdimm/ocxlpmem.h
>
> --
> 2.24.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
