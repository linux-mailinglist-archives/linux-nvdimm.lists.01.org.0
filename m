Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F7B123B6F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 18 Dec 2019 01:19:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B8B0710113626;
	Tue, 17 Dec 2019 16:22:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=sean.j.christopherson@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CF5C01011361D
	for <linux-nvdimm@lists.01.org>; Tue, 17 Dec 2019 16:22:20 -0800 (PST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 16:18:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600";
   d="scan'208";a="217971873"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga003.jf.intel.com with ESMTP; 17 Dec 2019 16:18:57 -0800
Date: Tue, 17 Dec 2019 16:18:57 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Barret Rhoden <brho@google.com>
Subject: Re: [PATCH v5 1/2] mm: make dev_pagemap_mapping_shift() externally
 visible
Message-ID: <20191218001857.GM11771@linux.intel.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-2-brho@google.com>
 <20191213174702.GB31552@linux.intel.com>
 <e004e742-f755-c22c-57bb-acfe30971c7d@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e004e742-f755-c22c-57bb-acfe30971c7d@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Message-ID-Hash: BSCOWHP5C3CC63AAYCSNRQ4S6MUBWDFY
X-Message-ID-Hash: BSCOWHP5C3CC63AAYCSNRQ4S6MUBWDFY
X-MailFrom: sean.j.christopherson@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BSCOWHP5C3CC63AAYCSNRQ4S6MUBWDFY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 16, 2019 at 12:59:53PM -0500, Barret Rhoden wrote:
> On 12/13/19 12:47 PM, Sean Christopherson wrote:
> >>+EXPORT_SYMBOL_GPL(dev_pagemap_mapping_shift);
> >
> >This is basically a rehash of lookup_address_in_pgd(), and doesn't provide
> >exactly what KVM needs.  E.g. KVM works with levels instead of shifts, and
> >it would be nice to provide the pte so that KVM can sanity check that the
> >pfn from this walk matches the pfn it plans on mapping.
> 
> One minor issue is that the levels for lookup_address_in_pgd() and for KVM
> differ in name, although not in value.  lookup uses PG_LEVEL_4K = 1.  KVM
> uses PT_PAGE_TABLE_LEVEL = 1.  The enums differ a little too: x86 has a name
> for a 512G page, etc.  It's all in arch/x86.
> 
> Does KVM-x86 need its own names for the levels?  If not, I could convert the
> PT_PAGE_TABLE_* stuff to PG_LEVEL_* stuff.

Not really.  I suspect the whole reason KVM has different enums is to
handle PSE/Mode-B paging, where PG_LEVEL_2M would be inaccurate, e.g.:

	if (PTTYPE == 32 && walker->level == PT_DIRECTORY_LEVEL && is_cpuid_PSE36())
		gfn += pse36_gfn_delta(pte);

That being said, I absolute loathe PT_PAGE_TABLE_LEVEL, I can never
remember that it means 4k pages.  I would be in favor of using the kernel's
enums with some KVM-specific abstraction of PG_LEVEL_2M, e.g.

/* KVM Hugepage definitions for x86 */
enum {
	PG_LEVEL_2M_OR_4M      = PG_LEVEL_2M,
	/* set max level to the biggest one */
	KVM_MAX_HUGEPAGE_LEVEL = PG_LEVEL_1G,
};

And ideally restrict usage of the ugly PG_LEVEL_2M_OR_4M to flows that can
actually encounter 4M pages, i.e. when walking guest page tables.  On the
host side, KVM always uses PAE or 64-bit paging.

Personally, I'd pursue that in a separate patch/series, it'll touch a
massive amount of code and will probably get bikeshedded a fair amount.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
