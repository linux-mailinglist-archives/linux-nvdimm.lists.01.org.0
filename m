Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599EA22B3F0
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 Jul 2020 18:52:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A30E112517F7A;
	Thu, 23 Jul 2020 09:52:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=fenghua.yu@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C75B212504360
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 09:52:06 -0700 (PDT)
IronPort-SDR: 22NrzGMgeiLRF+qWbG2tZZ/eOMN68A9UNc4heYn6AYQPI/EH2XzOHtdK1qs9nGFavkVKYSaqDa
 208lwChCKwcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="138070438"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800";
   d="scan'208";a="138070438"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 09:52:06 -0700
IronPort-SDR: mAmrUitOfiAg5CS/tsz6tCarSLviqTRzcFRleZL+GG/v8x+OPGmFN8FiKB+3GU/TO5dndgquAI
 CuGW8cd61NtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800";
   d="scan'208";a="311100155"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2020 09:52:05 -0700
Date: Thu, 23 Jul 2020 09:52:04 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200723165204.GB77434@romley-ivt3.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
 <CALCETrVe1i5JdyzD_BcctxQJn+ZE3T38EFPgjxN1F577M36g+w@mail.gmail.com>
 <20200723161818.GA77434@romley-ivt3.sc.intel.com>
 <1cdb358b-861a-5f74-8cd0-84ee5265035c@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1cdb358b-861a-5f74-8cd0-84ee5265035c@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Message-ID-Hash: 76DQPOC5XQA7L2XEB3ZDIWVB6W5RC3RV
X-Message-ID-Hash: 76DQPOC5XQA7L2XEB3ZDIWVB6W5RC3RV
X-MailFrom: fenghua.yu@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/76DQPOC5XQA7L2XEB3ZDIWVB6W5RC3RV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, Dave,

On Thu, Jul 23, 2020 at 09:23:13AM -0700, Dave Hansen wrote:
> On 7/23/20 9:18 AM, Fenghua Yu wrote:
> > The PKRS MSR has been preserved in thread_info during kernel entry. We
> > don't need to preserve it in another place (i.e. idtentry_state).
> 
> I'm missing how the PKRS MSR gets preserved in thread_info.  Could you
> explain the mechanism by which this happens and point to the code
> implementing it, please?

[Sorry, my mistake: I mean "thread_struct" instead of "thread_info".
Hopefully the typo doesn't change the essential part in my last email.]

The "saved_pkrs" is defined in thread_struct and context switched in
patch 04/17:
https://lore.kernel.org/lkml/20200717072056.73134-5-ira.weiny@intel.com/

Because there is no XSAVE support the PKRS MSR, we preserve it in
"saved_pkrs" in thread_struct. It's initialized as 0 (init state, no
protection key) in fork() or exec(). It's updated to a right protection
value when a driver calls the updating API. The PKRS MSR is context
switched by "saved_pkrs" when switching to a task (unless optimized if the
cached MSR is the same as the saved one).

Thanks.

-Fenghua
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
