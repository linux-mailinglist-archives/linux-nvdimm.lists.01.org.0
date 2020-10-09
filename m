Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D0C2892E0
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Oct 2020 21:51:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 07EDF1594D2EB;
	Fri,  9 Oct 2020 12:51:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 32AC31594D2E7
	for <linux-nvdimm@lists.01.org>; Fri,  9 Oct 2020 12:51:45 -0700 (PDT)
IronPort-SDR: CsZlrLa9BPZoS4ouJgcOqvqfzM4ouq/IA7sLie1Ba2K/cgt/FCnDC5rIbPWnzFs4ztb9T4douw
 VO/aihNaTeJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="227178873"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="227178873"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:51:44 -0700
IronPort-SDR: /XLKsCzQipLZYQ1rW+ETY2grttZNamy0/VnWHXeIGpFKMMZaq8ytLhObxugEuPiPsSx/1cqrId
 IdubLVsw8k0A==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="419536913"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:51:44 -0700
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC PKS/PMEM 16/58] fs/gfs2: Utilize new kmap_thread()
Date: Fri,  9 Oct 2020 12:49:51 -0700
Message-Id: <20201009195033.3208459-17-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: SCD7MNGQAI6OGSHDNQZHSRUWQ224PY7Y
X-Message-ID-Hash: SCD7MNGQAI6OGSHDNQZHSRUWQ224PY7Y
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Bob Peterson <rpeterso@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, kexec@lists.infradead.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org, linux-efi@vger.kernel.org, linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-um@lists.infradead.org, linux-ntfs-dev@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
  cluster-devel@redhat.com, ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, xen-devel@lists.xenproject.org, linux-cachefs@redhat.com, samba-technical@lists.samba.org, intel-wired-lan@lists.osuosl.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SCD7MNGQAI6OGSHDNQZHSRUWQ224PY7Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

The kmap() calls in this FS are localized to a single thread.  To avoid
the over head of global PKRS updates use the new kmap_thread() call.

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/gfs2/bmap.c       | 4 ++--
 fs/gfs2/ops_fstype.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 0f69fbd4af66..375af4528411 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -67,7 +67,7 @@ static int gfs2_unstuffer_page(struct gfs2_inode *ip, struct buffer_head *dibh,
 	}
 
 	if (!PageUptodate(page)) {
-		void *kaddr = kmap(page);
+		void *kaddr = kmap_thread(page);
 		u64 dsize = i_size_read(inode);
  
 		if (dsize > gfs2_max_stuffed_size(ip))
@@ -75,7 +75,7 @@ static int gfs2_unstuffer_page(struct gfs2_inode *ip, struct buffer_head *dibh,
 
 		memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
 		memset(kaddr + dsize, 0, PAGE_SIZE - dsize);
-		kunmap(page);
+		kunmap_thread(page);
 
 		SetPageUptodate(page);
 	}
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 6d18d2c91add..a5d20d9b504a 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -263,9 +263,9 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
 		__free_page(page);
 		return -EIO;
 	}
-	p = kmap(page);
+	p = kmap_thread(page);
 	gfs2_sb_in(sdp, p);
-	kunmap(page);
+	kunmap_thread(page);
 	__free_page(page);
 	return gfs2_check_sb(sdp, silent);
 }
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
