Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6D42727BD
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 16:37:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 31FF513CEFAFE;
	Mon, 21 Sep 2020 07:37:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7EC8613ADD7B2
	for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 07:37:47 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id r7so18034706ejs.11
        for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YBeSXvLus4k89SuWvx5C+h9enofCPRsPbiAnHJnW60A=;
        b=tS8DgT5159bYCvJY40SO6VuwxrqT1cXXFOCm8aXmbbh2ry1aGWGb6uDClNfEGnai+B
         JGdMghZwvStBGl2hJBdKKtOJU8sr1wbo2sYxUewvTcW+gNi8IvoGxN8oM7rDOAYJ6SfN
         0cKY7AE18gM+TPAi1eihr5MX0mk1rVn17OyxvxhOt+aa2dbgIAVTFMvZ/LQD2F6GFd0s
         yzux9geU3RldxcPXVTFvORr7/Nxc0SyP13QMPqO3DW2/b6ALOomSesQcEe/wv3hL57VV
         woNHgefDKYI5bgHLIglA4y4OrrwTK/qlX4sfbumrzaPWQrIoYdKhuVbE2ngSqqFzHw6M
         wvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YBeSXvLus4k89SuWvx5C+h9enofCPRsPbiAnHJnW60A=;
        b=qBJtnq2bNWa/Pb1f/yNs99Msw8evmxcdLmc7OXFp5x9mJCUZe/gPbiaC1YBQ7Qi4fn
         P1EyNLt+YffIkaYTrKqcrSZoVIeToBlD/iVY8aKVmpDcnNKCqF9UzpDH371QjPIyVNUI
         hx3wAHKuePuL51bomVE7pVWE52PJofwtIVEutERmIkmM/G5w2AWgSaAMa5moMTdWyU/7
         phgUaiDp1+KeENIKqVnYqs9K9bh4bEACJCKC5krgKrLr6er9HImmJrJJsQCRd4s7NRDt
         ZVJjBpblr/CuuIheZMEaXIK7+RSd2OLP5sEMkqWODNuEQe7RtIu9AlBFM2TZFcei1uSC
         b1gg==
X-Gm-Message-State: AOAM533JV6bbXrxH3cRmWcIVntlrx09z1WxqLvJRGkTL9RKkqzM478Xr
	lQiYQGWx8I6t/MiZeiBMOjthmSTlkX0jROw8hD5o1Q==
X-Google-Smtp-Source: ABdhPJwhXtSU3n2JqzHAvWL+ObX1hB9FbR/lmhh7oSMUv6M9LaBZioM3dK7aIllUn7WLtwD8GT0j9auDc6T8AYlGAhM=
X-Received: by 2002:a17:906:d7ab:: with SMTP id pk11mr49816186ejb.472.1600699064876;
 Mon, 21 Sep 2020 07:37:44 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 21 Sep 2020 07:37:33 -0700
Message-ID: <CAPcyv4jCqzs7vjFCvLxHSL13OE0CX0Ptc75ApT-dyyGo_UZ1jw@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fix for v5.9-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: L4DPCZGH3VHE3FODOYC5JVFYYN7MQ44O
X-Message-ID-Hash: L4DPCZGH3VHE3FODOYC5JVFYYN7MQ44O
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L4DPCZGH3VHE3FODOYC5JVFYYN7MQ44O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.9-rc7

...to receive a straggling compilation fixup. Apologies for the thrash
this caused.

---

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.9-rc7

for you to fetch changes up to 88b67edd7247466bc47f01e1dc539b0d0d4b931e:

  dax: Fix compilation for CONFIG_DAX && !CONFIG_FS_DAX (2020-09-21
06:53:09 -0700)

----------------------------------------------------------------
libnvdimm fix 5.9-rc7

- Fix compilation for the new dax_supported() exported helper

----------------------------------------------------------------
Jan Kara (1):
      dax: Fix compilation for CONFIG_DAX && !CONFIG_FS_DAX

 include/linux/dax.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
