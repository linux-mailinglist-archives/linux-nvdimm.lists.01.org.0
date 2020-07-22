Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E229A228FA8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 Jul 2020 07:27:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3C57D124802A1;
	Tue, 21 Jul 2020 22:27:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 939ED1247AFC6
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jul 2020 22:27:02 -0700 (PDT)
IronPort-SDR: TeKRrx/ReIqeqL6v7z2uI8LNb0wy6Wd4jkB1jPDVy1bV2Hfpun6ctw/jUcUQ/WX4ZtfbtmLSYd
 9+dxVMPTBYEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="214915592"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800";
   d="scan'208";a="214915592"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 22:27:02 -0700
IronPort-SDR: gFnUYrVOASUOkK5xCxZdfsLc4tmsyd3VgiyeCYVtyfHXekxZz8iMM1ONIE8sgXKwXcr8XVWkR3
 KW6ZtV6KMd3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800";
   d="scan'208";a="270646396"
Received: from vverma7-mobl4.lm.intel.com ([10.255.75.30])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jul 2020 22:27:02 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 2/2] ndctl/namespace: fix a resource leak in file_write_infoblock()
Date: Tue, 21 Jul 2020 23:26:55 -0600
Message-Id: <20200722052655.21296-3-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200722052655.21296-1-vishal.l.verma@intel.com>
References: <20200722052655.21296-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 427EKL5C433MC3EB6RTTC4ZOPZKRBGTI
X-Message-ID-Hash: 427EKL5C433MC3EB6RTTC4ZOPZKRBGTI
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/427EKL5C433MC3EB6RTTC4ZOPZKRBGTI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Static analysis showed that we might leak 'fd' in the given function.
Fix the error path to close(fd) if 'fd >= 0' rather than just 'fd > 0'.

Fixes: 7787807bcffe ("ndctl/namespace: Add write-infoblock command")
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 8aa5a42..e734248 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1969,7 +1969,7 @@ static int file_write_infoblock(const char *path)
 
 	free(buf);
 out:
-	if (fd > 0 && fd != STDOUT_FILENO)
+	if (fd >= 0 && fd != STDOUT_FILENO)
 		close(fd);
 	return rc;
 }
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
