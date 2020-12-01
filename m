Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F832C94C0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Dec 2020 02:36:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 51AB7100ED4BA;
	Mon, 30 Nov 2020 17:36:52 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 21EAC100ED4B7
	for <linux-nvdimm@lists.01.org>; Mon, 30 Nov 2020 17:36:49 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id c7so586340edv.6
        for <linux-nvdimm@lists.01.org>; Mon, 30 Nov 2020 17:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvDimc+sqAo3Frsq7ZIw4SVdw2xA6Iw+VeUzKSgkFk8=;
        b=gCeim+26PVzFuWUkbYomFsqQRRG+jJ1rE3VMGhFlMouMhlBuUImO5zEM1x9cmpW4Qg
         zTJyYNufD92YKKFDgc0TPC5fiQhDsipezOAJ9ltlWekiBxkzwyPIFLMaqCNxZkFgPogD
         cPnONtrJhzu0EcBCLyQ9FOxcTaXrRtN00e1ATzNdijsP0JbR9dMXWDwVQHXif/BmayW5
         55X5rJWRVULo4/p+6HYvpQZ7obu+EUR1o8kL4AvtmOEyNwuhkXZGn5voywyDB+xMJBNZ
         /IRyjtlcCeyjG9cb1Lgzzfd9adTTGCpvgcvFmK3wc7RSw4/ERcqiMfhUGjCllAaPvbZi
         ALVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvDimc+sqAo3Frsq7ZIw4SVdw2xA6Iw+VeUzKSgkFk8=;
        b=WsMTU5giNstFGKylcpk26Vx1UqGKwsOlww1LqD3mzgE0Il/CnxWWLdLGZsXSTqeTyv
         x8RD5gJFxg4qVavTtsMeZn/u3sgS7rp5UQv7auXC3FpsPmiO0ofnbCiER+TnKymEe0Xl
         M6nmUna5mqvzzzulT62c3vaIbLtXom3KrZMSgHD7oh6S0nGxiaJu5DLOgzhNacFif7pO
         v/FEaN4cuqpP7EaH70fAoloTWfMHlLLhZAzRN/O1oA0z4a1YdDKMv1wXVtPYu7IbHOOd
         HSbanBf63cWzfTErYW/IKVWT8j7f8E7MgQUmdltWOD/akZnDHqYDPCZ+Y+2r8rJTJRzb
         ighg==
X-Gm-Message-State: AOAM53181cvQfUiptSB3Lqr5asiamqK/RphtHAluw2V+SlsWINj39GZ7
	HDdKbuodIbGsFS81WyKu4wXKtVEhw9UQOrVqKKYEjw==
X-Google-Smtp-Source: ABdhPJzo9VpyDtW6OeJCWhlFPs5UmFas334BqWSpMmMJ89d1kfDleIF5reeBLBI11qSy3glxZXb3oGMsDnPxNnFlrpc=
X-Received: by 2002:a50:fe02:: with SMTP id f2mr606506edt.97.1606786607820;
 Mon, 30 Nov 2020 17:36:47 -0800 (PST)
MIME-Version: 1.0
References: <1687234809.1086398.1604889506963.JavaMail.zimbra@redhat.com>
 <4ed7ea52-20be-68fe-f920-238ba358395c@redhat.com> <20201109141216.GD244516@ziepe.ca>
 <CAPcyv4gJG_-gGwzaenQdnVq13JUWLjEnsTV+e4swuVtpGVpC8g@mail.gmail.com>
 <20201109175442.GE244516@ziepe.ca> <20201110003616.GA525483@nvidia.com>
 <27b0fccb-7f71-ca99-129d-bd3e373c2a85@redhat.com> <053911f5-a66f-f788-3f9e-98526ed8234f@redhat.com>
In-Reply-To: <053911f5-a66f-f788-3f9e-98526ed8234f@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 30 Nov 2020 17:36:43 -0800
Message-ID: <CAPcyv4jK3H_0pbUfSTzXMheXBWt5H_C9jWN8+LEzC0F2sqwQ6g@mail.gmail.com>
Subject: Re: regression from 5.10.0-rc3: BUG: Bad page state in process
 kworker/41:0 pfn:891066 during fio on devdax
To: Yi Zhang <yi.zhang@redhat.com>
Message-ID-Hash: 7CJWXKBWH4NZF2E7CZ6EQEVZ5K5BL3UI
X-Message-ID-Hash: 7CJWXKBWH4NZF2E7CZ6EQEVZ5K5BL3UI
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jason Gunthorpe <jgg@nvidia.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Ralph Campbell <rcampbell@nvidia.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7CJWXKBWH4NZF2E7CZ6EQEVZ5K5BL3UI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 10, 2020 at 8:51 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>
>
>
> On 11/10/20 3:36 PM, Yi Zhang wrote:
> >
> >
> > On 11/10/20 8:36 AM, Jason Gunthorpe wrote:
> >> On Mon, Nov 09, 2020 at 01:54:42PM -0400, Jason Gunthorpe wrote:
> >>> On Mon, Nov 09, 2020 at 09:26:19AM -0800, Dan Williams wrote:
> >>>> On Mon, Nov 9, 2020 at 6:12 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>>>> Wow, this is surprising
> >>>>>
> >>>>> This has been widely backported already, Dan please check??
> >>>>>
> >>>>> I thought pgprot_decrypted was a NOP on most x86 platforms -
> >>>>> sme_me_mask == 0:
> >>>>>
> >>>>> #define __sme_set(x)            ((x) | sme_me_mask)
> >>>>> #define __sme_clr(x)            ((x) & ~sme_me_mask)
> >>>>>
> >>>>> ??
> >>>>>
> >>>>> Confused how this can be causing DAX issues
> >>>> Does that correctly preserve the "soft" pte bits? Especially
> >>>> PTE_DEVMAP that DAX uses?
> >>>>
> >>>> I'll check...
> >>>   extern u64 sme_me_mask;
> >>>   #define __pgprot(x)        ((pgprot_t) { (x) } )
> >>>   #define pgprot_val(x)        ((x).pgprot)
> >>>   #define __sme_clr(x)            ((x) & ~sme_me_mask)
> >>>   #define pgprot_decrypted(prot) __pgprot(__sme_clr(pgprot_val(prot)))
> >>>
> >>>   static inline int io_remap_pfn_range(struct vm_area_struct *vma,
> >>>                                       unsigned long addr, unsigned
> >>> long pfn,
> >>>                                       unsigned long size, pgprot_t
> >>> prot)
> >>>   {
> >>>         return remap_pfn_range(vma, addr, pfn, size,
> >>> pgprot_decrypted(prot));
> >>>   }
> >>>
> >>> Not seeing how that could change the pgprot in any harmful way?
> >>>
> >>> Yi, are you using a platform where sme_me_mask != 0 ?
> >>>
> >>> That code looks clearly like it would only trigger on AMD SME systems,
> >>> is that what you are using?
> >> Can't be, the system is too old:
> >>
> >>   [  398.455914] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380
> >> Gen9, BIOS P89 10/05/2016
> >>
> >> I'm at a total loss how this change could even do anything on a
> >> non-AMD system, let alone how this intersects in any way with DEVDAX,
> >> which I could not find being used with io_remap_pfn_range()
> >
> > I will double confirm it.
> >
> Hi Dan/Jason
>
> It turns out that it was introduced by bellow patch[1] which fixed the
> "static key devmap_managed_key" issue, but introduced [2]
> Finally I found it was not 100% reproduced, and sorry for my mistake.
>
> [1]
> commit 46b1ee38b2ba1a9524c8e886ad078bd3ca40de2a (HEAD)
> Author: Ralph Campbell <rcampbell@nvidia.com>
> Date:   Sun Nov 1 17:07:23 2020 -0800
>
>      mm/mremap_pages: fix static key devmap_managed_key updates

Are you confident about this bisect? I am seeing a similar issue here:

https://lore.kernel.org/linux-nvdimm/CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com

...and my bisect attempts have never landed on this commit.
Unfortunately my bisect attempts also don't land on anything that
looks like the real culprit.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
