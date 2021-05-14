Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AA4381458
	for <lists+linux-nvdimm@lfdr.de>; Sat, 15 May 2021 01:43:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CCA1F100EAAE6;
	Fri, 14 May 2021 16:43:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E3777100F2268
	for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 16:43:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id m12so992511eja.2
        for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 16:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=v3u3b9uT02hbX02b+XftSWgRRCv+2h7+b/1VyLPKTaw=;
        b=K1r0Y34sTbOrf9jhumBPZ6G5hS4KTjCXmUPdNQawQh5HvGQBrptyVrAqG6jr6L8Y+L
         LjY2R+rIs4BlpX2nZY0BmTPMwrDqRRjMSOVzKf6lde8k3YqjHrWXoh1kd4GNZ3dfjs4M
         YxJ1mFbUVttbWsestCFpjlab/6Ryfb78NVImRllTfgPHiPE0EOaQxNFP1HPmZzo1dsBb
         XJswTOGqiFzG5/qLR/D2shgk70Nn0o48RvU8ppVwTymgZuhmtqvLBuWgL76hZvBJYpsf
         XHUHHlp1fd1woMT06xwZxUS6Vx25gSRI/Wlc74dyqBk41haWmtGrMUoctS0PWbzAN1ri
         CGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=v3u3b9uT02hbX02b+XftSWgRRCv+2h7+b/1VyLPKTaw=;
        b=F3GNj/GJbErT9WhGXb3JvY4+Kk5w3UKjNt44ZEadPW9DPibuh21yRdp0hRTkCkszj3
         l0M/xl3Qgtroi8MYwzaEZB8o4S3fTxHM6kpKl5NidOrNNM0HjHq5U/WjAJcmquntbUW4
         rjn06gja4w23fne3aKOd7s+Gr0Y4niZSFyaMaZhYa11/ozmi6ismKqC8GwLp0giZdQQG
         2PZQKMcKQvCpPj0edC2AxF2JzVPaAOjg+Cw/Ubm/x7qEH9Th+1OImJftiC6WiauaLYTU
         3dVgaAZ9YvsX181ngPe3elyG1+1wJJHWjFqyZrzTEyOwmq/Y/yUe+6Li86ndOMqi0BrO
         5JQg==
X-Gm-Message-State: AOAM530Nw6BYZ1iU7MXqMaDjsTQnJUPni0WlPQKmF9/Bb5+yK6YUjY3w
	0L/c7RjuJBXGAHlqYVVI0bAC9AiL86NPsHOY3RZcXA==
X-Google-Smtp-Source: ABdhPJxOQlIGiokO70SPnHXQBzx0NDpYA7ZkRGGn3AeoRPNbA/UMXqQl1o5UsxDfPBT75lhQedX4k1MOMo7xuNqSEMs=
X-Received: by 2002:a17:906:bc8e:: with SMTP id lv14mr50659631ejb.418.1621035822234;
 Fri, 14 May 2021 16:43:42 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 14 May 2021 16:43:31 -0700
Message-ID: <CAPcyv4gEKckAC2_mtjdK22OsEH4tHQSprYmuB7hkhafYquKNGQ@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fixes for 5.13-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: UMFLXWVSOD2S5QG3IGCVQND3VZ47KPTA
X-Message-ID-Hash: UMFLXWVSOD2S5QG3IGCVQND3VZ47KPTA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, nvdimm@lists.linux.dev, Linux ACPI <linux-acpi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UMFLXWVSOD2S5QG3IGCVQND3VZ47KPTA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.13-rc2

...to receive a regression fix for a bootup crash condition introduced
in -rc1 and some other minor fixups. This has all appeared in -next
with no reported issues.

---


The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.13-rc2

for you to fetch changes up to e9cfd259c6d386f6235395a13bd4f357a979b2d0:

  ACPI: NFIT: Fix support for variable 'SPA' structure size
(2021-05-12 12:38:25 -0700)

----------------------------------------------------------------
libnvdimm fixes for 5.13-rc2

- Fix regression in ACPI NFIT table handling leading to crashes and
  driver load failures.

- Move the nvdimm mailing list

- Miscellaneous minor fixups

----------------------------------------------------------------
Dan Williams (2):
      MAINTAINERS: Move nvdimm mailing list
      ACPI: NFIT: Fix support for variable 'SPA' structure size

Wan Jiabing (1):
      libnvdimm: Remove duplicate struct declaration

Zou Wei (1):
      tools/testing/nvdimm: Make symbol '__nfit_test_ioremap' static

 Documentation/ABI/obsolete/sysfs-class-dax    |  2 +-
 Documentation/ABI/removed/sysfs-bus-nfit      |  2 +-
 Documentation/ABI/testing/sysfs-bus-nfit      | 40 ++++++++++++-------------
 Documentation/ABI/testing/sysfs-bus-papr-pmem |  4 +--
 Documentation/driver-api/nvdimm/nvdimm.rst    |  2 +-
 MAINTAINERS                                   | 14 ++++-----
 drivers/acpi/nfit/core.c                      | 15 +++++++---
 include/linux/libnvdimm.h                     |  1 -
 tools/testing/nvdimm/test/iomap.c             |  2 +-
 tools/testing/nvdimm/test/nfit.c              | 42 ++++++++++++++++-----------
 10 files changed, 69 insertions(+), 55 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
