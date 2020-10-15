Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA72528E993
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Oct 2020 03:00:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B33115989D27;
	Wed, 14 Oct 2020 18:00:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7515B15943AEA
	for <linux-nvdimm@lists.01.org>; Wed, 14 Oct 2020 18:00:34 -0700 (PDT)
IronPort-SDR: NkL1nBy0vdhiacdauCfIg+OSDr0Ny5UQuBZz4JdqXVLBicFdx67r3wdYLQeM5Go+wcjU2888VF
 5GOuZVvQM1Lw==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="230411664"
X-IronPort-AV: E=Sophos;i="5.77,376,1596524400";
   d="scan'208";a="230411664"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 18:00:33 -0700
IronPort-SDR: KS3Q2MPMmR4hzA6BX3wFA5W4ZTgE4BVgWBtN9d6K0JraXbAetqre2n+FMuEAQ3xYV6F7MwO/RB
 ken2QsQHin7A==
X-IronPort-AV: E=Sophos;i="5.77,376,1596524400";
   d="scan'208";a="531053664"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 18:00:33 -0700
Subject: [PATCH 0/2] device-dax subdivision v5 to v6 fixups
From: Dan Williams <dan.j.williams@intel.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2020 17:42:04 -0700
Message-ID: <160272252400.3136502.13635752844548960833.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: CHPSDMM7PA5R3IPG35PIOUFVKMOQYTH4
X-Message-ID-Hash: CHPSDMM7PA5R3IPG35PIOUFVKMOQYTH4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Brice Goglin <Brice.Goglin@inria.fr>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Jia He <justin.he@arm.com>, akpm@linux-foundation.org, Dave Hansen <dave.hansen@linux.intel.com>, Juergen Gross <jgross@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Joao Martins <joao.m.martins@oracle.com>, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CHPSDMM7PA5R3IPG35PIOUFVKMOQYTH4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

The v5 series of the device-dax-subdivision series landed upstream which
missed some of the late breaking fixups in v6 [1]. The Xen one is
cosmetic, the kmem one is a functional problem. I will handle the kmem
in a device-dax follow-on pull request post-rc1. The Xen one can go
through the Xen tree at its own pace.

My thanks to Andrew for wrangling the thrash up to v5, and my apologies
to Andrew et al for not highlighting this gap sooner.

[1]: http://lore.kernel.org/r/160196728453.2166475.12832711415715687418.stgit@dwillia2-desk3.amr.corp.intel.com

---

Dan Williams (2):
      device-dax/kmem: Fix resource release
      xen/unpopulated-alloc: Consolidate pgmap manipulation


 drivers/dax/kmem.c              |   48 ++++++++++++++++++++++++++++-----------
 drivers/xen/unpopulated-alloc.c |   14 ++++++-----
 2 files changed, 41 insertions(+), 21 deletions(-)

base-commit: 4da9af0014b51c8b015ed8c622440ef28912efe6
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
