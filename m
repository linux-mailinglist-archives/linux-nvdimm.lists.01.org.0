Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF47314B34
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Feb 2021 10:15:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 27BE7100EB34F;
	Tue,  9 Feb 2021 01:15:24 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 7BD1A100EBB72
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 01:15:21 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800";
   d="scan'208";a="104367244"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Feb 2021 17:15:20 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id A2C304CE6F86;
	Tue,  9 Feb 2021 17:15:13 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 17:15:12 +0800
Subject: Re: [PATCH 5/7] fsdax: Dedup file range to use a compare function
To: Christoph Hellwig <hch@lst.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-6-ruansy.fnst@cn.fujitsu.com>
 <20210208151920.GE12872@lst.de>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <9193e305-22a1-3928-0675-af1cecd28942@cn.fujitsu.com>
Date: Tue, 9 Feb 2021 17:15:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208151920.GE12872@lst.de>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: A2C304CE6F86.ACFE6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: B6WXDLVWEZYBYQR44AD7QC45S65WGOOI
X-Message-ID-Hash: B6WXDLVWEZYBYQR44AD7QC45S65WGOOI
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, rgoldwyn@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B6WXDLVWEZYBYQR44AD7QC45S65WGOOI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjEvMi84IOS4i+WNiDExOjE5LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4g
T24gTW9uLCBGZWIgMDgsIDIwMjEgYXQgMDE6MDk6MjJBTSArMDgwMCwgU2hpeWFuZyBSdWFuIHdy
b3RlOg0KPj4gV2l0aCBkYXggd2UgY2Fubm90IGRlYWwgd2l0aCByZWFkcGFnZSgpIGV0Yy4gU28s
IHdlIGNyZWF0ZSBhDQo+PiBmdW5jaXRvbiBjYWxsYmFjayB0byBwZXJmb3JtIHRoZSBmaWxlIGRh
dGEgY29tcGFyaXNvbiBhbmQgcGFzcw0KPiANCj4gcy9mdW5jaXRvbi9mdW5jdGlvbi9nDQo+IA0K
Pj4gKyNkZWZpbmUgTUlOKGEsIGIpICgoKGEpIDwgKGIpKSA/IChhKSA6IChiKSkNCj4gDQo+IFRo
aXMgc2hvdWxkIHVzZSB0aGUgZXhpc3RpbmcgbWluIG9yIG1pbl90IGhlbHBlcnMuDQo+IA0KPiAN
Cj4+ICAgaW50IGdlbmVyaWNfcmVtYXBfZmlsZV9yYW5nZV9wcmVwKHN0cnVjdCBmaWxlICpmaWxl
X2luLCBsb2ZmX3QgcG9zX2luLA0KPj4gICAJCQkJICBzdHJ1Y3QgZmlsZSAqZmlsZV9vdXQsIGxv
ZmZfdCBwb3Nfb3V0LA0KPj4gLQkJCQkgIGxvZmZfdCAqbGVuLCB1bnNpZ25lZCBpbnQgcmVtYXBf
ZmxhZ3MpDQo+PiArCQkJCSAgbG9mZl90ICpsZW4sIHVuc2lnbmVkIGludCByZW1hcF9mbGFncywN
Cj4+ICsJCQkJICBjb21wYXJlX3JhbmdlX3QgY29tcGFyZV9yYW5nZV9mbikNCj4gDQo+IENhbiB3
ZSBrZWVwIGdlbmVyaWNfcmVtYXBfZmlsZV9yYW5nZV9wcmVwIGFzLWlzLCBhbmQgYWRkIGEgbmV3
DQo+IGRheF9yZW1hcF9maWxlX3JhbmdlX3ByZXAsIGJvdGggc2hhcmluZyBhIGxvdy1sZXZlbA0K
PiBfX2dlbmVyaWNfcmVtYXBfZmlsZV9yYW5nZV9wcmVwIGltcGxlbWVudGF0aW9uPyAgQW5kIGZv
ciB0aGF0DQo+IGltcGxlbWVudGF0aW9uIEknZCBhbHNvIGdvIGZvciBjbGFzc2ljIGlmL2Vsc2Ug
aW5zdGVhZCBvZiB0aGUgZnVuY3Rpb24NCj4gcG9pbnRlci4NCg0KVGhlIGRheCBkZWR1cGUgY29t
cGFyaXNvbiBuZWVkIHRoZSBpb21hcF9vcHMgcG9pbnRlciBhcyBhcmd1bWVudCwgc28gbXkgDQp1
bmRlcnN0YW5kaW5nIGlzIHRoYXQgd2UgZG9uJ3QgbW9kaWZ5IHRoZSBhcmd1bWVudCBsaXN0IG9m
IA0KZ2VuZXJpY19yZW1hcF9maWxlX3JhbmdlX3ByZXAoKSwgYnV0IG1vdmUgaXRzIGNvZGUgaW50
byANCl9fZ2VuZXJpY19yZW1hcF9maWxlX3JhbmdlX3ByZXAoKSB3aG9zZSBhcmd1bWVudCBsaXN0
IGNhbiBiZSBtb2RpZmllZCB0byANCmFjY2VwdHMgdGhlIGlvbWFwX29wcyBwb2ludGVyLiAgVGhl
biBpdCBsb29rcyBsaWtlIHRoaXM6DQoNCmBgYA0KaW50IGRheF9yZW1hcF9maWxlX3JhbmdlX3By
ZXAoc3RydWN0IGZpbGUgKmZpbGVfaW4sIGxvZmZfdCBwb3NfaW4sDQoJCQkJICBzdHJ1Y3QgZmls
ZSAqZmlsZV9vdXQsIGxvZmZfdCBwb3Nfb3V0LA0KCQkJCSAgbG9mZl90ICpsZW4sIHVuc2lnbmVk
IGludCByZW1hcF9mbGFncywNCgkJCQkgIGNvbnN0IHN0cnVjdCBpb21hcF9vcHMgKm9wcykNCnsN
CglyZXR1cm4gX19nZW5lcmljX3JlbWFwX2ZpbGVfcmFuZ2VfcHJlcChmaWxlX2luLCBwb3NfaW4s
IGZpbGVfb3V0LA0KCQkJcG9zX291dCwgbGVuLCByZW1hcF9mbGFncywgb3BzKTsNCn0NCkVYUE9S
VF9TWU1CT0woZGF4X3JlbWFwX2ZpbGVfcmFuZ2VfcHJlcCk7DQoNCmludCBnZW5lcmljX3JlbWFw
X2ZpbGVfcmFuZ2VfcHJlcChzdHJ1Y3QgZmlsZSAqZmlsZV9pbiwgbG9mZl90IHBvc19pbiwNCgkJ
CQkgIHN0cnVjdCBmaWxlICpmaWxlX291dCwgbG9mZl90IHBvc19vdXQsDQoJCQkJICBsb2ZmX3Qg
KmxlbiwgdW5zaWduZWQgaW50IHJlbWFwX2ZsYWdzKQ0Kew0KCXJldHVybiBfX2dlbmVyaWNfcmVt
YXBfZmlsZV9yYW5nZV9wcmVwKGZpbGVfaW4sIHBvc19pbiwgZmlsZV9vdXQsDQoJCQlwb3Nfb3V0
LCBsZW4sIHJlbWFwX2ZsYWdzLCBOVUxMKTsNCn0NCkVYUE9SVF9TWU1CT0woZ2VuZXJpY19yZW1h
cF9maWxlX3JhbmdlX3ByZXApOw0KYGBgDQoNCkFtIGkgcmlnaHQ/DQoNCg0KLS0NClRoYW5rcywN
ClJ1YW4gU2hpeWFuZy4NCg0KPiANCj4+ICtleHRlcm4gaW50IHZmc19kZWR1cGVfZmlsZV9yYW5n
ZV9jb21wYXJlKHN0cnVjdCBpbm9kZSAqc3JjLCBsb2ZmX3Qgc3Jjb2ZmLA0KPj4gKwkJCQkJIHN0
cnVjdCBpbm9kZSAqZGVzdCwgbG9mZl90IGRlc3RvZmYsDQo+PiArCQkJCQkgbG9mZl90IGxlbiwg
Ym9vbCAqaXNfc2FtZSk7DQo+IA0KPiBubyBuZWVkIGZvciB0aGUgZXh0ZXJuLg0KPiANCj4gDQoN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNj
cmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
