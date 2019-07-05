Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD03F6076C
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jul 2019 16:09:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AF2DE212B2055;
	Fri,  5 Jul 2019 07:09:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0F7FC212AD583
 for <linux-nvdimm@lists.01.org>; Fri,  5 Jul 2019 07:09:37 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61E4A30C5859;
 Fri,  5 Jul 2019 14:09:21 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-58.sin2.redhat.com
 [10.67.116.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D98318657;
 Fri,  5 Jul 2019 14:08:42 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
To: dm-devel@redhat.com, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-acpi@vger.kernel.org, qemu-devel@nongnu.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v15 5/7] dax: check synchronous mapping is supported
Date: Fri,  5 Jul 2019 19:33:26 +0530
Message-Id: <20190705140328.20190-6-pagupta@redhat.com>
In-Reply-To: <20190705140328.20190-1-pagupta@redhat.com>
References: <20190705140328.20190-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 05 Jul 2019 14:09:36 +0000 (UTC)
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
Cc: rdunlap@infradead.org, jack@suse.cz, snitzer@redhat.com, mst@redhat.com,
 jasowang@redhat.com, david@fromorbit.com, lcapitulino@redhat.com,
 adilger.kernel@dilger.ca, zwisler@kernel.org, aarcange@redhat.com,
 jstaron@google.com, darrick.wong@oracle.com, david@redhat.com,
 willy@infradead.org, hch@infradead.org, nilal@redhat.com, lenb@kernel.org,
 kilobyte@angband.pl, riel@surriel.com, yuval.shaia@oracle.com,
 stefanha@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, tytso@mit.edu,
 xiaoguangrong.eric@gmail.com, cohuck@redhat.com, rjw@rjwysocki.net,
 imammedo@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

This patch introduces 'daxdev_mapping_supported' helper
which checks if 'MAP_SYNC' is supported with filesystem
mapping. It also checks if corresponding dax_device is
synchronous. Virtio pmem device is asynchronous and
does not not support VM_SYNC.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/linux/dax.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index 86fc55c99b58..d1bea3979b5a 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -53,6 +53,18 @@ static inline void set_dax_synchronous(struct dax_device *dax_dev)
 {
 	__set_dax_synchronous(dax_dev);
 }
+/*
+ * Check if given mapping is supported by the file / underlying device.
+ */
+static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
+					     struct dax_device *dax_dev)
+{
+	if (!(vma->vm_flags & VM_SYNC))
+		return true;
+	if (!IS_DAX(file_inode(vma->vm_file)))
+		return false;
+	return dax_synchronous(dax_dev);
+}
 #else
 static inline struct dax_device *dax_get_by_host(const char *host)
 {
@@ -87,6 +99,11 @@ static inline bool dax_synchronous(struct dax_device *dax_dev)
 static inline void set_dax_synchronous(struct dax_device *dax_dev)
 {
 }
+static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
+				struct dax_device *dax_dev)
+{
+	return !(vma->vm_flags & VM_SYNC);
+}
 #endif
 
 struct writeback_control;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
