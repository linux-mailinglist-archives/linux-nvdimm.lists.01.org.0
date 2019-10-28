Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CB6E7C31
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Oct 2019 23:12:39 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F06D4100EA63C;
	Mon, 28 Oct 2019 15:13:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9212E100EA63A
	for <linux-nvdimm@lists.01.org>; Mon, 28 Oct 2019 15:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1572300753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUee+wYEbuSeB3k4G32oatRkIGid2AimfRnnWXrwOck=;
	b=dYZ0N1zGUn1A8dTFjkoh6P1wKSmCPxAIvH/atdebk1xhYGDmiqknamWSInL7e8jV395DR4
	/RAs3MLc05jBpdksnPLYj+7+YVRHGxjF/fmkUpRMtukdDZF0C0snuhItf2U+6YEh4N7Mpy
	nTRkVFSdJSLYzXm4U4CZdDMGOrR1XKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18--la1hE_oNpelRxjRwqBREg-1; Mon, 28 Oct 2019 18:12:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5C672B6;
	Mon, 28 Oct 2019 22:12:24 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 41FE75C1B2;
	Mon, 28 Oct 2019 22:12:24 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [ndctl patch 3/4] query_fw_finish_status: get rid of redundant variable
References: <20191018202302.8122-1-jmoyer@redhat.com>
	<20191018202302.8122-4-jmoyer@redhat.com>
	<20191018205424.GA12760@iweiny-DESK2.sc.intel.com>
	<x49sgnp7ohp.fsf@segfault.boston.devel.redhat.com>
	<49b7cb5dae88ada6945b15eb1cf2e5e798173861.camel@intel.com>
	<7187044f4f6dca57f43879cd2d493949735f63a2.camel@intel.com>
	<20191025222115.GA6536@iweiny-DESK2.sc.intel.com>
	<x49v9s8veyb.fsf@segfault.boston.devel.redhat.com>
	<20191028211338.GA9826@iweiny-DESK2.sc.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 28 Oct 2019 18:12:23 -0400
In-Reply-To: <20191028211338.GA9826@iweiny-DESK2.sc.intel.com> (Ira Weiny's
	message of "Mon, 28 Oct 2019 14:13:39 -0700")
Message-ID: <x49v9s834fs.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: -la1hE_oNpelRxjRwqBREg-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: BPRULSOYKQZWUWR2PFD7WSWQORNJMRRT
X-Message-ID-Hash: BPRULSOYKQZWUWR2PFD7WSWQORNJMRRT
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BPRULSOYKQZWUWR2PFD7WSWQORNJMRRT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ira Weiny <ira.weiny@intel.com> writes:

> On Mon, Oct 28, 2019 at 03:37:48PM -0400, Jeff Moyer wrote:
>> Ira Weiny <ira.weiny@intel.com> writes:
>> 
>> >> (Watching the unit test run fall into an infinite loop..) Nope, the
>> >> break is in the switch scope, the while loop needs the 'goto out'.
>> >> 
>> >> Yes this bit definitely needs to be refactored :)
>> >
>> > How about this patch instead?  Untested.
>> 
>> I'm not a fan of the looping with gotos.
>
> Me either... But... the logic here is not the same.

How about this one, then?  Again, compile-tested only.  I'll run it
through testing only if you like it better than your approach.  If you
like your appraoch better, I'll go ahead and review and test that.

Cheers,
Jeff

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index b1b84c2..63d4d4a 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -674,6 +674,52 @@ out:
 	return rc;
 }
 
+/*
+ * Wait for a command to complete, up to the firmware-specified timeout.
+ * Returns -errno on error.  On success, which means either the command
+ * completed (sucessfully or with an error), or we timed out waiting for
+ * it, return 0.  The caller needs to check the status on its own if this
+ * function returns 0.
+ */
+static int query_fw_finish_status_timeout(struct ndctl_cmd *cmd,
+					  struct fw_info *fw)
+{
+	enum ND_FW_STATUS status;
+	struct timespec sleeptime, start, now;
+	int rc;
+
+	rc = clock_gettime(CLOCK_MONOTONIC, &start);
+	if (rc < 0)
+		return rc;
+
+	sleeptime.tv_nsec = fw->query_interval / 1000;
+	sleeptime.tv_sec = 0;
+
+	while ((rc = ndctl_cmd_submit(cmd)) == 0 &&
+	       (status = ndctl_cmd_fw_xlat_firmware_status(cmd)) == FW_EBUSY) {
+
+		rc = clock_gettime(CLOCK_MONOTONIC, &now);
+		if (rc < 0)
+			break;
+
+		/*
+		 * If we expire max query time, we timed out
+		 */
+		if (now.tv_sec - start.tv_sec > fw->max_query / 1000000)
+			break;
+
+		/*
+		 * Sleep the interval dictated by firmware before
+		 * query again.
+		 */
+		rc = nanosleep(&sleeptime, NULL);
+		if (rc < 0)
+			break;
+	}
+
+	return rc;
+}
+
 static int query_fw_finish_status(struct ndctl_dimm *dimm,
 		struct action_context *actx)
 {
@@ -682,94 +728,55 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
 	struct ndctl_cmd *cmd;
 	int rc;
 	enum ND_FW_STATUS status;
-	struct timespec now, before, after;
 	uint64_t ver;
 
 	cmd = ndctl_dimm_cmd_new_fw_finish_query(uctx->start);
 	if (!cmd)
 		return -ENXIO;
 
-	rc = clock_gettime(CLOCK_MONOTONIC, &before);
+	rc = query_fw_finish_status_timeout(cmd, fw);
 	if (rc < 0)
-		goto out;
-
-	now.tv_nsec = fw->query_interval / 1000;
-	now.tv_sec = 0;
-
-	do {
-		rc = ndctl_cmd_submit(cmd);
-		if (rc < 0)
-			break;
-
-		status = ndctl_cmd_fw_xlat_firmware_status(cmd);
-		switch (status) {
-		case FW_SUCCESS:
-			ver = ndctl_cmd_fw_fquery_get_fw_rev(cmd);
-			if (ver == 0) {
-				fprintf(stderr, "No firmware updated.\n");
-				rc = -ENXIO;
-				goto out;
-			}
-
-			printf("Image updated successfully to DIMM %s.\n",
-					ndctl_dimm_get_devname(dimm));
-			printf("Firmware version %#lx.\n", ver);
-			printf("Cold reboot to activate.\n");
-			rc = 0;
-			goto out;
-			break;
-		case FW_EBUSY:
-			/* Still on going, continue */
-			rc = clock_gettime(CLOCK_MONOTONIC, &after);
-			if (rc < 0) {
-				rc = -errno;
-				goto out;
-			}
-
-			/*
-			 * If we expire max query time,
-			 * we timed out
-			 */
-			if (after.tv_sec - before.tv_sec >
-					fw->max_query / 1000000) {
-				rc = -ETIMEDOUT;
-				goto out;
-			}
+		goto unref;
 
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
+	status = ndctl_cmd_fw_xlat_firmware_status(cmd);
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
-			goto out;
-		default:
-			fprintf(stderr,
-				"Unknown update status: %#x on DIMM %s\n",
-				status, ndctl_dimm_get_devname(dimm));
-			rc = -EINVAL;
-			goto out;
+			break;
 		}
-	} while (true);
 
-out:
+		printf("Image updated successfully to DIMM %s.\n",
+		       ndctl_dimm_get_devname(dimm));
+		printf("Firmware version %#lx.\n", ver);
+		printf("Cold reboot to activate.\n");
+		break;
+	case FW_EBADFW:
+		fprintf(stderr,
+			"Firmware failed to verify by DIMM %s.\n",
+			ndctl_dimm_get_devname(dimm));
+	case FW_EINVAL_CTX:
+	case FW_ESEQUENCE:
+		rc = -ENXIO;
+		break;
+	case FW_EBUSY:
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
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
