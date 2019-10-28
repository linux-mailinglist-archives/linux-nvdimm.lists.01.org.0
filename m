Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CB6E6A6D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Oct 2019 02:13:12 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 88379100EA619;
	Sun, 27 Oct 2019 18:14:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ABB94100EA615;
	Sun, 27 Oct 2019 18:14:03 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 18:13:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,238,1569308400";
   d="scan'208";a="224486495"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Oct 2019 18:13:02 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
	(envelope-from <lkp@intel.com>)
	id 1iOtag-0004hM-6I; Mon, 28 Oct 2019 09:13:02 +0800
Date: Mon, 28 Oct 2019 09:12:52 +0800
From: kbuild test robot <lkp@intel.com>
To: Alastair D'Silva <alastair@au1.ibm.com>
Subject: [RFC PATCH] nvdimm: scm_get() can be static
Message-ID: <20191028011252.ebr7djanid6k25ok@4978f4969bb8>
References: <20191025044721.16617-9-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191025044721.16617-9-alastair@au1.ibm.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Message-ID-Hash: RCWEIH5JVGJ5TM6422D6M7ZHTINXXKT4
X-Message-ID-Hash: RCWEIH5JVGJ5TM6422D6M7ZHTINXXKT4
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: kbuild-all@lists.01.org, alastair@d-silva.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Gibson <david@gibson.dropbear.id.au>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Thomas Gleixner <tglx@linutronix.de>, Hari Bathini <hbathini@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Nicholas Piggin <npiggin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiy
 ang@gmail.com>, Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RCWEIH5JVGJ5TM6422D6M7ZHTINXXKT4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Fixes: 0d40f55b9035 ("nvdimm: Add driver for OpenCAPI Storage Class Memory")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 ocxl-scm.c          |    4 ++--
 ocxl-scm_internal.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/ocxl-scm.c b/drivers/nvdimm/ocxl-scm.c
index f4e6cc022de8a..c169cb0bc71d4 100644
--- a/drivers/nvdimm/ocxl-scm.c
+++ b/drivers/nvdimm/ocxl-scm.c
@@ -733,7 +733,7 @@ static void scm_put(struct scm_data *scm_data)
 	put_device(&scm_data->dev);
 }
 
-struct scm_data *scm_get(struct scm_data *scm_data)
+static struct scm_data *scm_get(struct scm_data *scm_data)
 {
 	return (get_device(&scm_data->dev) == NULL) ? NULL : scm_data;
 }
@@ -2142,7 +2142,7 @@ static int scm_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return -ENXIO;
 }
 
-struct pci_driver scm_pci_driver = {
+static struct pci_driver scm_pci_driver = {
 	.name = "ocxl-scm",
 	.id_table = scm_pci_tbl,
 	.probe = scm_probe,
diff --git a/drivers/nvdimm/ocxl-scm_internal.c b/drivers/nvdimm/ocxl-scm_internal.c
index e7c247835817b..ee11fb72e1ecd 100644
--- a/drivers/nvdimm/ocxl-scm_internal.c
+++ b/drivers/nvdimm/ocxl-scm_internal.c
@@ -64,8 +64,8 @@ int scm_admin_command_request(struct scm_data *scm_data, u8 op_code)
 	return scm_command_request(scm_data, &scm_data->admin_command, op_code);
 }
 
-int scm_command_response(const struct scm_data *scm_data,
-			 const struct command_metadata *cmd)
+static int scm_command_response(const struct scm_data *scm_data,
+				const struct command_metadata *cmd)
 {
 	u64 val;
 	u16 id;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
