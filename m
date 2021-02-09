Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 380563145D9
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Feb 2021 02:53:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7B47D100EB84E;
	Mon,  8 Feb 2021 17:53:19 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 09B1F100EBB67
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 17:53:16 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.81,163,1610380800";
   d="scan'208";a="104350575"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Feb 2021 09:53:15 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 9EFD34CE6F82;
	Tue,  9 Feb 2021 09:53:10 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 09:53:08 +0800
Subject: Re: [PATCH 3/7] fsdax: Copy data before write
To: Christoph Hellwig <hch@lst.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-4-ruansy.fnst@cn.fujitsu.com>
 <20210208151419.GC12872@lst.de>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <3f2826a8-df98-e7b0-6ab8-0f410488bc55@cn.fujitsu.com>
Date: Tue, 9 Feb 2021 09:53:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208151419.GC12872@lst.de>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 9EFD34CE6F82.AF079
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: 4KDPN4B7PCGXFCDGBXKI7GH62JBEWNYT
X-Message-ID-Hash: 4KDPN4B7PCGXFCDGBXKI7GH62JBEWNYT
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4KDPN4B7PCGXFCDGBXKI7GH62JBEWNYT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjEvMi84IOS4i+WNiDExOjE0LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+
ICAgCXN3aXRjaCAoaW9tYXAudHlwZSkgew0KPj4gICAJY2FzZSBJT01BUF9NQVBQRUQ6DQo+PiAr
Y293Og0KPj4gICAJCWlmIChpb21hcC5mbGFncyAmIElPTUFQX0ZfTkVXKSB7DQo+PiAgIAkJCWNv
dW50X3ZtX2V2ZW50KFBHTUFKRkFVTFQpOw0KPj4gICAJCQljb3VudF9tZW1jZ19ldmVudF9tbSh2
bWEtPnZtX21tLCBQR01BSkZBVUxUKTsNCj4+ICAgCQkJbWFqb3IgPSBWTV9GQVVMVF9NQUpPUjsN
Cj4+ICAgCQl9DQo+PiAgIAkJZXJyb3IgPSBkYXhfaW9tYXBfZGlyZWN0X2FjY2VzcygmaW9tYXAs
IHBvcywgUEFHRV9TSVpFLA0KPj4gLQkJCQkJCU5VTEwsICZwZm4pOw0KPj4gKwkJCQkJCSZrYWRk
ciwgJnBmbik7DQo+IA0KPiBBbnkgY2hhbmNlIHlvdSBjb3VsZCBsb29rIGludG8gZmFjdG9yaW5n
IG91dCB0aGlzIGNvZGUgaW50byBhIGhlbHBlcg0KPiB0byBhdm9pZCB0aGUgZ290byBtYWdpYywg
d2hpY2ggaXMgYSBsaXR0bGUgdG9vIGNvbnZvbHV0ZWQ/DQo+IA0KPj4gICAJc3dpdGNoIChpb21h
cC50eXBlKSB7DQo+PiAgIAljYXNlIElPTUFQX01BUFBFRDoNCj4+ICtjb3c6DQo+PiAgIAkJZXJy
b3IgPSBkYXhfaW9tYXBfZGlyZWN0X2FjY2VzcygmaW9tYXAsIHBvcywgUE1EX1NJWkUsDQo+PiAt
CQkJCQkJTlVMTCwgJnBmbik7DQo+PiArCQkJCQkJJmthZGRyLCAmcGZuKTsNCj4+ICAgCQlpZiAo
ZXJyb3IgPCAwKQ0KPj4gICAJCQlnb3RvIGZpbmlzaF9pb21hcDsNCj4+ICAgDQo+PiAgIAkJZW50
cnkgPSBkYXhfaW5zZXJ0X2VudHJ5KCZ4YXMsIG1hcHBpbmcsIHZtZiwgZW50cnksIHBmbiwNCj4+
ICAgCQkJCQkJREFYX1BNRCwgd3JpdGUgJiYgIXN5bmMpOw0KPj4gICANCj4+ICsJCWlmIChzcmNt
YXAudHlwZSAhPSBJT01BUF9IT0xFKSB7DQo+IA0KPiBTYW1lIGhlcmUuDQoNClRoYW5rcyBmb3Ig
c3VnZ2VzdGlvbi4gIEknbGwgdHJ5IGl0Lg0KDQoNCi0tDQpUaGFua3MsDQpSdWFuIFNoaXlhbmcu
DQo+IA0KPiANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3Jn
ClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3Rz
LjAxLm9yZwo=
