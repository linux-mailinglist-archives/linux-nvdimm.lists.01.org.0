Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EB51FCD1
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 02:06:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3D943212794BA;
	Wed, 15 May 2019 17:06:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3015921277791
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 17:06:10 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id a132so1201481oib.2
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 17:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=0sh2UsByjRLANJVfg34Xwvsd0MFYNc105tKEUP8O1rU=;
 b=t/6ieGbP2moQ4DomPsZ+RRywuPL3Wbq45QXsaH688QBKmc7oDJ1FAgfntRPDerTkr0
 B5dATTpwfcAfKK+4gpamM6gs23Umg/83i1eKrIqhMN6crLTENvGX5ONFCugZnz1xxXXG
 OL8JFmNGX38Gnqhz4UTcyocFMVtXSBmHeFQdZGScAU2OprhO/MFVfOZhkgbE1E3QBwE8
 e0v1Isogrz2G0Kmk3jwVr4Cc9WgeiRjLpmeacB3devbCAd+PIv2BJ45IR4wXZU02kXUu
 15PMm7esKMEfA2CznYssIhKN+L4CM1Nv7Td40K2BAhMgIImki3dICH3Lmc7hxvl/yBbY
 Jhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=0sh2UsByjRLANJVfg34Xwvsd0MFYNc105tKEUP8O1rU=;
 b=UY2MPaaT8vYptq2dhYnnj02fSJnwP8AGCovy73TRAM7xmo+h/ODzwC/S9eSq1kz+Sl
 7c3vxeuRVQiK/csplx9g95NU+zK8ToDjegko2wOvJ6hJcTtdVsi8jCBMAQwa0M7iU+Ok
 p1VmTedWUaUrSK8JREVXC6vboty99hWpHU1eH+VIyg+2AEETWNKDwWR7+d3t5GMsoKNl
 KPH03mlotH0FvYo6P38XplvA3M30E3XMhlNhPkoNi5GlBZdWVuakarXyz6HUAwqjWMTI
 QPCjgtk1dOnb+kdyTwVSYAfWuamT+VCm3ccEnF3gkCeCQps+OrWAuMpg5nzGL5pRe9vF
 0FkA==
X-Gm-Message-State: APjAAAXCQH3bkrCUbQbMCSjN/uvaZnOMECOOZjCrvcF+jBilMAMqpNBB
 BgVBEVC99Kvejc8XwKpK5TLGsbSWBBKlW5qPBaiRWg==
X-Google-Smtp-Source: APXvYqy5GxTivc+0J2t+V+9MNN3bDq6Dh1ZdsH4nxzQwx1BRJ/lX37anMupt/b2FQBOfFsn/1FIvqGLdDxBy5z8M25k=
X-Received: by 2002:aca:ab07:: with SMTP id u7mr4282661oie.73.1557965169384;
 Wed, 15 May 2019 17:06:09 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 15 May 2019 17:05:58 -0700
Message-ID: <CAPcyv4iXv7Jh4rjO9XQAFpeCJEZ4-4nvb46nZyQP554uLNbOyg@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fixes for v5.2-rc1
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
tags/libnvdimm-fixes-5.2-rc1

...to receive just a small collection of fixes this time around. The
new virtio-pmem driver is nearly ready, but some last minute
device-mapper acks and virtio questions made it prudent to await v5.3.
Other major topics that were brewing on the linux-nvdimm mailing list
like sub-section hotplug, and other devm_memremap_pages() reworks will
go upstream through Andrew's tree.

These have seen multiple -next releases with no reported issues.

---

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.2-rc1

for you to fetch changes up to 67476656febd7ec5f1fe1aeec3c441fcf53b1e45:

  drivers/dax: Allow to include DEV_DAX_PMEM as builtin (2019-05-07
07:48:06 -0700)

----------------------------------------------------------------
libnvdimm fixes 5.2-rc1

* Fix a long standing namespace label corruption scenario when
  re-provisioning capacity for a namespace.

* Restore the ability of the dax_pmem module to be built-in.

* Harden the build for the 'nfit_test' unit test modules so that the
  userspace test harness can ensure all required test modules are
  available.

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      drivers/dax: Allow to include DEV_DAX_PMEM as builtin

Dan Williams (1):
      libnvdimm/namespace: Fix label tracking error

Vishal Verma (2):
      dax/pmem: Fix whitespace in dax_pmem
      tools/testing/nvdimm: add watermarks for dax_pmem* modules

 drivers/dax/Kconfig                         |  3 +--
 drivers/dax/pmem/core.c                     |  6 +++---
 drivers/nvdimm/label.c                      | 29 ++++++++++++++++-------------
 drivers/nvdimm/namespace_devs.c             | 15 +++++++++++++++
 drivers/nvdimm/nd.h                         |  4 ++++
 tools/testing/nvdimm/Kbuild                 |  3 +++
 tools/testing/nvdimm/dax_pmem_compat_test.c |  8 ++++++++
 tools/testing/nvdimm/dax_pmem_core_test.c   |  8 ++++++++
 tools/testing/nvdimm/dax_pmem_test.c        |  8 ++++++++
 tools/testing/nvdimm/test/nfit.c            |  3 +++
 tools/testing/nvdimm/watermark.h            |  3 +++
 11 files changed, 72 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/nvdimm/dax_pmem_compat_test.c
 create mode 100644 tools/testing/nvdimm/dax_pmem_core_test.c
 create mode 100644 tools/testing/nvdimm/dax_pmem_test.c
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
