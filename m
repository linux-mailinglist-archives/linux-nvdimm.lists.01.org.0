Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B194DF598
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Oct 2019 21:04:27 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 24B0F10077F82;
	Mon, 21 Oct 2019 12:04:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 01AC91007B505
	for <linux-nvdimm@lists.01.org>; Mon, 21 Oct 2019 09:45:22 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 09:43:38 -0700
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200";
   d="scan'208";a="187595740"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 09:43:38 -0700
Subject: [PATCH v2] fs/dax: Fix pmd vs pte conflict detection
From: Dan Williams <dan.j.williams@intel.com>
To: linux-fsdevel@vger.kernel.org
Date: Mon, 21 Oct 2019 09:29:20 -0700
Message-ID: <157167532455.3945484.11971474077040503994.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: 6ZKYIYRDIHA6BX6QAYBI5Z2L2GBLS7PK
X-Message-ID-Hash: 6ZKYIYRDIHA6BX6QAYBI5Z2L2GBLS7PK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jeff Smits <jeff.smits@intel.com>, Doug Nelson <doug.nelson@intel.com>, stable@vger.kernel.org, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6ZKYIYRDIHA6BX6QAYBI5Z2L2GBLS7PK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Users reported a v5.3 performance regression and inability to establish
huge page mappings. A revised version of the ndctl "dax.sh" huge page
unit test identifies commit 23c84eb78375 "dax: Fix missed wakeup with
PMD faults" as the source.

Update get_unlocked_entry() to check for NULL entries before checking
the entry order, otherwise NULL is misinterpreted as a present pte
conflict. The 'order' check needs to happen before the locked check as
an unlocked entry at the wrong order must fallback to lookup the correct
order.

Reported-by: Jeff Smits <jeff.smits@intel.com>
Reported-by: Doug Nelson <doug.nelson@intel.com>
Cc: <stable@vger.kernel.org>
Fixes: 23c84eb78375 ("dax: Fix missed wakeup with PMD faults")
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes in v2:
- Update the changelog to reflect the user visible effects of the bug
  (Jeff)

 fs/dax.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6bf81f931de3..2cc43cd914eb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -220,10 +220,11 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
 
 	for (;;) {
 		entry = xas_find_conflict(xas);
+		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
+			return entry;
 		if (dax_entry_order(entry) < order)
 			return XA_RETRY_ENTRY;
-		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)) ||
-				!dax_is_locked(entry))
+		if (!dax_is_locked(entry))
 			return entry;
 
 		wq = dax_entry_waitqueue(xas, entry, &ewait.key);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
