Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5B22E0556
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Dec 2020 05:23:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6A730100EBBDB;
	Mon, 21 Dec 2020 20:23:39 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C1D5C100EBBDF
	for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:23:37 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x126so7716281pfc.7
        for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6HoK6fB2r6Qja6DT4TX8AKIWNNn8XY36QUkw7hIPOyc=;
        b=R9iaQCExSo6KEEMiZH0hGIUE+WpIge/RSjCWmU764eKInOOlO5ErhRnVfVev6b4Ji/
         /WAu7KDJHL1rJZxpz4lUApIMPjd+wi2klp1Dhurlye2ukiOlmLVnDUgKL1NVIJUN71cC
         RpmzqOhLwhTGKylsBI0kWo0f5IASiQBiqS7gsmfE+5X3DcvNSBqieiVEyH87mORz1KiT
         32Zmh7ImzULpO33nIpp09l9aPK+rGaa+sGGnBbE+tGzNicq2+RCjJx4SeC4vzm6Xzj9g
         2d4tSzRx8vFmAYMLhOtoChnTv9ahZJpa7An/uc4wjdJq9BdjSiEzNas8wPUnD9b8F1Ki
         Gc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6HoK6fB2r6Qja6DT4TX8AKIWNNn8XY36QUkw7hIPOyc=;
        b=ZTniKMx4pPzcPrIXO9RRa2fp2ZNPLMb18ntLhJRiv7FwzJF/BJZLMGW4yyvLACuMWp
         x9cvQ+HUYmHx8DBzbMMT4NTsh65yVH7gxERSqWVb61MBzhDymWfAe9Nv4QvBCe2GNWIg
         DirExtA4LqyEoGnQbWfia46faDdFpS146YO/OG3a0kWrxxEnmpZQXbe9uPEVuNjTis/S
         HriFemeRVjjKAsW0URLWIhZ8oKxy29iaGEvgi4SgJYHeCEyKOJZfj+R7TClXM0I0G8sM
         7iDZZYeFhb02cydioV6gxJTQADteAEpm/mlVNj4iq0PlupL2NeqzqnNPxUauvLthvV7r
         6gaw==
X-Gm-Message-State: AOAM533eULaPhRIbROR1eMkRKmlCdFiuaT3R6kiKFgLUqMLCjzDarheD
	67x8tCvajeP/36PLnIGigtZOynMGFjNm/A==
X-Google-Smtp-Source: ABdhPJyQuV4I9l8sgDu3/o8ZVdtJAg+HpovYIQC5GYUaV86wo2tJFxGqwKqyvzdjmo7lU3kefOkbEw==
X-Received: by 2002:a63:cf43:: with SMTP id b3mr10985029pgj.387.1608611017156;
        Mon, 21 Dec 2020 20:23:37 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id s5sm17909498pfh.5.2020.12.21.20.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 20:23:36 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH 6/7] ndtest: Add nvdimm control functions
Date: Tue, 22 Dec 2020 09:52:39 +0530
Message-Id: <20201222042240.2983755-7-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201222042240.2983755-1-santosh@fossix.org>
References: <20201222042240.2983755-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: H6DXAJ2V6WP4VSQF5QIDL3SBQXOZE4MK
X-Message-ID-Hash: H6DXAJ2V6WP4VSQF5QIDL3SBQXOZE4MK
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/H6DXAJ2V6WP4VSQF5QIDL3SBQXOZE4MK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add functions to support ND_CMD_GET_CONFIG_SIZE, ND_CMD_SET_CONFIG_DATA and
ND_CMD_GET_CONFIG_DATA.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 tools/testing/nvdimm/test/ndtest.c | 51 ++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 821296b59bdc..dc1e3636616a 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -254,6 +254,45 @@ static inline struct ndtest_priv *to_ndtest_priv(struct device *dev)
 	return container_of(pdev, struct ndtest_priv, pdev);
 }
 
+static int ndtest_config_get(struct ndtest_dimm *p, unsigned int buf_len,
+			     struct nd_cmd_get_config_data_hdr *hdr)
+{
+	unsigned int len;
+
+	if ((hdr->in_offset + hdr->in_length) > LABEL_SIZE)
+		return -EINVAL;
+
+	hdr->status = 0;
+	len = min(hdr->in_length, LABEL_SIZE - hdr->in_offset);
+	memcpy(hdr->out_buf, p->label_area + hdr->in_offset, len);
+
+	return buf_len - len;
+}
+
+static int ndtest_config_set(struct ndtest_dimm *p, unsigned int buf_len,
+			     struct nd_cmd_set_config_hdr *hdr)
+{
+	unsigned int len;
+
+	if ((hdr->in_offset + hdr->in_length) > LABEL_SIZE)
+		return -EINVAL;
+
+	len = min(hdr->in_length, LABEL_SIZE - hdr->in_offset);
+	memcpy(p->label_area + hdr->in_offset, hdr->in_buf, len);
+
+	return buf_len - len;
+}
+
+static int ndtest_get_config_size(struct ndtest_dimm *dimm, unsigned int buf_len,
+				  struct nd_cmd_get_config_size *size)
+{
+	size->status = 0;
+	size->max_xfer = 8;
+	size->config_size = dimm->config_size;
+
+	return 0;
+}
+
 static int ndtest_ctl(struct nvdimm_bus_descriptor *nd_desc,
 		      struct nvdimm *nvdimm, unsigned int cmd, void *buf,
 		      unsigned int buf_len, int *cmd_rc)
@@ -275,12 +314,24 @@ static int ndtest_ctl(struct nvdimm_bus_descriptor *nd_desc,
 
 	switch (cmd) {
 	case ND_CMD_GET_CONFIG_SIZE:
+		*cmd_rc = ndtest_get_config_size(dimm, buf_len, buf);
+		break;
 	case ND_CMD_GET_CONFIG_DATA:
+		*cmd_rc = ndtest_config_get(dimm, buf_len, buf);
+		break;
 	case ND_CMD_SET_CONFIG_DATA:
+		*cmd_rc = ndtest_config_set(dimm, buf_len, buf);
+		break;
 	default:
 		return -EINVAL;
 	}
 
+	/* Failures for a DIMM can be injected using fail_cmd and
+	 * fail_cmd_code, see the device attributes below
+	 */
+	if ((1 << cmd) & dimm->fail_cmd)
+		return dimm->fail_cmd_code ? dimm->fail_cmd_code : -EIO;
+
 	return 0;
 }
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
