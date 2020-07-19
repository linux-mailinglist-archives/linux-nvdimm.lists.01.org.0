Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FC6224F3B
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 Jul 2020 06:41:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C21E122BCD9B;
	Sat, 18 Jul 2020 21:41:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 19FFA122A8107
	for <linux-nvdimm@lists.01.org>; Sat, 18 Jul 2020 21:41:36 -0700 (PDT)
IronPort-SDR: U6Mo95Ls587Z8gYmfMMkoC6ziEdxA22zaROC/CSK/0iGc2n30OzeStw17KHGh3tBkxi5kUz/ED
 0J0NykFZct/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9686"; a="234638966"
X-IronPort-AV: E=Sophos;i="5.75,369,1589266800";
   d="scan'208";a="234638966"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 21:41:36 -0700
IronPort-SDR: 0R5r0POrAHJZkIVzaYM5LvL14m/HsDRcbVdHTM0jGjiiFzLf4uCpR3LN64DWY7R6h6P5xz5WOU
 AavFLGXR8NLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,369,1589266800";
   d="scan'208";a="269852530"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2020 21:41:36 -0700
Date: Sat, 18 Jul 2020 21:41:36 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC V2 14/17] dax: Stray write protection for
 dax_direct_access()
Message-ID: <20200719044135.GB478573@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-15-ira.weiny@intel.com>
 <20200717092243.GD10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717092243.GD10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: MNR3HKEYODG6KZRMKDVFBSOIYWRXTTTK
X-Message-ID-Hash: MNR3HKEYODG6KZRMKDVFBSOIYWRXTTTK
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MNR3HKEYODG6KZRMKDVFBSOIYWRXTTTK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 11:22:43AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 12:20:53AM -0700, ira.weiny@intel.com wrote:
> 
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -30,12 +30,14 @@ static DEFINE_SPINLOCK(dax_host_lock);
> >  
> >  int dax_read_lock(void)
> >  {
> > +	dev_access_enable();
> >  	return srcu_read_lock(&dax_srcu);
> >  }
> >  EXPORT_SYMBOL_GPL(dax_read_lock);
> >  
> >  void dax_read_unlock(int id)
> >  {
> > +	dev_access_disable();
> >  	srcu_read_unlock(&dax_srcu, id);
> >  }
> >  EXPORT_SYMBOL_GPL(dax_read_unlock);
> 
> This is inconsistently ordered.

Thanks, good catch.

Fixed.
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
