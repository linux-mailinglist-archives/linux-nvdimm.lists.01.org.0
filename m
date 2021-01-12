Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EB32F2B56
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 10:34:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A0CD6100EBB75;
	Tue, 12 Jan 2021 01:34:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 16149100EBB73
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 01:34:37 -0800 (PST)
IronPort-SDR: UF/hwM09XWjYlvw01V5b9WJHbOZubYwJCfoW4Z9YdhI+EXe8jppPBuXFvJczKtHll9cmDbfSX/
 uoT7CUr30+sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="174503023"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400";
   d="scan'208";a="174503023"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 01:34:37 -0800
IronPort-SDR: B4o+/ciPzlr45jWPFCMxT/2CPpQmmQQCCI4RCNc6hkk4ShdXdoYjAaUysR+2M53gnVdca6eSyz
 b9FQAcucoTBg==
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400";
   d="scan'208";a="464460801"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 01:34:36 -0800
Subject: [PATCH v2 0/5] mm: Fix pfn_to_online_page() with respect to
 ZONE_DEVICE
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org
Date: Tue, 12 Jan 2021 01:34:36 -0800
Message-ID: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: TGMOWZQB4DJ4EJGYH7IL5VVQP7KTPQKS
X-Message-ID-Hash: TGMOWZQB4DJ4EJGYH7IL5VVQP7KTPQKS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, Naoya Horiguchi <nao.horiguchi@gmail.com>, Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TGMOWZQB4DJ4EJGYH7IL5VVQP7KTPQKS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v1 [1]:
- Clarify the failing condition in patch 3 (Michal)
- Clarify how subsection collisions manifest in shipping systems
  (Michal)
- Use zone_idx() (Michal)
- Move section_taint_zone_device() conditions to
  move_pfn_range_to_zone() (Michal)
- Fix pfn_to_online_page() to account for pfn_valid() vs
  pfn_section_valid() confusion (David)

[1]: http://lore.kernel.org/r/160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com

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

---

Dan Williams (5):
      mm: Move pfn_to_online_page() out of line
      mm: Teach pfn_to_online_page() to consider subsection validity
      mm: Teach pfn_to_online_page() about ZONE_DEVICE section collisions
      mm: Fix page reference leak in soft_offline_page()
      libnvdimm/namespace: Fix visibility of namespace resource attribute


 drivers/nvdimm/namespace_devs.c |   10 +++---
 include/linux/memory_hotplug.h  |   17 +----------
 include/linux/mmzone.h          |   22 +++++++++-----
 mm/memory-failure.c             |   20 ++++++++++---
 mm/memory_hotplug.c             |   62 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 99 insertions(+), 32 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
