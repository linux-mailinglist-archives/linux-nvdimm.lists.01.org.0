Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05857B9BC3
	for <lists+linux-nvdimm@lfdr.de>; Sat, 21 Sep 2019 03:05:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E5879202EDBBD;
	Fri, 20 Sep 2019 18:07:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DF531202ECFBA
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 18:07:57 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 41so7667181oti.12
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 18:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=SNZHTXzWFoKdfyj4SStuMD6R3nyVpzOS/PYND2ZV/mU=;
 b=EG2xaZfdclJq2IuOFaxMmJcqHhFSAUvzcOVxAaowYSI2UPsZnqF3fEyRlK+eD87aa1
 f9di2GUe07f0vlLec7Elw2l8gHLl8sx4BqttWPPUQ1IpD01ySFme8ZfIq4JjlVMwRr9r
 O1gTPAfFoAg9QJFADrghcRLE5rk+5nwBsfCPF3xTDbSXVHVGnxT5SRXaH86JD/NEB9rN
 S07K7bdsME0qmcJ5CoBy0ATRmcFwtJKwaIJ9ef72V5bhz/S6etQJz8ZFldAsUFdPquV9
 O19plpd/L3TBPobjrgZ0JRxUvnlyAHUSxyYECq8/n43+TZ3Kia1h25hEvN6h6J0mTnWD
 Z1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=SNZHTXzWFoKdfyj4SStuMD6R3nyVpzOS/PYND2ZV/mU=;
 b=GNA8R9RGpXcD80grzPQpgCl1z9ZBhW17PAEtunlCF3FmTRg5ST9cv0ncGwi96uGPIb
 oRQw+lPheXUxl4yJRCwAyWrayr4W8ZhnVOpwoY5Rgew4uHVZCAwiMDeGGJ7ZsMjXdBM1
 IPrxOA7Li+FMIDw0AGRX0cSBf5h+O+CdDAhBSOFkYQSKG72YG1ICHp73WcHd/MEDw2dk
 BGZzNTou6TdswlyQVh0y2O+A8wyAe1TcrJu2B5AyoSOkGg/NLCojaAc4A/XJ/PTAOaCi
 bDAnLfs7JXjFglpoWSHfBGFqkvTqMXGUBL0UZYXXq2hnA4fpt1/rWuM+cFEtbAr/BDMz
 ubrQ==
X-Gm-Message-State: APjAAAVxBcyp+9sD9w4PdrfvBg5rVqyOEmTHFJBpRn+wMlONEtIAMe11
 d68IrjcrBlfUh2gYHZirrmiZ2A72DjmxZsYKdapr4sL9UCQ=
X-Google-Smtp-Source: APXvYqyUYCL340Fi0wZXLSZtP6idL/XMJySaz6gMFxZbpUO44FKAPVfR7TlRToS+JVeVKsf60wttWvs/zJYYbqHuPzo=
X-Received: by 2002:a9d:6014:: with SMTP id h20mr13280117otj.207.1569023863066; 
 Fri, 20 Sep 2019 16:57:43 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 20 Sep 2019 16:57:31 -0700
Message-ID: <CAPcyv4g9TpgciDdVpQajSxEYTaHxB4+R9KWF0d=Emt9J7LkAqg@mail.gmail.com>
Subject: [GIT PULL] libnvdimm for 5.4
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.4

...to receive some reworks to better support nvdimms on powerpc and an
nvdimm security interface update.

There was some last minute build breakage detected in -next so I've
left a patch that finalizes the powerpc compatibility work and some
other fixes out of this pull request.  The build fix requires a new
symbol export that needs an ack from ppc folks, so I'm going to save
that for a post -rc1 update. "libnvdimm/dax: Pick the right alignment
default when creating dax devices" not typically something I would
send during the -rc cycle, but I see no strong reason for it to wait
until v5.5.

The pending fixes for others watching are:

Aneesh Kumar K.V (4):
      libnvdimm/dax: Pick the right alignment default when creating dax devices
      mm/nvdimm: Fix endian conversion issues
      libnvdimm/altmap: Track namespace boundaries in altmap
      libnvdimm/region: Initialize bad block for volatile namespaces

Nathan Chancellor (1):
      libnvdimm/nfit_test: Fix acpi_handle redefinition

---

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.4

for you to fetch changes up to 5b26db95fee3f1ce0d096b2de0ac6f3716171093:

  libnvdimm: Use PAGE_SIZE instead of SZ_4K for align check
(2019-09-05 16:11:14 -0700)

----------------------------------------------------------------
libnvdimm for 5.4

- Rework the nvdimm core to accommodate architectures with different page
  sizes and ones that can change supported huge page sizes at boot
  time rather than a compile time constant.

- Introduce a distinct 'frozen' attribute for the nvdimm security state
  since it is independent of the locked state.

- Miscellaneous fixups.

----------------------------------------------------------------
Aneesh Kumar K.V (6):
      libnvdimm/of_pmem: Provide a unique name for bus provider
      libnvdimm/pmem: Advance namespace seed for specific probe errors
      libnvdimm/pfn_dev: Add a build check to make sure we notice when
struct page size change
      libnvdimm/pfn_dev: Add page size and struct page size to pfn superblock
      libnvdimm/label: Remove the dpa align check
      libnvdimm: Use PAGE_SIZE instead of SZ_4K for align check

Dan Williams (5):
      tools/testing/nvdimm: Fix fallthrough warning
      libnvdimm/security: Introduce a 'frozen' attribute
      libnvdimm/security: Tighten scope of nvdimm->busy vs security operations
      libnvdimm/security: Consolidate 'security' operations
      libnvdimm/region: Rewrite _probe_success() to _advance_seeds()

Gustavo A. R. Silva (1):
      libnvdimm, region: Use struct_size() in kzalloc()

 drivers/acpi/nfit/intel.c        |  59 ++++++------
 drivers/nvdimm/bus.c             |  10 +-
 drivers/nvdimm/dimm_devs.c       | 134 ++++++--------------------
 drivers/nvdimm/label.c           |   5 -
 drivers/nvdimm/namespace_devs.c  |  40 ++++++--
 drivers/nvdimm/nd-core.h         |  54 ++++-------
 drivers/nvdimm/nd.h              |   4 +
 drivers/nvdimm/of_pmem.c         |   2 +-
 drivers/nvdimm/pfn.h             |   5 +-
 drivers/nvdimm/pfn_devs.c        |  35 ++++++-
 drivers/nvdimm/pmem.c            |  29 +++++-
 drivers/nvdimm/region_devs.c     |  83 ++++------------
 drivers/nvdimm/security.c        | 199 ++++++++++++++++++++++++++-------------
 include/linux/libnvdimm.h        |   9 +-
 tools/testing/nvdimm/dimm_devs.c |  19 +---
 tools/testing/nvdimm/test/nfit.c |   3 +-
 16 files changed, 346 insertions(+), 344 deletions(-)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
