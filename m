Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991AC1745B6
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 10:17:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 98D0C10FC3190;
	Sat, 29 Feb 2020 01:18:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 255BA1007B18E
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 01:17:58 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id z12so5957034wmi.4
        for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 01:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84l+/iPVMM8/hLUieRf6a7Y3yljDnv4PnRrTq7Jpkjg=;
        b=cHz9xliE+HoEvGGVsxnoiYK5Z1qN46G0Mos7GBEWEeSNyKHWDkuAbgFoR95CSxxsOa
         HTF0mdtS3RJmE/T0bulXETv1S8b4hXclA5AlrHUJSPX0nHUSIzHzBPY26jGmE6zUMH98
         x5fFgVI8aslBCQY7dRXSV4T5LmhJcNOG4lW6mT2qgaCo5Kgp6gWm2uCgo25D3YKjQ7t2
         ru7x4/D620selz0Olgymq1Gy97B3+sD1UG4dbClwyjujmy92q9XQ8PP94zUfWGGgJmvD
         O6zZpaLAiHT5Sk4CPJVRd0LCowPFB3cPJe56OZhSZLLvM/tmLOeoe8w1E/vraQxps5S0
         jlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84l+/iPVMM8/hLUieRf6a7Y3yljDnv4PnRrTq7Jpkjg=;
        b=YRSMK51yRvSC69gdALj7i8cJNA5CzW2hNWvVmM00PcxtUemLBdyi48P8SDFRD7qS8T
         zflNNwgw1TaeECsSLye9qBy6ImloYNWcEqJkih2az+i6+tDm//mBGUfnSxlBTA98oMQc
         Jr3zHQFoQmimsOrQrsR5LsbGQac4i5OMSIGKOAuV8K+45MZCdKSwT5TnWDOFXvm9TuhK
         au68X7TvUQSnkTNW5mhoeqOCo/IBvmXkyQiSmTh8WliAKvMOVIa15tLuqxUUerGvbc8f
         wogn72xIAv8/JZK0K9C/AkjVuanMNqZlmB1gE4SrWLEh29DUUcFNgMKX+D/SH2ECWHNb
         FkqQ==
X-Gm-Message-State: APjAAAWmgdOxWHglaZuzQmQJTH+9s6E+FVi5kaZ8Ao8hyoTU/0OByeo3
	GVEpWLG6KqEojH1mIkBKeNW4RIGY7IcRYkSdSk8=
X-Google-Smtp-Source: APXvYqxfLRiVrnYhDu4x+AqoqT6WXSX/Yp2zDg70IB8IAjbVVRQuJ0ZHm+nq/8o1RcPnF9HGEur2CkpJXILJQTL0jqQ=
X-Received: by 2002:a1c:a789:: with SMTP id q131mr9556538wme.127.1582967824944;
 Sat, 29 Feb 2020 01:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20200228163456.1587-1-vgoyal@redhat.com>
In-Reply-To: <20200228163456.1587-1-vgoyal@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Sat, 29 Feb 2020 10:16:53 +0100
Message-ID: <CAM9Jb+j46n3Ykca3_F0zb-7U1M5C8KmmH+3uzB1z7MqH60mQBA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] dax/pmem: Provide a dax operation to zero page range
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: QNIK3IBHKFP4LLHWQ6KILLWJQA3IU455
X-Message-ID-Hash: QNIK3IBHKFP4LLHWQ6KILLWJQA3IU455
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, david@fromorbit.com, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QNIK3IBHKFP4LLHWQ6KILLWJQA3IU455/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vivek,

>
> Hi,
>
> This is V6 of patches. These patches are also available at.

Looks like cover letter is missing the motivation for the patchset.
Though I found it in previous posting. Its good to add it in the series
for anyone joining the discussion at later stages.

Thanks,
Pankaj

>
> Changes since V5:
>
> - Dan Williams preferred ->zero_page_range() to only accept PAGE_SIZE
>   aligned request and clear poison only on page size aligned zeroing. So
>   I changed it accordingly.
>
> - Dropped all the modifications which were required to support arbitrary
>   range zeroing with-in a page.
>
> - This patch series also fixes the issue where "truncate -s 512 foo.txt"
>   will fail if first sector of file is poisoned. Currently it succeeds
>   and filesystem expectes whole of the filesystem block to be free of
>   poison at the end of the operation.
>
> Christoph, I have dropped your Reviewed-by tag on 1-2 patches because
> these patches changed substantially. Especially signature of of
> dax zero_page_range() helper.
>
> Thanks
> Vivek
>
> Vivek Goyal (6):
>   pmem: Add functions for reading/writing page to/from pmem
>   dax, pmem: Add a dax operation zero_page_range
>   s390,dcssblk,dax: Add dax zero_page_range operation to dcssblk driver
>   dm,dax: Add dax zero_page_range operation
>   dax: Use new dax zero page method for zeroing a page
>   dax,iomap: Add helper dax_iomap_zero() to zero a range
>
>  drivers/dax/super.c           | 20 ++++++++
>  drivers/md/dm-linear.c        | 18 +++++++
>  drivers/md/dm-log-writes.c    | 17 ++++++
>  drivers/md/dm-stripe.c        | 23 +++++++++
>  drivers/md/dm.c               | 30 +++++++++++
>  drivers/nvdimm/pmem.c         | 97 ++++++++++++++++++++++-------------
>  drivers/s390/block/dcssblk.c  | 15 ++++++
>  fs/dax.c                      | 59 ++++++++++-----------
>  fs/iomap/buffered-io.c        |  9 +---
>  include/linux/dax.h           | 21 +++-----
>  include/linux/device-mapper.h |  3 ++
>  11 files changed, 221 insertions(+), 91 deletions(-)
>
> --
> 2.20.1
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
