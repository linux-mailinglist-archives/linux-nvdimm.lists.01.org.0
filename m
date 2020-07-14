Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3346D21FDF7
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jul 2020 22:00:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 586B01167EB2C;
	Tue, 14 Jul 2020 13:00:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 08DC010FC4F48
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 13:00:41 -0700 (PDT)
IronPort-SDR: 4w8e55GJ3ifcE0zuLzHJlvSKya7beKAQS3bZe/zWPZRWj7LgiPfUIGmvpCTBVMnwCHWgQrByW7
 ABGgBUzByBQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="148161327"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800";
   d="scan'208";a="148161327"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 13:00:41 -0700
IronPort-SDR: 4MS2nxEKSwXjwkPrhbmJP1OzdSRAj8lQAiaaHjC1Noo6yhxlz0lTa5uR4dcxyj5kZWZTGL1LmE
 m/OZlhrKMlvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800";
   d="scan'208";a="299658353"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2020 13:00:40 -0700
Date: Tue, 14 Jul 2020 13:00:40 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 12/15] kmap: Add stray write protection for device
 pages
Message-ID: <20200714200040.GF3008823@iweiny-DESK2.sc.intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-13-ira.weiny@intel.com>
 <20200714084451.GQ10769@hirez.programming.kicks-ass.net>
 <20200714190615.GC3008823@iweiny-DESK2.sc.intel.com>
 <20200714192930.GH5523@worktop.programming.kicks-ass.net>
 <50d472d8-e4d9-dd35-f31f-268aa69c76e2@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50d472d8-e4d9-dd35-f31f-268aa69c76e2@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 23YWXZGUOPWXN37IIS7QYTM3DSWJMKC7
X-Message-ID-Hash: 23YWXZGUOPWXN37IIS7QYTM3DSWJMKC7
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/23YWXZGUOPWXN37IIS7QYTM3DSWJMKC7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 14, 2020 at 12:42:11PM -0700, Dave Hansen wrote:
> On 7/14/20 12:29 PM, Peter Zijlstra wrote:
> > On Tue, Jul 14, 2020 at 12:06:16PM -0700, Ira Weiny wrote:
> >> On Tue, Jul 14, 2020 at 10:44:51AM +0200, Peter Zijlstra wrote:
> >>> So, if I followed along correctly, you're proposing to do a WRMSR per
> >>> k{,un}map{_atomic}(), sounds like excellent performance all-round :-(
> >> Only to pages which have this additional protection, ie not DRAM.
> >>
> >> User mappings of this memory is not affected (would be covered by User PKeys if
> >> desired).  User mappings to persistent memory are the primary use case and the
> >> performant path.
> > Because performance to non-volatile memory doesn't matter? I think Dave
> > has a better answer here ...
> 
> So, these WRMSRs are less evil than normal.  They're architecturally
> non-serializing instructions, just like the others in the SDM WRMSR
> documentation:
> 
> 	Note that WRMSR to the IA32_TSC_DEADLINE MSR (MSR index 6E0H)
> 	and the X2APIC MSRs (MSR indices 802H to 83FH) are  not
> 	serializing.
> 
> This section of the SDM needs to be updated for the PKRS.  Also note
> that the PKRS WRMSR is similar in its ordering properties to WRPKRU:
> 
> 	WRPKRU will never execute speculatively. Memory accesses
> 	affected by PKRU register will not execute (even speculatively)
> 	until all prior executions of WRPKRU have completed execution
> 	and updated the PKRU register.
> 
> Which means we don't have to do silliness like LFENCE before WRMSR to
> get ordering *back*.  This is another tidbit that needs to get added to
> the SDM.  It should probably also get captured in the changelog.
> 
> But, either way, this *will* make accessing PMEM more expensive from the
> kernel.  No escaping that.  But, we've also got customers saying they
> won't deploy PMEM until we mitigate this stray write issue.  Those folks
> are quite willing to pay the increased in-kernel cost for increased
> protection from stray kernel writes.  Intel is also quite motivated
> because we really like increasing the number of PMEM deployments. :)
> 
> Ira, can you make sure this all gets pulled into the changelogs somewhere?

Yes of course.  Thanks for writing that up.

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
