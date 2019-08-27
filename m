Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F579F303
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Aug 2019 21:13:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6085320216B95;
	Tue, 27 Aug 2019 12:15:06 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 027962020F950
 for <linux-nvdimm@lists.01.org>; Tue, 27 Aug 2019 12:15:04 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Aug 2019 12:12:56 -0700
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; d="scan'208";a="197371482"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Aug 2019 12:12:55 -0700
Subject: [ndctl PATCH] ndctl/namespace: Fix 'clear-error -s' excessive
 scrubbing
From: Dan Williams <dan.j.williams@intel.com>
To: vishal.l.verma@intel.com
Date: Tue, 27 Aug 2019 11:58:38 -0700
Message-ID: <156693231821.718166.10779376892986285406.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: Erwin Tsaur <erwin.tsaur@oracle.com>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Erwin reports:
    The current implementation of ndctl clear-errors takes a very long time,
    because a full scrub happens for every namespace.

    Doing a full system ARS scrub is obviously not necessary, it just needs
    to happen once.

Indeed, it only needs to happen once per bus. Clear the 'scrub' option
after one namespace_clear_bb() invocation, and reset it when looping to
the next bus.

Link: https://github.com/pmem/ndctl/issues/104
Reported-by: Erwin Tsaur <erwin.tsaur@oracle.com>
Fixes: 2ba7b8277075 ("ndctl: add a 'clear-errors' command")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index bbc9107c6baa..c1af7d0db153 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1295,7 +1295,7 @@ static int raw_clear_badblocks(struct ndctl_namespace *ndns)
 	return nstype_clear_badblocks(ndns, devname, begin, size);
 }
 
-static int namespace_wait_scrub(struct ndctl_namespace *ndns)
+static int namespace_wait_scrub(struct ndctl_namespace *ndns, bool do_scrub)
 {
 	const char *devname = ndctl_namespace_get_devname(ndns);
 	struct ndctl_bus *bus = ndctl_namespace_get_bus(ndns);
@@ -1309,7 +1309,7 @@ static int namespace_wait_scrub(struct ndctl_namespace *ndns)
 	}
 
 	/* start a scrub if asked and if one isn't in progress */
-	if (scrub && (!in_progress)) {
+	if (do_scrub && (!in_progress)) {
 		rc = ndctl_bus_start_scrub(bus);
 		if (rc) {
 			error("%s: Unable to start scrub: %s\n", devname,
@@ -1332,7 +1332,7 @@ static int namespace_wait_scrub(struct ndctl_namespace *ndns)
 	return 0;
 }
 
-static int namespace_clear_bb(struct ndctl_namespace *ndns)
+static int namespace_clear_bb(struct ndctl_namespace *ndns, bool do_scrub)
 {
 	struct ndctl_pfn *pfn = ndctl_namespace_get_pfn(ndns);
 	struct ndctl_dax *dax = ndctl_namespace_get_dax(ndns);
@@ -1347,7 +1347,7 @@ static int namespace_clear_bb(struct ndctl_namespace *ndns)
 		return 1;
 	}
 
-	rc = namespace_wait_scrub(ndns);
+	rc = namespace_wait_scrub(ndns, do_scrub);
 	if (rc)
 		return rc;
 
@@ -1716,9 +1716,14 @@ static int do_xaction_namespace(const char *namespace,
 		ndctl_set_log_priority(ctx, LOG_DEBUG);
 
         ndctl_bus_foreach(ctx, bus) {
+		bool do_scrub;
+
 		if (!util_bus_filter(bus, param.bus))
 			continue;
 
+		/* only request scrubbing once per bus */
+		do_scrub = scrub;
+
 		ndctl_region_foreach(bus, region) {
 			if (!util_region_filter(region, param.region))
 				continue;
@@ -1778,7 +1783,10 @@ static int do_xaction_namespace(const char *namespace,
 						(*processed)++;
 					break;
 				case ACTION_CLEAR:
-					rc = namespace_clear_bb(ndns);
+					rc = namespace_clear_bb(ndns, do_scrub);
+
+					/* one scrub per bus is sufficient */
+					do_scrub = false;
 					if (rc == 0)
 						(*processed)++;
 					break;

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
