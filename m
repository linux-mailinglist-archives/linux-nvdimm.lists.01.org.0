Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E84E2381446
	for <lists+linux-nvdimm@lfdr.de>; Sat, 15 May 2021 01:33:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C6A39100F2268;
	Fri, 14 May 2021 16:33:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 13E33100ED4BA
	for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 16:33:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n2so930775ejy.7
        for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 16:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1+NbqxnUts2cERrUKprfSG6COch8OgsrINoj1msojwQ=;
        b=SE78uhsaW5vmO2PQwNgDVDEFZaLmLd2hYDNZhtr9Nt/nw9Asyt0kF6wBIRcaCQE94q
         iFo9NmUEMIp1hQL34Xw1iwYmf+UkAl2N+08lUDF845tzB4wZaLM/OM2gen6ONHUtYSz7
         CpZ1xfTo2Jg4UJ9OutADhkb19GX/5HMflMJF05nLMyzn5UQuaGvwkMIMASnORPA3Rd/P
         FgZ1/x3PNkA7FZCp8OHCYRsQxDUyfrhsvaBWylUAX4Glxf2WL1OoaFEoTsTPAbce7R3Y
         l10IgmrP7DIItHPkINgy5dP9A30nU7qafs9JueEYbZP/3+8ZFpGxN6oO2AultOlrolea
         smUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1+NbqxnUts2cERrUKprfSG6COch8OgsrINoj1msojwQ=;
        b=OCjQlBpazA3Q0EmBnorKrNun7xNi0Q/7S9b/xhzJDpNwYYGbjConZrBy7DxcVP9bug
         LIIF9/gAyApBx3ViewHYe/rEnETQmTOIyTvxqCyM/jS9w8Rm26rDN1lfV2XneDDuYrln
         9ECXZKPqguZEN+nqwRFDB2gr6QyFFMQaL5L6Ko/BipFyv55i6HLzEdVNUQWuZG+fyeko
         aR2fix0MU652QyBQcFkc8gRM4g5sIj18cQI/GZhLMEcmwwXewwSq3oB9xNVDsEs0suR2
         UO/KsmeOoY+5Qoq1BHtTC9Itr7LLqY9CGxf8fLz3+2mqly0MvrlBk2D1XomJAO72ylf8
         jnsw==
X-Gm-Message-State: AOAM530DsqnzfGou5f/NYfhiAL/Td6wdVoszDKCFKCAo/cBDFz52ZEdB
	Qcw9Atyfe52RAQVIJxiiJ20nJALdwXiQ5xaXnj8Npg==
X-Google-Smtp-Source: ABdhPJyg/1HU0s2ONvtTgrt5iERBgGgkS6JytB18uzIi8C03bdvf44hVYzlIqOF4VsHI3+YtSAzrMa4Jr9LrNS0IJRg=
X-Received: by 2002:a17:906:33da:: with SMTP id w26mr51913539eja.472.1621035213402;
 Fri, 14 May 2021 16:33:33 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 14 May 2021 16:33:22 -0700
Message-ID: <CAPcyv4hDfxpYh1rvvqFCQ+eNk_XxZD3grUOYkHWbERfxky43xQ@mail.gmail.com>
Subject: [GIT PULL] dax fixes for v5.13-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: 4Q3I2ZYTDSBXDS5JHOIPVLBZ7HRW6XMF
X-Message-ID-Hash: 4Q3I2ZYTDSBXDS5JHOIPVLBZ7HRW6XMF
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, nvdimm@lists.linux.dev
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4Q3I2ZYTDSBXDS5JHOIPVLBZ7HRW6XMF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fixes-5.13-rc2

...to receive a fix for a hang condition in the filesystem-dax core
when exercised by virtiofs. This bug has been there from the
beginning, but the condition has not triggered on other filesystems
since they hold a lock over invalidation events.

The changes have appeared in -next with no reported issues. The
patches were originally against v5.12 so you will see a minor conflict
with Willy's nr_exceptional changes. My proposed conflict resolution
appended below.

---

The following changes since commit 9f4ad9e425a1d3b6a34617b8ea226d56a119a717:

  Linux 5.12 (2021-04-25 13:49:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fixes-5.13-rc2

for you to fetch changes up to 237388320deffde7c2d65ed8fc9eef670dc979b3:

  dax: Wake up all waiters after invalidating dax entry (2021-05-07
15:55:44 -0700)

----------------------------------------------------------------
dax fixes for 5.13-rc2

- Fix a hang condition (missed wakeups with virtiofs when invalidating
  entries)

----------------------------------------------------------------
Vivek Goyal (3):
      dax: Add an enum for specifying dax wakup mode
      dax: Add a wakeup mode parameter to put_unlocked_entry()
      dax: Wake up all waiters after invalidating dax entry

 fs/dax.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --cc fs/dax.c
index 69216241392f,df5485b4bddf..62352cbcf0f4
--- a/fs/dax.c
+++ b/fs/dax.c
@@@ -524,8 -535,8 +535,8 @@@ retry

                dax_disassociate_entry(entry, mapping, false);
                xas_store(xas, NULL);   /* undo the PMD join */
-               dax_wake_entry(xas, entry, true);
+               dax_wake_entry(xas, entry, WAKE_ALL);
 -              mapping->nrexceptional--;
 +              mapping->nrpages -= PG_PMD_NR;
                entry = NULL;
                xas_set(xas, index);
        }
@@@ -661,10 -672,10 +672,10 @@@ static int __dax_invalidate_entry(struc
                goto out;
        dax_disassociate_entry(entry, mapping, trunc);
        xas_store(&xas, NULL);
 -      mapping->nrexceptional--;
 +      mapping->nrpages -= 1UL << dax_entry_order(entry);
        ret = 1;
  out:
-       put_unlocked_entry(&xas, entry);
+       put_unlocked_entry(&xas, entry, WAKE_ALL);
        xas_unlock_irq(&xas);
        return ret;
  }
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
