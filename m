Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB6F33073D
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Mar 2021 06:23:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 86887100EBBC3;
	Sun,  7 Mar 2021 21:23:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7DEEA100EF265
	for <linux-nvdimm@lists.01.org>; Sun,  7 Mar 2021 21:23:52 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ox4so2083487ejb.11
        for <linux-nvdimm@lists.01.org>; Sun, 07 Mar 2021 21:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4vk8NjZWUWMSC21zZsC5XhaD9emmq9PjiDCa5A5wz7c=;
        b=dmfnCfqpjw4sbFySyQCvKT/bnV1gdfJE//RwUw+/gEad1qlgdXYzLJo6gW07X7BaWi
         fOhjzy+D1McnNY1FlfUUZ2eVsZX4PMmPnHHnfvK/QcHbludMlyF7P2E7NSHAbcqrf5gm
         aJ9t9GCUBUf7zQgOZPuMx/DcsYpEXNWI2O0bdl6RCMydWb7xFXo4rl9dJRw0Qhj5rYcP
         2LxgpXUh4l+i7nWNKqBaapAousEIDyzh4EFeoGR7B+xkGxD2oRsrUJHseSmx3kgzJrJn
         DP5PrPXZJVUI/wFIKhOVGuOZLzXVvn/Osj8paaq9+KZ4pIoYwDefy+eJcO2VWrZ8JUde
         amxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vk8NjZWUWMSC21zZsC5XhaD9emmq9PjiDCa5A5wz7c=;
        b=VjfsiXNhlAXYEkyn6dgpZ0wMtb/xFL6hZZE5+zzd8cW+Enm+Ta/bnahXwWNuFr8l8F
         NEp74oH+v4GBl25UXAsrrNBWC15yBekNEyWI1k2XDE16KLFeVrmv6AAVT0Clf4nEtTVA
         7JM4oqS9JmkKymohX70hog5N7XRgQ1tbmpLN7r+Z6aOY+ZmC79OXa/fGiE+ODhlPv1/m
         slD6BKBxNpPMpaDuOHIHte0YS/2wf3O9rgm8/FjLdHZJkXtgWQPa6Ae6RV9N6x5GcwOI
         3mzC9yE7qwH9hU2xq+vS9W3fuuuXaItfF9OtUDrxjGYnxCK1XFw8bDCLPD8IMn2QHAvg
         s1XA==
X-Gm-Message-State: AOAM531fKEvhGmYeawyO2XK9udXuYv/rlVGOnPQ2SGOtYNCigQxW45Kb
	vzop6oUW+Uf1ChuRtEPyIahPMwRKDMff8qXd/sfbVQ==
X-Google-Smtp-Source: ABdhPJxP4YeKftw4Lj6ZQkw1k0hTAM+QWLRj2zfFwlL8QUnJAuQwAg2fpXUMBBNPLZZXJqNMxEP+ZhTef3D9nTDkcKU=
X-Received: by 2002:a17:906:1bf2:: with SMTP id t18mr13449685ejg.418.1615181030278;
 Sun, 07 Mar 2021 21:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com> <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
 <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 7 Mar 2021 21:23:47 -0800
Message-ID: <CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
To: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Message-ID-Hash: U6CXDIZO5KOIR64XAFVKZR2EJ6UFH66B
X-Message-ID-Hash: U6CXDIZO5KOIR64XAFVKZR2EJ6UFH66B
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, device-mapper development <dm-devel@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Goldwyn Rodrigues <rgoldwyn@suse.de>, "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>, "y-goto@fujitsu.com" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U6CXDIZO5KOIR64XAFVKZR2EJ6UFH66B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 7, 2021 at 7:38 PM ruansy.fnst@fujitsu.com
<ruansy.fnst@fujitsu.com> wrote:
>
> > On Mon, Feb 8, 2021 at 2:55 AM Shiyang Ruan <ruansy.fnst@cn.fujitsu.com> wrote:
> > >
> > > When memory-failure occurs, we call this function which is implemented
> > > by each kind of devices.  For the fsdax case, pmem device driver
> > > implements it.  Pmem device driver will find out the block device where
> > > the error page locates in, and try to get the filesystem on this block
> > > device.  And finally call filesystem handler to deal with the error.
> > > The filesystem will try to recover the corrupted data if possiable.
> > >
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> > > ---
> > >  include/linux/memremap.h | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> > > index 79c49e7f5c30..0bcf2b1e20bd 100644
> > > --- a/include/linux/memremap.h
> > > +++ b/include/linux/memremap.h
> > > @@ -87,6 +87,14 @@ struct dev_pagemap_ops {
> > >          * the page back to a CPU accessible page.
> > >          */
> > >         vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
> > > +
> > > +       /*
> > > +        * Handle the memory failure happens on one page.  Notify the processes
> > > +        * who are using this page, and try to recover the data on this page
> > > +        * if necessary.
> > > +        */
> > > +       int (*memory_failure)(struct dev_pagemap *pgmap, unsigned long pfn,
> > > +                             int flags);
> > >  };
> >
> > After the conversation with Dave I don't see the point of this. If
> > there is a memory_failure() on a page, why not just call
> > memory_failure()? That already knows how to find the inode and the
> > filesystem can be notified from there.
>
> We want memory_failure() supports reflinked files.  In this case, we are not
> able to track multiple files from a page(this broken page) because
> page->mapping,page->index can only track one file.  Thus, I introduce this
> ->memory_failure() implemented in pmem driver, to call ->corrupted_range()
> upper level to upper level, and finally find out files who are
> using(mmapping) this page.
>

I know the motivation, but this implementation seems backwards. It's
already the case that memory_failure() looks up the address_space
associated with a mapping. From there I would expect a new 'struct
address_space_operations' op to let the fs handle the case when there
are multiple address_spaces associated with a given file.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
