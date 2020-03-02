Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 607E6176770
	for <lists+linux-nvdimm@lfdr.de>; Mon,  2 Mar 2020 23:36:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D87B10FC3606;
	Mon,  2 Mar 2020 14:37:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7EFAE10FC3415
	for <linux-nvdimm@lists.01.org>; Mon,  2 Mar 2020 14:37:01 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 14:36:09 -0800
X-IronPort-AV: E=Sophos;i="5.70,508,1574150400";
   d="scan'208";a="351657315"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 14:36:09 -0800
Subject: [PATCH 1/5] ACPI: NUMA: Add 'nohmat' option
From: Dan Williams <dan.j.williams@intel.com>
To: linux-acpi@vger.kernel.org
Date: Mon, 02 Mar 2020 14:20:03 -0800
Message-ID: <158318760361.2216124.13612198312947463590.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: HPEUKJY7A27WRO2C4DR5LQSR2DGKBPB2
X-Message-ID-Hash: HPEUKJY7A27WRO2C4DR5LQSR2DGKBPB2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, ard.biesheuvel@linaro.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HPEUKJY7A27WRO2C4DR5LQSR2DGKBPB2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Disable parsing of the HMAT for debug, to workaround broken platform
instances, or cases where it is otherwise not wanted.

Cc: x86@kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/numa.c       |    4 ++++
 drivers/acpi/numa/hmat.c |    3 ++-
 include/acpi/acpi_numa.h |    1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 59ba008504dc..22de2e2610c1 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -44,6 +44,10 @@ static __init int numa_setup(char *opt)
 #ifdef CONFIG_ACPI_NUMA
 	if (!strncmp(opt, "noacpi", 6))
 		acpi_numa = -1;
+#ifdef CONFIG_ACPI_HMAT
+	if (!strncmp(opt, "nohmat", 6))
+		hmat_disable = 1;
+#endif
 #endif
 	return 0;
 }
diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2c32cfb72370..d3db121e393a 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -26,6 +26,7 @@
 #include <linux/sysfs.h>
 
 static u8 hmat_revision;
+int hmat_disable __initdata;
 
 static LIST_HEAD(targets);
 static LIST_HEAD(initiators);
@@ -814,7 +815,7 @@ static __init int hmat_init(void)
 	enum acpi_hmat_type i;
 	acpi_status status;
 
-	if (srat_disabled())
+	if (srat_disabled() || hmat_disable)
 		return 0;
 
 	status = acpi_get_table(ACPI_SIG_SRAT, 0, &tbl);
diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index fdebcfc6c8df..48ca468e9b61 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -18,6 +18,7 @@ extern int node_to_pxm(int);
 extern int acpi_map_pxm_to_node(int);
 extern unsigned char acpi_srat_revision;
 extern int acpi_numa __initdata;
+extern int hmat_disable __initdata;
 
 extern void bad_srat(void);
 extern int srat_disabled(void);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
