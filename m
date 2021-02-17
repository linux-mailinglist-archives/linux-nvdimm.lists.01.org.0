Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7105A31D417
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 03:56:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 919CC100F226E;
	Tue, 16 Feb 2021 18:56:18 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 47A1F100F226D
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 18:56:15 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800";
   d="scan'208";a="104561557"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Feb 2021 10:56:13 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 374484CE72EC;
	Wed, 17 Feb 2021 10:56:13 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Feb
 2021 10:56:11 +0800
Subject: Re: [PATCH v3 05/11] mm, fsdax: Refactor memory-failure handler for
 dax mapping
To: Christoph Hellwig <hch@lst.de>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-6-ruansy.fnst@cn.fujitsu.com>
 <20210210133347.GD30109@lst.de>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <45a20d88-63ee-d678-ad86-6ccd8cdf7453@cn.fujitsu.com>
Date: Wed, 17 Feb 2021 10:56:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210210133347.GD30109@lst.de>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 374484CE72EC.AB75D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: QRHOYD76OV7DUB2ULQGMIKUWKUIJEVGX
X-Message-ID-Hash: QRHOYD76OV7DUB2ULQGMIKUWKUIJEVGX
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, dm-devel@redhat.com, darrick.wong@oracle.com, david@fromorbit.com, agk@redhat.com, snitzer@redhat.com, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QRHOYD76OV7DUB2ULQGMIKUWKUIJEVGX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjEvMi8xMCDkuIvljYg5OjMzLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+
ICtleHRlcm4gaW50IG1mX2RheF9tYXBwaW5nX2tpbGxfcHJvY3Moc3RydWN0IGFkZHJlc3Nfc3Bh
Y2UgKm1hcHBpbmcsIHBnb2ZmX3QgaW5kZXgsIGludCBmbGFncyk7DQo+IA0KPiBObyBuZWUgZm9y
IHRoZSBleHRlcm4sIHBsZWFzZSBhdm9pZCB0aGUgb3Zlcmx5IGxvbmcgbGluZS4NCg0KT0suDQoN
CkknZCBsaWtlIHRvIGNvbmZpcm0gb25lIHRoaW5nLi4uICBJIGhhdmUgY2hlY2tlZCBhbGwgb2Yg
dGhpcyBwYXRjaHNldCBieSANCmNoZWNrcGF0Y2gucGwgYW5kIGl0IGRpZCBub3QgcmVwb3J0IHRo
ZSBvdmVybHkgbG9uZyBsaW5lIHdhcm5pbmcuICBTbywgSSANCnNob3VsZCBzdGlsbCBvYmV5IHRo
ZSBydWxlIG9mIDgwIGNoYXJzIG9uZSBsaW5lPw0KDQo+IA0KPj4gQEAgLTEyMCw2ICsxMjEsMTMg
QEAgc3RhdGljIGludCBod3BvaXNvbl9maWx0ZXJfZGV2KHN0cnVjdCBwYWdlICpwKQ0KPj4gICAJ
aWYgKFBhZ2VTbGFiKHApKQ0KPj4gICAJCXJldHVybiAtRUlOVkFMOw0KPj4gICANCj4+ICsJaWYg
KHBmbl92YWxpZChwYWdlX3RvX3BmbihwKSkpIHsNCj4+ICsJCWlmIChpc19kZXZpY2VfZnNkYXhf
cGFnZShwKSkNCj4+ICsJCQlyZXR1cm4gMDsNCj4+ICsJCWVsc2UNCj4+ICsJCQlyZXR1cm4gLUVJ
TlZBTDsNCj4+ICsJfQ0KPj4gKw0KPiANCj4gVGhpcyBsb29rcyBvZGQuICBGb3Igb25lIHRoZXJl
IGlzIG5vIG5lZWQgZm9yIGFuIGVsc2UgYWZ0ZXIgYSByZXR1cm4uDQo+IEJ1dCBtb3JlIGltcG9y
dGFudGx5IHBhZ2VfbWFwcGluZygpIGFzIGNhbGxlZCBiZWxvdyBwcmV0dHkgbXVjaCBhc3N1bWVz
DQo+IGEgdmFsaWQgUEZOLCBzbyBzb21ldGhpbmcgaXMgZmlzaHkgaW4gdGhpcyBmdW5jdGlvbi4N
Cg0KWWVzLCBhIG1pc3Rha2UgaGVyZS4gIEknbGwgZml4IGl0Lg0KDQo+IA0KPj4gKwlpZiAoaXNf
em9uZV9kZXZpY2VfcGFnZShwKSkgew0KPj4gKwkJaWYgKGlzX2RldmljZV9mc2RheF9wYWdlKHAp
KQ0KPj4gKwkJCXRrLT5hZGRyID0gdm1hLT52bV9zdGFydCArDQo+PiArCQkJCQkoKHBnb2ZmIC0g
dm1hLT52bV9wZ29mZikgPDwgUEFHRV9TSElGVCk7DQo+IA0KPiBUaGUgYXJpdGhtZXRpY3MgaGVy
ZSBzY3JlYW0gZm9yIGEgY29tbW9uIGhlbHBlciwgSSBzdXNwZWN0IHRoZXJlIG1pZ2h0DQo+IGJl
IG90aGVyIHBsYWNlcyB0aGF0IGNvdWxkIHVzZSB0aGUgc2FtZSBoZWxwZXIuDQo+IA0KPj4gK2lu
dCBtZl9kYXhfbWFwcGluZ19raWxsX3Byb2NzKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5n
LCBwZ29mZl90IGluZGV4LCBpbnQgZmxhZ3MpDQo+IA0KPiBPdmVybHkgbG9uZyBsaW5lLiAgQWxz
byB0aGUgbmFtaW5nIHNjaGVtZSB3aXRoIHRoZSBtZl8gc2VlbXMgcmF0aGVyDQo+IHVudXN1YWwu
IE1heWJlIGRheF9raWxsX21hcHBpbmdfcHJvY3M/ICBBbHNvIHBsZWFzZSBhZGQgYSBrZXJuZWxk
b2MNCj4gY29tbWVudCBkZXNjcmliaW5nIHRoZSBmdW5jdGlvbiBnaXZlbiB0aGF0IGl0IGV4cG9y
dGVkLg0KPiANCg0KT0suICBUaGFua3MgZm9yIHlvdXIgZ3VpZGFuY2UuDQoNCg0KLS0NClRoYW5r
cywNClJ1YW4gU2hpeWFuZy4NCg0KPiANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRp
bW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZk
aW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
