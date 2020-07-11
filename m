Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FC521C18A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 11 Jul 2020 03:26:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7CE2811156F1A;
	Fri, 10 Jul 2020 18:26:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0B6BA11156F18
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jul 2020 18:26:39 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z17so5975700edr.9
        for <linux-nvdimm@lists.01.org>; Fri, 10 Jul 2020 18:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FjrM6YbUyqhD93+HtMW7ZllqWvaztpbqB/gNMOtGURo=;
        b=uJrPPKby1RgmkwDyZHBpFkBfJ9KFD0OuqUmYfgNoVzQzoUKJzLQkskDmDAfFHuZ2NY
         T2BnhLWVnZfDeL/yNilOhadrYLWHfVnzL4/E7e49tjrdHqiCuxoV+erP5Osq8v5yGCql
         PwHGs6YSAcPgrF8YzfqA+s6TH+U8vt96voUmimZR66l1K8R5RK6nOwADrW3d2OMdBFoM
         UN+2SEbAkTuqKfE30XdGW113kx05fAgVeX1Akar1FM4eci8rNx2nRaWp1vYwUmff84jZ
         b94ym6jIEU4Cqnni62TODUGGnvtFaavfr4EcIyPQymSWLag08SYG4K+kSfqtGhlvgdoK
         XqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FjrM6YbUyqhD93+HtMW7ZllqWvaztpbqB/gNMOtGURo=;
        b=H5ibibrYP8TZ/N+TSUCDmNSQ/Wbw9w8ISCDoDwlaV4p4YTYaf7x53r0lkQ/MebjnTi
         l6OMu+VNq7xP9h29aP1Zj00+2PFLBVPWrcsNnowwF6CgTMEoiKZXpPAHoSTTKxfzssuv
         hwPubDAAHOw8JnqMlJEEW3quKNPCxJVRS4wUQlLf4QmHSb15rrfZ5oaAcFmYeTH+3rwZ
         RwHfp+NxpNaByonXobXz1ZOKmB9Y/0A1hnCxgCfqFLpHc6HgFwNovQcuSFe2nRXSpodF
         TcqPy7Po/kF/2KxH+wyJfrdm29SqtBrM+zNhOSBu/G+B+yAp33mSxxwOqsswY+x1CLut
         bw5A==
X-Gm-Message-State: AOAM532pG1uhqz4OusySouEb6sXMVIla0v41K0i5A2h2F21c2iFpPajw
	cnnlS6zX0pykOY+H9vWurj8J6MEiy+e+AWGSiHOw1w==
X-Google-Smtp-Source: ABdhPJxaZWb0EaVxpvyuj0PNC4kHH62YNE23Hgn1jOXx+/IdRo57yhZxCnNSc+gMvja7FX2n7rAL1tZGmTOYfy3RY6I=
X-Received: by 2002:a05:6402:21c2:: with SMTP id bi2mr79608854edb.296.1594430798458;
 Fri, 10 Jul 2020 18:26:38 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 Jul 2020 18:26:27 -0700
Message-ID: <CAPcyv4jSHxx-dscb7PAadNVBWhVWgT_iczah_6TQ=JSprw9ZNg@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fix for v5.8-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: RQOMLFLFM5KSCBDMC34EAUB6ZIFZ4NDP
X-Message-ID-Hash: RQOMLFLFM5KSCBDMC34EAUB6ZIFZ4NDP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RQOMLFLFM5KSCBDMC34EAUB6ZIFZ4NDP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fix-v5.8-rc5

...to receive a one line fix for a regression from some of the 'keys'
subsystem reworks that landed in -rc1. I had been holding off to see
if anything else percolated up, but nothing has.

Please pull, thanks.

---

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fix-v5.8-rc5

for you to fetch changes up to 813357fead4adee73f7eca6bbe0e69dfcf514dc6:

  libnvdimm/security: Fix key lookup permissions (2020-07-08 17:08:01 -0700)

----------------------------------------------------------------
libnvdimm fix for v5.8-rc5

Fix key ring search permissions to address a regression from -rc1.

----------------------------------------------------------------
Dan Williams (1):
      libnvdimm/security: Fix key lookup permissions

 drivers/nvdimm/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
