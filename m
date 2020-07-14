Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F821E91E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jul 2020 09:04:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CCB3F10056B16;
	Tue, 14 Jul 2020 00:04:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 703F810056AFD
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 00:04:28 -0700 (PDT)
IronPort-SDR: QVkV/IMKVcqz0zmy+u9RvwR8hWCnM5g6U9vy9/1bKHcbq440vuG866xVAL0aYHjy/Qj/oawWzc
 3SJSxl5/O0Xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="128391978"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800";
   d="scan'208";a="128391978"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:28 -0700
IronPort-SDR: 2GlF4QiJnNhoGgMJ5XMp7xdyQ0iPfyqW+HUR8m12RTg7zWuuTG19TEkAYr8cw+FwjIa2w1Dc3M
 MV33WpvpzAfw==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800";
   d="scan'208";a="269934896"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:28 -0700
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 14/15] nvdimm/pmem: Stray write protection for pmem->virt_addr
Date: Tue, 14 Jul 2020 00:02:19 -0700
Message-Id: <20200714070220.3500839-15-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714070220.3500839-1-ira.weiny@intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: NKA2VIRRDGBUBDKSK5CQC3KWSI2TGXE3
X-Message-ID-Hash: NKA2VIRRDGBUBDKSK5CQC3KWSI2TGXE3
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NKA2VIRRDGBUBDKSK5CQC3KWSI2TGXE3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

The pmem driver uses a cached virtual address to access its memory
directly.  Because the nvdimm driver is well aware of the special
protections it has mapped memory with, we call dev_access_[en|dis]able()
around the direct pmem->virt_addr (pmem_addr) usage instead of the
unnecessary overhead of trying to get a page to kmap.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/nvdimm/pmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index d25e66fd942d..46c11a09b813 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -148,7 +148,9 @@ static blk_status_t pmem_do_read(struct pmem_device *pmem,
 	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
 		return BLK_STS_IOERR;
 
+	dev_access_enable();
 	rc = read_pmem(page, page_off, pmem_addr, len);
+	dev_access_disable();
 	flush_dcache_page(page);
 	return rc;
 }
@@ -180,11 +182,13 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
 	 * after clear poison.
 	 */
 	flush_dcache_page(page);
+	dev_access_enable();
 	write_pmem(pmem_addr, page, page_off, len);
 	if (unlikely(bad_pmem)) {
 		rc = pmem_clear_poison(pmem, pmem_off, len);
 		write_pmem(pmem_addr, page, page_off, len);
 	}
+	dev_access_disable();
 
 	return rc;
 }
-- 
2.25.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
