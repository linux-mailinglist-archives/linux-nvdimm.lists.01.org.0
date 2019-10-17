Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95019DA2FC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Oct 2019 03:20:51 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C8EE410FCD202;
	Wed, 16 Oct 2019 18:23:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=zhangliguang@linux.alibaba.com; receiver=<UNKNOWN> 
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4940510097D44
	for <linux-nvdimm@lists.01.org>; Wed, 16 Oct 2019 18:23:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TfGRvwi_1571275241;
Received: from 30.5.116.140(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TfGRvwi_1571275241)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Oct 2019 09:20:41 +0800
Subject: Re: [PATCH] libnvdimm: fix kernel-doc notation
To: "Weiny, Ira" <ira.weiny@intel.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "Verma, Vishal L" <vishal.l.verma@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Busch, Keith" <keith.busch@intel.com>
References: <1571192160-54202-1-git-send-email-zhangliguang@linux.alibaba.com>
 <2807E5FD2F6FDA4886F6618EAC48510E92B4C086@CRSMSX102.amr.corp.intel.com>
From: =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Message-ID: <3d3c1454-46f9-2e61-63b7-e1af2bc7d1a7@linux.alibaba.com>
Date: Thu, 17 Oct 2019 09:20:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E92B4C086@CRSMSX102.amr.corp.intel.com>
Message-ID-Hash: NTGYDRVCYV5SHO7W6Y6BLU4CGYI5XM2Y
X-Message-ID-Hash: NTGYDRVCYV5SHO7W6Y6BLU4CGYI5XM2Y
X-MailFrom: zhangliguang@linux.alibaba.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NTGYDRVCYV5SHO7W6Y6BLU4CGYI5XM2Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="gbk"; format="flowed"
Content-Transfer-Encoding: base64

SGkgV2VpbnksDQoNCtTaIDIwMTkvMTAvMTcgMDoyMCwgV2VpbnksIElyYSDQtLXAOg0KPj4gRml4
IGtlcm5lbC1kb2Mgbm90YXRpb24gaW4gZHJpdmVycy9udmRpbW0vbmFtZXNwYWNlX2RldnMuYy4N
Cj4+DQo+PiBGaXhlczogYmY5YmNjYzE0YzA1ICgibGlibnZkaW1tOiBwbWVtIGxhYmVsIHNldHMg
YW5kIG5hbWVzcGFjZQ0KPj4gaW5zdGFudGlhdGlvbi4iKQ0KPj4gU2lnbmVkLW9mZi1ieTogTGln
dWFuZyBaaGFuZyA8emhhbmdsaWd1YW5nQGxpbnV4LmFsaWJhYmEuY29tPg0KPj4gLS0tDQo+PiAg
IGRyaXZlcnMvbnZkaW1tL25hbWVzcGFjZV9kZXZzLmMgfCAyICstDQo+PiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL252ZGltbS9uYW1lc3BhY2VfZGV2cy5jDQo+PiBiL2RyaXZlcnMvbnZkaW1tL25hbWVz
cGFjZV9kZXZzLmMgaW5kZXggY2NhMGEzYi4uNWNmYjFlOSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvbnZkaW1tL25hbWVzcGFjZV9kZXZzLmMNCj4+ICsrKyBiL2RyaXZlcnMvbnZkaW1tL25hbWVz
cGFjZV9kZXZzLmMNCj4+IEBAIC0xOTAwLDcgKzE5MDAsNyBAQCBzdGF0aWMgaW50IHNlbGVjdF9w
bWVtX2lkKHN0cnVjdCBuZF9yZWdpb24NCj4+ICpuZF9yZWdpb24sIHU4ICpwbWVtX2lkKQ0KPj4g
ICAvKioNCj4+ICAgICogY3JlYXRlX25hbWVzcGFjZV9wbWVtIC0gdmFsaWRhdGUgaW50ZXJsZWF2
ZSBzZXQgbGFiZWxsaW5nLCByZXRyaWV2ZQ0KPj4gbGFiZWwwDQo+PiAgICAqIEBuZF9yZWdpb246
IHJlZ2lvbiB3aXRoIG1hcHBpbmdzIHRvIHZhbGlkYXRlDQo+PiAtICogQG5zcG06IHRhcmdldCBu
YW1lc3BhY2UgdG8gY3JlYXRlDQo+PiArICogQG5kaW5kZXg6IHRhcmdldCBuYW1lc3BhY2UgaW5k
ZXggdG8gY3JlYXRlDQo+IG5zaW5kZXg/ICAncyc/DQoNClllcy4gU29ycnkgZm9yIHRoaXMgZXJy
b3IsIEkgd2lsbCByZXNlbmQgaXQgYWdhaW4uDQoNCg0KUmVnYXJkcywNCg0KTGlndWFuZw0KDQo+
DQo+IElyYQ0KPg0KPj4gICAgKiBAbmRfbGFiZWw6IHRhcmdldCBwbWVtIG5hbWVzcGFjZSBsYWJl
bCB0byBldmFsdWF0ZQ0KPj4gICAgKi8NCj4+ICAgc3RhdGljIHN0cnVjdCBkZXZpY2UgKmNyZWF0
ZV9uYW1lc3BhY2VfcG1lbShzdHJ1Y3QgbmRfcmVnaW9uDQo+PiAqbmRfcmVnaW9uLA0KPj4gLS0N
Cj4+IDEuOC4zLjEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3Jn
ClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3Rz
LjAxLm9yZwo=
