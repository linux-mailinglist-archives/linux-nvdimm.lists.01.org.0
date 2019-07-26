Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4250774B8
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 00:54:04 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A56D4212E1594;
	Fri, 26 Jul 2019 15:56:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EED2A212E13DB
 for <linux-nvdimm@lists.01.org>; Fri, 26 Jul 2019 15:56:26 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id r21so50865790otq.6
 for <linux-nvdimm@lists.01.org>; Fri, 26 Jul 2019 15:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=9yHKSH2nyrMOIGNyd4CyMcnUdirfGb0YWEy2r0HnXdM=;
 b=m+fsM1k54XE4l7Y52Rhdx4f6VkwEeRHjELBA+I2opnzo8BChnkBi+nWCp1/u+0Zzq6
 ZvAue14znBPJb5hRMhgpvnah1jfLjorbivaiwWENClta8GSdohIK26jSG0LeaxCoyTbn
 I+I+bwIxe7kgCCti111wRuoG3MqDY5six9EKOl7pu0y9+pLG3g53Ew4MhVOADh65+/bB
 l3quZNvoqrVfTNtnOeIpMDAm2BQpee37zNSDx4caUe8n4X9Ah2NDfwxvh/IL0YTkBaAX
 8KXqUQtQ8DEh6jkKXms/C83uYNLukuZb4fctkwhO2GyNZfajirB5HJZFAMChPsZcF/Al
 qlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=9yHKSH2nyrMOIGNyd4CyMcnUdirfGb0YWEy2r0HnXdM=;
 b=DHZ0pGMa5CszlzMnN/WYm5MHXODh2LD8I8ZIQSMOWVEzX/cJxRGHePWVr0/lnqbfKc
 pD0/ZbxOBFgpideQDbIzgVbyUuDQkjatcmO2QxHVZ59P9GhfkF2YgwnRSbKCU3n61xEd
 fKEPntE6GBano0banzntpuHaPhzq5cPS40Vpj9cuS5Er+8vSGocj8AUAVKwbuhBY7SHl
 l+qrIqpUB/ZnQ48QxFqcFcA66z3tUoEQ4aZ3+Z5Vc0gWuW5sFSDVFRIHMy+kByaY4/0R
 fmld1TFSl67MyuOy65b7fmqDHEbtO8wwFErLBKQd5NjozF/Mu6xTiLMOGCQJ3RS36wQd
 rwpA==
X-Gm-Message-State: APjAAAV9xYHhhY+0vI0G+P0DCiLUZ0xTo15+NNKsizu9852UKwMGO2xq
 6dnV4MRHMAZeVPJdHxMXOYpPLL4NqSEJL2TfhCpSLA==
X-Google-Smtp-Source: APXvYqz4Uvodp449SpQfppdw+t/cXgvDGwkwTvwh7UY4Ms1pF+6kuQ9VjwgbAYP1RwIe4MoqUCAC2Qf4MJiEBRYC6Kw=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr65596750otn.71.1564181639248; 
 Fri, 26 Jul 2019 15:53:59 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 26 Jul 2019 15:53:47 -0700
Message-ID: <CAPcyv4gqE6zOoSibTgjbWWHE3VVQ0wSJN-NxwF288nTe2Z3yzA@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fixes for 5.3-rc2
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
tags/libnvdimm-fixes-5.3-rc2

...to receive a collection of locking and async operations fixes for
v5.3-rc2. These had been soaking in a branch targeting the merge
window, but missed due to a regression hunt. This fixed up version has
otherwise been in -next this past week with no reported issues.

In order to gain confidence in the locking changes the pull also
includes a debug / instrumentation patch to enable lockdep coverage
for libnvdimm subsystem operations that depend on the device_lock for
exclusion. As mentioned in the changelog it is a hack, but it works
and documents the locking expectations of the sub-system in a way that
others can use lockdep to verify. The driver core touches got an ack
from Greg.

Please pull, but I'll understand if you want a resend with the debug
patch dropped.

---

The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.3-rc2

for you to fetch changes up to 87a30e1f05d73a34e6d1895065541369131aaf1c:

  driver-core, libnvdimm: Let device subsystems add local lockdep
coverage (2019-07-18 16:23:27 -0700)

----------------------------------------------------------------
libnvdimm fixes v5.3-rc2

- Fix duplicate device_unregister() calls (multiple threads competing to
  do unregister work when scheduling device removal from a sysfs attribute
  of the self-same device).

- Fix badblocks registration order bug. Ensure region badblocks are
  initialized in advance of namespace registration.

- Fix a deadlock between the bus lock and probe operations.

- Export device-core infrastructure to coordinate async operations via
  the device ->dead state.

- Add device-core infrastructure to validate device_lock() usage with
  lockdep.

----------------------------------------------------------------
Dan Williams (7):
      drivers/base: Introduce kill_device()
      libnvdimm/bus: Prevent duplicate device_unregister() calls
      libnvdimm/region: Register badblocks before namespaces
      libnvdimm/bus: Prepare the nd_ioctl() path to be re-entrant
      libnvdimm/bus: Stop holding nvdimm_bus_list_mutex over __nd_ioctl()
      libnvdimm/bus: Fix wait_nvdimm_bus_probe_idle() ABBA deadlock
      driver-core, libnvdimm: Let device subsystems add local lockdep coverage

 drivers/acpi/nfit/core.c        |  28 +++---
 drivers/acpi/nfit/nfit.h        |  24 +++++
 drivers/base/core.c             |  30 ++++--
 drivers/nvdimm/btt_devs.c       |  16 +--
 drivers/nvdimm/bus.c            | 210 ++++++++++++++++++++++++++--------------
 drivers/nvdimm/core.c           |  10 +-
 drivers/nvdimm/dimm_devs.c      |   4 +-
 drivers/nvdimm/namespace_devs.c |  36 +++----
 drivers/nvdimm/nd-core.h        |  71 +++++++++++++-
 drivers/nvdimm/pfn_devs.c       |  24 ++---
 drivers/nvdimm/pmem.c           |   4 +-
 drivers/nvdimm/region.c         |  24 ++---
 drivers/nvdimm/region_devs.c    |  12 ++-
 drivers/nvdimm/region.c         |  24 ++---
 drivers/nvdimm/region_devs.c    |  12 ++-
 include/linux/device.h          |   6 ++
 14 files changed, 343 insertions(+), 156 deletions(-)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
