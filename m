Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE1F34F73E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Mar 2021 05:12:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 98E98100EB332;
	Tue, 30 Mar 2021 20:12:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2CC2E100EB323
	for <linux-nvdimm@lists.01.org>; Tue, 30 Mar 2021 20:12:50 -0700 (PDT)
IronPort-SDR: PEQGl2zOqWkOdt3IPsyYyWD/goHMxxLL6I/kqWXcZ6YqmFM4qPFxbBACJIpxIa3EBrxgnw3evp
 K167W3oOoM2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179035534"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400";
   d="scan'208";a="179035534"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 20:12:50 -0700
IronPort-SDR: ah/oYgQQVMTxNEhRuqrBu9AjlMr9xU+wiuaar9ZDwf/qH4OQhJVT3i7IsFGZXb/oRrYZbe2iDy
 6teRvFN2mtlQ==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400";
   d="scan'208";a="438581744"
Received: from choffma1-mobl.amr.corp.intel.com (HELO omniknight.intel.com) ([10.212.71.210])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 20:12:49 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH 3/3] libndctl: check for active system-ram before disabling daxctl devices
Date: Tue, 30 Mar 2021 21:12:29 -0600
Message-Id: <20210331031229.384068-4-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331031229.384068-1-vishal.l.verma@intel.com>
References: <20210331031229.384068-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 7IB5YTDWAB5QQIVLXSH6P37UQCPEZFRN
X-Message-ID-Hash: 7IB5YTDWAB5QQIVLXSH6P37UQCPEZFRN
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Hansen <dave.hansen@linux.intel.com>, Chunye Xu <chunye.xu@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7IB5YTDWAB5QQIVLXSH6P37UQCPEZFRN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Teach ndctl_namespace_disable_safe() to look at the state of a
daxctl_dev with respect to whether it is active in 'system-ram' mode
before disabling it. This is similar to checking whether a filesystem is
actively mounted on a namespace before disabling it.

Without this, libndctl would happily disable a devdax namespace while the
device was active in system-ram mode. If the namespace was subsequently
also destroyed, this would leave the memory without any sort of a
'handle' to perform any subsequent operation on it, and the system would
have to be rebooted to get out of this situation.

Reported-by: Chunye Xu <chunye.xu@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl/lib/libndctl.c   | 25 ++++++++++++++++++++++++-
 test/daxctl-devices.sh | 16 ++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 2f6d806..2eda56c 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -4593,21 +4593,40 @@ NDCTL_EXPORT int ndctl_namespace_disable_invalidate(struct ndctl_namespace *ndns
 	return ndctl_namespace_disable(ndns);
 }
 
+static int ndctl_dax_has_active_memory(struct ndctl_dax *dax)
+{
+	struct daxctl_region *dax_region;
+	struct daxctl_dev *dax_dev;
+
+	dax_region = ndctl_dax_get_daxctl_region(dax);
+	if (!dax_region)
+		return 0;
+
+	daxctl_dev_foreach(dax_region, dax_dev)
+		if (daxctl_dev_has_online_memory(dax_dev))
+			return 1;
+
+	return 0;
+}
+
 NDCTL_EXPORT int ndctl_namespace_disable_safe(struct ndctl_namespace *ndns)
 {
 	const char *devname = ndctl_namespace_get_devname(ndns);
 	struct ndctl_ctx *ctx = ndctl_namespace_get_ctx(ndns);
 	struct ndctl_pfn *pfn = ndctl_namespace_get_pfn(ndns);
 	struct ndctl_btt *btt = ndctl_namespace_get_btt(ndns);
+	struct ndctl_dax *dax = ndctl_namespace_get_dax(ndns);
 	const char *bdev = NULL;
+	int fd, active = 0;
 	char path[50];
-	int fd;
 	unsigned long long size = ndctl_namespace_get_size(ndns);
 
 	if (pfn && ndctl_pfn_is_enabled(pfn))
 		bdev = ndctl_pfn_get_block_device(pfn);
 	else if (btt && ndctl_btt_is_enabled(btt))
 		bdev = ndctl_btt_get_block_device(btt);
+	else if (dax && ndctl_dax_is_enabled(dax))
+		active = ndctl_dax_has_active_memory(dax);
 	else if (ndctl_namespace_is_enabled(ndns))
 		bdev = ndctl_namespace_get_block_device(ndns);
 
@@ -4632,6 +4651,10 @@ NDCTL_EXPORT int ndctl_namespace_disable_safe(struct ndctl_namespace *ndns)
 					devname, bdev, strerror(errno));
 			return -errno;
 		}
+	} else if (active) {
+		dbg(ctx, "%s: active as system-ram, refusing to disable\n",
+				devname);
+		return -EBUSY;
 	} else {
 		if (size == 0)
 			/* No disable necessary due to no capacity allocated */
diff --git a/test/daxctl-devices.sh b/test/daxctl-devices.sh
index eed5906..56c9691 100755
--- a/test/daxctl-devices.sh
+++ b/test/daxctl-devices.sh
@@ -105,6 +105,22 @@ daxctl_test()
 	"$DAXCTL" reconfigure-device -f -m devdax "$daxdev"
 	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
 
+	# fail 'ndctl-disable-namespace' while the devdax namespace is active
+	# as system-ram. If this test fails, a reboot will be required to
+	# recover from the resulting state.
+	test -n "$testdev"
+	"$DAXCTL" reconfigure-device -m system-ram "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "system-ram" ]]
+	if ! "$NDCTL" disable-namespace "$testdev"; then
+		echo "disable-namespace failed as expected"
+	else
+		echo "disable-namespace succeded, expected failure"
+		echo "reboot required to recover from this state"
+		return 1
+	fi
+	"$DAXCTL" reconfigure-device -f -m devdax "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+
 	# this tests for reconfiguration failure if an online-policy is set
 	set_online_policy
 	: "This command is expected to fail:"
-- 
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
