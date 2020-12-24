Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D58772E28AC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 24 Dec 2020 20:02:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EC9AF100EC1EC;
	Thu, 24 Dec 2020 11:02:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 59C7A100EC1EB
	for <linux-nvdimm@lists.01.org>; Thu, 24 Dec 2020 11:02:05 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id lt17so4301237ejb.3
        for <linux-nvdimm@lists.01.org>; Thu, 24 Dec 2020 11:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DY0LSNRuJC1VTeyAItmzj6dM2VdxUyAti0XxIdcaZ5E=;
        b=2Hpe/9xrT4zb3yTL9CqVhR3qbkcAZlcrex/9QmVwHiYnU5FGpHDjYQnhqRsWGwR3wK
         yE/9ocCEgIRo4zeJU5frghG2LiiqWZVf1OLu0ZhT97ZogfqwAspbxcFCFIGHBxyAuIbk
         0uNyrtgCFRG1aXjLxvFdEl24Shoo4nWdJhCqhFhXMTuprTiWjBhODbwN+3oqVcI+ihyF
         cHvFWTRtPmbq7zS0udGbvQq1qSlP+A39wDwavDMYBDgvdKwS+vRxr+wVAH3/L1AJjh7T
         tBrxi88QLFgkC1gT1ebLzHq159LlR1hFYxw/jfwyHHBpH/TTxn9cQTpBI1e7rdjksXkc
         3dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DY0LSNRuJC1VTeyAItmzj6dM2VdxUyAti0XxIdcaZ5E=;
        b=nhSDpLdxO+PHASMS/u7j1Bkve5TKu7NsUgFyFbHDzn/6bBUwyjN3R/faQ0k65/kdFv
         0lH23zyHv3oJBbw19v7sS5/DIymf7CnvE9Dxd+wsGs9+1KS2vY3U9XEvLbNV2Oy3hzJ/
         BZty5UglDW/1ZloupcNehErPLc77BiZQXuIIhvSnr9ZRDC9bXl0sak3JcH3171tfxs4v
         Aqh7MMyvsCxUpcLRkMtxGwLRJMUbyVHLBpF79Bb+Yedtk2L5Qsw6IxVkmG27Ep3vP9Ux
         UzSAhVvx0aYYcU2Wvc8WFZ+T3Z/uOSzowiNmnOGFiMXtugLVxwF20cK+u9pt8T68EYyf
         MRyA==
X-Gm-Message-State: AOAM530SzMOQytYBTshK6WQKY6bWdgQbzj5hZvL+uz0vI03OejDgq9+Z
	x+IrpYInWOcvNr8jMyc5BZzmr6c0I8OjVdXB5vCisJAkgxY9kQ==
X-Google-Smtp-Source: ABdhPJy/1Krz5HO9oGVYRjEamxCdyjL7FIkyx0/iZh9QIuQOwePG7Q6ROPFrOC+psbIFJvxzYJJgnYMQUctla/j4jgc=
X-Received: by 2002:a17:906:a3c7:: with SMTP id ca7mr29855808ejb.523.1608836523729;
 Thu, 24 Dec 2020 11:02:03 -0800 (PST)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 24 Dec 2020 11:01:53 -0800
Message-ID: <CAPcyv4iufHK1g-KvhOsh5pwNL=DwK5ydVR7NWePaco5v5XL24A@mail.gmail.com>
Subject: [GIT PULL] libnvdimm for v5.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: MZ5ML76XXWFVP5S7MVULHJF6WQVXLGGP
X-Message-ID-Hash: MZ5ML76XXWFVP5S7MVULHJF6WQVXLGGP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MZ5ML76XXWFVP5S7MVULHJF6WQVXLGGP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus,

Twas the day before Christmas and the only thing stirring in libnvdimm
/ device-dax land is a pile of miscellaneous fixups and cleanups. If
this is too late for -rc1 I'll pull out the fixes and resubmit after
the holidays. The bulk of it has appeared in -next save the last two
patches to device-dax that are passed my build and unit tests.

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.11

---

The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.11

for you to fetch changes up to 127c3d2e7e8a79628160e56e54d2be099bdd47c6:

  Merge branch 'for-5.11/dax' into for-5.11/libnvdimm (2020-12-24
10:14:04 -0800)

----------------------------------------------------------------
libnvdimm for 5.11

- Fix a long standing block-window-namespace issue surfaced by the ndctl
  change to attempt to preserve the kernel device name over a
  'reconfigure'

- Fix a few error path memory leaks in nfit and device-dax

- Silence a smatch warning in the ioctl path

- Miscellaneous cleanups

----------------------------------------------------------------
Dan Williams (4):
      libnvdimm/namespace: Fix reaping of invalidated
block-window-namespace labels
      ACPI: NFIT: Fix input validation of bus-family
      device-dax: Fix range release
      Merge branch 'for-5.11/dax' into for-5.11/libnvdimm

Enrico Weigelt (1):
      libnvdimm: Cleanup include of badblocks.h

Wang Hai (1):
      device-dax/core: Fix memory leak when rmmod dax.ko

Zhang Qilong (1):
      libnvdimm/label: Return -ENXIO for no slot in __blk_label_update

Zhen Lei (3):
      ACPI/nfit: avoid accessing uninitialized memory in acpi_nfit_ctl()
      device-dax: delete a redundancy check in dev_dax_validate_align()
      device-dax: Avoid an unnecessary check in alloc_dev_dax_range()

Zheng Yongjun (1):
      device-dax/pmem: Convert comma to semicolon

 drivers/acpi/nfit/core.c | 15 ++++++----
 drivers/dax/bus.c        | 71 ++++++++++++++++++------------------------------
 drivers/dax/pmem/core.c  |  2 +-
 drivers/dax/super.c      |  1 +
 drivers/nvdimm/btt.h     |  3 +-
 drivers/nvdimm/claim.c   |  1 +
 drivers/nvdimm/core.c    |  1 -
 drivers/nvdimm/label.c   | 13 ++++++++-
 8 files changed, 54 insertions(+), 53 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
