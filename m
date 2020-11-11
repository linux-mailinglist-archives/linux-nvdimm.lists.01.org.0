Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38342AE72C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Nov 2020 04:45:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CF9541672CA4F;
	Tue, 10 Nov 2020 19:44:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=yi.zhang@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AADC21672CA4A
	for <linux-nvdimm@lists.01.org>; Tue, 10 Nov 2020 19:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1605066294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbHRGarbZ76CMTJSyQixvcDH0vf/ymWql7JPBUrhdi8=;
	b=dH4/8BrAAKUwAc41G42dNwCu7Zk8dPInLAAARxrodZIWHDghz7DWCQjS7xrx2t7qOusJON
	f7G8uxunqjk8YwUBj4a06+Gm+pp8Uj0zcf0UzeMdPwlbEAehwGg0e0PKXMQ7DLq8PQp9B3
	lnt1HIMMo+GPuZcl/w5ZheIXdu4rL7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-K02YGkKaOAeKEFBulgHcuA-1; Tue, 10 Nov 2020 22:44:51 -0500
X-MC-Unique: K02YGkKaOAeKEFBulgHcuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 749B11074658;
	Wed, 11 Nov 2020 03:44:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 98DB76115F;
	Wed, 11 Nov 2020 03:44:48 +0000 (UTC)
Subject: Re: regression from 5.10.0-rc3: BUG: Bad page state in process
 kworker/41:0 pfn:891066 during fio on devdax
From: Yi Zhang <yi.zhang@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams
 <dan.j.williams@intel.com>, Ralph Campbell <rcampbell@nvidia.com>
References: <1687234809.1086398.1604889506963.JavaMail.zimbra@redhat.com>
 <4ed7ea52-20be-68fe-f920-238ba358395c@redhat.com>
 <20201109141216.GD244516@ziepe.ca>
 <CAPcyv4gJG_-gGwzaenQdnVq13JUWLjEnsTV+e4swuVtpGVpC8g@mail.gmail.com>
 <20201109175442.GE244516@ziepe.ca> <20201110003616.GA525483@nvidia.com>
 <27b0fccb-7f71-ca99-129d-bd3e373c2a85@redhat.com>
 <053911f5-a66f-f788-3f9e-98526ed8234f@redhat.com>
Message-ID: <ef5aca5c-6d32-8d01-81d6-ac65558115fa@redhat.com>
Date: Wed, 11 Nov 2020 11:44:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <053911f5-a66f-f788-3f9e-98526ed8234f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yi.zhang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: 6C7WULXJNPCCKKU2M5V7N5JBOHOACABL
X-Message-ID-Hash: 6C7WULXJNPCCKKU2M5V7N5JBOHOACABL
X-MailFrom: yi.zhang@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6C7WULXJNPCCKKU2M5V7N5JBOHOACABL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

QWRkIFJhbHBoDQoNCj4+DQo+IEhpIERhbi9KYXNvbg0KPg0KPiBJdCB0dXJucyBvdXQgdGhhdCBp
dCB3YXMgaW50cm9kdWNlZCBieSBiZWxsb3cgcGF0Y2hbMV0gd2hpY2ggZml4ZWQgdGhlIA0KPiAi
c3RhdGljIGtleSBkZXZtYXBfbWFuYWdlZF9rZXkiIGlzc3VlLCBidXQgaW50cm9kdWNlZCBbMl0N
Cj4gRmluYWxseSBJIGZvdW5kIGl0IHdhcyBub3QgMTAwJSByZXByb2R1Y2VkLCBhbmQgc29ycnkg
Zm9yIG15IG1pc3Rha2UuDQo+DQo+IFsxXQ0KPiBjb21taXQgNDZiMWVlMzhiMmJhMWE5NTI0Yzhl
ODg2YWQwNzhiZDNjYTQwZGUyYSAoSEVBRCkNCj4gQXV0aG9yOiBSYWxwaCBDYW1wYmVsbCA8cmNh
bXBiZWxsQG52aWRpYS5jb20+DQo+IERhdGU6wqDCoCBTdW4gTm92IDEgMTc6MDc6MjMgMjAyMCAt
MDgwMA0KPg0KPiDCoMKgwqAgbW0vbXJlbWFwX3BhZ2VzOiBmaXggc3RhdGljIGtleSBkZXZtYXBf
bWFuYWdlZF9rZXkgdXBkYXRlcw0KPg0KPiBbMl0NCj4gWyAxMTI5Ljc5MjY3M10gbWVtbWFwX2lu
aXRfem9uZV9kZXZpY2UgaW5pdGlhbGlzZWQgMjA2Mzg3MiBwYWdlcyBpbiAzNG1zDQo+IFsgMTEy
OS44NjU0NjldIG1lbW1hcF9pbml0X3pvbmVfZGV2aWNlIGluaXRpYWxpc2VkIDIwNjM4NzIgcGFn
ZXMgaW4gMzRtcw0KPiBbIDExMjkuOTI0MDgwXSBtZW1tYXBfaW5pdF96b25lX2RldmljZSBpbml0
aWFsaXNlZCAyMDYzODcyIHBhZ2VzIGluIDI0bXMNCj4gWyAxMTI5Ljk4NzE2MF0gbWVtbWFwX2lu
aXRfem9uZV9kZXZpY2UgaW5pdGlhbGlzZWQgMjA2Mzg3MiBwYWdlcyBpbiAyNW1zDQo+IFsgMTE3
MC43ODUxMTRdIEJVRzogQmFkIHBhZ2Ugc3RhdGUgaW4gcHJvY2VzcyBrd29ya2VyLzY3OjIgcGZu
OjE4OWUzZQ0KPiBbIDExNzAuODE1ODU5XSBwYWdlOjAwMDAwMDAwMmY1ZmUwNDcgcmVmY291bnQ6
MCBtYXBjb3VudDotMTAyNCANCj4gbWFwcGluZzowMDAwMDAwMDAwMDAwMDAwIGluZGV4OjB4MCBw
Zm46MHgxODllM2UNCj4gWyAxMTcwLjg2NDc3Ml0gZmxhZ3M6IDB4MTdmZmZmYzAwMDAwMDAoKQ0K
PiBbIDExNzAuODgzMjkxXSByYXc6IDAwMTdmZmZmYzAwMDAwMDAgZGVhZDAwMDAwMDAwMDEwMCBk
ZWFkMDAwMDAwMDAwMTIyIA0KPiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgMTE3MC45MjA1MzddIHJh
dzogMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAwZmZmZmZiZmYgDQo+
IDAwMDAwMDAwMDAwMDAwMDANCj4gWyAxMTcwLjk1NzYyN10gcGFnZSBkdW1wZWQgYmVjYXVzZTog
bm9uemVybyBtYXBjb3VudA0KPiBbIDExNzAuOTgwMTAxXSBNb2R1bGVzIGxpbmtlZCBpbjogcnBj
c2VjX2dzc19rcmI1IGF1dGhfcnBjZ3NzIG5mc3Y0IA0KPiBkbnNfcmVzb2x2ZXIgbmZzIGxvY2tk
IGdyYWNlIG5mc19zc2MgZnNjYWNoZSByZmtpbGwgc3VucnBjIHZmYXQgZmF0IA0KPiBkbV9tdWx0
aXBhdGggaW50ZWxfcmFwbF9tc3IgaW50ZWxfcmFwbF9jb21tb24gc2JfZWRhYyANCj4geDg2X3Br
Z190ZW1wX3RoZXJtYWwgaW50ZWxfcG93ZXJjbGFtcCBjb3JldGVtcCBrdm1faW50ZWwgaXBtaV9z
c2lmIGt2bSANCj4gaXJxYnlwYXNzIG1nYWcyMDAgY3JjdDEwZGlmX3BjbG11bCBpVENPX3dkdCBp
MmNfYWxnb19iaXQgY3JjMzJfcGNsbXVsIA0KPiBpVENPX3ZlbmRvcl9zdXBwb3J0IGRybV9rbXNf
aGVscGVyIHN5c2NvcHlhcmVhIGFjcGlfaXBtaSANCj4gZ2hhc2hfY2xtdWxuaV9pbnRlbCBzeXNm
aWxscmVjdCBpcG1pX3NpIHJhcGwgc3lzaW1nYmx0IGZiX3N5c19mb3BzIA0KPiBpMmNfaTgwMSBp
cG1pX2RldmludGYgZHJtIGlwbWlfbXNnaGFuZGxlciBpbnRlbF9jc3RhdGUgaW50ZWxfdW5jb3Jl
IA0KPiBkYXhfcG1lbV9jb21wYXQgZGV2aWNlX2RheCBpb2F0ZG1hIGkyY19zbWJ1cyBhY3BpX3Rh
ZCBqb3lkZXYgDQo+IGRheF9wbWVtX2NvcmUgcGNzcGtyIGhwd2R0IGxwY19pY2ggYWNwaV9wb3dl
cl9tZXRlciBocGlsbyBkY2EgDQo+IGlwX3RhYmxlcyB4ZnMgc3JfbW9kIGNkcm9tIHNkX21vZCB0
MTBfcGkgc2cgbmRfcG1lbSBuZF9idHQgYWhjaSBibngyeCANCj4gbGliYWhjaSBuZml0IGxpYmF0
YSB0ZzMgbGlibnZkaW1tIGhwc2EgbWRpbyBzY3NpX3RyYW5zcG9ydF9zYXMgDQo+IGxpYmNyYzMy
YyB3bWkgY3JjMzJjX2ludGVsIGRtX21pcnJvciBkbV9yZWdpb25faGFzaCBkbV9sb2cgZG1fbW9k
DQo+IFsgMTE3MS4zMzIyODFdIENQVTogNjcgUElEOiAyNzAwIENvbW06IGt3b3JrZXIvNjc6MiBU
YWludGVkOiBHIA0KPiBTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDUuMTAuMC1yYzIu
NDZiMWVlMzhiMmJhKyAjNA0KPiBbIDExNzEuMzc4MzM0XSBIYXJkd2FyZSBuYW1lOiBIUCBQcm9M
aWFudCBETDM4MCBHZW45L1Byb0xpYW50IERMMzgwIA0KPiBHZW45LCBCSU9TIFA4OSAxMC8wNS8y
MDE2DQo+IFsgMTE3MS40MTk3NzRdIFdvcmtxdWV1ZTogbW1fcGVyY3B1X3dxIHZtc3RhdF91cGRh
dGUNCj4gWyAxMTcxLjQ0MjcyNl0gQ2FsbCBUcmFjZToNCj4gWyAxMTcxLjQ1NDQ4MV3CoCBkdW1w
X3N0YWNrKzB4NTcvMHg2YQ0KPiBbIDExNzEuNDcwNTk3XcKgIGJhZF9wYWdlLmNvbGQuMTE0KzB4
OWIvMHhhMA0KPiBbIDExNzEuNDg5ODQxXcKgIGZyZWVfcGNwcGFnZXNfYnVsaysweDUzOC8weDc2
MA0KPiBbIDExNzEuNTA5MTI0XcKgIGRyYWluX3pvbmVfcGFnZXMrMHgxZi8weDMwDQo+IFsgMTE3
MS41Mjc2NDldwqAgcmVmcmVzaF9jcHVfdm1fc3RhdHMrMHgxZWEvMHgyYjANCj4gWyAxMTcxLjU0
ODkzNV3CoCB2bXN0YXRfdXBkYXRlKzB4Zi8weDUwDQo+IFsgMTE3MS41NjU5NjFdwqAgcHJvY2Vz
c19vbmVfd29yaysweDFhNC8weDM0MA0KPiBbIDExNzEuNTg1MTQyXcKgID8gcHJvY2Vzc19vbmVf
d29yaysweDM0MC8weDM0MA0KPiBbIDExNzEuNjA1MTQ3XcKgIHdvcmtlcl90aHJlYWQrMHgzMC8w
eDM3MA0KPiBbIDExNzEuNjIyNjAzXcKgID8gcHJvY2Vzc19vbmVfd29yaysweDM0MC8weDM0MA0K
PiBbIDExNzEuNjQyMzU1XcKgIGt0aHJlYWQrMHgxMTYvMHgxMzANCj4gWyAxMTcxLjY1NzUxOV3C
oCA/IGt0aHJlYWRfcGFyaysweDgwLzB4ODANCj4gWyAxMTcxLjY3NDcxM13CoCByZXRfZnJvbV9m
b3JrKzB4MjIvMHgzMA0KPiBbIDExNzEuNjkxMjkxXSBEaXNhYmxpbmcgbG9jayBkZWJ1Z2dpbmcg
ZHVlIHRvIGtlcm5lbCB0YWludA0KPg0KPj4+IEhvdyBjb25maWRlbnQgYXJlIHlvdSBpbiB0aGUg
YmlzZWN0aW9uPw0KPj4+DQo+Pj4gSmFzb24NCj4+Pg0KPj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IExpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3Qg
LS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZw0KPj4gVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBl
bWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnDQo+Pg0KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eC1udmRpbW0gbWFp
bGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcNCj4gVG8gdW5zdWJzY3JpYmUg
c2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFp
bGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2Vu
ZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
