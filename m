Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A0034F73B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Mar 2021 05:12:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5BFC9100EB329;
	Tue, 30 Mar 2021 20:12:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5CCE5100EB85F
	for <linux-nvdimm@lists.01.org>; Tue, 30 Mar 2021 20:12:48 -0700 (PDT)
IronPort-SDR: V70fN+7E2Kt9hDhhappehkFgNC5iQUrdQJQgy0x7g2Byth+BQlk1Q9HJ/jn9Rs5mf3CIMqfGoi
 NH5lXzAEam/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179035513"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400";
   d="scan'208";a="179035513"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 20:12:48 -0700
IronPort-SDR: 07P68APtm6vdbbMfnPkPEBezEfc2owFP7AQFI2vPCe9PP4p96PwbmoK5P1Ud4y6IIr/6cnm1MD
 y3HoOwRMUpcQ==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400";
   d="scan'208";a="438581731"
Received: from choffma1-mobl.amr.corp.intel.com (HELO omniknight.intel.com) ([10.212.71.210])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 20:12:47 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH 1/3] daxctl: fail reconfigure-device based on kernel onlining policy
Date: Tue, 30 Mar 2021 21:12:27 -0600
Message-Id: <20210331031229.384068-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331031229.384068-1-vishal.l.verma@intel.com>
References: <20210331031229.384068-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 44COBQOGPLMPT3B66EIQ7M3Q7BG6EPGD
X-Message-ID-Hash: 44COBQOGPLMPT3B66EIQ7M3Q7BG6EPGD
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Hansen <dave.hansen@linux.intel.com>, Chunye Xu <chunye.xu@intel.com>, Dave Hansen <dave.hansen@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/44COBQOGPLMPT3B66EIQ7M3Q7BG6EPGD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

If the kernel has a policy set to auto-online any new memory blocks, we
know that an attempt to reconfigure a device either in ZONE_MOVABLE, or
with the --no-online is going to fail. While we detect this race after
the fact, and print a warning, that is often insufficient as the user
may be forced to reboot to get out of the situation, resulting in an
unpleasant experience.

Detect whether the kernel policy is set to auto-online. If so, fail
device reconfigure operations that we know can't be satisfied. Allow
for overriding this safety check via the -f (--force) option. Update the
man page to talk about this, and the unit test to test for an expected
failure by enabling auto-onlining.

Cc: Dave Hansen <dave.hansen@intel.com>
Reported-by: Chunye Xu <chunye.xu@intel.com>
Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 .../daxctl/daxctl-reconfigure-device.txt      | 12 ++++++-
 daxctl/lib/libdaxctl-private.h                |  1 +
 daxctl/lib/libdaxctl.c                        | 21 +++++++++++
 daxctl/libdaxctl.h                            |  1 +
 daxctl/device.c                               | 10 ++++++
 daxctl/lib/libdaxctl.sym                      |  5 +++
 test/daxctl-devices.sh                        | 36 +++++++++++++++++++
 7 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/Documentation/daxctl/daxctl-reconfigure-device.txt b/Documentation/daxctl/daxctl-reconfigure-device.txt
index ad33eda..f112b3c 100644
--- a/Documentation/daxctl/daxctl-reconfigure-device.txt
+++ b/Documentation/daxctl/daxctl-reconfigure-device.txt
@@ -119,6 +119,10 @@ recommended to use the --no-online option described below. This will abridge
 the device reconfiguration operation to just hotplugging the memory, and
 refrain from then onlining it.
 
+In case daxctl detects that there is a kernel policy to auto-online blocks
+(via /sys/devices/system/memory/auto_online_blocks), then reconfiguring to
+system-ram will result in a failure. This can be overridden with '--force'.
+
 OPTIONS
 -------
 include::region-option.txt[]
@@ -162,12 +166,18 @@ include::movable-options.txt[]
 
 -f::
 --force::
-	When converting from "system-ram" mode to "devdax", it is expected
+	- When converting from "system-ram" mode to "devdax", it is expected
 	that all the memory sections are first made offline. By default,
 	daxctl won't touch online memory. However with this option, attempt
 	to offline the memory on the NUMA node associated with the dax device
 	before converting it back to "devdax" mode.
 
+	- Additionally, if a kernel policy to auto-online blocks is detected,
+	reconfiguration to system-ram fails. With this option, the failure can
+	be overridden to allow reconfiguration regardless of kernel policy.
+	Doing this may result in a successful reconfiguration, but it may
+	not be possible to subsequently offline the memory without a reboot.
+
 
 include::human-option.txt[]
 
diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
index af257fd..ae45311 100644
--- a/daxctl/lib/libdaxctl-private.h
+++ b/daxctl/lib/libdaxctl-private.h
@@ -111,6 +111,7 @@ struct daxctl_memory {
 	char *node_path;
 	unsigned long block_size;
 	enum memory_zones zone;
+	bool auto_online;
 };
 
 
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 479e8f6..879f7e6 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1644,3 +1644,24 @@ DAXCTL_EXPORT int daxctl_memory_is_movable(struct daxctl_memory *mem)
 		return rc;
 	return (mem->zone == MEM_ZONE_MOVABLE) ? 1 : 0;
 }
+
+DAXCTL_EXPORT int daxctl_dev_will_auto_online_memory(struct daxctl_dev *dev)
+{
+	const char *auto_path = "/sys/devices/system/memory/auto_online_blocks";
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char buf[SYSFS_ATTR_SIZE];
+
+	/*
+	 * If we can't read the policy for some reason, don't fail yet. Assume
+	 * the auto-onlining policy is absent, and carry on. If onlining blocks
+	 * does result in the memory being in an inconsistent state, we have a
+	 * check and warning for it after the fact
+	 */
+	if (sysfs_read_attr(ctx, auto_path, buf) != 0)
+		err(ctx, "%s: Unable to determine auto-online policy: %s\n",
+				devname, strerror(errno));
+
+	/* match both "online" and "online_movable" */
+	return !strncmp(buf, "online", 6);
+}
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index e82b274..30ab51a 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -71,6 +71,7 @@ int daxctl_dev_disable(struct daxctl_dev *dev);
 int daxctl_dev_enable_devdax(struct daxctl_dev *dev);
 int daxctl_dev_enable_ram(struct daxctl_dev *dev);
 int daxctl_dev_get_target_node(struct daxctl_dev *dev);
+int daxctl_dev_will_auto_online_memory(struct daxctl_dev *dev);
 
 struct daxctl_memory;
 struct daxctl_memory *daxctl_dev_get_memory(struct daxctl_dev *dev);
diff --git a/daxctl/device.c b/daxctl/device.c
index 0721a57..a427b7d 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -541,8 +541,18 @@ static int disable_devdax_device(struct daxctl_dev *dev)
 
 static int reconfig_mode_system_ram(struct daxctl_dev *dev)
 {
+	const char *devname = daxctl_dev_get_devname(dev);
 	int rc, skip_enable = 0;
 
+	if (param.no_online || !param.no_movable) {
+		if (!param.force && daxctl_dev_will_auto_online_memory(dev)) {
+			fprintf(stderr,
+				"%s: error: kernel policy will auto-online memory, aborting\n",
+				devname);
+			return -EBUSY;
+		}
+	}
+
 	if (daxctl_dev_is_enabled(dev)) {
 		rc = disable_devdax_device(dev);
 		if (rc < 0)
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index a4e1684..892e393 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -91,3 +91,8 @@ global:
 	daxctl_mapping_get_size;
 	daxctl_dev_set_mapping;
 } LIBDAXCTL_7;
+
+LIBDAXCTL_9 {
+global:
+	daxctl_dev_will_auto_online_memory;
+} LIBDAXCTL_8;
diff --git a/test/daxctl-devices.sh b/test/daxctl-devices.sh
index 496e4f2..eed5906 100755
--- a/test/daxctl-devices.sh
+++ b/test/daxctl-devices.sh
@@ -64,6 +64,26 @@ daxctl_get_mode()
 	"$DAXCTL" list -d "$1" | jq -er '.[].mode'
 }
 
+set_online_policy()
+{
+	echo "online" > /sys/devices/system/memory/auto_online_blocks
+}
+
+unset_online_policy()
+{
+	echo "offline" > /sys/devices/system/memory/auto_online_blocks
+}
+
+save_online_policy()
+{
+	saved_policy="$(cat /sys/devices/system/memory/auto_online_blocks)"
+}
+
+restore_online_policy()
+{
+	echo "$saved_policy" > /sys/devices/system/memory/auto_online_blocks
+}
+
 daxctl_test()
 {
 	local daxdev
@@ -71,6 +91,9 @@ daxctl_test()
 	daxdev=$(daxctl_get_dev "$testdev")
 	test -n "$daxdev"
 
+	# these tests need to run with kernel onlining policy turned off
+	save_online_policy
+	unset_online_policy
 	"$DAXCTL" reconfigure-device -N -m system-ram "$daxdev"
 	[[ $(daxctl_get_mode "$daxdev") == "system-ram" ]]
 	"$DAXCTL" online-memory "$daxdev"
@@ -81,6 +104,19 @@ daxctl_test()
 	[[ $(daxctl_get_mode "$daxdev") == "system-ram" ]]
 	"$DAXCTL" reconfigure-device -f -m devdax "$daxdev"
 	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+
+	# this tests for reconfiguration failure if an online-policy is set
+	set_online_policy
+	: "This command is expected to fail:"
+	if ! "$DAXCTL" reconfigure-device -N -m system-ram "$daxdev"; then
+		echo "reconfigure failed as expected"
+	else
+		echo "reconfigure succeded, expected failure"
+		restore_online_policy
+		return 1
+	fi
+
+	restore_online_policy
 }
 
 find_testdev
-- 
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
