Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C52582903C4
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Oct 2020 13:08:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 78B0316071510;
	Fri, 16 Oct 2020 04:08:04 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A5D8916071506
	for <linux-nvdimm@lists.01.org>; Fri, 16 Oct 2020 04:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eyZ2qg64RQ303sBdkP1lBs7fkr9God3dSz0qy38M/4M=; b=dZ9yLLnDn8uHkOohF4LtcVTtmG
	vD/AvaMvtW7Iv79FR7SYDe3WCGkohikUM/LA3sJTkktbuTGecWJvkHruNptN/hVsM2IupFmNIA5S2
	H69bQ0Xu77anBDXOJpsYWe7HHiH337wX6hYLdljPurcjoEypXOYYjyKQvTTowiu2JOKasGGQ3Ossx
	x62zDNQP0/8RlsPG6ycSOA2wYISuv2XuWA+cMKIfe67hrK8616drWYuaoceAy9lBS9hNaXpb/QDXH
	NY6rmTF3WZZmzQ9PYAMvqWkvZcVjSAbvTFWrdah3Db5WssoZG3WYHZbfoY6sxywhh63dSN4xzCz1t
	SJLSJzPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTNaP-0001gC-NE; Fri, 16 Oct 2020 11:07:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 978F03011E6;
	Fri, 16 Oct 2020 13:07:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8A2F622E98D29; Fri, 16 Oct 2020 13:07:47 +0200 (CEST)
Date: Fri, 16 Oct 2020 13:07:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: ira.weiny@intel.com
Subject: Re: [PATCH RFC V3 5/9] x86/pks: Add PKS kernel API
Message-ID: <20201016110747.GM2611@hirez.programming.kicks-ass.net>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-6-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201009194258.3207172-6-ira.weiny@intel.com>
Message-ID-Hash: FWJ3URAZQEQDRAJ6DZ2LT6IVS4XQRO3E
X-Message-ID-Hash: FWJ3URAZQEQDRAJ6DZ2LT6IVS4XQRO3E
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FWJ3URAZQEQDRAJ6DZ2LT6IVS4XQRO3E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 09, 2020 at 12:42:54PM -0700, ira.weiny@intel.com wrote:
> +static inline void pks_update_protection(int pkey, unsigned long protection)
> +{
> +	current->thread.saved_pkrs = update_pkey_val(current->thread.saved_pkrs,
> +						     pkey, protection);
> +	preempt_disable();
> +	write_pkrs(current->thread.saved_pkrs);
> +	preempt_enable();
> +}

write_pkrs() already disables preemption itself. Wrapping it in yet
another layer is useless.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
