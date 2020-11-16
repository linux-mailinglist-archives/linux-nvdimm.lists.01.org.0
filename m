Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2228D2B5022
	for <lists+linux-nvdimm@lfdr.de>; Mon, 16 Nov 2020 19:49:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 04313100EC1C7;
	Mon, 16 Nov 2020 10:49:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5AD11100EC1C5
	for <linux-nvdimm@lists.01.org>; Mon, 16 Nov 2020 10:49:21 -0800 (PST)
IronPort-SDR: ZzR/neQlRriFlZge0fOBqV4Sxz/SNlt7fdF6qPiR5PVmMnDiXICsRADUEpyXa1EbCfEKpgAdeQ
 x8MIjr+bZ+Dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="170900510"
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400";
   d="scan'208";a="170900510"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 10:49:18 -0800
IronPort-SDR: QM3K1Df9J/Wg+oJAcVfa83qY/TNr4BOrYcj8zI8YrrZ97jsEsonZ8J/uK1N6DUXothgxIsiUVW
 Pzs792lhR6LA==
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400";
   d="scan'208";a="533514829"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 10:49:17 -0800
Date: Mon, 16 Nov 2020 10:49:16 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3 05/10] x86/entry: Pass irqentry_state_t by reference
Message-ID: <20201116184916.GA722447@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
 <20201106232908.364581-6-ira.weiny@intel.com>
 <87mtzi8n0z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mtzi8n0z.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: TBRR2ENKBAC643MPL4K7GJLRQCH5JEA5
X-Message-ID-Hash: TBRR2ENKBAC643MPL4K7GJLRQCH5JEA5
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TBRR2ENKBAC643MPL4K7GJLRQCH5JEA5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Nov 15, 2020 at 07:58:52PM +0100, Thomas Gleixner wrote:
> Ira,
> 
> On Fri, Nov 06 2020 at 15:29, ira weiny wrote:
> 
> Subject prefix wants to 'entry:'. This changes generic code and the x86
> part is just required to fix the generic code change.

Sorry, yes that was carried incorrectly from earlier versions.

> 
> > Currently struct irqentry_state_t only contains a single bool value
> > which makes passing it by value is reasonable.  However, future patches
> > propose to add information to this struct, for example the PKRS
> > register/thread state.
> >
> > Adding information to irqentry_state_t makes passing by value less
> > efficient.  Therefore, change the entry/exit calls to pass irq_state by
> > reference.
> 
> The PKRS muck needs to add an u32 to that struct. So how is that a
> problem?

There are more fields to be added for the kmap/pmem support.  So this will be
needed eventually.  Even though it is not strictly necessary in the next patch.

> 
> The resulting struct still fits into 64bit which is by far more
> efficiently passed by value than by reference. So which problem are you
> solving here?

I'm getting ahead of myself a bit.  I will be adding more fields for the
kmap/pmem tracking.

Would you accept just a clean up for the variable names in this patch?  I could
then add the pass by reference when I add the new fields later.  Or would an
update to the commit message be ok to land this now?

Ira

> 
> Thanks
> 
>         tglx
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
