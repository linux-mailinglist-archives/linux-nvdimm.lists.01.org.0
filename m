Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3DA29A549
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Oct 2020 08:11:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5B27A15129240;
	Tue, 27 Oct 2020 00:11:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 90B3D1512923E
	for <linux-nvdimm@lists.01.org>; Tue, 27 Oct 2020 00:11:22 -0700 (PDT)
IronPort-SDR: fG+FP8Gw6IZhhL/LyLWmUMdmTmO97qKNmDIYd1+7VYfS3uFSq82LtZdTn+sbpHKbUTFBq3VGKB
 ztvTI3jyOtMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="252736635"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400";
   d="scan'208";a="252736635"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 00:11:21 -0700
IronPort-SDR: yxpbvNXqR2ZH8VELzLKdveHPiLfaOg4FP6eotaVuipb+Li1gAU22E4WQmw0d7T2iCHSawR5QAw
 LXDe2LDQzbVA==
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400";
   d="scan'208";a="535680174"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 00:11:15 -0700
Date: Tue, 27 Oct 2020 00:11:14 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 07/10] x86/entry: Pass irqentry_state_t by reference
Message-ID: <20201027071114.GN534324@iweiny-DESK2.sc.intel.com>
References: <20201022222701.887660-1-ira.weiny@intel.com>
 <20201022222701.887660-8-ira.weiny@intel.com>
 <87y2jw4ne6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87y2jw4ne6.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: OT4SHTXZJQ6FQH27ENZYRVZ34T5MWYJF
X-Message-ID-Hash: OT4SHTXZJQ6FQH27ENZYRVZ34T5MWYJF
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OT4SHTXZJQ6FQH27ENZYRVZ34T5MWYJF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 23, 2020 at 11:56:33PM +0200, Thomas Gleixner wrote:
> On Thu, Oct 22 2020 at 15:26, ira weiny wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > In preparation for adding PKS information to struct irqentry_state_t
> > change all call sites and usages to pass the struct by reference
> > instead of by value.
> 
> This still does not explain WHY you need to do that. 'Preparation' is a
> pretty useless information.
> 
> What is the actual reason for this? Just because PKS information feels
> better that way?
> 
> Also what is PKS information? Changelogs have to make sense on their own
> and not only in the context of a larger series of changes.

I've reworded this to explain the addition of new members which would make
passing by value less efficient with additional structure changes being added
later in the series.

> 
> > While we are editing the call sites it is a good time to standardize on
> > the name 'irq_state'.
> 
>   While at it change all usage sites to consistently use the variable
>   name 'irq_state'.
> 
> Or something like that. See Documentation/process/...

Sorry, bad habit.

Fixed.

Thanks,
Ira

> 
> Thanks,
> 
>         tglx
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
