Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E785A225B18
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jul 2020 11:16:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 970F9123757CB;
	Mon, 20 Jul 2020 02:16:04 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B4D601236F6C3
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LGLWvg6ZDIUlei0ZDQ3T5GmRjQgNLRaVaWwSYGqHGW4=; b=hSBeriNHtlumBJ+DPG5faJaUBK
	xOohGFXtfbnZk6s5lws1YyNCXqeSHDgqdGn6Wo7FyyBA8zVImTRfO722gMZD48RZoXPx+JkfpUVlu
	TKh11UPDMA2/enEZKUwjegXxgRSEG0uJPFvxApi4A1eN+vXlXxim2A/g4A4Ia8LiRgps7RgVk4AUi
	rGStWRJjZ9iLyu5d8pBo3A2cHvvBEYJbweYyDj0/J3K3u6GyAEp3FGfyjWXdvkuJD8/D+udXHtcZh
	qpbn6ZAr/RTIgKpXTPWMwjJeHwjDlkVR6Uv9xhWno3N5yy+Bdjf6QTUGXzF98MYmW1Egoo81znxWW
	dnOw8mjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxRtr-0005wP-Ts; Mon, 20 Jul 2020 09:15:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 89F023010C8;
	Mon, 20 Jul 2020 11:15:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7B365205A7673; Mon, 20 Jul 2020 11:15:54 +0200 (CEST)
Date: Mon, 20 Jul 2020 11:15:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH RFC V2 04/17] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20200720091554.GN10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-5-ira.weiny@intel.com>
 <20200717085954.GY10769@hirez.programming.kicks-ass.net>
 <20200717223407.GS3008823@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717223407.GS3008823@iweiny-DESK2.sc.intel.com>
Message-ID-Hash: L4BRNA5PPUTETPJ2O6ZWSVLZAIJ4E5FR
X-Message-ID-Hash: L4BRNA5PPUTETPJ2O6ZWSVLZAIJ4E5FR
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L4BRNA5PPUTETPJ2O6ZWSVLZAIJ4E5FR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 03:34:07PM -0700, Ira Weiny wrote:
> On Fri, Jul 17, 2020 at 10:59:54AM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 17, 2020 at 12:20:43AM -0700, ira.weiny@intel.com wrote:
> > > +/*
> > > + * Write the PKey Register Supervisor.  This must be run with preemption
> > > + * disabled as it does not guarantee the atomicity of updating the pkrs_cache
> > > + * and MSR on its own.
> > > + */
> > > +void write_pkrs(u32 pkrs_val)
> > > +{
> > > +	this_cpu_write(pkrs_cache, pkrs_val);
> > > +	wrmsrl(MSR_IA32_PKRS, pkrs_val);
> > > +}
> > 
> > Should we write that like:
> > 
> > void write_pkrs(u32 pkr)
> > {
> > 	u32 *pkrs = get_cpu_ptr(pkrs_cache);
> > 	if (*pkrs != pkr) {
> > 		*pkrs = pkr;
> > 		wrmsrl(MSR_IA32_PKRS, pkr);
> > 	}
> > 	put_cpu_ptrpkrs_cache);
> > }
> > 
> > given that we fundamentally need to serialize againt schedule() here.
> 
> Yes.  That seems better.
> 
> That also means pks_sched_in() can be simplified to just
> 
> static inline void pks_sched_in(void)
> {
> 	write_pkrs(current->thread.saved_pkrs);
> }
> 
> Because of the built WRMSR avoidance.
> 
> However, pkrs_cache is static so I think I need to use {get,put}_cpu_var() here
> don't I?

Or get_cpu_ptr(&pkrs_cache), sorry for the typo :-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
