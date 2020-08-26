Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 296F3252E99
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Aug 2020 14:19:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 612B8123F3552;
	Wed, 26 Aug 2020 05:19:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.191; helo=huawei.com; envelope-from=yuehaibing@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2C278123F0FE3
	for <linux-nvdimm@lists.01.org>; Wed, 26 Aug 2020 05:18:59 -0700 (PDT)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 6307F1CE024FDD78DF13;
	Wed, 26 Aug 2020 20:18:55 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 26 Aug 2020
 20:18:44 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>, <mingo@kernel.org>
Subject: [PATCH] libnvdimm/e820: Fix build error without MEMORY_HOTPLUG
Date: Wed, 26 Aug 2020 20:18:00 +0800
Message-ID: <20200826121800.732-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Message-ID-Hash: E7Q7F3MRXOH5H2QSPSFJGIAKICCXJL5I
X-Message-ID-Hash: E7Q7F3MRXOH5H2QSPSFJGIAKICCXJL5I
X-MailFrom: yuehaibing@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E7Q7F3MRXOH5H2QSPSFJGIAKICCXJL5I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SWYgTUVNT1JZX0hPVFBMVUcgaXMgbiwgYnVpbGQgZmFpbHM6DQoNCmRyaXZlcnMvbnZkaW1tL2U4
MjAuYzogSW4gZnVuY3Rpb24g4oCYZTgyMF9yZWdpc3Rlcl9vbmXigJk6DQpkcml2ZXJzL252ZGlt
bS9lODIwLmM6MjQ6MTI6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDi
gJhwaHlzX3RvX3RhcmdldF9ub2Rl4oCZOyBkaWQgeW91IG1lYW4g4oCYc2V0X3BhZ2Vfbm9kZeKA
mT8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQogIGludCBuaWQgPSBw
aHlzX3RvX3RhcmdldF9ub2RlKHJlcy0+c3RhcnQpOw0KICAgICAgICAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+fg0KICAgICAgICAgICAgc2V0X3BhZ2Vfbm9kZQ0KDQpGaXhlczogN2IyN2E4NjIyZjgw
ICgibGlibnZkaW1tL2U4MjA6IFJldHJpZXZlIGFuZCBwb3B1bGF0ZSBjb3JyZWN0ICd0YXJnZXRf
bm9kZScgaW5mbyIpDQpTaWduZWQtb2ZmLWJ5OiBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdl
aS5jb20+DQotLS0NCiBkcml2ZXJzL252ZGltbS9lODIwLmMgfCA3ICsrKysrKysNCiAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9l
ODIwLmMgYi9kcml2ZXJzL252ZGltbS9lODIwLmMNCmluZGV4IDRjZDE4YmU5ZDBlOS4uYzc0MWYw
MjlmMjE1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udmRpbW0vZTgyMC5jDQorKysgYi9kcml2ZXJz
L252ZGltbS9lODIwLmMNCkBAIC0xNyw2ICsxNywxMyBAQCBzdGF0aWMgaW50IGU4MjBfcG1lbV9y
ZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJcmV0dXJuIDA7DQogfQ0KIA0K
KyNpZm5kZWYgQ09ORklHX01FTU9SWV9IT1RQTFVHDQorc3RhdGljIGlubGluZSBpbnQgcGh5c190
b190YXJnZXRfbm9kZSh1NjQgc3RhcnQpDQorew0KKwlyZXR1cm4gMDsNCit9DQorI2VuZGlmDQor
DQogc3RhdGljIGludCBlODIwX3JlZ2lzdGVyX29uZShzdHJ1Y3QgcmVzb3VyY2UgKnJlcywgdm9p
ZCAqZGF0YSkNCiB7DQogCXN0cnVjdCBuZF9yZWdpb25fZGVzYyBuZHJfZGVzYzsNCi0tIA0KMi4x
Ny4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1
bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5v
cmcK
