Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DD9179C5E
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Mar 2020 00:25:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 33C5D10FC36F1;
	Wed,  4 Mar 2020 15:26:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=mcroce@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5BD8A10FC36E4
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 15:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583364314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kINxwd1M5ISm+eKGguIdVf+iBkibSVPYpAF7V50yuvE=;
	b=EvMKnYL30VbGLRIKhXSo3SYlzpWdtX4zgdZaXg1VdVt+g+IfhMcxok15BBzBGljQdcBg+O
	4Q8/L6kwOsnElMHSZ8IX4ZedJoDkYSy3Nw4W3uxllOaLkdmVFRwf2tRqAboZoUgfx+7d/B
	GNw9yLG8NzD5VI2WlIHsvrdhEsnzNMM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-UaVx3E3XOzmgjSfJL6Lx_A-1; Wed, 04 Mar 2020 18:25:13 -0500
X-MC-Unique: UaVx3E3XOzmgjSfJL6Lx_A-1
Received: by mail-ed1-f71.google.com with SMTP id y35so2841661ede.4
        for <linux-nvdimm@lists.01.org>; Wed, 04 Mar 2020 15:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8juafuY9nBxbQdXTOkQQGLh3mRvbcDsJuPyMUd6LN0=;
        b=CtLHnnGPtNFGm0LulWddwK/CZUoohV6CMUEk7BwwDnzx8A9q1rl9bT2OelC3TEF0qG
         +yD6aerzMUwjh196g+w/ZeRTgl8CoGff6M2WCYHeI1XSIEMZ9EmCgWo7/acoUAckjrnE
         06Oox5cInl7l4S4kXZ0yHrs0K0gRrmHxqnP8UzJWJbr7BrKhn/FiV++yksfgoidYcqCx
         hkLIVfbyQbNchmp+Z7ev+i+zUW4qDK6EYABZVEiElPzxKLsoudqLktshXSCbOFm4V3uf
         ubclBDb9s5SgrEdc/uZlVnL1RUKQ63+KzDDJ+tUgwGizYsgYRPlxq+UPG+SQKNXaq+w5
         M6JQ==
X-Gm-Message-State: ANhLgQ04FemhdNqorEmbHyrfQw1URvWVJwQ6vUkChRxSsq7NJh3w8pX/
	xTJFEnSBIs8tUV3urKheN5fLhFfsBX56RDHNBcvvQ7G2akJ9OiuPhE6QYS8uC+kM/bvYE41r2fV
	jsUK31UZrA0R9WfqAvKZyNOzshymdUX2oa279
X-Received: by 2002:aa7:cac4:: with SMTP id l4mr5308696edt.367.1583364312075;
        Wed, 04 Mar 2020 15:25:12 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtRn9VC83shY8XHTDzRhsN1U3qcWCfB7uMojQH5bbSmIYgKzcRcKNB9bk5ZyS5m8JegYhUQLyH/6undXUq6ODg=
X-Received: by 2002:aa7:cac4:: with SMTP id l4mr5308663edt.367.1583364311594;
 Wed, 04 Mar 2020 15:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20200223165724.23816-1-mcroce@redhat.com> <CAPcyv4ijKqVhHixsp42kZL4p7uReJ67p3XoPyw5ojM-ZsOOUOg@mail.gmail.com>
In-Reply-To: <CAPcyv4ijKqVhHixsp42kZL4p7uReJ67p3XoPyw5ojM-ZsOOUOg@mail.gmail.com>
From: Matteo Croce <mcroce@redhat.com>
Date: Thu, 5 Mar 2020 00:24:35 +0100
Message-ID: <CAGnkfhxAHctB9MHD0LzSk8uh4tEoF-hw+iwYAEdfeY_=g3NT2A@mail.gmail.com>
Subject: Re: [PATCH] block: refactor duplicated macros
To: Dan Williams <dan.j.williams@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: ECWGSOGG5DPF7HTQXXUYESLDVISDMPAT
X-Message-ID-Hash: ECWGSOGG5DPF7HTQXXUYESLDVISDMPAT
X-MailFrom: mcroce@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-block@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-bcache@vger.kernel.org, linux-raid <linux-raid@vger.kernel.org>, linux-mmc@vger.kernel.org, xen-devel <xen-devel@lists.xenproject.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-nfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, "James E.J. Bottomley" <jejb@linux.ibm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Anna Schumaker <anna.schumaker@netapp.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ECWGSOGG5DPF7HTQXXUYESLDVISDMPAT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 4, 2020 at 9:57 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sun, Feb 23, 2020 at 9:04 AM Matteo Croce <mcroce@redhat.com> wrote:
> >
> > The macros PAGE_SECTORS, PAGE_SECTORS_SHIFT and SECTOR_MASK are defined
> > several times in different flavours across the whole tree.
> > Define them just once in a common header.
> >
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> > ---
> >  block/blk-lib.c                  |  2 +-
> >  drivers/block/brd.c              |  3 ---
> >  drivers/block/null_blk_main.c    |  4 ----
> >  drivers/block/zram/zram_drv.c    |  8 ++++----
> >  drivers/block/zram/zram_drv.h    |  2 --
> >  drivers/dax/super.c              |  2 +-
>
> For the dax change:
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
>
> However...
>
> [..]
> >  include/linux/blkdev.h           |  4 ++++
> [..]
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 053ea4b51988..b3c9be6906a0 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -910,6 +910,10 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
> >  #define SECTOR_SIZE (1 << SECTOR_SHIFT)
> >  #endif
> >
> > +#define PAGE_SECTORS_SHIFT     (PAGE_SHIFT - SECTOR_SHIFT)
> > +#define PAGE_SECTORS           (1 << PAGE_SECTORS_SHIFT)
> > +#define SECTOR_MASK            (PAGE_SECTORS - 1)
> > +
>
> ...I think SECTOR_MASK is misnamed given it considers pages, and
> should probably match the polarity of PAGE_MASK, i.e.
>
> #define PAGE_SECTORS_MASK            (~(PAGE_SECTORS - 1))
>

Makes sense. I just kept the same value as in drivers/block/null_blk_main.c

-- 
Matteo Croce
per aspera ad upstream
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
