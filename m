Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4D31BB9E3
	for <lists+linux-nvdimm@lfdr.de>; Tue, 28 Apr 2020 11:32:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DF1EC10083EB1;
	Tue, 28 Apr 2020 02:31:58 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 21D9610083EAF
	for <linux-nvdimm@lists.01.org>; Tue, 28 Apr 2020 02:31:56 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.73,326,1583164800";
   d="scan'208";a="90638122"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Apr 2020 17:32:51 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 3DFFC50A9991;
	Tue, 28 Apr 2020 17:32:49 +0800 (CST)
Received: from [10.167.225.141] (10.167.225.141) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 28 Apr 2020 17:32:46 +0800
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUmU6IFtSRkMgUEFUQ0ggMC84XSBkYXg6IEFkZCBh?=
 =?UTF-8?Q?_dax-rmap_tree_to_support_reflink?=
To: Dave Chinner <david@fromorbit.com>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
 <20200428064318.GG2040@dread.disaster.area>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <259fe633-e1ff-b279-cd8c-1a81eaa40941@cn.fujitsu.com>
Date: Tue, 28 Apr 2020 17:32:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428064318.GG2040@dread.disaster.area>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 3DFFC50A9991.AE2A1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: 5GMOIQNMFIU7V7K6RWYJ3CAPVJNVH7GC
X-Message-ID-Hash: 5GMOIQNMFIU7V7K6RWYJ3CAPVJNVH7GC
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Matthew Wilcox <willy@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "Qi, Fuli" <qi.fuli@fujitsu.com>, "Gotou, Yasunori" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5GMOIQNMFIU7V7K6RWYJ3CAPVJNVH7GC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjAvNC8yOCDkuIvljYgyOjQzLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+IE9uIFR1
ZSwgQXByIDI4LCAyMDIwIGF0IDA2OjA5OjQ3QU0gKzAwMDAsIFJ1YW4sIFNoaXlhbmcgd3JvdGU6
DQo+Pg0KPj4g5ZyoIDIwMjAvNC8yNyAyMDoyODozNiwgIk1hdHRoZXcgV2lsY294IiA8d2lsbHlA
aW5mcmFkZWFkLm9yZz4g5YaZ6YGTOg0KPj4NCj4+PiBPbiBNb24sIEFwciAyNywgMjAyMCBhdCAw
NDo0Nzo0MlBNICswODAwLCBTaGl5YW5nIFJ1YW4gd3JvdGU6DQo+Pj4+ICAgVGhpcyBwYXRjaHNl
dCBpcyBhIHRyeSB0byByZXNvbHZlIHRoZSBzaGFyZWQgJ3BhZ2UgY2FjaGUnIHByb2JsZW0gZm9y
DQo+Pj4+ICAgZnNkYXguDQo+Pj4+DQo+Pj4+ICAgSW4gb3JkZXIgdG8gdHJhY2sgbXVsdGlwbGUg
bWFwcGluZ3MgYW5kIGluZGV4ZXMgb24gb25lIHBhZ2UsIEkNCj4+Pj4gICBpbnRyb2R1Y2VkIGEg
ZGF4LXJtYXAgcmItdHJlZSB0byBtYW5hZ2UgdGhlIHJlbGF0aW9uc2hpcC4gIEEgZGF4IGVudHJ5
DQo+Pj4+ICAgd2lsbCBiZSBhc3NvY2lhdGVkIG1vcmUgdGhhbiBvbmNlIGlmIGlzIHNoYXJlZC4g
IEF0IHRoZSBzZWNvbmQgdGltZSB3ZQ0KPj4+PiAgIGFzc29jaWF0ZSB0aGlzIGVudHJ5LCB3ZSBj
cmVhdGUgdGhpcyByYi10cmVlIGFuZCBzdG9yZSBpdHMgcm9vdCBpbg0KPj4+PiAgIHBhZ2UtPnBy
aXZhdGUobm90IHVzZWQgaW4gZnNkYXgpLiAgSW5zZXJ0ICgtPm1hcHBpbmcsIC0+aW5kZXgpIHdo
ZW4NCj4+Pj4gICBkYXhfYXNzb2NpYXRlX2VudHJ5KCkgYW5kIGRlbGV0ZSBpdCB3aGVuIGRheF9k
aXNhc3NvY2lhdGVfZW50cnkoKS4NCj4+Pg0KPj4+IERvIHdlIHJlYWxseSB3YW50IHRvIHRyYWNr
IGFsbCBvZiB0aGlzIG9uIGEgcGVyLXBhZ2UgYmFzaXM/ICBJIHdvdWxkDQo+Pj4gaGF2ZSB0aG91
Z2h0IGEgcGVyLWV4dGVudCBiYXNpcyB3YXMgbW9yZSB1c2VmdWwuICBFc3NlbnRpYWxseSwgY3Jl
YXRlDQo+Pj4gYSBuZXcgYWRkcmVzc19zcGFjZSBmb3IgZWFjaCBzaGFyZWQgZXh0ZW50LiAgUGVy
IHBhZ2UganVzdCBzZWVtcyBsaWtlDQo+Pj4gYSBodWdlIG92ZXJoZWFkLg0KPj4+DQo+PiBQZXIt
ZXh0ZW50IHRyYWNraW5nIGlzIGEgbmljZSBpZGVhIGZvciBtZS4gIEkgaGF2ZW4ndCB0aG91Z2h0
IG9mIGl0DQo+PiB5ZXQuLi4NCj4+DQo+PiBCdXQgdGhlIGV4dGVudCBpbmZvIGlzIG1haW50YWlu
ZWQgYnkgZmlsZXN5c3RlbS4gIEkgdGhpbmsgd2UgbmVlZCBhIHdheQ0KPj4gdG8gb2J0YWluIHRo
aXMgaW5mbyBmcm9tIEZTIHdoZW4gYXNzb2NpYXRpbmcgYSBwYWdlLiAgTWF5IGJlIGEgYml0DQo+
PiBjb21wbGljYXRlZC4gIExldCBtZSB0aGluayBhYm91dCBpdC4uLg0KPiANCj4gVGhhdCdzIHdo
eSBJIHdhbnQgdGhlIC11c2VyIG9mIHRoaXMgYXNzb2NpYXRpb24tIHRvIGRvIGEgZmlsZXN5c3Rl
bQ0KPiBjYWxsb3V0IGluc3RlYWQgb2Yga2VlcGluZyBpdCdzIG93biBuYWl2ZSB0cmFja2luZyBp
bmZyYXN0cnVjdHVyZS4NCj4gVGhlIGZpbGVzeXN0ZW0gY2FuIGRvIGFuIGVmZmljaWVudCwgb24t
ZGVtYW5kIHJldmVyc2UgbWFwcGluZyBsb29rdXANCj4gZnJvbSBpdCdzIG93biBleHRlbnQgdHJh
Y2tpbmcgaW5mcmFzdHJ1Y3R1cmUsIGFuZCB0aGVyZSdzIHplcm8NCj4gcnVudGltZSBvdmVyaGVh
ZCB3aGVuIHRoZXJlIGFyZSBubyBlcnJvcnMgcHJlc2VudC4NCj4gDQo+IEF0IHRoZSBtb21lbnQs
IHRoaXMgImRheCBhc3NvY2lhdGlvbiIgaXMgdXNlZCB0byAicmVwb3J0IiBhIHN0b3JhZ2UNCj4g
bWVkaWEgZXJyb3IgZGlyZWN0bHkgdG8gdXNlcnNwYWNlLiBJIHNheSAicmVwb3J0IiBiZWNhdXNl
IHdoYXQgaXQNCj4gZG9lcyBpcyBraWxsIHVzZXJzcGFjZSBwcm9jZXNzZXMgZGVhZC4gVGhlIHN0
b3JhZ2UgbWVkaWEgZXJyb3INCj4gYWN0dWFsbHkgbmVlZHMgdG8gYmUgcmVwb3J0ZWQgdG8gdGhl
IG93bmVyIG9mIHRoZSBzdG9yYWdlIG1lZGlhLA0KPiB3aGljaCBpbiB0aGUgY2FzZSBvZiBGUy1E
QVggaXMgdGhlIGZpbGVzeXRlbS4NCg0KVW5kZXJzdG9vZC4NCg0KQlRXLCB0aGlzIGlzIHRoZSB1
c2FnZSBpbiBtZW1vcnktZmFpbHVyZSwgc28gd2hhdCBhYm91dCBybWFwPyAgSSBoYXZlIA0Kbm90
IGZvdW5kIGhvdyB0byB1c2UgdGhpcyB0cmFja2luZyBpbiBybWFwLiAgRG8geW91IGhhdmUgYW55
IGlkZWFzPw0KDQo+IA0KPiBUaGF0IHdheSB0aGUgZmlsZXN5c3RlbSBjYW4gdGhlbiBsb29rIHVw
IGFsbCB0aGUgb3duZXJzIG9mIHRoYXQgYmFkDQo+IG1lZGlhIHJhbmdlIChpLmUuIHRoZSBmaWxl
c3lzdGVtIGJsb2NrIGl0IGNvcnJlc3BvbmRzIHRvKSBhbmQgdGFrZQ0KPiBhcHByb3ByaWF0ZSBh
Y3Rpb24uIGUuZy4NCg0KSSB0cmllZCB3cml0aW5nIGEgZnVuY3Rpb24gdG8gbG9vayB1cCBhbGwg
dGhlIG93bmVycycgaW5mbyBvZiBvbmUgYmxvY2sgDQppbiB4ZnMgZm9yIG1lbW9yeS1mYWlsdXJl
IHVzZS4gIEl0IHdhcyBkcm9wcGVkIGluIHRoaXMgcGF0Y2hzZXQgYmVjYXVzZSANCkkgZm91bmQg
b3V0IHRoYXQgdGhpcyBsb29rdXAgZnVuY3Rpb24gbmVlZHMgJ3JtYXBidCcgdG8gYmUgZW5hYmxl
ZCB3aGVuIA0KbWtmcy4gIEJ1dCBieSBkZWZhdWx0LCBybWFwYnQgaXMgZGlzYWJsZWQuICBJIGFt
IG5vdCBzdXJlIGlmIGl0IG1hdHRlcnMuLi4NCg0KPiANCj4gLSBpZiBpdCBmYWxscyBpbiBmaWxl
c3l0ZW0gbWV0YWRhdGEsIHNodXRkb3duIHRoZSBmaWxlc3lzdGVtDQo+IC0gaWYgaXQgZmFsbHMg
aW4gdXNlciBkYXRhLCBjYWxsIHRoZSAia2lsbCB1c2Vyc3BhY2UgZGVhZCIgcm91dGluZXMNCj4g
ICAgZm9yIGVhY2ggbWFwcGluZy9pbmRleCB0dXBsZSB0aGUgZmlsZXN5c3RlbSBmaW5kcyBmb3Ig
dGhlIGdpdmVuDQo+ICAgIExCQSBhZGRyZXNzIHRoYXQgdGhlIG1lZGlhIGVycm9yIG9jY3VycmVk
ID4NCj4gUmlnaHQgbm93IGlmIHRoZSBtZWRpYSBlcnJvciBpcyBpbiBmaWxlc3lzdGVtIG1ldGFk
YXRhLCB0aGUNCj4gZmlsZXN5c3RlbSBpc24ndCBldmVuIHRvbGQgYWJvdXQgaXQuIFRoZSBmaWxl
c3lzdGVtIGNhbid0IGV2ZW4gc2h1dA0KPiBkb3duIC0gdGhlIGVycm9yIGlzIGp1c3QgZHJvcHBl
ZCBvbiB0aGUgZmxvb3IgYW5kIGl0IHdvbid0IGJlIHVudGlsDQo+IHRoZSBmaWxlc3lzdGVtIG5l
eHQgdHJpZXMgdG8gcmVmZXJlbmNlIHRoYXQgbWV0YWRhdGEgdGhhdCB3ZSBub3RpY2UNCj4gdGhl
cmUgaXMgYW4gaXNzdWUuDQoNClVuZGVyc3Rvb2QuICBUaGFua3MuDQoNCj4gDQo+IENoZWVycywN
Cj4gDQo+IERhdmUuDQo+IA0KDQoNCi0tDQpUaGFua3MsDQpSdWFuIFNoaXlhbmcuDQoNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBt
YWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBz
ZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
