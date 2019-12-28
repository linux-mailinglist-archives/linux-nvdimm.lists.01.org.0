Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A416012BC80
	for <lists+linux-nvdimm@lfdr.de>; Sat, 28 Dec 2019 05:09:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 54DF710113682;
	Fri, 27 Dec 2019 20:12:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8DD251011367D
	for <linux-nvdimm@lists.01.org>; Fri, 27 Dec 2019 20:12:57 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 20:09:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,365,1571727600";
   d="scan'208";a="230522557"
Received: from atan33-mobl1.gar.corp.intel.com (HELO redhaire-MOBL1.gar.corp.intel.com) ([10.255.176.179])
  by orsmga002.jf.intel.com with ESMTP; 27 Dec 2019 20:09:33 -0800
From: redhairer <redhairer.li@intel.com>
To: linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com
Subject: [PATCH 1/1] ndctl, test: add UUID_LIBS for blk_namespaces/pmem_namespaces/device_dax
Date: Sat, 28 Dec 2019 12:09:27 +0800
Message-Id: <20191228040927.4800-1-redhairer.li@intel.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Message-ID-Hash: VJ6HFDTLN633V2YWX4O5E73RFHJVCCDG
X-Message-ID-Hash: VJ6HFDTLN633V2YWX4O5E73RFHJVCCDG
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: redhairer <redhairer.li@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VJ6HFDTLN633V2YWX4O5E73RFHJVCCDG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Some environments automatically include the missing library dependency,
and others need it to be explicitly included.

Signed-off-by: Redhairer Li <redhairer.li@intel.com>
---
 test/Makefile.am | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/Makefile.am b/test/Makefile.am
index 829146d..a13440e 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -98,10 +98,10 @@ ack_shutdown_count_set_SOURCES =\
 ack_shutdown_count_set_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS)
 
 blk_ns_SOURCES = blk_namespaces.c $(testcore)
-blk_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS)
+blk_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS) $(UUID_LIBS)
 
 pmem_ns_SOURCES = pmem_namespaces.c $(testcore)
-pmem_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS)
+pmem_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS) $(UUID_LIBS)
 
 dpa_alloc_SOURCES = dpa-alloc.c $(testcore)
 dpa_alloc_LDADD = $(LIBNDCTL_LIB) $(UUID_LIBS) $(KMOD_LIBS)
@@ -143,6 +143,7 @@ device_dax_LDADD = \
 		$(LIBNDCTL_LIB) \
 		$(KMOD_LIBS) \
 		$(JSON_LIBS) \
+                $(UUID_LIBS) \
 		../libutil.a
 
 smart_notify_SOURCES = smart-notify.c
-- 
2.20.1.windows.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
