Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C72312667
	for <lists+linux-nvdimm@lfdr.de>; Sun,  7 Feb 2021 18:37:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC248100EBB7D;
	Sun,  7 Feb 2021 09:37:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 65DBB100EBB6C
	for <linux-nvdimm@lists.01.org>; Sun,  7 Feb 2021 09:37:20 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id j4so5974606qvk.6
        for <linux-nvdimm@lists.01.org>; Sun, 07 Feb 2021 09:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=j9qX/HSwLIMkP63Z3KVtmxMD254RgIGqBGNpCVomjWY=;
        b=nNNMJeBi0mPrn9xvenzjb7nX0r7+1vTZVgnpiPdsvMEYsbPxm577zKBfHWm1WnZ0I6
         d+3OwFjhKKyKbJP46sku5okjjhHvffxRGy8cqlkwDuRUzQ0XCMMKEVQ6AgCWPExndX71
         iV/F/MxRqhLEVIW7PCyQVdwxaFFoXgExBvu8sYrNURdElojS1mGJiXG9sabighuYGzQU
         0wWIWHzgN8BnvfcPJjQf3+xcdeyTYuPqQLXwkqiII5Ijfv0+VK66zfGu0J+OLQWHBlrr
         Kw2EdENjXfdhW5dSrS4JoV0AYReI4rMEoi1srVgbWsGwO+gkYbaR63jGH+RAAwEVIjYG
         6mWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=j9qX/HSwLIMkP63Z3KVtmxMD254RgIGqBGNpCVomjWY=;
        b=tKH3rePSpUivj19kLPHKPIucFcVS34yqkWf+GcYg1HlwOhF7Coe43JC8JeWpryApmc
         q8hLPo5HDnuUl0VTF0wGgk6p90K/1qIXAc5or/fP3X08IuycAy1PCQkfrYhFaOsDtzsh
         OpkVG4PD3T4Vq2XREJxSqk9/JiHd2E89uNgbsr30Bx1DHGY91FrvwoW34DWDrDfCrHdu
         jUcUKCw7VCq3KMNMC2NNwH5DV66ViER14zKgNQPKD8JXfeQ5AQZn3z4VmxUpM6vEMj/4
         gF9bNTAAR7Lln9hAXLVGlDseUEXMMnY6E2ldvJ/EN9AxODGB67qgWNc5WwKq0waSV1+H
         cdGQ==
X-Gm-Message-State: AOAM532+DLpMRenoSNOJC7Odj4e8cTOImdzV9kItkpNy2mwNOwWU7qq3
	7adkki8k7gUL5G9h9GiMfa6MukaJwlOqHswcO6pyYg==
X-Google-Smtp-Source: ABdhPJxCjzPVfc2g1XZxDZvYSY4IV7O7SVX3xJakIAGZzxobmpJJpZpBIB0BY2mm1CSY2CXwv2rPdWyqlr2BrsTWol4=
X-Received: by 2002:ad4:584b:: with SMTP id de11mr12935044qvb.19.1612719438769;
 Sun, 07 Feb 2021 09:37:18 -0800 (PST)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 7 Feb 2021 09:37:21 -0800
Message-ID: <CAPcyv4j++J_ra8zWkvVovmwmYCERp8vKsVSZn9x4PYGoJa-XOA@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fixes for v5.11-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: XKISQKOPFOXRUMD6QCRZEBQMGNXZUMV6
X-Message-ID-Hash: XKISQKOPFOXRUMD6QCRZEBQMGNXZUMV6
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XKISQKOPFOXRUMD6QCRZEBQMGNXZUMV6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.11-rc7

...to receive a fix for a crash scenario that has been present since
the initial merge, a minor regression in sysfs attribute visibility,
and a fix for some flexible array warnings. The bulk of this pull is
an update to the libnvdimm unit test infrastructure to test non-ACPI
platforms. Given there is zero regression risk for test updates, and
the tests enable validation of bits headed towards the next merge
window, I saw no reason to hold the new tests back. Santosh originally
submitted this before the v5.11 window opened.

This has all appeared in -next with no reported issues.

---

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.11-rc7

for you to fetch changes up to 7018c897c2f243d4b5f1b94bc6b4831a7eab80fb:

  libnvdimm/dimm: Avoid race between probe and available_slots_show()
(2021-02-01 16:20:40 -0800)

----------------------------------------------------------------
libnvdimm for 5.11-rc7
- Fix a crash when sysfs accesses race 'dimm' driver probe/remove.

- Fix a regression in 'resource' attribute visibility necessary for
  mapping badblocks and other physical address interrogations.

- Fix some flexible array warnings

- Expand the unit test infrastructure for non-ACPI platforms

----------------------------------------------------------------
Dan Williams (3):
      ACPI: NFIT: Fix flexible_array.cocci warnings
      libnvdimm/namespace: Fix visibility of namespace resource attribute
      libnvdimm/dimm: Avoid race between probe and available_slots_show()

Jianpeng Ma (1):
      libnvdimm/pmem: Remove unused header

Santosh Sivaraj (7):
      testing/nvdimm: Add test module for non-nfit platforms
      ndtest: Add compatability string to treat it as PAPR family
      ndtest: Add dimms to the two buses
      ndtest: Add dimm attributes
      ndtest: Add regions and mappings to the test buses
      ndtest: Add nvdimm control functions
      ndtest: Add papr health related flags

 drivers/acpi/nfit/core.c            |   75 +--
 drivers/nvdimm/dimm_devs.c          |   18 +-
 drivers/nvdimm/namespace_devs.c     |   10 +-
 drivers/nvdimm/pmem.c               |    1 -
 tools/testing/nvdimm/config_check.c |    3 +-
 tools/testing/nvdimm/test/Kbuild    |    6 +-
 tools/testing/nvdimm/test/ndtest.c  | 1129 +++++++++++++++++++++++++++++++++++
 tools/testing/nvdimm/test/ndtest.h  |  109 ++++
 8 files changed, 1293 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/nvdimm/test/ndtest.c
 create mode 100644 tools/testing/nvdimm/test/ndtest.h
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
