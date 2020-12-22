Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E40B2E0552
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Dec 2020 05:23:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ED99E100EBBDE;
	Mon, 21 Dec 2020 20:23:26 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3BA28100EBBDE
	for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:23:25 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id r4so6755472pls.11
        for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+XQ98VQlJbx/wJmwWGGJ/XeFWJw65N1toCzuaN5sHhg=;
        b=wuOknEaoOh/jW74glIP5DW1mxI8VIjRuG1WhCYO4ATDLdn2ZRUzErZBT9ReMdVjeKo
         kZm53SRcwwS+XetWaXIZYU5xF8JxinNgPmlGomr01slbeBktP/1LeEl8l/yTdoxvA1jm
         xXDm+zLHsUjQVlgSatWb7u0T1JER9/hMFDNRH0m6JRi1FHpA7oFoPCT4TmpNXqViMLA8
         Y8QwS7h5FkyNtvkhTXyW6eSHTp7iVBvFCjv5axtzQZMsSE7WpX/8JMK5O+1xnnMFrhzo
         mFiIJ//lS+AjGjo3U9vDuzuhWmNn9O7XQiHBey7kU+HrZoiP0WIoysJNu6XKidu9Pgr9
         CRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+XQ98VQlJbx/wJmwWGGJ/XeFWJw65N1toCzuaN5sHhg=;
        b=LllcrT4snrkEFdIxqlMxBKHcAy3SfRYas94VZCM3IaXdDQo2Zk0CatdFxng+n3ggxz
         ARU3ozP69ywX6TUz2rC/OH9eRbew/SuxjMzLtGqc3/M9ButSeCehpAoOYxyVM06FiLJH
         Ue9n9fHP0GJRlm6dnB2pI/cYLkFYINT6H3vkJJFvkEip1U2FgVqGWgMF7gDRY9u+4INw
         nYSh+L5UfF1w32IxRFdstFpEIgZ/MBwio4C5H0NiARycmvdPDCjrnpuJs9Jd7WgWnoa2
         IecFGUBGPQ8N/H5ZHJ17uWrhHCE1zN3B8YNEWdVPuoZFLEJ6utevmI2Cw2EK38WCRWMr
         4PEw==
X-Gm-Message-State: AOAM531DuHerdfCpAIFpuJU3B3afCqCYBEgxdschA2WJq1gI2w346vVE
	9dtDZTZW6ciD0ioaJMHsCVSghYjaFU17Kw==
X-Google-Smtp-Source: ABdhPJzoxJqmMXF2IcZp79sW2SmpBqdPc8SaUzNFbsL9jjhK0AQMi2VWdlITvVyWKQ+juNAykRO2lQ==
X-Received: by 2002:a17:90a:d790:: with SMTP id z16mr20565155pju.88.1608611004546;
        Mon, 21 Dec 2020 20:23:24 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id s5sm17909498pfh.5.2020.12.21.20.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 20:23:24 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH 2/7] ndtest: Add compatability string to treat it as PAPR family
Date: Tue, 22 Dec 2020 09:52:35 +0530
Message-Id: <20201222042240.2983755-3-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201222042240.2983755-1-santosh@fossix.org>
References: <20201222042240.2983755-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: OL5ZKU3MGJCUP72EZ5PL22NQWMZWY3BS
X-Message-ID-Hash: OL5ZKU3MGJCUP72EZ5PL22NQWMZWY3BS
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OL5ZKU3MGJCUP72EZ5PL22NQWMZWY3BS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since this module is written to be platform agnostic, the module is made
part of the PAPR_FAMILY. ndctl identifies the family using the compatible
string inside of_node dir-entry.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 tools/testing/nvdimm/test/ndtest.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index f89d74fdcdee..001527b37a23 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -65,11 +65,34 @@ static int ndtest_ctl(struct nvdimm_bus_descriptor *nd_desc,
 	return 0;
 }
 
+static ssize_t compatible_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "nvdimm_test");
+}
+static DEVICE_ATTR_RO(compatible);
+
+static struct attribute *of_node_attributes[] = {
+	&dev_attr_compatible.attr,
+	NULL
+};
+
+static const struct attribute_group of_node_attribute_group = {
+	.name = "of_node",
+	.attrs = of_node_attributes,
+};
+
+static const struct attribute_group *ndtest_attribute_groups[] = {
+	&of_node_attribute_group,
+	NULL,
+};
+
 static int ndtest_bus_register(struct ndtest_priv *p)
 {
 	p->bus_desc.ndctl = ndtest_ctl;
 	p->bus_desc.module = THIS_MODULE;
 	p->bus_desc.provider_name = NULL;
+	p->bus_desc.attr_groups = ndtest_attribute_groups;
 
 	p->bus = nvdimm_bus_register(&p->pdev.dev, &p->bus_desc);
 	if (!p->bus) {
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
