Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 679A4159B97
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 Feb 2020 22:49:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BA0F71007A82E;
	Tue, 11 Feb 2020 13:52:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 116591007A82B
	for <linux-nvdimm@lists.01.org>; Tue, 11 Feb 2020 13:52:25 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id l9so14330010oii.5
        for <linux-nvdimm@lists.01.org>; Tue, 11 Feb 2020 13:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FVB/FcS1YOjObTBIYNnVwzrPxX/PinI+dOSwT8ez2L8=;
        b=y9yAC60AVrZQixjl326TyeNDbhyODKMwz9kKbdXLmYJ7yuLP7+N/R7imC2n5zmdjsd
         xbQWK68oFv3C0BdUgO/mnokdGoADVVi54e6xpDyWasTg/i9BHP37QqPhIMeru8YsxH81
         L76OFlAE096nnOxGKP1NP0crqf6AQGzM145x0vn2YDA3gi7kemrtwulQmVhIF0KumRDs
         qT24enBkvSv6FAkgalwyqYijjHETJLlx2tCbLwLAShAX4rlYMjAJ94HFB9HlauYK6Rxn
         no/KdVjAPrJon48Fth0FK03FqHomy5Pzl0NvHWL2YUQzxOk1aGvQA3OC0n4hJOnB1hvq
         hgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FVB/FcS1YOjObTBIYNnVwzrPxX/PinI+dOSwT8ez2L8=;
        b=Aoc11vEjegZky4SnadnaPJeXEuwpWNMxp0ZRdJWTzVY80qH7DXt+YGeL3/S964Upki
         bABU0FrcyuPhl10O1xRlHkixx/zXnzz++ETwR/nhqXg0qfKiCUH3LwMI09JncD5/5Fnq
         bj9Z9KoZmT/5U/SBKfHOCqcG5HTnHHggTGGKOtGZmHePRtBFCdLKYve8tqNInL/ZTiAI
         BLaTVzYsV47O1jXxCs6yL1C7hYxnFkdM2uk9W0vD8farHiHHv35EnjwXtAky3iz7I/ne
         Q1Du9Ggf2W5+UeB4eaHwFgOGZlt5Qft203ob74L4ep41zH19PNm8RHLNOsY509okgFzy
         63xg==
X-Gm-Message-State: APjAAAW8kZcWH3MZksprRXO4oqh6qCC0w8oh4KocGdJqoaIM/iS79pSl
	rGXoSuNL1xVAqLXnjJ5bb8NJwPSF8uBMvPZMldAF7A==
X-Google-Smtp-Source: APXvYqy8Gw71waEd6oNkzeNXV51JRxA7IyRoFOyWOQUMhEEWpqf0WTeOmjmyRiRWGbyVxa175PNVu9gVDG5VrM6mXw4=
X-Received: by 2002:aca:aa0e:: with SMTP id t14mr4249907oie.149.1581457747093;
 Tue, 11 Feb 2020 13:49:07 -0800 (PST)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 11 Feb 2020 13:48:56 -0800
Message-ID: <CAPcyv4iQf80XGwYVU3-GnbxU7u+bu2bn=+MwM54WGyG1kN=ddQ@mail.gmail.com>
Subject: [GIT PULL] dax fixes for v5.6-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: 3ICVH4PVVE5AWD2UUVXK45BOTZC7DNJB
X-Message-ID-Hash: 3ICVH4PVVE5AWD2UUVXK45BOTZC7DNJB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3ICVH4PVVE5AWD2UUVXK45BOTZC7DNJB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fixes-5.6-rc1

...to receive a fix for an xfstest failure and some and an update that
removes an fsdax dependency on block devices. The update is small
enough that I held it back to merge with the fix post -rc1 and let it
all appear in a -next release. No reported issues in -next.

---

The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fixes-5.6-rc1

for you to fetch changes up to 96222d53842dfe54869ec4e1b9d4856daf9105a2:

  dax: pass NOWAIT flag to iomap_apply (2020-02-05 20:34:32 -0800)

----------------------------------------------------------------
dax fixes 5.6-rc1

- Fix RWF_NOWAIT writes to properly return -EAGAIN

- Clean up an unused helper

- Update dax_writeback_mapping_range to not need a block_device argument

----------------------------------------------------------------
Jeff Moyer (1):
      dax: pass NOWAIT flag to iomap_apply

Vivek Goyal (2):
      dax: Pass dax_dev instead of bdev to dax_writeback_mapping_range()
      dax: Get rid of fs_dax_get_by_host() helper

 drivers/dax/super.c |  2 +-
 fs/dax.c            | 11 ++++-------
 fs/ext2/inode.c     |  5 +++--
 fs/ext4/inode.c     |  2 +-
 fs/xfs/xfs_aops.c   |  2 +-
 include/linux/dax.h | 14 ++------------
 6 files changed, 12 insertions(+), 24 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
