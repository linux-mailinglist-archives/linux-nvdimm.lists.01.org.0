Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAC11795EF
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 17:59:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BAFC810FC3778;
	Wed,  4 Mar 2020 09:00:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CEB0310FC36C7
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 09:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583341162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6pQ8jsfaduj841lJuAnYCAgbmehnOTdC6Bq+PWck1A=;
	b=GRxiGidzNo0K5ozehXWnphw2W3BEckGxccQ5TVgoE6oKVI7/rL8JUhmdvwsDhjd6vl7o2K
	bc0PaWPlzZ2ClD6GVK3wgSSQJnJu9whNQjFU+tyO36YEV3SG9mehsWupDOPhWtvDzXw7vX
	uKg2B/YkzfWvFS9Kla9VhravAhyRlU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-PZVYUYR1NCiIri0PTi6-tg-1; Wed, 04 Mar 2020 11:59:20 -0500
X-MC-Unique: PZVYUYR1NCiIri0PTi6-tg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58FF9800D5C;
	Wed,  4 Mar 2020 16:59:19 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 50DC619E9C;
	Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 8A0BE225818; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	virtio-fs@redhat.com,
	miklos@szeredi.hu
Subject: [PATCH 18/20] fuse: Release file in process context
Date: Wed,  4 Mar 2020 11:58:43 -0500
Message-Id: <20200304165845.3081-19-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: 7VWVVNH7WENOJAEL3Y642NJJ5KTCHQGV
X-Message-ID-Hash: 7VWVVNH7WENOJAEL3Y642NJJ5KTCHQGV
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7VWVVNH7WENOJAEL3Y642NJJ5KTCHQGV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

fuse_file_put(sync) can be called with sync=true/false. If sync=true,
it waits for release request response and then calls iput() in the
caller's context. If sync=false, it does not wait for release request
response, frees the fuse_file struct immediately and req->end function
does the iput().

iput() can be a problem with DAX if called in req->end context. If this
is last reference to inode (VFS has let go its reference already), then
iput() will clean DAX mappings as well and send REMOVEMAPPING requests
and wait for completion. (All the the worker thread context which is
processing fuse replies from daemon on the host).

That means it blocks worker thread and it stops processing further
replies and system deadlocks.

So for now, force sync release of file in case of DAX inodes.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index afabeb1acd50..561428b66101 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -543,6 +543,7 @@ void fuse_release_common(struct file *file, bool isdir)
 	struct fuse_file *ff = file->private_data;
 	struct fuse_release_args *ra = ff->release_args;
 	int opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
+	bool sync = false;
 
 	fuse_prepare_release(fi, ff, file->f_flags, opcode);
 
@@ -562,8 +563,19 @@ void fuse_release_common(struct file *file, bool isdir)
 	 * Make the release synchronous if this is a fuseblk mount,
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
+	 *
+	 * For DAX, fuse server is trusted. So it should be fine to
+	 * do a sync file put. Doing async file put is creating
+	 * problems right now because when request finish, iput()
+	 * can lead to freeing of inode. That means it tears down
+	 * mappings backing DAX memory and sends REMOVEMAPPING message
+	 * to server and blocks for completion. Currently, waiting
+	 * in req->end context deadlocks the system as same worker thread
+	 * can't process REMOVEMAPPING reply it is waiting for.
 	 */
-	fuse_file_put(ff, ff->fc->destroy, isdir);
+	if (IS_DAX(file_inode(file)) || ff->fc->destroy)
+		sync = true;
+	fuse_file_put(ff, sync, isdir);
 }
 
 static int fuse_open(struct inode *inode, struct file *file)
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
