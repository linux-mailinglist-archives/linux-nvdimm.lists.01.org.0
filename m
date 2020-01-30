Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8E914E5B8
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Jan 2020 23:58:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D966D10FC3160;
	Thu, 30 Jan 2020 15:01:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7063B10F6CD1C
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 15:01:52 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 14:58:34 -0800
X-IronPort-AV: E=Sophos;i="5.70,383,1574150400";
   d="scan'208";a="218434810"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 14:58:33 -0800
Subject: [ndctl PATCH 0/2] ndctl: Cross-arch compatible namespace alignment
From: Dan Williams <dan.j.williams@intel.com>
To: vishal.l.verma@intel.com
Date: Thu, 30 Jan 2020 14:42:30 -0800
Message-ID: <158042414995.3946705.2742716492944802875.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: EKISUHMEJGIJ7FLQIZ5NIMSBMZRBWIKP
X-Message-ID-Hash: EKISUHMEJGIJ7FLQIZ5NIMSBMZRBWIKP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EKISUHMEJGIJ7FLQIZ5NIMSBMZRBWIKP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A follow-up to the region-align kernel enabling, [1], update ndctl to
enumerate region alignment, and update the unit tests to account for the
kernel's default compatible alignment.

Given that changing the default is a surefire way to create incompatible
namespaces I do not think it makes sense to plumb region alignment
through the create-namespace interface. Only expert users would be
expected to trawl through sysfs and set a non-default alignment. I.e.
the lack of documentation and enabling for setting this value in the
ndctl man pages is deliberate.

---

Dan Williams (2):
      ndctl/region: Support ndctl_region_{get,set}_align()
      ndctl/namespace: Improve namespace action failure messages


 ndctl/lib/libndctl.c   |   35 ++++++++++++++++++++
 ndctl/lib/libndctl.sym |    2 +
 ndctl/libndctl.h       |    2 +
 ndctl/list.c           |    5 +++
 ndctl/namespace.c      |   82 ++++++++++++++++++++++++++++++++----------------
 test/blk_namespaces.c  |    1 +
 test/dpa-alloc.c       |   10 +++++-
 test/dsm-fail.c        |    5 ++-
 test/libndctl.c        |   10 +++++-
 test/parent-uuid.c     |    1 +
 10 files changed, 121 insertions(+), 32 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
