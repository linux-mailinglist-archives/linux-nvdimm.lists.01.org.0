Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A2D1A9D64
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Apr 2020 13:46:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1E92010106318;
	Wed, 15 Apr 2020 04:46:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sashal@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DF2C91010630F
	for <linux-nvdimm@lists.01.org>; Wed, 15 Apr 2020 04:46:48 -0700 (PDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 62B0420775;
	Wed, 15 Apr 2020 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586951179;
	bh=S8BciryhmOjmP06oCroyDH/n35WS5a6CLZ6N5yiRrvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIqtJTvw+0jZ6EXCJaAgF4Ewv76mM1WB1uOkribtNJ0hToIgXdxYNKVOSyz5D0wEO
	 1J5CUby2ZJpmqkDYO76picHP0pEwslKlbEwfxsgZ3zMdH0m0dzbo2sDbbO5/6O3CvY
	 47IMQhupxMkelyAxleALbe1npxnJmALPGsSsnACQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 82/84] acpi/nfit: improve bounds checking for 'func'
Date: Wed, 15 Apr 2020 07:44:39 -0400
Message-Id: <20200415114442.14166-82-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114442.14166-1-sashal@kernel.org>
References: <20200415114442.14166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Message-ID-Hash: WW2YAHPSJI6UBA3AWB5F2XI6TVNXYMPT
X-Message-ID-Hash: WW2YAHPSJI6UBA3AWB5F2XI6TVNXYMPT
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dan Carpenter <dan.carpenter@oracle.com>, Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WW2YAHPSJI6UBA3AWB5F2XI6TVNXYMPT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 01091c496f920e634ea84b689f480c39016752a8 ]

The 'func' variable can come from the user in the __nd_ioctl().  If it's
too high then the (1 << func) shift in acpi_nfit_clear_to_send() is
undefined.  In acpi_nfit_ctl() we pass 'func' to test_bit(func, &dsm_mask)
which could result in an out of bounds access.

To fix these issues, I introduced the NVDIMM_CMD_MAX (31) define and
updated nfit_dsm_revid() to use that define as well instead of magic
numbers.

Fixes: 11189c1089da ("acpi/nfit: Fix command-supported detection")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/r/20200225161927.hvftuq7kjn547fyj@kili.mountain
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 10 ++++++----
 drivers/acpi/nfit/nfit.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 14e68f202f810..12d980aafc5ff 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -360,7 +360,7 @@ static union acpi_object *acpi_label_info(acpi_handle handle)
 
 static u8 nfit_dsm_revid(unsigned family, unsigned func)
 {
-	static const u8 revid_table[NVDIMM_FAMILY_MAX+1][32] = {
+	static const u8 revid_table[NVDIMM_FAMILY_MAX+1][NVDIMM_CMD_MAX+1] = {
 		[NVDIMM_FAMILY_INTEL] = {
 			[NVDIMM_INTEL_GET_MODES] = 2,
 			[NVDIMM_INTEL_GET_FWINFO] = 2,
@@ -386,7 +386,7 @@ static u8 nfit_dsm_revid(unsigned family, unsigned func)
 
 	if (family > NVDIMM_FAMILY_MAX)
 		return 0;
-	if (func > 31)
+	if (func > NVDIMM_CMD_MAX)
 		return 0;
 	id = revid_table[family][func];
 	if (id == 0)
@@ -492,7 +492,8 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	 * Check for a valid command.  For ND_CMD_CALL, we also have to
 	 * make sure that the DSM function is supported.
 	 */
-	if (cmd == ND_CMD_CALL && !test_bit(func, &dsm_mask))
+	if (cmd == ND_CMD_CALL &&
+	    (func > NVDIMM_CMD_MAX || !test_bit(func, &dsm_mask)))
 		return -ENOTTY;
 	else if (!test_bit(cmd, &cmd_mask))
 		return -ENOTTY;
@@ -3499,7 +3500,8 @@ static int acpi_nfit_clear_to_send(struct nvdimm_bus_descriptor *nd_desc,
 	if (nvdimm && cmd == ND_CMD_CALL &&
 			call_pkg->nd_family == NVDIMM_FAMILY_INTEL) {
 		func = call_pkg->nd_command;
-		if ((1 << func) & NVDIMM_INTEL_SECURITY_CMDMASK)
+		if (func > NVDIMM_CMD_MAX ||
+		    (1 << func) & NVDIMM_INTEL_SECURITY_CMDMASK)
 			return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 24241941181ce..b317f4043705f 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -34,6 +34,7 @@
 		| ACPI_NFIT_MEM_NOT_ARMED | ACPI_NFIT_MEM_MAP_FAILED)
 
 #define NVDIMM_FAMILY_MAX NVDIMM_FAMILY_HYPERV
+#define NVDIMM_CMD_MAX 31
 
 #define NVDIMM_STANDARD_CMDMASK \
 (1 << ND_CMD_SMART | 1 << ND_CMD_SMART_THRESHOLD | 1 << ND_CMD_DIMM_FLAGS \
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
