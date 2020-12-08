Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B682D30DC
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 18:22:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AAF65100EB824;
	Tue,  8 Dec 2020 09:22:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C0ABF100EBB99
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 09:22:52 -0800 (PST)
IronPort-SDR: wRfhfYjtHxBiXo+CJ0/yb3PXEJz2uitiheNC0V2MilfPZJogJZlVrXWCYF5glJnPG+zP6tPvl9
 xaKH9VnIUBvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174079649"
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400";
   d="scan'208";a="174079649"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 09:22:51 -0800
IronPort-SDR: 4tMCT8vGceU6karZIafhKmMgXOvVyLb2LYUpW4elgkPoxwOmo0p3IPPIPJd/KFUP4xOgwuEKcz
 tsRuwAPBPm3Q==
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400";
   d="scan'208";a="363733327"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 09:22:51 -0800
Date: Tue, 8 Dec 2020 09:22:51 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3 00/10] PKS: Add Protection Keys Supervisor (PKS)
 support V3
Message-ID: <20201208172250.GA2032506@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
 <20201207221431.GL1563847@iweiny-DESK2.sc.intel.com>
 <87v9dc2sxh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87v9dc2sxh.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: IKRZ2RDB6GE4FHLH5OFCQ4RFHK2TW4WS
X-Message-ID-Hash: IKRZ2RDB6GE4FHLH5OFCQ4RFHK2TW4WS
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IKRZ2RDB6GE4FHLH5OFCQ4RFHK2TW4WS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 08, 2020 at 04:55:54PM +0100, Thomas Gleixner wrote:
> Ira,
> 
> On Mon, Dec 07 2020 at 14:14, Ira Weiny wrote:
> > Is there any chance of this landing before the kmap stuff gets sorted out?
> 
> I have marked this as needs an update because the change log of 5/10
> sucks. https://lore.kernel.org/r/87lff1xcmv.fsf@nanos.tec.linutronix.de
> 
> > It would be nice to have this in 5.11 to build off of.
> 
> It would be nice if people follow up on review request :)

I did, but just as an update to that patch.[1]  Sorry if this caused you to
miss the response.  It would have been better for me to ping you on that patch.
:-/

I was trying to avoid a whole new series just for that single commit message.
Is that generally ok?

Is that commit message still lacking?

Ira

[1] https://lore.kernel.org/linux-doc/20201124060956.1405768-1-ira.weiny@intel.com/
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
