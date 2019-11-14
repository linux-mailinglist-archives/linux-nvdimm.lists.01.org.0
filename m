Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814E6FC0B9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 Nov 2019 08:25:39 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B5CF7100DC43D;
	Wed, 13 Nov 2019 23:27:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0C1DA100DC43B
	for <linux-nvdimm@lists.01.org>; Wed, 13 Nov 2019 23:27:07 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id v138so4384480oif.6
        for <linux-nvdimm@lists.01.org>; Wed, 13 Nov 2019 23:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5d5/bpHoXBtRihRqTs8DB3/xqD8D283lsRAFtLbrfY=;
        b=ka9TFfKoK65lEg8yCbO74ziezgRtQdVgpXv0yhH69HHcnCDQeoZMEx0zXoBS7PR5CR
         HUSM9ldvvNqYmMcaebJWojK6kxK8YredJDVlobIurEivs8HOFwov2jkpRQva3FuViGRf
         ZaqsOLOTzq/jVjwP4ypul0EYWEaO7bvk7hbPzNM96uv6Cgr5HBNYLPmiYoYyOFHvE9hD
         mXVwpyQKlHtexK/PvqnnO2dznfTmoig1liLGmqjelsl+RrlPIQi/2x1HOJVbWTe4SI/d
         3v/ItiNlUzTdLdfu/x+OUPTS84IMvoks4EpIT9ybpTurledVYXiFfLBuX7ocfw5Mez8k
         y+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5d5/bpHoXBtRihRqTs8DB3/xqD8D283lsRAFtLbrfY=;
        b=rFKLxERyplG7DwdhrZsM8NehuRiMJUtX6Y2yHkP+4/x30hewJQWrtitCS7FMmyfCSg
         IE3nAZCUOPE7r9u8K9s7BGQfxMm59TYOr+eR8uJhZlzcJFqpKE1zVLGh05qRdIXmG7EQ
         WgxLs+mlx9E5Z8R5oEBo3vQAKV9V5uhMFjI+XFC008GuMo90yZUXCO24NdMmu7wHx5ZW
         AFaV0tfiZrsQ/YQY4HuMBmIjDlWjzktUdFDlU56rDUECLuUp1OcgRTTTuCzhkV9LBxhf
         sKOLhE4RxSqvGE5wkhF2baEN/3LCtkiXXahxo+FSXEBte/uA7eJeQlkTTQ794R5jHjWA
         7G/A==
X-Gm-Message-State: APjAAAWegjMj6ujHDGXyLFTWm6QTS1o9vBLjmGrq5AVQ/ESjGSbgA0qn
	Tc1evZXHoPz+L8FFgxHBiyR7rv2Bdiign0MYtaWASA==
X-Google-Smtp-Source: APXvYqyw6GUqimMOF1WKHvSfkunTVJ/My/V0dioePYkRQ/odDMDx25P6oQDKSOWhF5aoTpM0cuCpZKOnaci5mnKBdMI=
X-Received: by 2002:a05:6808:1da:: with SMTP id x26mr720739oic.149.1573716334479;
 Wed, 13 Nov 2019 23:25:34 -0800 (PST)
MIME-Version: 1.0
References: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20191114071903.GA26307@lst.de>
In-Reply-To: <20191114071903.GA26307@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 13 Nov 2019 23:25:23 -0800
Message-ID: <CAPcyv4iyD7f-3Ws7HpNvfNwO52CK7W-iF7Vsxv3MrGWzALsMGA@mail.gmail.com>
Subject: Re: [PATCH] mm: Cleanup __put_devmap_managed_page() vs ->page_free()
To: Christoph Hellwig <hch@lst.de>
Message-ID-Hash: GVIUZWEBGVE3H57HL4NGVBYHRTXCEEGQ
X-Message-ID-Hash: GVIUZWEBGVE3H57HL4NGVBYHRTXCEEGQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GVIUZWEBGVE3H57HL4NGVBYHRTXCEEGQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 13, 2019 at 11:19 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Nov 13, 2019 at 04:07:22PM -0800, Dan Williams wrote:
> >  static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
> >  {
> > -     if (!pgmap->ops || !pgmap->ops->page_free) {
> > +     if (!pgmap->ops || (pgmap->type == MEMORY_DEVICE_PRIVATE
> > +                             && !pgmap->ops->page_free)) {
>
> I don't think this check is correct.  You only want the the ops null check
> or MEMORY_DEVICE_PRIVATE as well now, i.e.:
>
>         if (pgmap->type == MEMORY_DEVICE_PRIVATE &&
>             (!pgmap->ops || !pgmap->ops->page_free)) {
>
> > @@ -476,10 +471,17 @@ void __put_devmap_managed_page(struct page *page)
> >                * handled differently or not done at all, so there is no need
> >                * to clear page->mapping.
> >                */
> > -             if (is_device_private_page(page))
> > -                     page->mapping = NULL;
> > +             if (is_device_private_page(page)) {
> > +                     /* Clear Active bit in case of parallel mark_page_accessed */
>
> This adds a > 80 char line.  But that whole flow of the function seems
> rather odd now.
>
> Why can't we do:
>
>         if (count == 0) {
>                 __put_page(page);
>         } else if (is_device_private_page(page)) {
>                 __ClearPageActive(page);
>                 __ClearPageWaiters(page);
>
>                 mem_cgroup_uncharge(page);
>                 page->mapping = NULL;
>                 page->pgmap->ops->page_free(page);
>         } else {
>                 wake_up_var(&page->_refcount);
>         }
>

All the above looks good to me will spin a v2.

> (except for the fact that I don't get the point of calling __put_page
> on a refcount of zero, but that is separate from this patch).

That looked odd to me as well until I recalled that we did that to
simplify the pgmap reference counting.

71389703839e mm, zone_device: Replace {get, put}_zone_device_page()
with a single reference to fix pmem crash

I'll add a comment in v2.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
