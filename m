Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AACD622355E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 09:21:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 23F7611EB8DFE;
	Fri, 17 Jul 2020 00:21:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A6A9311EB8DE9
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 00:21:04 -0700 (PDT)
IronPort-SDR: HGoRM8Hwn6fTiqlShuk9zqf1/HP3l3O8c83Wk9iuanBzmGD6VWF3nxrbiM0lcPl5vc5mmlNbYD
 2AfpHd3VXsKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129632996"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800";
   d="scan'208";a="129632996"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:04 -0700
IronPort-SDR: 4zwRcwamzur591b0APcoSq3hW8wylsw0cAqcpjKNMF8iH8HcKZLa37STEc1jY9FgE2B4hxhh1+
 0G1zRQBjWkzQ==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800";
   d="scan'208";a="361271089"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:03 -0700
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC V2 06/17] x86/pks: Add a debugfs file for allocated PKS keys
Date: Fri, 17 Jul 2020 00:20:45 -0700
Message-Id: <20200717072056.73134-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20200717072056.73134-1-ira.weiny@intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 6Z4PS2PQPKCFWG6MU245VAVX6TJ3OQTD
X-Message-ID-Hash: 6Z4PS2PQPKCFWG6MU245VAVX6TJ3OQTD
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6Z4PS2PQPKCFWG6MU245VAVX6TJ3OQTD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Fenghua Yu <fenghua.yu@intel.com>

The sysadmin may need to know which PKS keys are currently being used.

Add a debugfs file to show the allocated PKS keys and their names.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/mm/pkeys.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 16f735c12fcd..e565fadd74d7 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -328,3 +328,43 @@ void pks_key_free(int pkey)
 	mutex_unlock(&pks_lock);
 }
 EXPORT_SYMBOL_GPL(pks_key_free);
+
+static int pks_keys_allocated_show(struct seq_file *m, void *p)
+{
+	int i;
+
+	mutex_lock(&pks_lock);
+	for (i = PKS_KERN_DEFAULT_KEY; i < PKS_NUM_KEYS; i++) {
+		/* It is ok for pks_key_users[i] to be NULL */
+		if (test_bit(i, &pks_key_allocation_map))
+			seq_printf(m, "%d: %s\n", i, pks_key_users[i]);
+	}
+	mutex_unlock(&pks_lock);
+
+	return 0;
+}
+
+static int pks_keys_allocated_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pks_keys_allocated_show, NULL);
+}
+
+static const struct file_operations pks_keys_allocated_fops = {
+	.open		= pks_keys_allocated_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init pks_keys_initcall(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_PKS)) {
+		/* Create a debugfs file to show allocated PKS keys. */
+		debugfs_create_file("pks_keys_allocated", 0400,
+				    arch_debugfs_dir, NULL,
+				    &pks_keys_allocated_fops);
+	}
+
+	return 0;
+}
+late_initcall(pks_keys_initcall);
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
