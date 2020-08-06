Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F8E23D921
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Aug 2020 12:11:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5342D12BD9DB0;
	Thu,  6 Aug 2020 03:11:10 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com; envelope-from=kirill@shutemov.name; receiver=<UNKNOWN> 
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EECF912BD9DAB
	for <linux-nvdimm@lists.01.org>; Thu,  6 Aug 2020 03:11:08 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j22so19932112lfm.2
        for <linux-nvdimm@lists.01.org>; Thu, 06 Aug 2020 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FmHNrmiGc1oEc9Yta/aBuQn+1EulEN2xZuLGLoeLXHQ=;
        b=vdAe04pQJi4piGZ5+mZ0j2zhjTn6XVtWXoKVvfYvjkZt497I/uZbgq0bCXUw9yqxv1
         aDwbG4fQLRxllT940g4JJIoLaihdHAzLTznrUByrMW1Sxn0NV4LG6ITrocLkxfQ/UbR8
         /22r5p3LxUUJDP/bT5Lo9OvmnoXmRxUSyOPo0gH4uKUH+elU8Mn1VlYg4xH7/Swt6AEz
         woNXvCrI7kpsrhxnMJDhchfVxMGgUKsXYC/i/xUa92sA04Rdaab+RLuwLDiP7hERRYMU
         MGSXXRnFS4yE+plzwECIlQPOIq5Q9sL11BNdJXjz4h7FpV4jOJJQ0vybui6R3DGZ4y4F
         e/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FmHNrmiGc1oEc9Yta/aBuQn+1EulEN2xZuLGLoeLXHQ=;
        b=YwA8aSWlZ6hO7mYgcM01tP3IORuh+vPyiJoOgjKtR86QGAxpweo3PQSDbQWYLcoLG1
         2FoYRz51nVx9CpjxKIJapwZ9UrXRP9FH7lhgs85fL563FXyABMXpmWcBfUbjVnfEgobi
         Hg/ry/3P3OPopqhrJfeq5QnB5Lt5KYgYeZ+IThcb3qTyN6MnMvIMO2SchRLUOQJQsl1e
         6/DEAz0TFcslzPV78LIgQx53jx7slopal6asnS7d7mTTlsE1uDxZsXf9qRkOIEhQzfnT
         D7ku8Ply7idkLSSmwTlT+B0ZvwJNCJzD7K+MEHH/4+8t4wYqhyQeWjL6e+z2ia1mZ0on
         6gwQ==
X-Gm-Message-State: AOAM53228u7mJzv0rVoJLx0iLa6d44foj6WXQenU0bGVMiHAPzWn+UC+
	2TASjGivYYFnoVXfdDzTBsnXLg==
X-Google-Smtp-Source: ABdhPJztxQdmUqdlmLCUV07uqArQbN1pckvCcR5Q9hxz1Dr0Q7jnsmbBT95GM1N8CkcdipmeoNGGIA==
X-Received: by 2002:a19:70c:: with SMTP id 12mr3611270lfh.207.1596708665300;
        Thu, 06 Aug 2020 03:11:05 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v9sm2356183lja.81.2020.08.06.03.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 03:11:04 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
	id 92823102E1B; Thu,  6 Aug 2020 13:11:12 +0300 (+03)
Date: Thu, 6 Aug 2020 13:11:12 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v3 1/6] mm: add definition of PMD_PAGE_ORDER
Message-ID: <20200806101112.bjw4mxu2odpsg2hh@box>
References: <20200804095035.18778-1-rppt@kernel.org>
 <20200804095035.18778-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200804095035.18778-2-rppt@kernel.org>
Message-ID-Hash: 6NNGPXTWV3ECN4BIKEW4RNQHESNWDOJT
X-Message-ID-Hash: 6NNGPXTWV3ECN4BIKEW4RNQHESNWDOJT
X-MailFrom: kirill@shutemov.name
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdev
 el@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6NNGPXTWV3ECN4BIKEW4RNQHESNWDOJT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 04, 2020 at 12:50:30PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The definition of PMD_PAGE_ORDER denoting the number of base pages in the
> second-level leaf page is already used by DAX and maybe handy in other
> cases as well.
> 
> Several architectures already have definition of PMD_ORDER as the size of
> second level page table, so to avoid conflict with these definitions use
> PMD_PAGE_ORDER name and update DAX respectively.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  fs/dax.c                | 10 +++++-----
>  include/linux/pgtable.h |  3 +++
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 11b16729b86f..b91d8c8dda45 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -50,7 +50,7 @@ static inline unsigned int pe_order(enum page_entry_size pe_size)
>  #define PG_PMD_NR	(PMD_SIZE >> PAGE_SHIFT)
>  
>  /* The order of a PMD entry */
> -#define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> +#define PMD_PAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)

Hm. Wouldn't it conflict with definition in pgtable.h? Or should we
include it instead?

> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 56c1e8eb7bb0..79f8443609e7 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -28,6 +28,9 @@
>  #define USER_PGTABLES_CEILING	0UL
>  #endif
>  
> +/* Number of base pages in a second level leaf page */
> +#define PMD_PAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> +
>  /*
>   * A page table page can be thought of an array like this: pXd_t[PTRS_PER_PxD]
>   *

-- 
 Kirill A. Shutemov
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
