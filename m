Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A78643821FF
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 May 2021 01:14:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 45274100EB829;
	Sun, 16 May 2021 16:14:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=fukuri.sai@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0025E100EBB9F
	for <linux-nvdimm@lists.01.org>; Sun, 16 May 2021 16:14:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id e19so3733430pfv.3
        for <linux-nvdimm@lists.01.org>; Sun, 16 May 2021 16:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XGXWm6Qnm4KtykKPFhHdURI5jCHABTlOVC5SxQbm9AI=;
        b=ZVeBRqvfL/WPpbUppkRLSn2HOjoeCEv3Vf3b70zzvsWwP3Bu5ASQVvUtn26LcUKAqc
         3A8dg6ejmMReusRZkthwTLc48e3lpeP55iaz2p9ojWVn6rWRKtzS2hgQkzPlpVjbcgRD
         +t8SmFfPXykcKX04qoVpwzfjXz/zK6ck06UoPp8+WOGRGQTqhuBTVnSHXjYZHWa9toIu
         wK+rbvUR+gGuu05hCfViLiXLtOk2VrZ5wcIDrInLiRjZ5o373bInqnyMYGWHCaDrkVt/
         jrEpnIl/zT7znGLpCvr8EPBe0o6U93gpZQrO58MG2gykSVLXq7f0jBslKGTjg6h4mvYC
         mH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGXWm6Qnm4KtykKPFhHdURI5jCHABTlOVC5SxQbm9AI=;
        b=J619i2LkGI6wpcnPeWIN6g3OnW9lol7REmeoNIMmmWp3laaauXcWY2FqYSRXjF8xh2
         qRBnM7XDuqAF3kyDxxZooqc77SQSIkAJ80/Q+QCURtPDsULf6F5AwG/XPXebLdgKCzw3
         4Vdnsibt0nXanbXRUz765e1HWhtUM7DYVhgR3wQUoiJ6JiqBTDHlaO1AtoJCWt2HiI7e
         ByqRwO00R9BREUy7MFe2XqeSS1B8IF1AbWxBTk23nEbzzdqkc+/MGjM4D75tCDYzTuey
         Z6Nuhup8/bKXvsv5y6hpWXLZ/RI+RAbf65ErgTxndOOB5m80sxRSwSkA1SwvFonffc1B
         wp0A==
X-Gm-Message-State: AOAM530rRJtFzVyyeYUJ1y88gjp7WgElbWwB4l6c78k/qG3BWijcaLSQ
	HfxbZm69EHzqYOglKTDSfJXwlW7FzIEiQfDk
X-Google-Smtp-Source: ABdhPJxGiIztwdD5shd+pYJxUYF+KAVvfkPT0V+M3GQPuiwNMVa96AZv7dp9QTzRa4qoP74vac1ZDA==
X-Received: by 2002:a65:584d:: with SMTP id s13mr58070948pgr.97.1621206892541;
        Sun, 16 May 2021 16:14:52 -0700 (PDT)
Received: from localhost.localdomain (softbank126008227016.bbtec.net. [126.8.227.16])
        by smtp.gmail.com with ESMTPSA id c17sm9097890pgm.3.2021.05.16.16.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 16:14:51 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: linux-nvdimm@lists.01.org
Subject: [RFC ndctl PATCH 3/3] ndctl, rename monitor.conf to ndctl.conf
Date: Mon, 17 May 2021 08:14:27 +0900
Message-Id: <20210516231427.64162-4-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516231427.64162-1-qi.fuli@fujitsu.com>
References: <20210516231427.64162-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
Message-ID-Hash: SJDCL6OZPHIA7ZGQWOAZN45TQD3ZUH5C
X-Message-ID-Hash: SJDCL6OZPHIA7ZGQWOAZN45TQD3ZUH5C
X-MailFrom: fukuri.sai@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: QI Fuli <qi.fuli@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SJDCL6OZPHIA7ZGQWOAZN45TQD3ZUH5C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: QI Fuli <qi.fuli@fujitsu.com>

Rename monitor.conf to ndctl.conf, and make it a ndclt global
configuration file that all commands can refer to.
Refactor monitor to make it work with ndctl.conf.

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 configure.ac                       |   8 +-
 ndctl/Makefile.am                  |   9 +-
 ndctl/monitor.c                    | 127 +++++------------------------
 ndctl/{monitor.conf => ndctl.conf} |  16 +++-
 4 files changed, 40 insertions(+), 120 deletions(-)
 rename ndctl/{monitor.conf => ndctl.conf} (82%)

diff --git a/configure.ac b/configure.ac
index 5ec8d2f..ab2d8a3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -171,10 +171,10 @@ fi
 AC_SUBST([systemd_unitdir])
 AM_CONDITIONAL([ENABLE_SYSTEMD_UNITS], [test "x$with_systemd" = "xyes"])
 
-ndctl_monitorconfdir=${sysconfdir}/ndctl
-ndctl_monitorconf=monitor.conf
-AC_SUBST([ndctl_monitorconfdir])
-AC_SUBST([ndctl_monitorconf])
+ndctl_confdir=${sysconfdir}/ndctl
+ndctl_conf=ndctl.conf
+AC_SUBST([ndctl_confdir])
+AC_SUBST([ndctl_conf])
 
 daxctl_modprobe_datadir=${datadir}/daxctl
 daxctl_modprobe_data=daxctl.conf
diff --git a/ndctl/Makefile.am b/ndctl/Makefile.am
index a63b1e0..b107b3d 100644
--- a/ndctl/Makefile.am
+++ b/ndctl/Makefile.am
@@ -7,7 +7,7 @@ BUILT_SOURCES = config.h
 config.h: $(srcdir)/Makefile.am
 	$(AM_V_GEN) echo "/* Autogenerated by ndctl/Makefile.am */" >$@ && \
 	echo '#define NDCTL_CONF_FILE \
-		"$(ndctl_monitorconfdir)/$(ndctl_monitorconf)"' >>$@
+		"$(ndctl_confdir)/$(ndctl_conf)"' >>$@
 	$(AM_V_GEN) echo '#define NDCTL_KEYS_DIR  "$(ndctl_keysdir)"' >>$@
 
 ndctl_SOURCES = ndctl.c \
@@ -42,7 +42,7 @@ keys_configdir = $(ndctl_keysdir)
 keys_config_DATA = $(ndctl_keysreadme)
 endif
 
-EXTRA_DIST += keys.readme monitor.conf ndctl-monitor.service
+EXTRA_DIST += keys.readme ndctl.conf ndctl-monitor.service
 
 if ENABLE_DESTRUCTIVE
 ndctl_SOURCES += ../test/blk_namespaces.c \
@@ -54,6 +54,7 @@ ndctl_LDADD =\
 	lib/libndctl.la \
 	../daxctl/lib/libdaxctl.la \
 	../libutil.a \
+	../libccan.a \
 	$(UUID_LIBS) \
 	$(KMOD_LIBS) \
 	$(JSON_LIBS)
@@ -73,8 +74,8 @@ ndctl_SOURCES += ../test/libndctl.c \
 		 test.c
 endif
 
-monitor_configdir = $(ndctl_monitorconfdir)
-monitor_config_DATA = $(ndctl_monitorconf)
+ndctl_configdir = $(ndctl_confdir)
+ndctl_config_DATA = $(ndctl_conf)
 
 if ENABLE_SYSTEMD_UNITS
 systemd_unit_DATA = ndctl-monitor.service
diff --git a/ndctl/monitor.c b/ndctl/monitor.c
index ca36179..ea707d2 100644
--- a/ndctl/monitor.c
+++ b/ndctl/monitor.c
@@ -10,11 +10,13 @@
 #include <util/filter.h>
 #include <util/util.h>
 #include <util/parse-options.h>
+#include <util/parse-configs.h>
 #include <util/strbuf.h>
 #include <ndctl/config.h>
 #include <ndctl/ndctl.h>
 #include <ndctl/libndctl.h>
 #include <sys/epoll.h>
+#include <stdbool.h>
 #define BUF_SIZE 2048
 
 /* reuse the core log helpers for the monitor logger */
@@ -463,113 +465,6 @@ out:
 	return rc;
 }
 
-static void parse_config(const char **arg, char *key, char *val, char *ident)
-{
-	struct strbuf value = STRBUF_INIT;
-	size_t arg_len = *arg ? strlen(*arg) : 0;
-
-	if (!ident || !key || (strcmp(ident, key) != 0))
-		return;
-
-	if (arg_len) {
-		strbuf_add(&value, *arg, arg_len);
-		strbuf_addstr(&value, " ");
-	}
-	strbuf_addstr(&value, val);
-	*arg = strbuf_detach(&value, NULL);
-}
-
-static int read_config_file(struct ndctl_ctx *ctx, struct monitor *_monitor,
-		struct util_filter_params *_param)
-{
-	FILE *f;
-	size_t len = 0;
-	int line = 0, rc = 0;
-	char *buf = NULL, *seek, *value, *config_file;
-
-	if (_monitor->config_file)
-		config_file = strdup(_monitor->config_file);
-	else
-		config_file = strdup(NDCTL_CONF_FILE);
-	if (!config_file) {
-		fail("strdup default config file failed\n");
-		rc = -ENOMEM;
-		goto out;
-	}
-
-	buf = malloc(BUF_SIZE);
-	if (!buf) {
-		fail("malloc read config-file buf error\n");
-		rc = -ENOMEM;
-		goto out;
-	}
-	seek = buf;
-
-	f = fopen(config_file, "r");
-	if (!f) {
-		if (_monitor->config_file) {
-			err(&monitor, "config-file: %s cannot be opened\n",
-				config_file);
-			rc = -errno;
-		}
-		goto out;
-	}
-
-	while (fgets(seek, BUF_SIZE, f)) {
-		value = NULL;
-		line++;
-
-		while (isspace(*seek))
-			seek++;
-
-		if (*seek == '#' || *seek == '\0')
-			continue;
-
-		value = strchr(seek, '=');
-		if (!value) {
-			fail("config-file syntax error, skip line[%i]\n", line);
-			continue;
-		}
-
-		value[0] = '\0';
-		value++;
-
-		while (isspace(value[0]))
-			value++;
-
-		len = strlen(seek);
-		if (len == 0)
-			continue;
-		while (isspace(seek[len-1]))
-			len--;
-		seek[len] = '\0';
-
-		len = strlen(value);
-		if (len == 0)
-			continue;
-		while (isspace(value[len-1]))
-			len--;
-		value[len] = '\0';
-
-		if (len == 0)
-			continue;
-
-		parse_config(&_param->bus, "bus", value, seek);
-		parse_config(&_param->dimm, "dimm", value, seek);
-		parse_config(&_param->region, "region", value, seek);
-		parse_config(&_param->namespace, "namespace", value, seek);
-		parse_config(&_monitor->dimm_event, "dimm-event", value, seek);
-
-		if (!_monitor->log)
-			parse_config(&_monitor->log, "log", value, seek);
-	}
-	fclose(f);
-out:
-	free(buf);
-	free(config_file);
-	return rc;
-}
-
 int cmd_monitor(int argc, const char **argv, struct ndctl_ctx *ctx)
 {
 	const struct option options[] = {
@@ -601,6 +496,19 @@ int cmd_monitor(int argc, const char **argv, struct ndctl_ctx *ctx)
 		"ndctl monitor [<options>]",
 		NULL
 	};
+	const struct config configs[] = {
+		CONF_STR("core:bus", &param.bus, NULL),
+		CONF_STR("core:region", &param.region, NULL),
+		CONF_STR("core:dimm", &param.dimm, NULL),
+		CONF_STR("core:namespace", &param.namespace, NULL),
+		CONF_STR("monitor:bus", &param.bus, NULL),
+		CONF_STR("monitor:region", &param.region, NULL),
+		CONF_STR("monitor:dimm", &param.dimm, NULL),
+		CONF_STR("monitor:namespace", &param.namespace, NULL),
+		CONF_STR("monitor:dimm-event", &monitor.dimm_event, NULL),
+		//CONF_FILE("monitor:log", &monitor.log, NULL),
+		CONF_END(),
+	};
 	const char *prefix = "./";
 	struct util_filter_ctx fctx = { 0 };
 	struct monitor_filter_arg mfa = { 0 };
@@ -621,7 +529,10 @@ int cmd_monitor(int argc, const char **argv, struct ndctl_ctx *ctx)
 	else
 		monitor.ctx.log_priority = LOG_INFO;
 
-	rc = read_config_file(ctx, &monitor, &param);
+	if (monitor.config_file)
+		rc = parse_configs(monitor.config_file, configs);
+	else
+		rc = parse_configs(NDCTL_CONF_FILE, configs);
 	if (rc)
 		goto out;
 
diff --git a/ndctl/monitor.conf b/ndctl/ndctl.conf
similarity index 82%
rename from ndctl/monitor.conf
rename to ndctl/ndctl.conf
index 934e2c0..85343b0 100644
--- a/ndctl/monitor.conf
+++ b/ndctl/ndctl.conf
@@ -1,14 +1,22 @@
-# This is the main ndctl monitor configuration file. It contains the
-# configuration directives that give ndctl monitor instructions.
-# You can change the configuration of ndctl monitor by editing this
+# This is the ndctl global configuration file. It contains the
+# configuration directives that give ndctl instructions.
+# You can change the configuration of ndctl by editing this
 # file or using [--config-file=<file>] option to override this one.
-# The changed value will work after restart ndctl monitor service.
+# The changed value will work after restart ndctl services.
 
 # In this file, lines starting with a hash (#) are comments.
 # The configurations should follow <key> = <value> style.
 # Multiple space-separated values are allowed, but except the following
 # characters: : ? / \ % " ' $ & ! * { } [ ] ( ) = < > @
 
+[core]
+# The values in the [core] section work for all ndctl commands.
+# dimm = all
+# bus = all
+# region = all
+# namespace = all
+
+[monitor]
 # The objects to monitor are filtered via dimm's name by setting key "dimm".
 # If this value is different from the value of [--dimm=<value>] option,
 # both of the values will work.
-- 
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
