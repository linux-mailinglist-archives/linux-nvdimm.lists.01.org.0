Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CED7D18D
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Aug 2019 00:53:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E89DB212FD407;
	Wed, 31 Jul 2019 15:55:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DC52B212E4B59
 for <linux-nvdimm@lists.01.org>; Wed, 31 Jul 2019 15:55:36 -0700 (PDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jul 2019 15:53:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,331,1559545200"; d="scan'208";a="166594533"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by orsmga008.jf.intel.com with ESMTP; 31 Jul 2019 15:53:05 -0700
Date: Wed, 31 Jul 2019 16:53:04 -0600
From: Vishal Verma <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH v8 07/13] daxctl: add a new reconfigure-device
 command
Message-ID: <20190731225258.GA13147@vverma7-desk1.lm.intel.com>
References: <20190727015212.27092-1-vishal.l.verma@intel.com>
 <20190727015212.27092-8-vishal.l.verma@intel.com>
 <3de8c0564d45eb4ef328a48e5ff47220335886b6.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3de8c0564d45eb4ef328a48e5ff47220335886b6.camel@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 07/30, Verma, Vishal L wrote:
> On Fri, 2019-07-26 at 19:52 -0600, Vishal Verma wrote:
> > Add a new command 'daxctl-reconfigure-device'. This is used to switch
> > the mode of a dax device between regular 'device_dax' and
> > 'system-memory'. The command also uses the memory hotplug sysfs
> > interfaces to online the newly available memory when converting to
> > 'system-ram', and to attempt to offline the memory when converting back
> > to a DAX device.
> > 
> > Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > ---
> >  daxctl/Makefile.am |   2 +
> >  daxctl/builtin.h   |   1 +
> >  daxctl/daxctl.c    |   1 +
> >  daxctl/device.c    | 503 +++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 507 insertions(+)
> >  create mode 100644 daxctl/device.c
> > 
> > +static int verify_dax_bus_model(struct daxctl_dev *dev)
> > +{
> 
> I suspect this check is screaming to be moved into the library, and be
> invoked internally by the 'enable' and 'is_enabled' routines.
> 
> When in the dax-class model, a listing of the dax device will currently
> show:
> 
> {
>   "chardev":"dax1.0",
>   "size":799063146496,
>   "target_node":3,
>   "mode":"devdax",
>   "state":"disabled"
> }
> 
> Where the state: disabled is misleading.
>

I think I have all the dax-class oddness fixed with the attached
incremental patch (on top of the series). I'll send a new set with these
changes folded in.

From de16d2c286fac61f25ddfc37943161932cd72bd4 Mon Sep 17 00:00:00 2001
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Wed, 31 Jul 2019 16:47:53 -0600
Subject: [ndctl PATCH] fixup

---
 .../daxctl/daxctl-reconfigure-device.txt      |  5 +-
 daxctl/device.c                               | 56 +------------
 daxctl/lib/libdaxctl.c                        | 78 +++++++++++++++----
 3 files changed, 70 insertions(+), 69 deletions(-)

diff --git a/Documentation/daxctl/daxctl-reconfigure-device.txt b/Documentation/daxctl/daxctl-reconfigure-device.txt
index fe87762..196d692 100644
--- a/Documentation/daxctl/daxctl-reconfigure-device.txt
+++ b/Documentation/daxctl/daxctl-reconfigure-device.txt
@@ -91,8 +91,9 @@ in use (via the dax_pmem_compat driver), the reconfiguration will fail with an
 error such as the following:
 ----
 # daxctl reconfigure-device --mode=system-ram --region=0 all
-dax3.0: dax-class device model unsupported
-error reconfiguring devices: No such device or address
+libdaxctl: daxctl_dev_disable: dax3.0: error: device model is dax-class
+dax3.0: disable failed: Operation not supported
+error reconfiguring devices: Operation not supported
 reconfigured 0 devices
 ----
 
diff --git a/daxctl/device.c b/daxctl/device.c
index 01d057e..4887ccf 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -378,51 +378,6 @@ static int reconfig_mode_devdax(struct daxctl_dev *dev)
 	return 0;
 }
 
-static int verify_dax_bus_model(struct daxctl_dev *dev)
-{
-	const char *devname = daxctl_dev_get_devname(dev);
-	char *dev_path, *subsys_path, *resolved;
-	struct stat sb;
-	int rc;
-
-	if (asprintf(&dev_path, "/dev/%s", devname) < 0)
-		return -ENOMEM;
-
-	rc = lstat(dev_path, &sb);
-	if (rc < 0) {
-		rc = -errno;
-		fprintf(stderr, "%s: stat for %s failed: %s\n",
-			devname, dev_path, strerror(-rc));
-		goto out_dev;;
-	}
-
-	if (asprintf(&subsys_path, "/sys/dev/char/%d:%d/subsystem",
-			major(sb.st_rdev), minor(sb.st_rdev)) < 0) {
-		rc = -ENOMEM;
-		goto out_dev;
-	}
-
-	resolved = realpath(subsys_path, NULL);
-	if (!resolved) {
-		rc = -errno;
-		fprintf(stderr, "%s:  unable to determine subsys: %s\n",
-			devname, strerror(errno));
-		goto out_subsys;
-	}
-
-	if (strcmp(resolved, "/sys/bus/dax") == 0)
-		rc = 0;
-	else
-		rc = -ENXIO;
-
-	free(resolved);
-out_subsys:
-	free(subsys_path);
-out_dev:
-	free(dev_path);
-	return rc;
-}
-
 static int do_reconfig(struct daxctl_dev *dev, enum dev_mode mode,
 		struct json_object **jdevs)
 {
@@ -430,12 +385,6 @@ static int do_reconfig(struct daxctl_dev *dev, enum dev_mode mode,
 	struct json_object *jdev;
 	int rc = 0;
 
-	if (verify_dax_bus_model(dev) != 0) {
-		fprintf(stderr, "%s: dax-class device model unsupported\n",
-			devname);
-		return -ENXIO;
-	}
-
 	switch (mode) {
 	case DAXCTL_DEV_MODE_RAM:
 		rc = reconfig_mode_system_ram(dev);
@@ -449,6 +398,9 @@ static int do_reconfig(struct daxctl_dev *dev, enum dev_mode mode,
 		rc = -EINVAL;
 	}
 
+	if (rc)
+		return rc;
+
 	*jdevs = json_object_new_array();
 	if (*jdevs) {
 		jdev = util_daxctl_dev_to_json(dev, flags);
@@ -456,7 +408,7 @@ static int do_reconfig(struct daxctl_dev *dev, enum dev_mode mode,
 			json_object_array_add(*jdevs, jdev);
 	}
 
-	return rc;
+	return 0;
 }
 
 static int do_xline(struct daxctl_dev *dev, enum device_action action)
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index c2a2a50..066f718 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -355,39 +355,74 @@ static struct kmod_list *to_module_list(struct daxctl_ctx *ctx,
 	return list;
 }
 
-static int dev_is_system_ram_capable(struct daxctl_dev *dev)
+static bool device_model_is_dax_bus(struct daxctl_dev *dev)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char *path = dev->dev_buf, *resolved;
+	size_t len = dev->buf_len;
+	struct stat sb;
+
+	if (snprintf(path, len, "/dev/%s", devname) < 0)
+		return false;
+
+	if (lstat(path, &sb) < 0) {
+		err(ctx, "%s: stat for %s failed: %s\n",
+			devname, path, strerror(errno));
+		return false;
+	}
+
+	if (snprintf(path, len, "/sys/dev/char/%d:%d/subsystem",
+			major(sb.st_rdev), minor(sb.st_rdev)) < 0)
+		return false;
+
+	resolved = realpath(path, NULL);
+	if (!resolved) {
+		err(ctx, "%s:  unable to determine subsys: %s\n",
+			devname, strerror(errno));
+		return false;
+	}
+
+	if (strcmp(resolved, "/sys/bus/dax") == 0) {
+		free(resolved);
+		return true;
+	}
+
+	free(resolved);
+	return false;
+}
+
+static bool dev_is_system_ram_capable(struct daxctl_dev *dev)
 {
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
 	char *mod_path, *mod_base;
 	char path[200];
-	int rc = 0;
 	const int len = sizeof(path);
 
+	if (!device_model_is_dax_bus(dev))
+		return false;
+
 	if (!daxctl_dev_is_enabled(dev))
-		return rc;
+		return false;
 
 	if (snprintf(path, len, "%s/driver/module", dev->dev_path) >= len) {
 		err(ctx, "%s: buffer too small!\n", devname);
-		return -ENXIO;
+		return false;
 	}
 
 	mod_path = realpath(path, NULL);
-	if (!mod_path) {
-		rc = -errno;
-		err(ctx, "%s:  unable to determine module: %s\n", devname,
-			strerror(errno));
-		return rc;
-	}
+	if (!mod_path)
+		return false;
 
 	mod_base = basename(mod_path);
-	if (strcmp(mod_base, dax_modules[DAXCTL_DEV_MODE_RAM]) == 0)
-		rc = 1;
-	else if (strcmp(mod_base, dax_modules[DAXCTL_DEV_MODE_DEVDAX]) == 0)
-		rc = 0;
+	if (strcmp(mod_base, dax_modules[DAXCTL_DEV_MODE_RAM]) == 0) {
+		free(mod_path);
+		return true;
+	}
 
 	free(mod_path);
-	return rc;
+	return false;
 }
 
 /*
@@ -821,6 +856,9 @@ DAXCTL_EXPORT int daxctl_dev_is_enabled(struct daxctl_dev *dev)
 	char *path = dev->dev_buf;
 	int len = dev->buf_len;
 
+	if (!device_model_is_dax_bus(dev))
+		return 1;
+
 	if (snprintf(path, len, "%s/driver", dev->dev_path) >= len) {
 		err(ctx, "%s: buffer too small!\n",
 				daxctl_dev_get_devname(dev));
@@ -877,6 +915,11 @@ static int daxctl_dev_enable(struct daxctl_dev *dev, enum daxctl_dev_mode mode)
 	const char *mod_name = dax_modules[mode];
 	int rc;
 
+	if (!device_model_is_dax_bus(dev)) {
+		err(ctx, "%s: error: device model is dax-class\n", devname);
+		return -EOPNOTSUPP;
+	}
+
 	if (daxctl_dev_is_enabled(dev))
 		return 0;
 
@@ -917,6 +960,11 @@ DAXCTL_EXPORT int daxctl_dev_disable(struct daxctl_dev *dev)
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
 
+	if (!device_model_is_dax_bus(dev)) {
+		err(ctx, "%s: error: device model is dax-class\n", devname);
+		return -EOPNOTSUPP;
+	}
+
 	if (!daxctl_dev_is_enabled(dev))
 		return 0;
 
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
