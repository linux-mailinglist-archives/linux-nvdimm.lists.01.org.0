Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63906226E61
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jul 2020 20:35:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D137100A6D48;
	Mon, 20 Jul 2020 11:35:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4BA6B100A6D46
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 11:35:17 -0700 (PDT)
IronPort-SDR: F8pjRYlY1qtG8z4gii1N7aTnryq+AqhppP7AqpP8I3IadhcnUTRvgPCjfULX4+vxXLOJTwxc8i
 BVKMmmGA8rPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="211527667"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800";
   d="scan'208";a="211527667"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 11:35:16 -0700
IronPort-SDR: wK7wo3tDMannoMaWGv9oSkwguhLqP6DavKpuU2XXsLRCL8yJhaDeTIBrq75zM686eRl+HmbVUR
 EPP//W3JMNMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800";
   d="scan'208";a="309946010"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2020 11:35:16 -0700
Date: Mon, 20 Jul 2020 11:35:16 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC V2 04/17] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20200720183515.GF478573@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-5-ira.weiny@intel.com>
 <20200717085954.GY10769@hirez.programming.kicks-ass.net>
 <20200717223407.GS3008823@iweiny-DESK2.sc.intel.com>
 <20200720091554.GN10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200720091554.GN10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: JPE432ORBFTOB5V6NYHSAFEG23T74HWO
X-Message-ID-Hash: JPE432ORBFTOB5V6NYHSAFEG23T74HWO
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JPE432ORBFTOB5V6NYHSAFEG23T74HWO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 20, 2020 at 11:15:54AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 03:34:07PM -0700, Ira Weiny wrote:
> > On Fri, Jul 17, 2020 at 10:59:54AM +0200, Peter Zijlstra wrote:
> > > On Fri, Jul 17, 2020 at 12:20:43AM -0700, ira.weiny@intel.com wrote:
> > > > +/*
> > > > + * Write the PKey Register Supervisor.  This must be run with preemption
> > > > + * disabled as it does not guarantee the atomicity of updating the pkrs_cache
> > > > + * and MSR on its own.
> > > > + */
> > > > +void write_pkrs(u32 pkrs_val)
> > > > +{
> > > > +	this_cpu_write(pkrs_cache, pkrs_val);
> > > > +	wrmsrl(MSR_IA32_PKRS, pkrs_val);
> > > > +}
> > > 
> > > Should we write that like:
> > > 
> > > void write_pkrs(u32 pkr)
> > > {
> > > 	u32 *pkrs = get_cpu_ptr(pkrs_cache);
> > > 	if (*pkrs != pkr) {
> > > 		*pkrs = pkr;
> > > 		wrmsrl(MSR_IA32_PKRS, pkr);
> > > 	}
> > > 	put_cpu_ptrpkrs_cache);
> > > }
> > > 
> > > given that we fundamentally need to serialize againt schedule() here.
> > 
> > Yes.  That seems better.
> > 
> > That also means pks_sched_in() can be simplified to just
> > 
> > static inline void pks_sched_in(void)
> > {
> > 	write_pkrs(current->thread.saved_pkrs);
> > }
> > 
> > Because of the built WRMSR avoidance.
> > 
> > However, pkrs_cache is static so I think I need to use {get,put}_cpu_var() here
> > don't I?
> 
> Or get_cpu_ptr(&pkrs_cache), sorry for the typo :-)

Ah I see...  sorry, yes that will work.

Done,
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
