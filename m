Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2083228FA6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 Jul 2020 07:27:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0FFFE1247B8F8;
	Tue, 21 Jul 2020 22:27:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 622361247AFC6
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jul 2020 22:27:02 -0700 (PDT)
IronPort-SDR: zm79gyBomVggb5+7aksCBieHy/RE3WG+2rr9yQZaLrbEufk3ZUWqXsqi4dZHya+WOeScEE2sVr
 xyiHVhRx98mA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="214915588"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800";
   d="scan'208";a="214915588"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 22:27:01 -0700
IronPort-SDR: 0yEHmAdZqVBr071G8QMIPYQz/p71pRxp4Ffl3jM/hrEOs81qf8mv6SarCZTQYrU2gip9SCKdiT
 +M3w1foMLL1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800";
   d="scan'208";a="270646387"
Received: from vverma7-mobl4.lm.intel.com ([10.255.75.30])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jul 2020 22:27:01 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 0/2] misc fixes and cleanup
Date: Tue, 21 Jul 2020 23:26:53 -0600
Message-Id: <20200722052655.21296-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Message-ID-Hash: 6HQOO3MD6B75BIZFWNBPMZJXSEH6DM2D
X-Message-ID-Hash: 6HQOO3MD6B75BIZFWNBPMZJXSEH6DM2D
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6HQOO3MD6B75BIZFWNBPMZJXSEH6DM2D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Patch 1 is a README update in the Unit tests section to include
CONFIG_ENCRYPTED_KEYS in the list of config items required for unit tests.

Patch 2 fixes a potential resource leak found during static analysis

Vishal Verma (2):
  ndctl/README: Add CONFIG_ENCRYPTED_KEYS to the config items list
  ndctl/namespace: fix a resource leak in file_write_infoblock()

 README.md         | 1 +
 ndctl/namespace.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
