Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 809202E0554
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Dec 2020 05:23:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 379D4100EBBDF;
	Mon, 21 Dec 2020 20:23:33 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6E0DA100EBB68
	for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:23:31 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id g18so7595745pgk.1
        for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ic2mMqvpqTjhjjMuE4exv7qpNi/mu6fZmsdb6XwpV9A=;
        b=izIiwdp2dqtliqjLOv56riug7+y3Oyem1Xh7vtlGN5iTW98OdhuL5AG32xgdsLVFwO
         eaRgUBfRZ+FL0hgQjZ2iZxMhDGhgdcfWJZhDCmkxa2QaYEk8i8nYzkovv7Zf59cx7tQj
         pjNzqGFRCIUrlxbglSkoTVa+7yJueGx3O6SF8lqJoYtkk0y8LMQqAFW3RtIUj+54qJdJ
         eBQ4H8ZGpSlxE6CIkuXa041mk8rzawUEWNPpmsrzeNODY06E9EdhWaVNLP4hzu7X48Cn
         n56JIZBgpagkVDFFQAwgafa55jrWY3RtLlx2iWstRed3xbkJyl3Huc3XUqMArRDxDEf0
         2yOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ic2mMqvpqTjhjjMuE4exv7qpNi/mu6fZmsdb6XwpV9A=;
        b=SEgJEH/hAT/LaVrvsqGZDu5Lo6q1ZJwv/nbWPkXd0TMCSQWBA+Yt/pvE51dhAYKvB8
         NzFHI2LkkX492SMx0VV1ev2bh9rDiLXsCYW+HkOY8ucRa5cx3hDZtIu5DFamdQedYkiH
         TibP1y1Vpaq0+xZV+0+5y8uDq29diUFN7c9nDry0f5akE/hQmL82IAo5q6mP0TlPDC98
         SGIU7kVdnQfS8Q+Zwe8VXxqDiNCVw+6nNPioPuScfAUsKfWPc8OB0EOvPU6GUsjm2UBh
         WwdomhEiEdJCTVO19j7GJyPEgDHKhX7TyMHmp/GyPtdyFo2rjznkaOusNaKoqYtRGDaA
         P+Sw==
X-Gm-Message-State: AOAM533d4C/xRr+0MlCPJ6rbQRN4Sk07X0iLZPRVqr2V+zzpvAZMYsC3
	eZFmkJYKGrKg9KXfBHlE+Cdxgo4a2BD4Dg==
X-Google-Smtp-Source: ABdhPJxx2s5Puy0PZQRG7w/Mxjy1n1Zt/1I/iB6D01kXLtySLK6aEGS1hOLeJ7veUNk0TYiaKhb5DQ==
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id 144-20020a6218960000b0290197491cbe38mr18343506pfy.15.1608611010822;
        Mon, 21 Dec 2020 20:23:30 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id s5sm17909498pfh.5.2020.12.21.20.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 20:23:30 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH 4/7] ndtest: Add dimm attributes
Date: Tue, 22 Dec 2020 09:52:37 +0530
Message-Id: <20201222042240.2983755-5-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201222042240.2983755-1-santosh@fossix.org>
References: <20201222042240.2983755-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: 2OBGMRHQ6JDTMG2GXRBB7NVFWAK6WFYG
X-Message-ID-Hash: 2OBGMRHQ6JDTMG2GXRBB7NVFWAK6WFYG
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2OBGMRHQ6JDTMG2GXRBB7NVFWAK6WFYG/>
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
