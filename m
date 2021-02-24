Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF36732365B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Feb 2021 05:05:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1382A100F2245;
	Tue, 23 Feb 2021 20:05:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CC522100EF25B
	for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 20:05:42 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v22so777490edx.13
        for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 20:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hmwsW/hf6/2eNzJ4EGL8BqxVfyFIYIQmZsJ1d9wI35s=;
        b=V2OwGNpjZM3cH+Ci1gP9V+sU0EEQLoI8bMChDK6jv/XeY+2prCQEhzVTk3OiOcpO4X
         FG6fepE7DKhQWWNJQB4PN5nzUd8Z4f+3g6WpAGoTHev0uGpt4LGdZXrmOecbK/IkZIyX
         fBuRmeRZbdHp7EXBsfJOUrWvVt5H44gLttBjCFMm7G4237ZsmZCrWSceYgt3K0FOZTtN
         fL52IdG+ooqOL/TiDnhKsXn/VHZIQYACBKkC1IiE0QTl4+fNgmyquSLbAzM+LSilIshg
         UVrEHp8AvmFt5kNYZE1SZ4VhZTwxVmgcZW2/FY/YY2mbjMzNOnuSOQCvdVr24a6rd7w0
         Ug2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hmwsW/hf6/2eNzJ4EGL8BqxVfyFIYIQmZsJ1d9wI35s=;
        b=ILdmRDHRCmeyyW+9GHHHlpAvc99Jc8EgFFMTkS+dbExBU+GZvLuUMrSa9rn9jeN/5L
         tSULGeOZ4DXnKK3f6sqEX+KrZMYJyJ6y1ZhuzrZi4NFGRh48l3vrRvfqXJANt8ro5IRy
         uQjpWruCxpKsnQBJZXj1865v2sx/ZzRFquL0vabgsxKllyj6zYH19pZ4ABq2GD3R4Z43
         fOyA30Bqa4UYbI7OlhwwDmsjwbfGziO+xB0N/9kjkWYI0BrcbCeKx9ot+oNqshVowhFt
         V+mFbPEA5WFoV/Q6xOGyS3v6lSsU+K25VgMEE4SpYQbq8GO7uZnk12t8pJTsAXepX+Gr
         r/aA==
X-Gm-Message-State: AOAM533k6FG2hbSzgj3cBNXFTRg+1QhtvOiUNBnqT2LjkxHtepGvpn1c
	zxVWJecpnzpv1kc3YfHeJjCXmXbeyF3D+0oO3o3w2g==
X-Google-Smtp-Source: ABdhPJyyMXiElO804i+nVnIKVghScSNY8WXhEcoxqmt+bxh74dj5khIOevOokzp6nvoTt0Vm4in3WgBzIM7gGBXJHZE=
X-Received: by 2002:aa7:d315:: with SMTP id p21mr29659333edq.300.1614139540770;
 Tue, 23 Feb 2021 20:05:40 -0800 (PST)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Feb 2021 20:05:36 -0800
Message-ID: <CAPcyv4gsXbi6Cc71wW5hob8mGuupXKkL5tHLRaZkdLZ1oAuK8Q@mail.gmail.com>
Subject: [GIT PULL] Compute Express Linux (CXL) for v5.12-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: ODA4NQEHWYWP73HYW6EEML4P45HVOQ2H
X-Message-ID-Hash: ODA4NQEHWYWP73HYW6EEML4P45HVOQ2H
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ODA4NQEHWYWP73HYW6EEML4P45HVOQ2H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/cxl-for-5.12

...to receive an initial driver for CXL 2.0 Memory Devices. Technical
details are in the tag message and Documentation/. I am taking this
through nvdimm.git this first cycle until the cxl.git repository and
maintainer team can be set up on git.kernel.org.

In terms of why merge this initial driver now, it establishes just
enough functionality to enumerate these devices and issue all
administrative commands. It sets a v5.12 baseline to develop the more
complicated higher order functionality like memory device
interleaving, persistent memory support, and hotplug which entangle
with ACPI, LIBNVDIMM, and PCI.

The focus of this release is establishing the ioctl UAPI for the
management commands. Similar to NVME there are a set of standard
commands as well as the possibility for vendor specific commands.
Unlike the NVME driver the CXL driver does not enable vendor specific
command functionality by default. This conservatism is out of concern
for the fact that CXL interleaves memory across devices and implements
host memory. The system integrity implications of some commands are
more severe than NVME and vendor specific functionality is mostly
unauditable. This will be an ongoing topic of discussion with the
wider CXL community for next few months.

The driver has been developed in the open since November against a
work-in-progress QEMU emulation of the CXL device model. That QEMU
effort has recently attracted contributions from multiple hardware
vendors.

The driver has appeared in -next. It collected some initial static
analysis fixes and build-robot reports, but all quiet in -next for the
past week.

A list of review tags that arrived after the branch for -next was cut
is appended to the tag message below.

---

The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/cxl-for-5.12

for you to fetch changes up to 88ff5d466c0250259818f3153dbdc4af1f8615dd:

  cxl/mem: Fix potential memory leak (2021-02-22 14:44:39 -0800)

----------------------------------------------------------------
cxl for 5.12

Introduce an initial driver for CXL 2.0 Type-3 Memory Devices. CXL is
Compute Express Link which released the 2.0 specification in November.
The Linux relevant changes in CXL 2.0 are support for an OS to
dynamically assign address space to memory devices, support for
switches, persistent memory, and hotplug. A Type-3 Memory Device is a
PCI enumerated device presenting the CXL Memory Device Class Code and
implementing the CXL.mem protocol. CXL.mem allows device to advertise
CPU and I/O coherent memory to the system, i.e. typical "System RAM" and
"Persistent Memory" in Linux /proc/iomem terms.

In addition to the CXL.mem fast path there is an administrative command
hardware mailbox interface for maintenance and provisioning. It is this
command interface that is the focus of the initial driver. With this
driver a CXL device that is mapped by the BIOS can be administered by
Linux. Linux support for CXL PMEM and dynamic CXL address space
management are to be implemented post v5.12.

4cdadfd5e0a7 cxl/mem: Introduce a driver for CXL-2.0-Type-3 endpoints
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

8adaf747c9f0 cxl/mem: Find device capabilities
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

b39cb1052a5c cxl/mem: Register CXL memX devices
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

13237183c735 cxl/mem: Add a "RAW" send command
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

472b1ce6e9d6 cxl/mem: Enable commands via CEL
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

57ee605b976c cxl/mem: Add set of informational commands
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

----------------------------------------------------------------
Ben Widawsky (7):
      cxl/mem: Find device capabilities
      cxl/mem: Add basic IOCTL interface
      cxl/mem: Add a "RAW" send command
      cxl/mem: Enable commands via CEL
      cxl/mem: Add set of informational commands
      MAINTAINERS: Add maintainers of the CXL driver
      cxl/mem: Fix potential memory leak

Dan Carpenter (1):
      cxl/mem: Return -EFAULT if copy_to_user() fails

Dan Williams (2):
      cxl/mem: Introduce a driver for CXL-2.0-Type-3 endpoints
      cxl/mem: Register CXL memX devices

 .clang-format                                      |    1 +
 Documentation/ABI/testing/sysfs-bus-cxl            |   26 +
 Documentation/driver-api/cxl/index.rst             |   12 +
 Documentation/driver-api/cxl/memory-devices.rst    |   46 +
 Documentation/driver-api/index.rst                 |    1 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 MAINTAINERS                                        |   11 +
 drivers/Kconfig                                    |    1 +
 drivers/Makefile                                   |    1 +
 drivers/cxl/Kconfig                                |   53 +
 drivers/cxl/Makefile                               |    7 +
 drivers/cxl/bus.c                                  |   29 +
 drivers/cxl/cxl.h                                  |   95 ++
 drivers/cxl/mem.c                                  | 1552 ++++++++++++++++++++
 drivers/cxl/pci.h                                  |   31 +
 include/linux/pci_ids.h                            |    1 +
 include/uapi/linux/cxl_mem.h                       |  172 +++
 17 files changed, 2040 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-cxl
 create mode 100644 Documentation/driver-api/cxl/index.rst
 create mode 100644 Documentation/driver-api/cxl/memory-devices.rst
 create mode 100644 drivers/cxl/Kconfig
 create mode 100644 drivers/cxl/Makefile
 create mode 100644 drivers/cxl/bus.c
 create mode 100644 drivers/cxl/cxl.h
 create mode 100644 drivers/cxl/mem.c
 create mode 100644 drivers/cxl/pci.h
 create mode 100644 include/uapi/linux/cxl_mem.h
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
