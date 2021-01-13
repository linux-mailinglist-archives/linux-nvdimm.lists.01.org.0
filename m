Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE572F44F7
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 08:14:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 679B0100EB320;
	Tue, 12 Jan 2021 23:14:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D74AE100EB85F
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 23:14:53 -0800 (PST)
IronPort-SDR: 03oFkW+IjOhuoqNm3bQbXI8DEYlmD2LqxE6HBzuQoXzFILOVCO4gEL1i4MODFYoB23c73isMBs
 H95O+vB1b0gA==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="178310018"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="178310018"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:14:53 -0800
IronPort-SDR: VW8ZtevZfQnWW53LyuDrIwNU9KaJ+r1QZHvCOMwe6T/KIud0d7xVGzzdd7GNfzJx9FH1BGxx7+
 Wo5Y+WZRlT7w==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="389408652"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:14:53 -0800
Subject: [ndctl PATCH 0/4] ndctl/test: softoffline, mremap, and misc fixups
From: Dan Williams <dan.j.williams@intel.com>
To: vishal.l.verma@intel.com
Date: Tue, 12 Jan 2021 23:14:53 -0800
Message-ID: <161052209289.1804207.11599120961607513911.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: OKHZDOEKUHMEXWWUZIULHZDIZCYBMUWW
X-Message-ID-Hash: OKHZDOEKUHMEXWWUZIULHZDIZCYBMUWW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OKHZDOEKUHMEXWWUZIULHZDIZCYBMUWW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vishal,

Here's a collection of test updates. It adds support for regression
testing pfn_to_online_page() which suffered from a lack of precision in
mixed zone memory-sections. Updates the mremap() regression to accept
failure as an option (the behavior in v5.11-rc1+). Fixes a warning, and
ditches an 'out' label.

---

Dan Williams (4):
      ndctl/test: Fix btt expect table compile warning
      ndctl/test: Cleanup unnecessary out label
      ndctl/test: Fix device-dax mremap() test
      ndctl/test: Exercise soft_offline_page() corner cases


 test/dax-pmd.c    |   17 +++++++++--------
 test/dax-poison.c |   19 +++++++++++++++++++
 test/device-dax.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 test/libndctl.c   |   12 ++++++------
 4 files changed, 79 insertions(+), 14 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
