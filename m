Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA3E2F4541
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 08:35:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D874E100EB32E;
	Tue, 12 Jan 2021 23:35:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 86103100EB32E
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 23:35:26 -0800 (PST)
IronPort-SDR: QPm/YASTBj/DCAku5OvPvvR+butt89Un0YGg+oSUKR3SJy2L0iHc4WuJ/hTI6ZSX0/6eCiX2oo
 I4lS4u06jNoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="165252659"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="165252659"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:35:19 -0800
IronPort-SDR: R7U7SOlxIAask0dFOPSZ+iv/4TSvK3885rmAPXftCa0I6o/KodFyfMs5MpYz6914ji5DT++mEY
 igedmqs3aGCA==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="400456436"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:35:15 -0800
Subject: [PATCH v3 0/6] mm: Fix pfn_to_online_page() with respect to
 ZONE_DEVICE
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org
Date: Tue, 12 Jan 2021 23:35:15 -0800
Message-ID: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: CB3RB57RNBCODVNP2S64RTMCC7RR6IGB
X-Message-ID-Hash: CB3RB57RNBCODVNP2S64RTMCC7RR6IGB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, Naoya Horiguchi <nao.horiguchi@gmail.com>, Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>, Andrew Morton <akpm@linux-foundation.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CB3RB57RNBCODVNP2S64RTMCC7RR6IGB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v2 [1]:
- Collect some reviewed-by's from David and Oscar

- Rework subsection validity to include pfn_valid() gated by
  CONFIG_HAVE_ARCH_PFN_VALID (David, Oscar)

- Introduce pgmap_pfn_valid() to validate metadata vs data in a pgmap (David)

! Kill put_ref_page(): the extra "if (ref_page) put_page(ref_page)" still
  feels more cluttered than adding a tiny helper. (Oscar)

[1]: http://lore.kernel.org/r/161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com

---

Michal reminds that the discussion about how to ensure pfn-walkers do
not get confused by ZONE_DEVICE pages never resolved. A pfn-walker that
uses pfn_to_online_page() may inadvertently translate a pfn as online
and in the page allocator, when it is offline managed by a ZONE_DEVICE
mapping (details in Patch 3: ("mm: Teach pfn_to_online_page() about
ZONE_DEVICE section collisions")).

The 2 proposals under consideration are teach pfn_to_online_page() to be
precise in the presence of mixed-zone sections, or teach the memory-add
code to drop the System RAM associated with ZONE_DEVICE collisions. In
order to not regress memory capacity by a few 10s to 100s of MiB the
approach taken in this set is to add precision to pfn_to_online_page().

In the course of validating pfn_to_online_page() a couple other fixes
fell out:

1/ soft_offline_page() fails to drop the reference taken in the
   madvise(..., MADV_SOFT_OFFLINE) case.

2/ The libnvdimm sysfs attribute visibility code was failing to publish
   the resource base for memmap=ss!nn defined namespaces. This is needed
   for the regression test for soft_offline_page().

3/ memory_failure() uses get_dev_pagemap() to lookup ZONE_DEVICE pages,
   however that mapping may contain data pages and metadata raw pfns.
   Introduce pgmap_pfn_valid() to delineate the 2 types and fail the
   handling of raw metadata pfns.

---

Dan Williams (6):
      mm: Move pfn_to_online_page() out of line
      mm: Teach pfn_to_online_page() to consider subsection validity
      mm: Teach pfn_to_online_page() about ZONE_DEVICE section collisions
      mm: Fix page reference leak in soft_offline_page()
      mm: Fix memory_failure() handling of dax-namespace metadata
      libnvdimm/namespace: Fix visibility of namespace resource attribute


 drivers/nvdimm/namespace_devs.c |   10 +++---
 include/linux/memory_hotplug.h  |   17 +--------
 include/linux/memremap.h        |    6 +++
 include/linux/mmzone.h          |   22 ++++++++----
 mm/memory-failure.c             |   26 ++++++++++++--
 mm/memory_hotplug.c             |   70 +++++++++++++++++++++++++++++++++++++++
 mm/memremap.c                   |   15 ++++++++
 7 files changed, 134 insertions(+), 32 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
