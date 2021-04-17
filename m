Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 740B3362D30
	for <lists+linux-nvdimm@lfdr.de>; Sat, 17 Apr 2021 05:26:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A29DA100ED4BA;
	Fri, 16 Apr 2021 20:26:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.218.50; helo=mail-ej1-f50.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CA675100ED4AE
	for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 20:26:40 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id e14so44838028ejz.11
        for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 20:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WiTsWqeV3t2x9ikLj20hBA8e/9UUZ/sS0LIdWopzgJw=;
        b=zZi1DYhYfCAX8+wpHDkgCFrEaVlN8lv6zgnzOfAywVOZyAVUtqcx5SZ5MQzrLD+MIg
         ht+jGsPDLzCUxkj+v5smSoFrluIFa+zMtIfr6IcKisYQcah9MmjQhhisXimcrKDmj8rg
         bB39uI7NS0gpD8FCXUZU+5sZxjBsvy2XTr4dYolxNk3TPRjA0K88fFwkLkC92ZvCTps0
         vgWojhbFszNfJvSipnqO5bAuDEO48IbUWlNzd2L73stQ/7zEli/TdAmuFFc5k6k4ux7d
         vJp9BNY/9bSNsMFE5YotlZXZIOgU6yHXk0OYeln3AUXFRd5hv9PjDR1LOoE2K7aLAReB
         vgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WiTsWqeV3t2x9ikLj20hBA8e/9UUZ/sS0LIdWopzgJw=;
        b=iDDq+Ku6UflUCbO/KQO7wPQUefiOVwVj+D5gZmxz50AJfEVZSTzsY5o+BGAWEESOkN
         wwqmkFjYAU4SokebQDcoSp4vqSmVKbuIW1WKC00x/dBHVd+9tefHOfcp/SRbIjNU8nLY
         dK1BRt+RWc3fY4EUxEe9iCyfnpyFYdJin9PkxKbhQy9Gy7qW7VKO3ahkoNAWoTki/VAF
         mddtNzUnHkaIm7+rYMqhHx2K5bbnwaVXrVGKwCCN+6W5vojeH2Dg5DZz/YbQDjosdO4r
         vL8ghT1rUXJvz30n/DQbutxHHwOmYrpAvMRAVV3m105557ydlJNJtSsvv5sViRoWNE2a
         WWsA==
X-Gm-Message-State: AOAM5315EObBRS6ODScpW1cDV4EN9QtxcK/xtsh38EFIQtJg46LfsyFE
	abXdWuMu6HCRbcKso7aJsHb0RcBC+tISbwMHN7Q1pg==
X-Google-Smtp-Source: ABdhPJzhP/d5r5MCA8c5O3EKtsr6nKURNW9JgWhqYU0ARu+Tgyy09rsNfRCnS7qLLeEgVIGM4c4UU+UTtDfSkZ5pAeA=
X-Received: by 2002:a17:906:ef2:: with SMTP id x18mr11475415eji.323.1618629938929;
 Fri, 16 Apr 2021 20:25:38 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Apr 2021 20:25:28 -0700
Message-ID: <CAPcyv4iUPPY7XpwwY1zK3VGUY72p+zZckSCwgWuvJa183Y_QBA@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fixes for v5.12-rc8 / final
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: LIJFL73JYCYRCLW7YYK7YKMIXHMEG4XB
X-Message-ID-Hash: LIJFL73JYCYRCLW7YYK7YKMIXHMEG4XB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LIJFL73JYCYRCLW7YYK7YKMIXHMEG4XB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

...to receive a handful of libnvdimm fixups.

The largest change is for a regression that landed during -rc1 for
block-device read-only handling. Vaibhav found a new use for the
ability (originally introduced by virtio_pmem) to call back to the
platform to flush data, but also found an original bug in that
implementation. Lastly, Arnd cleans up some compile warnings in dax.

This has all appeared in -next with no reported issues.

---

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-for-5.12-rc8

for you to fetch changes up to 11d2498f1568a0f923dc8ef7621de15a9e89267f:

  Merge branch 'for-5.12/dax' into libnvdimm-fixes (2021-04-09 22:00:09 -0700)

----------------------------------------------------------------
libnvdimm fixes for v5.12-rc8

- Fix a regression of read-only handling in the pmem driver.

- Fix a compile warning.

- Fix support for platform cache flush commands on powerpc/papr

----------------------------------------------------------------
Arnd Bergmann (1):
      dax: avoid -Wempty-body warnings

Dan Williams (2):
      libnvdimm: Notify disk drivers to revalidate region read-only
      Merge branch 'for-5.12/dax' into libnvdimm-fixes

Vaibhav Jain (1):
      libnvdimm/region: Fix nvdimm_has_flush() to handle ND_REGION_ASYNC

 drivers/dax/bus.c            |  6 ++----
 drivers/nvdimm/bus.c         | 14 ++++++--------
 drivers/nvdimm/pmem.c        | 37 +++++++++++++++++++++++++++++++++----
 drivers/nvdimm/region_devs.c | 16 ++++++++++++++--
 include/linux/nd.h           |  1 +
 5 files changed, 56 insertions(+), 18 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
