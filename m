Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE7A223785
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 11:00:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D857611EB8D91;
	Fri, 17 Jul 2020 02:00:07 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0ED1211EB8D8E
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 02:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8xT/WVtQE2KY4X7YjP79ChPInUPynkTTYKC9pryceZE=; b=e8KQste/jtn3QrtBaetLpn+930
	lo7u3UpKqeat3xIAKeiubE8XcxBOKlbeGR+zBvDcke8mVhn2ZhXIwz/zwSoruuzYOQQnpdCu9VnX7
	kPEQ1GdsmNi7kWdwGOU62EL1GI1oq3MhbE3MF5Emma66Ddcf580sU3Uax4jBgNxK6tB5mi9o8UN5l
	dEky9TUhy29LwKea+f2O3dJtrVwpY6RLv8drTRWYk4uE/aME4kvSRVvTQhQZi19Y+5rjSYthwxVtj
	3m5koTs+xwLdLDFypF6fAfbSPUXt7HXH9dhFltXANJc09Slkg5B6GcdVs0+Zs1woD4Yqqt0nwQFQf
	i6xNaS1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwMDk-0005yy-7T; Fri, 17 Jul 2020 08:59:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D695B304D58;
	Fri, 17 Jul 2020 10:59:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id B702429CF6F79; Fri, 17 Jul 2020 10:59:54 +0200 (CEST)
Date: Fri, 17 Jul 2020 10:59:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: ira.weiny@intel.com
Subject: Re: [PATCH RFC V2 04/17] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20200717085954.GY10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717072056.73134-5-ira.weiny@intel.com>
Message-ID-Hash: RR4Z4YJNQ7VJN7WRHQPWW5FGMGVFRLZH
X-Message-ID-Hash: RR4Z4YJNQ7VJN7WRHQPWW5FGMGVFRLZH
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RR4Z4YJNQ7VJN7WRHQPWW5FGMGVFRLZH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 12:20:43AM -0700, ira.weiny@intel.com wrote:
> +/*
> + * Write the PKey Register Supervisor.  This must be run with preemption
> + * disabled as it does not guarantee the atomicity of updating the pkrs_cache
> + * and MSR on its own.
> + */
> +void write_pkrs(u32 pkrs_val)
> +{
> +	this_cpu_write(pkrs_cache, pkrs_val);
> +	wrmsrl(MSR_IA32_PKRS, pkrs_val);
> +}

Should we write that like:

void write_pkrs(u32 pkr)
{
	u32 *pkrs = get_cpu_ptr(pkrs_cache);
	if (*pkrs != pkr) {
		*pkrs = pkr;
		wrmsrl(MSR_IA32_PKRS, pkr);
	}
	put_cpu_ptrpkrs_cache);
}

given that we fundamentally need to serialize againt schedule() here.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
