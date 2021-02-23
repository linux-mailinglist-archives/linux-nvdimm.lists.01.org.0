Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B73332305E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Feb 2021 19:15:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C7D63100EB34A;
	Tue, 23 Feb 2021 10:15:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 80BF7100EB349
	for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 10:15:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w21so490989edc.7
        for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 10:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKwY/Wjegp2tSfa2RMFEBBX87zeL+Eex6LmLCawXkrQ=;
        b=DwT5zMphywe2ZrdU6xciBsJgD6hr2+gi6yDVJE5PL7gqK+sdSDbsOKMK1sp4qA5Ygr
         B1bmHjQJKgnUdOj8mRc3oCi1BqHIjwJxAnktxsCHY6DxOxCgwwWzGAE+H8ftz/Ts9Ve+
         mN03LDctbfN3/SCXAY2AVVHQrrYoKI5T3dT63EkPN56DqjhKIGI2s2+n7LBFJ21VlOZC
         cKrbAUcqjwm+rMlhWyl9qLj2tAtGW5VzrSgFQEfOidTgYaY4A/WJfxFqmpuiUZlN3zTb
         uOwLxDOguTX2QYC6bCbO8Z9evqoHzoi/ozGT1B9u7kh8O0oCpu0aGyY/xcvqZhQdeiVL
         a5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKwY/Wjegp2tSfa2RMFEBBX87zeL+Eex6LmLCawXkrQ=;
        b=R+SD/XyhNAuuh1AXrCd2X/whjsTdZxfL5gHgclGSk1Rt+ar4PMj7ktUIKQCJTR8CDL
         gmAKgc+7T/1SIb8GG01xj54l2+OA+ksGxGuk9CIsaEPKhsquPd1V9ZhJq8pD7jwTWrfB
         zppTN2RcmCy3Tb+4Edj53Lr8WcWhShb5jLXDUhwH0xloLWMZ54C+/QMOPRVSPOuIoKWU
         44uD0zqmY8mqjp67OcnyYt87FjPWMAaFr5jL2TXL9pVlD85kc6ipCYQXPBStnMxHJTCz
         ROth1VwtwynzFjEctRmrtuh4OHFwIClVZS5H0usL3kUwxKCV1SVDnHVgyqu3AZxtOVDQ
         gOXw==
X-Gm-Message-State: AOAM532EzvgG/qMtr6UBlGx76W+ZvAA2fZFZzdyO/VClN3/1jK8nHmaq
	x4jZYZNgytFTJf0ifA4x0W7jEXQhMhvKEXp/jsX97hnsGSw=
X-Google-Smtp-Source: ABdhPJybZbSPJ+2Xb6lTQDXcAhfTfuWmUkdu6cu9SZiPQbbsO2EsfQn2GEkh+aQHMJ1XAULXznbTVPz7CqSS92dFR50=
X-Received: by 2002:a05:6402:10ce:: with SMTP id p14mr16769062edu.348.1614104116562;
 Tue, 23 Feb 2021 10:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <CAPcyv4gQQ03-nhBNwLK6KDc953SVD1rOs7HFBo_Mu9LFTkXRgw@mail.gmail.com>
 <6a18179e-65f7-367d-89a9-d5162f10fef0@oracle.com> <CAPcyv4joomjhZYaCBNrYjvATSYgECfHYOZy=n_QVKqX7D_ReZQ@mail.gmail.com>
 <1cf0adb0-9692-bcb2-4d3d-374ba3164994@oracle.com>
In-Reply-To: <1cf0adb0-9692-bcb2-4d3d-374ba3164994@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Feb 2021 10:15:12 -0800
Message-ID: <CAPcyv4gdL3p-RVKSVGPfSdBWW+eakTHqCYZp2hqV4QiXCv6KTw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] mm, sparse-vmemmap: Introduce compound pagemaps
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: J47K4GPRCTEXOUB2PUVABUSSRQ362EO5
X-Message-ID-Hash: J47K4GPRCTEXOUB2PUVABUSSRQ362EO5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J47K4GPRCTEXOUB2PUVABUSSRQ362EO5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 23, 2021 at 9:16 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 2/23/21 4:44 PM, Dan Williams wrote:
> > On Tue, Feb 23, 2021 at 8:30 AM Joao Martins <joao.m.martins@oracle.com> wrote:
> >>
> >> On 2/20/21 1:18 AM, Dan Williams wrote:
> >>> On Tue, Dec 8, 2020 at 9:32 AM Joao Martins <joao.m.martins@oracle.com> wrote:
> >>>> Patch 6 - 8: Optimize grabbing/release a page refcount changes given that we
> >>>> are working with compound pages i.e. we do 1 increment/decrement to the head
> >>>> page for a given set of N subpages compared as opposed to N individual writes.
> >>>> {get,pin}_user_pages_fast() for zone_device with compound pagemap consequently
> >>>> improves considerably, and unpin_user_pages() improves as well when passed a
> >>>> set of consecutive pages:
> >>>>
> >>>>                                            before          after
> >>>>     (get_user_pages_fast 1G;2M page size) ~75k  us -> ~3.2k ; ~5.2k us
> >>>>     (pin_user_pages_fast 1G;2M page size) ~125k us -> ~3.4k ; ~5.5k us
> >>>
> >>> Compelling!
> >>>
> >>
> >> BTW is there any reason why we don't support pin_user_pages_fast() with FOLL_LONGTERM for
> >> device-dax?
> >>
> >
> > Good catch.
> >
> > Must have been an oversight of the conversion. FOLL_LONGTERM collides
> > with filesystem operations, but not device-dax.
>
> hmmmm, fwiw, it was unilaterally disabled for any devmap pmd/pud in commit 7af75561e171
> ("mm/gup: add FOLL_LONGTERM capability to GUP fast") and I must only assume that
> by "DAX pages" the submitter was only referring to fs-dax pages.

Agree, that was an fsdax only assumption. Maybe this went unnoticed
because the primary gup-fast case for direct-I/O was not impacted.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
