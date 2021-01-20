Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3492D2FDAAB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Jan 2021 21:21:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 22FF6100EB331;
	Wed, 20 Jan 2021 12:21:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9D1EA100EB330
	for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 12:21:08 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id 6so35342612ejz.5
        for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 12:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCzet5L0nxCVD8lCgMuy9Zk/SXca20QY9TXFaVfK/m0=;
        b=z7ZgwC01LO6kgIolKQifAjUHfIK8S7ZunUxX5mw3TJaRwa5fSmFkN2Zb9ul9Yimez7
         FVl4u9G/CbX7Z6bQlVHfAeFphktTJLhYp+YoI2ONOEyuj/ivvmuPreQDsWzCKEBdpZW9
         3ioqFQZ3flqzB5RhaG7bfK6LLkY02hXNnYD0twiunfHczGXixZZiZorsav09qFpw7SwY
         a1mtJcWxN5sw8Krdc5ddQa5mVad+IKmUIil9HpJZZLOr29jhxFsP9HVPnOu6ZfN6e3tu
         as6Hw9D2MQkS1hidKgv03sNmslKNsHl823y6tACzbe416AwXjBVwEHF5jww90sT1RRFi
         SrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCzet5L0nxCVD8lCgMuy9Zk/SXca20QY9TXFaVfK/m0=;
        b=omlhlio6KFlBK1g9kLfidch5tEf2G9u8miPE06IiSLA56LFFzGlBcoKVFYP9SVScvl
         j/lezVHqiETJHItgYrpmCZonYRHSShTjLoJYxilEdk70KZul5/IYocIMY4EnWW+i4LGW
         sKdbr0q8mHopvUIJNn2iQjl9BiLQB8WWElaoTnYKJFCPi+JwqHvdrQM9krU+6upjKJ4s
         5rd60V12wR5OYbvi7xwJhHEIAYLSnmFST9yyWr4V4L1FKUVG//hRXSZGw3jmCgwk1ZpS
         l0C9Fm6tWsV1zdLdSd1lSl0bmf1A0uy8ZxIkE4o7zVVq6sY+pVKapJyAOYl3ZXTIDFnO
         RzlA==
X-Gm-Message-State: AOAM532BgXAwEApUPqfP+yj2yA1KmVh0GO5Jnw4ecQ/oJj84gVzOY1nS
	mMgT3i7o93lEU/n7tdIWN30CG0HTGukcANdgva7Mcg==
X-Google-Smtp-Source: ABdhPJxjbd20vFE8n/InbI5J8sGslKS9iLtSPPWcjxWg7uUP4a4WQHUKkLuOMn9oWWU/4fuh0F52VaqkkzWNyRYhPjw=
X-Received: by 2002:a17:907:d8e:: with SMTP id go14mr7317695ejc.472.1611174066233;
 Wed, 20 Jan 2021 12:21:06 -0800 (PST)
MIME-Version: 1.0
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210120194609.GA3843758@infradead.org>
In-Reply-To: <20210120194609.GA3843758@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 20 Jan 2021 12:20:59 -0800
Message-ID: <CAPcyv4jvGfZ1W8KLPO22oYVDBiUYius+Nf8kRNP=xmPvjg+deA@mail.gmail.com>
Subject: Re: [PATCH 1/3] cdev: Finish the cdev api with queued mode support
To: Christoph Hellwig <hch@infradead.org>
Message-ID-Hash: 44IVIK3CE6TRQBJLMKKIIY2CGYBCXUYZ
X-Message-ID-Hash: 44IVIK3CE6TRQBJLMKKIIY2CGYBCXUYZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Greg KH <gregkh@linuxfoundation.org>, Logan Gunthorpe <logang@deltatee.com>, Hans Verkuil <hans.verkuil@cisco.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/44IVIK3CE6TRQBJLMKKIIY2CGYBCXUYZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 20, 2021 at 11:46 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> The subject doesn't make any sense to me.
>
> But thn again queued sound really weird.  You just have a managed
> API with a refcount and synchronization, right?

Correct.

"queue" was in reference to the way q_usage_count behaves, but yes,
just refcount + synchronization is all this is.

>
> procfs and debugfs already support these kind of managed ops, kinda sad
> to duplicate this concept yet another time.

Oh, I didn't realize there were managed ops there, I'll go take a look
and see if cdev can adopt that scheme.

> > +static long cdev_queued_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>
> Overly long line.
>
> > +__must_check int __cdev_register_queued(struct cdev *cdev, struct module *owner,
> > +                                     dev_t dev, unsigned count,
> > +                                     const struct cdev_operations *qops)
> > +{
> > +     int rc;
> > +
> > +     if (!qops->ioctl || !owner)
> > +             return -EINVAL;
>
> Why is the ioctl method mandatory?

Yeah, that can drop. It was there more to ask the question about
whether cdev should be mandating ioctls with pointer arguments and
taking the need to specify the compat fallback away from a driver
responsibility.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
