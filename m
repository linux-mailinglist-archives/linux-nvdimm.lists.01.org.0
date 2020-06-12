Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ABC1F7F0A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 13 Jun 2020 00:47:07 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 85324100A05CF;
	Fri, 12 Jun 2020 15:47:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3E966100A0830
	for <linux-nvdimm@lists.01.org>; Fri, 12 Jun 2020 15:47:02 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g1so7512509edv.6
        for <linux-nvdimm@lists.01.org>; Fri, 12 Jun 2020 15:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2LCJlPjQS0gd4aoPiMI6xbg97Spn/0YYSiPlNrj5IrU=;
        b=fortF6f1kvl3IV2y2CB+0zJ6WvpATfMGUcgF5oUrAxMu1rYMY5zjRkS66sDRr5nOJ0
         ytTSAEhGL/y84gWKEKvIXRyFFD2iY39+jorRG3+9kimLTpbBPrbKtFuHOsswExzf1KTf
         jFmHBd50RTeoc7e/9UkxpLSz1rzGd+Jq9e+qPU0pWtKt4FEsOutCOLS3VVEWNvBxOiCo
         GA7/JVMenN8HtZRAIJBbmajGWbHanikY6jtrimLmqPEGExtcuJGpbQC5l4B5+v300JXr
         V5QKd+4VKibZzffoCyi81sjd3NCoSLnvh7h0PRni7WwWh6ZYvtxWcZJOP7Krv/VgbFj7
         ZAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2LCJlPjQS0gd4aoPiMI6xbg97Spn/0YYSiPlNrj5IrU=;
        b=D0KIN5XEjLv0NfEk6vEvDI5U9HQfiYfJ3lqPj90kB2FRYXNIqsMwbBlvclxcCl2UPL
         irQcouJrguRVZE2MtArr0JpdPF69qnkpPEBxuIcSfuEYDs4NAMkMKAPb0QIeciak28YQ
         U1pAGalsyytg/fjlPVqEI7g4tRg8FSn5Z00A9Ch4tPD+/PLN1dgdMN/6ebt9pC1Ap/GF
         30DzjDBgsUx6LY1ep4MuJ0kanPdi0QmE6v8zjzrOh5dTHqfWrWgtMtV3SVSnuPOjrook
         cEWPaQb0ou103SGb9W1ZCtDh8jvy5F2Osm2A0VTdlkJ1qU9d7x/zD9VCZAbeFjQ5FIXh
         APWg==
X-Gm-Message-State: AOAM531apYGHw5LEPIUqQRNQJwy5ZeZ5LyiBmB6T3hclpHEqvhZJzaaX
	T/k7YlsiN6J3AahGSvVexaf87TkXCR6fj47hf+KkqQ==
X-Google-Smtp-Source: ABdhPJxNe68eLGh3J4q+DFbYhyzpnTNd+T3ljiVc/zosVTnbXp/wpXXs3GloAfAO/DB7e69vJ+Aa9oWtwEehNctjfbU=
X-Received: by 2002:aa7:c489:: with SMTP id m9mr14552170edq.102.1592002021252;
 Fri, 12 Jun 2020 15:47:01 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 12 Jun 2020 15:46:50 -0700
Message-ID: <CAPcyv4jDQ9VVZJTD=cz+VvPxo6FNQGbW=BYA1Qhix-yQkSWeCQ@mail.gmail.com>
Subject: [GIT PULL] libnvdimm for v5.8
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: 444NPHZ7F6QBM2T5PO46ZYLFGWBHDYDP
X-Message-ID-Hash: 444NPHZ7F6QBM2T5PO46ZYLFGWBHDYDP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/444NPHZ7F6QBM2T5PO46ZYLFGWBHDYDP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.8

...to receive a smattering of cleanups for v5.8. I was considering at
least one more late breaking topic for -rc1 (papr_scm device health
reporting), but a last minute kbuild-robot report kicked it out. I
might bring that back for -rc2 since it was nearly ready save for that
late breaking test report.

Otherwise, this has appeared in -next with no reported issues.

---

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.8

for you to fetch changes up to 6ec26b8b2d70b41d7c2affd8660d94ce78b3823c:

  nvdimm/pmem: stop using ->queuedata (2020-05-13 15:15:37 -0700)

----------------------------------------------------------------
libnvdimm for 5.8

- Small collection of cleanups to rework usage of ->queuedata and the
  GUID api.

----------------------------------------------------------------
Andy Shevchenko (1):
      libnvdimm: Replace guid_copy() with import_guid() where it makes sense

Christoph Hellwig (3):
      nvdimm/blk: stop using ->queuedata
      nvdimm/btt: stop using ->queuedata
      nvdimm/pmem: stop using ->queuedata

 drivers/acpi/nfit/core.c | 2 +-
 drivers/nvdimm/blk.c     | 5 ++---
 drivers/nvdimm/btt.c     | 3 +--
 drivers/nvdimm/pmem.c    | 6 +++---
 4 files changed, 7 insertions(+), 9 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
