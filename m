Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778753335B7
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Mar 2021 07:09:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E5C2E100EC1E7;
	Tue,  9 Mar 2021 22:09:52 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 46327100EC1E6
	for <linux-nvdimm@lists.01.org>; Tue,  9 Mar 2021 22:09:50 -0800 (PST)
IronPort-SDR: b5M248Rzl/dNnVsUJ+NPbNXtl+EqWjYac380XbSzGRqu6wHfsxr5STHzHpccZEK3SZsyyM/2Qh
 RcRyggD7IPWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="168310220"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400";
   d="scan'208";a="168310220"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 22:09:49 -0800
IronPort-SDR: UnhYaMwIwr3TluAJYUMpYEZK25Njdxq9Hidno4VpgqxLhWU4AleJKBPliLvdAy3DHoMWWonB52
 f43eBcBE1vDw==
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400";
   d="scan'208";a="410049640"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 22:09:49 -0800
Subject: [ndctl PATCH] test/libndctl: Use ndctl_region_set_ro() to change
 disk read-only state
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Tue, 09 Mar 2021 22:09:49 -0800
Message-ID: <161535658913.530219.12194565167385663385.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: NO2JFVBNANVIT33ZS6PNDE3JZPFTIUF5
X-Message-ID-Hash: NO2JFVBNANVIT33ZS6PNDE3JZPFTIUF5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: kernel test robot <lkp@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NO2JFVBNANVIT33ZS6PNDE3JZPFTIUF5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Kernel commit 52f019d43c22 ("block: add a hard-readonly flag to struct
gendisk") broke the read-only management test, by fixing the broken
behavior that BLKROSET could make a block device read-write even when the
disk is read-only. The fix (see Link:) propagates changes of the region
read-only state to the underlying disk. Add ndctl_region_set_ro() ahead of
BLKROSET so that BLKROSET does not conflict the block_device state with the
disk state.

Link: http://lore.kernel.org/r/161534060720.528671.2341213328968989192.stgit@dwillia2-desk3.amr.corp.intel.com
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/libndctl.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/test/libndctl.c b/test/libndctl.c
index faa308ade8fc..391b94086dae 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -1541,6 +1541,7 @@ static int validate_bdev(const char *devname, struct ndctl_btt *btt,
 		struct ndctl_pfn *pfn, struct ndctl_namespace *ndns,
 		struct namespace *namespace, void *buf)
 {
+	struct ndctl_region *region = ndctl_namespace_get_region(ndns);
 	char bdevpath[50];
 	int fd, rc, ro;
 
@@ -1578,6 +1579,13 @@ static int validate_bdev(const char *devname, struct ndctl_btt *btt,
 	}
 
 	ro = 0;
+	rc = ndctl_region_set_ro(region, ro);
+	if (rc < 0) {
+		fprintf(stderr, "%s: ndctl_region_set_ro failed\n", devname);
+		rc = -errno;
+		goto out;
+	}
+
 	rc = ioctl(fd, BLKROSET, &ro);
 	if (rc < 0) {
 		fprintf(stderr, "%s: BLKROSET failed\n",
@@ -1605,8 +1613,16 @@ static int validate_bdev(const char *devname, struct ndctl_btt *btt,
 		rc = -ENXIO;
 		goto out;
 	}
+
+	rc = ndctl_region_set_ro(region, namespace->ro);
+	if (rc < 0) {
+		fprintf(stderr, "%s: ndctl_region_set_ro reset failed\n", devname);
+		rc = -errno;
+		goto out;
+	}
+
 	rc = 0;
- out:
+out:
 	close(fd);
 	return rc;
 }
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
