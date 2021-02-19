Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F260031F3C9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Feb 2021 03:04:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3F339100EAB45;
	Thu, 18 Feb 2021 18:04:04 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 81897100EAB5E
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 18:03:56 -0800 (PST)
IronPort-SDR: 9DtYZX4SIja5fThuEP8bmRzBOXExq73HSM4iMLEI3J/CmlIs6T9kDs5EFeOqpkAvf6qxKQihQP
 wNCb8+xN4ZIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="181151524"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="181151524"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:56 -0800
IronPort-SDR: QoIZ0i4ySHXLoUw8caSh8y6/4quGuLGeZUmWf0dCN7BiOYzK0Uk6h2v9Yow6zmPJAJ1FakqF4w
 /EFsCvloJ7Fg==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="513509687"
Received: from jnavar1-mobl4.amr.corp.intel.com (HELO omniknight.intel.com) ([10.213.167.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:55 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-cxl@vger.kernel.org>
Subject: [ndctl PATCH v2 12/13] Documentation/cxl: add library API documentation
Date: Thu, 18 Feb 2021 19:03:30 -0700
Message-Id: <20210219020331.725687-13-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219020331.725687-1-vishal.l.verma@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: KHZAKLB2SBWNUPTLYENNNLBSOTU7FGA7
X-Message-ID-Hash: KHZAKLB2SBWNUPTLYENNNLBSOTU7FGA7
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Ben Widawsky <ben.widawsky@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KHZAKLB2SBWNUPTLYENNNLBSOTU7FGA7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add library API documentation for libcxl(3) using the existing
asciidoc(tor) build system. Add a section 3 man page for 'libcxl' that
provides an overview of the library and its usage, and a man page for
the 'cxl_new()' API.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Documentation/cxl/lib/cxl_new.txt | 43 +++++++++++++++++++++++
 Documentation/cxl/lib/libcxl.txt  | 56 +++++++++++++++++++++++++++++
 configure.ac                      |  1 +
 Makefile.am                       |  1 +
 .gitignore                        |  3 ++
 Documentation/cxl/lib/Makefile.am | 58 +++++++++++++++++++++++++++++++
 6 files changed, 162 insertions(+)
 create mode 100644 Documentation/cxl/lib/cxl_new.txt
 create mode 100644 Documentation/cxl/lib/libcxl.txt
 create mode 100644 Documentation/cxl/lib/Makefile.am

diff --git a/Documentation/cxl/lib/cxl_new.txt b/Documentation/cxl/lib/cxl_new.txt
new file mode 100644
index 0000000..d4d5bcb
--- /dev/null
+++ b/Documentation/cxl/lib/cxl_new.txt
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl_new(3)
+==========
+
+NAME
+----
+cxl_new - Create a new library context object that acts as a handle for all
+library operations
+
+SYNOPSIS
+--------
+[verse]
+----
+#include <cxl/libcxl.h>
+
+int cxl_new(struct cxl_ctx **ctx);
+----
+
+DESCRIPTION
+-----------
+Instantiates a new library context, and stores an opaque pointer in ctx. The
+context is freed by linklibcxl:cxl_unref[3], i.e. cxl_new(3) implies an
+internal linklibcxl:cxl_ref[3].
+
+
+RETURN VALUE
+------------
+Returns 0 on success, and a negative errno on failure.
+Possible error codes are:
+
+ * -ENOMEM
+ * -ENXIO
+
+EXAMPLE
+-------
+See example usage in test/libcxl.c
+
+include::../../copyright.txt[]
+
+SEE ALSO
+--------
+linklibcxl:cxl_ref[3], linklibcxl:cxl_unref[3]
diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
new file mode 100644
index 0000000..47f4cc3
--- /dev/null
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+
+libcxl(3)
+=========
+
+NAME
+----
+libcxl - A library to interact with CXL devices through sysfs(5)
+and ioctl(2) interfaces
+
+SYNOPSIS
+--------
+[verse]
+#include <cxl/libcxl.h>
+cc ... -lcxl
+
+DESCRIPTION
+-----------
+libcxl provides interfaces to interact with CXL devices in Linux, using sysfs
+interfaces for most kernel interactions, and the ioctl() interface for command
+submission.
+
+The starting point for all library interfaces is a 'cxl_ctx' object, returned
+by linklibcxl:cxl_new[3]. CXL 'Type 3' memory devices are children of the
+cxl_ctx object, and can be iterated through using an iterator API.
+
+Library level interfaces that are agnostic to any device, or a specific
+subclass of operations have the prefix 'cxl_'
+
+The object representing a CXL Type 3 device is 'cxl_memdev'. Library interfaces
+related to these devices have the prefix 'cxl_memdev_'. These interfaces are
+mostly associated with sysfs interactions (unless otherwise noted in their
+respective documentation pages). They are typically used to retrieve data
+published by the kernel, or to send data or trigger kernel operations for a
+given device.
+
+A 'cxl_cmd' is a reference counted object which is used to perform 'Mailbox'
+commands as described in the CXL Specification. A 'cxl_cmd' object is tied to a
+'cxl_memdev'. Associated library interfaces have the prefix 'cxl_cmd_'. Within
+this sub-class of interfaces, there are:
+
+ * 'cxl_cmd_new_*' interfaces that allocate a new cxl_cmd object for a given
+   command type.
+
+ * 'cxl_cmd_submit' which submits the command via ioctl()
+
+ * 'cxl_cmd_<name>_get_<field>' interfaces that get specific fields out of the
+   command response
+
+ * 'cxl_cmd_get_*' interfaces to get general command related information.
+
+include::../../copyright.txt[]
+
+SEE ALSO
+--------
+linklibcxl:cxl[1]
diff --git a/configure.ac b/configure.ac
index 7f5e6f0..a357042 100644
--- a/configure.ac
+++ b/configure.ac
@@ -231,6 +231,7 @@ AC_CONFIG_FILES([
         Documentation/ndctl/Makefile
         Documentation/daxctl/Makefile
         Documentation/cxl/Makefile
+        Documentation/cxl/lib/Makefile
 ])
 
 AC_OUTPUT
diff --git a/Makefile.am b/Makefile.am
index 4904ee7..e2f6bef 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -4,6 +4,7 @@ ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}
 SUBDIRS = . cxl/lib daxctl/lib ndctl/lib cxl ndctl daxctl
 if ENABLE_DOCS
 SUBDIRS += Documentation/ndctl Documentation/daxctl Documentation/cxl
+SUBDIRS += Documentation/cxl/lib
 endif
 SUBDIRS += test
 
diff --git a/.gitignore b/.gitignore
index de43823..b0f93dc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -13,12 +13,15 @@ Makefile.in
 /libtool
 /stamp-h1
 *.1
+*.3
 Documentation/daxctl/asciidoc.conf
 Documentation/ndctl/asciidoc.conf
 Documentation/cxl/asciidoc.conf
+Documentation/cxl/lib/asciidoc.conf
 Documentation/daxctl/asciidoctor-extensions.rb
 Documentation/ndctl/asciidoctor-extensions.rb
 Documentation/cxl/asciidoctor-extensions.rb
+Documentation/cxl/lib/asciidoctor-extensions.rb
 .dirstamp
 daxctl/config.h
 daxctl/daxctl
diff --git a/Documentation/cxl/lib/Makefile.am b/Documentation/cxl/lib/Makefile.am
new file mode 100644
index 0000000..41e3a5f
--- /dev/null
+++ b/Documentation/cxl/lib/Makefile.am
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020-2021 Intel Corporation. All rights reserved.
+
+if USE_ASCIIDOCTOR
+
+do_subst = sed -e 's,@Utility@,Libcxl,g' -e's,@utility@,libcxl,g'
+CONFFILE = asciidoctor-extensions.rb
+asciidoctor-extensions.rb: ../../asciidoctor-extensions.rb.in
+	$(AM_V_GEN) $(do_subst) < $< > $@
+
+else
+
+do_subst = sed -e 's,UTILITY,libcxl,g'
+CONFFILE = asciidoc.conf
+asciidoc.conf: ../../asciidoc.conf.in
+	$(AM_V_GEN) $(do_subst) < $< > $@
+
+endif
+
+man3_MANS = \
+	libcxl.3 \
+	cxl_new.3
+
+EXTRA_DIST = $(man3_MANS)
+
+CLEANFILES = $(man3_MANS)
+
+XML_DEPS = \
+	../../../version.m4 \
+	../../copyright.txt \
+	Makefile \
+	$(CONFFILE)
+
+RM ?= rm -f
+
+if USE_ASCIIDOCTOR
+
+%.3: %.txt $(XML_DEPS)
+	$(AM_V_GEN)$(RM) $@+ $@ && \
+		$(ASCIIDOC) -b manpage -d manpage -acompat-mode \
+		-I. -rasciidoctor-extensions \
+		-amansource=libcxl -amanmanual="libcxl Manual" \
+		-andctl_version=$(VERSION) -o $@+ $< && \
+		mv $@+ $@
+
+else
+
+%.xml: %.txt $(XML_DEPS)
+	$(AM_V_GEN)$(RM) $@+ $@ && \
+		$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
+		--unsafe -alibcxl_version=$(VERSION) -o $@+ $< && \
+		mv $@+ $@
+
+%.3: %.xml $(XML_DEPS)
+	$(AM_V_GEN)$(RM) $@ && \
+		$(XMLTO) -o . -m ../../manpage-normal.xsl man $<
+
+endif
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
