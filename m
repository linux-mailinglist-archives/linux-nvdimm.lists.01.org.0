Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 090D42D966B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 14 Dec 2020 11:39:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7609C100EF275;
	Mon, 14 Dec 2020 02:39:37 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0C70C100EF264
	for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:39:36 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w6so11848699pfu.1
        for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ic2mMqvpqTjhjjMuE4exv7qpNi/mu6fZmsdb6XwpV9A=;
        b=ewYKZjZHTCO6oU39espRpzm79n4dqPsfZCcQ1oqVwM8FOhISjrtZUBEAuY8uCouqfy
         /rgNul25GvwvukDKM3rQIOJ5k+L1ItVhPHEkgBelneBOYvxPtcVLEuUzv5994W6yNnSU
         VSVTefBNKtZ6O+DuXLyh7rs3aD8o5R6IOCNbPIJtsGNGX8ePeNtKG1DF3rwfG7XdF2tp
         tfFm0p43qMryFABHodiTkT8S2slm6+rDioxPnK9lpL/LSicqa42j+cVYTOTHFip6Rslh
         ZMvbyOdHiNU+3bD/isVCmleHPuMFL3/luJQUkn0lT25aXMxwJvxK/hS7WIgQOZUum7lN
         h5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ic2mMqvpqTjhjjMuE4exv7qpNi/mu6fZmsdb6XwpV9A=;
        b=g/QRRlr6TbDUHqGPykgQydwpDIgLPdOoc/55ZeOa0EjJxwVILbNZJoxlefjnZvCCN1
         8MYJRg0NBaf/wPRX1AKC7+zlqvruh29sF5o14o/R58rQKxSuy2qHksdFrSKQ+nHD6uo5
         EUyZRVfh0MZhF0uRf2+icY0Y3sUYjYkBMKsvi6b9YvDVlhbdAJ76cgesqx5THPdKRIEw
         ilipy3m1R+uX8qnQ9UQ6T5MK7VCMpd1oZBamvUn+FuxAdL0RW1lTMdR7Z8MUDbafqJ7V
         jyI4NJtqupeaZIrwV+kEq6cnaE58s9hfKjBHyeMmS21+xEfJiRrJ4l4h3zrhY0oGAsvy
         c8yA==
X-Gm-Message-State: AOAM532ObJP0yUXVu1cJkWPDF/80Qpl2NLplpUaU8a1KjwZ/kMykRPW5
	z747u6vrcReLsaUKEsUpI8gEttkBS2bWFw==
X-Google-Smtp-Source: ABdhPJyXevytsFJlZHYwOmxBPASGsJ+cfT09aXeCbFNwJ/l8TQ3HrrpxuKOfLeX2qSbyDptR+9Vstg==
X-Received: by 2002:a65:63d5:: with SMTP id n21mr23514237pgv.346.1607942375319;
        Mon, 14 Dec 2020 02:39:35 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id p1sm20735926pfb.208.2020.12.14.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 02:39:34 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [RFC v5 4/7] ndtest: Add dimm attributes
Date: Mon, 14 Dec 2020 16:08:56 +0530
Message-Id: <20201214103859.2409175-5-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214103859.2409175-1-santosh@fossix.org>
References: <20201214103859.2409175-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: R5WS7GINIB25MLPNEXPD5R7UMBLIPFMX
X-Message-ID-Hash: R5WS7GINIB25MLPNEXPD5R7UMBLIPFMX
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R5WS7GINIB25MLPNEXPD5R7UMBLIPFMX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds sysfs attributes for nvdimm and the dimm device.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 tools/testing/nvdimm/test/ndtest.c | 202 ++++++++++++++++++++++++++++-
 1 file changed, 200 insertions(+), 2 deletions(-)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index a82790013f8a..f7682e1d3efe 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -219,6 +219,203 @@ static void put_dimms(void *data)
 		}
 }
 
+static ssize_t handle_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct ndtest_dimm *dimm = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%#x\n", dimm->handle);
+}
+static DEVICE_ATTR_RO(handle);
+
+static ssize_t fail_cmd_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct ndtest_dimm *dimm = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%#x\n", dimm->fail_cmd);
+}
+
+static ssize_t fail_cmd_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	struct ndtest_dimm *dimm = dev_get_drvdata(dev);
+	unsigned long val;
+	ssize_t rc;
+
+	rc = kstrtol(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	dimm->fail_cmd = val;
+
+	return size;
+}
+static DEVICE_ATTR_RW(fail_cmd);
+
+static ssize_t fail_cmd_code_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct ndtest_dimm *dimm = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", dimm->fail_cmd_code);
+}
+
+static ssize_t fail_cmd_code_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	struct ndtest_dimm *dimm = dev_get_drvdata(dev);
+	unsigned long val;
+	ssize_t rc;
+
+	rc = kstrtol(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	dimm->fail_cmd_code = val;
+	return size;
+}
+static DEVICE_ATTR_RW(fail_cmd_code);
+
+static struct attribute *dimm_attributes[] = {
+	&dev_attr_handle.attr,
+	&dev_attr_fail_cmd.attr,
+	&dev_attr_fail_cmd_code.attr,
+	NULL,
+};
+
+static struct attribute_group dimm_attribute_group = {
+	.attrs = dimm_attributes,
+};
+
+static const struct attribute_group *dimm_attribute_groups[] = {
+	&dimm_attribute_group,
+	NULL,
+};
+
+static ssize_t phys_id_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
+
+	return sprintf(buf, "%#x\n", dimm->physical_id);
+}
+static DEVICE_ATTR_RO(phys_id);
+
+static ssize_t vendor_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x1234567\n");
+}
+static DEVICE_ATTR_RO(vendor);
+
+static ssize_t id_show(struct device *dev,
+		       struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
+
+	return sprintf(buf, "%04x-%02x-%04x-%08x", 0xabcd,
+		       0xa, 2016, ~(dimm->handle));
+}
+static DEVICE_ATTR_RO(id);
+
+static ssize_t nvdimm_handle_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
+
+	return sprintf(buf, "%#x\n", dimm->handle);
+}
+
+static struct device_attribute dev_attr_nvdimm_show_handle =  {
+	.attr	= { .name = "handle", .mode = 0444 },
+	.show	= nvdimm_handle_show,
+};
+
+static ssize_t subsystem_vendor_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%04x\n", 0);
+}
+static DEVICE_ATTR_RO(subsystem_vendor);
+
+static ssize_t dirty_shutdown_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", 42);
+}
+static DEVICE_ATTR_RO(dirty_shutdown);
+
+static ssize_t formats_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
+
+	return sprintf(buf, "%d\n", dimm->num_formats);
+}
+static DEVICE_ATTR_RO(formats);
+
+static ssize_t format_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
+
+	if (dimm->num_formats > 1)
+		return sprintf(buf, "0x201\n");
+
+	return sprintf(buf, "0x101\n");
+}
+static DEVICE_ATTR_RO(format);
+
+static ssize_t format1_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	return sprintf(buf, "0x301\n");
+}
+static DEVICE_ATTR_RO(format1);
+
+static umode_t ndtest_nvdimm_attr_visible(struct kobject *kobj,
+					struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
+
+	if (a == &dev_attr_format1.attr && dimm->num_formats <= 1)
+		return 0;
+
+	return a->mode;
+}
+
+static struct attribute *ndtest_nvdimm_attributes[] = {
+	&dev_attr_nvdimm_show_handle.attr,
+	&dev_attr_vendor.attr,
+	&dev_attr_id.attr,
+	&dev_attr_phys_id.attr,
+	&dev_attr_subsystem_vendor.attr,
+	&dev_attr_dirty_shutdown.attr,
+	&dev_attr_formats.attr,
+	&dev_attr_format.attr,
+	&dev_attr_format1.attr,
+	NULL,
+};
+
+static const struct attribute_group ndtest_nvdimm_attribute_group = {
+	.name = "papr",
+	.attrs = ndtest_nvdimm_attributes,
+	.is_visible = ndtest_nvdimm_attr_visible,
+};
+
+static const struct attribute_group *ndtest_nvdimm_attribute_groups[] = {
+	&ndtest_nvdimm_attribute_group,
+	NULL,
+};
+
 static int ndtest_dimm_register(struct ndtest_priv *priv,
 				struct ndtest_dimm *dimm, int id)
 {
@@ -230,7 +427,8 @@ static int ndtest_dimm_register(struct ndtest_priv *priv,
 		set_bit(NDD_LABELING, &dimm_flags);
 	}
 
-	dimm->nvdimm = nvdimm_create(priv->bus, dimm, NULL, dimm_flags,
+	dimm->nvdimm = nvdimm_create(priv->bus, dimm,
+				    ndtest_nvdimm_attribute_groups, dimm_flags,
 				    NDTEST_SCM_DIMM_CMD_MASK, 0, NULL);
 	if (!dimm->nvdimm) {
 		dev_err(dev, "Error creating DIMM object for %pOF\n", priv->dn);
@@ -239,7 +437,7 @@ static int ndtest_dimm_register(struct ndtest_priv *priv,
 
 	dimm->dev = device_create_with_groups(ndtest_dimm_class,
 					     &priv->pdev.dev,
-					     0, dimm, NULL,
+					     0, dimm, dimm_attribute_groups,
 					     "test_dimm%d", id);
 	if (!dimm->dev) {
 		pr_err("Could not create dimm device attributes\n");
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
