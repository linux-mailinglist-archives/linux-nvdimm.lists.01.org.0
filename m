Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EA5290EFF
	for <lists+linux-nvdimm@lfdr.de>; Sat, 17 Oct 2020 07:14:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 72DB815CBDC36;
	Fri, 16 Oct 2020 22:14:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 66439158AFE91
	for <linux-nvdimm@lists.01.org>; Fri, 16 Oct 2020 22:14:13 -0700 (PDT)
IronPort-SDR: dCxUyTWFkyP8tO2brZK0JVDzSAb3GQDHzYEccIBA1uhJBpqq79i//faZ6bSItYHhYNwEldJPfi
 vuYNQgsP95Lw==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="153671599"
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400";
   d="scan'208";a="153671599"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 22:14:11 -0700
IronPort-SDR: 3XRfBEMKtTlYf8Z8qW4rktOEmrz3tfwYHJY64FpmSJj9Yo7F5sdqW0j6CxcMd1S6SrD+tuozbQ
 2OvTFTNMfadw==
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400";
   d="scan'208";a="522523589"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 22:14:11 -0700
Date: Fri, 16 Oct 2020 22:14:10 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC V3 4/9] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20201017051410.GW2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-5-ira.weiny@intel.com>
 <429789d3-ab5b-49c3-65c3-f0fc30a12516@intel.com>
 <20201016111226.GN2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201016111226.GN2611@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 47JSCHSSEIZKURQJKBI76EMTEGBYFDYP
X-Message-ID-Hash: 47JSCHSSEIZKURQJKBI76EMTEGBYFDYP
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/47JSCHSSEIZKURQJKBI76EMTEGBYFDYP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 16, 2020 at 01:12:26PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 13, 2020 at 11:31:45AM -0700, Dave Hansen wrote:
> > > +/**
> > > + * It should also be noted that the underlying WRMSR(MSR_IA32_PKRS) is not
> > > + * serializing but still maintains ordering properties similar to WRPKRU.
> > > + * The current SDM section on PKRS needs updating but should be the same as
> > > + * that of WRPKRU.  So to quote from the WRPKRU text:
> > > + *
> > > + * 	WRPKRU will never execute transiently. Memory accesses
> > > + * 	affected by PKRU register will not execute (even transiently)
> > > + * 	until all prior executions of WRPKRU have completed execution
> > > + * 	and updated the PKRU register.
> > > + */
> > > +void write_pkrs(u32 new_pkrs)
> > > +{
> > > +	u32 *pkrs;
> > > +
> > > +	if (!static_cpu_has(X86_FEATURE_PKS))
> > > +		return;
> > > +
> > > +	pkrs = get_cpu_ptr(&pkrs_cache);
> > > +	if (*pkrs != new_pkrs) {
> > > +		*pkrs = new_pkrs;
> > > +		wrmsrl(MSR_IA32_PKRS, new_pkrs);
> > > +	}
> > > +	put_cpu_ptr(pkrs);
> > > +}
> > > 
> > 
> > It bugs me a *bit* that this is being called in a preempt-disabled
> > region, but we still bother with the get/put_cpu jazz.  Are there other
> > future call-sites for this that aren't in preempt-disabled regions?
> 
> So the previous version had a useful comment that got lost.

Ok Looking back I see what happened...  This comment...

 /*
  * PKRS is only temporarily changed during specific code paths.
  * Only a preemption during these windows away from the default
  * value would require updating the MSR.
  */

... was added to pks_sched_in() but that got simplified down because cleaning
up write_pkrs() made the code there obsolete.

> This stuff
> needs to fundamentally be preempt disabled,

I agree, the update to the percpu cache value and MSR can not be torn.

> so it either needs to
> explicitly do so, or have an assertion that preemption is indeed
> disabled.

However, I don't think I understand clearly.  Doesn't [get|put]_cpu_ptr()
handle the preempt_disable() for us?  Is it not sufficient to rely on that?

Dave's comment seems to be the opposite where we need to eliminate preempt
disable before calling write_pkrs().

FWIW I think I'm mistaken in my response to Dave regarding the
preempt_disable() in pks_update_protection().

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
