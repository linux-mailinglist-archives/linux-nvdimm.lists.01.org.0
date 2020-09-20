Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A63C27173D
	for <lists+linux-nvdimm@lfdr.de>; Sun, 20 Sep 2020 20:56:07 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 41CF014C226EC;
	Sun, 20 Sep 2020 11:56:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B439D13FD9ED7
	for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 11:56:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q13so14737341ejo.9
        for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ndUrGHBk92F1HUk+uxxSKtBUDi6Sd7JPiTr1APxGa3w=;
        b=06+rJhdHVsBikc7My0jVdVWkFb6ll1c13PfOBaXFzXenuTkKwBRq+WHycaid/goujl
         vamZD6pIPUPBN2IevX0wGsoK1NY5XskGD4kP73Z/SRFMTvfT1BGRZy1p8HihAd1W9R4l
         DSjRGcwIfknnzdONQaCLqDdXHdw1gKQu3qCry/JTCaqAcaWhya8UrzZ9Nac//COnDQZx
         4uFTrCbGoL4RDWBCqiha51wc3/BcXxU59qX6LQtoYmJwkqBKGmAV7gUrysMGPfTxhM8e
         +YWXlZhBuWN31arVAB1ix7QvtwiAMLjlIgSO9n/j/JedEUD8YUYp0qubfIPo6EPyI2Bb
         uDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ndUrGHBk92F1HUk+uxxSKtBUDi6Sd7JPiTr1APxGa3w=;
        b=NXsXfrf715/jFZH3oXapzO593mSWaWl1dvQYMx98PcxkLAVsw4uY9Dre6eAQLtClWv
         6TQK+wXPxDc5ODEOT/2wugrcTxh0mSfblGs5xQqRdpu5nsBWlhr7ErGDkUK4YGGPvKEG
         3dMr6tIcx9xe1PSxJTSXLqPs46Rec7CWMFj8UV98JFec0vEhc1rF+lXui+u3Cjj+h7kZ
         VT54n1wGJXwjIjE1nJ2GKIWYwMtXZ7TgPYQmgUArDICE3ovbaWkgOMzrCXCVsNHOSa10
         gDFdaHIr0gz701Mwy49G2CKj6YHXaVEAY+v5d1eDKgFhMWTu+eNGjaXJUPsA7F6noize
         4Q1g==
X-Gm-Message-State: AOAM5310Cmn3+x0MVmbutTYe8pmIW/LpWPh1JRlwOTWvZFXe9l4UiRza
	KUw6hNNce03OuqrNUWaSrf6HCqCXgz4SP89/M25lgg==
X-Google-Smtp-Source: ABdhPJw5iohlXyCeLttrxkgBFQjc3U6GHH9QAJRXr6ebWx59BVm+Rbod9dk6PHIoy/8UAn87A2YkjANX8lc0r9162HY=
X-Received: by 2002:a17:906:8289:: with SMTP id h9mr46107743ejx.45.1600628159425;
 Sun, 20 Sep 2020 11:55:59 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 20 Sep 2020 11:55:48 -0700
Message-ID: <CAPcyv4h3oKM-2hoG=FWHJwzVqjptnpQV9C+W6txfp_qcBhd7yQ@mail.gmail.com>
Subject: libnvdimm fixes 5.9-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: YKOT5CTXLM6KZ2NUB45XTMFOTJGJKSHH
X-Message-ID-Hash: YKOT5CTXLM6KZ2NUB45XTMFOTJGJKSHH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, device-mapper development <dm-devel@redhat.com>, Jan Kara <jack@suse.cz>, Adrian Huang12 <ahuang12@lenovo.com>, Mike Snitzer <snitzer@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YKOT5CTXLM6KZ2NUB45XTMFOTJGJKSHH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.9-rc6

...to receive a handful of fixes to address a string of mistakes in
the mechanism for device-mapper to determine if its component devices
are dax capable. You will notice that this branch was rebased this
morning and it has not appeared in -next. I decided to cut short the
soak time because the infinite-recursion regression is currently
crashing anyone attempting to test filesystem-dax in 5.9-rc5+. The
most recent rebase folded in a compile fix reported by the kbuild
robot for the uncommon CONFIG_DAX=m case. It should, "should",  be all
good now.

---

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.9-rc6

for you to fetch changes up to d4c5da5049ac27c6ef8f6f98548c3a1ade352d25:

  dax: Fix stack overflow when mounting fsdax pmem device (2020-09-20
08:57:36 -0700)

----------------------------------------------------------------
libnvdimm fixes for 5.9-rc6

- Fix an original bug in device-mapper table reference counting when
  interrogating dax capability in the component device. This bug was
  hidden by the following bug.

- Fix device-mapper to use the proper helper (dax_supported() instead of
  the leaf helper generic_fsdax_supported()) to determine dax operation
  of a stacked block device configuration. The original implementation
  is only valid for one level of dax-capable block device stacking. This
  bug was discovered while fixing the below regression.

- Fix an infinite recursion regression introduced by broken attempts to
  quiet the generic_fsdax_supported() path and make it bail out before
  logging "dax capability not found" errors.

----------------------------------------------------------------
Adrian Huang (1):
      dax: Fix stack overflow when mounting fsdax pmem device

Dan Williams (1):
      dm/dax: Fix table reference counts

Jan Kara (1):
      dm: Call proper helper to determine dax support

 drivers/dax/super.c   | 16 ++++++++++------
 drivers/md/dm-table.c | 10 +++++++---
 drivers/md/dm.c       |  5 +++--
 include/linux/dax.h   | 22 ++++++++++++++++++++--
 4 files changed, 40 insertions(+), 13 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
