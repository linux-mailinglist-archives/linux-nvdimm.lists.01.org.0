Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE6010D9C9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 29 Nov 2019 19:56:38 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1EE0F100DC2D7;
	Fri, 29 Nov 2019 10:59:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C5674100DC3EC
	for <linux-nvdimm@lists.01.org>; Fri, 29 Nov 2019 10:59:57 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id 14so26800757oir.12
        for <linux-nvdimm@lists.01.org>; Fri, 29 Nov 2019 10:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xboj7F00bLbKnatedgQze9i2APMnPtQy1LrQNkM7FYQ=;
        b=Q1+qt9qmF/rLkAGqDYkEHYeW6EPQtxzZ+8NtolvjMgoSovWm13CTHenqOgKWRP4D4f
         aKXtgJD3mrzRgeFkX4xXtZZU7Tdp+RyHrJh2Cs5RgQvLZ4qveq/M2BTUPg1q7EfeQAVw
         lVGygT+Pwk34HBtkoZLFR+TF2OmaHYuV/8l+eJJCQwlE3ZOt6U/fTUUIwPhaZU5STa0e
         quHtjFQJVApCTJ9Cl5pvi3VW+Ts1WpNYNTuKfsnptFQciYz3CLt+VGAkAr5hxfFJ07W4
         S906t//NGSvk1EVk2cIcfrb2jweYPzanpDN9XPOBJVtzBuizrtYc+UHNa+DFFutxL+j5
         Lb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xboj7F00bLbKnatedgQze9i2APMnPtQy1LrQNkM7FYQ=;
        b=diyLj7SDk9UPt1DSVOYuDypunf4IHGlK9gaxjgJYU/TeadaUOTkZ3k82z+nz9VoTLi
         N98BgnzqZsULdN+kkDppyynOgUmg9avwLcw0Si+bqrh9ubtNZrd2tMVCS79UyQx15UGp
         j0C0kRfH01ga4qWwXOljOsKniv9sLRvzJ6YLv02ITPIZsV7na56yrobcUfQr0rZwBraV
         kcA0Mpt8JtTeKmT5OTUZom9UqFDfm/zRkk+t6F1E50wYYl+rVOMvSnJb0MbyifuPXCUn
         90hQFXCp4PrQIqT02/zJm69rlREV2rtlGUuLzfEUf9CFi6pJd+MypKjxlSFPaKxmBGjQ
         nwMQ==
X-Gm-Message-State: APjAAAXPeUHZ9u31W3m1FgnZtwZK+fRmpx7gKcAy17TapF3MndIrhO9G
	i6fZVoeMF+P/zUH9e/NjLCNAvIEZ4e/wx4wY5hP7+g==
X-Google-Smtp-Source: APXvYqzd57f2wxECF4fesi3hhXmvOo40o4Zq2olC+h0RWJ9X7eKDf4fWTmQ75AQmTV7EkFg6r5iSKXRdJRJrI8ZfR34=
X-Received: by 2002:a54:468e:: with SMTP id k14mr1852547oic.105.1575053793229;
 Fri, 29 Nov 2019 10:56:33 -0800 (PST)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 29 Nov 2019 10:56:22 -0800
Message-ID: <CAPcyv4jftz7mN=4zNPo1tGZfcXxfKunTUF4Owof6pJ108GYk=g@mail.gmail.com>
Subject: [GIT PULL] libnvdimm for v5.5
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: OVDVFGUCTAQSOAP3SM6UZDTZH2DN5AEK
X-Message-ID-Hash: OVDVFGUCTAQSOAP3SM6UZDTZH2DN5AEK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OVDVFGUCTAQSOAP3SM6UZDTZH2DN5AEK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.5

...to receive the libnvdimm update for this cycle. The highlight this
cycle is continuing integration fixes for PowerPC and some resulting
optimizations. These commits have appeared in -next with no reported
issues.

---

The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.5

for you to fetch changes up to 0dfbb932bb67dc76646e579ec5cd21a12125a458:

  MAINTAINERS: Remove Keith from NVDIMM maintainers (2019-11-25 15:45:08 -0800)

----------------------------------------------------------------
libnvdimm for 5.5

- Updates to better support vmalloc space restrictions on PowerPC platforms.

- Cleanups to move common sysfs attributes to core 'struct device_type'
  objects.

- Export the 'target_node' attribute (the effective numa node if pmem is
  marked online) for regions and namespaces.

- Miscellaneous fixups and optimizations.

----------------------------------------------------------------
Alastair D'Silva (1):
      libnvdimm: Remove prototypes for nonexistent functions

Aneesh Kumar K.V (2):
      libnvdimm/pfn_dev: Don't clear device memmap area during generic
namespace probe
      libnvdimm/namespace: Differentiate between probe mapping and
runtime mapping

Dan Williams (14):
      libnvdimm/pmem: Delete include of nd-core.h
      libnvdimm: Move attribute groups to device type
      libnvdimm: Move region attribute group definition
      libnvdimm: Move nd_device_attribute_group to device_type
      libnvdimm: Move nd_numa_attribute_group to device_type
      libnvdimm: Move nd_region_attribute_group to device_type
      libnvdimm: Move nd_mapping_attribute_group to device_type
      libnvdimm: Move nvdimm_attribute_group to device_type
      libnvdimm: Move nvdimm_bus_attribute_group to device_type
      dax: Create a dax device_type
      dax: Simplify root read-only definition for the 'resource' attribute
      libnvdimm: Simplify root read-only definition for the 'resource' attribute
      dax: Add numa_node to the default device-dax attributes
      libnvdimm: Export the target_node attribute for regions and namespaces

Ira Weiny (2):
      libnvdimm/namsepace: Don't set claim_class on error
      libnvdimm: Trivial comment fix

Keith Busch (1):
      MAINTAINERS: Remove Keith from NVDIMM maintainers

Qian Cai (1):
      libnvdimm/btt: fix variable 'rc' set but not used

 MAINTAINERS                               |   2 -
 arch/powerpc/platforms/pseries/papr_scm.c |  25 +---
 drivers/acpi/nfit/core.c                  |   7 -
 drivers/dax/bus.c                         |  22 ++-
 drivers/dax/pmem/core.c                   |   6 +-
 drivers/nvdimm/btt.c                      |  18 ++-
 drivers/nvdimm/btt_devs.c                 |  24 +--
 drivers/nvdimm/bus.c                      |  44 +++++-
 drivers/nvdimm/claim.c                    |  14 +-
 drivers/nvdimm/core.c                     |   8 +-
 drivers/nvdimm/dax_devs.c                 |  27 ++--
 drivers/nvdimm/dimm_devs.c                |  30 ++--
 drivers/nvdimm/e820.c                     |  13 --
 drivers/nvdimm/namespace_devs.c           | 114 +++++++++------
 drivers/nvdimm/nd-core.h                  |  21 ++-
 drivers/nvdimm/nd.h                       |  27 ++--
 drivers/nvdimm/of_pmem.c                  |  13 --
 drivers/nvdimm/pfn_devs.c                 |  64 ++++----
 drivers/nvdimm/pmem.c                     |  18 ++-
 drivers/nvdimm/region_devs.c              | 235 +++++++++++++++---------------
 include/linux/libnvdimm.h                 |   7 -
 include/linux/nd.h                        |   2 +-
 22 files changed, 387 insertions(+), 354 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
