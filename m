Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 631C62F2D25
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 11:48:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BFCB8100EB82C;
	Tue, 12 Jan 2021 02:48:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=osalvador@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 27E2B100EB829
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 02:48:26 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 77524AD18;
	Tue, 12 Jan 2021 10:48:25 +0000 (UTC)
Date: Tue, 12 Jan 2021 11:48:23 +0100
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 2/5] mm: Teach pfn_to_online_page() to consider
 subsection validity
Message-ID: <20210112104817.GA12956@linux>
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161044408728.1482714.9086710868634042303.stgit@dwillia2-desk3.amr.corp.intel.com>
 <0586c562-787c-4872-4132-18a49c3ffc8e@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0586c562-787c-4872-4132-18a49c3ffc8e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: NUGZCT7H5IZXOYHHP4YWTRTUCDKY4ALA
X-Message-ID-Hash: NUGZCT7H5IZXOYHHP4YWTRTUCDKY4ALA
X-MailFrom: osalvador@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NUGZCT7H5IZXOYHHP4YWTRTUCDKY4ALA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 12, 2021 at 10:53:17AM +0100, David Hildenbrand wrote:
> That's not sufficient for alternative implementations of pfn_valid().
> 
> You still need some kind of pfn_valid(pfn) for alternative versions of
> pfn_valid(). Consider arm64 memory holes in the memmap. See their
> current (yet to be fixed/reworked) pfn_valid() implementation.
> (pfn_valid_within() is implicitly active on arm64)
> 
> Actually, I think we should add something like the following, to make
> this clearer (pfn_valid_within() is confusing)
> 
> #ifdef CONFIG_HAVE_ARCH_PFN_VALID
> 	/* We might have to check for holes inside the memmap. */
> 	if (!pfn_valid())
> 		return NULL;
> #endif

I have to confess that I was a bit confused by pfn_valid_within + HOLES_IN_ZONES
+ HAVE_ARCH_PFN_VALID.

At first I thought that we should stick with pfn_valid_within, as we also
depend on HOLES_IN_ZONES, so it could be that

 if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID))
  ...

would to too much work, as if CONFIG_HOLES_IN_ZONES was not set but an arch
pfn_valid was provided, we would perform unedeed checks.
But on a closer look, CONFIG_HOLES_IN_ZONES is set by default on arm64, and
on ia64 when SPARSEMEM is set, so looks fine.


-- 
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
