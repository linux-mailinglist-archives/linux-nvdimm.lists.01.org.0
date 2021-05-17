Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36056382744
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 May 2021 10:43:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E3C78100EB83E;
	Mon, 17 May 2021 01:43:24 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3440E100EB83C
	for <linux-nvdimm@lists.01.org>; Mon, 17 May 2021 01:43:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g24so3261179pji.4
        for <linux-nvdimm@lists.01.org>; Mon, 17 May 2021 01:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KaOCXsVkJiWJFh7uxvmdrcNTyQdi3/Y8ExfCK7odyDs=;
        b=BRniKKjqowuQly3YQ1F+w9n1V2U+WweltMH6F3gNP7pRfJSWG6E7nu4l05wKyTc0fP
         nrDNXkqtnOGO9KnyM5cGfslvgvmyfwMCHY/bq/tIOanyccff4tX4Fmi0j9s8TfVThLtd
         OpMDeEu2qBloZvK19MZ5dyT3eZCTb+m3EvBa06O2pockIxn4evEPZVTR9qG1Idlxpxa5
         Nf70D3RV9lPuqHc6HPoLUjpq9AGd/II+bKSp2HJ7fwPQgUuXL+NoeD4aQbyvynQzrfZp
         v2YZIolmm7zQx1rMyI5y8Q1oOGCX/W2IOLfkrh96dWoTs+GeRyVJ/UG0/1y9MERfeA0d
         S8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KaOCXsVkJiWJFh7uxvmdrcNTyQdi3/Y8ExfCK7odyDs=;
        b=OCK4P0Wen3o3oq8TCF+XFNRHwt6FwNJzDao3W9OeI53eUPSzC2zICmawms9cvEOgJc
         V2Xa+fCETN8/NQFa+zhSJ15/pPVcHHO60hM2isTkqPc7QB+VjwUiKt4MG5CojBQ85pj8
         W7PF0QdZkTv8//acjA2AM8HSnyxxxIX8x3L+8WtNiXRS+ytpL+G1dd05nAL/im2vI9F8
         6/UL+l0izUCYOyPXHybEEkSv+U7Bckz4OBn2K1mqfkHGybN+LrQJR8xalZ6rlxR76KBz
         dMHoN3LKT5Z7zssK7hDLdgSbijk199QOCKp9Fb/dieCJB61XJdPQH+9jXEwqZ9KhaLVi
         tizQ==
X-Gm-Message-State: AOAM533uOIxa0waqOj0L+adFXK1zJ/5xUFaHAFCyEhR5G0h30dXNHaEO
	E/q+wlW+VSdjJzdAvX6/uvi6Vg3j0qu2ZQ==
X-Google-Smtp-Source: ABdhPJwV6k48stTIHcPjA9xh82EwbITsEggSOZWbforpgAmyhJGkNOKHOHy6wCPVJDV4wLM1fP9tfw==
X-Received: by 2002:a17:90a:f491:: with SMTP id bx17mr25939108pjb.176.1621241001483;
        Mon, 17 May 2021 01:43:21 -0700 (PDT)
Received: from desktop.fossix.local ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id z24sm2715254pfk.150.2021.05.17.01.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 01:43:21 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>
Subject: [ndctl v2 2/4] papr: ndtest: Enable smart test cases
Date: Mon, 17 May 2021 14:12:57 +0530
Message-Id: <20210517084259.181236-2-santosh@fossix.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517084259.181236-1-santosh@fossix.org>
References: <20210517084259.181236-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: AMHUCLETDTUHFCVIKBD4RD7QERYNER7M
X-Message-ID-Hash: AMHUCLETDTUHFCVIKBD4RD7QERYNER7M
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AMHUCLETDTUHFCVIKBD4RD7QERYNER7M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>

The patch implements all necessary smart APIs for the
ndtest kernel driver.

Both inject-smart.sh and monitor.sh tests pass with the patch.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
---
 ndctl/lib/papr.c      | 313 ++++++++++++++++++++++++++++++++++++++++++
 ndctl/lib/papr.h      |   9 ++
 ndctl/lib/papr_pdsm.h |  50 ++++++-
 3 files changed, 371 insertions(+), 1 deletion(-)

diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c
index 9c6f2f0..f94f8aa 100644
--- a/ndctl/lib/papr.c
+++ b/ndctl/lib/papr.c
@@ -165,6 +165,18 @@ static unsigned int papr_smart_get_flags(struct ndctl_cmd *cmd)
 		if (health.extension_flags & PDSM_DIMM_HEALTH_RUN_GAUGE_VALID)
 			flags |= ND_SMART_USED_VALID;
 
+		if (health.extension_flags & PDSM_DIMM_HEALTH_MEDIA_TEMPERATURE_VALID)
+			flags |= ND_SMART_MTEMP_VALID;
+
+		if (health.extension_flags & PDSM_DIMM_HEALTH_CTRL_TEMPERATURE_VALID)
+			flags |= ND_SMART_CTEMP_VALID;
+
+		if (health.extension_flags & PDSM_DIMM_HEALTH_SPARES_VALID)
+			flags |= ND_SMART_SPARES_VALID;
+
+		if (health.extension_flags & PDSM_DIMM_HEALTH_ALARM_VALID)
+			flags |= ND_SMART_ALARM_VALID;
+
 		return flags;
 	}
 
@@ -201,6 +213,26 @@ static unsigned int papr_smart_get_health(struct ndctl_cmd *cmd)
 	return  !health.dimm_health ? 0 : 1 << (health.dimm_health - 1);
 }
 
+static int papr_pdsm_health_set_threshold_valid(struct ndctl_cmd *cmd)
+{
+       if (!cmd_is_valid(cmd) ||
+           to_pdsm(cmd)->cmd_status != 0 ||
+           to_pdsm_cmd(cmd) != PAPR_PDSM_HEALTH_THRESHOLD_SET) {
+               return -EINVAL;
+       }
+
+       return 0;
+}
+
+static unsigned int papr_cmd_smart_threshold_get_supported_alarms(
+               struct ndctl_cmd *cmd)
+{
+       if (papr_pdsm_health_set_threshold_valid(cmd) < 0)
+               return 0;
+       return ND_SMART_SPARE_TRIP | ND_SMART_MTEMP_TRIP
+               | ND_SMART_CTEMP_TRIP;
+}
+
 static unsigned int papr_smart_get_shutdown_state(struct ndctl_cmd *cmd)
 {
 	struct nd_papr_pdsm_health health;
@@ -218,6 +250,126 @@ static unsigned int papr_smart_get_shutdown_state(struct ndctl_cmd *cmd)
 	return health.dimm_bad_shutdown;
 }
 
+static int papr_smart_inject_supported(struct ndctl_dimm *dimm)
+{
+	struct ndctl_ctx *ctx = ndctl_dimm_get_ctx(dimm);
+
+	if (!ndctl_dimm_is_cmd_supported(dimm, ND_CMD_CALL)) {
+		dbg(ctx, "unsupported cmd: %d\n", ND_CMD_CALL);
+		return -EOPNOTSUPP;
+	}
+
+	if (!test_dimm_dsm(dimm, PAPR_PDSM_HEALTH_INJECT)) {
+		dbg(ctx, "smart injection functions unsupported\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int papr_smart_inject_valid(struct ndctl_cmd *cmd)
+{
+	if (cmd->type != ND_CMD_CALL ||
+			to_pdsm(cmd)->cmd_status != 0 ||
+			to_pdsm_cmd(cmd) != PAPR_PDSM_HEALTH_INJECT)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int papr_cmd_smart_inject_media_temperature(struct ndctl_cmd *cmd,
+		bool enable, unsigned int mtemp)
+{
+	if (papr_smart_inject_valid(cmd) < 0)
+		return -EINVAL;
+
+	to_payload(cmd)->inject.flags |= ND_PAPR_SMART_INJECT_MTEMP;
+	to_payload(cmd)->inject.mtemp_enable = enable == true;
+	to_payload(cmd)->inject.media_temperature = mtemp;
+
+	return 0;
+}
+
+static int papr_cmd_smart_inject_ctrl_temperature(struct ndctl_cmd *cmd,
+		bool enable, unsigned int mtemp)
+{
+	if (papr_smart_inject_valid(cmd) < 0)
+		return -EINVAL;
+
+	to_payload(cmd)->inject.flags |= ND_PAPR_SMART_INJECT_MTEMP;
+	to_payload(cmd)->inject.ctemp_enable = enable == true;
+	to_payload(cmd)->inject.ctrl_temperature = mtemp;
+
+	return 0;
+}
+
+static int papr_cmd_smart_inject_spares(struct ndctl_cmd *cmd,
+		bool enable, unsigned int spares)
+{
+	if (papr_smart_inject_valid(cmd) < 0)
+		return -EINVAL;
+
+	to_payload(cmd)->inject.flags |= ND_PAPR_SMART_INJECT_SPARES;
+	to_payload(cmd)->inject.spares_enable = enable == true;
+	to_payload(cmd)->inject.spares = spares;
+
+	return 0;
+}
+
+static struct ndctl_cmd *papr_new_smart_inject(struct ndctl_dimm *dimm)
+{
+	struct ndctl_cmd *cmd;
+
+	cmd = allocate_cmd(dimm, PAPR_PDSM_HEALTH_INJECT,
+			sizeof(struct nd_papr_pdsm_health_inject));
+	if (!cmd)
+		return NULL;
+
+	return cmd;
+}
+
+static struct ndctl_cmd *papr_dimm_cmd_new_smart_set_threshold(
+		struct ndctl_cmd *threshold_cmd)
+{
+	struct ndctl_cmd *set_cmd;
+	struct nd_papr_pdsm_health_threshold thresh;
+
+	if (!cmd_is_valid(threshold_cmd) ||
+	    to_pdsm(threshold_cmd)->cmd_status != 0 ||
+	    to_pdsm_cmd(threshold_cmd) != PAPR_PDSM_HEALTH_THRESHOLD) {
+		return NULL;
+	}
+
+	thresh = to_payload(threshold_cmd)->threshold;
+
+	set_cmd = allocate_cmd(threshold_cmd->dimm, PAPR_PDSM_HEALTH_THRESHOLD_SET,
+			sizeof(struct nd_papr_pdsm_health_threshold));
+	if (!set_cmd)
+		return NULL;
+
+	set_cmd->source = threshold_cmd;
+	ndctl_cmd_ref(threshold_cmd);
+
+	to_payload(set_cmd)->threshold.alarm_control = thresh.alarm_control;
+	to_payload(set_cmd)->threshold.spares = thresh.spares;
+	to_payload(set_cmd)->threshold.media_temperature = thresh.media_temperature;
+	to_payload(set_cmd)->threshold.ctrl_temperature = thresh.ctrl_temperature;
+
+	return set_cmd;
+}
+
+static struct ndctl_cmd *papr_cmd_new_smart_threshold(struct ndctl_dimm *dimm)
+{
+	struct ndctl_cmd *cmd;
+
+	cmd = allocate_cmd(dimm, PAPR_PDSM_HEALTH_THRESHOLD,
+			sizeof(struct nd_papr_pdsm_health_threshold));
+	if (!cmd)
+		return NULL;
+
+	return cmd;
+}
+
 static unsigned int papr_smart_get_life_used(struct ndctl_cmd *cmd)
 {
 	struct nd_papr_pdsm_health health;
@@ -236,13 +388,174 @@ static unsigned int papr_smart_get_life_used(struct ndctl_cmd *cmd)
 		(100 - health.dimm_fuel_gauge) : 0;
 }
 
+static int papr_cmd_smart_inject_fatal(struct ndctl_cmd *cmd, bool enable)
+{
+	if (papr_smart_inject_valid(cmd) < 0)
+		return -EINVAL;
+
+	to_payload(cmd)->inject.flags |= ND_PAPR_SMART_INJECT_FATAL;
+	to_payload(cmd)->inject.fatal_enable = enable == true;
+
+	return 0;
+}
+
+static int papr_cmd_smart_inject_unsafe_shutdown(struct ndctl_cmd *cmd,
+							bool enable)
+{
+	if (papr_smart_inject_valid(cmd) < 0)
+		return -EINVAL;
+
+	to_payload(cmd)->inject.flags |= ND_PAPR_SMART_INJECT_SHUTDOWN;
+	to_payload(cmd)->inject.unsafe_shutdown_enable = enable == true;
+
+	return 0;
+}
+
+static unsigned int papr_cmd_smart_threshold_get_alarm_control(struct ndctl_cmd *cmd)
+{
+	int rc = 0;
+	unsigned int flags = 0;
+	struct nd_pkg_pdsm *pcmd = to_pdsm(cmd);
+	struct nd_papr_pdsm_health_threshold threshold;
+
+	if (!cmd_is_valid(cmd) ||
+	    to_pdsm(cmd)->cmd_status != 0 ||
+	    to_pdsm_cmd(cmd) != PAPR_PDSM_HEALTH_THRESHOLD) {
+		rc = -EINVAL;
+	}
+
+        if (rc < 0) {
+		errno = -rc;
+		return UINT_MAX;
+	}
+
+	threshold = pcmd->payload.threshold;
+	if (threshold.alarm_control & ND_PAPR_HEALTH_SPARE_TRIP)
+		flags |= ND_SMART_SPARE_TRIP;
+	if (threshold.alarm_control & ND_PAPR_HEALTH_TEMP_TRIP)
+		flags |= ND_SMART_TEMP_TRIP;
+	if (threshold.alarm_control & ND_PAPR_HEALTH_CTEMP_TRIP)
+		flags |= ND_SMART_CTEMP_TRIP;
+
+	return flags;
+}
+
+static int papr_smart_threshold_valid(struct ndctl_cmd *cmd)
+{
+	int rc = 0;
+
+	if (!cmd_is_valid(cmd) ||
+		to_pdsm(cmd)->cmd_status != 0 ||
+		to_pdsm_cmd(cmd) != PAPR_PDSM_HEALTH_THRESHOLD) {
+		rc = -EINVAL;
+	}
+
+	return rc;
+}
+
+#define papr_smart_threshold_get_field(cmd, field) \
+static unsigned int papr_cmd_smart_threshold_get_##field( \
+		struct ndctl_cmd *cmd) \
+{ \
+	int rc; \
+	struct nd_pkg_pdsm *pcmd = to_pdsm(cmd); \
+	rc = papr_smart_threshold_valid(cmd); \
+	if (rc < 0) { \
+		errno = -rc; \
+		return UINT_MAX; \
+	} \
+	return pcmd->payload.threshold.field; \
+}
+
+papr_smart_threshold_get_field(cmd, media_temperature)
+papr_smart_threshold_get_field(cmd, ctrl_temperature)
+papr_smart_threshold_get_field(cmd, spares)
+
+static int papr_smart_valid(struct ndctl_cmd *cmd)
+{
+	int rc = 0;
+
+	if (!cmd_is_valid(cmd) ||
+		to_pdsm(cmd)->cmd_status != 0 ||
+		to_pdsm_cmd(cmd) != PAPR_PDSM_HEALTH) {
+		rc = -EINVAL;
+	}
+
+	return rc;
+}
+
+
+#define papr_smart_get_field(cmd, field) \
+static unsigned int papr_cmd_smart_get_##field(struct ndctl_cmd *cmd) \
+{ \
+	int rc; \
+	struct nd_pkg_pdsm *pcmd = to_pdsm(cmd); \
+	rc = papr_smart_valid(cmd); \
+	if (rc < 0) { \
+		errno = -rc; \
+		return UINT_MAX; \
+	} \
+	return pcmd->payload.health.field; \
+}
+
+papr_smart_get_field(cmd, ctrl_temperature)
+papr_smart_get_field(cmd, media_temperature)
+papr_smart_get_field(cmd, alarm_flags)
+papr_smart_get_field(cmd, spares)
+
+#define papr_cmd_smart_threshold_set_field(field) \
+static int papr_cmd_smart_threshold_set_##field( \
+				struct ndctl_cmd *cmd, unsigned int val) \
+{ \
+	struct nd_pkg_pdsm *pcmd = to_pdsm(cmd); \
+	if (papr_pdsm_health_set_threshold_valid(cmd) < 0) \
+		return -EINVAL; \
+	pcmd->payload.threshold.field = val; \
+	return 0; \
+}
+
+papr_cmd_smart_threshold_set_field(alarm_control)
+papr_cmd_smart_threshold_set_field(media_temperature)
+papr_cmd_smart_threshold_set_field(ctrl_temperature)
+papr_cmd_smart_threshold_set_field(spares)
+
+
 struct ndctl_dimm_ops * const papr_dimm_ops = &(struct ndctl_dimm_ops) {
 	.cmd_is_supported = papr_cmd_is_supported,
+	.new_smart_inject = papr_new_smart_inject,
 	.smart_get_flags = papr_smart_get_flags,
+	.smart_inject_supported = papr_smart_inject_supported,
+	.smart_inject_media_temperature = papr_cmd_smart_inject_media_temperature,
+	.smart_inject_ctrl_temperature = papr_cmd_smart_inject_ctrl_temperature,
+	.smart_inject_spares = papr_cmd_smart_inject_spares,
+	.smart_inject_fatal = papr_cmd_smart_inject_fatal,
+	.smart_inject_unsafe_shutdown = papr_cmd_smart_inject_unsafe_shutdown,
+	.smart_get_ctrl_temperature = papr_cmd_smart_get_ctrl_temperature,
+	.smart_get_media_temperature = papr_cmd_smart_get_media_temperature,
+	.smart_get_alarm_flags = papr_cmd_smart_get_alarm_flags,
+	.smart_get_spares = papr_cmd_smart_get_spares,
 	.get_firmware_status =  papr_get_firmware_status,
 	.xlat_firmware_status = papr_xlat_firmware_status,
 	.new_smart = papr_new_smart_health,
 	.smart_get_health = papr_smart_get_health,
 	.smart_get_shutdown_state = papr_smart_get_shutdown_state,
 	.smart_get_life_used = papr_smart_get_life_used,
+	.new_smart_threshold = papr_cmd_new_smart_threshold,
+	.smart_threshold_get_alarm_control
+		= papr_cmd_smart_threshold_get_alarm_control,
+	.smart_threshold_get_media_temperature
+		= papr_cmd_smart_threshold_get_media_temperature,
+	.smart_threshold_get_ctrl_temperature
+		= papr_cmd_smart_threshold_get_ctrl_temperature,
+	.smart_threshold_get_spares = papr_cmd_smart_threshold_get_spares,
+	.new_smart_set_threshold = papr_dimm_cmd_new_smart_set_threshold,
+	.smart_threshold_get_supported_alarms
+		= papr_cmd_smart_threshold_get_supported_alarms,
+	.smart_threshold_set_alarm_control
+		= papr_cmd_smart_threshold_set_alarm_control,
+	.smart_threshold_set_media_temperature
+		= papr_cmd_smart_threshold_set_media_temperature,
+	.smart_threshold_set_ctrl_temperature
+		= papr_cmd_smart_threshold_set_ctrl_temperature,
+	.smart_threshold_set_spares = papr_cmd_smart_threshold_set_spares,
 };
diff --git a/ndctl/lib/papr.h b/ndctl/lib/papr.h
index 7757939..58ba81c 100644
--- a/ndctl/lib/papr.h
+++ b/ndctl/lib/papr.h
@@ -12,4 +12,13 @@ struct nd_pkg_papr {
 	struct nd_pkg_pdsm pdsm;
 };
 
+#define ND_PAPR_SMART_INJECT_MTEMP             (1 << 0)
+#define ND_PAPR_SMART_INJECT_SPARES            (1 << 1)
+#define ND_PAPR_SMART_INJECT_FATAL             (1 << 2)
+#define ND_PAPR_SMART_INJECT_SHUTDOWN          (1 << 3)
+
+#define ND_PAPR_HEALTH_SPARE_TRIP               (1 << 0)
+#define ND_PAPR_HEALTH_TEMP_TRIP                (1 << 1)
+#define ND_PAPR_HEALTH_CTEMP_TRIP               (1 << 2)
+
 #endif /* __PAPR_H__ */
diff --git a/ndctl/lib/papr_pdsm.h b/ndctl/lib/papr_pdsm.h
index 1bac8a7..19586dc 100644
--- a/ndctl/lib/papr_pdsm.h
+++ b/ndctl/lib/papr_pdsm.h
@@ -73,7 +73,12 @@
 #define PAPR_PDSM_DIMM_FATAL         3
 
 /* Indicate that the 'dimm_fuel_gauge' field is valid */
-#define PDSM_DIMM_HEALTH_RUN_GAUGE_VALID 1
+#define PDSM_DIMM_HEALTH_RUN_GAUGE_VALID		(1 << 0)
+#define PDSM_DIMM_HEALTH_MEDIA_TEMPERATURE_VALID 	(1 << 1)
+#define PDSM_DIMM_HEALTH_CTRL_TEMPERATURE_VALID		(1 << 2)
+#define PDSM_DIMM_HEALTH_SHUTDOWN_COUNT_VALID		(1 << 3)
+#define PDSM_DIMM_HEALTH_SPARES_VALID			(1 << 4)
+#define PDSM_DIMM_HEALTH_ALARM_VALID			(1 << 5)
 
 /*
  * Struct exchanged between kernel & ndctl in for PAPR_PDSM_HEALTH
@@ -103,6 +108,10 @@ struct nd_papr_pdsm_health {
 
 			/* Extension flag PDSM_DIMM_HEALTH_RUN_GAUGE_VALID */
 			__u16 dimm_fuel_gauge;
+			__u16 media_temperature;
+			__u16 ctrl_temperature;
+			__u8 spares;
+			__u16 alarm_flags;
 		};
 		__u8 buf[ND_PDSM_PAYLOAD_MAX_SIZE];
 	};
@@ -115,12 +124,51 @@ struct nd_papr_pdsm_health {
 enum papr_pdsm {
 	PAPR_PDSM_MIN = 0x0,
 	PAPR_PDSM_HEALTH,
+	PAPR_PDSM_INJECT_SET = 11,
+	PAPR_PDSM_INJECT_CLEAR = 12,
+	PAPR_PDSM_INJECT_GET = 13,
+	PAPR_PDSM_HEALTH_INJECT = 14,
+	PAPR_PDSM_HEALTH_THRESHOLD = 15,
+	PAPR_PDSM_HEALTH_THRESHOLD_SET = 16,
 	PAPR_PDSM_MAX,
 };
 
+struct nd_papr_pdsm_health_inject {
+	union {
+		struct {
+			__u64 flags;
+			__u8 mtemp_enable;
+			__u16 media_temperature;
+			__u8 ctemp_enable;
+			__u16 ctrl_temperature;
+			__u8 spares_enable;
+			__u8 spares;
+			__u8 fatal_enable;
+			__u8 unsafe_shutdown_enable;
+			__u32 status;
+		};
+		__u8 buf[ND_PDSM_PAYLOAD_MAX_SIZE];
+	};
+};
+
+struct nd_papr_pdsm_health_threshold {
+	union {
+		struct {
+			__u16 alarm_control;
+			__u8 spares;
+			__u16 media_temperature;
+			__u16 ctrl_temperature;
+			__u32 status;
+		};
+		__u8 buf[ND_PDSM_PAYLOAD_MAX_SIZE];
+	};
+};
+
 /* Maximal union that can hold all possible payload types */
 union nd_pdsm_payload {
 	struct nd_papr_pdsm_health health;
+	struct nd_papr_pdsm_health_inject inject;
+	struct nd_papr_pdsm_health_threshold threshold;
 	__u8 buf[ND_PDSM_PAYLOAD_MAX_SIZE];
 } __attribute__((packed));
 
-- 
2.31.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
