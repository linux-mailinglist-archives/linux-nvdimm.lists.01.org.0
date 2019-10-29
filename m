Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B9E8F03
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Oct 2019 19:10:45 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A069100EA531;
	Tue, 29 Oct 2019 11:11:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E7934100EEB9C
	for <linux-nvdimm@lists.01.org>; Tue, 29 Oct 2019 11:11:22 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 11:10:40 -0700
X-IronPort-AV: E=Sophos;i="5.68,244,1569308400";
   d="scan'208";a="193689577"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 11:10:40 -0700
Subject: [ndctl PATCH] ndctl/namespace: Clarify that 'reconfigure' ==
 'destroy+create'
From: Dan Williams <dan.j.williams@intel.com>
To: vishal.l.verma@intel.com
Date: Tue, 29 Oct 2019 10:56:23 -0700
Message-ID: <157237178347.4146560.10127156903020487402.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: HOVPRJPBPRFIK7QFJDR77M2VSWBCGAR6
X-Message-ID-Hash: HOVPRJPBPRFIK7QFJDR77M2VSWBCGAR6
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Seema Pandit <seema.pandit@intel.com>, Bharath Venkatesh <bharath.venkatesh@intel.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HOVPRJPBPRFIK7QFJDR77M2VSWBCGAR6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 'reconfigure' option to create-namespace is simply a shortcut for
the following flow:

- Read all parameters from @victim_namespace
- Destroy @victim_namespace
- Create @new_namespace merging old parameters with new ones

Critically this process makes no attempt to preserve data. In fact
previous data is almost always destroyed except for cases where the mode
remains 'raw' over the transition. Even there the create step may choose
new free space for @new_namespace that was not previously allocated to
@victim_namespace. For reconfigurations where the target mode is 'fsdax'
or 'devdax' any size increase may increase the size of metadata needed
at the start of the namespace and overwrite previous data from
@victim_namespace.

Highlight these details in the man page to preclude assumptions that the
a namespace can be reconfigured while keeping existing data intact.

Reported-by: Seema Pandit <seema.pandit@intel.com>
Reported-by: Bharath Venkatesh <bharath.venkatesh@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/ndctl-create-namespace.txt |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/ndctl/ndctl-create-namespace.txt b/Documentation/ndctl/ndctl-create-namespace.txt
index e29a5e75e43c..45a4c4c2f408 100644
--- a/Documentation/ndctl/ndctl-create-namespace.txt
+++ b/Documentation/ndctl/ndctl-create-namespace.txt
@@ -116,12 +116,21 @@ OPTIONS
 
 -e::
 --reconfig=::
-	Reconfigure an existing namespace (change the mode, sector size,
-	etc...).  All namespace parameters, save uuid, default to the
-	current attributes of the specified namespace.  The namespace is
-	then re-created with the specified modifications.  The uuid is
-	refreshed to a new value by default whenever the data layout of
-	a namespace is changed, see --uuid= to set a specific uuid.
+	Reconfigure an existing namespace. This option is a shortcut for
+	the following sequence:
+
+	- Read all parameters from @victim_namespace
+	- Destroy @victim_namespace
+	- Create @new_namespace merging old parameters with new ones
+::
+	Note that the major implication of a destroy-create cycle is
+	that data from @victim_namespace is not preserved in
+	@new_namespace. The attributes transferred from
+	@victim_namespace are the geometry, mode, and name (not uuid
+	without --uuid=). No attempt is made to preserve the data and
+	any old data that is visible in @new_namespace is by coincidence
+	not convention. "Backup and restore" is the only reliable method
+	to populate @new_namespace with data from @victim_namespace.
 
 -u::
 --uuid=::
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
