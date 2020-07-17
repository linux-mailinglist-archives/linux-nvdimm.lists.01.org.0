Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706B522356A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 09:21:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 520BA11EDD976;
	Fri, 17 Jul 2020 00:21:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D9E1F11EDD961
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 00:21:09 -0700 (PDT)
IronPort-SDR: rj1h5MzVcDfs8UqKc/Ot5qkSYHf6mfswSX2mIGAfgCPEYQi1ENR17DgZS7h0QJcN/O13QxF0nJ
 nGCKx2wm7uFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="150928919"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800";
   d="scan'208";a="150928919"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:09 -0700
IronPort-SDR: YpmkIwj70j6oVnuZCPgm7Puk0Ze/LdT6Mtx+PLsWg4I1ZRpbL4Ii+GQfOj73MXeOUOarxnJ+rq
 LsrpPStzFBzg==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800";
   d="scan'208";a="282708053"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:08 -0700
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC V2 14/17] dax: Stray write protection for dax_direct_access()
Date: Fri, 17 Jul 2020 00:20:53 -0700
Message-Id: <20200717072056.73134-15-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20200717072056.73134-1-ira.weiny@intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: YSF6HELKLX5543O4NR5MHNVV72ZM3WOF
X-Message-ID-Hash: YSF6HELKLX5543O4NR5MHNVV72ZM3WOF
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YSF6HELKLX5543O4NR5MHNVV72ZM3WOF/>
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
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
