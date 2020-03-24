Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C09190610
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 08:07:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BA4A910FC38A0;
	Tue, 24 Mar 2020 00:08:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.74; helo=us-smtp-delivery-74.mimecast.com; envelope-from=bhe@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [216.205.24.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0D2EB10FC388D
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 00:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1585033671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaSi0ZO+Ks2DlAc0F4wKniHNa/ruO7TTk/TDQ9gB5fA=;
	b=BX6Oqw+KGYIEs9PWXVUQBdifL7yLEH38F520uXqFkiKj3Ca1g5/iOPptodIPVKNTyeB2T0
	Cr4sFtKzvhjkale7YORbraMKErYybL+NGPsziq2Fnp0p/64TLeV8BpIIBVNgTBn0hYY/jB
	y7i3aPL6lCr4b+kNgsJXTxHh96Gy8CU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-sHWL7KGCMh2yyJpLJRO4bw-1; Tue, 24 Mar 2020 03:07:46 -0400
X-MC-Unique: sHWL7KGCMh2yyJpLJRO4bw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 644718017CE;
	Tue, 24 Mar 2020 07:07:45 +0000 (UTC)
Received: from localhost (ovpn-12-69.pek2.redhat.com [10.72.12.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B7B191C947;
	Tue, 24 Mar 2020 07:07:44 +0000 (UTC)
Date: Tue, 24 Mar 2020 15:07:42 +0800
From: Baoquan He <bhe@redhat.com>
To: Sachin Sant <sachinp@linux.vnet.ibm.com>
Subject: Re: [5.6.0-rc7] Kernel crash while running ndctl tests
Message-ID: <20200324070742.GJ2987@MiWiFi-R3L-srv>
References: <CF20E440-4DCB-4EFD-88B6-0AB98DC7FBD4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CF20E440-4DCB-4EFD-88B6-0AB98DC7FBD4@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: Z2RL4O4DLIS3OBCHZWHLSYO3IVJ32KVD
X-Message-ID-Hash: Z2RL4O4DLIS3OBCHZWHLSYO3IVJ32KVD
X-MailFrom: bhe@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z2RL4O4DLIS3OBCHZWHLSYO3IVJ32KVD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgU2FjaGluLA0KDQpPbiAwMy8yNC8yMCBhdCAxMToyNWFtLCBTYWNoaW4gU2FudCB3cm90ZToN
Cj4gV2hpbGUgcnVubmluZyBuZGN0bFsxXSB0ZXN0cyBhZ2FpbnN0IDUuNi4wLXJjNyBmb2xsb3dp
bmcgY3Jhc2ggaXMgZW5jb3VudGVyZWQuDQo+IA0KPiBCaXNlY3QgbGVhZHMgbWUgdG8gIGNvbW1p
dCBkNDFlMmYzYmQ1NDYgDQo+IG1tL2hvdHBsdWc6IGZpeCBob3QgcmVtb3ZlIGZhaWx1cmUgaW4g
U1BBUlNFTUVNfCFWTUVNTUFQIGNhc2UNCj4gDQo+IFJldmVydGluZyB0aGlzIGNvbW1pdCBoZWxw
cyBhbmQgdGhlIHRlc3RzIGNvbXBsZXRlIHdpdGhvdXQgYW55IGNyYXNoLg0KDQpDb3VsZCB5b3Ug
cGFzdGUgeW91ciBrZXJuZWwgY29uZmlnIGFuZCB0aGUgYm9vdCBsb2c/DQoNCklmIGl0J3MgY29u
ZmlkZW50aWFsLCBwcml2YXRlIGF0dGFjaG1lbnQgaXMgYWxzbyBPSy4NCg0KVGhhbmtzDQpCYW9x
dWFuDQoNCj4gDQo+IHBtZW0wOiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDEw
NzIwNjQxMDI0DQo+IEJVRzogS2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBvbiByZWFk
IGF0IDB4MDAwMDAwMDANCj4gRmF1bHRpbmcgaW5zdHJ1Y3Rpb24gYWRkcmVzczogMHhjMDAwMDAw
MDAwYzM0NDdjDQo+IE9vcHM6IEtlcm5lbCBhY2Nlc3Mgb2YgYmFkIGFyZWEsIHNpZzogMTEgWyMx
XQ0KPiBMRSBQQUdFX1NJWkU9NjRLIE1NVT1IYXNoIFNNUCBOUl9DUFVTPTIwNDggTlVNQSBwU2Vy
aWVzDQo+IER1bXBpbmcgZnRyYWNlIGJ1ZmZlcjoNCj4gICAgKGZ0cmFjZSBidWZmZXIgZW1wdHkp
DQo+IE1vZHVsZXMgbGlua2VkIGluOiBkbV9tb2QgbmZfY29ubnRyYWNrIG5mX2RlZnJhZ19pcHY2
IG5mX2RlZnJhZ19pcHY0IGxpYmNyYzMyYyBpcDZfdGFibGVzIG5mdF9jb21wYXQgaXBfc2V0IHJm
a2lsbCBuZl90YWJsZXMgbmZuZXRsaW5rIHN1bnJwYyBzZyBwc2VyaWVzX3JuZyBwYXByX3NjbSB1
aW9fcGRydl9nZW5pcnEgdWlvIHNjaF9mcV9jb2RlbCBpcF90YWJsZXMgc2RfbW9kIHQxMF9waSBp
Ym12c2NzaSBzY3NpX3RyYW5zcG9ydF9zcnAgaWJtdmV0aA0KPiBDUFU6IDExIFBJRDogNzUxOSBD
b21tOiBsdC1uZGN0bCBOb3QgdGFpbnRlZCA1LjYuMC1yYzctYXV0b3Rlc3QgIzENCj4gTklQOiAg
YzAwMDAwMDAwMGMzNDQ3YyBMUjogYzAwMDAwMDAwMDA4ODM1NCBDVFI6IGMwMDAwMDAwMDAxOGU5
OTANCj4gUkVHUzogYzAwMDAwMDYyMjNmYjYzMCBUUkFQOiAwMzAwICAgTm90IHRhaW50ZWQgICg1
LjYuMC1yYzctYXV0b3Rlc3QpDQo+IE1TUjogIDgwMDAwMDAwMDI4MGIwMzMgPFNGLFZFQyxWU1gs
RUUsRlAsTUUsSVIsRFIsUkksTEU+ICBDUjogMjQwNDg4ODggIFhFUjogMDAwMDAwMDANCj4gQ0ZB
UjogYzAwMDAwMDAwMDAwZGVjNCBEQVI6IDAwMDAwMDAwMDAwMDAwMDAgRFNJU1I6IDQwMDAwMDAw
IElSUU1BU0s6IDAgDQo+IEdQUjAwOiBjMDAwMDAwMDAwM2M1ODIwIGMwMDAwMDA2MjIzZmI4YzAg
YzAwMDAwMDAwMTY4NDkwMCAwMDAwMDAwMDA0MDAwMDAwIA0KPiBHUFIwNDogYzAwYzAwMDEwMTAw
MDAwMCAwMDAwMDAwMDA3ZmZmZmZmIGMwMDAwMDA2N2ZmMjA5MDAgYzAwYzAwMDAwMDAwMDAwMCAN
Cj4gR1BSMDg6IDAwMDAwMDAwMDAwMDAwMDAgYzAwYzAwMDEwMDAwMDAwMCAwMDAwMDAwMDAwMDAw
MDAwIGMwMDAwMDAwMDNmMDAwMDAgDQo+IEdQUjEyOiAwMDAwMDAwMDAwMDA4MDAwIGMwMDAwMDAw
MWVjNzAyMDAgMDAwMDdmZmZjMTAyZjllOCAwMDAwMDAwMDEwMDJlMDg4IA0KPiBHUFIxNjogMDAw
MDAwMDAwMDAwMDAwMCAwMDAwMDAwMDEwMDUwZDg4IDAwMDAwMDAwMTAwMmY3NzggMDAwMDAwMDAx
MDAyZjc3MCANCj4gR1BSMjA6IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDEwMCAwMDAw
MDAwMDAwMDAwMDAxIDAwMDAwMDAwMDAwMDEwMDAgDQo+IEdQUjI0OiAwMDAwMDAwMDAwMDAwMDA4
IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwNDAwMDAwMCBjMDBjMDAwMTAwMDA0MDAwIA0KPiBH
UFIyODogYzAwMDAwMDAwMzEwMWFhMCBjMDBjMDAwMTAwMDAwMDAwIDAwMDAwMDAwMDEwMDAwMDAg
MDAwMDAwMDAwNDAwMDEwMCANCj4gTklQIFtjMDAwMDAwMDAwYzM0NDdjXSB2bWVtbWFwX3BvcHVs
YXRlZCsweDk4LzB4YzANCj4gTFIgW2MwMDAwMDAwMDAwODgzNTRdIHZtZW1tYXBfZnJlZSsweDE0
NC8weDMyMA0KPiBDYWxsIFRyYWNlOg0KPiBbYzAwMDAwMDYyMjNmYjhjMF0gW2MwMDAwMDA2MjIz
ZmI5NjBdIDB4YzAwMDAwMDYyMjNmYjk2MCAodW5yZWxpYWJsZSkNCj4gW2MwMDAwMDA2MjIzZmI5
ODBdIFtjMDAwMDAwMDAwM2M1ODIwXSBzZWN0aW9uX2RlYWN0aXZhdGUrMHgyMjAvMHgyNDANCj4g
W2MwMDAwMDA2MjIzZmJhMzBdIFtjMDAwMDAwMDAwM2RjMWQ4XSBfX3JlbW92ZV9wYWdlcysweDEx
OC8weDE3MA0KPiBbYzAwMDAwMDYyMjNmYmE4MF0gW2MwMDAwMDAwMDAwODZlNWNdIGFyY2hfcmVt
b3ZlX21lbW9yeSsweDNjLzB4MTUwDQo+IFtjMDAwMDAwNjIyM2ZiYjAwXSBbYzAwMDAwMDAwMDQx
YTNiY10gbWVtdW5tYXBfcGFnZXMrMHgxY2MvMHgyZjANCj4gW2MwMDAwMDA2MjIzZmJiODBdIFtj
MDAwMDAwMDAwN2Q2ZDAwXSBkZXZtX2FjdGlvbl9yZWxlYXNlKzB4MzAvMHg1MA0KPiBbYzAwMDAw
MDYyMjNmYmJhMF0gW2MwMDAwMDAwMDA3ZDdkZThdIHJlbGVhc2Vfbm9kZXMrMHgyZjgvMHgzZTAN
Cj4gW2MwMDAwMDA2MjIzZmJjNTBdIFtjMDAwMDAwMDAwN2QwYjM4XSBkZXZpY2VfcmVsZWFzZV9k
cml2ZXJfaW50ZXJuYWwrMHgxNjgvMHgyNzANCj4gW2MwMDAwMDA2MjIzZmJjOTBdIFtjMDAwMDAw
MDAwN2NjZjUwXSB1bmJpbmRfc3RvcmUrMHgxMzAvMHgxNzANCj4gW2MwMDAwMDA2MjIzZmJjZDBd
IFtjMDAwMDAwMDAwN2NjMGI0XSBkcnZfYXR0cl9zdG9yZSsweDQ0LzB4NjANCj4gW2MwMDAwMDA2
MjIzZmJjZjBdIFtjMDAwMDAwMDAwNTFmZGI4XSBzeXNmc19rZl93cml0ZSsweDY4LzB4ODANCj4g
W2MwMDAwMDA2MjIzZmJkMTBdIFtjMDAwMDAwMDAwNTFmMjAwXSBrZXJuZnNfZm9wX3dyaXRlKzB4
MTAwLzB4MjkwDQo+IFtjMDAwMDAwNjIyM2ZiZDYwXSBbYzAwMDAwMDAwMDQyMDM3Y10gX192ZnNf
d3JpdGUrMHgzYy8weDcwDQo+IFtjMDAwMDAwNjIyM2ZiZDgwXSBbYzAwMDAwMDAwMDQyNDA0Y10g
dmZzX3dyaXRlKzB4Y2MvMHgyNDANCj4gW2MwMDAwMDA2MjIzZmJkZDBdIFtjMDAwMDAwMDAwNDI0
NDJjXSBrc3lzX3dyaXRlKzB4N2MvMHgxNDANCj4gW2MwMDAwMDA2MjIzZmJlMjBdIFtjMDAwMDAw
MDAwMDBiMjc4XSBzeXN0ZW1fY2FsbCsweDVjLzB4NjgNCj4gSW5zdHJ1Y3Rpb24gZHVtcDoNCj4g
MmVhODAwMDAgNDE5NjAwM2MgNzk0YTI0MjggN2Q2ODUyMTUgNDE4MjAwMzAgN2Q0ODUwMmEgNzE0
ODAwMDIgNDE4MjAwMjQgDQo+IDcxNGEwMDA4IDQwODIwMDJjIGU5MGIwMDA4IDc4NmFkZjYyIDxl
ODY4MDAwMD4gN2M2MzU0MzYgNzA2MzAwMDEgNGM4MjAwMjAgDQo+IC0tLVsgZW5kIHRyYWNlIDU3
OWI0ODE2MmRhMWI4OTAgXeKAlA0KPiANCj4gVGhhbmtzDQo+IC1TYWNoaW4NCj4gDQo+IFsxXSBo
dHRwczovL2dpdGh1Yi5jb20vYXZvY2Fkby1mcmFtZXdvcmstdGVzdHMvYXZvY2Fkby1taXNjLXRl
c3RzL2Jsb2IvbWFzdGVyL21lbW9yeS9uZGN0bC5weQ0KPiANCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0g
bGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRv
IGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
