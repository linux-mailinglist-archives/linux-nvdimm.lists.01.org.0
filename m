Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A31B9ED4
	for <lists+linux-nvdimm@lfdr.de>; Sat, 21 Sep 2019 18:09:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9F9CB21962301;
	Sat, 21 Sep 2019 09:12:21 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5CD32202EC056
 for <linux-nvdimm@lists.01.org>; Sat, 21 Sep 2019 09:12:20 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id e18so4330246oii.0
 for <linux-nvdimm@lists.01.org>; Sat, 21 Sep 2019 09:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nBi7HZ9yDa4JTOl5bhGG+3rVsUpAvLqUeab5GdL4x+0=;
 b=dy2DmS2GmQbZ27qbfn7yW9Ukr99IPJCkHsSkLjibCPoDEsD0fr2sfhru+qXSVGu0gE
 7gq3Mcg2Df/qk8iAGiKwbShet0jVjLXOoEKvGVzh1f7PQataZBKz9QBMoc7y3DyAWMAy
 KETS6WpMj2GyHz6yGdd5XRGlwGyjScWpj3nRSrT9awfLC0qtZZh6Dhhw+S8LaruP8MxY
 Y0dyFld+EoAX8bOZJYaYfXM1v5JJHWCr0HdovXOVuTSXX7fbSi47bwVbHqVknocjkYdM
 +0YmolBzt4hf0pPwhJaxb0aniqMrUIKSwxQFfHdln0WyWFiR2APdfxVvME/oo2BkLScC
 XCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nBi7HZ9yDa4JTOl5bhGG+3rVsUpAvLqUeab5GdL4x+0=;
 b=QflGPeTfwtrhiMtgJujyNEin6bEMhFZZPy3pTcDvr55WiNnd+Lrj3nSEvsOp4atmk7
 E4Uz7oYXo51ENjx1BnmhGpye2+K2VqWbRTk8e1vYj5dxgTvWPr0hdXKJEB3U4mYHdwxJ
 QbTE0hcKUOjQHJ1LJnTil8Gr3AKMz9wtKRWx2ZM6sowx9EicMu0/O3gXm5mT47i5490V
 7ThRFyqY7fJb0SGhC/e3wjXCgqWWa0DL086KAsCR9Xcub6NMzhYtlvek2PL+1t+LQHuC
 hrR1pqZcRTCnj5BVZQIKw/O10zkRlkW0wiY3FtO9OCBkdGvTOGwFLXqXqLNldljrbuvt
 y6GQ==
X-Gm-Message-State: APjAAAU2mNU2ipqcWIv5JHFqJfGe21qJQgB9wuO7KAFIg3JF3VVMTALH
 avsUCIVJqe2qIcqVkYUkU4gfrApiEKVJyS04OeOg+w==
X-Google-Smtp-Source: APXvYqxQJR7nyuTjwekOUNBLU1LMVXBipOYGs618Q3tTz6bwh88PeAaADZSsvcX6K0o09klXrzxLiVkXer0KaQYX5TQ=
X-Received: by 2002:aca:4b05:: with SMTP id y5mr7078977oia.70.1569082173661;
 Sat, 21 Sep 2019 09:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4g9TpgciDdVpQajSxEYTaHxB4+R9KWF0d=Emt9J7LkAqg@mail.gmail.com>
In-Reply-To: <CAPcyv4g9TpgciDdVpQajSxEYTaHxB4+R9KWF0d=Emt9J7LkAqg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 21 Sep 2019 09:09:22 -0700
Message-ID: <CAPcyv4jXamkc7ytxCw0R=9ZeXTBbifnZKQpHdLP0J04yfx0TBw@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm for 5.4
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Sep 20, 2019 at 4:57 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Hi Linus, please pull from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
> tags/libnvdimm-for-5.4
>
> ...to receive some reworks to better support nvdimms on powerpc and an
> nvdimm security interface update.

Btw, minor conflict with your tree due to a fix that went into
v5.3-rc8. Here's my resolution:

diff --cc drivers/nvdimm/pfn_devs.c
index cb98b8fe786e,ce9ef18282dd..bb9cc5cf0873
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@@ -724,9 -751,10 +753,11 @@@ static int nd_pfn_init(struct nd_pfn *n
        memcpy(pfn_sb->uuid, nd_pfn->uuid, 16);
        memcpy(pfn_sb->parent_uuid, nd_dev_to_uuid(&ndns->dev), 16);
        pfn_sb->version_major = cpu_to_le16(1);
-       pfn_sb->version_minor = cpu_to_le16(3);
+       pfn_sb->version_minor = cpu_to_le16(4);
 +      pfn_sb->end_trunc = cpu_to_le32(end_trunc);
        pfn_sb->align = cpu_to_le32(nd_pfn->align);
+       pfn_sb->page_struct_size = cpu_to_le16(MAX_STRUCT_PAGE_SIZE);
+       pfn_sb->page_size = cpu_to_le32(PAGE_SIZE);
        checksum = nd_sb_checksum((struct nd_gen_sb *) pfn_sb);
        pfn_sb->checksum = cpu_to_le64(checksum);
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
