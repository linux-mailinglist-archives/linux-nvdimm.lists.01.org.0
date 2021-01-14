Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CAA2F5993
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 Jan 2021 04:52:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7AD5F100F2265;
	Wed, 13 Jan 2021 19:52:23 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 7015E100F2264
	for <linux-nvdimm@lists.01.org>; Wed, 13 Jan 2021 19:52:20 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.79,346,1602518400";
   d="scan'208";a="103466040"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Jan 2021 11:52:18 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 929244CE602D;
	Thu, 14 Jan 2021 11:52:16 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Jan
 2021 11:52:17 +0800
Subject: Re: [PATCH 04/10] mm, fsdax: Refactor memory-failure handler for dax
 mapping
To: zhong jiang <zhongjiang-ali@linux.alibaba.com>, Jan Kara <jack@suse.cz>
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
 <20201230165601.845024-5-ruansy.fnst@cn.fujitsu.com>
 <20210106154132.GC29271@quack2.suse.cz>
 <75164044-bfdf-b2d6-dff0-d6a8d56d1f62@cn.fujitsu.com>
 <781f276b-afdd-091c-3dba-048e415431ab@linux.alibaba.com>
 <ef29ba5c-96d7-d0bb-e405-c7472a518b32@cn.fujitsu.com>
 <e2f7ad16-8162-4933-9091-72e690e9877e@linux.alibaba.com>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <4f184987-3cc2-c72d-0774-5d20ea2e1d49@cn.fujitsu.com>
Date: Thu, 14 Jan 2021 11:52:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <e2f7ad16-8162-4933-9091-72e690e9877e@linux.alibaba.com>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 929244CE602D.ADB7E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: AIMS4LAFEPLTWVIHZXR7R4SDHVRMUF7Z
X-Message-ID-Hash: AIMS4LAFEPLTWVIHZXR7R4SDHVRMUF7Z
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AIMS4LAFEPLTWVIHZXR7R4SDHVRMUF7Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjEvMS8xNCDkuIrljYgxMToyNiwgemhvbmcgamlhbmcgd3JvdGU6DQo+IA0KPiBP
biAyMDIxLzEvMTQgOTo0NCDkuIrljYgsIFJ1YW4gU2hpeWFuZyB3cm90ZToNCj4+DQo+Pg0KPj4g
T24gMjAyMS8xLzEzIOS4i+WNiDY6MDQsIHpob25nIGppYW5nIHdyb3RlOg0KPj4+DQo+Pj4gT24g
MjAyMS8xLzEyIDEwOjU1IOS4iuWNiCwgUnVhbiBTaGl5YW5nIHdyb3RlOg0KPj4+Pg0KPj4+Pg0K
Pj4+PiBPbiAyMDIxLzEvNiDkuIvljYgxMTo0MSwgSmFuIEthcmEgd3JvdGU6DQo+Pj4+PiBPbiBU
aHUgMzEtMTItMjAgMDA6NTU6NTUsIFNoaXlhbmcgUnVhbiB3cm90ZToNCj4+Pj4+PiBUaGUgY3Vy
cmVudCBtZW1vcnlfZmFpbHVyZV9kZXZfcGFnZW1hcCgpIGNhbiBvbmx5IGhhbmRsZSANCj4+Pj4+
PiBzaW5nbGUtbWFwcGVkDQo+Pj4+Pj4gZGF4IHBhZ2UgZm9yIGZzZGF4IG1vZGUuwqAgVGhlIGRh
eCBwYWdlIGNvdWxkIGJlIG1hcHBlZCBieSBtdWx0aXBsZSANCj4+Pj4+PiBmaWxlcw0KPj4+Pj4+
IGFuZCBvZmZzZXRzIGlmIHdlIGxldCByZWZsaW5rIGZlYXR1cmUgJiBmc2RheCBtb2RlIHdvcmsg
dG9nZXRoZXIuIFNvLA0KPj4+Pj4+IHdlIHJlZmFjdG9yIGN1cnJlbnQgaW1wbGVtZW50YXRpb24g
dG8gc3VwcG9ydCBoYW5kbGUgbWVtb3J5IA0KPj4+Pj4+IGZhaWx1cmUgb24NCj4+Pj4+PiBlYWNo
IGZpbGUgYW5kIG9mZnNldC4NCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFNoaXlhbmcg
UnVhbiA8cnVhbnN5LmZuc3RAY24uZnVqaXRzdS5jb20+DQo+Pj4+Pg0KPj4+Pj4gT3ZlcmFsbCB0
aGlzIGxvb2tzIE9LIHRvIG1lLCBhIGZldyBjb21tZW50cyBiZWxvdy4NCj4+Pj4+DQo+Pj4+Pj4g
LS0tDQo+Pj4+Pj4gwqAgZnMvZGF4LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjEgKysrKysr
KysrKysNCj4+Pj4+PiDCoCBpbmNsdWRlL2xpbnV4L2RheC5oIHzCoCAxICsNCj4+Pj4+PiDCoCBp
bmNsdWRlL2xpbnV4L21tLmjCoCB8wqAgOSArKysrKw0KPj4+Pj4+IMKgIG1tL21lbW9yeS1mYWls
dXJlLmMgfCA5MSANCj4+Pj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0NCj4+Pj4+PiDCoCA0IGZpbGVzIGNoYW5nZWQsIDEwMCBpbnNlcnRpb25zKCspLCAy
MiBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gLi4uDQo+Pj4+DQo+Pj4+Pj4gwqAgQEAgLTM0NSw5
ICszNDgsMTIgQEAgc3RhdGljIHZvaWQgYWRkX3RvX2tpbGwoc3RydWN0IHRhc2tfc3RydWN0IA0K
Pj4+Pj4+ICp0c2ssIHN0cnVjdCBwYWdlICpwLA0KPj4+Pj4+IMKgwqDCoMKgwqAgfQ0KPj4+Pj4+
IMKgIMKgwqDCoMKgwqAgdGstPmFkZHIgPSBwYWdlX2FkZHJlc3NfaW5fdm1hKHAsIHZtYSk7DQo+
Pj4+Pj4gLcKgwqDCoCBpZiAoaXNfem9uZV9kZXZpY2VfcGFnZShwKSkNCj4+Pj4+PiAtwqDCoMKg
wqDCoMKgwqAgdGstPnNpemVfc2hpZnQgPSBkZXZfcGFnZW1hcF9tYXBwaW5nX3NoaWZ0KHAsIHZt
YSk7DQo+Pj4+Pj4gLcKgwqDCoCBlbHNlDQo+Pj4+Pj4gK8KgwqDCoCBpZiAoaXNfem9uZV9kZXZp
Y2VfcGFnZShwKSkgew0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoaXNfZGV2aWNlX2ZzZGF4
X3BhZ2UocCkpDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGstPmFkZHIgPSB2bWEt
PnZtX3N0YXJ0ICsNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKChwZ29mZiAtIHZtYS0+dm1fcGdvZmYpIDw8IFBBR0VfU0hJRlQpOw0KPj4+Pj4NCj4+Pj4+
IEl0IHNlZW1zIHN0cmFuZ2UgdG8gdXNlICdwZ29mZicgZm9yIGRheCBwYWdlcyBhbmQgbm90IGZv
ciBhbnkgb3RoZXIgDQo+Pj4+PiBwYWdlLg0KPj4+Pj4gV2h5PyBJJ2QgcmF0aGVyIHBhc3MgY29y
cmVjdCBwZ29mZiBmcm9tIGFsbCBjYWxsZXJzIG9mIA0KPj4+Pj4gYWRkX3RvX2tpbGwoKSBhbmQN
Cj4+Pj4+IGF2b2lkIHRoaXMgc3BlY2lhbCBjYXNpbmcuLi4NCj4+Pj4NCj4+Pj4gQmVjYXVzZSBv
bmUgZnNkYXggcGFnZSBjYW4gYmUgc2hhcmVkIGJ5IG11bHRpcGxlIHBnb2Zmcy7CoCBJIGhhdmUg
dG8gDQo+Pj4+IHBhc3MgZWFjaCBwZ29mZiBpbiBlYWNoIGl0ZXJhdGlvbiB0byBjYWxjdWxhdGUg
dGhlIGFkZHJlc3MgaW4gdm1hIA0KPj4+PiAoZm9yIHRrLT5hZGRyKS7CoCBPdGhlciBraW5kcyBv
ZiBwYWdlcyBkb24ndCBuZWVkIHRoaXMuIFRoZXkgY2FuIGdldCANCj4+Pj4gdGhlaXIgdW5pcXVl
IGFkZHJlc3MgYnkgY2FsbGluZyAicGFnZV9hZGRyZXNzX2luX3ZtYSgpIi4NCj4+Pj4NCj4+PiBJ
TU8swqDCoCBhbiBmc2RheCBwYWdlIGNhbiBiZSBzaGFyZWQgYnkgbXVsdGlwbGUgZmlsZXMgcmF0
aGVyIHRoYW4gDQo+Pj4gbXVsdGlwbGUgcGdvZmZzIGlmIGZzIHF1ZXJ5IHN1cHBvcnQgcmVmbGlu
ay7CoMKgIEJlY2F1c2UgYW4gcGFnZSBvbmx5IA0KPj4+IGxvY2F0ZWQgaW4gYW4gbWFwcGluZyhw
YWdlLT5tYXBwaW5nIGlzIGV4Y2x1c2l2ZSksIGhlbmNlIGl0wqAgb25seSBoYXMgDQo+Pj4gYW4g
cGdvZmYgb3IgaW5kZXggcG9pbnRpbmcgYXQgdGhlIG5vZGUuDQo+Pj4NCj4+PiDCoMKgb3LCoCBJ
IG1pc3Mgc29tZXRoaW5nIGZvciB0aGUgZmVhdHVyZSA/wqAgdGhhbmtzLA0KPj4NCj4+IFllcywg
YSBmc2RheCBwYWdlIGlzIHNoYXJlZCBieSBtdWx0aXBsZSBmaWxlcyBiZWNhdXNlIG9mIHJlZmxp
bmsuIEkgDQo+PiB0aGluayBteSBkZXNjcmlwdGlvbiBvZiAncGdvZmYnIGhlcmUgaXMgbm90IGNv
cnJlY3QuwqAgVGhpcyAncGdvZmYnIA0KPj4gbWVhbnMgdGhlIG9mZnNldCB3aXRoaW4gdGhlIGEg
ZmlsZS7CoCAoV2UgdXNlIHJtYXAgdG8gZmluZCBvdXQgYWxsIHRoZSANCj4+IHNoYXJpbmcgZmls
ZXMgYW5kIHRoZWlyIG9mZnNldHMuKcKgIFNvLCBJIHNhaWQgdGhhdCAiY2FuIGJlIHNoYXJlZCBi
eSANCj4+IG11bHRpcGxlIHBnb2ZmcyIuwqAgSXQncyBteSBiYWQuDQo+Pg0KPj4gSSB0aGluayBJ
IHNob3VsZCBuYW1lIGl0IGFub3RoZXIgd29yZCB0byBhdm9pZCBtaXN1bmRlcnN0YW5kaW5ncy4N
Cj4+DQo+IElNTyzCoCBBbGwgdGhlIHNoYXJpbmcgZmlsZXMgc2hvdWxkIGJlIHRoZSBzYW1lIG9m
ZnNldCB0byBzaGFyZSB0aGUgZnNkYXggDQo+IHBhZ2UuwqAgd2h5IG5vdCB0aGF0ID8gDQoNClRo
ZSBkZWR1cGUgb3BlcmF0aW9uIGNhbiBsZXQgZGlmZmVyZW50IGZpbGVzIHNoYXJlIHRoZWlyIHNh
bWUgZGF0YSANCmV4dGVudCwgdGhvdWdoIG9mZnNldHMgYXJlIG5vdCBzYW1lLiAgU28sIGZpbGVz
IGNhbiBzaGFyZSBvbmUgZnNkYXggcGFnZSANCmF0IGRpZmZlcmVudCBvZmZzZXQuDQoNCj4gQXMg
eW91IGhhcyBzYWlkLMKgIGEgc2hhcmVkIGZhZGF4IHBhZ2Ugc2hvdWxkIGJlIA0KPiBpbnNlcnRl
ZCB0byBkaWZmZXJlbnQgbWFwcGluZyBmaWxlcy7CoCBidXQgcGFnZS0+aW5kZXggYW5kIHBhZ2Ut
Pm1hcHBpbmcgDQo+IGlzIGV4Y2x1c2l2ZS7CoCBoZW5jZSBhbiBwYWdlIG9ubHkgc2hvdWxkIGJl
IHBsYWNlZCBpbiBhbiBtYXBwaW5nIHRyZWUuDQoNCldlIGNhbid0IHVzZSBwYWdlLT5tYXBwaW5n
IGFuZCBwYWdlLT5pbmRleCBoZXJlIGZvciByZWZsaW5rICYgZnNkYXguIA0KQW5kIHRoYXQncyB0
aGlzIHBhdGNoc2V0IGFpbXMgdG8gc29sdmUuICBJIGludHJvZHVjZWQgYSBzZXJpZXMgb2YgDQot
PmNvcnJ1cHRlZF9yYW5nZSgpLCBmcm9tIG1tIHRvIHBtZW0gZHJpdmVyIHRvIGJsb2NrIGRldmlj
ZSBhbmQgZmluYWxseSANCnRvIGZpbGVzeXN0ZW0sIHRvIHVzZSBybWFwIGZlYXR1cmUgb2YgZmls
ZXN5c3RlbSB0byBmaW5kIG91dCBhbGwgZmlsZXMgDQpzaGFyaW5nIHNhbWUgZGF0YSBleHRlbnQg
KGZzZGF4IHBhZ2UpLg0KDQoNCi0tDQpUaGFua3MsDQpSdWFuIFNoaXlhbmcuDQoNCj4gDQo+IEFu
ZCBJbiB0aGUgY3VycmVudCBwYXRjaCzCoCB3ZSBmYWlsZWQgdG8gZm91bmQgb3V0IHRoYXQgYWxs
IHByb2Nlc3MgdXNlIA0KPiB0aGUgZnNkYXggcGFnZSBzaGFyZWQgYnkgbXVsdGlwbGUgZmlsZXMg
YW5kIGtpbGwgdGhlbS4NCj4gDQo+IA0KPiBUaGFua3MsDQo+IA0KPj4gLS0gDQo+PiBUaGFua3Ms
DQo+PiBSdWFuIFNoaXlhbmcuDQo+Pg0KPj4+DQo+Pj4+IFNvLCBJIGFkZGVkIHRoaXMgZnNkYXgg
Y2FzZSBoZXJlLsKgIFRoaXMgcGF0Y2hzZXQgb25seSBpbXBsZW1lbnRlZCANCj4+Pj4gdGhlIGZz
ZGF4IGNhc2UsIG90aGVyIGNhc2VzIGFsc28gbmVlZCB0byBiZSBhZGRlZCBoZXJlIGlmIHRvIGJl
IA0KPj4+PiBpbXBsZW1lbnRlZC4NCj4+Pj4NCj4+Pj4NCj4+Pj4gLS0gDQo+Pj4+IFRoYW5rcywN
Cj4+Pj4gUnVhbiBTaGl5YW5nLg0KPj4+Pg0KPj4+Pj4NCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAg
dGstPnNpemVfc2hpZnQgPSBkZXZfcGFnZW1hcF9tYXBwaW5nX3NoaWZ0KHAsIHZtYSwgDQo+Pj4+
Pj4gdGstPmFkZHIpOw0KPj4+Pj4+ICvCoMKgwqAgfSBlbHNlDQo+Pj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgIHRrLT5zaXplX3NoaWZ0ID0gcGFnZV9zaGlmdChjb21wb3VuZF9oZWFkKHApKTsNCj4+
Pj4+PiDCoCDCoMKgwqDCoMKgIC8qDQo+Pj4+Pj4gQEAgLTQ5NSw3ICs1MDEsNyBAQCBzdGF0aWMg
dm9pZCBjb2xsZWN0X3Byb2NzX2Fub24oc3RydWN0IHBhZ2UgDQo+Pj4+Pj4gKnBhZ2UsIHN0cnVj
dCBsaXN0X2hlYWQgKnRvX2tpbGwsDQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKCFwYWdlX21hcHBlZF9pbl92bWEocGFnZSwgdm1hKSkNCj4+Pj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOw0KPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlmICh2bWEtPnZtX21tID09IHQtPm1tKQ0KPj4+Pj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYWRkX3RvX2tpbGwodCwgcGFnZSwgdm1hLCB0b19raWxsKTsNCj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZF90b19raWxsKHQsIHBhZ2Us
IE5VTEwsIDAsIHZtYSwgdG9fa2lsbCk7DQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+
Pj4+PiDCoMKgwqDCoMKgIH0NCj4+Pj4+PiDCoMKgwqDCoMKgIHJlYWRfdW5sb2NrKCZ0YXNrbGlz
dF9sb2NrKTsNCj4+Pj4+PiBAQCAtNTA1LDI0ICs1MTEsMTkgQEAgc3RhdGljIHZvaWQgY29sbGVj
dF9wcm9jc19hbm9uKHN0cnVjdCBwYWdlIA0KPj4+Pj4+ICpwYWdlLCBzdHJ1Y3QgbGlzdF9oZWFk
ICp0b19raWxsLA0KPj4+Pj4+IMKgIC8qDQo+Pj4+Pj4gwqDCoCAqIENvbGxlY3QgcHJvY2Vzc2Vz
IHdoZW4gdGhlIGVycm9yIGhpdCBhIGZpbGUgbWFwcGVkIHBhZ2UuDQo+Pj4+Pj4gwqDCoCAqLw0K
Pj4+Pj4+IC1zdGF0aWMgdm9pZCBjb2xsZWN0X3Byb2NzX2ZpbGUoc3RydWN0IHBhZ2UgKnBhZ2Us
IHN0cnVjdCANCj4+Pj4+PiBsaXN0X2hlYWQgKnRvX2tpbGwsDQo+Pj4+Pj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgZm9yY2VfZWFybHkpDQo+Pj4+Pj4gK3N0YXRpYyB2b2lk
IGNvbGxlY3RfcHJvY3NfZmlsZShzdHJ1Y3QgcGFnZSAqcGFnZSwgc3RydWN0IA0KPj4+Pj4+IGFk
ZHJlc3Nfc3BhY2UgKm1hcHBpbmcsDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHBnb2ZmX3QgcGdv
ZmYsIHN0cnVjdCBsaXN0X2hlYWQgKnRvX2tpbGwsIGludCBmb3JjZV9lYXJseSkNCj4+Pj4+PiDC
oCB7DQo+Pj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYTsNCj4+Pj4+
PiDCoMKgwqDCoMKgIHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrOw0KPj4+Pj4+IC3CoMKgwqAgc3Ry
dWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcgPSBwYWdlLT5tYXBwaW5nOw0KPj4+Pj4+IC3CoMKg
wqAgcGdvZmZfdCBwZ29mZjsNCj4+Pj4+PiDCoCDCoMKgwqDCoMKgIGlfbW1hcF9sb2NrX3JlYWQo
bWFwcGluZyk7DQo+Pj4+Pj4gwqDCoMKgwqDCoCByZWFkX2xvY2soJnRhc2tsaXN0X2xvY2spOw0K
Pj4+Pj4+IC3CoMKgwqAgcGdvZmYgPSBwYWdlX3RvX3Bnb2ZmKHBhZ2UpOw0KPj4+Pj4+IMKgwqDC
oMKgwqAgZm9yX2VhY2hfcHJvY2Vzcyh0c2spIHsNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
c3RydWN0IHRhc2tfc3RydWN0ICp0ID0gdGFza19lYXJseV9raWxsKHRzaywgZm9yY2VfZWFybHkp
Ow0KPj4+Pj4+IC0NCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCF0KQ0KPj4+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOw0KPj4+Pj4+IC3CoMKgwqDCoMKgwqDC
oCB2bWFfaW50ZXJ2YWxfdHJlZV9mb3JlYWNoKHZtYSwgJm1hcHBpbmctPmlfbW1hcCwgcGdvZmYs
DQo+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwZ29m
Zikgew0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB2bWFfaW50ZXJ2YWxfdHJlZV9mb3JlYWNoKHZt
YSwgJm1hcHBpbmctPmlfbW1hcCwgcGdvZmYsIA0KPj4+Pj4+IHBnb2ZmKSB7DQo+Pj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICogU2VuZCBlYXJseSBraWxsIHNpZ25hbCB0byB0YXNrcyB3aGVyZSBhIHZtYSBjb3Zl
cnMNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogdGhlIHBhZ2UgYnV0IHRo
ZSBjb3JydXB0ZWQgcGFnZSBpcyBub3QgbmVjZXNzYXJpbHkNCj4+Pj4+PiBAQCAtNTMxLDcgKzUz
Miw3IEBAIHN0YXRpYyB2b2lkIGNvbGxlY3RfcHJvY3NfZmlsZShzdHJ1Y3QgcGFnZSANCj4+Pj4+
PiAqcGFnZSwgc3RydWN0IGxpc3RfaGVhZCAqdG9fa2lsbCwNCj4+Pj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICogdG8gYmUgaW5mb3JtZWQgb2YgYWxsIHN1Y2ggZGF0YSBjb3JydXB0
aW9ucy4NCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+Pj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHZtYS0+dm1fbW0gPT0gdC0+bW0pDQo+Pj4+Pj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGRfdG9fa2lsbCh0LCBwYWdlLCB2bWEs
IHRvX2tpbGwpOw0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRkX3Rv
X2tpbGwodCwgcGFnZSwgbWFwcGluZywgcGdvZmYsIHZtYSwgdG9fa2lsbCk7DQo+Pj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4+PiDCoMKgwqDCoMKgIH0NCj4+Pj4+PiDCoMKgwqDCoMKg
IHJlYWRfdW5sb2NrKCZ0YXNrbGlzdF9sb2NrKTsNCj4+Pj4+PiBAQCAtNTUwLDcgKzU1MSw4IEBA
IHN0YXRpYyB2b2lkIGNvbGxlY3RfcHJvY3Moc3RydWN0IHBhZ2UgKnBhZ2UsIA0KPj4+Pj4+IHN0
cnVjdCBsaXN0X2hlYWQgKnRva2lsbCwNCj4+Pj4+PiDCoMKgwqDCoMKgIGlmIChQYWdlQW5vbihw
YWdlKSkNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY29sbGVjdF9wcm9jc19hbm9uKHBhZ2Us
IHRva2lsbCwgZm9yY2VfZWFybHkpOw0KPj4+Pj4+IMKgwqDCoMKgwqAgZWxzZQ0KPj4+Pj4+IC3C
oMKgwqDCoMKgwqDCoCBjb2xsZWN0X3Byb2NzX2ZpbGUocGFnZSwgdG9raWxsLCBmb3JjZV9lYXJs
eSk7DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGNvbGxlY3RfcHJvY3NfZmlsZShwYWdlLCBwYWdl
LT5tYXBwaW5nLCBwYWdlX3RvX3Bnb2ZmKHBhZ2UpLA0KPj4+Pj4NCj4+Pj4+IFdoeSBub3QgdXNl
IHBhZ2VfbWFwcGluZygpIGhlbHBlciBoZXJlPyBJdCB3b3VsZCBiZSBzYWZlciBmb3IgVEhQcyAN
Cj4+Pj4+IGlmIHRoZXkNCj4+Pj4+IGV2ZXIgZ2V0IGhlcmUuLi4NCj4+Pj4+DQo+Pj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBIb256YQ0KPj4+Pj4NCj4+Pj4NCj4+Pg0KPj4+DQo+Pg0KPiANCj4gDQoNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5n
IGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFu
IGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
