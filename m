Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9411795EA
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 17:59:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 136AA10FC3773;
	Wed,  4 Mar 2020 09:00:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7F3CB10FC36D0
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 09:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583341157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BDyna82gOULpd6exk200NRUKeqMshv908IMcsDkgfcs=;
	b=WGDktcE6ApXdD+PsZy0xtkI/tTQuPVN9UMxS1+WP0xfe0aAC4SrmpOWGd/pTun3c7dKNCW
	hcE8j7vraTjfjb4BrXiUBlNDlFuKr6dwLd8h1U1PCBPyePmQDtaev+LeRHvZqoG0vtXzs5
	7x7LYOKyJS82saa83/rPCgfSCdcjets=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-G7_KU9XAPJmSDI_OWHjqAA-1; Wed, 04 Mar 2020 11:59:13 -0500
X-MC-Unique: G7_KU9XAPJmSDI_OWHjqAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56BBA107ACCA;
	Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2FA4960C84;
	Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 8153F225816; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	virtio-fs@redhat.com,
	miklos@szeredi.hu
Subject: [PATCH 16/20] fuse,virtiofs: Define dax address space operations
Date: Wed,  4 Mar 2020 11:58:41 -0500
Message-Id: <20200304165845.3081-17-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: 5IDF4YCX4AB7RNUZC3SJIMEGUR5LRHAW
X-Message-ID-Hash: 5IDF4YCX4AB7RNUZC3SJIMEGUR5LRHAW
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5IDF4YCX4AB7RNUZC3SJIMEGUR5LRHAW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is done along the lines of ext4 and xfs. I primarily wanted ->writepages
hook at this time so that I could call into dax_writeback_mapping_range().
This in turn will decide which pfns need to be written back.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ab56396cf661..619aff6b5f44 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2696,6 +2696,16 @@ static int fuse_writepages_fill(struct page *page,
 	return err;
 }
 
+static int fuse_dax_writepages(struct address_space *mapping,
+				struct writeback_control *wbc)
+{
+
+	struct inode *inode = mapping->host;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	return dax_writeback_mapping_range(mapping, fc->dax_dev, wbc);
+}
+
 static int fuse_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
@@ -4032,6 +4042,13 @@ static const struct address_space_operations fuse_file_aops  = {
 	.write_end	= fuse_write_end,
 };
 
+static const struct address_space_operations fuse_dax_file_aops  = {
+	.writepages	= fuse_dax_writepages,
+	.direct_IO	= noop_direct_IO,
+	.set_page_dirty	= noop_set_page_dirty,
+	.invalidatepage	= noop_invalidatepage,
+};
+
 void fuse_init_file_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
@@ -4049,5 +4066,6 @@ void fuse_init_file_inode(struct inode *inode)
 
 	if (fc->dax_dev) {
 		inode->i_flags |= S_DAX;
+		inode->i_data.a_ops = &fuse_dax_file_aops;
 	}
 }
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
