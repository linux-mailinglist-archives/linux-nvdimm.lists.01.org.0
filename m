Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C06A23E10
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 May 2019 19:09:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7F81F212735AE;
	Mon, 20 May 2019 10:09:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7A3D2212735A0
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 10:09:11 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id f4so10576794oib.4
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yKxKhF1FvSDo9f8sIipTTZjoo77Dif+CkluYVXpcRgw=;
 b=V/DLpIz2Cps7Vz9YsQHlqqdZTYdH0WHSn/FPCx9uvLu6vjEqKny+XWTmXKJJWtLCSx
 qxNK1tixYTMzWbLi1LGbXZmIXn+vfxhi/AXVo82Y7ubuQefRIebHbUukIZV90wr62PoG
 BXCoNyB11kyqHlXrUqFhjimKu+S0xXXtA0+rVhgdzTqeMKKO8t7L8yLNNYtnQYcJLlZd
 bSvLceMtjPm6b6gA3c/1SdhYOlOPjCidwL/o5fRaZberQhryCP7bV729IcjXwCc8xDZF
 g6jotOgS+H+MABwnFrtAE0Rg8L97s4KS8OS1x3HHi5a6qqa9CRACTCNHTe5jtOpYQ8YQ
 e96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yKxKhF1FvSDo9f8sIipTTZjoo77Dif+CkluYVXpcRgw=;
 b=UCFgjhxPoMTaw6KcGqu1NLC2uXRB+KGfvqKsKKTnKM7lKiAHEQ66sybfMtE2ICdcJ+
 CdG2ucF3BMyoVKFNg3j4tH+sRUzwrxN1eoEio5i7C0j1p2WZ2s4Xd4pwH6Od8OZo+QMw
 Fl1MQcJr2Ye4crqZHsWv5lf+7/Q4Te7AF7/EsxqT5UKLN6pl0CQOyBZsXwTRNmAHyrQ8
 +D6RrOunPLddepImgjqUgE7I/sg0xQOOnhDELUp+ex9xMBhhELw+U8eSAUL7H05Qm1yT
 87iGKCM622dxvzrMRsTo3tT2c6tLrNzN05u1c8ZEibIKkbMBGIaefwI/srHHqPV7l8Yi
 M7Bw==
X-Gm-Message-State: APjAAAW/0EPJelPshGncHwX9xae8vkKxvQ5vRQ13ivrsgqr5FpACEh8A
 D0cIZRA2lkE9nFlPZVKRLEXBPnw3rRpkF+Yk471R1ChO
X-Google-Smtp-Source: APXvYqwBtWxgHgdvAiDLmO5TZSGZNCT4wiYmm0OQf+BmHaSAnpJX0G36CIkrI5eKeEcDT4auoPb9k0KbTK9uxTOuoQI=
X-Received: by 2002:aca:b641:: with SMTP id g62mr110703oif.149.1558372150650; 
 Mon, 20 May 2019 10:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190516055422.16939-1-vaibhav@linux.ibm.com>
 <CAPcyv4j6Jhpqg9SqAAmz2A6PDry7UUtnniNVoc_qG=WXwuVOWA@mail.gmail.com>
 <87bm01mylr.fsf@vajain21.in.ibm.com>
In-Reply-To: <87bm01mylr.fsf@vajain21.in.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 20 May 2019 10:08:59 -0700
Message-ID: <CAPcyv4j-OQbN=rYY6MH3XFCF+dPpooCYekYF7PJL+N-tCJey3g@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix last_page check in __bdev_dax_supported()
To: Vaibhav Jain <vaibhav@linux.ibm.com>
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
Cc: Mike Snitzer <snitzer@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chandan Rajendra <chandan@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 16, 2019 at 10:37 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Wed, May 15, 2019 at 10:55 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
> >>
> >> Presently __bdev_dax_supported() checks if first sector of last
> >> page ( last_page ) on the block device is aligned to page
> >> boundary. However the code to compute 'last_page' assumes that there
> >> are 8 sectors/page assuming a 4K page-size.
> >>
> >> This assumption breaks on architectures which use a different page
> >> size specifically PPC64 where page-size == 64K. Hence a warning is
> >> seen while trying to mount a xfs/ext4 file-system with dax enabled:
> >>
> >> $ sudo mount -o dax /dev/pmem0 /mnt/pmem
> >> XFS (pmem0): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
> >> XFS (pmem0): DAX unsupported by block device. Turning off DAX.
> >>
> >> The patch fixes this issue by updating calculation of 'last_var' to
> >> take into account number-of-sectors/page instead of assuming it to be
> >> '8'.
> >
> > Yes, I noticed this too and fixed it up in a wider change that also
> > allows device-mapper to validate each component device. Does this
> > patch work for you?
> >
> > https://lore.kernel.org/lkml/155789172402.748145.11853718580748830476.stgit@dwillia2-desk3.amr.corp.intel.com/
>
> Thanks Dan, I tested your patch and not seeing the issue anymore.

Thanks, I recorded a "Tested-by" for you.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
