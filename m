Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 929722DDDA3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 05:10:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BAAF7100EB327;
	Thu, 17 Dec 2020 20:10:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 01354100EB827
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 20:10:13 -0800 (PST)
IronPort-SDR: tNRyKursKDc9HXAdzwSUPa70Q1nKfsgrYQUzdUMSXrgZNSX1Vvev88yUKPGF5vNQBt5QHooPNd
 V4ndSTRyf+Ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="193782739"
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400";
   d="scan'208";a="193782739"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 20:10:13 -0800
IronPort-SDR: A8u2UZH5a9Ii6dfZcq04bAX2OwOham5rhmAyowRSRBJduIiiyn3HqDkqgXP4Y95DSUsg50PLbn
 q5u/5uck4oEw==
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400";
   d="scan'208";a="338679461"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 20:10:12 -0800
Date: Thu, 17 Dec 2020 20:10:12 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [NEEDS-REVIEW] [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR
 on context switch
Message-ID: <20201218041012.GC2506510@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
 <20201106232908.364581-5-ira.weiny@intel.com>
 <ff685068-6821-ca35-7fa8-732a66cbf266@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ff685068-6821-ca35-7fa8-732a66cbf266@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 5Z47PXBTM3JIXZ42NK6PDPB6IJZXJBNP
X-Message-ID-Hash: 5Z47PXBTM3JIXZ42NK6PDPB6IJZXJBNP
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5Z47PXBTM3JIXZ42NK6PDPB6IJZXJBNP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 17, 2020 at 12:41:50PM -0800, Dave Hansen wrote:
> On 11/6/20 3:29 PM, ira.weiny@intel.com wrote:
> >  void disable_TSC(void)
> > @@ -644,6 +668,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
> >  
> >  	if ((tifp ^ tifn) & _TIF_SLD)
> >  		switch_to_sld(tifn);
> > +
> > +	pks_sched_in();
> >  }
> 
> Does the selftest for this ever actually schedule()?

At this point I'm not sure.  This code has been in since the beginning.  So its
seen a lot of soak time.

> 
> I see it talking about context switching, but I don't immediately see
> how it would.

We were trying to force parent and child to run on the same CPU.  I suspect
something is wrong in the timing of that test.

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
