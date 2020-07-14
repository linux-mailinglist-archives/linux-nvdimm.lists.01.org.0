Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2274E21E90E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jul 2020 09:04:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ECCE810056B0B;
	Tue, 14 Jul 2020 00:04:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 70F5D10056B05
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 00:04:12 -0700 (PDT)
IronPort-SDR: 7IqVlgu+Ty/Ji96J4SoeSGVDEtABPdjSlWcF+/ubOrWU6ICzVKXXrTZZvuTzoi9zqS8c2F990J
 9QpbrD+/cHug==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="150261178"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800";
   d="scan'208";a="150261178"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:12 -0700
IronPort-SDR: 2S/nvFjzQ392JiaSqjcp8ScDg96hb1apbpi4JcpWqJ5/phFArv7EiT3mk7FEux00XHBnw/HaLS
 IAyf6X3DxdnQ==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800";
   d="scan'208";a="324463867"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:11 -0700
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 06/15] x86/pks: Add a debugfs file for allocated PKS keys
Date: Tue, 14 Jul 2020 00:02:11 -0700
Message-Id: <20200714070220.3500839-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714070220.3500839-1-ira.weiny@intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 6CTENATK34MMV3D42SX54UW4MHVZJQU7
X-Message-ID-Hash: 6CTENATK34MMV3D42SX54UW4MHVZJQU7
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6CTENATK34MMV3D42SX54UW4MHVZJQU7/>
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
2.25.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
