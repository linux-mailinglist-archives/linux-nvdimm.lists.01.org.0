Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D332A52F
	for <lists+linux-nvdimm@lfdr.de>; Sat, 25 May 2019 18:05:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7891B21276B9B;
	Sat, 25 May 2019 09:05:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D0D3A21275441
 for <linux-nvdimm@lists.01.org>; Sat, 25 May 2019 09:05:15 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id l17so11399201otq.1
 for <linux-nvdimm@lists.01.org>; Sat, 25 May 2019 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=l19XRunZ4edmyDiZ8/eCl7rM5qgS/YH9jQvm1C3vHc0=;
 b=A3R14F4IdcV5sGeshPkMMlET6bqHANhBQb2J1bCY9X4ch70IWyGnvHDaWX7d/Mp9Hp
 079KwzmPK2FQg0CKC4tmO05nGMcJDwLLCcUXRJCjur91/spbZ+8t1wyYdfue3wSQR/bI
 rzz5FyPKSdgU5EZd67GNobxk3dpzASrGl/OQyjqlRV0tOj1qXaEiTpa2uhaIdr8CfPcf
 4NR2FhFt9nxCD0WYLWKucNTfXEL208ZaFL8Jr6G8nuln3V0oAoIaAMIK6qrEkWBmb8S8
 bobds6NAOD3zO8pK0cz+ipbFoYEH4f4ObUqbSIr9KIUzJmXO31+WLiZIgH7hMWFOvsHC
 u4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=l19XRunZ4edmyDiZ8/eCl7rM5qgS/YH9jQvm1C3vHc0=;
 b=CqI/cSMBlnhWAuMfAIP2X0Lfyl+ZLfRFj7T75L8oKSulXeBhRU0M6gB4hWjlpnGUNi
 s1QZ0NuELQQR9SlQ4z/fxi1KqwF8M3eI5fH7Vf05Ukmc/KohZUkyacLwFRmB/lF1GWHs
 PYsWKhxA69B7n/+kfEsXdm/P8uBJI7sVZRbFFFb/YBry6WOKIj+kPHsDn7qku9uNMBnG
 rYn28RLPJbg40g5l39Qn3uYPML6d54AENytBp+69MbcLltzvcD7TQnu5zDv5D0822HGH
 ebv8r5GhCDujtMcRjcOr0qVh75cuViJanXhMT/R1EvRuflFU0y+ezFUEtHqntFAR4ICC
 k5pA==
X-Gm-Message-State: APjAAAUcOn67i/EjQ3ukMeV2ER1Fsw1RE83vUSMUbg4qpcxu/pFWT002
 osspa/2QuwXMZLMeiT+viGRU+FCUwzpVc+OuuO5kdA==
X-Google-Smtp-Source: APXvYqzCSOOpLKL4h1itEOlv/uZne/4BHXc4Cc3fThbuUcmz5bHH1XQuhj/0zSI48i6WyVWu0nKtZVfmMlH6epbuGBk=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr841087otr.207.1558800314745; 
 Sat, 25 May 2019 09:05:14 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 25 May 2019 09:05:03 -0700
Message-ID: <CAPcyv4ghA3bGeTFw+wVV5N8cb-izpwdi9BQU5Ec6wNTw8ZywMw@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fixes for v5.2-rc2
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
tags/libnvdimm-fixes-5.2-rc2

...to receive a regression fix, a small (2 line code change)
performance enhancement, and some miscellaneous compilation warning
fixes. These have soaked in -next the past week with no known issues.
The device-mapper touches have Mike's ack, and the hardened user-copy
bypass was reviewed with Kees.

---

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.2-rc2

for you to fetch changes up to 52f476a323f9efc959be1c890d0cdcf12e1582e0:

  libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead (2019-05-20
20:43:32 -0700)

----------------------------------------------------------------
libnvdimm fixes v5.2-rc2

- Fix a regression that disabled device-mapper dax support

- Remove unnecessary hardened-user-copy overhead (>30%) for dax
  read(2)/write(2).

- Fix some compilation warnings.

----------------------------------------------------------------
Dan Williams (2):
      dax: Arrange for dax_supported check to span multiple devices
      libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead

Qian Cai (1):
      libnvdimm: Fix compilation warnings with W=1

 drivers/dax/super.c          | 88 ++++++++++++++++++++++++++++----------------
 drivers/md/dm-table.c        | 17 ++++++---
 drivers/md/dm.c              | 20 ++++++++++
 drivers/md/dm.h              |  1 +
 drivers/nvdimm/bus.c         |  4 +-
 drivers/nvdimm/label.c       |  2 +
 drivers/nvdimm/label.h       |  2 -
 drivers/nvdimm/pmem.c        | 11 +++++-
 drivers/s390/block/dcssblk.c |  1 +
 include/linux/dax.h          | 26 +++++++++++++
 10 files changed, 129 insertions(+), 43 deletions(-)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
