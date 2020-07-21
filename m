Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B24FB2287E3
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jul 2020 20:01:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC7B411BB489A;
	Tue, 21 Jul 2020 11:01:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E7B8F11BB489A
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jul 2020 11:01:40 -0700 (PDT)
IronPort-SDR: xO5/kz5Sb9zBFBlwiGfbFb535D/77t9TXGpATh/9AOjXqhlG7bKyN9zbxKf5xbYXs0qgaacf1I
 0K2+imRvUlgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="147699083"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800";
   d="scan'208";a="147699083"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 11:01:39 -0700
IronPort-SDR: qe5k1fK528+7itSbwwwS6IKZcJvdlZH1lFT8UQ253GQI2FZOjz37hTraZvX/V9KC4se8G7enQF
 XJPuNvtJfimA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800";
   d="scan'208";a="362445458"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2020 11:01:35 -0700
Date: Tue, 21 Jul 2020 11:01:34 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200721180134.GB643353@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
 <20200717093041.GF10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717093041.GF10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: UTT4KESC5DUECEV6VM4VVKHU3X2T73II
X-Message-ID-Hash: UTT4KESC5DUECEV6VM4VVKHU3X2T73II
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UTT4KESC5DUECEV6VM4VVKHU3X2T73II/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 11:30:41AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 12:20:56AM -0700, ira.weiny@intel.com wrote:
> > +static void noinstr idt_save_pkrs(idtentry_state_t state)
> 
> noinstr goes in the same place you would normally put inline, that's
> before the return type, not after it.
>

Sorry about that.  But that does not look to be consistent.

10:57:35 > git grep 'noinstr' arch/x86/entry/common.c
...
arch/x86/entry/common.c:idtentry_state_t noinstr idtentry_enter(struct pt_regs *regs)
arch/x86/entry/common.c:void noinstr idtentry_exit(struct pt_regs *regs, idtentry_state_t state)
arch/x86/entry/common.c:void noinstr idtentry_enter_user(struct pt_regs *regs)
arch/x86/entry/common.c:void noinstr idtentry_exit_user(struct pt_regs *regs)
...

Are the above 'wrong'?  Is it worth me sending a patch?

I've changed my code,
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
