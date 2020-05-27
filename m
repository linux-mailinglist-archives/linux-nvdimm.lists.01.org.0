Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F0B1E348F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 May 2020 03:17:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 93A911173E9C7;
	Tue, 26 May 2020 18:13:13 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4C8B01173E9C6
	for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 18:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=zpMNP4CRwq3qJJZms/7x8Uur/00YnZ5BGSuGvOyqx+o=; b=UfYb+ZYwQarNICF4sxHwDW63ZY
	NhMXs2vxOENFfckJiditFF5tZcB5tt7dL2oJmNk2/btFFC5kPL1U9pxtElpCyeAWvLwcAgLwEQu8O
	raI/MRoki4omR54gvrHokSrHXgZvXSbZHGaXLcUBNt7PwM7SR6rHQLcu4qS+iI9nKmmI4Gm16Il7M
	cF28v/eJZl5jUP+rrVnP9KDz/fKMeD27xqIX1BSWWjjBxsLu+OFrXpbbXD1n6q3qRLLFLzRiaSUgK
	WAPLk21kJxVHpNhvT3j5ha5YBPtXtO5ir27NwcwymyOsymoy5qrVs0uDHGBVTwu3Tls+EifncDS0D
	Uh5VGJPw==;
Received: from [2601:1c0:6280:3f0::19c2]
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdkh1-0002Fv-Dx; Wed, 27 May 2020 01:17:15 +0000
To: LKML <linux-kernel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Jonathan Corbet <corbet@lwn.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: fixes to the maintainer-entry-profile template
Message-ID: <fbaa9b67-e7b8-d5e8-ecbb-6ae068234880@infradead.org>
Date: Tue, 26 May 2020 18:17:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Language: en-US
Message-ID-Hash: KFQNA7SXUM2KKZDH4OX6Z5N3FLSTHZBG
X-Message-ID-Hash: KFQNA7SXUM2KKZDH4OX6Z5N3FLSTHZBG
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KFQNA7SXUM2KKZDH4OX6Z5N3FLSTHZBG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Randy Dunlap <rdunlap@infradead.org>

Do some wordsmithing and copy editing on the maintainer-entry-profile
profile (template, guide):
- fix punctuation
- fix some wording
- use "-rc" consistently

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/maintainer/maintainer-entry-profile.rst |   12 +++++-----
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20200526.orig/Documentation/maintainer/maintainer-entry-profile.rst
+++ linux-next-20200526/Documentation/maintainer/maintainer-entry-profile.rst
@@ -7,7 +7,7 @@ The Maintainer Entry Profile supplements
 (submitting-patches, submitting drivers...) with
 subsystem/device-driver-local customs as well as details about the patch
 submission life-cycle. A contributor uses this document to level set
-their expectations and avoid common mistakes, maintainers may use these
+their expectations and avoid common mistakes; maintainers may use these
 profiles to look across subsystems for opportunities to converge on
 common practices.
 
@@ -26,7 +26,7 @@ Example questions to consider:
 - Does the subsystem have a patchwork instance? Are patchwork state
   changes notified?
 - Any bots or CI infrastructure that watches the list, or automated
-  testing feedback that the subsystem gates acceptance?
+  testing feedback that the subsystem uses to gate acceptance?
 - Git branches that are pulled into -next?
 - What branch should contributors submit against?
 - Links to any other Maintainer Entry Profiles? For example a
@@ -54,8 +54,8 @@ One of the common misunderstandings of s
 sent at any time before the merge window closes and can still be
 considered for the next -rc1. The reality is that most patches need to
 be settled in soaking in linux-next in advance of the merge window
-opening. Clarify for the submitter the key dates (in terms rc release
-week) that patches might considered for merging and when patches need to
+opening. Clarify for the submitter the key dates (in terms of -rc release
+week) that patches might be considered for merging and when patches need to
 wait for the next -rc. At a minimum:
 
 - Last -rc for new feature submissions:
@@ -70,8 +70,8 @@ wait for the next -rc. At a minimum:
 - Last -rc to merge features: Deadline for merge decisions
   Indicate to contributors the point at which an as yet un-applied patch
   set will need to wait for the NEXT+1 merge window. Of course there is no
-  obligation to ever except any given patchset, but if the review has not
-  concluded by this point the expectation the contributor should wait and
+  obligation to ever accept any given patchset, but if the review has not
+  concluded by this point the expectation is the contributor should wait and
   resubmit for the following merge window.
 
 Optional:
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
