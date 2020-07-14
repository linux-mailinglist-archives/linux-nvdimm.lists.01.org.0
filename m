Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EE221E91F
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jul 2020 09:04:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EFFBB10056B03;
	Tue, 14 Jul 2020 00:04:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C480810056AFD
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 00:04:28 -0700 (PDT)
IronPort-SDR: Q0PTe7EP388qT0S2BRDRsyVcqaWDF5Hh4evrZVG+r6KltLWtFKORezpwnKWulqlXiXc2UjMDXR
 5nhgRgYOtlRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="146304360"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800";
   d="scan'208";a="146304360"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:28 -0700
IronPort-SDR: M1818UDpOziaMV+1NuZExXbDGKfxAHE7xxsE/1/8eIxmubbVe3Yh1zWgdqipkeJC59admPi65v
 orXIGfMQFVpQ==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800";
   d="scan'208";a="390397762"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:26 -0700
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 13/15] dax: Stray write protection for dax_direct_access()
Date: Tue, 14 Jul 2020 00:02:18 -0700
Message-Id: <20200714070220.3500839-14-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714070220.3500839-1-ira.weiny@intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 4VCPYB4R3QXGSCPX3ORYB2U5RQH7XTSW
X-Message-ID-Hash: 4VCPYB4R3QXGSCPX3ORYB2U5RQH7XTSW
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4VCPYB4R3QXGSCPX3ORYB2U5RQH7XTSW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

dax_direct_access() is a special case of accessing pmem via a page
offset and without a struct page.

Because the dax driver is well aware of the special protections it has
mapped memory with, call dev_access_[en|dis]able() directly instead of
the unnecessary overhead of trying to get a page to kmap.

Like kmap though, leverage the existing dax_read[un]lock() functions
because they are already required to surround the use of the memory
returned from dax_direct_access().

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 021739768093..e8d0a28e6ed2 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -30,12 +30,14 @@ static DEFINE_SPINLOCK(dax_host_lock);
 
 int dax_read_lock(void)
 {
+	dev_access_enable();
 	return srcu_read_lock(&dax_srcu);
 }
 EXPORT_SYMBOL_GPL(dax_read_lock);
 
 void dax_read_unlock(int id)
 {
+	dev_access_disable();
 	srcu_read_unlock(&dax_srcu, id);
 }
 EXPORT_SYMBOL_GPL(dax_read_unlock);
-- 
2.25.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
