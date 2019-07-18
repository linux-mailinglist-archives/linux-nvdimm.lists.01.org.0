Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 706336CF89
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 16:16:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F0410212CFEBD;
	Thu, 18 Jul 2019 07:19:22 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3FA49212CFEAC
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 07:19:21 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id j11so4939545otp.10
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=RwpnZ/oYArVLKO1FOa0zkV+rIVwJ+6+HIwfsxFdupWs=;
 b=W8sPtuhs0XYA3yVl25QJblCCOLf59FqZ8LL+DoHIc0yvkazbLQZCN3mIP185ktOrtw
 RrZvReTlY2b2kXUGci9xvRh2Sw8VSICp7oKsf2MsCvQ46r47Wd9eyksSn2VoUw1wkqea
 VQG6gNCEh15o0VRH9XrQmpdItVep31fMjxygzk0q14RO8+z4SktKfgNofQlV6VwTVgK4
 5BSaBazfdkk3uZj+LirLot8dfN71GXNgsVgiwvwwvbc8NeMmo1eeP9Rp0u0RrSMqxfQI
 Ce/qPBM9C2bAK7YJ9UZqHSH6VO8AC5PS+AJUBR3LV8Y76Pxv6o89epff2ihtDTv5HWFd
 Ywow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=RwpnZ/oYArVLKO1FOa0zkV+rIVwJ+6+HIwfsxFdupWs=;
 b=JkiRO0RBAtkMx/p9XsF8XpB0/yTWeNcgXgFDvFM8LHDw57dLYZnHZAwj+R7KKmZ2eb
 cIwqD1bEUnEEPDLBYQQWh/TdONlRLpAV+BlK5CFDVMOL3mWq1ViqmsBrqGLP48Puih0q
 88OZT9OWytAjtVLbv5m4dCeXmE1ITQcwtqeVrDMsF3k4ufR4WuDPHhxwWNCDOTjMZVim
 BIawuZTkQqHwsk1QHSxrYu6DKFgJKsDTgkXlxusB8PwphI9ZqbU8Y+jj45B56JeMWQ9c
 JLOR49gQxbjJps/uw98LjZGXO3ZLNOFn22sDtw7hu4goqG/w4VsxPnIR7k+vvC0BXYqC
 qvpg==
X-Gm-Message-State: APjAAAUl/bCfOAutnm16+PVgkbayzdAmwLZ4hms7LT2gmHDw9k2ORaME
 hTbiu6Kb6MCzzdr74Kl6gnmFHOFGhC6nODykVQcznQ==
X-Google-Smtp-Source: APXvYqyoP5GJxKjG9yqXUy0a6+m6CJdrkTAwTJlxCLi1DF02tSRMO8QPtauzgaksegMMK6qPttHmI7N0dt209RrVo3c=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr33844897otf.126.1563459412721; 
 Thu, 18 Jul 2019 07:16:52 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 18 Jul 2019 07:16:41 -0700
Message-ID: <CAPcyv4ji_0CqmeO2hh1ERvUnVJZkFcuj+=QQ3mrSx13y3uSHoQ@mail.gmail.com>
Subject: [GIT PULL] libnvdimm for 5.3
To: Linus Torvalds <torvalds@linux-foundation.org>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.3

...to receive primarily just the virtio_pmem driver for v5.3-rc1. The
lateness is attributed to me being out last week, and a last minute
regression hunt in a pending fix / rework of libnvdimm locking. Those
fixes can wait to post-rc1.

These commits have been in multiple -next releases, and uncovered a
late sparse fixup that is appended. The touches to ext4 and xfs have
received acks. Ted's ack is here [1], it arrived after I cut the
branch. Mike reviewed the device-mapper touches.

[1]: https://lore.kernel.org/lkml/20190707163415.GA19775@mit.edu/

---

The following changes since commit 9e0babf2c06c73cda2c0cd37a1653d823adb40ec:

  Linux 5.2-rc5 (2019-06-16 08:49:45 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.3

for you to fetch changes up to 8c2e408e73f735d2e6e8b43f9b038c9abb082939:

  virtio_pmem: fix sparse warning (2019-07-16 19:44:26 -0700)

----------------------------------------------------------------
- virtio_pmem: The new virtio_pmem facility introduces a paravirtualized
  persistent memory device that allows a guest VM to use DAX mechanisms to
  access a host-file with host-page-cache. It arranges for MAP_SYNC to
  be disabled and instead triggers a host fsync() when a 'write-cache
  flush' command is sent to the virtual disk device.

- Miscellaneous small fixups.

----------------------------------------------------------------
Andy Shevchenko (1):
      libnvdimm, namespace: Drop uuid_t implementation detail

Pankaj Gupta (8):
      libnvdimm: nd_region flush callback support
      virtio-pmem: Add virtio pmem driver
      libnvdimm: add dax_dev sync flag
      dm: enable synchronous dax
      dax: check synchronous mapping is supported
      ext4: disable map_sync for async flush
      xfs: disable map_sync for async flush
      virtio_pmem: fix sparse warning

 drivers/acpi/nfit/core.c         |   4 +-
 drivers/dax/bus.c                |   2 +-
 drivers/dax/super.c              |  19 +++++-
 drivers/md/dm-table.c            |  24 ++++++--
 drivers/md/dm.c                  |   5 +-
 drivers/md/dm.h                  |   5 +-
 drivers/nvdimm/Makefile          |   1 +
 drivers/nvdimm/claim.c           |   6 +-
 drivers/nvdimm/namespace_devs.c  |   8 +--
 drivers/nvdimm/nd.h              |   1 +
 drivers/nvdimm/nd_virtio.c       | 125 +++++++++++++++++++++++++++++++++++++++
 drivers/nvdimm/pmem.c            |  18 ++++--
 drivers/nvdimm/region_devs.c     |  33 ++++++++++-
 drivers/nvdimm/virtio_pmem.c     | 122 ++++++++++++++++++++++++++++++++++++++
 drivers/nvdimm/virtio_pmem.h     |  55 +++++++++++++++++
 drivers/s390/block/dcssblk.c     |   2 +-
 drivers/virtio/Kconfig           |  11 ++++
 fs/ext4/file.c                   |  10 ++--
 fs/xfs/xfs_file.c                |   9 ++-
 include/linux/dax.h              |  41 ++++++++++++-
 include/linux/libnvdimm.h        |  10 +++-
 include/uapi/linux/virtio_ids.h  |   1 +
 include/uapi/linux/virtio_pmem.h |  34 +++++++++++
 23 files changed, 508 insertions(+), 38 deletions(-)
 create mode 100644 drivers/nvdimm/nd_virtio.c
 create mode 100644 drivers/nvdimm/virtio_pmem.c
 create mode 100644 drivers/nvdimm/virtio_pmem.h
 create mode 100644 include/uapi/linux/virtio_pmem.h
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
