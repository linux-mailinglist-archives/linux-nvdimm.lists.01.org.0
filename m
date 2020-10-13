Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D8428D4D7
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Oct 2020 21:44:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 64733159591B0;
	Tue, 13 Oct 2020 12:44:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 28D5B159591A8
	for <linux-nvdimm@lists.01.org>; Tue, 13 Oct 2020 12:44:07 -0700 (PDT)
IronPort-SDR: EUVWb3Wf9kx7i4bWm5LpqiOPFA4xHb2fHz7e14cTVW2XExPTdwCzJyzNMZnFBWoBxs55R4CovG
 oNNdc3Jh7bog==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="145290847"
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400";
   d="scan'208";a="145290847"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 12:44:06 -0700
IronPort-SDR: FYowcW5TgJ16AeEVdPPfqP9JnqqAhtCUVoZalbg+Ng0NVMQ+PjkvJjQyjlNEqhvyQc+O17Jzhv
 jpaAnfNZjUOw==
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400";
   d="scan'208";a="530539601"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 12:44:05 -0700
Date: Tue, 13 Oct 2020 12:44:05 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH RFC V3 1/9] x86/pkeys: Create pkeys_common.h
Message-ID: <20201013194405.GG2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-2-ira.weiny@intel.com>
 <0305912d-891f-839a-e861-49f5fada62b1@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0305912d-891f-839a-e861-49f5fada62b1@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: FNZQGAHUDKGXR2JACVM6W7ANSEBEHA5J
X-Message-ID-Hash: FNZQGAHUDKGXR2JACVM6W7ANSEBEHA5J
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FNZQGAHUDKGXR2JACVM6W7ANSEBEHA5J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 13, 2020 at 10:46:16AM -0700, Dave Hansen wrote:
> On 10/9/20 12:42 PM, ira.weiny@intel.com wrote:
> > Protection Keys User (PKU) and Protection Keys Supervisor (PKS) work
> > in similar fashions and can share common defines.
> 
> Could we be a bit less abstract?  PKS and PKU each have:
> 1. A single control register
> 2. The same number of keys
> 3. The same number of bits in the register per key
> 4. Access and Write disable in the same bit locations
> 
> That means that we can share all the macros that synthesize and
> manipulate register values between the two features.

Sure.  Done.

> 
> > +++ b/arch/x86/include/asm/pkeys_common.h
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_X86_PKEYS_INTERNAL_H
> > +#define _ASM_X86_PKEYS_INTERNAL_H
> > +
> > +#define PKR_AD_BIT 0x1
> > +#define PKR_WD_BIT 0x2
> > +#define PKR_BITS_PER_PKEY 2
> > +
> > +#define PKR_AD_KEY(pkey)	(PKR_AD_BIT << ((pkey) * PKR_BITS_PER_PKEY))
> 
> Now that this has moved away from its use-site, it's a bit less
> self-documenting.  Let's add a comment:
> 
> /*
>  * Generate an Access-Disable mask for the given pkey.  Several of these
>  * can be OR'd together to generate pkey register values.
>  */

Fair enough. done.

> 
> Once that's in place, along with the updated changelog:
> 
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks,
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
