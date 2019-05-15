Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CF71FA7E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 21:27:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A2664212794D3;
	Wed, 15 May 2019 12:27:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 337A421D0DE61
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 12:27:34 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B327E3001A77;
 Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F3DF19C71;
 Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id E5707225488; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: [PATCH v2 20/30] fuse: Introduce setupmapping/removemapping commands
Date: Wed, 15 May 2019 15:27:05 -0400
Message-Id: <20190515192715.18000-21-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 15 May 2019 19:27:33 +0000 (UTC)
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
Cc: swhiteho@redhat.com, dgilbert@redhat.com, stefanha@redhat.com,
 miklos@szeredi.hu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Introduce two new fuse commands to setup/remove memory mappings. This
will be used to setup/tear down file mapping in dax window.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 include/uapi/linux/fuse.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2ac598614a8f..9eb313220549 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -399,6 +399,8 @@ enum fuse_opcode {
 	FUSE_RENAME2		= 45,
 	FUSE_LSEEK		= 46,
 	FUSE_COPY_FILE_RANGE	= 47,
+	FUSE_SETUPMAPPING       = 48,
+	FUSE_REMOVEMAPPING      = 49,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -822,4 +824,35 @@ struct fuse_copy_file_range_in {
 	uint64_t	flags;
 };
 
+#define FUSE_SETUPMAPPING_ENTRIES 8
+#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
+struct fuse_setupmapping_in {
+	/* An already open handle */
+	uint64_t	fh;
+	/* Offset into the file to start the mapping */
+	uint64_t	foffset;
+	/* Length of mapping required */
+	uint64_t	len;
+	/* Flags, FUSE_SETUPMAPPING_FLAG_* */
+	uint64_t	flags;
+	/* Offset in Memory Window */
+	uint64_t	moffset;
+};
+
+struct fuse_setupmapping_out {
+	/* Offsets into the cache of mappings */
+	uint64_t	coffset[FUSE_SETUPMAPPING_ENTRIES];
+        /* Lengths of each mapping */
+        uint64_t	len[FUSE_SETUPMAPPING_ENTRIES];
+};
+
+struct fuse_removemapping_in {
+        /* An already open handle */
+        uint64_t	fh;
+	/* Offset into the dax window start the unmapping */
+	uint64_t        moffset;
+        /* Length of mapping required */
+        uint64_t	len;
+};
+
 #endif /* _LINUX_FUSE_H */
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
