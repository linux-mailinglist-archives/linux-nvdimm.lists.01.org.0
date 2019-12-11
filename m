Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA4611A0A6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Dec 2019 02:44:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2DCF710113619;
	Tue, 10 Dec 2019 17:47:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 54E7A10113618
	for <linux-nvdimm@lists.01.org>; Tue, 10 Dec 2019 17:47:35 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 17:44:12 -0800
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600";
   d="scan'208";a="203391316"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 17:44:12 -0800
Subject: [ndctl PATCH 2/4] ndctl/build: Ensure header and other misc files
 are listed.
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Tue, 10 Dec 2019 17:29:56 -0800
Message-ID: <157602779685.1290519.18200044670741501676.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157602779173.1290519.2114609018855604805.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157602779173.1290519.2114609018855604805.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: Y3CA4CUVK6CDFKOXWVYTHJYMTA2KW47F
X-Message-ID-Hash: Y3CA4CUVK6CDFKOXWVYTHJYMTA2KW47F
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Auke Kok <auke-jan.h.kok@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y3CA4CUVK6CDFKOXWVYTHJYMTA2KW47F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Auke Kok <auke-jan.h.kok@intel.com>

Otherwise `make distcheck` is guaranteed to fail as BoM lists will
be incomplete to compile the sources properly.

Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/daxctl/Makefile.am |    2 ++
 Documentation/ndctl/Makefile.am  |    2 ++
 Makefile.am                      |   12 +++++++++++-
 daxctl/Makefile.am               |    3 ++-
 daxctl/lib/Makefile.am           |    2 +-
 ndctl/Makefile.am                |   12 +++++++++++-
 ndctl/lib/Makefile.am            |    9 ++++++++-
 test/Makefile.am                 |    2 ++
 8 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/Documentation/daxctl/Makefile.am b/Documentation/daxctl/Makefile.am
index 37c3bdee265d..7696e23cc9c0 100644
--- a/Documentation/daxctl/Makefile.am
+++ b/Documentation/daxctl/Makefile.am
@@ -33,6 +33,8 @@ man1_MANS = \
 	daxctl-online-memory.1 \
 	daxctl-offline-memory.1
 
+EXTRA_DIST = $(man1_MANS)
+
 CLEANFILES = $(man1_MANS)
 
 XML_DEPS = \
diff --git a/Documentation/ndctl/Makefile.am b/Documentation/ndctl/Makefile.am
index fb46d7c87938..659cb32f0878 100644
--- a/Documentation/ndctl/Makefile.am
+++ b/Documentation/ndctl/Makefile.am
@@ -57,6 +57,8 @@ man1_MANS = \
 	ndctl-load-keys.1 \
 	ndctl-wait-overwrite.1
 
+EXTRA_DIST = $(man1_MANS)
+
 CLEANFILES = $(man1_MANS)
 
 .ONESHELL:
diff --git a/Makefile.am b/Makefile.am
index 8d10a10ad1ee..95950d4f708e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -13,6 +13,10 @@ version.m4: FORCE
 
 FORCE:
 
+EXTRA_DIST += ndctl.spec.in \
+		sles/header \
+		contrib/nvdimm-security.conf
+
 noinst_SCRIPTS = rhel/ndctl.spec sles/ndctl.spec
 CLEANFILES += $(noinst_SCRIPTS)
 
@@ -75,6 +79,12 @@ libutil_a_SOURCES = \
 	util/filter.c \
 	util/bitmap.c \
 	util/abspath.c \
-	util/iomem.c
+	util/iomem.c \
+	util/util.h \
+	util/strbuf.h \
+	util/size.h \
+	util/main.h \
+	util/filter.h \
+	util/bitmap.h
 
 nobase_include_HEADERS = daxctl/libdaxctl.h
diff --git a/daxctl/Makefile.am b/daxctl/Makefile.am
index 66dcc7fc3438..ca1b86748bfb 100644
--- a/daxctl/Makefile.am
+++ b/daxctl/Makefile.am
@@ -16,7 +16,8 @@ daxctl_SOURCES =\
 		list.c \
 		migrate.c \
 		device.c \
-		../util/json.c
+		../util/json.c \
+		builtin.h
 
 daxctl_LDADD =\
 	lib/libdaxctl.la \
diff --git a/daxctl/lib/Makefile.am b/daxctl/lib/Makefile.am
index 7704b1be76f0..25efd8333572 100644
--- a/daxctl/lib/Makefile.am
+++ b/daxctl/lib/Makefile.am
@@ -23,7 +23,7 @@ libdaxctl_la_LIBADD =\
 
 daxctl_modprobe_data_DATA = daxctl.conf
 
-EXTRA_DIST += libdaxctl.sym
+EXTRA_DIST += libdaxctl.sym daxctl.conf
 
 libdaxctl_la_LDFLAGS = $(AM_LDFLAGS) \
 	-version-info $(LIBDAXCTL_CURRENT):$(LIBDAXCTL_REVISION):$(LIBDAXCTL_AGE) \
diff --git a/ndctl/Makefile.am b/ndctl/Makefile.am
index 502271ebb65e..264c4ed2d9e8 100644
--- a/ndctl/Makefile.am
+++ b/ndctl/Makefile.am
@@ -11,6 +11,7 @@ config.h: $(srcdir)/Makefile.am
 	$(AM_V_GEN) echo '#define NDCTL_KEYS_DIR  "$(ndctl_keysdir)"' >>$@
 
 ndctl_SOURCES = ndctl.c \
+		builtin.h \
 		bus.c \
 		create-nfit.c \
 		namespace.c \
@@ -20,11 +21,18 @@ ndctl_SOURCES = ndctl.c \
 		 ../util/log.c \
 		list.c \
 		../util/json.c \
+		../util/json.h \
 		util/json-smart.c \
 		util/json-firmware.c \
+		util/keys.h \
 		inject-error.c \
 		inject-smart.c \
-		monitor.c
+		monitor.c \
+		namespace.h \
+		action.h \
+		../nfit.h \
+		../test.h \
+		firmware-update.h
 
 if ENABLE_KEYUTILS
 ndctl_SOURCES += util/keys.c \
@@ -33,6 +41,8 @@ keys_configdir = $(ndctl_keysdir)
 keys_config_DATA = $(ndctl_keysreadme)
 endif
 
+EXTRA_DIST += keys.readme monitor.conf ndctl-monitor.service
+
 if ENABLE_DESTRUCTIVE
 ndctl_SOURCES += ../test/blk_namespaces.c \
 		 ../test/pmem_namespaces.c
diff --git a/ndctl/lib/Makefile.am b/ndctl/lib/Makefile.am
index e4eb0060bca4..d6be5c3acd26 100644
--- a/ndctl/lib/Makefile.am
+++ b/ndctl/lib/Makefile.am
@@ -9,10 +9,12 @@ lib_LTLIBRARIES = libndctl.la
 libndctl_la_SOURCES =\
 	../libndctl.h \
 	private.h \
+	../../util/list.h \
 	../../util/log.c \
 	../../util/log.h \
 	../../util/sysfs.c \
 	../../util/sysfs.h \
+	../../util/fletcher.h \
 	dimm.c \
 	inject.c \
 	nfit.c \
@@ -23,7 +25,12 @@ libndctl_la_SOURCES =\
 	hyperv.c \
 	ars.c \
 	firmware.c \
-	libndctl.c
+	libndctl.c \
+	intel.h \
+	hpe1.h \
+	msft.h \
+	hyperv.h \
+	../../ndctl/libndctl-nfit.h
 
 libndctl_la_LIBADD =\
 	../../daxctl/lib/libdaxctl.la \
diff --git a/test/Makefile.am b/test/Makefile.am
index 829146d5da74..c2c1158dc8ba 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -27,6 +27,8 @@ TESTS =\
 	max_available_extent_ns.sh \
 	pfn-meta-errors.sh
 
+EXTRA_DIST = $(TESTS)
+
 check_PROGRAMS =\
 	libndctl \
 	dsm-fail \
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
