Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE57131748
	for <lists+linux-nvdimm@lfdr.de>; Mon,  6 Jan 2020 19:11:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 44FD310097DE8;
	Mon,  6 Jan 2020 10:14:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BB60310097F38
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jan 2020 10:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1578334284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=CRysVtjZRGC/Wj52fo19nEafOFpuDwYw8PVTvgf5qKY=;
	b=VYkOp/zJEgUYY5dTpJ0qLctnQ90oC4VcEbWmBUGK3+KwQYEgUk4TOG7tLHnRUIY63HfnHd
	CCeQu26pxtVHGdkN9yhSLxOTNTFY2NSAF2PX87XZTLLQmNXOerNEK9sJR2c4+kv6Y0YBdR
	NqYHitmotmNjk31V4kZKjSqWZu6NfC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-6eHQhMmfNfywzX5U9a-rPg-1; Mon, 06 Jan 2020 13:11:19 -0500
X-MC-Unique: 6eHQhMmfNfywzX5U9a-rPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3417F18557E5;
	Mon,  6 Jan 2020 18:11:18 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0F3907C3A3;
	Mon,  6 Jan 2020 18:11:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 8F2312202E9; Mon,  6 Jan 2020 13:11:17 -0500 (EST)
Date: Mon, 6 Jan 2020 13:11:17 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: dax: Get rid of fs_dax_get_by_host() helper
Message-ID: <20200106181117.GA16248@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: VHIBWSCWYTZ3QRSAINJPHGJWCM7EP3QI
X-Message-ID-Hash: VHIBWSCWYTZ3QRSAINJPHGJWCM7EP3QI
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VHIBWSCWYTZ3QRSAINJPHGJWCM7EP3QI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Looks like nobody is using fs_dax_get_by_host() except fs_dax_get_by_bdev()
and it can easily use dax_get_by_host() instead.

IIUC, fs_dax_get_by_host() was only introduced so that one could compile
with CONFIG_FS_DAX=n and CONFIG_DAX=m. fs_dax_get_by_bdev() achieves
the same purpose and hence it looks like fs_dax_get_by_host() is not
needed anymore.
 
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/dax/super.c |    2 +-
 include/linux/dax.h |   10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

Index: rhvgoyal-linux-fuse/drivers/dax/super.c
===================================================================
--- rhvgoyal-linux-fuse.orig/drivers/dax/super.c	2020-01-03 11:19:57.616186062 -0500
+++ rhvgoyal-linux-fuse/drivers/dax/super.c	2020-01-03 11:20:08.941186062 -0500
@@ -61,7 +61,7 @@ struct dax_device *fs_dax_get_by_bdev(st
 {
 	if (!blk_queue_dax(bdev->bd_queue))
 		return NULL;
-	return fs_dax_get_by_host(bdev->bd_disk->disk_name);
+	return dax_get_by_host(bdev->bd_disk->disk_name);
 }
 EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
 #endif
Index: rhvgoyal-linux-fuse/include/linux/dax.h
===================================================================
--- rhvgoyal-linux-fuse.orig/include/linux/dax.h	2020-01-03 11:20:05.603186062 -0500
+++ rhvgoyal-linux-fuse/include/linux/dax.h	2020-01-03 11:20:08.942186062 -0500
@@ -129,11 +129,6 @@ static inline bool generic_fsdax_support
 			sectors);
 }
 
-static inline struct dax_device *fs_dax_get_by_host(const char *host)
-{
-	return dax_get_by_host(host);
-}
-
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
 	put_dax(dax_dev);
@@ -160,11 +155,6 @@ static inline bool generic_fsdax_support
 	return false;
 }
 
-static inline struct dax_device *fs_dax_get_by_host(const char *host)
-{
-	return NULL;
-}
-
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
 }
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
