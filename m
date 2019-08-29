Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615D1A0E97
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Aug 2019 02:17:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 628A12194EB7A;
	Wed, 28 Aug 2019 17:19:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 06BE52021B70E
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 17:19:41 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Aug 2019 17:17:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; d="scan'208";a="356285450"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by orsmga005.jf.intel.com with ESMTP; 28 Aug 2019 17:17:41 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH 1/3] Documentation: refactor 'bus options' into its own
 include
Date: Wed, 28 Aug 2019 18:17:33 -0600
Message-Id: <20190829001735.30289-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829001735.30289-1-vishal.l.verma@intel.com>
References: <20190829001735.30289-1-vishal.l.verma@intel.com>
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
Cc: Steve Scargall <steve.scargall@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Create a new 'xable-bus-options.txt' file that is included everywhere
that previously relied upon xable-region-options.txt for bus options
inclusion.

While at it, fix the formatting for the first description text block
from an include - the empty line at the start caused the first block to
be incorrectly indented. This fixes both the dimm and region variants.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Documentation/ndctl/ndctl-check-namespace.txt   |  4 ++++
 Documentation/ndctl/ndctl-clear-errors.txt      |  4 ++++
 Documentation/ndctl/ndctl-create-namespace.txt  |  4 ++++
 Documentation/ndctl/ndctl-disable-dimm.txt      |  4 ++++
 Documentation/ndctl/ndctl-disable-region.txt    |  4 ++++
 Documentation/ndctl/ndctl-enable-dimm.txt       |  4 ++++
 Documentation/ndctl/ndctl-enable-region.txt     |  4 ++++
 Documentation/ndctl/ndctl-freeze-security.txt   |  4 ++++
 Documentation/ndctl/ndctl-inject-error.txt      |  4 ++++
 Documentation/ndctl/ndctl-list.txt              |  4 ++++
 Documentation/ndctl/ndctl-remove-passphrase.txt |  4 ++++
 Documentation/ndctl/ndctl-sanitize-dimm.txt     |  4 ++++
 Documentation/ndctl/ndctl-setup-passphrase.txt  |  4 ++++
 Documentation/ndctl/ndctl-update-firmware.txt   |  4 ++++
 Documentation/ndctl/ndctl-update-passphrase.txt |  4 ++++
 Documentation/ndctl/ndctl-wait-overwrite.txt    |  4 ++++
 Documentation/ndctl/xable-bus-options.txt       |  4 ++++
 Documentation/ndctl/xable-dimm-options.txt      | 13 +++----------
 Documentation/ndctl/xable-namespace-options.txt |  4 ++++
 Documentation/ndctl/xable-region-options.txt    | 13 +++----------
 20 files changed, 78 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/ndctl/xable-bus-options.txt

diff --git a/Documentation/ndctl/ndctl-check-namespace.txt b/Documentation/ndctl/ndctl-check-namespace.txt
index 2ece4e7..222f729 100644
--- a/Documentation/ndctl/ndctl-check-namespace.txt
+++ b/Documentation/ndctl/ndctl-check-namespace.txt
@@ -69,6 +69,10 @@ OPTIONS
 --region=::
 include::xable-region-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 include::../copyright.txt[]
 
 SEE ALSO
diff --git a/Documentation/ndctl/ndctl-clear-errors.txt b/Documentation/ndctl/ndctl-clear-errors.txt
index 206ab58..8eff57e 100644
--- a/Documentation/ndctl/ndctl-clear-errors.txt
+++ b/Documentation/ndctl/ndctl-clear-errors.txt
@@ -98,6 +98,10 @@ can potentially be a very long-running operation.
 --region=::
 include::xable-region-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 include::../copyright.txt[]
 
 SEE ALSO
diff --git a/Documentation/ndctl/ndctl-create-namespace.txt b/Documentation/ndctl/ndctl-create-namespace.txt
index 343733d..c9ae27c 100644
--- a/Documentation/ndctl/ndctl-create-namespace.txt
+++ b/Documentation/ndctl/ndctl-create-namespace.txt
@@ -211,6 +211,10 @@ OPTIONS
 --region=::
 include::xable-region-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 include::../copyright.txt[]
 
 SEE ALSO
diff --git a/Documentation/ndctl/ndctl-disable-dimm.txt b/Documentation/ndctl/ndctl-disable-dimm.txt
index 7706ac3..caa6714 100644
--- a/Documentation/ndctl/ndctl-disable-dimm.txt
+++ b/Documentation/ndctl/ndctl-disable-dimm.txt
@@ -19,6 +19,10 @@ OPTIONS
 <dimm>::
 include::xable-dimm-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 include::../copyright.txt[]
 
 SEE ALSO
diff --git a/Documentation/ndctl/ndctl-disable-region.txt b/Documentation/ndctl/ndctl-disable-region.txt
index ea1fd3a..3ca65a6 100644
--- a/Documentation/ndctl/ndctl-disable-region.txt
+++ b/Documentation/ndctl/ndctl-disable-region.txt
@@ -19,6 +19,10 @@ OPTIONS
 <region>::
 include::xable-region-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 include::../copyright.txt[]
 
 SEE ALSO
diff --git a/Documentation/ndctl/ndctl-enable-dimm.txt b/Documentation/ndctl/ndctl-enable-dimm.txt
index cd9908d..3e7106c 100644
--- a/Documentation/ndctl/ndctl-enable-dimm.txt
+++ b/Documentation/ndctl/ndctl-enable-dimm.txt
@@ -19,6 +19,10 @@ OPTIONS
 <dimm>::
 include::xable-dimm-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 include::../copyright.txt[]
 
 SEE ALSO
diff --git a/Documentation/ndctl/ndctl-enable-region.txt b/Documentation/ndctl/ndctl-enable-region.txt
index e5cbddb..96c2d1e 100644
--- a/Documentation/ndctl/ndctl-enable-region.txt
+++ b/Documentation/ndctl/ndctl-enable-region.txt
@@ -19,6 +19,10 @@ OPTIONS
 <region>::
 include::xable-region-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 include::../copyright.txt[]
 
 SEE ALSO
diff --git a/Documentation/ndctl/ndctl-freeze-security.txt b/Documentation/ndctl/ndctl-freeze-security.txt
index dbb94e7..55aaab7 100644
--- a/Documentation/ndctl/ndctl-freeze-security.txt
+++ b/Documentation/ndctl/ndctl-freeze-security.txt
@@ -56,6 +56,10 @@ OPTIONS
 <dimm>::
 include::xable-dimm-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 -v::
 --verbose::
         Emit debug messages.
diff --git a/Documentation/ndctl/ndctl-inject-error.txt b/Documentation/ndctl/ndctl-inject-error.txt
index 744ea50..da376ec 100644
--- a/Documentation/ndctl/ndctl-inject-error.txt
+++ b/Documentation/ndctl/ndctl-inject-error.txt
@@ -112,6 +112,10 @@ include::human-option.txt[]
 --region=::
 include::xable-region-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 include::../copyright.txt[]
 
 SEE ALSO
diff --git a/Documentation/ndctl/ndctl-list.txt b/Documentation/ndctl/ndctl-list.txt
index 80ad610..f9c7434 100644
--- a/Documentation/ndctl/ndctl-list.txt
+++ b/Documentation/ndctl/ndctl-list.txt
@@ -62,6 +62,10 @@ OPTIONS
 --region=::
 include::xable-region-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 -d::
 --dimm=::
 	An 'nmemX' device name, or dimm id number. The dimm id number
diff --git a/Documentation/ndctl/ndctl-remove-passphrase.txt b/Documentation/ndctl/ndctl-remove-passphrase.txt
index 3e838bb..f14e649 100644
--- a/Documentation/ndctl/ndctl-remove-passphrase.txt
+++ b/Documentation/ndctl/ndctl-remove-passphrase.txt
@@ -25,6 +25,10 @@ OPTIONS
 <dimm>::
 include::xable-dimm-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 -v::
 --verbose::
         Emit debug messages.
diff --git a/Documentation/ndctl/ndctl-sanitize-dimm.txt b/Documentation/ndctl/ndctl-sanitize-dimm.txt
index 91abf47..b2e5fde 100644
--- a/Documentation/ndctl/ndctl-sanitize-dimm.txt
+++ b/Documentation/ndctl/ndctl-sanitize-dimm.txt
@@ -38,6 +38,10 @@ OPTIONS
 <dimm>::
 include::xable-dimm-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 -c::
 --crypto-erase::
 	Replace the media encryption key on the NVDIMM causing all existing
diff --git a/Documentation/ndctl/ndctl-setup-passphrase.txt b/Documentation/ndctl/ndctl-setup-passphrase.txt
index b22d352..1219279 100644
--- a/Documentation/ndctl/ndctl-setup-passphrase.txt
+++ b/Documentation/ndctl/ndctl-setup-passphrase.txt
@@ -34,6 +34,10 @@ OPTIONS
 <dimm>::
 include::xable-dimm-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 -k::
 --key_handle=::
 	Handle for the master 'kek' (key-encryption-key) that will be used for
diff --git a/Documentation/ndctl/ndctl-update-firmware.txt b/Documentation/ndctl/ndctl-update-firmware.txt
index 449d858..1aa7fee 100644
--- a/Documentation/ndctl/ndctl-update-firmware.txt
+++ b/Documentation/ndctl/ndctl-update-firmware.txt
@@ -24,6 +24,10 @@ OPTIONS
 <dimm>::
 include::xable-dimm-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 -f::
 --firmware::
 	firmware file used to perform the update
diff --git a/Documentation/ndctl/ndctl-update-passphrase.txt b/Documentation/ndctl/ndctl-update-passphrase.txt
index 995efec..c7c1bfc 100644
--- a/Documentation/ndctl/ndctl-update-passphrase.txt
+++ b/Documentation/ndctl/ndctl-update-passphrase.txt
@@ -31,6 +31,10 @@ OPTIONS
 <dimm>::
 include::xable-dimm-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 -k::
 --key_handle=::
 	Handle for the master 'kek' (key-encryption-key) that will be used for
diff --git a/Documentation/ndctl/ndctl-wait-overwrite.txt b/Documentation/ndctl/ndctl-wait-overwrite.txt
index 0fada36..eb24f39 100644
--- a/Documentation/ndctl/ndctl-wait-overwrite.txt
+++ b/Documentation/ndctl/ndctl-wait-overwrite.txt
@@ -23,6 +23,10 @@ OPTIONS
 <dimm>::
 include::xable-dimm-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 -v::
 --verbose::
 	Emit debug messages.
diff --git a/Documentation/ndctl/xable-bus-options.txt b/Documentation/ndctl/xable-bus-options.txt
new file mode 100644
index 0000000..8813113
--- /dev/null
+++ b/Documentation/ndctl/xable-bus-options.txt
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+Enforce that the operation only be carried on devices that are
+attached to the given bus. Where 'bus' can be a provider name or a bus
+id number.
diff --git a/Documentation/ndctl/xable-dimm-options.txt b/Documentation/ndctl/xable-dimm-options.txt
index 709e2e4..8826c2b 100644
--- a/Documentation/ndctl/xable-dimm-options.txt
+++ b/Documentation/ndctl/xable-dimm-options.txt
@@ -1,11 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-	A 'nmemX' device name, or a dimm id number. The keyword 'all' can
-	be specified to carry out the operation on every dimm in the system,
-	optionally filtered by bus id (see --bus= option).
-
--b::
---bus=::
-	Enforce that the operation only be carried on devices that are
-	attached to the given bus. Where 'bus' can be a provider name or a bus
-	id number.
+A 'nmemX' device name, or a dimm id number. The keyword 'all' can
+be specified to carry out the operation on every dimm in the system,
+optionally filtered by bus id (see --bus= option).
diff --git a/Documentation/ndctl/xable-namespace-options.txt b/Documentation/ndctl/xable-namespace-options.txt
index babc248..1a25fee 100644
--- a/Documentation/ndctl/xable-namespace-options.txt
+++ b/Documentation/ndctl/xable-namespace-options.txt
@@ -9,6 +9,10 @@ the operation on every namespace in the system, optionally filtered by region
 --region=::
 include::xable-region-options.txt[]
 
+-b::
+--bus=::
+include::xable-bus-options.txt[]
+
 -v::
 --verbose::
 	Emit debug messages for the namespace operation
diff --git a/Documentation/ndctl/xable-region-options.txt b/Documentation/ndctl/xable-region-options.txt
index 69d3926..d5198f5 100644
--- a/Documentation/ndctl/xable-region-options.txt
+++ b/Documentation/ndctl/xable-region-options.txt
@@ -1,11 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-	A 'regionX' device name, or a region id number. The keyword 'all' can
-	be specified to carry out the operation on every region in the system,
-	optionally filtered by bus id (see --bus= option).
-
--b::
---bus=::
-	Enforce that the operation only be carried on devices that are
-	attached to the given bus. Where 'bus' can be a provider name or a bus
-	id number.
+A 'regionX' device name, or a region id number. The keyword 'all' can
+be specified to carry out the operation on every region in the system,
+optionally filtered by bus id (see --bus= option).
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
