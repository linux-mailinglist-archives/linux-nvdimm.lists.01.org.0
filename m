Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADAF128B9D
	for <lists+linux-nvdimm@lfdr.de>; Sat, 21 Dec 2019 22:07:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 058611011368C;
	Sat, 21 Dec 2019 13:10:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 452E810113685
	for <linux-nvdimm@lists.01.org>; Sat, 21 Dec 2019 13:10:52 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id c22so16667078otj.13
        for <linux-nvdimm@lists.01.org>; Sat, 21 Dec 2019 13:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IQDzCGNeAK5EBtUX/LCaBsUYMxFLJD3gX/4djK3YpRc=;
        b=Qc99rLKJgNWmEo4aen5nEwhzg0Id7tJ25T7TMJzjSGBHrUlcLKVEARoCtwqqkbUWnx
         uupcmM2Kbu4hbAw+axe5k9rWtzyRnSRh9NrhQFLqGNJUn/rIBg9PASLauLvb+vXYLhi0
         SacpUI9vfda6grwUlYTSOaw6h8UCjDlPm3ZUzgCBW9io+sF2BOjtT52nu07Cp9Frd9fu
         DjjItt4s6wdKeRzbzjKJa2v1ephnx7CZBesu0nHlod7IUS5zjBOa0gD/oVDl/rQquKGI
         8nXANHDmPfeB6GH6iebGxM+Jrd+AWW14x7IYdBPfs5Q5sL6c3/uF860uGgO9MCuHJ8e7
         v5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IQDzCGNeAK5EBtUX/LCaBsUYMxFLJD3gX/4djK3YpRc=;
        b=TuJ1ui1kvJZdlXj1CtvwFJ5c7xE50mJEINFSizebcU7SR2BKnORVkYl2zCplnRzGVQ
         Z6NPvbKZzgW2uTHSfnL1VqdJ1mQsc7S0YezHamdYCHiE8dVS0ZvduHg1zmKsrDIjt8gJ
         PdgXVnvsaAlraIFTy3WV2t6L0hMfUwVtecQm5hGVhU4KE1HGCIhvVp4CKMI+TqkhcTGf
         qp+3xyfZAd5SMCPu9ZtrgdU24b3eA0C2EXo9ClRcZQLWs+2JmPjz5Nhwfo1FF6x/mRf9
         PmA8TInoW9D6nj2XlNmkcxDnAyqyy2IFyHLL6D2vTyl+rz5zqd7vHsCmw0TI8RipsYtI
         rVYg==
X-Gm-Message-State: APjAAAXRGy6aNZl/Wbe9davdLBy0WGQV0pfjIihHkALbCSRoj+Yo3P3Z
	17aLIITWX9J2A2lWk2weVdnqTG4a4Q0aY+m7TliMMQ==
X-Google-Smtp-Source: APXvYqzA75IgQS6VboqDPPddv0Nmm2P0sHQlEcSJ/8iJ0sdo9xLSQTvgYrEfrvkcQTYOnRoSpRzPnKHKGsvCcFyyDks=
X-Received: by 2002:a05:6830:174c:: with SMTP id 12mr4748830otz.71.1576962451276;
 Sat, 21 Dec 2019 13:07:31 -0800 (PST)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 21 Dec 2019 13:07:20 -0800
Message-ID: <CAPcyv4gfbuttbdW0ea6EUzMihUK33cc0mBQmLjqZe1T_QCKF-Q@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fix for v5.5-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: DLV55TEWTWAJ4QWXLZBH62O7GO2HZZW6
X-Message-ID-Hash: DLV55TEWTWAJ4QWXLZBH62O7GO2HZZW6
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@lst.de>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DLV55TEWTWAJ4QWXLZBH62O7GO2HZZW6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fix-5.5-rc3

...to receive a minor regression fix. The libnvdimm unit tests were
expecting to mock calls to ioremap_nocache() which disappeared in
v5.5-rc1. This fix has appeared in -next and collided with some
cleanups that Christoph has planned for v5.6, but he will fix up his
branch once this goes in.

---

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fix-5.5-rc3

for you to fetch changes up to c1468554776229d0db69e74a9aaf6f7e7095fd51:

  tools/testing/nvdimm: Fix mock support for ioremap (2019-12-11 17:11:10 -0800)

----------------------------------------------------------------
libnvdimm fix 5.5-rc3

- Restore the operation of the libnvdimm unit tests after the removal of
  ioremap_nocache().

----------------------------------------------------------------
Dan Williams (1):
      tools/testing/nvdimm: Fix mock support for ioremap

 tools/testing/nvdimm/Kbuild       | 1 +
 tools/testing/nvdimm/test/iomap.c | 6 ++++++
 2 files changed, 7 insertions(+)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
