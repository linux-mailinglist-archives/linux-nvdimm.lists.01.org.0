Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F46D228FA7
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 Jul 2020 07:27:07 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 27F211247FDBD;
	Tue, 21 Jul 2020 22:27:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 81A8B1247AFC6
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jul 2020 22:27:02 -0700 (PDT)
IronPort-SDR: b12kJy2IaWF6fyYdqvFdt02B+jQ4wi8giDIjC9K6KcnvvCW2Yoqbsfdw5i8DbYKhZGFzWVZSqC
 no383AqcUN9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="214915590"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800";
   d="scan'208";a="214915590"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 22:27:02 -0700
IronPort-SDR: qs++qwaHpQG8SuUkPdRcvlF1EYjPjKlxrKTHnrG59K2oYMQ4ZNEHhCOhvuhkv3Me59pTGW1XY4
 tdPcmcWRnoqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800";
   d="scan'208";a="270646392"
Received: from vverma7-mobl4.lm.intel.com ([10.255.75.30])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jul 2020 22:27:01 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 1/2] ndctl/README: Add CONFIG_ENCRYPTED_KEYS to the config items list
Date: Tue, 21 Jul 2020 23:26:54 -0600
Message-Id: <20200722052655.21296-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200722052655.21296-1-vishal.l.verma@intel.com>
References: <20200722052655.21296-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 5KJWCXYHMYLNZHL5FNQFGQDUY72ONVBP
X-Message-ID-Hash: 5KJWCXYHMYLNZHL5FNQFGQDUY72ONVBP
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5KJWCXYHMYLNZHL5FNQFGQDUY72ONVBP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

CONFIG_ENCRYPTED_KEYS is required for test/security.sh (and generally
for security operations). It defaults to 'N', so call it out in the list
of config items for nfit_test.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 README.md | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README.md b/README.md
index d296c6b..89dfc87 100644
--- a/README.md
+++ b/README.md
@@ -65,6 +65,7 @@ loaded.  To build and install nfit_test.ko:
    CONFIG_NVDIMM_PFN=y
    CONFIG_NVDIMM_DAX=y
    CONFIG_DEV_DAX_PMEM=m
+   CONFIG_ENCRYPTED_KEYS=y
    ```
 
 1. Build and install the unit test enabled libnvdimm modules in the
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
