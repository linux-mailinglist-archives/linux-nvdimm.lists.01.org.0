Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D56435FEF3
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jul 2019 02:11:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3CB53212B2046;
	Thu,  4 Jul 2019 17:11:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9AC07212B2042
 for <linux-nvdimm@lists.01.org>; Thu,  4 Jul 2019 17:11:27 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a127so5977496oii.2
 for <linux-nvdimm@lists.01.org>; Thu, 04 Jul 2019 17:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=+KUa/pKnTzDUY8iKea0h5ooJheLbdX4Z7I3oB9ImT1k=;
 b=Csg0RK3gwejbtYn9Bb96veoScBvqb+LsOvHsMSjOVUfAQG6kL/HEasbVW03BPfrMDM
 ZeuMYi7iMCiXFYjKO7NNNvzX383rUBtSgQ7jb3iBxp0V4Cn64eMPQKIQJKzoxBXC7f46
 yq3qgX3oNi7KDe8mpw9URsinu3RdiHrxyNpf36txzLyNzX72aa5f/LyG71Vb4G3+ESVY
 3yFaL+JvV4wjgoWuBheorPaqmTVmjQj7WTkiaYl9yFoJInHv5PTAvYtbG+mrvIC1dO3T
 8UwG5AR2e7+7Lz/RRbqy9+ghEdHrOmb7R1lfER1Z2hAF8juynW3DZExwrjdWUIE5cTZd
 5pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=+KUa/pKnTzDUY8iKea0h5ooJheLbdX4Z7I3oB9ImT1k=;
 b=E2p5SMI7y8p84Qa+5DZmVkTQ6eeyhtF2mg1DloR6yb49SRFBdquu65zt92/sYtW5sh
 N2EXOCrgLSwiqMQ/rX3Ys4KHcUJ/jfX6lWfrrEAuIjbTiBN/hmkdSGQfNsqMPeIJC6Pk
 LM4Df4UshG9xhPnK98Dxz15LPHbEUZ9A1FVagLdzExjEJmnsZ9kjy3AytbcEO/tJ07oj
 5gCm8nzUeCc7lRidxU5nUQ57OX5HXg6VakbAPkA/SoewlfctBW49A2FErMNA+4HDExQu
 MaFqW8QYpT0D1Zu4L1kWHCLJvu/+xSBXflg5fbjPLLHJ+E/BbaMywTWzeJwZ6c6/O+Nh
 r4yQ==
X-Gm-Message-State: APjAAAVruIlxmsOskdsS3QbI7Gxrl92l3+Tk6vyVk13EDaZRjlbQ2a5r
 Sr1eGkl2dLrugNwE1vedyCUM8dk08777btU+3oXB4g==
X-Google-Smtp-Source: APXvYqzlFmpt61vIj6L8l0EpOJd4L4Dl2URxNXWw5ml57YfYsXHkMntq9TesGECcSO3CKqdxrpnlkYkyniCr9rxgMas=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr461198oih.73.1562285486732; 
 Thu, 04 Jul 2019 17:11:26 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 4 Jul 2019 17:11:16 -0700
Message-ID: <CAPcyv4hs6bncxc3_vOKYYc-XdL+-dv_dJkmV8EduRrshv3rBgQ@mail.gmail.com>
Subject: [GIT PULL] dax fix for v5.2-rc8
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
Cc: Jan Kara <jack@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fix-5.2-rc8

...to receive a single dax fix that has been soaking awaiting other
fixes under discussion to join it. As it is getting late in the cycle
lets proceed with this fix and save follow-on changes for
post-v5.3-rc1.

---

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fix-5.2-rc8

for you to fetch changes up to 1571c029a2ff289683ddb0a32253850363bcb8a7:

  dax: Fix xarray entry association for mixed mappings (2019-06-06
22:18:49 -0700)

----------------------------------------------------------------
dax fix v5.2-rc8

- Ensure proper accounting page->index and page->mapping, needed for
  memory error handling, when downgrading a PMD mapping/entry to PTE size.

----------------------------------------------------------------
Jan Kara (1):
      dax: Fix xarray entry association for mixed mappings

 fs/dax.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
