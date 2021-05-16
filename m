Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0313821FE
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 May 2021 01:14:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 25E2C100EBB63;
	Sun, 16 May 2021 16:14:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=fukuri.sai@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 351B1100EBBCB
	for <linux-nvdimm@lists.01.org>; Sun, 16 May 2021 16:14:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso3543922pjx.1
        for <linux-nvdimm@lists.01.org>; Sun, 16 May 2021 16:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ip25uj9IkAnBAu1V9gz7bDqY2wXbBuNqwlNTqZz6EGw=;
        b=t1gJEfo05FykvnpOy/1DWXVohNnV4vQ4ecOl6i6oT+wffCncsQ6/lVRL53c0cTWtkw
         wqQ3os2K9RTo6rBXgznP+cTzoPJ0V/U4pRf85RYAMJhRWJZxNe0CHAFaq7DkdyzGEMog
         KNQhnHE/jgO5ZM1pKd/+/ME0I2y44SNOo1rE7q27PZz8D1qhRRru9gjR4FIxkH+BmEio
         imwKDVpnQL7SzM7s/cepgEUPxW4NwsU27qFLdPEC4ti3joAdXk7CTzqoN3FiLgsrQHk6
         3R3frR9Xl4Rb2WpAtSIHNEeb5fEbXTPLYBfwo6IqIgsmJHGhfB9vVf8JitekJ8wD+lvg
         Jq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ip25uj9IkAnBAu1V9gz7bDqY2wXbBuNqwlNTqZz6EGw=;
        b=uKwESEEK2DR7Rx+6GSk74YW7Bct1XBTLkDV7UONCelcWChv7pivQsLV83/aBHPT86h
         ZHoSI5+a83walbvVDOBgSuJ+OXgHB9DKP28cx5igPY1zkzpIJqSU8RKdrN8jPpXsZ3Zv
         3CiDQG8pcMiNOmTn9VjXNAynLmQbb0PyNh+1MTOR9AcSy++AGjChiYpUw+9vJobtzWUp
         25qM+q4szRfFxYMjE286zeyQbLcazkU6wkgw4/IL0c8iy2QmxnqGLjR1fOS7P/ZlZ209
         hZ06yy8+lvUPNwNOwgx3kkFr3KCBkJwqkN2F3WBpxVRZAunVoMM5JfAZmewKlEYGAAs2
         Q2oQ==
X-Gm-Message-State: AOAM531JJRNMsgUWALFqQo4iMgd4VEShjbYwUuNu9tUx1e7Vu2bxEDYf
	C2+b5l4nIIUo3qkqZYFZoHoRmOZ3mCqg12z7
X-Google-Smtp-Source: ABdhPJzi/2+36GqM+3ahzZuRExHqd451GdrjncAef0FX7FRrIsmGahEzPzchprzdbfvyzBnKTUZWeA==
X-Received: by 2002:a17:90b:1e46:: with SMTP id pi6mr23852145pjb.212.1621206889794;
        Sun, 16 May 2021 16:14:49 -0700 (PDT)
Received: from localhost.localdomain (softbank126008227016.bbtec.net. [126.8.227.16])
        by smtp.gmail.com with ESMTPSA id c17sm9097890pgm.3.2021.05.16.16.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 16:14:49 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: linux-nvdimm@lists.01.org
Subject: [RFC ndctl PATCH 2/3] ndctl, util: add parse-configs helper
Date: Mon, 17 May 2021 08:14:26 +0900
Message-Id: <20210516231427.64162-3-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516231427.64162-1-qi.fuli@fujitsu.com>
References: <20210516231427.64162-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
Message-ID-Hash: BGKZHIRXDMFT3ZXTRYTMSWLG5X6ERPKV
X-Message-ID-Hash: BGKZHIRXDMFT3ZXTRYTMSWLG5X6ERPKV
X-MailFrom: fukuri.sai@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: QI Fuli <qi.fuli@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BGKZHIRXDMFT3ZXTRYTMSWLG5X6ERPKV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: QI Fuli <qi.fuli@fujitsu.com>

Add parse-config helper to help ndctl commands read the ndctl global
configuration file.

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 Makefile.am          |  2 ++
 util/parse-configs.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 util/parse-configs.h | 26 ++++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 util/parse-configs.c
 create mode 100644 util/parse-configs.h

diff --git a/Makefile.am b/Makefile.am
index 960b5e9..6e50741 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -74,6 +74,8 @@ noinst_LIBRARIES += libutil.a
 libutil_a_SOURCES = \
 	util/parse-options.c \
 	util/parse-options.h \
+	util/parse-configs.c \
+	util/parse-configs.h \
 	util/usage.c \
 	util/size.c \
 	util/main.c \
diff --git a/util/parse-configs.c b/util/parse-configs.c
new file mode 100644
index 0000000..d404786
--- /dev/null
+++ b/util/parse-configs.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2021, FUJITSU LIMITED. ALL rights reserved.
+
+#include <errno.h>
+#include <util/parse-configs.h>
+#include <util/strbuf.h>
+#include <ccan/ciniparser/ciniparser.h>
+
+static void set_value(const char **value, char *val)
+{
+	struct strbuf buf = STRBUF_INIT;
+	size_t len = *value ? strlen(*value) : 0;
+
+	if (!val)
+		return;
+
+	if (len) {
+		strbuf_add(&buf, *value, len);
+		strbuf_addstr(&buf, " ");
+	}
+	strbuf_addstr(&buf, val);
+	*value = strbuf_detach(&buf, NULL);
+}
+
+int parse_configs(const char *config_file, const struct config *configs)
+{
+	dictionary *dic;
+
+	dic = ciniparser_load(config_file);
+	if (!dic)
+		return -errno;
+
+	for (; configs->type != CONFIG_END; configs++) {
+		switch (configs->type) {
+		case CONFIG_STRING:
+			set_value((const char **)configs->value,
+					ciniparser_getstring(dic,
+					configs->key, configs->defval));
+			break;
+		case CONFIG_END:
+			break;
+		}
+	}
+
+	ciniparser_freedict(dic);
+	return 0;
+}
diff --git a/util/parse-configs.h b/util/parse-configs.h
new file mode 100644
index 0000000..31886f7
--- /dev/null
+++ b/util/parse-configs.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2021, FUJITSU LIMITED. ALL rights reserved.
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <util/util.h>
+
+enum parse_conf_type {
+	CONFIG_STRING,
+	CONFIG_END,
+};
+
+struct config {
+	enum parse_conf_type type;
+	const char *key;
+	void *value;
+	void *defval;
+};
+
+#define check_vtype(v, type) ( BUILD_BUG_ON_ZERO(!__builtin_types_compatible_p(typeof(v), type)) + v )
+
+#define CONF_END() { .type = CONFIG_END }
+#define CONF_STR(k,v,d) \
+	{ .type = CONFIG_STRING, .key = (k), .value = check_vtype(v, const char **), .defval = (d) }
+
+int parse_configs(const char *config_file, const struct config *configs);
-- 
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
