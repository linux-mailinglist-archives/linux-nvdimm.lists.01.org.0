Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8B9197E43
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Mar 2020 16:22:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E97FB10FC36E5;
	Mon, 30 Mar 2020 07:23:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=huawei.com; envelope-from=yuehaibing@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 202E410FC337F
	for <linux-nvdimm@lists.01.org>; Mon, 30 Mar 2020 07:23:40 -0700 (PDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 6B56F5D28BC866C93547;
	Mon, 30 Mar 2020 22:22:47 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 22:22:39 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>, <aneesh.kumar@linux.ibm.com>,
	<jmoyer@redhat.com>
Subject: [PATCH -next] libnvdimm/region: Fix build error
Date: Mon, 30 Mar 2020 22:19:43 +0800
Message-ID: <20200330141943.31696-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Message-ID-Hash: 2PVF6HM6YXPWR7HP56DLDJOJYSWRGTLE
X-Message-ID-Hash: 2PVF6HM6YXPWR7HP56DLDJOJYSWRGTLE
X-MailFrom: yuehaibing@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2PVF6HM6YXPWR7HP56DLDJOJYSWRGTLE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gQ09ORklHX1BQQzMyPXkgYnVpbGQgZmFpbHM6DQoNCmRyaXZlcnMvbnZkaW1tL3JlZ2lvbl9k
ZXZzLmM6MTAzNDoxNDogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmGRvX2RpduKAmQ0K
ICByZW1haW5kZXIgPSBkb19kaXYocGVyX21hcHBpbmcsIG1hcHBpbmdzKTsNCiAgICAgICAgICAg
ICAgXn5+fn5+DQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9n
ZW5lcmF0ZWQvYXNtL2RpdjY0Lmg6MTowLA0KICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVk
ZS9saW51eC9rZXJuZWwuaDoxOCwNCiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvYXNt
LWdlbmVyaWMvYnVnLmg6MTksDQogICAgICAgICAgICAgICAgIGZyb20gLi9hcmNoL3Bvd2VycGMv
aW5jbHVkZS9hc20vYnVnLmg6MTA5LA0KICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9s
aW51eC9idWcuaDo1LA0KICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9zY2F0
dGVybGlzdC5oOjcsDQogICAgICAgICAgICAgICAgIGZyb20gZHJpdmVycy9udmRpbW0vcmVnaW9u
X2RldnMuYzo1Og0KLi9pbmNsdWRlL2FzbS1nZW5lcmljL2RpdjY0Lmg6MjQzOjIyOiBlcnJvcjog
cGFzc2luZyBhcmd1bWVudCAxIG9mIOKAmF9fZGl2NjRfMzLigJkgZnJvbSBpbmNvbXBhdGlibGUg
cG9pbnRlciB0eXBlIFstV2Vycm9yPWluY29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQ0KICAgX19y
ZW0gPSBfX2RpdjY0XzMyKCYobiksIF9fYmFzZSk7IFwNCg0KVXNlIGRpdl91NjQgaW5zdGVhZCBv
ZiBkb19kaXYgdG8gZml4IHRoaXMuDQoNCkZpeGVzOiAyNTIyYWZiODZhOGMgKCJsaWJudmRpbW0v
cmVnaW9uOiBJbnRyb2R1Y2UgYW4gJ2FsaWduJyBhdHRyaWJ1dGUiKQ0KU2lnbmVkLW9mZi1ieTog
WXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KLS0tDQogZHJpdmVycy9udmRpbW0v
cmVnaW9uX2RldnMuYyB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9yZWdpb25fZGV2
cy5jIGIvZHJpdmVycy9udmRpbW0vcmVnaW9uX2RldnMuYw0KaW5kZXggYmYyMzllNzgzOTQwLi4y
MjkxZjA2NDlkMjcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252ZGltbS9yZWdpb25fZGV2cy5jDQor
KysgYi9kcml2ZXJzL252ZGltbS9yZWdpb25fZGV2cy5jDQpAQCAtNTY0LDcgKzU2NCw3IEBAIHN0
YXRpYyBzc2l6ZV90IGFsaWduX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwNCiAJICogc3BhY2Ug
Zm9yIHRoZSBuYW1lc3BhY2UuDQogCSAqLw0KIAlkcGEgPSB2YWw7DQotCXJlbWFpbmRlciA9IGRv
X2RpdihkcGEsIG5kX3JlZ2lvbi0+bmRyX21hcHBpbmdzKTsNCisJcmVtYWluZGVyID0gZGl2X3U2
NChkcGEsIG5kX3JlZ2lvbi0+bmRyX21hcHBpbmdzKTsNCiAJaWYgKCFpc19wb3dlcl9vZl8yKGRw
YSkgfHwgZHBhIDwgUEFHRV9TSVpFDQogCQkJfHwgdmFsID4gcmVnaW9uX3NpemUobmRfcmVnaW9u
KSB8fCByZW1haW5kZXIpDQogCQlyZXR1cm4gLUVJTlZBTDsNCkBAIC0xMDMxLDcgKzEwMzEsNyBA
QCBzdGF0aWMgdW5zaWduZWQgbG9uZyBkZWZhdWx0X2FsaWduKHN0cnVjdCBuZF9yZWdpb24gKm5k
X3JlZ2lvbikNCiANCiAJbWFwcGluZ3MgPSBtYXhfdCh1MTYsIDEsIG5kX3JlZ2lvbi0+bmRyX21h
cHBpbmdzKTsNCiAJcGVyX21hcHBpbmcgPSBhbGlnbjsNCi0JcmVtYWluZGVyID0gZG9fZGl2KHBl
cl9tYXBwaW5nLCBtYXBwaW5ncyk7DQorCXJlbWFpbmRlciA9IGRpdl91NjQocGVyX21hcHBpbmcs
IG1hcHBpbmdzKTsNCiAJaWYgKHJlbWFpbmRlcikNCiAJCWFsaWduICo9IG1hcHBpbmdzOw0KIA0K
LS0gDQoyLjE3LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEu
b3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxp
c3RzLjAxLm9yZwo=
