Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7972C7E50A
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Aug 2019 23:55:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A2F1321306CE6;
	Thu,  1 Aug 2019 14:57:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2F926212FE8B7
 for <linux-nvdimm@lists.01.org>; Thu,  1 Aug 2019 14:57:28 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B34F30D822D;
 Thu,  1 Aug 2019 21:54:57 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23C895D9CD;
 Thu,  1 Aug 2019 21:54:57 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: dan.j.williams@intel.com
Subject: [patch] nfit: report frozen security state
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 01 Aug 2019 17:54:56 -0400
Message-ID: <x49k1bw7dqn.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 01 Aug 2019 21:54:57 +0000 (UTC)
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
Cc: linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

If a dimm is frozen, it is currently reported as being "locked".  While
that's not technically wrong, it is misleading as the dimm can't be
unlocked.  Fix the confusion.

Thanks to Dan for pointing this out.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index cddd0fcf622c..0df2216b2c68 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -54,12 +54,12 @@ static enum nvdimm_security_state intel_security_state(struct nvdimm *nvdimm,
 		if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_UNSUPPORTED)
 			return -ENXIO;
 		else if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_ENABLED) {
-			if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_LOCKED)
-				return NVDIMM_SECURITY_LOCKED;
-			else if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_FROZEN
+			if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_FROZEN
 					|| nd_cmd.cmd.state &
 					ND_INTEL_SEC_STATE_PLIMIT)
 				return NVDIMM_SECURITY_FROZEN;
+			else if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_LOCKED)
+				return NVDIMM_SECURITY_LOCKED;
 			else
 				return NVDIMM_SECURITY_UNLOCKED;
 		}
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
