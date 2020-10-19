Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E91292DB9
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Oct 2020 20:49:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2B32415948577;
	Mon, 19 Oct 2020 11:49:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BE15A15947F9F
	for <linux-nvdimm@lists.01.org>; Mon, 19 Oct 2020 11:48:59 -0700 (PDT)
IronPort-SDR: 27dUGr1rjGjhQaMpcAxlmjIzx78UyP3d6W4a5eXT8Ia58p537Px/JcJMAP+bFUecshvrI60yTR
 QYRgHlgC3WTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="154025058"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400";
   d="scan'208";a="154025058"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 11:48:51 -0700
IronPort-SDR: 9Q6lfeqmVXf8xJoZpKKEiMAlLaNRA4+210TknTwmbYMu5RiGfjwSmlxLQWJuXLP/L8JCdm8vZJ
 yjNckI9qdKrw==
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400";
   d="scan'208";a="301476541"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 11:48:49 -0700
Date: Mon, 19 Oct 2020 11:48:49 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC V3 4/9] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20201019184849.GC3713473@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-5-ira.weiny@intel.com>
 <429789d3-ab5b-49c3-65c3-f0fc30a12516@intel.com>
 <20201016111226.GN2611@hirez.programming.kicks-ass.net>
 <20201017051410.GW2046448@iweiny-DESK2.sc.intel.com>
 <20201019093714.GI2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201019093714.GI2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 27CT5WTGCOJCVNYQYSHHDBLW36VZVGEE
X-Message-ID-Hash: 27CT5WTGCOJCVNYQYSHHDBLW36VZVGEE
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/27CT5WTGCOJCVNYQYSHHDBLW36VZVGEE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 19, 2020 at 11:37:14AM +0200, Peter Zijlstra wrote:
> On Fri, Oct 16, 2020 at 10:14:10PM -0700, Ira Weiny wrote:
> > > so it either needs to
> > > explicitly do so, or have an assertion that preemption is indeed
> > > disabled.
> > 
> > However, I don't think I understand clearly.  Doesn't [get|put]_cpu_ptr()
> > handle the preempt_disable() for us? 
> 
> It does.
> 
> > Is it not sufficient to rely on that?
> 
> It is.
> 
> > Dave's comment seems to be the opposite where we need to eliminate preempt
> > disable before calling write_pkrs().
> > 
> > FWIW I think I'm mistaken in my response to Dave regarding the
> > preempt_disable() in pks_update_protection().
> 
> Dave's concern is that we're calling with with preemption already
> disabled so disabling it again is superfluous.

Ok, thanks, and after getting my head straight I think I agree with him, and
you.

Thanks I've reworked the code to removed the superfluous calls.  Sorry about
being so dense...  :-D

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
