Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D344B21EB47
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jul 2020 10:27:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ED399111B91F6;
	Tue, 14 Jul 2020 01:27:15 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DB9BD111B91F3
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 01:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A51ag8nDs9zuaekV72PLvRRRTy65GcHBqX/h7vCoPM8=; b=Qliqg88yubr5gTr0CebRm5zHyM
	VmoSi0W8BiWxbo8q0BQItVbTESnzPp2YQGxipV4dST4DFJUBsJEgrytU7IzP9Ptmtt31ahpakJj6W
	pvVJgC5LHcsQYfqFGy5fNdrhBWJcuZf7H3SfDGiu09ZMSL4+z0b4A+hAncBX1lLJRahHM4aEJlNXj
	lWa0NgagAQJSPYr3J9uR3wRQOov3bvouDKlbm6svybYdiMyh2k7P7B7hdk3PoyRtrnU8/ltNHbyf4
	4872KPEM7cf358Zm+G7TVXFu4J9ua11eoXXrDYwTVxnobsO9G7E1mpGrwznsBUZ6VolO/a5+BQvvh
	bjtbmldw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvGHI-0003qe-0A; Tue, 14 Jul 2020 08:27:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E72DC305C22;
	Tue, 14 Jul 2020 10:27:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id C5FA120D27C6B; Tue, 14 Jul 2020 10:27:01 +0200 (CEST)
Date: Tue, 14 Jul 2020 10:27:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: ira.weiny@intel.com
Subject: Re: [RFC PATCH 04/15] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20200714082701.GO10769@hirez.programming.kicks-ass.net>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200714070220.3500839-5-ira.weiny@intel.com>
Message-ID-Hash: PVJMYXC5F62LJ6NTOLX376HBBTYXTO66
X-Message-ID-Hash: PVJMYXC5F62LJ6NTOLX376HBBTYXTO66
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PVJMYXC5F62LJ6NTOLX376HBBTYXTO66/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 14, 2020 at 12:02:09AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The PKRS MSR is defined as a per-core register.  This isolates memory
> access by CPU.  Unfortunately, the MSR is not preserved by XSAVE.
> Therefore, We must preserve the protections for individual tasks even if
> they are context switched out and placed on another cpu later.

This is a contradiction and utter trainwreck. We're not going to do more
per-core MSRs and pretend they make sense per-task.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
