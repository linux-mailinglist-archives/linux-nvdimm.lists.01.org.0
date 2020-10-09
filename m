Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1215A289466
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Oct 2020 21:54:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E230C159C2228;
	Fri,  9 Oct 2020 12:54:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B286E159C222A
	for <linux-nvdimm@lists.01.org>; Fri,  9 Oct 2020 12:54:01 -0700 (PDT)
IronPort-SDR: 6kblP8MEQesOAWbqjpSlaRnJVh2H9EOhrWijg6FOCevgeHm0Cj+2nof7ViTbiDF1uYu1bjQgII
 SZOZKcYzDNlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="162068246"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="162068246"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:54:01 -0700
IronPort-SDR: vscQ8/PPGEHFzlszF4epup1/yO0Zdiea6PUky2hcTMxo6TNU67DufPr1A76ntRogBKZEHAEf8L
 bsjRzl3g/9bQ==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="529054196"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:54:00 -0700
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC PKS/PMEM 55/58] samples: Utilize new kmap_thread()
Date: Fri,  9 Oct 2020 12:50:30 -0700
Message-Id: <20201009195033.3208459-56-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: O2UR5LYIT3XLJXLGVGQYKZYIDR5HZRY4
X-Message-ID-Hash: O2UR5LYIT3XLJXLGVGQYKZYIDR5HZRY4
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Kirti Wankhede <kwankhede@nvidia.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, kexec@lists.infradead.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org, linux-efi@vger.kernel.org, linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-um@lists.infradead.org, linux-ntfs-dev@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org, cluster-devel@redhat.com, ecryptfs@vger
 .kernel.org, linux-cifs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, xen-devel@lists.xenproject.org, linux-cachefs@redhat.com, samba-technical@lists.samba.org, intel-wired-lan@lists.osuosl.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O2UR5LYIT3XLJXLGVGQYKZYIDR5HZRY4/>
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

Cc: Kirti Wankhede <kwankhede@nvidia.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 samples/vfio-mdev/mbochs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index 3cc5e5921682..6d95422c0b46 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -479,12 +479,12 @@ static ssize_t mdev_access(struct mdev_device *mdev, char *buf, size_t count,
 		pos -= MBOCHS_MMIO_BAR_OFFSET;
 		poff = pos & ~PAGE_MASK;
 		pg = __mbochs_get_page(mdev_state, pos >> PAGE_SHIFT);
-		map = kmap(pg);
+		map = kmap_thread(pg);
 		if (is_write)
 			memcpy(map + poff, buf, count);
 		else
 			memcpy(buf, map + poff, count);
-		kunmap(pg);
+		kunmap_thread(pg);
 		put_page(pg);
 
 	} else {
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
