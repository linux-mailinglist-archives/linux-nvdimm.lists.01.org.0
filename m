Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAA136F8F
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Jun 2019 11:10:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 90E2A21290D49;
	Thu,  6 Jun 2019 02:10:37 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 188622128DD50
 for <linux-nvdimm@lists.01.org>; Thu,  6 Jun 2019 02:10:35 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E298CAF90;
 Thu,  6 Jun 2019 09:10:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 564401E3F51; Thu,  6 Jun 2019 11:10:33 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] dax: Fix xarray entry association for mixed mappings
Date: Thu,  6 Jun 2019 11:10:28 +0200
Message-Id: <20190606091028.31715-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
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
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-nvdimm@lists.01.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

When inserting entry into xarray, we store mapping and index in
corresponding struct pages for memory error handling. When it happened
that one process was mapping file at PMD granularity while another
process at PTE granularity, we could wrongly deassociate PMD range and
then reassociate PTE range leaving the rest of struct pages in PMD range
without mapping information which could later cause missed notifications
about memory errors. Fix the problem by calling the association /
deassociation code if and only if we are really going to update the
xarray (deassociating and associating zero or empty entries is just
no-op so there's no reason to complicate the code with trying to avoid
the calls for these cases).

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/dax.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index f74386293632..9fd908f3df32 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -728,12 +728,11 @@ static void *dax_insert_entry(struct xa_state *xas,
 
 	xas_reset(xas);
 	xas_lock_irq(xas);
-	if (dax_entry_size(entry) != dax_entry_size(new_entry)) {
+	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
+		void *old;
+
 		dax_disassociate_entry(entry, mapping, false);
 		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
-	}
-
-	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -742,7 +741,7 @@ static void *dax_insert_entry(struct xa_state *xas,
 		 * existing entry is a PMD, we will just leave the PMD in the
 		 * tree and dirty it if necessary.
 		 */
-		void *old = dax_lock_entry(xas, new_entry);
+		old = dax_lock_entry(xas, new_entry);
 		WARN_ON_ONCE(old != xa_mk_value(xa_to_value(entry) |
 					DAX_LOCKED));
 		entry = new_entry;
-- 
2.16.4

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
