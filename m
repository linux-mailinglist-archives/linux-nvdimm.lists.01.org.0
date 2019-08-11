Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 250BA8933B
	for <lists+linux-nvdimm@lfdr.de>; Sun, 11 Aug 2019 21:01:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 94661212E843A;
	Sun, 11 Aug 2019 12:03:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A1E23212E4B65
 for <linux-nvdimm@lists.01.org>; Sun, 11 Aug 2019 12:03:41 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id r20so1718762ota.5
 for <linux-nvdimm@lists.01.org>; Sun, 11 Aug 2019 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=8CYB75tEXZ2XGjArz0sIzOXQhMzMA9ETRG0W57479F8=;
 b=0oOGBZDHawnT6tmmA7FIAOOT8r1zBTfrvPcrZf5O/ihWNLAllN93OL9uP95I9VkQmM
 nP5hxw8LFtTmglndTHiTXYpR3W3jYv56Gl6E0js3c83nUptmb2OdO+3Bbco9QmsAeD4h
 KtlxjbFd8VhocheXPss1Yt538XYGlGyAwtHOP/ZaPWOM9gYX6RFWSaOTsqn9J5nPUmkU
 wnEidQKmM5iGTz8daURN3XxmKJbFD+gnM+K7NWcXx8pqMwwFQCFiLShU/t77cu3YPfU0
 UWdGRsUmyGm7l18Ex8CDjsMpYcqYlpvoHLgcu2u/xEmQPdbCFGq8G+wpm+0yLFxUPya+
 kcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=8CYB75tEXZ2XGjArz0sIzOXQhMzMA9ETRG0W57479F8=;
 b=K2luryogbAcRE+2WC5YMnsRUQRqsMN5StK+2UMis/u6HX6HWrHSCCpzWHEQRrIMoTx
 YoHfwuQgOXTIdBJN6kqAvw6NaxBC+OhKSlZEwpLofzy70D247nbblt8B27IshcqKx1wM
 I5tIYa5sq/zm7HkhArBPl9FADuLR+xrOyER8VkFrJ4uxMVRWN1P46Sp/LB4U0xevQepI
 geXu/RRCr04cmvayhf0EOKfTJha7HJp9Gtr4jNfgkqCB/glOXmqcxfzFHFu3gzbbiug4
 c0tpvgqZgFDAVJB5sPvfSQ8A3rpSwW2cuGTE18b9MV7MeygvHsNX0KeoFqGv1lbU3aYt
 +ExA==
X-Gm-Message-State: APjAAAVOyxqsQZWQsFumdFmWc0zHHzzz9zZ2RTyd3HNnHNwgUPVwJAsU
 TsjeILgQuJxUOjdrMFTyB26Ns29OM75+xo6uNwS4Nw==
X-Google-Smtp-Source: APXvYqxCBXehuIHD7MVGr3oQ6+9vulwhlOrxF2TSbUxwyaVksmmBcJbvCHzRAExD9UI669rmu+iqnsMwb1EjIkGlO98=
X-Received: by 2002:a9d:5f13:: with SMTP id f19mr19214592oti.207.1565550073180; 
 Sun, 11 Aug 2019 12:01:13 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 11 Aug 2019 12:01:02 -0700
Message-ID: <CAPcyv4iaYiXbv2sf-Znn5dYphLKEi77NjafkEzXA2kAEMqyR0w@mail.gmail.com>
Subject: [GIT PULL] dax fixes v5.3-rc4
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
tags/dax-fixes-5.3-rc4

...a filesystem-dax and device-dax fix for v5.3. The filesystem-dax
fix is tagged for stable as the implementation has been mistakenly
throwing away all cow pages on any truncate or hole punch operation as
part of the solution to coordinate device-dma vs truncate to dax
pages. The device-dax change fixes up a regression this cycle from the
introduction of a common 'internal per-cpu-ref' implementation.

The filesystem-dax fix has appeared in -next. The device-dax has not,
but it has been exposed on a kbuild-robot visible branch for the past
few days, and passes the nvdimm unit tests.

---

The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fixes-5.3-rc4

for you to fetch changes up to 06282373ff57a2b82621be4f84f981e1b0a4eb28:

  mm/memremap: Fix reuse of pgmap instances with internal references
(2019-08-09 14:16:15 -0700)

----------------------------------------------------------------
dax fixes v5.3-rc4

- Fix dax_layout_busy_page() to not discard private cow pages of fs/dax
  private mappings.

- Update the memremap_pages core to properly cleanup on behalf of
  internal reference-count users like device-dax.

----------------------------------------------------------------
Dan Williams (1):
      mm/memremap: Fix reuse of pgmap instances with internal references

Vivek Goyal (1):
      dax: dax_layout_busy_page() should not unmap cow pages

 fs/dax.c      | 2 +-
 mm/memremap.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
