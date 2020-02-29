Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6AF17493E
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:37:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E373210FC33F4;
	Sat, 29 Feb 2020 12:37:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D94B910FC33F3
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:37:48 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:56 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="439607695"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:56 -0800
Subject: [ndctl PATCH 09/36] ndctl/namespace: Check for region alignment
 violations
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 29 Feb 2020 12:20:51 -0800
Message-ID: <158300765145.2141307.14325031909413548404.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: URILIDABE4LUTVWCTBWKX6PS762JT5UV
X-Message-ID-Hash: URILIDABE4LUTVWCTBWKX6PS762JT5UV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/URILIDABE4LUTVWCTBWKX6PS762JT5UV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With the new kernel updates to enforce wider alignment constraints by
default ndctl has the ability to validate alignments problems before the
kernel fails the namespace instantiation. Teach create-namespace to
check the size argument against the region alignment rather than waiting
for the kernel to fail the operation:

Before:
#  ndctl create-namespace -m fsdax -s 1073750016 -a 4k
failed to create namespace: Invalid argument

After:
#  ndctl create-namespace -m fsdax -s 1073750016 -a 4k
  Error: create namespace: region2: align setting is 0x1000000 size 0x40002000 is misaligned

Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index b967e9be578f..c4aab94abcd4 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -652,6 +652,14 @@ static int validate_namespace_options(struct ndctl_region *region,
 		}
 	}
 
+	region_align = ndctl_region_get_align(region);
+	if (region_align < ULONG_MAX && p->size % region_align) {
+		err("%s: align setting is %#lx size %#llx is misaligned\n",
+				ndctl_region_get_devname(region), region_align,
+				p->size);
+		return -EINVAL;
+	}
+
 	size_align = p->align;
 
 	/* (re-)validate that the size satisfies the alignment */
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
