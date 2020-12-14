Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 162A02D966D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 14 Dec 2020 11:39:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BF256100EF274;
	Mon, 14 Dec 2020 02:39:44 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F0C12100EF27B
	for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:39:42 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id g20so7592612plo.2
        for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6HoK6fB2r6Qja6DT4TX8AKIWNNn8XY36QUkw7hIPOyc=;
        b=zXdkgM0mX5Pv844ueE8KY4HKWOT1RBuIFe+vdGwQGpXHHyKhYhDXsK5X2D2ptptiJM
         EiysEKALAK6PEptqdntX3M8mb7luRQvK2iEXJhUza49+VcNKUU1n8e4o8V1VCt2T4OY4
         e4D6frN2vnoRhGk2dB04EwSl1ImGnGkxCq5BQ5J8Ca4QRu42Y9dgIWMU/BvbrqQuID2y
         DAh5SYiD4DOBVQtfebspf8A9/3eI1PTT89yVUs6D1Vj2Z9TeJj1WZlFwrzy2SUzw5E7r
         P6WZWqQDEsQqBYkJi46Xe/KsYEDQ2Oo1Gmv3stQUtXGCpypa2EWWWlp60rKAhB3bzC/z
         bkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6HoK6fB2r6Qja6DT4TX8AKIWNNn8XY36QUkw7hIPOyc=;
        b=oUdf6tNMiJ12v+WM/OVY9vxzEMOXTcbkEn8DxcTln5hXXw0W/2zoUxF2bEGcBFIeS+
         //2W+sa7MZCMg9Myq+ofdwZFqdkkUzkcTCtjTxKqZrABaxClTL1WpzWIHh+byyHzFOxs
         /uEoeMJ63ktqLXBjjUXC4eWbRW65TsCMP+8Gcsz289SE2oV57in9MZbh2kgMx+e2NdV7
         WIJnXeELWK5sPtOIeEqJyXPW+uscEI39Le/gVXLXByjv6t9D/1bXUIB5w1BmTrBCrsJr
         DdwIXs6kdORygKWmeVxGTkPyS2lMV1Qqd6ZwYynAqy97mdAg2+QAo+HJUcyAKf3TTN0m
         xgiA==
X-Gm-Message-State: AOAM531h1rknVUL3cgIhHCWX+1uHLbD+CQzH88IMdK9XUtpWEFvHOHZx
	tOy7lDlQersDcG1fO7IN5WUqu0PvyDs2vw==
X-Google-Smtp-Source: ABdhPJxhQ5s0aPfWAsOCLNiyPKlGGxwxIAwfjcl4V6dNHBAF4XQwSQgWXobi8fMeoTRXtMQwpiBdWQ==
X-Received: by 2002:a17:90a:dac2:: with SMTP id g2mr21298980pjx.17.1607942382373;
        Mon, 14 Dec 2020 02:39:42 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id p1sm20735926pfb.208.2020.12.14.02.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 02:39:41 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [RFC v5 6/7] ndtest: Add nvdimm control functions
Date: Mon, 14 Dec 2020 16:08:58 +0530
Message-Id: <20201214103859.2409175-7-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214103859.2409175-1-santosh@fossix.org>
References: <20201214103859.2409175-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: BP4E6DX573U6CDEHGFOZ5RR5D7GCZLGF
X-Message-ID-Hash: BP4E6DX573U6CDEHGFOZ5RR5D7GCZLGF
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BP4E6DX573U6CDEHGFOZ5RR5D7GCZLGF/>
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
