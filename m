Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B922D8289A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Aug 2019 02:23:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D5EE21329968;
	Mon,  5 Aug 2019 17:25:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DEDEB21324661
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 17:25:51 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Aug 2019 17:23:21 -0700
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; d="scan'208";a="349263666"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Aug 2019 17:23:21 -0700
Subject: [ndctl PATCH v5 0/7] Improvements for namespace creation/interrogation
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 05 Aug 2019 17:09:03 -0700
Message-ID: <156505014382.848599.16271067825582995055.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Changes since v4:
- One more static analysis fixup, this time in "ndctl/dimm: Add offset
  and size options to {read,write,zero}-labels".

---

This trimmed version includes the extent support for label operations
which significantly speeds up common label operations like
'init-labels'. It also fixes up some surprising results from
'create-namespace' where it would fail even though available capacity is
present.

---

Dan Williams (7):
      ndctl/dimm: Support small label reads/writes
      ndctl/dimm: Minimize data-transfer for init-labels
      ndctl/dimm: Add offset and size options to {read,write,zero}-labels
      ndctl/dimm: Limit read-labels with --index option
      ndctl/namespace: Minimize label data transfer for autolabel
      ndctl/namespace: Continue region search on 'missing seed' event
      ndctl/namespace: Report ENOSPC when regions are full


 Documentation/ndctl/labels-options.txt    |    9 ++
 Documentation/ndctl/ndctl-read-labels.txt |    7 ++
 ndctl/dimm.c                              |   92 +++++++++++++++++--------
 ndctl/lib/dimm.c                          |   85 +++++++++++++++++++++--
 ndctl/lib/libndctl.c                      |  108 +++++++++++++++++++++++++----
 ndctl/lib/libndctl.sym                    |    9 ++
 ndctl/lib/private.h                       |    4 -
 ndctl/libndctl.h                          |    9 ++
 ndctl/namespace.c                         |   13 +++
 util/util.h                               |    4 +
 10 files changed, 285 insertions(+), 55 deletions(-)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
