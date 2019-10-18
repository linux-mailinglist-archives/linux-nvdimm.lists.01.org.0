Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E819DCFEE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 22:23:14 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0CFC010FCB900;
	Fri, 18 Oct 2019 13:25:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9AA0F10FCB3BF
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 13:25:14 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E065418CB91C
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 20:23:08 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C55E660600;
	Fri, 18 Oct 2019 20:23:08 +0000 (UTC)
Received: by segfault.boston.devel.redhat.com (Postfix, from userid 3734)
	id CDBBE21C9AD4; Fri, 18 Oct 2019 16:23:07 -0400 (EDT)
From: Jeff Moyer <jmoyer@redhat.com>
To: linux-nvdimm@lists.01.org
Cc: Jeff Moyer <jmoyer@redhat.com>
Subject: [ndctl patch 3/4] query_fw_finish_status: get rid of redundant variable
Date: Fri, 18 Oct 2019 16:23:01 -0400
Message-Id: <20191018202302.8122-4-jmoyer@redhat.com>
In-Reply-To: <20191018202302.8122-1-jmoyer@redhat.com>
References: <20191018202302.8122-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Fri, 18 Oct 2019 20:23:08 +0000 (UTC)
Message-ID-Hash: OAQ5ZUCF37HIJXCVK3FWDGU7UYETBGMJ
X-Message-ID-Hash: OAQ5ZUCF37HIJXCVK3FWDGU7UYETBGMJ
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OAQ5ZUCF37HIJXCVK3FWDGU7UYETBGMJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 'done' variable only adds confusion.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---
 ndctl/dimm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index c8821d6..f28b9c1 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -682,7 +682,6 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
 	struct ndctl_cmd *cmd;
 	int rc;
 	enum ND_FW_STATUS status;
-	bool done = false;
 	struct timespec now, before, after;
 	uint64_t ver;
 
@@ -716,7 +715,6 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
 					ndctl_dimm_get_devname(dimm));
 			printf("Firmware version %#lx.\n", ver);
 			printf("Cold reboot to activate.\n");
-			done = true;
 			rc = 0;
 			break;
 		case FW_EBUSY:
@@ -753,7 +751,6 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
 				ndctl_dimm_get_devname(dimm));
 		case FW_EINVAL_CTX:
 		case FW_ESEQUENCE:
-			done = true;
 			rc = -ENXIO;
 			goto out;
 		case FW_ENORES:
@@ -761,17 +758,15 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
 				"Firmware update sequence timed out: %s\n",
 				ndctl_dimm_get_devname(dimm));
 			rc = -ETIMEDOUT;
-			done = true;
 			goto out;
 		default:
 			fprintf(stderr,
 				"Unknown update status: %#x on DIMM %s\n",
 				status, ndctl_dimm_get_devname(dimm));
 			rc = -EINVAL;
-			done = true;
 			goto out;
 		}
-	} while (!done);
+	} while (true);
 
 out:
 	ndctl_cmd_unref(cmd);
-- 
2.19.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
