Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643C82D9668
	for <lists+linux-nvdimm@lfdr.de>; Mon, 14 Dec 2020 11:39:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 090E8100EF26A;
	Mon, 14 Dec 2020 02:39:29 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7D274100EF24F
	for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:39:26 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id f9so11806665pfc.11
        for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjABGvSacIOV2MEix+R8giDapdsizfjk5AYSaGkfsSo=;
        b=Q7OPl7PpsChx5jXFDOZqX/h8uMDoyQ8uouNQU4yoM7FyMx8DR0eIgOqR5aC1hqnt5l
         CxlcR5dh9GcShgDhoUM3C5EFyDvGmhrwd+4xFiZOQKDOm0cJogC49F9PHQC50ZKB6wfK
         KGzBvlai7qfBJOC8VlM6r3HEIYaI3xCN7E7SzqP2QX15MgkZBkeZDNq0O4I8zGgduEsp
         0+MW5tysS9HYULTGyBGWb6BzO5I34CGviuP7+mS+M4vheeCaGFHtIsg5AV/Y2h9yJ9R2
         +m7YdXujUKGl1jQf9g1zhwp125V4QNDDcikFeI/6ZRbbzLoXxdXmMVwsX8NMsUlKNBYr
         zU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjABGvSacIOV2MEix+R8giDapdsizfjk5AYSaGkfsSo=;
        b=XO14Izn/JEyZJD0Z+eBxEFUDyGutQ6sVxtkkSahI7kyBH2bvkD0tTnrmboU0FxKWIS
         LBzg2JSIgn7c1MKlZBxK9Qln75uF1UaWK5y6L+FCOJ4FMjgTNOmIlX4ruUx18vc7SDgI
         rXzvqLsQlwPs1LXU2Ivh50/I1z3lAOqQdI/g6eAWFxBaqALPquGkVKqb+ckYE39R9Fzn
         gpY5Eav4A3dniHw9vg8f3zxPF+MviNH0LwXWsXtCo7EKc6jH2FZGDH/hqU+M110Qa3AW
         prRgA20/ud1ah8AzPvovFuxBlnBNN1weByufyHTmIQllXCvBYLjDMndpkoJX7eY9joXn
         3y5A==
X-Gm-Message-State: AOAM533mBRyOKb66pzC8ULk+JlbQEPsgho+hsuKV2w8OU/Vex0jI6o3C
	+hlRT3ARQpFoLQx05YwRd89OkkwyKcSaMQ==
X-Google-Smtp-Source: ABdhPJyd2OWbhZy8iXl5LROxAj9p90G7x1BUiGzzsuESpQhaTGcX5lv5LUMwFhTGl1OEGiS32r1rNg==
X-Received: by 2002:a63:609:: with SMTP id 9mr1345574pgg.391.1607942365685;
        Mon, 14 Dec 2020 02:39:25 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id p1sm20735926pfb.208.2020.12.14.02.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 02:39:25 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [RFC v5 1/7] testing/nvdimm: Add test module for non-nfit platforms
Date: Mon, 14 Dec 2020 16:08:53 +0530
Message-Id: <20201214103859.2409175-2-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214103859.2409175-1-santosh@fossix.org>
References: <20201214103859.2409175-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: I4IP3NMBSMU5TONCT5SF4HFBAF6FJZDJ
X-Message-ID-Hash: I4IP3NMBSMU5TONCT5SF4HFBAF6FJZDJ
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I4IP3NMBSMU5TONCT5SF4HFBAF6FJZDJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The current test module cannot be used for testing platforms (make check)
that do not have support for NFIT. In order to get the ndctl tests working,
we need a module which can emulate NVDIMM devices without relying on
ACPI/NFIT.

The aim of this proposed module is to implement a similar functionality to
the existing module but without the ACPI dependencies.

This RFC series is split into reviewable and compilable chunks.

This patch adds a new driver and registers two nvdimm bus needed for ndctl
make check.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 tools/testing/nvdimm/config_check.c |   3 +-
 tools/testing/nvdimm/test/Kbuild    |   6 +-
 tools/testing/nvdimm/test/ndtest.c  | 206 ++++++++++++++++++++++++++++
 tools/testing/nvdimm/test/ndtest.h  |  16 +++
 4 files changed, 229 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/nvdimm/test/ndtest.c
 create mode 100644 tools/testing/nvdimm/test/ndtest.h

diff --git a/tools/testing/nvdimm/config_check.c b/tools/testing/nvdimm/config_check.c
index cac891028cd1..3e3a5f518864 100644
--- a/tools/testing/nvdimm/config_check.c
+++ b/tools/testing/nvdimm/config_check.c
@@ -12,7 +12,8 @@ void check(void)
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_ND_BTT));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_ND_PFN));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_ND_BLK));
-	BUILD_BUG_ON(!IS_MODULE(CONFIG_ACPI_NFIT));
+	if (IS_ENABLED(CONFIG_ACPI_NFIT))
+		BUILD_BUG_ON(!IS_MODULE(CONFIG_ACPI_NFIT));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_DEV_DAX));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_DEV_DAX_PMEM));
 }
diff --git a/tools/testing/nvdimm/test/Kbuild b/tools/testing/nvdimm/test/Kbuild
index 75baebf8f4ba..197bcb2b7f35 100644
--- a/tools/testing/nvdimm/test/Kbuild
+++ b/tools/testing/nvdimm/test/Kbuild
@@ -5,5 +5,9 @@ ccflags-y += -I$(srctree)/drivers/acpi/nfit/
 obj-m += nfit_test.o
 obj-m += nfit_test_iomap.o
 
-nfit_test-y := nfit.o
+ifeq  ($(CONFIG_ACPI_NFIT),m)
+	nfit_test-y := nfit.o
+else
+	nfit_test-y := ndtest.o
+endif
 nfit_test_iomap-y := iomap.o
diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
new file mode 100644
index 000000000000..f89d74fdcdee
--- /dev/null
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/genalloc.h>
+#include <linux/vmalloc.h>
+#include <linux/dma-mapping.h>
+#include <linux/list_sort.h>
+#include <linux/libnvdimm.h>
+#include <linux/ndctl.h>
+#include <nd-core.h>
+#include <linux/printk.h>
+#include <linux/seq_buf.h>
+
+#include "../watermark.h"
+#include "nfit_test.h"
+#include "ndtest.h"
+
+enum {
+	DIMM_SIZE = SZ_32M,
+	LABEL_SIZE = SZ_128K,
+	NUM_INSTANCES = 2,
+	NUM_DCR = 4,
+};
+
+static struct ndtest_priv *instances[NUM_INSTANCES];
+static struct class *ndtest_dimm_class;
+
+static inline struct ndtest_priv *to_ndtest_priv(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return container_of(pdev, struct ndtest_priv, pdev);
+}
+
+static int ndtest_ctl(struct nvdimm_bus_descriptor *nd_desc,
+		      struct nvdimm *nvdimm, unsigned int cmd, void *buf,
+		      unsigned int buf_len, int *cmd_rc)
+{
+	struct ndtest_dimm *dimm;
+	int _cmd_rc;
+
+	if (!cmd_rc)
+		cmd_rc = &_cmd_rc;
+
+	*cmd_rc = 0;
+
+	if (!nvdimm)
+		return -EINVAL;
+
+	dimm = nvdimm_provider_data(nvdimm);
+	if (!dimm)
+		return -EINVAL;
+
+	switch (cmd) {
+	case ND_CMD_GET_CONFIG_SIZE:
+	case ND_CMD_GET_CONFIG_DATA:
+	case ND_CMD_SET_CONFIG_DATA:
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ndtest_bus_register(struct ndtest_priv *p)
+{
+	p->bus_desc.ndctl = ndtest_ctl;
+	p->bus_desc.module = THIS_MODULE;
+	p->bus_desc.provider_name = NULL;
+
+	p->bus = nvdimm_bus_register(&p->pdev.dev, &p->bus_desc);
+	if (!p->bus) {
+		dev_err(&p->pdev.dev, "Error creating nvdimm bus %pOF\n", p->dn);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int ndtest_remove(struct platform_device *pdev)
+{
+	struct ndtest_priv *p = to_ndtest_priv(&pdev->dev);
+
+	nvdimm_bus_unregister(p->bus);
+	return 0;
+}
+
+static int ndtest_probe(struct platform_device *pdev)
+{
+	struct ndtest_priv *p;
+
+	p = to_ndtest_priv(&pdev->dev);
+	if (ndtest_bus_register(p))
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, p);
+
+	return 0;
+}
+
+static const struct platform_device_id ndtest_id[] = {
+	{ KBUILD_MODNAME },
+	{ },
+};
+
+static struct platform_driver ndtest_driver = {
+	.probe = ndtest_probe,
+	.remove = ndtest_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.id_table = ndtest_id,
+};
+
+static void ndtest_release(struct device *dev)
+{
+	struct ndtest_priv *p = to_ndtest_priv(dev);
+
+	kfree(p);
+}
+
+static void cleanup_devices(void)
+{
+	int i;
+
+	for (i = 0; i < NUM_INSTANCES; i++)
+		if (instances[i])
+			platform_device_unregister(&instances[i]->pdev);
+
+	nfit_test_teardown();
+
+	if (ndtest_dimm_class)
+		class_destroy(ndtest_dimm_class);
+}
+
+static __init int ndtest_init(void)
+{
+	int rc, i;
+
+	pmem_test();
+	libnvdimm_test();
+	device_dax_test();
+	dax_pmem_test();
+	dax_pmem_core_test();
+#ifdef CONFIG_DEV_DAX_PMEM_COMPAT
+	dax_pmem_compat_test();
+#endif
+
+	ndtest_dimm_class = class_create(THIS_MODULE, "nfit_test_dimm");
+	if (IS_ERR(ndtest_dimm_class)) {
+		rc = PTR_ERR(ndtest_dimm_class);
+		goto err_register;
+	}
+
+	/* Each instance can be taken as a bus, which can have multiple dimms */
+	for (i = 0; i < NUM_INSTANCES; i++) {
+		struct ndtest_priv *priv;
+		struct platform_device *pdev;
+
+		priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+		if (!priv) {
+			rc = -ENOMEM;
+			goto err_register;
+		}
+
+		INIT_LIST_HEAD(&priv->resources);
+		pdev = &priv->pdev;
+		pdev->name = KBUILD_MODNAME;
+		pdev->id = i;
+		pdev->dev.release = ndtest_release;
+		rc = platform_device_register(pdev);
+		if (rc) {
+			put_device(&pdev->dev);
+			goto err_register;
+		}
+		get_device(&pdev->dev);
+
+		instances[i] = priv;
+	}
+
+	rc = platform_driver_register(&ndtest_driver);
+	if (rc)
+		goto err_register;
+
+	return 0;
+
+err_register:
+	pr_err("Error registering platform device\n");
+	cleanup_devices();
+
+	return rc;
+}
+
+static __exit void ndtest_exit(void)
+{
+	cleanup_devices();
+	platform_driver_unregister(&ndtest_driver);
+}
+
+module_init(ndtest_init);
+module_exit(ndtest_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("IBM Corporation");
diff --git a/tools/testing/nvdimm/test/ndtest.h b/tools/testing/nvdimm/test/ndtest.h
new file mode 100644
index 000000000000..831ac5c65f50
--- /dev/null
+++ b/tools/testing/nvdimm/test/ndtest.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef NDTEST_H
+#define NDTEST_H
+
+#include <linux/platform_device.h>
+#include <linux/libnvdimm.h>
+
+struct ndtest_priv {
+	struct platform_device pdev;
+	struct device_node *dn;
+	struct list_head resources;
+	struct nvdimm_bus_descriptor bus_desc;
+	struct nvdimm_bus *bus;
+};
+
+#endif /* NDTEST_H */
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
