Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4413692B3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Apr 2021 15:07:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7E18C100EAAEE;
	Fri, 23 Apr 2021 06:07:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2FEED100EAAE8
	for <linux-nvdimm@lists.01.org>; Fri, 23 Apr 2021 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619183273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTA/WZ0fubKgiuLZMkyv2Dw6Jo7MxejhgE42RBMW76E=;
	b=aYR0pQZQ8nq3gVLG9BGPmc1QKDhRDGJQo5c2oFM5TyCXDhURRMeaQsLYjYZ3+npyR+5MxX
	O27tUKriOUHWOCwMwagg7aEfq3e1X66ULzI7drNqbe5tr3atwMUGmlayYb4x+bSGStOFOM
	LEiaqMq+xoW6d2B/Z911X/+GgUq0/J0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-bqmKJPGyPCSURhppUUTeSA-1; Fri, 23 Apr 2021 09:07:49 -0400
X-MC-Unique: bqmKJPGyPCSURhppUUTeSA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18BA58026AD;
	Fri, 23 Apr 2021 13:07:48 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-86.rdu2.redhat.com [10.10.115.86])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 123E95C3E5;
	Fri, 23 Apr 2021 13:07:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 9DC16223D98; Fri, 23 Apr 2021 09:07:37 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com
Subject: [PATCH v4 1/3] dax: Add an enum for specifying dax wakup mode
Date: Fri, 23 Apr 2021 09:07:21 -0400
Message-Id: <20210423130723.1673919-2-vgoyal@redhat.com>
In-Reply-To: <20210423130723.1673919-1-vgoyal@redhat.com>
References: <20210423130723.1673919-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: TYSBPUAS5F27VTVT2LKEA3CULQBPJIRC
X-Message-ID-Hash: TYSBPUAS5F27VTVT2LKEA3CULQBPJIRC
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, virtio-fs@redhat.com, miklos@szeredi.hu, jack@suse.cz, willy@infradead.org, slp@redhat.com, groug@kaod.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TYSBPUAS5F27VTVT2LKEA3CULQBPJIRC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan mentioned that he is not very fond of passing around a boolean true/false
to specify if only next waiter should be woken up or all waiters should be
woken up. He instead prefers that we introduce an enum and make it very
explicity at the callsite itself. Easier to read code.

This patch should not introduce any change of behavior.

Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index b3d27fdc6775..4b1918b9ad97 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -144,6 +144,16 @@ struct wait_exceptional_entry_queue {
 	struct exceptional_entry_key key;
 };
 
+/**
+ * enum dax_wake_mode: waitqueue wakeup behaviour
+ * @WAKE_NEXT: wake only the first waiter in the waitqueue
+ * @WAKE_ALL: wake all waiters in the waitqueue
+ */
+enum dax_wake_mode {
+	WAKE_NEXT,
+	WAKE_ALL,
+};
+
 static wait_queue_head_t *dax_entry_waitqueue(struct xa_state *xas,
 		void *entry, struct exceptional_entry_key *key)
 {
@@ -182,7 +192,8 @@ static int wake_exceptional_entry_func(wait_queue_entry_t *wait,
  * The important information it's conveying is whether the entry at
  * this index used to be a PMD entry.
  */
-static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
+static void dax_wake_entry(struct xa_state *xas, void *entry,
+			   enum dax_wake_mode mode)
 {
 	struct exceptional_entry_key key;
 	wait_queue_head_t *wq;
@@ -196,7 +207,7 @@ static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
 	 * must be in the waitqueue and the following check will see them.
 	 */
 	if (waitqueue_active(wq))
-		__wake_up(wq, TASK_NORMAL, wake_all ? 0 : 1, &key);
+		__wake_up(wq, TASK_NORMAL, mode == WAKE_ALL ? 0 : 1, &key);
 }
 
 /*
@@ -268,7 +279,7 @@ static void put_unlocked_entry(struct xa_state *xas, void *entry)
 {
 	/* If we were the only waiter woken, wake the next one */
 	if (entry && !dax_is_conflict(entry))
-		dax_wake_entry(xas, entry, false);
+		dax_wake_entry(xas, entry, WAKE_NEXT);
 }
 
 /*
@@ -286,7 +297,7 @@ static void dax_unlock_entry(struct xa_state *xas, void *entry)
 	old = xas_store(xas, entry);
 	xas_unlock_irq(xas);
 	BUG_ON(!dax_is_locked(old));
-	dax_wake_entry(xas, entry, false);
+	dax_wake_entry(xas, entry, WAKE_NEXT);
 }
 
 /*
@@ -524,7 +535,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 
 		dax_disassociate_entry(entry, mapping, false);
 		xas_store(xas, NULL);	/* undo the PMD join */
-		dax_wake_entry(xas, entry, true);
+		dax_wake_entry(xas, entry, WAKE_ALL);
 		mapping->nrexceptional--;
 		entry = NULL;
 		xas_set(xas, index);
@@ -937,7 +948,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	xas_lock_irq(xas);
 	xas_store(xas, entry);
 	xas_clear_mark(xas, PAGECACHE_TAG_DIRTY);
-	dax_wake_entry(xas, entry, false);
+	dax_wake_entry(xas, entry, WAKE_NEXT);
 
 	trace_dax_writeback_one(mapping->host, index, count);
 	return ret;
-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
