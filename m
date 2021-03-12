Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26375338594
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Mar 2021 06:55:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3CCCF100EAB44;
	Thu, 11 Mar 2021 21:54:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 27DE2100EAB43
	for <linux-nvdimm@lists.01.org>; Thu, 11 Mar 2021 21:54:52 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id r17so51066767ejy.13
        for <linux-nvdimm@lists.01.org>; Thu, 11 Mar 2021 21:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wfgrhjBFwEzFBFXqj/JElN7KHjfc0N5GV2L7MtyLc5s=;
        b=kcM7AexuPVJk9B4qmDAk0W9+zQXLkef8Akxk8pygIsqz2+9m4CHZBnCQr0vqBUg5BK
         JvMV2o7qoJJiWKFAyHG2Zf7KCJnL6D9OR4DT92rOqTDnvKh4wDqvPzWcU+0GFXJimW6I
         wRjIZWOb/N+TKRv0+RL6FKvyTWNYr1DbgDrrFYkAIdojbUb2vqcu6JVQHzbZzSr5HAPp
         qgfx+kGvkG758PzUYqQQFvb61w8eoz2AI/ryXzkEc1V1HKa9R0qoW96BMaTz1Q+znSPM
         oUZn96cjk7Hr7NTYOitC1LWLRPdWjLWJnFIGRKwQ1whI/ea4lh4s6AYmUnQyI5UZOpGi
         mSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfgrhjBFwEzFBFXqj/JElN7KHjfc0N5GV2L7MtyLc5s=;
        b=XnGcgZ18g5tvrARsmQTnAQyTIT+EA2f9uQ/h0zACbilsN2jfeY2iKhZjpXLIIjRRqQ
         QHICgGQB08gGEL5JIP0rMwLIpG5BM8ISQXZ2t274CTg29OvkhT+4znwGOizFEbRRDLTq
         n3hov4Tg95azHOtLpHYNwpFpg+c4nB4+dzEs+Oa6AzbriqRRyvpK3PHR4mUWC6Kbx8wG
         ZLDFl7Pxju/5iS5a3JKRVjEAeYDhdII+5jLx/Hc3gY1BjQXe/C4/uwLX2LENgSZwSVz6
         G7wk34ridY7D+Tn7L/blawjg98Dd0Hu+mj0I0wIIJzkJGiZcZlh0v9SoT/ae40xaWbuS
         ME6A==
X-Gm-Message-State: AOAM532mpLu8lU+ylEbbRhYkebNdJRhgc1ZgU91aGFiQkegr5Yk9J+8b
	MC85lavoZZicnSrTERJPq3KO3jGMBeaJo1y0SZfLRQ==
X-Google-Smtp-Source: ABdhPJxKfBvYG+kNLXc0u3fjseSeVl6oGe2f7JFYk7AhyGUudU+A7Fg1UaCUTv/tyj459F+m5ctZ3O5GiuonO61gxio=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr6750672ejz.341.1615528490911;
 Thu, 11 Mar 2021 21:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-2-joao.m.martins@oracle.com> <7249cfd2-c178-2e6a-6b03-307a05f11785@nvidia.com>
 <CAPcyv4iMzaAqKe6C1Q_feHL5SwppPdBem0i6XfYX4sL1U6sHgg@mail.gmail.com>
 <7e8908ca-4d0f-6549-0442-d4b15fbc90ab@oracle.com> <CAPcyv4jDk=ppsR2Pvgpb1DqWk5D8bkrNCAtyRU21ShnC3fzdSA@mail.gmail.com>
 <b1ef0aa7-754c-78e8-ffbd-87397c1eaf79@oracle.com>
In-Reply-To: <b1ef0aa7-754c-78e8-ffbd-87397c1eaf79@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 11 Mar 2021 21:54:40 -0800
Message-ID: <CAPcyv4gAfBO18bPvc=yRbAhaOuDcDgz2wOsvs+konvfpxDiJeA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/9] memremap: add ZONE_DEVICE support for compound pages
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: 3JKQQ23RN3URG77SJKAPGZTLNHATZDF7
X-Message-ID-Hash: 3JKQQ23RN3URG77SJKAPGZTLNHATZDF7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3JKQQ23RN3URG77SJKAPGZTLNHATZDF7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 10, 2021 at 10:13 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 2/22/21 8:37 PM, Dan Williams wrote:
> > On Mon, Feb 22, 2021 at 3:24 AM Joao Martins <joao.m.martins@oracle.com> wrote:
> >> On 2/20/21 1:43 AM, Dan Williams wrote:
> >>> On Tue, Dec 8, 2020 at 9:59 PM John Hubbard <jhubbard@nvidia.com> wrote:
> >>>> On 12/8/20 9:28 AM, Joao Martins wrote:
> >> One thing to point out about altmap is that the degradation (in pinning and
> >> unpining) we observed with struct page's in device memory, is no longer observed
> >> once 1) we batch ref count updates as we move to compound pages 2) reusing
> >> tail pages seems to lead to these struct pages staying more likely in cache
> >> which perhaps contributes to dirtying a lot less cachelines.
> >
> > True, it makes it more palatable to survive 'struct page' in PMEM,
>
> I want to retract for now what I said above wrt to the no degradation with
> struct page in device comment. I was fooled by a bug on a patch later down
> this series. Particular because I accidentally cleared PGMAP_ALTMAP_VALID when
> unilaterally setting PGMAP_COMPOUND, which consequently lead to always
> allocating struct pages from memory. No wonder the numbers were just as fast.
> I am still confident that it's going to be faster and observe less degradation
> in pinning/init. Init for now is worst-case 2x faster. But to be *as fast* struct
> pages in memory might still be early to say.
>
> The broken masking of the PGMAP_ALTMAP_VALID bit did hide one flaw, where
> we don't support altmap for basepages on x86/mm and it apparently depends
> on architectures to implement it (and a couple other issues). The vmemmap
> allocation isn't the problem, so the previous comment in this thread that
> altmap doesn't change much in the vmemmap_populate_compound_pages() is
> still accurate.
>
> The problem though resides on the freeing of vmemmap pagetables with
> basepages *with altmap* (e.g. at dax-device teardown) which require arch
> support. Doing it properly would mean making the altmap reserve smaller
> (given fewer pages are allocated), and the ability for the altmap pfn
> allocator to track references per pfn. But I think it deserves its own
> separate patch series (probably almost just as big).
>
> Perhaps for this set I can stick without altmap as you suggested, and
> use hugepage vmemmap population (which wouldn't
> lead to device memory savings) instead of reusing base pages . I would
> still leave the compound page support logic as metadata representation
> for > 4K @align, as I think that's the right thing to do. And then
> a separate series onto improving altmap to leverage the metadata reduction
> support as done with non-device struct pages.
>
> Thoughts?

The space savings is the whole point. So I agree with moving altmap
support to a follow-on enhancement, but land the non-altmap basepage
support in the first round.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
