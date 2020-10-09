Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCDF28941A
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Oct 2020 21:53:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E3CF0159C220F;
	Fri,  9 Oct 2020 12:53:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A43D8159C220F
	for <linux-nvdimm@lists.01.org>; Fri,  9 Oct 2020 12:53:35 -0700 (PDT)
IronPort-SDR: VvjpFlJI2iKDLyljHUhJfZW7aJ19UFzi9Ygr1rFjcpeyofUsMJsSTI0Wg8nQGbTSgkSxX/LvnY
 aqZ4ht7IFFIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="162893632"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="162893632"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:53:35 -0700
IronPort-SDR: 1BDjhBWRiZHjmax0H5jHPL9Ee2R7VPzFxt4XNyUZ5d5LafdvLgy40B0wtQFVU3AX2TCQgDyRso
 HhmDRI33qIDA==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="345148602"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:53:34 -0700
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC PKS/PMEM 47/58] drivers/mtd: Utilize new kmap_thread()
Date: Fri,  9 Oct 2020 12:50:22 -0700
Message-Id: <20201009195033.3208459-48-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: O36HBSOHOGI4VPHOZPDAFGHS34U74CQW
X-Message-ID-Hash: O36HBSOHOGI4VPHOZPDAFGHS34U74CQW
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, kexec@lists.infradead.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org, linux-efi@vger.kernel.org, linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-um@lists.infradead.org, linux-ntfs-dev@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourc
 eforge.net, linux-nilfs@vger.kernel.org, cluster-devel@redhat.com, ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, xen-devel@lists.xenproject.org, linux-cachefs@redhat.com, samba-technical@lists.samba.org, intel-wired-lan@lists.osuosl.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O36HBSOHOGI4VPHOZPDAFGHS34U74CQW/>
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

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/mtd/mtd_blkdevs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 0c05f77f9b21..4b18998273fa 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -88,14 +88,14 @@ static blk_status_t do_blktrans_request(struct mtd_blktrans_ops *tr,
 			return BLK_STS_IOERR;
 		return BLK_STS_OK;
 	case REQ_OP_READ:
-		buf = kmap(bio_page(req->bio)) + bio_offset(req->bio);
+		buf = kmap_thread(bio_page(req->bio)) + bio_offset(req->bio);
 		for (; nsect > 0; nsect--, block++, buf += tr->blksize) {
 			if (tr->readsect(dev, block, buf)) {
-				kunmap(bio_page(req->bio));
+				kunmap_thread(bio_page(req->bio));
 				return BLK_STS_IOERR;
 			}
 		}
-		kunmap(bio_page(req->bio));
+		kunmap_thread(bio_page(req->bio));
 		rq_flush_dcache_pages(req);
 		return BLK_STS_OK;
 	case REQ_OP_WRITE:
@@ -103,14 +103,14 @@ static blk_status_t do_blktrans_request(struct mtd_blktrans_ops *tr,
 			return BLK_STS_IOERR;
 
 		rq_flush_dcache_pages(req);
-		buf = kmap(bio_page(req->bio)) + bio_offset(req->bio);
+		buf = kmap_thread(bio_page(req->bio)) + bio_offset(req->bio);
 		for (; nsect > 0; nsect--, block++, buf += tr->blksize) {
 			if (tr->writesect(dev, block, buf)) {
-				kunmap(bio_page(req->bio));
+				kunmap_thread(bio_page(req->bio));
 				return BLK_STS_IOERR;
 			}
 		}
-		kunmap(bio_page(req->bio));
+		kunmap_thread(bio_page(req->bio));
 		return BLK_STS_OK;
 	default:
 		return BLK_STS_IOERR;
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
