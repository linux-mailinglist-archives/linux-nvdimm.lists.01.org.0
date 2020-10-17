Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BABC7290F87
	for <lists+linux-nvdimm@lfdr.de>; Sat, 17 Oct 2020 07:42:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A45A615CAD5F2;
	Fri, 16 Oct 2020 22:42:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 70C7115CAD5E6
	for <linux-nvdimm@lists.01.org>; Fri, 16 Oct 2020 22:42:17 -0700 (PDT)
IronPort-SDR: V/ZMmx4WwXu3A6QzFOzbja4YtNkDpMjr2QgqpbwmiBFZ/u1V9+wic6pFuoJ6vzj3ZiaA7OaJcO
 Pdp0q6WchVZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="184327518"
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400";
   d="scan'208";a="184327518"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 22:42:16 -0700
IronPort-SDR: bloDPZ1mHCCMDkSL4HTubqN5FZT0XoM6+FUXgp3YTonyMsQFc3Ur7Lotbw2ij0kO5hWgIJ5cfw
 HGUQxgmHfd2w==
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400";
   d="scan'208";a="522528942"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 22:42:16 -0700
Date: Fri, 16 Oct 2020 22:42:16 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC V3 5/9] x86/pks: Add PKS kernel API
Message-ID: <20201017054216.GB3702775@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-6-ira.weiny@intel.com>
 <20201016110747.GM2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201016110747.GM2611@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: AP6P47RQJWK5ZMMFDAHMELRUDS2JIDJK
X-Message-ID-Hash: AP6P47RQJWK5ZMMFDAHMELRUDS2JIDJK
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AP6P47RQJWK5ZMMFDAHMELRUDS2JIDJK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 16, 2020 at 01:07:47PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 09, 2020 at 12:42:54PM -0700, ira.weiny@intel.com wrote:
> > +static inline void pks_update_protection(int pkey, unsigned long protection)
> > +{
> > +	current->thread.saved_pkrs = update_pkey_val(current->thread.saved_pkrs,
> > +						     pkey, protection);
> > +	preempt_disable();
> > +	write_pkrs(current->thread.saved_pkrs);
> > +	preempt_enable();
> > +}
> 
> write_pkrs() already disables preemption itself. Wrapping it in yet
> another layer is useless.

I was thinking the update to saved_pkrs needed this protection as well and that
was to be included in the preemption disable.  But that too is incorrect.

I've removed this preemption disable.

Thanks,
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
