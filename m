Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC797225AF1
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jul 2020 11:14:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3D8A4123757CB;
	Mon, 20 Jul 2020 02:14:17 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 97E54123757C8
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 02:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5tslci/TZCCd1TbRC9GV4KEBZulaQ3nrLO1vcSVnALA=; b=yeDA/fpzF7U+Gx0dfEISR0uEJP
	34s0go7buhwmKs+qfROqytezUisi+mIVzYOopOlh7jd8hd/A8NmwGJQP62l4fkskjxzgP/3Zr1kP3
	fpHrpD6jAStfySdu8sisLTHK+VawELwg5EH1SUKP6Xf0R4hV+bVaGJZcMkTltk5GAq1RCzgJtgDXj
	6p7px9Fk/TED3Wn0qRz89MByrHWQJ34kMcQyS6gnFlqMxVmyFWWBYZjWrGeyUinopPED96tPKbEX5
	haGFO6Ts4sH3KLy4rA0v0lyercBCENxzUu284Q6fY9ISQ0j0a5yKEvG4vJQ1vA9MDW5QjZaiEXI61
	hHxtIL+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxRrz-0005aJ-SK; Mon, 20 Jul 2020 09:14:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 223193010C8;
	Mon, 20 Jul 2020 11:13:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 00B3A23646C00; Mon, 20 Jul 2020 11:13:56 +0200 (CEST)
Date: Mon, 20 Jul 2020 11:13:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH RFC V2 02/17] x86/fpu: Refactor
 arch_set_user_pkey_access() for PKS support
Message-ID: <20200720091356.GL10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-3-ira.weiny@intel.com>
 <20200717085442.GX10769@hirez.programming.kicks-ass.net>
 <1f9586df-cabb-c743-1eeb-f44c73459fb5@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1f9586df-cabb-c743-1eeb-f44c73459fb5@intel.com>
Message-ID-Hash: UPT2R4GBMWTQM6MQIR2CDUQOLU5F5PTJ
X-Message-ID-Hash: UPT2R4GBMWTQM6MQIR2CDUQOLU5F5PTJ
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UPT2R4GBMWTQM6MQIR2CDUQOLU5F5PTJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 03:36:12PM -0700, Dave Hansen wrote:
> On 7/17/20 1:54 AM, Peter Zijlstra wrote:
> > This is unbelievable junk...
> 
> Ouch!
> 
> This is from the original user pkeys implementation.

The thing I fell over most was new in this patch; the naming of that
function. It doesn't 'get' anything, nor does it allocate anything, so
'new' is out the window too.

> > How about something like:
> > 
> > u32 update_pkey_reg(u32 pk_reg, int pkey, unsigned int flags)
> > {
> > 	int pkey_shift = pkey * PKR_BITS_PER_PKEY;
> > 
> > 	pk_reg &= ~(((1 << PKR_BITS_PER_PKEY) - 1) << pkey_shift);
> > 
> > 	if (flags & PKEY_DISABLE_ACCESS)
> > 		pk_reg |= PKR_AD_BIT << pkey_shift;
> > 	if (flags & PKEY_DISABLE_WRITE)
> > 		pk_reg |= PKR_WD_BIT << pkey_shift;
> > 
> > 	return pk_reg;
> > }
> > 
> > Then we at least have a little clue wtf the thing does.. Yes I started
> > with a rename and then got annoyed at the implementation too.
> 
> That's fine, if some comments get added.

I'm not sure what you would want commented; the code is trivial.

> It looks correct to me but
> probably compiles down to pretty much the same thing as what was there.
>  FWIW, I prefer the explicit masking off of two bit values to implicit
> masking off with a mask generated from PKR_BITS_PER_PKEY.  It's
> certainly more compact, but I usually don't fret over the lines of code.

This way you're sure there are no bits missed. Both the shift and mask
use the same value.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
