Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D77A02CB7B9
	for <lists+linux-nvdimm@lfdr.de>; Wed,  2 Dec 2020 09:50:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F1104100EBBC6;
	Wed,  2 Dec 2020 00:50:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 21E22100EBBC5
	for <linux-nvdimm@lists.01.org>; Wed,  2 Dec 2020 00:50:02 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id 7so2544906ejm.0
        for <linux-nvdimm@lists.01.org>; Wed, 02 Dec 2020 00:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGQxU4smDX12ciBTdGM0u5QnLY7pZDLRsh2d6WxdLj4=;
        b=iR1FDnQLqeGi9h3b4ydgVKH+wqFxdW3ToSn0JbeVWoBc9csAWHNmVQGElBwr1oLvpz
         asmJiulvDDNswro3F7DGewO0s6QqElhrUhY4bCwqMbkcXc8xhK8dykM4qrpsVVfefac3
         afaC5haErcVCGTkM5YYzvUR6myyhwbho7qd4IE6XS03zJFNfU/9G+r2TFPMYyQyx3nvD
         9Zx+o7ie1lJ9+fWPNDMBGFwpeOqpq0S1uQ8xVXNIWGBa8I00YjYe45yJQ0mXbh1p6I10
         jcUnce/DjcatGjJirhK5cswDAbDle8Fi/sLe+J4RBNdehhrnCokv3oI8vBJe+Wk6mQr1
         fa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGQxU4smDX12ciBTdGM0u5QnLY7pZDLRsh2d6WxdLj4=;
        b=R2Pb/c10Yv2x0f7Tf0fPNoNmE374yoyN+DfQmiUOmgUsJIL9/vs/Kq7q47FKmmw/5B
         E96reTTJo0dHqK2x93xJ2MxVkdFzkW0o/C273qtlYl3nijFTaHtMpR2HPgXMvC7vDq1c
         unoh7W5i0ZQqWIzUychvqBJ7MVYENyc3zvx5QXGA2V2wfKhI1Z1pXJINC1SoRA43J1KF
         gdLPhEDFgXTIZmOoqiJtpk2DfdrcRfHRhaLvk4LSfJ6hNe3k+Y3IQy2hh45HKd3CKYHa
         667EpryGfiEYAnbNVkAUOW1aC2TZu2jIwcvH50YGkC3A2vSZaB7rjP1Z7ZG9UJvvCMMr
         I9Lg==
X-Gm-Message-State: AOAM530StFBOBT+o6xqqW+7coHoM6kDWVUVPEJFmv6eBy2UlSqGkvVQ0
	XcBiSDlx9cSF8lT2M+6WZQncR8atMfukCA0bvzPAQg==
X-Google-Smtp-Source: ABdhPJwhZcZHLPK/OTQxaZiCfcGmM8ZvtDS5GjOo3YE6HIDLyrPWM6ofYoH4ZaI5fu462fSc4leThNOXk1bFo/2g54g=
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr1273603ejb.264.1606899001140;
 Wed, 02 Dec 2020 00:50:01 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
 <20201201022412.GG4327@casper.infradead.org> <CAPcyv4j7wtjOSg8vL5q0PPjWdaknY-PC7m9x-Q1R_YL5dhE+bQ@mail.gmail.com>
 <20201201204900.GC11935@casper.infradead.org> <CAPcyv4jNVroYmirzKw_=CsEixOEACdL3M1Wc4xjd_TFv3h+o8Q@mail.gmail.com>
 <20201202034308.GD11935@casper.infradead.org> <CAPcyv4jk2-6hRZAC+=-wuXwFyYK9uKiRX=pVc0Q0UeB9yc=y1w@mail.gmail.com>
In-Reply-To: <CAPcyv4jk2-6hRZAC+=-wuXwFyYK9uKiRX=pVc0Q0UeB9yc=y1w@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 2 Dec 2020 00:49:57 -0800
Message-ID: <CAPcyv4hxuzn9k-W_+iBsa=evL-FGijWyaxkyFLohUTqCCoJAig@mail.gmail.com>
Subject: Re: mapcount corruption regression
To: Matthew Wilcox <willy@infradead.org>
Message-ID-Hash: NUTRFBHQSXAEATNUUX7IEGGFG62CJUQH
X-Message-ID-Hash: NUTRFBHQSXAEATNUUX7IEGGFG62CJUQH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Shutemov, Kirill" <kirill.shutemov@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Vlastimil Babka <vbabka@suse.cz>, Yi Zhang <yi.zhang@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NUTRFBHQSXAEATNUUX7IEGGFG62CJUQH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 1, 2020 at 9:07 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Dec 1, 2020 at 7:43 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Dec 01, 2020 at 06:28:45PM -0800, Dan Williams wrote:
> > > On Tue, Dec 1, 2020 at 12:49 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Tue, Dec 01, 2020 at 12:42:39PM -0800, Dan Williams wrote:
> > > > > On Mon, Nov 30, 2020 at 6:24 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > >
> > > > > > On Mon, Nov 30, 2020 at 05:20:25PM -0800, Dan Williams wrote:
> > > > > > > Kirill, Willy, compound page experts,
> > > > > > >
> > > > > > > I am seeking some debug ideas about the following splat:
> > > > > > >
> > > > > > > BUG: Bad page state in process lt-pmem-ns  pfn:121a12
> > > > > > > page:0000000051ef73f7 refcount:0 mapcount:-1024
> > > > > > > mapping:0000000000000000 index:0x0 pfn:0x121a12
> > > > > >
> > > > > > Mapcount of -1024 is the signature of:
> > > > > >
> > > > > > #define PG_guard        0x00000400
> > > > >
> > > > > Oh, thanks for that. I overlooked how mapcount is overloaded. Although
> > > > > in v5.10-rc4 that value is:
> > > > >
> > > > > #define PG_table        0x00000400
> > > >
> > > > Ah, I was looking at -next, where Roman renumbered it.
> > > >
> > > > I know UML had a problem where it was not clearing PG_table, but you
> > > > seem to be running on bare metal.  SuperH did too, but again, you're
> > > > not using SuperH.
> > > >
> > > > > >
> > > > > > (the bits are inverted, so this turns into 0xfffffbff which is reported
> > > > > > as -1024)
> > > > > >
> > > > > > I assume you have debug_pagealloc enabled?
> > > > >
> > > > > Added it, but no extra spew. I'll dig a bit more on how PG_table is
> > > > > not being cleared in this case.
> > > >
> > > > I only asked about debug_pagealloc because that sets PG_guard.  Since
> > > > the problem is actually PG_table, it's not relevant.
> > >
> > > As a shot in the dark I reverted:
> > >
> > >     b2b29d6d0119 mm: account PMD tables like PTE tables
> > >
> > > ...and the test passed.
> >
> > That's not really surprising ... you're still freeing PMD tables without
> > calling the destructor, which means that you're leaking ptlocks on
> > configs that can't embed the ptlock in the struct page.
>
> Ok, so potentially this new tracking is highlighting a long standing
> bug that was previously silent. That would explain the ambiguous
> bisect results.
>
> > I suppose it shows that you're leaking a PMD table rather than a PTE
> > table, so that might help track it down.  Checking for PG_table in
> > free_unref_page() and calling show_stack() will probably help more.
>
> Will do.

Thanks for the pointers Willy this fix below tests ok and looks
correct to me given the history:

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index dfd82f51ba66..7ed99314dcdf 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -829,6 +829,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
        }

        free_page((unsigned long)pmd_sv);
+       pgtable_pmd_page_dtor(virt_to_page(pmd));
        free_page((unsigned long)pmd);

        return 1;

In 2013 Kirill noticed that he missed a pmd page table free site:

    c283610e44ec x86, mm: do not leak page->ptl for pmd page tables

In 2018 Toshi added a new pmd page table free site without the destructor:

    28ee90fe6048 x86/mm: implement free pmd/pte page interfaces

In 2020 Willy adds PG_table accounting that flags the missing
pgtable_pmd_page_dtor()

Yi, I would appreciate a confirmation that the fix works for you.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
