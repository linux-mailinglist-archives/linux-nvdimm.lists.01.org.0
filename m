Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27194A2704
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Aug 2019 21:08:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4C3D52021DD50;
	Thu, 29 Aug 2019 12:10:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F0A242021DD4B
 for <linux-nvdimm@lists.01.org>; Thu, 29 Aug 2019 12:10:44 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Aug 2019 12:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; d="scan'208";a="197866910"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2019 12:08:52 -0700
Date: Thu, 29 Aug 2019 13:08:52 -0600
From: Vishal Verma <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH 3/3] ndctl/namespace: add a --continue option to
 create namespaces greedily
Message-ID: <20190829190852.GA14129@vverma7-desk1.lm.intel.com>
References: <20190829001735.30289-1-vishal.l.verma@intel.com>
 <20190829001735.30289-4-vishal.l.verma@intel.com>
 <CAPcyv4gB-2hkPM=zKCigpDAUxQbzWFVRmZ=UnTF0wsBW3-nmsQ@mail.gmail.com>
 <44b020035e3245084b2310cfdfe496853e2cf18d.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <44b020035e3245084b2310cfdfe496853e2cf18d.camel@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: "Scargall, Steve" <steve.scargall@intel.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 08/29, Verma, Vishal L wrote:
> On Wed, 2019-08-28 at 19:34 -0700, Dan Williams wrote:
> > 
> > Hmm, should "--continue --force" override that policy?
> 
> Yep that's a good idea, with a big note in the man page that errors
> could be lost/meaningless in that case.
> 
> > 
> > Otherwise this looks good to me.
> 
> Thanks, I'll send a new version with the above.
> _______________________________________________

Here is v2 with the --force change:

3<----


From a91425beabae750227931594f77fe3db72b4cfff Mon Sep 17 00:00:00 2001
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Wed, 28 Aug 2019 18:01:38 -0600
Subject: [ndctl PATCH v2] ndctl/namespace: add a --continue option to create
 namespaces greedily

Add a --continue option to ndctl-create-namespaces to allow the creation
of as many namespaces as possible, that meet the given filter
restrictions.

The creation loop will be aborted if a failure is encountered at any
point, unless --force is also specified.

Link: https://github.com/pmem/ndctl/issues/106
Reported-by: Steve Scargal <steve.scargall@intel.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---

v2: Allow --force to continue in spite of errors (Dan)

 .../ndctl/ndctl-create-namespace.txt          | 11 +++++-
 ndctl/namespace.c                             | 34 +++++++++++++++----
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/Documentation/ndctl/ndctl-create-namespace.txt b/Documentation/ndctl/ndctl-create-namespace.txt
index c9ae27c..e29a5e7 100644
--- a/Documentation/ndctl/ndctl-create-namespace.txt
+++ b/Documentation/ndctl/ndctl-create-namespace.txt
@@ -152,6 +152,13 @@ OPTIONS
 	namespace directly ("--map=dev"). The overhead is 64-bytes per
 	4K (16GB per 1TB) on x86.
 
+-c::
+--continue::
+	Do not stop after creating one namespace. Instead, greedily create as
+	many namespaces as possible within the given --bus and --region filter
+	restrictions. This will abort if any creation attempt results in an
+	error unless --force is also supplied.
+
 -f::
 --force::
 	Unless this option is specified the 'reconfigure namespace'
@@ -160,7 +167,9 @@ OPTIONS
 	the operation is attempted. However, if the namespace is
 	mounted then the 'disable namespace' and 'reconfigure
 	namespace' operations will be aborted.  The namespace must be
-	unmounted before being reconfigured.
+	unmounted before being reconfigured. When used in conjunction
+	with --continue, continue the namespace creation loop even
+	if an error is encountered for intermediate namespaces.
 
 -L::
 --autolabel::
diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index af20a42..67768f3 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -41,6 +41,7 @@ static struct parameters {
 	bool do_scan;
 	bool mode_default;
 	bool autolabel;
+	bool greedy;
 	const char *bus;
 	const char *map;
 	const char *type;
@@ -114,7 +115,9 @@ OPT_STRING('t', "type", &param.type, "type", \
 OPT_STRING('a', "align", &param.align, "align", \
 	"specify the namespace alignment in bytes (default: 2M)"), \
 OPT_BOOLEAN('f', "force", &force, "reconfigure namespace even if currently active"), \
-OPT_BOOLEAN('L', "autolabel", &param.autolabel, "automatically initialize labels")
+OPT_BOOLEAN('L', "autolabel", &param.autolabel, "automatically initialize labels"), \
+OPT_BOOLEAN('c', "continue", &param.greedy, \
+	"continue creating namespaces as long as the filter criteria are met")
 
 #define CHECK_OPTIONS() \
 OPT_BOOLEAN('R', "repair", &repair, "perform metadata repairs"), \
@@ -1322,10 +1325,10 @@ static int do_xaction_namespace(const char *namespace,
 		int *processed)
 {
 	struct ndctl_namespace *ndns, *_n;
+	int rc = -ENXIO, saved_rc = 0;
 	struct ndctl_region *region;
 	const char *ndns_name;
 	struct ndctl_bus *bus;
-	int rc = -ENXIO;
 
 	*processed = 0;
 
@@ -1365,8 +1368,16 @@ static int do_xaction_namespace(const char *namespace,
 				rc = namespace_create(region);
 				if (rc == -EAGAIN)
 					continue;
-				if (rc == 0)
-					*processed = 1;
+				if (rc == 0) {
+					(*processed)++;
+					if (param.greedy)
+						continue;
+				}
+				if (force) {
+					if (rc)
+						saved_rc = rc;
+					continue;
+				}
 				return rc;
 			}
 			ndctl_namespace_foreach_safe(region, ndns, _n) {
@@ -1427,10 +1438,18 @@ static int do_xaction_namespace(const char *namespace,
 		/*
 		 * Namespace creation searched through all candidate
 		 * regions and all of them said "nope, I don't have
-		 * enough capacity", so report -ENOSPC
+		 * enough capacity", so report -ENOSPC. Except during
+		 * greedy namespace creation using --continue as we
+		 * may have created some namespaces already, and the
+		 * last one in the region search may preexist.
 		 */
-		rc = -ENOSPC;
+		if (param.greedy && (*processed) > 0)
+			rc = 0;
+		else
+			rc = -ENOSPC;
 	}
+	if (saved_rc)
+		rc = saved_rc;
 
 	return rc;
 }
@@ -1487,6 +1506,9 @@ int cmd_create_namespace(int argc, const char **argv, struct ndctl_ctx *ctx)
 		rc = do_xaction_namespace(NULL, ACTION_CREATE, ctx, &created);
 	}
 
+	if (param.greedy)
+		fprintf(stderr, "created %d namespace%s\n", created,
+			created == 1 ? "" : "s");
 	if (rc < 0 || (!namespace && created < 1)) {
 		fprintf(stderr, "failed to %s namespace: %s\n", namespace
 				? "reconfigure" : "create", strerror(-rc));
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
