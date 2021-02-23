Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E34DF32307A
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Feb 2021 19:18:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 379FB100EB34F;
	Tue, 23 Feb 2021 10:18:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 44630100EB34E
	for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 10:18:36 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id w1so35847353ejf.11
        for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 10:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7TKOxtIPubSWBMdBmROKVMkCaaa3udkcxhiRusHIqg=;
        b=XT7ZogD44IGZSwnl04BuslsAjEFzJ54K3btpAhcBwuf6WnbZ9geKwvrOj/WSslmtn2
         n90kKkhJoi4DgorKaqGYW8aUgNg+R9x6oYImDEA+wSAd0hZp6+qPFaP5uiUW3mKlBir5
         fKwlKl59wHnn83RLfgbkhnOYCsVdFguKqFXZwry2v/gPBf4u2E9KCoaejJfi46T6u2O1
         woC6FgOoK0xJ9tHBM4Pk5V6LHk31u+faK3twjPnbZhEYa+A1qxsKIUv04EpCjJThjqxh
         Z/MF5N4Rkg0HX9BHwljKFPK+ra6hCbfj2ngw0EyHOKgkNq7NySrGQa+SyN9KGJe+odJM
         GZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7TKOxtIPubSWBMdBmROKVMkCaaa3udkcxhiRusHIqg=;
        b=i/wZvmnFmAVtFaytCZACEEdE0OSeiki4jT+QEamrvZtSuxI9b9QfPgfGWAvR7DsYxa
         7IYGvEJEk241q1dwgrBe/z1EA5na76qPr/SJY4D+eIKSQQUZB+ZHW7tSYJ34jmeVCCWx
         tzxatEjLx1Czf0Cy1oI792/UhqKB8zRqOhsgXZQc+Xr6x0nq+6/ssMjDdDyHKiGKJWoH
         sacAIE3yQVKyPcZFKkE/0KPnvlNJMPv4aBBXwH8U9TbQs+6vX/0YuXTKdxwPSDVS3rLZ
         CShka42RmG3e0alPK1o8I8rYU+I1wE0mfiZF1NFHZfwfGJd/1EA9yld7oGWMtvSaLAAk
         NwUw==
X-Gm-Message-State: AOAM530/4eNgi1fg5CPixATXs021inm12UC38PT/BQOFjPIz2/UJuZPd
	57REf9oOD19OUOVAi7gIOOqMYvSNt3RhWkEDcNoD0A==
X-Google-Smtp-Source: ABdhPJw+XSq6g2M1vDuZGcjoJeTZChklC3kcuEWAG0F7PeXyjl6IA0fZFJsUFTY7Iwd8Vbi543a4Lc1mg1RgWaLthjY=
X-Received: by 2002:a17:906:e0b:: with SMTP id l11mr20720810eji.523.1614104314865;
 Tue, 23 Feb 2021 10:18:34 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-2-joao.m.martins@oracle.com> <7249cfd2-c178-2e6a-6b03-307a05f11785@nvidia.com>
 <CAPcyv4iMzaAqKe6C1Q_feHL5SwppPdBem0i6XfYX4sL1U6sHgg@mail.gmail.com>
 <7e8908ca-4d0f-6549-0442-d4b15fbc90ab@oracle.com> <CAPcyv4jDk=ppsR2Pvgpb1DqWk5D8bkrNCAtyRU21ShnC3fzdSA@mail.gmail.com>
 <94075df6-ab3b-c6e4-13f1-26dd266dbf82@oracle.com> <CAPcyv4gsVWi8j=aZj3n1-O=39gq2jULcpWgiY22U6hpGTpcGzA@mail.gmail.com>
 <e9e24d05-79e7-275a-530d-fc3b5041845d@oracle.com>
In-Reply-To: <e9e24d05-79e7-275a-530d-fc3b5041845d@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Feb 2021 10:18:30 -0800
Message-ID: <CAPcyv4ixBjf7w-FtSaVOHoXccVag=gw7-mmaMYReV92pczy2tA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/9] memremap: add ZONE_DEVICE support for compound pages
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: GYKVAXO7US76D5C3PJLPNZ2V5PRVS3AR
X-Message-ID-Hash: GYKVAXO7US76D5C3PJLPNZ2V5PRVS3AR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GYKVAXO7US76D5C3PJLPNZ2V5PRVS3AR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 23, 2021 at 9:19 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 2/23/21 4:50 PM, Dan Williams wrote:
> > On Tue, Feb 23, 2021 at 7:46 AM Joao Martins <joao.m.martins@oracle.com> wrote:
> >> On 2/22/21 8:37 PM, Dan Williams wrote:
> >>> On Mon, Feb 22, 2021 at 3:24 AM Joao Martins <joao.m.martins@oracle.com> wrote:
> >>>> On 2/20/21 1:43 AM, Dan Williams wrote:
> >>>>> On Tue, Dec 8, 2020 at 9:59 PM John Hubbard <jhubbard@nvidia.com> wrote:
> >>>>>> On 12/8/20 9:28 AM, Joao Martins wrote:
>
> [...]
>
> >>> Don't get me wrong the
> >>> capability is still needed for filesystem-dax, but the distinction is
> >>> that vmemmap_populate_compound_pages() need never worry about an
> >>> altmap.
> >>>
> >> IMO there's not much added complexity strictly speaking about altmap. We still use the
> >> same vmemmap_{pmd,pte,pgd}_populate helpers which just pass an altmap. So whatever it is
> >> being maintained for fsdax or other altmap consumers (e.g. we seem to be working towards
> >> hotplug making use of it) we are using it in the exact same way.
> >>
> >> The complexity of the future vmemmap_populate_compound_pages() has more to do with reusing
> >> vmemmap blocks allocated in previous vmemmap pages, and preserving that across section
> >> onlining (for 1G pages).
> >
> > True, I'm less worried about the complexity as much as
> > opportunistically converting configurations to RAM backed pages. It's
> > already the case that poison handling is page mapping size aligned for
> > device-dax, and filesystem-dax needs to stick with non-compound-pages
> > for the foreseeable future.
> >
> Hmm, I was sort off wondering that fsdax could move to compound pages too as
> opposed to base pages, albeit not necessarily using the vmemmap page reuse
> as it splits pages IIUC.

I'm not sure compound pages for fsdax would work long term because
there's no infrastructure to reassemble compound pages after a split.
So if you fracture a block and then coalesce it back to a 2MB or 1GB
aligned block there's nothing to go fixup the compound page... unless
the filesystem wants to get into mm metadata fixups.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
