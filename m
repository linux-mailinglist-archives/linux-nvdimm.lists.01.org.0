Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC0D21EFB9
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jul 2020 13:46:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 68C2C11553E88;
	Tue, 14 Jul 2020 04:46:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1A7DE11553E85
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 04:46:00 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 5B238AB3D
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 11:46:01 +0000 (UTC)
From: Michal Suchanek <msuchanek@suse.de>
To: linux-nvdimm@lists.01.org
Subject: [PATCH] Documentation: use includes in more ndctl command pages.
Date: Tue, 14 Jul 2020 13:45:52 +0200
Message-Id: <20200714114552.21685-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: ULGJSDNATAXHYWZAKOZFIDK3REDEZ7AH
X-Message-ID-Hash: ULGJSDNATAXHYWZAKOZFIDK3REDEZ7AH
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Suchanek <msuchanek@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ULGJSDNATAXHYWZAKOZFIDK3REDEZ7AH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

While backporting commit 498ee3d100c3 ("Documentation: clarify bus/dimm/region filtering")
I noticed not all instances of --bus, --dimm, and --region use the
include and hence do not get the clarification.

Fixes: 498ee3d100c3 ("Documentation: clarify bus/dimm/region filtering")

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 Documentation/ndctl/labels-options.txt     |  7 ++-----
 Documentation/ndctl/ndctl-inject-smart.txt |  4 +---
 Documentation/ndctl/ndctl-monitor.txt      | 11 +++--------
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/Documentation/ndctl/labels-options.txt b/Documentation/ndctl/labels-options.txt
index 4aee37969fd5..c7649cfd2aab 100644
--- a/Documentation/ndctl/labels-options.txt
+++ b/Documentation/ndctl/labels-options.txt
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 <memory device(s)>::
-	One or more 'nmemX' device names. The keyword 'all' can be specified to
-	operate on every dimm in the system, optionally filtered by bus id (see
-        --bus= option).
+include::xable-dimm-options.txt[]
 
 -s::
 --size=::
@@ -16,8 +14,7 @@
 
 -b::
 --bus=::
-	Limit operation to memory devices (dimms) that are on the given bus.
-	Where 'bus' can be a provider name or a bus id number.
+include::xable-bus-options.txt[]
 
 -v::
 	Turn on verbose debug messages in the library (if ndctl was built with
diff --git a/Documentation/ndctl/ndctl-inject-smart.txt b/Documentation/ndctl/ndctl-inject-smart.txt
index d28be46cae1c..9fd63bae2729 100644
--- a/Documentation/ndctl/ndctl-inject-smart.txt
+++ b/Documentation/ndctl/ndctl-inject-smart.txt
@@ -38,9 +38,7 @@ OPTIONS
 -------
 -b::
 --bus=::
-	Enforce that the operation only be carried on devices that are
-	attached to the given bus. Where 'bus' can be a provider name or a bus
-	id number.
+include::xable-bus-options.txt[]
 
 -m::
 --media-temperature=::
diff --git a/Documentation/ndctl/ndctl-monitor.txt b/Documentation/ndctl/ndctl-monitor.txt
index 2239f047266d..c0273d378b59 100644
--- a/Documentation/ndctl/ndctl-monitor.txt
+++ b/Documentation/ndctl/ndctl-monitor.txt
@@ -49,20 +49,15 @@ OPTIONS
 -------
 -b::
 --bus=::
-	Enforce that the operation only be carried on devices that are
-	attached to the given bus. Where 'bus' can be a provider name
-	or a bus id number.
+include::xable-bus-options.txt[]
 
 -d::
 --dimm=::
-	A 'nmemX' device name, or dimm id number. Select the devices to
-	monitor reference the given dimm.
+include::xable-dimm-options.txt[]
 
 -r::
 --region=::
-	A 'regionX' device name, or a region id number. The keyword 'all'
-	can be specified to carry out the operation on every region in
-	the system, optionally filtered by bus id (see --bus= option).
+include::xable-region-options.txt[]
 
 -n::
 --namespace=::
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
