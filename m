Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B44F85479
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Aug 2019 22:29:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C03421309D2F;
	Wed,  7 Aug 2019 13:32:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 93793212FD3F1
 for <linux-nvdimm@lists.01.org>; Wed,  7 Aug 2019 13:32:15 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Aug 2019 11:05:57 -0700
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; d="scan'208";a="168713377"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Aug 2019 11:05:57 -0700
Subject: [ndctl PATCH] ndctl/lib: Fix duplicate bus detection
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 07 Aug 2019 10:51:39 -0700
Message-ID: <156520029994.1268132.13388510714364773911.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

After an ndctl_invalidate() event the next add_bus() invocation attempts
to rescan for new bus objects and drop duplicate instances that match
existing bus objects. However, the implementation mistakenly expects
that ndctl_bus_get_provider_name() returns a unique identifier per-bus,
but it is perfectly acceptable for unique buses to share a 'provider
name'. Use the bus device-name to disambiguate buses with the same
'provider name'.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Tested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/lib/libndctl.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 4d9cc7e29c6b..6596f94edef8 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -889,7 +889,9 @@ static void *add_bus(void *parent, int id, const char *ctl_base)
 
 	ndctl_bus_foreach(ctx, bus_dup)
 		if (strcmp(ndctl_bus_get_provider(bus_dup),
-					ndctl_bus_get_provider(bus)) == 0) {
+					ndctl_bus_get_provider(bus)) == 0
+				&& strcmp(ndctl_bus_get_devname(bus_dup),
+					ndctl_bus_get_devname(bus)) == 0) {
 			free_bus(bus, NULL);
 			free(path);
 			return bus_dup;

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
