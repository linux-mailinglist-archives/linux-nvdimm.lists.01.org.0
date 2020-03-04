Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1681795E5
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 17:59:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 23CDE10FC36F8;
	Wed,  4 Mar 2020 09:00:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D8E2010FC36D1
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 09:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583341155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBFU8IIvnGbLA1VTtFFHfhcbNjvcmVFEe+Go+jm56Gc=;
	b=KoWzMtbIYiOE2taaRDHf48EzvTU37Azub6aIWTpNdtHyw/7YDhZHZeSuCSKeuC1tTQ5LCN
	jgjRSpRGShsRyDcODXWFsn0aJtQf72E5606gKbh6AVEM+jDA/uJ1ViZZ2I0JPCrZT533Hg
	AYS/WCGOm7XRb26YXuyw15/4TtFpthY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-ul4BurxFNO22LBVyUIglCg-1; Wed, 04 Mar 2020 11:59:13 -0500
X-MC-Unique: ul4BurxFNO22LBVyUIglCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EDDC800D55;
	Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4C46A5C1D4;
	Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 8F8E9225819; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	virtio-fs@redhat.com,
	miklos@szeredi.hu
Subject: [PATCH 19/20] fuse: Take inode lock for dax inode truncation
Date: Wed,  4 Mar 2020 11:58:44 -0500
Message-Id: <20200304165845.3081-20-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: 23J2HIW3LJWWPA5OVHZ5USG32IFSJOT3
X-Message-ID-Hash: 23J2HIW3LJWWPA5OVHZ5USG32IFSJOT3
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/23J2HIW3LJWWPA5OVHZ5USG32IFSJOT3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When a file is opened with O_TRUNC, we need to make sure that any other
DAX operation is not in progress. DAX expects i_size to be stable.

In fuse_iomap_begin() we check for i_size at multiple places and we expect
i_size to not change.

Another problem is, if we setup a mapping in fuse_iomap_begin(), and
file gets truncated and dax read/write happens, KVM currently hangs.
It tries to fault in a page which does not exist on host (file got
truncated). It probably requries fixing in KVM.

So for now, take inode lock. Once KVM is fixed, we might have to
have a look at it again.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 561428b66101..8b264fcb9b3c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -483,7 +483,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	int err;
 	bool is_wb_truncate = (file->f_flags & O_TRUNC) &&
 			  fc->atomic_o_trunc &&
-			  fc->writeback_cache;
+			  (fc->writeback_cache || IS_DAX(inode));
 
 	err = generic_file_open(inode, file);
 	if (err)
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
