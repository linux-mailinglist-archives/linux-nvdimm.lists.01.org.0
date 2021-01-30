Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8253090F1
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 Jan 2021 01:25:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 73946100EAB19;
	Fri, 29 Jan 2021 16:24:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E1702100EB35E
	for <linux-nvdimm@lists.01.org>; Fri, 29 Jan 2021 16:24:49 -0800 (PST)
IronPort-SDR: EnNVN11PDJx/k3t0sjaXfkS9gL8P7kOfxLKoZmPXvag1UU1KMrRXYzo4zPO/GyrIqu/o+w9TIO
 +7uhjnqZKb6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="265333149"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="265333149"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:49 -0800
IronPort-SDR: m7fLWpnzSaGDDMzkIoKQE1gcfDJtpyuPc8V2ww1bEY8aPomuNC709+efCr5+o4CuEcZOz7049/
 ppIAmMFJlyyg==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="370591682"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:49 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH 08/14] taint: add taint for direct hardware access
Date: Fri, 29 Jan 2021 16:24:32 -0800
Message-Id: <20210130002438.1872527-9-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210130002438.1872527-1-ben.widawsky@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: X7HP5WGRVH6HQLD32CESKXZ3BUDJN36J
X-Message-ID-Hash: X7HP5WGRVH6HQLD32CESKXZ3BUDJN36J
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X7HP5WGRVH6HQLD32CESKXZ3BUDJN36J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

For drivers that moderate access to the underlying hardware it is
sometimes desirable to allow userspace to bypass restrictions. Once
userspace has done this, the driver can no longer guarantee the sanctity
of either the OS or the hardware. When in this state, it is helpful for
kernel developers to be made aware (via this taint flag) of this fact
for subsequent bug reports.

Example usage:
- Hardware xyzzy accepts 2 commands, waldo and fred.
- The xyzzy driver provides an interface for using waldo, but not fred.
- quux is convinced they really need the fred command.
- xyzzy driver allows quux to frob hardware to initiate fred.
  - kernel gets tainted.
- turns out fred command is borked, and scribbles over memory.
- developers laugh while closing quux's subsequent bug report.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/admin-guide/sysctl/kernel.rst   | 1 +
 Documentation/admin-guide/tainted-kernels.rst | 6 +++++-
 include/linux/kernel.h                        | 3 ++-
 kernel/panic.c                                | 1 +
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 1d56a6b73a4e..3e1eada53504 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1352,6 +1352,7 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
  32768  `(K)`  kernel has been live patched
  65536  `(X)`  Auxiliary taint, defined and used by for distros
 131072  `(T)`  The kernel was built with the struct randomization plugin
+262144  `(H)`  The kernel has allowed vendor shenanigans
 ======  =====  ==============================================================
 
 See :doc:`/admin-guide/tainted-kernels` for more information.
diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index ceeed7b0798d..ee2913316344 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -74,7 +74,7 @@ a particular type of taint. It's best to leave that to the aforementioned
 script, but if you need something quick you can use this shell command to check
 which bits are set::
 
-	$ for i in $(seq 18); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
+	$ for i in $(seq 19); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
 
 Table for decoding tainted state
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -100,6 +100,7 @@ Bit  Log  Number  Reason that got the kernel tainted
  15  _/K   32768  kernel has been live patched
  16  _/X   65536  auxiliary taint, defined for and used by distros
  17  _/T  131072  kernel was built with the struct randomization plugin
+ 18  _/H  262144  kernel has allowed vendor shenanigans
 ===  ===  ======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
@@ -175,3 +176,6 @@ More detailed explanation for tainting
      produce extremely unusual kernel structure layouts (even performance
      pathological ones), which is important to know when debugging. Set at
      build time.
+
+ 18) ``H`` Kernel has allowed direct access to hardware and can no longer make
+     any guarantees about the stability of the device or driver.
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f7902d8c1048..bc95486f817e 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -443,7 +443,8 @@ extern enum system_states {
 #define TAINT_LIVEPATCH			15
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
-#define TAINT_FLAGS_COUNT		18
+#define TAINT_RAW_PASSTHROUGH		18
+#define TAINT_FLAGS_COUNT		19
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/kernel/panic.c b/kernel/panic.c
index 332736a72a58..dff22bd80eaf 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -386,6 +386,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
+	[ TAINT_RAW_PASSTHROUGH ]	= { 'H', ' ', true },
 };
 
 /**
-- 
2.30.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
