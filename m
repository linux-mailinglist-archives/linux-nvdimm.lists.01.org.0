Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9F02EA45D
	for <lists+linux-nvdimm@lfdr.de>; Tue,  5 Jan 2021 05:19:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5F303100EBBB9;
	Mon,  4 Jan 2021 20:19:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8C619100EBBB1
	for <linux-nvdimm@lists.01.org>; Mon,  4 Jan 2021 20:19:00 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ce23so39574363ejb.8
        for <linux-nvdimm@lists.01.org>; Mon, 04 Jan 2021 20:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8gOUdE50UNp9LhAlhCoddse7EZKmhUhGDFbU73aCc4=;
        b=QQAB3r3U7V/2S0pr/HlzDsASSQCQL5YI2Yu+LKkp2b3uUmYomjrfg0xQ/kZkvLyJQ6
         upccUaRauLNncsDHq4Dan5ZBkaKXTJoCxVNuWo6SVKRMoKr0n82h1XgfvAGBdNfBPM3x
         tpbv+nMXZ/yauTzmx7BYKMKDtKWHQl+RnsMxuRFL2Jxbf04JYY8nN/uKYxGMJLS/kCyt
         15iKGTLQ6np+ytfvUZKLGX8b/FbMtjsr+qXMrCWxWeH2+cjGgV3haAtGTdB0LH492H/g
         tnFPN+k4sObUPr8XYZaAxDMevIG02HiaO09sA8oN6jeOYaDd9pD9reN7rEjfXdWPhrcE
         22fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8gOUdE50UNp9LhAlhCoddse7EZKmhUhGDFbU73aCc4=;
        b=q9jz6uMLl7EPY6APK9ETjwjXkT7sYkdSsMnambiBYVZMmWhUXcRHYfbJV+ebvqT95F
         I3Bvj2NtK3n3ya74e5AutLVh9XWD1xFOYuSLAfKXB/0Pk0epo6PeQJwN0WcKz17Jt7Il
         ggUAbhKwzbfVyH9IzQiEKkyvfNFJ9lRhuBx7ILO5SWIHQvEQwsbsZf7PXzgoeMnMRfw0
         6SckVPXX3mF7AsuOaKbRVihhAAOl+SoV4/gQdBG9mL+eVFY79Vf/C+O33sA8ed3+vXlL
         MeC8Fk1W+NJYVbikRDxU9WJXkAPYT9EjO/ojBp86F7gz2TSzeO9G3K73oOO+OqVHPxbo
         XajA==
X-Gm-Message-State: AOAM530vlmJxLXgZKoOfJsbcgkoVTfHBUWmSAqrPEnoEfNc4JVhmuNBh
	omoGnN4wOC5UFnSPcaIozofeF3ZfvcEZfr8uBEvJEyAFrNw=
X-Google-Smtp-Source: ABdhPJwUnQsFATKp5CduacMlqRJgBHibGCWUhJq78mdMhVMEWJEhUC+nU/NhEqVFi56Uab8rCE8D+QUrCHC/kVrYF4o=
X-Received: by 2002:a17:907:c15:: with SMTP id ga21mr69757557ejc.472.1609820338819;
 Mon, 04 Jan 2021 20:18:58 -0800 (PST)
MIME-Version: 1.0
References: <160697689204.605323.17629854984697045602.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160697689204.605323.17629854984697045602.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 4 Jan 2021 20:18:52 -0800
Message-ID: <CAPcyv4hdrYFCO6xXv0wfM4DFCyGAeYDETJwmJVOOtsJSKwEjNA@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Fix leak of pmd ptlock
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Message-ID-Hash: VYGE24COHEWUOAKVBV5RO5OBGBK3TUUD
X-Message-ID-Hash: VYGE24COHEWUOAKVBV5RO5OBGBK3TUUD
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stable <stable@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Yi Zhang <yi.zhang@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VYGE24COHEWUOAKVBV5RO5OBGBK3TUUD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ping, this bug is still present on v5.11-rc2, need a resend?

On Wed, Dec 2, 2020 at 10:28 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Commit 28ee90fe6048 ("x86/mm: implement free pmd/pte page interfaces")
> introduced a new location where a pmd was released, but neglected to run
> the pmd page destructor. In fact, this happened previously for a
> different pmd release path and was fixed by commit:
>
> c283610e44ec ("x86, mm: do not leak page->ptl for pmd page tables").
>
> This issue was hidden until recently because the failure mode is silent,
> but commit:
>
> b2b29d6d0119 ("mm: account PMD tables like PTE tables")
>
> ...turns the failure mode into this signature:
>
>  BUG: Bad page state in process lt-pmem-ns  pfn:15943d
>  page:000000007262ed7b refcount:0 mapcount:-1024 mapping:0000000000000000 index:0x0 pfn:0x15943d
>  flags: 0xaffff800000000()
>  raw: 00affff800000000 dead000000000100 0000000000000000 0000000000000000
>  raw: 0000000000000000 ffff913a029bcc08 00000000fffffbff 0000000000000000
>  page dumped because: nonzero mapcount
>  [..]
>   dump_stack+0x8b/0xb0
>   bad_page.cold+0x63/0x94
>   free_pcp_prepare+0x224/0x270
>   free_unref_page+0x18/0xd0
>   pud_free_pmd_page+0x146/0x160
>   ioremap_pud_range+0xe3/0x350
>   ioremap_page_range+0x108/0x160
>   __ioremap_caller.constprop.0+0x174/0x2b0
>   ? memremap+0x7a/0x110
>   memremap+0x7a/0x110
>   devm_memremap+0x53/0xa0
>   pmem_attach_disk+0x4ed/0x530 [nd_pmem]
>   ? __devm_release_region+0x52/0x80
>   nvdimm_bus_probe+0x85/0x210 [libnvdimm]
>
> Given this is a repeat occurrence it seemed prudent to look for other
> places where this destructor might be missing and whether a better
> helper is needed. try_to_free_pmd_page() looks like a candidate, but
> testing with setting up and tearing down pmd mappings via the dax unit
> tests is thus far not triggering the failure. As for a better helper
> pmd_free() is close, but it is a messy fit due to requiring an @mm arg.
> Also, ___pmd_free_tlb() wants to call paravirt_tlb_remove_table()
> instead of free_page(), so open-coded pgtable_pmd_page_dtor() seems the
> best way forward for now.
>
> Fixes: 28ee90fe6048 ("x86/mm: implement free pmd/pte page interfaces")
> Cc: <stable@vger.kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Co-debugged-by: Matthew Wilcox <willy@infradead.org>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/mm/pgtable.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index dfd82f51ba66..f6a9e2e36642 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -829,6 +829,8 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>         }
>
>         free_page((unsigned long)pmd_sv);
> +
> +       pgtable_pmd_page_dtor(virt_to_page(pmd));
>         free_page((unsigned long)pmd);
>
>         return 1;
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
