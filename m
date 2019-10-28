Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C5DE7950
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Oct 2019 20:38:04 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CFE43100EA639;
	Mon, 28 Oct 2019 12:38:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 18952100EA638
	for <linux-nvdimm@lists.01.org>; Mon, 28 Oct 2019 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1572291478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhwFbZwQP6F32OrsrGJ+GaYk1XCAwoPe9jyDswQ7N2A=;
	b=HE0MTpgTRRYv0t08E6Y8k8h8A11DrSdisrkSwboCa6tUnaaZmXgySEYVUclAEHHj+0Bm/O
	2BKuTkAZKiXT2js/HL4p6rQNOQDMV/LruXCA79OOJKP/0dQrTEDVg1DG/UH4dYJ+zstnR7
	gs0aT7OflIjB+ko1/yY1upg9TeI+jgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-r8orKcQ0NUC32wT6wqXxqg-1; Mon, 28 Oct 2019 15:37:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CE105E6;
	Mon, 28 Oct 2019 19:37:50 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ECE1B600C9;
	Mon, 28 Oct 2019 19:37:49 +0000 (UTC)
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
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 28 Oct 2019 15:37:48 -0400
In-Reply-To: <20191025222115.GA6536@iweiny-DESK2.sc.intel.com> (Ira Weiny's
	message of "Fri, 25 Oct 2019 15:21:16 -0700")
Message-ID: <x49v9s8veyb.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: r8orKcQ0NUC32wT6wqXxqg-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: 6EVUZPLKPC3NXE3T7NXMQO6WZJ3EFTUR
X-Message-ID-Hash: 6EVUZPLKPC3NXE3T7NXMQO6WZJ3EFTUR
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6EVUZPLKPC3NXE3T7NXMQO6WZJ3EFTUR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ira Weiny <ira.weiny@intel.com> writes:

>> (Watching the unit test run fall into an infinite loop..) Nope, the
>> break is in the switch scope, the while loop needs the 'goto out'.
>> 
>> Yes this bit definitely needs to be refactored :)
>
> How about this patch instead?  Untested.

I'm not a fan of the looping with gotos.  I think separating out the
waiting for busy to its own function would make this more clear.
Looking more closely, there are other issues.  The timeout code looks at
the seconds, but ignores the fractions, so you could be off by almost an
entire second, there.  It also doens't retry the sleep if interrupted.
Finally, I find the variables names to be highly confusing.

I've decided not to fix those last two bugs just yet, but here's a patch
that shows the dirction I think it should go.  Compile-tested only for
now.  Let me know what you think.

Ira, I used the same base as you.  If you updated ndctl, you'll have to
revert 9e0391e057b36 to apply this patch.

Cheers,
Jeff

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index c8821d6..701f58b 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -674,6 +674,41 @@ out:
 	return rc;
 }
 
+static void wait_for_cmd_completion(struct ndctl_cmd *cmd, struct fw_info *fw,
+				    struct timespec *start)
+{
+	enum ND_FW_STATUS status;
+	struct timespec sleeptime, now;
+	int rc;
+
+	sleeptime.tv_nsec = fw->query_interval / 1000;
+	sleeptime.tv_sec = 0;
+
+	while ((status = ndctl_cmd_fw_xlat_firmware_status(cmd)) == FW_EBUSY) {
+
+		rc = clock_gettime(CLOCK_MONOTONIC, &now);
+		if (rc < 0)
+			break;
+
+		/*
+		 * If we expire max query time, we timed out
+		 */
+		if (now.tv_sec - start->tv_sec > fw->max_query / 1000000)
+			break;
+
+		/*
+		 * Sleep the interval dictated by firmware before
+		 * query again.
+		 */
+		rc = nanosleep(&sleeptime, NULL);
+		if (rc < 0)
+			break;
+
+	}
+
+	return;
+}
+
 static int query_fw_finish_status(struct ndctl_dimm *dimm,
 		struct action_context *actx)
 {
@@ -682,98 +717,65 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
 	struct ndctl_cmd *cmd;
 	int rc;
 	enum ND_FW_STATUS status;
-	bool done = false;
-	struct timespec now, before, after;
+	struct timespec start;
 	uint64_t ver;
 
 	cmd = ndctl_dimm_cmd_new_fw_finish_query(uctx->start);
 	if (!cmd)
 		return -ENXIO;
 
-	rc = clock_gettime(CLOCK_MONOTONIC, &before);
+	rc = clock_gettime(CLOCK_MONOTONIC, &start);
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
-
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
+	rc = ndctl_cmd_submit(cmd);
+	if (rc < 0)
+		goto unref;
 
-			/*
-			 * If we expire max query time,
-			 * we timed out
-			 */
-			if (after.tv_sec - before.tv_sec >
-					fw->max_query / 1000000) {
-				rc = -ETIMEDOUT;
-				goto out;
-			}
+	wait_for_cmd_completion(cmd, fw, &start);
 
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
-			done = true;
-			goto out;
-		default:
-			fprintf(stderr,
-				"Unknown update status: %#x on DIMM %s\n",
-				status, ndctl_dimm_get_devname(dimm));
-			rc = -EINVAL;
-			done = true;
-			goto out;
+			break;
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
