Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 666AD364D29
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 23:39:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56E7C100EB323;
	Mon, 19 Apr 2021 14:39:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A8846100EB856
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 14:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618868344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IC12KDzjvoUKJ+dNEG7qWjewHh2vR3rSNthHIJpJXfg=;
	b=Zt+nyaL6bnrUPkgCzBnlF2FEkFy82VzG8tKeYGBkfmitTT7PhpYo7GmUGV/dnphe5FWlOi
	t9oH4QQnMceHV4U7J8xVyYM0FmJB9xWlMzH7Z3r4KOA2oc7bfyoZzB4/FGEXMuNne/itrW
	Ym0YqA+4hi3oewrqkKUFrnwEcoRCG1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-kTXYu0NXNue_LfhajHIQlA-1; Mon, 19 Apr 2021 17:39:00 -0400
X-MC-Unique: kTXYu0NXNue_LfhajHIQlA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A48FE19251A0;
	Mon, 19 Apr 2021 21:38:59 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-35.rdu2.redhat.com [10.10.116.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0F69019744;
	Mon, 19 Apr 2021 21:38:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 98C1B223D99; Mon, 19 Apr 2021 17:38:52 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	dan.j.williams@intel.com,
	jack@suse.cz,
	willy@infradead.org
Subject: [PATCH v3 2/3] dax: Add a wakeup mode parameter to put_unlocked_entry()
Date: Mon, 19 Apr 2021 17:36:35 -0400
Message-Id: <20210419213636.1514816-3-vgoyal@redhat.com>
In-Reply-To: <20210419213636.1514816-1-vgoyal@redhat.com>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: U6DQNSW752NOSB2PFAHOHV7566IXV6CF
X-Message-ID-Hash: U6DQNSW752NOSB2PFAHOHV7566IXV6CF
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: virtio-fs@redhat.com, slp@redhat.com, miklos@szeredi.hu, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U6DQNSW752NOSB2PFAHOHV7566IXV6CF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

As of now put_unlocked_entry() always wakes up next waiter. In next
patches we want to wake up all waiters at one callsite. Hence, add a
parameter to the function.

This patch does not introduce any change of behavior.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 00978d0838b1..f19d76a6a493 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -275,11 +275,12 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
 	finish_wait(wq, &ewait.wait);
 }
 
-static void put_unlocked_entry(struct xa_state *xas, void *entry)
+static void put_unlocked_entry(struct xa_state *xas, void *entry,
+			       enum dax_entry_wake_mode mode)
 {
 	/* If we were the only waiter woken, wake the next one */
 	if (entry && !dax_is_conflict(entry))
-		dax_wake_entry(xas, entry, WAKE_NEXT);
+		dax_wake_entry(xas, entry, mode);
 }
 
 /*
@@ -633,7 +634,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 			entry = get_unlocked_entry(&xas, 0);
 		if (entry)
 			page = dax_busy_page(entry);
-		put_unlocked_entry(&xas, entry);
+		put_unlocked_entry(&xas, entry, WAKE_NEXT);
 		if (page)
 			break;
 		if (++scanned % XA_CHECK_SCHED)
@@ -675,7 +676,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	mapping->nrexceptional--;
 	ret = 1;
 out:
-	put_unlocked_entry(&xas, entry);
+	put_unlocked_entry(&xas, entry, WAKE_NEXT);
 	xas_unlock_irq(&xas);
 	return ret;
 }
@@ -954,7 +955,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	return ret;
 
  put_unlocked:
-	put_unlocked_entry(xas, entry);
+	put_unlocked_entry(xas, entry, WAKE_NEXT);
 	return ret;
 }
 
@@ -1695,7 +1696,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	/* Did we race with someone splitting entry or so? */
 	if (!entry || dax_is_conflict(entry) ||
 	    (order == 0 && !dax_is_pte_entry(entry))) {
-		put_unlocked_entry(&xas, entry);
+		put_unlocked_entry(&xas, entry, WAKE_NEXT);
 		xas_unlock_irq(&xas);
 		trace_dax_insert_pfn_mkwrite_no_entry(mapping->host, vmf,
 						      VM_FAULT_NOPAGE);
-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
