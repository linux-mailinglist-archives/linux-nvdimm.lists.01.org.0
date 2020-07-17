Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9712238F0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 12:06:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 67F8011F6E70C;
	Fri, 17 Jul 2020 03:06:27 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2CEE011F6E70B
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 03:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K43ZCjJYMy6klub7Xq9DzX6bYQQEbWnMvoQ9/7nSlAU=; b=kkj/1INFxcsjPmAR7HcjcnkS3F
	gw7royqUQ/ZjChcF6ex998nRsQtVD8spWkTSkg3erjwYnMG/byuVK5dodJVY+nAW6ZP31fbitrYbx
	XASLEXixb7B5lLt+39tv+EAuZ75Q+jVs04bCADdjSmLIa6K1FEFih8/mS8J+WCt9OGM/80ogi0xe7
	Xo8Q2rQXvnhMNB5RooczCx4UaqQye0duLIMEuN1+9eM+0/f9axdcXAkGf9PVove8rnp+8J6aJwjgJ
	7IATAvjDIyeylA4nJvrm+w5utE1TjSJIxm2ynBiGTatJOtZYYD5WAttk8FyPDpfucP4CDH6R2FbwN
	13hGovbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwNFs-0001WA-IX; Fri, 17 Jul 2020 10:06:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCBFF300446;
	Fri, 17 Jul 2020 12:06:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id B678029CF6F57; Fri, 17 Jul 2020 12:06:10 +0200 (CEST)
Date: Fri, 17 Jul 2020 12:06:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: ira.weiny@intel.com
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200717100610.GH10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717072056.73134-18-ira.weiny@intel.com>
Message-ID-Hash: OUZAHKW3VUS7TPJFF7UKOMYYH2XZJZIG
X-Message-ID-Hash: OUZAHKW3VUS7TPJFF7UKOMYYH2XZJZIG
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OUZAHKW3VUS7TPJFF7UKOMYYH2XZJZIG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 12:20:56AM -0700, ira.weiny@intel.com wrote:
> First I'm not sure if adding this state to idtentry_state and having
> that state copied is the right way to go.  It seems like we should start
> passing this by reference instead of value.  But for now this works as
> an RFC.  Comments?

As long as you keep sizeof(struct idtentry_state_t) <= sizeof(u64) or
possibly 2*sizeof(unsigned long), code gen shouldn't be too horrid IIRC.
You'll have to look at what the compiler makes of it.

> Second, I'm not 100% happy with having to save the reference count in
> the exception handler.  It seems like a very ugly layering violation but
> I don't see a way around it at the moment.

So I've been struggling with that API, all the way from
pks_update_protection() to that dev_access_{en,dis}able(). I _really_
hate it, but I see how you ended up with it.

I wanted to propose something like:

u32 current_pkey_save(int pkey, unsigned flags)
{
	u32 *lpkr = get_cpu_ptr(&local_pkr);
	u32 pkr, saved = *lpkr;

	pkr = update_pkey_reg(saved, pkey, flags);
	if (pkr != saved)
		wrpkr(pkr);

	put_cpu_ptr(&local_pkr);
	return saved;
}

void current_pkey_restore(u32 pkr)
{
	u32 *lpkr = get_cpu_ptr(&local_pkr);
	if (*lpkr != pkr)
		wrpkr(pkr);
	put_cpu_ptr(&local_pkr);
}

Together with:

void pkey_switch(struct task_struct *prev, struct task_struct *next)
{
	prev->pkr = this_cpu_read(local_pkr);
	if (prev->pkr != next->pkr)
		wrpkr(next->pkr);
}

But that's actually hard to frob into the kmap() model :-( The upside is
that you only have 1 word of state, instead of the 2 you have now.

> Third, this patch has gone through a couple of revisions as I've had
> crashes which just don't make sense to me.  One particular issue I've
> had is taking a MCE during memcpy_mcsafe causing my WARN_ON() to fire.
> The code path was a pmem copy and the ref count should have been
> elevated due to dev_access_enable() but why was
> idtentry_enter()->idt_save_pkrs() not called I don't know.

Because MCEs are NMI-like and don't go through the normal interrupt
path. MCEs are an abomination, please wear all the protective devices
you can lay hands on when delving into that.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
