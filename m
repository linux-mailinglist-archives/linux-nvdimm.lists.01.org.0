Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE45357587
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 02:30:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 827AC212AAFFE;
	Wed, 26 Jun 2019 17:30:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2AB05212AAB65
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 17:30:02 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Jun 2019 17:30:02 -0700
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; d="scan'208";a="152848892"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Jun 2019 17:30:02 -0700
Subject: [PATCH] filesystem-dax: Disable PMD support
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 26 Jun 2019 17:15:45 -0700
Message-ID: <156159454541.2964018.7466991316059381921.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Robert Barror <robert.barror@intel.com>,
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
 Seema Pandit <seema.pandit@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Ever since the conversion of DAX to the Xarray a RocksDB benchmark has
been encountering intermittent lockups. The backtraces always include
the filesystem-DAX PMD path, multi-order entries have been a source of
bugs in the past, and disabling the PMD path allows a test that fails in
minutes to run for an hour.

The regression has been bisected to "dax: Convert page fault handlers to
XArray", but little progress has been made on the root cause debug.
Unless / until root cause can be identified mark CONFIG_FS_DAX_PMD
broken to preclude intermittent lockups. Reverting the Xarray conversion
also works, but that change is too big to backport. The implementation
is committed to Xarray at this point.

Link: https://lore.kernel.org/linux-fsdevel/CAPcyv4hwHpX-MkUEqxwdTj7wCCZCN4RV-L4jsnuwLGyL_UEG4A@mail.gmail.com/
Fixes: b15cd800682f ("dax: Convert page fault handlers to XArray")
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: <stable@vger.kernel.org>
Reported-by: Robert Barror <robert.barror@intel.com>
Reported-by: Seema Pandit <seema.pandit@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index f1046cf6ad85..85eecd0d4c5d 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -66,6 +66,9 @@ config FS_DAX_PMD
 	depends on FS_DAX
 	depends on ZONE_DEVICE
 	depends on TRANSPARENT_HUGEPAGE
+	# intermittent lockups since commit b15cd800682f "dax: Convert
+	# page fault handlers to XArray"
+	depends on BROKEN
 
 # Selected by DAX drivers that do not expect filesystem DAX to support
 # get_user_pages() of DAX mappings. I.e. "limited" indicates no support

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
