Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFB321FA85
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jul 2020 20:53:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1B738116733D7;
	Tue, 14 Jul 2020 11:53:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BBC95114342BB
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 11:53:24 -0700 (PDT)
IronPort-SDR: 2RJM3Mp9L/Nkq1w2S8BXK2wX3RtMqsWxtRor+b+8C8hXf4DryWDpXKqrTeEt7QQgvlNYr97iYx
 FbrCUPBjGe2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="129094384"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800";
   d="scan'208";a="129094384"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 11:53:23 -0700
IronPort-SDR: K8KPclbMvzgCpNFSFhz9Nn0YwCcdCbQhJi73NeRnxAdxCClsbyjKHY02fk6MDlf/UteP15gYg8
 6LDggwpzlYUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800";
   d="scan'208";a="307978346"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2020 11:53:23 -0700
Date: Tue, 14 Jul 2020 11:53:22 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 04/15] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20200714185322.GB3008823@iweiny-DESK2.sc.intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-5-ira.weiny@intel.com>
 <20200714082701.GO10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200714082701.GO10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: CSD3AFB2B2IEGNJYBNP6EGTWVGW5U3NF
X-Message-ID-Hash: CSD3AFB2B2IEGNJYBNP6EGTWVGW5U3NF
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CSD3AFB2B2IEGNJYBNP6EGTWVGW5U3NF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 14, 2020 at 10:27:01AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 14, 2020 at 12:02:09AM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The PKRS MSR is defined as a per-core register.  This isolates memory
> > access by CPU.  Unfortunately, the MSR is not preserved by XSAVE.
> > Therefore, We must preserve the protections for individual tasks even if
> > they are context switched out and placed on another cpu later.
> 
> This is a contradiction and utter trainwreck.

I don't understand where there is a contradiction?  Perhaps I should have said
the MSR is not XSAVE managed vs 'preserved'?

> We're not going to do more
> per-core MSRs and pretend they make sense per-task.

I don't understand how this does not make sense.  The PKRS register is
controlling the task's access to kernel memory and is designed to be restricted
to that task.  Put another way, this is similar to CR3 which ultimately
controls tasks memory access.  Per-process mm is inherent to memory access
control and is per-task.  So how is this any different?  Many MSRs are like
this.

I suppose an alternative might be to disallow a context switch while the PKRS
value is not the default but I don't see this being very desirable at all.

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
