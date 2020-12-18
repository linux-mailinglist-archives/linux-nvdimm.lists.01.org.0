Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEC32DDCAF
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 02:52:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 97FA2100EB855;
	Thu, 17 Dec 2020 17:52:13 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 3F52F100EB852
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 17:52:09 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.78,428,1599494400";
   d="scan'208";a="102687556"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2020 09:52:07 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id D6EE84CE4BCB;
	Fri, 18 Dec 2020 09:52:06 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Dec
 2020 09:52:06 +0800
Subject: Re: [RFC PATCH v3 8/9] md: Implement ->corrupted_range()
To: Jane Chu <jane.chu@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
	<linux-mm@kvack.org>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <20201215121414.253660-9-ruansy.fnst@cn.fujitsu.com>
 <100fcdf4-b2fe-d77d-e95f-52a7323d7ee1@oracle.com>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <8742889a-c967-d899-ff32-f4a4ebcde7ad@cn.fujitsu.com>
Date: Fri, 18 Dec 2020 09:50:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <100fcdf4-b2fe-d77d-e95f-52a7323d7ee1@oracle.com>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: D6EE84CE4BCB.A18A3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: PGYSGQEHYEMA53UUM4T5ZGDKP3XSXEOW
X-Message-ID-Hash: PGYSGQEHYEMA53UUM4T5ZGDKP3XSXEOW
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PGYSGQEHYEMA53UUM4T5ZGDKP3XSXEOW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjAvMTIvMTYg5LiL5Y2IMTo0MywgSmFuZSBDaHUgd3JvdGU6DQo+IE9uIDEyLzE1
LzIwMjAgNDoxNCBBTSwgU2hpeWFuZyBSdWFuIHdyb3RlOg0KPj4gwqAgI2lmZGVmIENPTkZJR19T
WVNGUw0KPj4gK2ludCBiZF9kaXNrX2hvbGRlcl9jb3JydXB0ZWRfcmFuZ2Uoc3RydWN0IGJsb2Nr
X2RldmljZSAqYmRldiwgbG9mZl90IA0KPj4gb2ZmLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzaXplX3QgbGVuLCB2b2lkICpkYXRhKTsNCj4+IMKgIGludCBiZF9s
aW5rX2Rpc2tfaG9sZGVyKHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIHN0cnVjdCBnZW5kaXNr
IA0KPj4gKmRpc2spOw0KPj4gwqAgdm9pZCBiZF91bmxpbmtfZGlza19ob2xkZXIoc3RydWN0IGJs
b2NrX2RldmljZSAqYmRldiwgc3RydWN0IGdlbmRpc2sgDQo+PiAqZGlzayk7DQo+PiDCoCAjZWxz
ZQ0KPj4gK2ludCBiZF9kaXNrX2hvbGRlcl9jb3JydXB0ZWRfcmFuZ2Uoc3RydWN0IGJsb2NrX2Rl
dmljZSAqYmRldiwgbG9mZl90IA0KPj4gb2ZmLA0KPiANCj4gRGlkIHlvdSBtZWFuDQo+ICDCoCBz
dGF0aWMgaW5saW5lIGludCBiZF9kaXNrX2hvbGRlcl9jb3JydXB0ZWRfcmFuZ2UoLi4NCj4gPw0K
DQpZZXMsIGl0J3MgbXkgZmF1bHQuICBUaGFua3MgYSBsb3QuDQoNCg0KLS0NClRoYW5rcywNClJ1
YW4gU2hpeWFuZy4NCg0KPiANCj4gdGhhbmtzLA0KPiAtamFuZQ0KPiANCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZV90IGxlbiwgdm9pZCAqZGF0YSkNCj4+ICt7
DQo+PiArwqDCoMKgIHJldHVybiAwOw0KPj4gK30NCj4+IMKgIHN0YXRpYyBpbmxpbmUgaW50IGJk
X2xpbmtfZGlza19ob2xkZXIoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwNCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGdlbmRpc2sgKmRp
c2spDQo+IA0KPiANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEu
b3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxp
c3RzLjAxLm9yZwo=
