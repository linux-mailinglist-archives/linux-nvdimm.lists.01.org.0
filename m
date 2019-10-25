Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C89E566F
	for <lists+linux-nvdimm@lfdr.de>; Sat, 26 Oct 2019 00:21:21 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B1B58100EEBBE;
	Fri, 25 Oct 2019 15:22:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 61E52100EEBBA
	for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 15:22:28 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 15:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400";
   d="scan'208";a="201941997"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 15:21:16 -0700
Date: Fri, 25 Oct 2019 15:21:16 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [ndctl patch 3/4] query_fw_finish_status: get rid of redundant
 variable
Message-ID: <20191025222115.GA6536@iweiny-DESK2.sc.intel.com>
References: <20191018202302.8122-1-jmoyer@redhat.com>
 <20191018202302.8122-4-jmoyer@redhat.com>
 <20191018205424.GA12760@iweiny-DESK2.sc.intel.com>
 <x49sgnp7ohp.fsf@segfault.boston.devel.redhat.com>
 <49b7cb5dae88ada6945b15eb1cf2e5e798173861.camel@intel.com>
 <7187044f4f6dca57f43879cd2d493949735f63a2.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7187044f4f6dca57f43879cd2d493949735f63a2.camel@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: I6DU2MO4WZ7IINHINHQVU763NYLPUYB2
X-Message-ID-Hash: I6DU2MO4WZ7IINHINHQVU763NYLPUYB2
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I6DU2MO4WZ7IINHINHQVU763NYLPUYB2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 23, 2019 at 03:51:21PM -0700, 'Vishal Verma' wrote:
> On Wed, 2019-10-23 at 22:28 +0000, Verma, Vishal L wrote:
> > On Fri, 2019-10-18 at 17:06 -0400, Jeff Moyer wrote:
> > > Ira Weiny <ira.weiny@intel.com> writes:
> > > > On Fri, Oct 18, 2019 at 04:23:01PM -0400, Jeff Moyer wrote:
> > > > > The 'done' variable only adds confusion.
> > > > > 
> > > > > Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> > > > > ---
> > > > >  ndctl/dimm.c | 7 +------
> > > > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/ndctl/dimm.c b/ndctl/dimm.c
> > > > > index c8821d6..f28b9c1 100644
> > > > > --- a/ndctl/dimm.c
> > > > > +++ b/ndctl/dimm.c
> > > > > @@ -682,7 +682,6 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
> > > > >  	struct ndctl_cmd *cmd;
> > > > >  	int rc;
> > > > >  	enum ND_FW_STATUS status;
> > > > > -	bool done = false;
> > > > >  	struct timespec now, before, after;
> > > > >  	uint64_t ver;
> > > > >  
> > > > > @@ -716,7 +715,6 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
> > > > >  					ndctl_dimm_get_devname(dimm));
> > > > >  			printf("Firmware version %#lx.\n", ver);
> > > > >  			printf("Cold reboot to activate.\n");
> > > > > -			done = true;
> > > > >  			rc = 0;
> > > > 
> > > > Do we need "goto out" here?
> > > 
> > > Yes, I missed that one.  Thanks.
> > 
> > This actually looks fine, since there is a 'break' down below.
> > 
> > > > >  			break;
> > > > >  		case FW_EBUSY:
> 
> (Watching the unit test run fall into an infinite loop..) Nope, the
> break is in the switch scope, the while loop needs the 'goto out'.
> 
> Yes this bit definitely needs to be refactored :)

How about this patch instead?  Untested.

Ira

From 24511b6a9f1b5e5c9e36c70ef6a03da5100cf4c7 Mon Sep 17 00:00:00 2001
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 25 Oct 2019 15:16:13 -0700
Subject: [PATCH] ndctl: Clean up loop logic in query_fw_finish_status

This gets rid of a redundant variable as originally pointed out by Jeff
Moyer[1]

Also, while we are here change the printf's to fprintf(stderr, ...)

[1] https://patchwork.kernel.org/patch/11199557/

Suggested-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 ndctl/dimm.c | 142 +++++++++++++++++++++++++--------------------------
 1 file changed, 70 insertions(+), 72 deletions(-)

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index 5e6fa19bab15..84de014e93d6 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -682,7 +682,6 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
 	struct ndctl_cmd *cmd;
 	int rc;
 	enum ND_FW_STATUS status;
-	bool done = false;
 	struct timespec now, before, after;
 	uint64_t ver;
 
@@ -692,88 +691,87 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
 
 	rc = clock_gettime(CLOCK_MONOTONIC, &before);
 	if (rc < 0)
-		goto out;
+		goto unref;
 
 	now.tv_nsec = fw->query_interval / 1000;
 	now.tv_sec = 0;
 
-	do {
-		rc = ndctl_cmd_submit(cmd);
-		if (rc < 0)
-			break;
+again:
+	rc = ndctl_cmd_submit(cmd);
+	if (rc < 0)
+		goto unref;
 
-		status = ndctl_cmd_fw_xlat_firmware_status(cmd);
-		switch (status) {
-		case FW_SUCCESS:
-			ver = ndctl_cmd_fw_fquery_get_fw_rev(cmd);
-			if (ver == 0) {
-				fprintf(stderr, "No firmware updated.\n");
-				rc = -ENXIO;
-				goto out;
-			}
+	status = ndctl_cmd_fw_xlat_firmware_status(cmd);
+	if (status == FW_EBUSY) {
+		/* Still on going, continue */
+		rc = clock_gettime(CLOCK_MONOTONIC, &after);
+		if (rc < 0) {
+			rc = -errno;
+			goto unref;
+		}
 
-			printf("Image updated successfully to DIMM %s.\n",
-					ndctl_dimm_get_devname(dimm));
-			printf("Firmware version %#lx.\n", ver);
-			printf("Cold reboot to activate.\n");
-			done = true;
-			rc = 0;
-			break;
-		case FW_EBUSY:
-			/* Still on going, continue */
-			rc = clock_gettime(CLOCK_MONOTONIC, &after);
-			if (rc < 0) {
-				rc = -errno;
-				goto out;
-			}
+		/*
+		 * If we expire max query time,
+		 * we timed out
+		 */
+		if (after.tv_sec - before.tv_sec >
+				fw->max_query / 1000000) {
+			rc = -ETIMEDOUT;
+			goto unref;
+		}
 
-			/*
-			 * If we expire max query time,
-			 * we timed out
-			 */
-			if (after.tv_sec - before.tv_sec >
-					fw->max_query / 1000000) {
-				rc = -ETIMEDOUT;
-				goto out;
-			}
+		/*
+		 * Sleep the interval dictated by firmware
+		 * before query again.
+		 */
+		rc = nanosleep(&now, NULL);
+		if (rc < 0) {
+			rc = -errno;
+			goto unref;
+		}
+		goto again;
+	}
 
-			/*
-			 * Sleep the interval dictated by firmware
-			 * before query again.
-			 */
-			rc = nanosleep(&now, NULL);
-			if (rc < 0) {
-				rc = -errno;
-				goto out;
-			}
-			break;
-		case FW_EBADFW:
-			fprintf(stderr,
-				"Firmware failed to verify by DIMM %s.\n",
-				ndctl_dimm_get_devname(dimm));
-		case FW_EINVAL_CTX:
-		case FW_ESEQUENCE:
-			done = true;
+	/* We are done determine error code */
+	switch (status) {
+	case FW_SUCCESS:
+		ver = ndctl_cmd_fw_fquery_get_fw_rev(cmd);
+		if (ver == 0) {
+			fprintf(stderr, "No firmware updated.\n");
 			rc = -ENXIO;
-			goto out;
-		case FW_ENORES:
-			fprintf(stderr,
-				"Firmware update sequence timed out: %s\n",
-				ndctl_dimm_get_devname(dimm));
-			rc = -ETIMEDOUT;
-			done = true;
-			goto out;
-		default:
-			fprintf(stderr,
-				"Unknown update status: %#x on DIMM %s\n",
-				status, ndctl_dimm_get_devname(dimm));
-			rc = -EINVAL;
-			done = true;
-			goto out;
+			goto unref;
 		}
-	} while (!done);
 
-out:
+		fprintf(stderr, "Image updated successfully to DIMM %s.\n",
+			ndctl_dimm_get_devname(dimm));
+		fprintf(stderr, "Firmware version %#lx.\n", ver);
+		fprintf(stderr, "Cold reboot to activate.\n");
+		rc = 0;
+		break;
+	case FW_EBADFW:
+		fprintf(stderr,
+			"Firmware failed to verify by DIMM %s.\n",
+			ndctl_dimm_get_devname(dimm));
+		/* FALLTHROUGH */
+	case FW_EINVAL_CTX:
+	case FW_ESEQUENCE:
+		rc = -ENXIO;
+		break;
+	case FW_ENORES:
+		fprintf(stderr,
+			"Firmware update sequence timed out: %s\n",
+			ndctl_dimm_get_devname(dimm));
+		rc = -ETIMEDOUT;
+		break;
+	default:
+		fprintf(stderr,
+			"Unknown update status: %#x on DIMM %s\n",
+			status, ndctl_dimm_get_devname(dimm));
+		rc = -EINVAL;
+		break;
+	}
+
+unref:
 	ndctl_cmd_unref(cmd);
 	return rc;
 }
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
