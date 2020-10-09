Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5EC2893D6
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Oct 2020 21:53:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5549C159C2207;
	Fri,  9 Oct 2020 12:53:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7A460159C2205
	for <linux-nvdimm@lists.01.org>; Fri,  9 Oct 2020 12:53:19 -0700 (PDT)
IronPort-SDR: m2ZYsmViilLLufvZuPi2GQq2RthTv0W4llQKlDC5TYjEkn+BYd/3XNl8vIEZe+AggSbnI26NkY
 R4CJMfe5pKiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="229715321"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="229715321"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:53:19 -0700
IronPort-SDR: W4xxziDMxkncUnjnfmhtERgTle+fDEBI/syTBEG/tlt++YK2v+9/w8FvvM36z1FzCpPIzrEgyR
 3zBS2pDk0hzg==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="354959339"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:53:18 -0700
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC PKS/PMEM 42/58] drivers/scsi: Utilize new kmap_thread()
Date: Fri,  9 Oct 2020 12:50:17 -0700
Message-Id: <20201009195033.3208459-43-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 4EKARUJXVCS4AVIXB37OLK4MF4XM5EG4
X-Message-ID-Hash: 4EKARUJXVCS4AVIXB37OLK4MF4XM5EG4
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, kexec@lists.infradead.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org, linux-efi@vger.kernel.org, linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-um@lists.infradead.org, linux-ntfs-dev@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org, cluster-devel@redhat.com, ecryptf
 s@vger.kernel.org, linux-cifs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, xen-devel@lists.xenproject.org, linux-cachefs@redhat.com, samba-technical@lists.samba.org, intel-wired-lan@lists.osuosl.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4EKARUJXVCS4AVIXB37OLK4MF4XM5EG4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

These kmap() calls are localized to a single thread.  To avoid the over
head of global PKRS updates use the new kmap_thread() call.

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/scsi/ipr.c     | 8 ++++----
 drivers/scsi/pmcraid.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index b0aa58d117cc..a5a0b8feb661 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -3923,9 +3923,9 @@ static int ipr_copy_ucode_buffer(struct ipr_sglist *sglist,
 			buffer += bsize_elem) {
 		struct page *page = sg_page(sg);
 
-		kaddr = kmap(page);
+		kaddr = kmap_thread(page);
 		memcpy(kaddr, buffer, bsize_elem);
-		kunmap(page);
+		kunmap_thread(page);
 
 		sg->length = bsize_elem;
 
@@ -3938,9 +3938,9 @@ static int ipr_copy_ucode_buffer(struct ipr_sglist *sglist,
 	if (len % bsize_elem) {
 		struct page *page = sg_page(sg);
 
-		kaddr = kmap(page);
+		kaddr = kmap_thread(page);
 		memcpy(kaddr, buffer, len % bsize_elem);
-		kunmap(page);
+		kunmap_thread(page);
 
 		sg->length = len % bsize_elem;
 	}
diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index aa9ae2ae8579..4b05ba4b8a11 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -3269,13 +3269,13 @@ static int pmcraid_copy_sglist(
 	for (i = 0; i < (len / bsize_elem); i++, sg = sg_next(sg), buffer += bsize_elem) {
 		struct page *page = sg_page(sg);
 
-		kaddr = kmap(page);
+		kaddr = kmap_thread(page);
 		if (direction == DMA_TO_DEVICE)
 			rc = copy_from_user(kaddr, buffer, bsize_elem);
 		else
 			rc = copy_to_user(buffer, kaddr, bsize_elem);
 
-		kunmap(page);
+		kunmap_thread(page);
 
 		if (rc) {
 			pmcraid_err("failed to copy user data into sg list\n");
@@ -3288,14 +3288,14 @@ static int pmcraid_copy_sglist(
 	if (len % bsize_elem) {
 		struct page *page = sg_page(sg);
 
-		kaddr = kmap(page);
+		kaddr = kmap_thread(page);
 
 		if (direction == DMA_TO_DEVICE)
 			rc = copy_from_user(kaddr, buffer, len % bsize_elem);
 		else
 			rc = copy_to_user(buffer, kaddr, len % bsize_elem);
 
-		kunmap(page);
+		kunmap_thread(page);
 
 		sg->length = len % bsize_elem;
 	}
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
