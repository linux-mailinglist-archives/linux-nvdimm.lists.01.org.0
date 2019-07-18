Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E7E6CFF5
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 16:37:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B14A6212CFEC5;
	Thu, 18 Jul 2019 07:39:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::841; helo=mail-qt1-x841.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D3486212C01FB
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 07:39:47 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d17so27356709qtj.8
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=P952fJXBLk5gGmwzQWc4AdTbQsUFnxHNQ/JjKtt4NKc=;
 b=mGythxfugEaFvl0wyE39KZQUFGsK+FuHqI4IU0NimV+KcqB82JKwxtNkJYwrBATEBJ
 c/Cd25vpiSXyQEREaH66Utgzdw+g4fYhB+0VYAuoTeM3N3qHyl6WbR75bH+NIKMeeV2e
 cwh63Sl3S1aqo4pnm12YqKlEYwetRIANDF33tUMpoThDQmnV52nqKcKScBS+gkn1/NOg
 Gh/63dvdIPrMahiYbuhKcWd/K40WXUA/XWKiL3WlKx43udHTGN0e8l7ez0zyLgGYXACv
 1frTvKYJdrQcaikMAbT7y6F/IaYIQGvG4gJZbmukAWqiNzL8aHkITUKWY+7kcYHXvu/g
 wmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=P952fJXBLk5gGmwzQWc4AdTbQsUFnxHNQ/JjKtt4NKc=;
 b=k6mWvSYLjzwAMxWKd3eUqxK3aDhk0+L5ZHigP8vL0ZBYOAWYC+Ld5QS2WetHJ9+B55
 TZyfHVKP+dJfsnLbGgnpTzX027EmNxrpDYRIGVhFKcG3t0bdfEU/k5gzKxs03LfRGtqZ
 beqbpRMteORN+l3St/O5ywwuucPAa0QDzVJuUkN2x4jnTlUMlbVatdkrFztDo0VZiYY5
 8WOZeB2fAO9Be3gwebdI6w2DLGzjr2RzNAGulQzxh/CBBEIg9NDVwol97tAHWTE37ql9
 mRbO6raau9Y3U+KWTrRFWRVrhpuA7NufxEyxfHPJ36RpePyN+XTOHpV384mq4vshX2zF
 VfEQ==
X-Gm-Message-State: APjAAAVIDBinSrbEXdTkQxjVrZ5KwrF3F4CcTnFfc2LCf9uf17mtswLw
 UK1LEL8Dxk2vOMmOBqoyUEFrtO3VRKmbNxoPPBpAQA==
X-Google-Smtp-Source: APXvYqwlRBjp0w1syFaW3nPSBwwug0SrJnGWLAMIYDiIoIGHAU6aSAPrRGiIr53fvkPxLKi+KZvUIFrxm7qmxiv9rs8=
X-Received: by 2002:ac8:1e8a:: with SMTP id c10mr31333075qtm.45.1563460638305; 
 Thu, 18 Jul 2019 07:37:18 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 18 Jul 2019 07:37:07 -0700
Message-ID: <CAPcyv4jMjvPYTa00hbq=64LZ=Vcu-gi7hLcgDTnD9d4dF0t9ng@mail.gmail.com>
Subject: [GIT PULL] dax for 5.3
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
 Matthew Wilcox <willy@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-for-5.3

...to receive the fruits of a bug hunt in the fsdax implementation
with Willy and a small feature update for device-dax. These have
appeared in a -next release with no reported issues.

---

The following changes since commit 9e0babf2c06c73cda2c0cd37a1653d823adb40ec:

  Linux 5.2-rc5 (2019-06-16 08:49:45 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-for-5.3

for you to fetch changes up to 23c84eb7837514e16d79ed6d849b13745e0ce688:

  dax: Fix missed wakeup with PMD faults (2019-07-16 19:30:59 -0700)

----------------------------------------------------------------
- Fix a hang condition that started triggering after the Xarray
  conversion of fsdax in the v4.20 kernel.

- Add a 'resource' (root-only physical base address) sysfs attribute to
  device-dax instances to correlate memory-blocks onlined via the kmem
  driver with a given device instance.

----------------------------------------------------------------
Matthew Wilcox (Oracle) (1):
      dax: Fix missed wakeup with PMD faults

Vishal Verma (1):
      device-dax: Add a 'resource' attribute

 drivers/dax/bus.c | 19 +++++++++++++++++++
 fs/dax.c          | 53 +++++++++++++++++++++++++++++++++--------------------
 2 files changed, 52 insertions(+), 20 deletions(-)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
