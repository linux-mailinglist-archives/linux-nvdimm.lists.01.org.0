Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE9D21EB98
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jul 2020 10:41:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 37C32100F478C;
	Tue, 14 Jul 2020 01:41:12 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C2F30100F478A
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 01:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7EYMAPkg0epsaMUyGWJdgDKUvk+AqT0tO9qkB/mcaeo=; b=wfr+9nwGB+CdzxX9LElESkKpwK
	5k6vYKRmT9DWltVSjWYMZnlQ/I7lRShp5WfUSxuESbkpptjM1Zh51DEeu3IE2h70muDG6uMcqNOJs
	tbUiCnwFTFua/844sZg8NY3KOWNMYBopQOL65ye10DuSJEQrab2Owce2ZJPEvCdclI4nYahvmc+/m
	EAV1vZjgIkz6FI88PB18iJgnXx5oP3SGBVUT0ldkiYGCcd17mQCOx3Ky+cLShm+MxUZWkyYv8ysI/
	pC8MiwAVFKfFJndnElLfvG/DprsK6kP6uqUIpq6f1xjuyLepg4kSLDczlLmAkx+6IjVFOvlyQchuw
	oZXIlvmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvGUl-0006VI-Lv; Tue, 14 Jul 2020 08:40:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8831E305C22;
	Tue, 14 Jul 2020 10:40:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7393128B91072; Tue, 14 Jul 2020 10:40:57 +0200 (CEST)
Date: Tue, 14 Jul 2020 10:40:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: ira.weiny@intel.com
Subject: Re: [RFC PATCH 11/15] memremap: Add zone device access protection
Message-ID: <20200714084057.GP10769@hirez.programming.kicks-ass.net>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-12-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200714070220.3500839-12-ira.weiny@intel.com>
Message-ID-Hash: KBBNIGP4CPFZH74SILF5E4ZG6XVS6X7H
X-Message-ID-Hash: KBBNIGP4CPFZH74SILF5E4ZG6XVS6X7H
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KBBNIGP4CPFZH74SILF5E4ZG6XVS6X7H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 14, 2020 at 12:02:16AM -0700, ira.weiny@intel.com wrote:

> +static pgprot_t dev_protection_enable_get(struct dev_pagemap *pgmap, pgprot_t prot)
> +{
> +	if (pgmap->flags & PGMAP_PROT_ENABLED && dev_page_pkey != PKEY_INVALID) {
> +		pgprotval_t val = pgprot_val(prot);
> +
> +		mutex_lock(&dev_prot_enable_lock);
> +		dev_protection_enable++;
> +		/* Only enable the static branch 1 time */
> +		if (dev_protection_enable == 1)
> +			static_branch_enable(&dev_protection_static_key);
> +		mutex_unlock(&dev_prot_enable_lock);
> +
> +		prot = __pgprot(val | _PAGE_PKEY(dev_page_pkey));
> +	}
> +	return prot;
> +}
> +
> +static void dev_protection_enable_put(struct dev_pagemap *pgmap)
> +{
> +	if (pgmap->flags & PGMAP_PROT_ENABLED && dev_page_pkey != PKEY_INVALID) {
> +		mutex_lock(&dev_prot_enable_lock);
> +		dev_protection_enable--;
> +		if (dev_protection_enable == 0)
> +			static_branch_disable(&dev_protection_static_key);
> +		mutex_unlock(&dev_prot_enable_lock);
> +	}
> +}

That's an anti-pattern vs static_keys, I'm thinking you actually want
static_key_slow_{inc,dec}() instead of {enable,disable}().
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
