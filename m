Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 445C92DDCAE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 02:50:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 60432100EB852;
	Thu, 17 Dec 2020 17:50:33 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 56B34100EB832
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 17:50:30 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.78,428,1599494400";
   d="scan'208";a="102687225"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2020 09:50:28 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id D0B364CE6014;
	Fri, 18 Dec 2020 09:50:25 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Dec
 2020 09:50:25 +0800
Subject: Re: [RFC PATCH v3 4/9] mm, fsdax: Refactor memory-failure handler for
 dax mapping
To: Dave Chinner <david@fromorbit.com>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <20201215121414.253660-5-ruansy.fnst@cn.fujitsu.com>
 <20201216212648.GN632069@dread.disaster.area>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <513e7602-80d7-8d8c-ed5d-06b8113823bf@cn.fujitsu.com>
Date: Fri, 18 Dec 2020 09:48:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201216212648.GN632069@dread.disaster.area>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: D0B364CE6014.AB9CB
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: FKZNJUJLLMNCM56ARQ3INWHEMKMBKL2M
X-Message-ID-Hash: FKZNJUJLLMNCM56ARQ3INWHEMKMBKL2M
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FKZNJUJLLMNCM56ARQ3INWHEMKMBKL2M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjAvMTIvMTcg5LiK5Y2INToyNiwgRGF2ZSBDaGlubmVyIHdyb3RlOg0KPiBPbiBU
dWUsIERlYyAxNSwgMjAyMCBhdCAwODoxNDowOVBNICswODAwLCBTaGl5YW5nIFJ1YW4gd3JvdGU6
DQo+PiBUaGUgY3VycmVudCBtZW1vcnlfZmFpbHVyZV9kZXZfcGFnZW1hcCgpIGNhbiBvbmx5IGhh
bmRsZSBzaW5nbGUtbWFwcGVkDQo+PiBkYXggcGFnZSBmb3IgZnNkYXggbW9kZS4gIFRoZSBkYXgg
cGFnZSBjb3VsZCBiZSBtYXBwZWQgYnkgbXVsdGlwbGUgZmlsZXMNCj4+IGFuZCBvZmZzZXRzIGlm
IHdlIGxldCByZWZsaW5rIGZlYXR1cmUgJiBmc2RheCBtb2RlIHdvcmsgdG9nZXRoZXIuICBTbywN
Cj4+IHdlIHJlZmFjdG9yIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gdG8gc3VwcG9ydCBoYW5kbGUg
bWVtb3J5IGZhaWx1cmUgb24NCj4+IGVhY2ggZmlsZSBhbmQgb2Zmc2V0Lg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFNoaXlhbmcgUnVhbiA8cnVhbnN5LmZuc3RAY24uZnVqaXRzdS5jb20+DQo+PiAt
LS0NCj4gLi4uLi4NCj4+ICAgc3RhdGljIGNvbnN0IGNoYXIgKmFjdGlvbl9uYW1lW10gPSB7DQo+
PiBAQCAtMTE0Nyw2ICsxMTQ4LDYwIEBAIHN0YXRpYyBpbnQgdHJ5X3RvX3NwbGl0X3RocF9wYWdl
KHN0cnVjdCBwYWdlICpwYWdlLCBjb25zdCBjaGFyICptc2cpDQo+PiAgIAlyZXR1cm4gMDsNCj4+
ICAgfQ0KPj4gICANCj4+ICtpbnQgbWZfZGF4X21hcHBpbmdfa2lsbF9wcm9jcyhzdHJ1Y3QgYWRk
cmVzc19zcGFjZSAqbWFwcGluZywgcGdvZmZfdCBpbmRleCwgaW50IGZsYWdzKQ0KPj4gK3sNCj4+
ICsJY29uc3QgYm9vbCB1bm1hcF9zdWNjZXNzID0gdHJ1ZTsNCj4+ICsJdW5zaWduZWQgbG9uZyBw
Zm4sIHNpemUgPSAwOw0KPj4gKwlzdHJ1Y3QgdG9fa2lsbCAqdGs7DQo+PiArCUxJU1RfSEVBRCh0
b19raWxsKTsNCj4+ICsJaW50IHJjID0gLUVCVVNZOw0KPj4gKwlsb2ZmX3Qgc3RhcnQ7DQo+PiAr
CWRheF9lbnRyeV90IGNvb2tpZTsNCj4+ICsNCj4+ICsJLyoNCj4+ICsJICogUHJldmVudCB0aGUg
aW5vZGUgZnJvbSBiZWluZyBmcmVlZCB3aGlsZSB3ZSBhcmUgaW50ZXJyb2dhdGluZw0KPj4gKwkg
KiB0aGUgYWRkcmVzc19zcGFjZSwgdHlwaWNhbGx5IHRoaXMgd291bGQgYmUgaGFuZGxlZCBieQ0K
Pj4gKwkgKiBsb2NrX3BhZ2UoKSwgYnV0IGRheCBwYWdlcyBkbyBub3QgdXNlIHRoZSBwYWdlIGxv
Y2suIFRoaXMNCj4+ICsJICogYWxzbyBwcmV2ZW50cyBjaGFuZ2VzIHRvIHRoZSBtYXBwaW5nIG9m
IHRoaXMgcGZuIHVudGlsDQo+PiArCSAqIHBvaXNvbiBzaWduYWxpbmcgaXMgY29tcGxldGUuDQo+
PiArCSAqLw0KPj4gKwljb29raWUgPSBkYXhfbG9jayhtYXBwaW5nLCBpbmRleCwgJnBmbik7DQo+
PiArCWlmICghY29va2llKQ0KPj4gKwkJZ290byB1bmxvY2s7DQo+IA0KPiBXaHkgZG8gd2UgbmVl
ZCB0byBwcmV2ZW50IHRoZSBpbm9kZSBmcm9tIGdvaW5nIGF3YXkgaGVyZT8gVGhpcw0KPiBmdW5j
dGlvbiBnZXRzIGNhbGxlZCBieSBYRlMgYWZ0ZXIgZG9pbmcgYW4geGZzX2lnZXQoKSBjYWxsIHRv
IGdyYWINCj4gdGhlIGlub2RlIHRoYXQgb3ducyB0aGUgYmxvY2suIEhlbmNlIHRoZSB0aGUgaW5v
ZGUgKGFuZCB0aGUgbWFwcGluZykNCj4gYXJlIGd1YXJhbnRlZWQgdG8gYmUgcmVmZXJlbmNlZCBh
bmQgY2FuJ3QgZ28gYXdheS4gSGVuY2UgZm9yIHRoZQ0KPiBmaWxlc3lzdGVtIGJhc2VkIGNhbGxl
cnMsIHRoaXMgd2hvbGUgImRheF9sb2NrKCkiIHRoaW5nIGNhbiBnbyBhd2F5ID4NCj4gU28sIEFG
QUlDVCwgdGhlIGRheF9sb2NrKCkgc3R1ZmYgaXMgb25seSBuZWNlc3Nhcnkgd2hlbiB0aGUNCj4g
ZmlsZXN5c3RlbSBjYW4ndCBiZSB1c2VkIHRvIHJlc29sdmUgdGhlIG93bmVyIG9mIHBoeXNpY2Fs
IHBhZ2UgdGhhdA0KPiB3ZW50IGJhZC4uLi4NCg0KWWVzLCB5b3UgYXJlIHJpZ2h0LiAgSSBtYWRl
IGEgbWlzdGFrZSBpbiB0aGUgY2FsbGluZyBzZXF1ZW5jZSBoZXJlLiANClRoYW5rcyBmb3IgcG9p
bnRpbmcgb3V0Lg0KDQoNCi0tDQpUaGFua3MsDQpSdWFuIFNoaXlhbmcuDQoNCj4gDQo+IENoZWVy
cywNCj4gDQo+IERhdmUuDQo+IA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBs
aXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0t
bGVhdmVAbGlzdHMuMDEub3JnCg==
