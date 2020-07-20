Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B73AB225B05
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jul 2020 11:14:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65E2C123757CD;
	Mon, 20 Jul 2020 02:14:46 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 83F1E123757CA
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 02:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EpGd6SEaYQtDfwRuX/5QX4nSgxOOCJks5zLX/RcylHI=; b=o2uXRpBUKCj/3z9C8xL2NxsLDH
	rKrqEdke9+y7xe207kiZRU9MC379GI4gZovgu/FmbG8gR4nxsro7LQolBc01s12sEEIchddhnfxqX
	4jvm2gzcB0p4+cybVE9RXmvefsfzt+TJzrw4vh31pRkw3wYYWOHR58N1G9eRMxyMfSV0cBNxHPVTs
	dcl+yj/dT4hQbBaJBaRevoQTSOhR1OCJy4AfJvmbxWldkPMMaIvh4YXDb8kYYQL/TUyMLrLp14kAw
	x44frFLYDRGbXy3JcYGVMHEuSC28p3zVgHSHp9eYgwXrRvBo4vQxaRluocS9a3q41UoK9ZFf2Azor
	X4lLH7RQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxRsb-0005jK-4L; Mon, 20 Jul 2020 09:14:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BED2A306CEE;
	Mon, 20 Jul 2020 11:14:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id B0D04205A7673; Mon, 20 Jul 2020 11:14:35 +0200 (CEST)
Date: Mon, 20 Jul 2020 11:14:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH RFC V2 02/17] x86/fpu: Refactor
 arch_set_user_pkey_access() for PKS support
Message-ID: <20200720091435.GM10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-3-ira.weiny@intel.com>
 <20200717085442.GX10769@hirez.programming.kicks-ass.net>
 <20200717205254.GQ3008823@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717205254.GQ3008823@iweiny-DESK2.sc.intel.com>
Message-ID-Hash: XQOCAKVD3PF5KZB6AD7F7JNHA7U6IHN4
X-Message-ID-Hash: XQOCAKVD3PF5KZB6AD7F7JNHA7U6IHN4
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XQOCAKVD3PF5KZB6AD7F7JNHA7U6IHN4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 01:52:55PM -0700, Ira Weiny wrote:
> On Fri, Jul 17, 2020 at 10:54:42AM +0200, Peter Zijlstra wrote:

> > Then we at least have a little clue wtf the thing does.. Yes I started
> > with a rename and then got annoyed at the implementation too.
> 
> On the code I think this is fair.  I've also updated the calling function to be
> a bit cleaner as well.
> 
> However, I think the name 'update' is a bit misleading.  Here is the new
> calling code:
> 
> ...
>         pkru = read_pkru();
> 	pkru = update_pkey_reg(pkru, pkey, init_val);
> 	write_pkru(pkru);
> ...
> 
> 
> I think it is odd to have a function called update_pkey_reg() called right
> before a write_pkru().  Can we call this update_pkey_value?  or just 'val'?
> Because write_pkru() actually updates the register.

Fair enough, update_pkey_val() works fine for me.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
