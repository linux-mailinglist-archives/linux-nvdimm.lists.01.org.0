Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8B02A6C11
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Nov 2020 18:46:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1BC731650AF5D;
	Wed,  4 Nov 2020 09:46:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B78191626E0E9
	for <linux-nvdimm@lists.01.org>; Wed,  4 Nov 2020 09:46:52 -0800 (PST)
IronPort-SDR: h8b6ZldEszCuy6twIJUkf23NCnokqyzZ1o/1oi1Y+tvHwieDRgsZWryfZpHVr34i78bR+elc4V
 5Z8gKq7MvtDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="169403352"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400";
   d="scan'208";a="169403352"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 09:46:46 -0800
IronPort-SDR: Q9Bmv6A8hLY7c8TvyszzEw9vj0W25YTLM3HEfYG4mwCufaGsYgJuK+k0r2131jolfBeCTxgYes
 GJ1Yb9QiFgjQ==
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400";
   d="scan'208";a="471304692"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 09:46:44 -0800
Date: Wed, 4 Nov 2020 09:46:44 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 00/10] PKS: Add Protection Keys Supervisor (PKS)
 support
Message-ID: <20201104174643.GC1531489@iweiny-DESK2.sc.intel.com>
References: <20201102205320.1458656-1-ira.weiny@intel.com>
 <871rhb8h73.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871rhb8h73.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: Q664PGZCMOAWZGU6STN7QR4XLYZ27URN
X-Message-ID-Hash: Q664PGZCMOAWZGU6STN7QR4XLYZ27URN
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q664PGZCMOAWZGU6STN7QR4XLYZ27URN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 03, 2020 at 12:36:16AM +0100, Thomas Gleixner wrote:
> On Mon, Nov 02 2020 at 12:53, ira weiny wrote:
> > Fenghua Yu (2):
> >   x86/pks: Enable Protection Keys Supervisor (PKS)
> >   x86/pks: Add PKS kernel API
> >
> > Ira Weiny (7):
> >   x86/pkeys: Create pkeys_common.h
> >   x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
> >   x86/pks: Preserve the PKRS MSR on context switch
> >   x86/entry: Pass irqentry_state_t by reference
> >   x86/entry: Preserve PKRS MSR across exceptions
> >   x86/fault: Report the PKRS state on fault
> >   x86/pks: Add PKS test code
> >
> > Thomas Gleixner (1):
> >   x86/entry: Move nmi entry/exit into common code
> 
> So the actual patch ordering is:
> 
>    x86/pkeys: Create pkeys_common.h
>    x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
>    x86/pks: Enable Protection Keys Supervisor (PKS)
>    x86/pks: Preserve the PKRS MSR on context switch
>    x86/pks: Add PKS kernel API
> 
>    x86/entry: Move nmi entry/exit into common code
>    x86/entry: Pass irqentry_state_t by reference
> 
>    x86/entry: Preserve PKRS MSR across exceptions
>    x86/fault: Report the PKRS state on fault
>    x86/pks: Add PKS test code
> 
> This is the wrong ordering, really.
> 
>      x86/entry: Move nmi entry/exit into common code
> 
> is a general cleanup and has absolutely nothing to do with PKRS.So this
> wants to go first.
> 

Sorry, yes this should be a pre-patch.

> Also:
> 
>     x86/entry: Move nmi entry/exit into common code
> [from other email]
>    >      x86/entry: Pass irqentry_state_t by reference
>    >      > 
>    >      >
> 
> is a prerequisite for the rest. So why is it in the middle of the
> series?

It is in the middle because passing by reference is not needed until additional
information is added to irqentry_state_t which is done immediately after this
patch by:

    x86/entry: Preserve PKRS MSR across exceptions

I debated squashing the 2 but it made review harder IMO.  But I thought keeping
them in order together made a lot of sense.

> 
> And then you enable all that muck _before_ it is usable:
> 

Strictly speaking you are correct, sorry.  I will reorder the series.

> 
> Bisectability is overrrated, right?

Agreed, bisectability is important.  I thought I had it covered but I was
wrong.

> 
> Once again: Read an understand Documentation/process/*
> 
> Aside of that using a spell checker is not optional.

Agreed.

In looking closer at the entry code I've found a couple of other instances I'll
add another precursor patch.

I've also found other errors with the series which I should have caught.  My
apologies I made some last minute changes which I should have checked more
thoroughly.

Thanks,
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
