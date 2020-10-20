Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329FC293E52
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Oct 2020 16:10:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 031A815D8EF49;
	Tue, 20 Oct 2020 07:10:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 044F3159AD627
	for <linux-nvdimm@lists.01.org>; Tue, 20 Oct 2020 07:10:31 -0700 (PDT)
IronPort-SDR: cHJDrFYdzehyINbSYmCuJGkQ87YX2P92RsA0H9wEe/Mw2DhqJKpN4Tl0cszbnUtqCzFwYYQk+j
 jGtFwQX7Yo1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="154996676"
X-IronPort-AV: E=Sophos;i="5.77,397,1596524400";
   d="scan'208";a="154996676"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 07:10:30 -0700
IronPort-SDR: 5xB2GYyzejmXwfcx8S0E0keerXvIVZmHeJ9k8p8SkKxbYpm+GEU2CaHzDyn4xNTNrYc7te8yIK
 wI4dOY831O1w==
X-IronPort-AV: E=Sophos;i="5.77,397,1596524400";
   d="scan'208";a="533074263"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 07:10:29 -0700
Date: Tue, 20 Oct 2020 07:10:29 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC V3 6/9] x86/entry: Pass irqentry_state_t by reference
Message-ID: <20201020141029.GE3713473@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-7-ira.weiny@intel.com>
 <20201016114510.GO2611@hirez.programming.kicks-ass.net>
 <87lfg6tjnq.fsf@nanos.tec.linutronix.de>
 <20201019053639.GA3713473@iweiny-DESK2.sc.intel.com>
 <87k0vma7ct.fsf@nanos.tec.linutronix.de>
 <20201019202647.GD3713473@iweiny-DESK2.sc.intel.com>
 <871rhtapir.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871rhtapir.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: PA6XHCSYSP7CB3MVQJYM5HRBSPWYRTKO
X-Message-ID-Hash: PA6XHCSYSP7CB3MVQJYM5HRBSPWYRTKO
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PA6XHCSYSP7CB3MVQJYM5HRBSPWYRTKO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 19, 2020 at 11:12:44PM +0200, Thomas Gleixner wrote:
> On Mon, Oct 19 2020 at 13:26, Ira Weiny wrote:
> > On Mon, Oct 19, 2020 at 11:32:50AM +0200, Thomas Gleixner wrote:
> > Sorry, let me clarify.  After this patch we have.
> >
> > typedef union irqentry_state {
> > 	bool	exit_rcu;
> > 	bool	lockdep;
> > } irqentry_state_t;
> >
> > Which reflects the mutual exclusion of the 2 variables.
> 
> Huch? From the patch I gave you:
> 
>  #ifndef irqentry_state
>  typedef struct irqentry_state {
>  	bool    exit_rcu;
> +       bool    lockdep;
>  } irqentry_state_t;
>  #endif
> 
> How is that a union?

I was proposing to make it a union.

> 
> > But then when the pkrs stuff is added the union changes back to a structure and
> > looks like this.
> 
> So you want:
> 
>   1) Move stuff to struct irqentry_state (my patch)
> 
>   2) Change it to a union and pass it as pointer at the same time

No, I would have made it a union in your patch.

Pass by reference would remain largely the same.

> 
>   3) Change it back to struct to add PKRS

Yes.  :-/

> 
> > Is that clear?
> 
> What's clear is that the above is nonsense. We can just do
> 
>  #ifndef irqentry_state
>  typedef struct irqentry_state {
>  	union {
>          	bool    exit_rcu;
>                 bool    lockdep;
>         };        
>  } irqentry_state_t;
>  #endif
> 
> right in the patch which I gave you. Because that actually makes sense.

Ok I'm very sorry.  I was thinking that having a struct containing nothing but
an anonymous union would be unacceptable as a stand alone item in your patch.
In my experience other maintainers would have rejected such a change and
would have asked; 'why not just make it a union'?

I'm very happy skipping the gymnastics on individual patches in favor of making
the whole series work out in the end.

Thank you for your help again.  :-)

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
