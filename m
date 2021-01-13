Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD952F44FA
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 08:15:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AF3EF100EB324;
	Tue, 12 Jan 2021 23:15:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B905D100EB325
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 23:15:04 -0800 (PST)
IronPort-SDR: FEIjnLEZEYMyJsN3N69PC3mk0oOA6GEAvFJDCcxDy+kyaZp8qEbv87RL/OLB6KsMbpSR16/3yB
 makwWH6lmoAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="262948693"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="262948693"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:15:04 -0800
IronPort-SDR: z8IAgj2FemypgMdubKPcxYH8GD1GiTM8GaTdlmc7+eOL6rKG3b4GRRZ71id9NxDqVCfHyr45aw
 gzUI75W95IOg==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="569336683"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:15:04 -0800
Subject: [ndctl PATCH 2/4] ndctl/test: Cleanup unnecessary out label
From: Dan Williams <dan.j.williams@intel.com>
To: vishal.l.verma@intel.com
Date: Tue, 12 Jan 2021 23:15:03 -0800
Message-ID: <161052210395.1804207.7318263492906073721.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161052209289.1804207.11599120961607513911.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161052209289.1804207.11599120961607513911.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: W5WVD47DKXFI3HJUF2JP4FEWNRPOIG4D
X-Message-ID-Hash: W5WVD47DKXFI3HJUF2JP4FEWNRPOIG4D
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W5WVD47DKXFI3HJUF2JP4FEWNRPOIG4D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There are no cleanup actions to take in test_dax_remap(), and it is already
inconsistent for having a single return point, so remove the out label.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/dax-pmd.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/test/dax-pmd.c b/test/dax-pmd.c
index 401826d02d69..b1251db63041 100644
--- a/test/dax-pmd.c
+++ b/test/dax-pmd.c
@@ -83,20 +83,18 @@ int test_dax_remap(struct ndctl_test *test, int dax_fd, unsigned long align, voi
 	act.sa_flags = SA_SIGINFO;
 	if (sigaction(SIGBUS, &act, 0)) {
 		perror("sigaction");
-		rc = EXIT_FAILURE;
-		goto out;
+		return EXIT_FAILURE;
 	}
 
 	/* test fault after device-dax instance disabled */
 	if (sigsetjmp(sj_env, 1)) {
 		if (!fsdax && align > SZ_4K) {
 			fprintf(stderr, "got expected SIGBUS after mremap() of device-dax\n");
-			rc = 0;
+			return 0;
 		} else {
 			fprintf(stderr, "unpexpected SIGBUS after mremap()\n");
-			rc = -EIO;
+			return -EIO;
 		}
-		goto out;
 	}
 
 	*(int *) anon = 0xAA;
@@ -107,9 +105,7 @@ int test_dax_remap(struct ndctl_test *test, int dax_fd, unsigned long align, voi
 		return -ENXIO;
 	}
 
-	rc = 0;
-out:
-	return rc;
+	return 0;
 }
 
 int test_dax_directio(int dax_fd, unsigned long align, void *dax_addr, off_t offset)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
