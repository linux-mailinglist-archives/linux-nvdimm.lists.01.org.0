Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672EF17493D
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:36:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB75F10FC340E;
	Sat, 29 Feb 2020 12:37:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5D08610FC33F3
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:37:43 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:51 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="231411379"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:49 -0800
Subject: [ndctl PATCH 08/36] ndctl/namespace: Emit better errors on failure
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 29 Feb 2020 12:20:45 -0800
Message-ID: <158300764577.2141307.437568876961580865.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: HZJ3W6LWWR6DHGHHVPE3IXG6WDHESRRR
X-Message-ID-Hash: HZJ3W6LWWR6DHGHHVPE3IXG6WDHESRRR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HZJ3W6LWWR6DHGHHVPE3IXG6WDHESRRR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When namespace creation fails, useful information about the reason is
not available unless the command happened to be run with the verbose. It
is needlessly confusing and user-unfriendly.

Introduce a new err() facility and use it to replace the debug() prints
that are actually error reasons. The err() helper suppresses the cryptic
strerror() summary message at the end of the call, but if no error
message was printed then the summary message is the fallback.

Some existing error() calls are also move to err().

Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |   74 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 994b4e8791ea..b967e9be578f 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -57,6 +57,8 @@ static struct parameters {
 	.autolabel = true,
 };
 
+const char *cmd_name = "namespace";
+
 void builtin_xaction_namespace_reset(void)
 {
 	/*
@@ -88,6 +90,10 @@ struct parsed_parameters {
 		do { } while (0); \
 	}})
 
+static int err_count;
+#define err(fmt, ...) \
+	({ err_count++; error("%s: " fmt, cmd_name, ##__VA_ARGS__); })
+
 #define BASE_OPTIONS() \
 OPT_STRING('b', "bus", &param.bus, "bus-id", \
 	"limit namespace to a bus with an id or provider of <bus-id>"), \
@@ -325,7 +331,7 @@ static const char *parse_namespace_options(int argc, const char **argv,
 do { \
 	int __rc = prefix##_##op(dev, p); \
 	if (__rc) { \
-		debug("%s: " #op " failed: %s\n", \
+		err("%s: " #op " failed: %s\n", \
 				prefix##_get_devname(dev), \
 				strerror(abs(__rc))); \
 		return __rc; \
@@ -475,6 +481,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 	unsigned long long size_align, units = 1, resource;
 	struct ndctl_pfn *pfn = NULL;
 	struct ndctl_dax *dax = NULL;
+	unsigned long region_align;
 	unsigned int ways;
 	int rc = 0;
 
@@ -492,7 +499,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 
 	if (param.uuid) {
 		if (uuid_parse(param.uuid, p->uuid) != 0) {
-			debug("%s: invalid uuid\n", __func__);
+			err("%s: invalid uuid\n", __func__);
 			return -EINVAL;
 		}
 	} else
@@ -504,7 +511,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 		rc = snprintf(p->name, sizeof(p->name), "%s",
 				ndctl_namespace_get_alt_name(ndns));
 	if (rc >= (int) sizeof(p->name)) {
-		debug("%s: alt name overflow\n", __func__);
+		err("%s: alt name overflow\n", __func__);
 		return -EINVAL;
 	}
 
@@ -523,7 +530,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 		if (ndctl_region_get_type(region) != ND_DEVICE_REGION_PMEM
 				&& (p->mode == NDCTL_NS_MODE_MEMORY
 					|| p->mode == NDCTL_NS_MODE_DAX)) {
-			debug("blk %s does not support %s mode\n", region_name,
+			err("blk %s does not support %s mode\n", region_name,
 					p->mode == NDCTL_NS_MODE_MEMORY
 					? "fsdax" : "devdax");
 			return -EAGAIN;
@@ -534,7 +541,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 	if (p->mode == NDCTL_NS_MODE_MEMORY) {
 		pfn = ndctl_region_get_pfn_seed(region);
 		if (!pfn && param.mode_default) {
-			debug("%s fsdax mode not available\n", region_name);
+			err("%s fsdax mode not available\n", region_name);
 			p->mode = NDCTL_NS_MODE_RAW;
 		}
 		/*
@@ -671,7 +678,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 		p->size++;
 		p->size *= size_align;
 		p->size /= units;
-		error("'--size=' must align to interleave-width: %d and alignment: %ld\n"
+		err("'--size=' must align to interleave-width: %d and alignment: %ld\n"
 				"did you intend --size=%lld%s?\n",
 				ways, p->align, p->size, suffix);
 		return -EINVAL;
@@ -685,7 +692,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 		btt = ndctl_region_get_btt_seed(region);
 		if (p->mode == NDCTL_NS_MODE_SAFE) {
 			if (!btt) {
-				debug("%s: does not support 'sector' mode\n",
+				err("%s: does not support 'sector' mode\n",
 						region_name);
 				return -EINVAL;
 			}
@@ -695,7 +702,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 						== p->sector_size)
 					break;
 			if (i >= num) {
-				debug("%s: does not support btt sector_size %lu\n",
+				err("%s: does not support btt sector_size %lu\n",
 						region_name, p->sector_size);
 				return -EINVAL;
 			}
@@ -710,7 +717,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 						== p->sector_size)
 					break;
 			if (i >= num) {
-				debug("%s: does not support namespace sector_size %lu\n",
+				err("%s: does not support namespace sector_size %lu\n",
 						region_name, p->sector_size);
 				return -EINVAL;
 			}
@@ -752,7 +759,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 
 		if (ndns && p->mode != NDCTL_NS_MODE_MEMORY
 			&& p->mode != NDCTL_NS_MODE_DAX) {
-			debug("%s: --map= only valid for fsdax mode namespace\n",
+			err("%s: --map= only valid for fsdax mode namespace\n",
 				ndctl_namespace_get_devname(ndns));
 			return -EINVAL;
 		}
@@ -850,7 +857,7 @@ static int zero_info_block(struct ndctl_namespace *ndns)
 	ndctl_namespace_set_raw_mode(ndns, 1);
 	rc = ndctl_namespace_enable(ndns);
 	if (rc < 0) {
-		debug("%s failed to enable for zeroing, continuing\n", devname);
+		err("%s failed to enable for zeroing, continuing\n", devname);
 		rc = 1;
 		goto out;
 	}
@@ -867,7 +874,7 @@ static int zero_info_block(struct ndctl_namespace *ndns)
 	sprintf(path, "/dev/%s", ndctl_namespace_get_block_device(ndns));
 	fd = open(path, O_RDWR|O_DIRECT|O_EXCL);
 	if (fd < 0) {
-		debug("%s: failed to open %s to zero info block\n",
+		err("%s: failed to open %s to zero info block\n",
 				devname, path);
 		goto out;
 	}
@@ -875,7 +882,7 @@ static int zero_info_block(struct ndctl_namespace *ndns)
 	memset(buf, 0, info_size);
 	rc = pread(fd, read_buf, info_size, 0);
 	if (rc < info_size) {
-		debug("%s: failed to read info block, continuing\n",
+		err("%s: failed to read info block, continuing\n",
 			devname);
 	}
 	if (memcmp(buf, read_buf, info_size) == 0) {
@@ -885,7 +892,7 @@ static int zero_info_block(struct ndctl_namespace *ndns)
 
 	rc = pwrite(fd, buf, info_size, 0);
 	if (rc < info_size) {
-		debug("%s: failed to zero info block %s\n",
+		err("%s: failed to zero info block %s\n",
 				devname, path);
 		rc = -ENXIO;
 	} else
@@ -1046,7 +1053,7 @@ retry:
 out:
 	ndctl_region_enable(region);
 	if (ndctl_region_get_nstype(region) != ND_DEVICE_NAMESPACE_PMEM) {
-		debug("%s: failed to initialize labels\n",
+		err("%s: failed to initialize labels\n",
 				ndctl_region_get_devname(region));
 		return -EBUSY;
 	}
@@ -1101,19 +1108,19 @@ static int bus_send_clear(struct ndctl_bus *bus, unsigned long long start,
 	/* get ars_cap */
 	cmd_cap = ndctl_bus_cmd_new_ars_cap(bus, start, size);
 	if (!cmd_cap) {
-		debug("bus: %s failed to create cmd\n", busname);
+		err("bus: %s failed to create cmd\n", busname);
 		return -ENOTTY;
 	}
 
 	rc = ndctl_cmd_submit_xlat(cmd_cap);
 	if (rc < 0) {
-		debug("bus: %s failed to submit cmd: %d\n", busname, rc);
+		err("bus: %s failed to submit cmd: %d\n", busname, rc);
 		goto out_cap;
 	}
 
 	/* send clear_error */
 	if (ndctl_cmd_ars_cap_get_range(cmd_cap, &range)) {
-		debug("bus: %s failed to get ars_cap range\n", busname);
+		err("bus: %s failed to get ars_cap range\n", busname);
 		rc = -ENXIO;
 		goto out_cap;
 	}
@@ -1121,20 +1128,20 @@ static int bus_send_clear(struct ndctl_bus *bus, unsigned long long start,
 	cmd_clear = ndctl_bus_cmd_new_clear_error(range.address,
 					range.length, cmd_cap);
 	if (!cmd_clear) {
-		debug("bus: %s failed to create cmd\n", busname);
+		err("bus: %s failed to create cmd\n", busname);
 		rc = -ENOTTY;
 		goto out_cap;
 	}
 
 	rc = ndctl_cmd_submit_xlat(cmd_clear);
 	if (rc < 0) {
-		debug("bus: %s failed to submit cmd: %d\n", busname, rc);
+		err("bus: %s failed to submit cmd: %d\n", busname, rc);
 		goto out_clr;
 	}
 
 	cleared = ndctl_cmd_clear_error_get_cleared(cmd_clear);
 	if (cleared != range.length) {
-		debug("bus: %s expected to clear: %lld actual: %lld\n",
+		err("bus: %s expected to clear: %lld actual: %lld\n",
 				busname, range.length, cleared);
 		rc = -ENXIO;
 	}
@@ -1356,6 +1363,19 @@ static int do_xaction_namespace(const char *namespace,
 	if (verbose)
 		ndctl_set_log_priority(ctx, LOG_DEBUG);
 
+	if (action == ACTION_ENABLE)
+		cmd_name = "enable namespace";
+	else if (action == ACTION_DISABLE)
+		cmd_name = "disable namespace";
+	else if (action == ACTION_CREATE)
+		cmd_name = "create namespace";
+	else if (action == ACTION_DESTROY)
+		cmd_name = "destroy namespace";
+	else if (action == ACTION_CHECK)
+		cmd_name = "check namespace";
+	else if (action == ACTION_CLEAR)
+		cmd_name = "clear errors namespace";
+
         ndctl_bus_foreach(ctx, bus) {
 		bool do_scrub;
 
@@ -1478,7 +1498,7 @@ int cmd_disable_namespace(int argc, const char **argv, struct ndctl_ctx *ctx)
 	int disabled, rc;
 
 	rc = do_xaction_namespace(namespace, ACTION_DISABLE, ctx, &disabled);
-	if (rc < 0)
+	if (rc < 0 && !err_count)
 		fprintf(stderr, "error disabling namespaces: %s\n",
 				strerror(-rc));
 
@@ -1495,7 +1515,7 @@ int cmd_enable_namespace(int argc, const char **argv, struct ndctl_ctx *ctx)
 	int enabled, rc;
 
 	rc = do_xaction_namespace(namespace, ACTION_ENABLE, ctx, &enabled);
-	if (rc < 0)
+	if (rc < 0 && !err_count)
 		fprintf(stderr, "error enabling namespaces: %s\n",
 				strerror(-rc));
 	fprintf(stderr, "enabled %d namespace%s\n", enabled,
@@ -1525,7 +1545,7 @@ int cmd_create_namespace(int argc, const char **argv, struct ndctl_ctx *ctx)
 	if (param.greedy)
 		fprintf(stderr, "created %d namespace%s\n", created,
 			created == 1 ? "" : "s");
-	if (rc < 0 || (!namespace && created < 1)) {
+	if ((rc < 0 || (!namespace && created < 1)) && !err_count) {
 		fprintf(stderr, "failed to %s namespace: %s\n", namespace
 				? "reconfigure" : "create", strerror(-rc));
 		if (!namespace)
@@ -1543,7 +1563,7 @@ int cmd_destroy_namespace(int argc , const char **argv, struct ndctl_ctx *ctx)
 	int destroyed, rc;
 
 	rc = do_xaction_namespace(namespace, ACTION_DESTROY, ctx, &destroyed);
-	if (rc < 0)
+	if (rc < 0 && !err_count)
 		fprintf(stderr, "error destroying namespaces: %s\n",
 				strerror(-rc));
 	fprintf(stderr, "destroyed %d namespace%s\n", destroyed,
@@ -1559,7 +1579,7 @@ int cmd_check_namespace(int argc , const char **argv, struct ndctl_ctx *ctx)
 	int checked, rc;
 
 	rc = do_xaction_namespace(namespace, ACTION_CHECK, ctx, &checked);
-	if (rc < 0)
+	if (rc < 0 && !err_count)
 		fprintf(stderr, "error checking namespaces: %s\n",
 				strerror(-rc));
 	fprintf(stderr, "checked %d namespace%s\n", checked,
@@ -1575,7 +1595,7 @@ int cmd_clear_errors(int argc , const char **argv, struct ndctl_ctx *ctx)
 	int cleared, rc;
 
 	rc = do_xaction_namespace(namespace, ACTION_CLEAR, ctx, &cleared);
-	if (rc < 0)
+	if (rc < 0 && !err_count)
 		fprintf(stderr, "error clearing namespaces: %s\n",
 				strerror(-rc));
 	fprintf(stderr, "cleared %d namespace%s\n", cleared,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
