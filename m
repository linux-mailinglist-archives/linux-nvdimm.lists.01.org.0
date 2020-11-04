Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 773762A70C5
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Nov 2020 23:46:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 92B85163498A9;
	Wed,  4 Nov 2020 14:45:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E1386163498A8
	for <linux-nvdimm@lists.01.org>; Wed,  4 Nov 2020 14:45:55 -0800 (PST)
IronPort-SDR: M28zuCMxkzh2VRfWb+kB8nks/Lv8RNne8izPiilUjrUKyod9mvUCe0PFGLUnmRnBfZISATab+m
 XrSewH2ssQoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="187165106"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400";
   d="scan'208";a="187165106"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 14:45:55 -0800
IronPort-SDR: Yu6Av8YfU+hmZkASLaufD19grQq9zs+wMzuJdOarI6DsD7ekyU5JCuR4WDdbdtEa4Ih697xK7O
 BUokPLMnwCjg==
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400";
   d="scan'208";a="539110386"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 14:45:54 -0800
Date: Wed, 4 Nov 2020 14:45:54 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 00/10] PKS: Add Protection Keys Supervisor (PKS)
 support
Message-ID: <20201104224554.GE1531489@iweiny-DESK2.sc.intel.com>
References: <20201102205320.1458656-1-ira.weiny@intel.com>
 <871rhb8h73.fsf@nanos.tec.linutronix.de>
 <20201104174643.GC1531489@iweiny-DESK2.sc.intel.com>
 <87k0v0lr4r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k0v0lr4r.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: X46MV6A65XNFSFL5RIAFZS7W5YS7UG37
X-Message-ID-Hash: X46MV6A65XNFSFL5RIAFZS7W5YS7UG37
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X46MV6A65XNFSFL5RIAFZS7W5YS7UG37/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 04, 2020 at 11:00:04PM +0100, Thomas Gleixner wrote:
> On Wed, Nov 04 2020 at 09:46, Ira Weiny wrote:
> > On Tue, Nov 03, 2020 at 12:36:16AM +0100, Thomas Gleixner wrote:
> >> This is the wrong ordering, really.
> >> 
> >>      x86/entry: Move nmi entry/exit into common code
> >> 
> >> is a general cleanup and has absolutely nothing to do with PKRS.So this
> >> wants to go first.
> >
> > Sorry, yes this should be a pre-patch.
> 
> I picked it out of the series and applied it to tip core/entry as I have
> other stuff coming up in that area. 

Thanks!  I'll rebase to that tree.

I assume you fixed the spelling error?  Sorry about that.

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
