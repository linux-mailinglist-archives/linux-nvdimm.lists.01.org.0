Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8664128EC02
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Oct 2020 06:18:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CAF7515765DEC;
	Wed, 14 Oct 2020 21:18:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CFBF615765DEA
	for <linux-nvdimm@lists.01.org>; Wed, 14 Oct 2020 21:18:09 -0700 (PDT)
IronPort-SDR: WzY5SREa86YgxK4OOCSdYbqjfFa/mDzSRAXXvG1G/jnYsL0OGwsYckL/E9mZro3qizdpuDIIl0
 FBm4HXQCBe0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="162791950"
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400";
   d="scan'208";a="162791950"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 21:18:09 -0700
IronPort-SDR: v7spRh8MuASRkdNNr0ZHoNczdFMxX2I1ak7xY7gos/SeU28ARiQ6EMmXTm9vqvcAGZ60oslnd3
 9cmkDq9PvUXw==
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400";
   d="scan'208";a="531100241"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 21:18:08 -0700
Date: Wed, 14 Oct 2020 21:18:08 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH RFC V3 7/9] x86/entry: Preserve PKRS MSR across exceptions
Message-ID: <20201015041808.GS2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-8-ira.weiny@intel.com>
 <6006a4c8-32bd-04ca-95cc-b2736a5cef72@intel.com>
 <20201015034645.GQ2046448@iweiny-DESK2.sc.intel.com>
 <a3cb045e-3d27-eaca-c78d-d30d9a045e02@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a3cb045e-3d27-eaca-c78d-d30d9a045e02@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: VZJHYVWWPZAIQMLKYA72Q7FSKTP6DERG
X-Message-ID-Hash: VZJHYVWWPZAIQMLKYA72Q7FSKTP6DERG
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VZJHYVWWPZAIQMLKYA72Q7FSKTP6DERG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 14, 2020 at 09:06:44PM -0700, Dave Hansen wrote:
> On 10/14/20 8:46 PM, Ira Weiny wrote:
> > On Tue, Oct 13, 2020 at 11:52:32AM -0700, Dave Hansen wrote:
> >> On 10/9/20 12:42 PM, ira.weiny@intel.com wrote:
> >>> @@ -341,6 +341,9 @@ noinstr void irqentry_enter(struct pt_regs *regs, irqentry_state_t *state)
> >>>  	/* Use the combo lockdep/tracing function */
> >>>  	trace_hardirqs_off();
> >>>  	instrumentation_end();
> >>> +
> >>> +done:
> >>> +	irq_save_pkrs(state);
> >>>  }
> >> One nit: This saves *and* sets PKRS.  It's not obvious from the call
> >> here that PKRS is altered at this site.  Seems like there could be a
> >> better name.
> >>
> >> Even if we did:
> >>
> >> 	irq_save_set_pkrs(state, INIT_VAL);
> >>
> >> It would probably compile down to the same thing, but be *really*
> >> obvious what's going on.
> > I suppose that is true.  But I think it is odd having a parameter which is the
> > same for every call site.
> 
> Well, it depends on what you optimize for.  I'm trying to optimize for
> the code being understood quickly the first time someone reads it.  To
> me, that's more important than minimizing the number of function
> parameters (which are essentially free).
>

Agreed.  Sorry I was not trying to be confrontational.  There is just enough
other things which are going to take me time to get right I need to focus on
them...  :-D

Sorry,
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
