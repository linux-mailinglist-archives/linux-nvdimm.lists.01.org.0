Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 928F21DD360
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 May 2020 18:52:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8295D11678594;
	Thu, 21 May 2020 09:48:31 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2870611678592
	for <linux-nvdimm@lists.01.org>; Thu, 21 May 2020 09:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=2O1Tg2zoC7nFEvMcg7+Gz3j7SsEauO9Urp+9H16pJrI=; b=cElemK5/V2BTVGAUY1OEd8YFBE
	wVe6bTbyqcTfFhBPQQ94dhs6L3uc7xHKr8Igx9ZCou9LCI0vJh9N6RCzGgEoLHj+rzG0YS9JMF5RN
	zklJBrX9ZB4hF6F2rJohSt32DE+yMcR9Cm1RaLKpkTuxcrdlE/LJ0cwprM98cb5Cc0vduMNZi0lXm
	G/z99A6Y3PWh6LXL4n1j9xildH68k3fmlmrnMDS4wG+kAqJP/VY5oUqdfJkz7BxfMt41vSf5TIWgN
	tNLTiMZQFoxjC+QhplitUyFiUfy97zwb8hNeR1LD/O2pFR/ytUwC32Yxk5oF9isA0PBYzjJmy1JxE
	lpAGm3lQ==;
Received: from [2601:1c0:6280:3f0::19c2]
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jboQI-0003AV-At; Thu, 21 May 2020 16:51:59 +0000
To: LKML <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] nvdimm: fixes to maintainter-entry-profile
Message-ID: <103a0e71-28b5-e4c2-fdf2-80d2dd005b44@infradead.org>
Date: Thu, 21 May 2020 09:51:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Language: en-US
Message-ID-Hash: R7LOD3A5IZUC5GJMNGDKUC37JEUBPPTV
X-Message-ID-Hash: R7LOD3A5IZUC5GJMNGDKUC37JEUBPPTV
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jonathan Corbet <corbet@lwn.net>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R7LOD3A5IZUC5GJMNGDKUC37JEUBPPTV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Randy Dunlap <rdunlap@infradead.org>

Fix punctuation and wording in a few places.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: linux-nvdimm@lists.01.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/nvdimm/maintainer-entry-profile.rst |   14 ++++++------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- linux-next-20200521.orig/Documentation/nvdimm/maintainer-entry-profile.rst
+++ linux-next-20200521/Documentation/nvdimm/maintainer-entry-profile.rst
@@ -4,15 +4,15 @@ LIBNVDIMM Maintainer Entry Profile
 Overview
 --------
 The libnvdimm subsystem manages persistent memory across multiple
-architectures. The mailing list, is tracked by patchwork here:
+architectures. The mailing list is tracked by patchwork here:
 https://patchwork.kernel.org/project/linux-nvdimm/list/
 ...and that instance is configured to give feedback to submitters on
 patch acceptance and upstream merge. Patches are merged to either the
-'libnvdimm-fixes', or 'libnvdimm-for-next' branch. Those branches are
+'libnvdimm-fixes' or 'libnvdimm-for-next' branch. Those branches are
 available here:
 https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/
 
-In general patches can be submitted against the latest -rc, however if
+In general patches can be submitted against the latest -rc; however, if
 the incoming code change is dependent on other pending changes then the
 patch should be based on the libnvdimm-for-next branch. However, since
 persistent memory sits at the intersection of storage and memory there
@@ -35,12 +35,12 @@ getting the test environment set up.
 
 ACPI Device Specific Methods (_DSM)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-Before patches enabling for a new _DSM family will be considered it must
+Before patches enabling a new _DSM family will be considered, it must
 be assigned a format-interface-code from the NVDIMM Sub-team of the ACPI
 Specification Working Group. In general, the stance of the subsystem is
-to push back on the proliferation of NVDIMM command sets, do strongly
+to push back on the proliferation of NVDIMM command sets, so do strongly
 consider implementing support for an existing command set. See
-drivers/acpi/nfit/nfit.h for the set of support command sets.
+drivers/acpi/nfit/nfit.h for the set of supported command sets.
 
 
 Key Cycle Dates
@@ -48,7 +48,7 @@ Key Cycle Dates
 New submissions can be sent at any time, but if they intend to hit the
 next merge window they should be sent before -rc4, and ideally
 stabilized in the libnvdimm-for-next branch by -rc6. Of course if a
-patch set requires more than 2 weeks of review -rc4 is already too late
+patch set requires more than 2 weeks of review, -rc4 is already too late
 and some patches may require multiple development cycles to review.
 
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
