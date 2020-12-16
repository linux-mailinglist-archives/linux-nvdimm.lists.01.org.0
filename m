Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D252D2DB958
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 03:46:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3BA58100EF271;
	Tue, 15 Dec 2020 18:46:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A574E100EF270
	for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 18:46:43 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG2iQFr060031;
	Wed, 16 Dec 2020 02:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=WkCjasEHHy7py54Y2YmM8Hp8LCLtjfYuzvd3sPD2fgI=;
 b=HRPBZ1n1r4YYFJMqvwxqxobnCC8pPSyTiY3O8BBNihRVerUQAh1Dwe+MuK9XM63QVbTh
 E5LAPvc0G3eYYWwd4sAFBxJ7gg6m8G/ccfxjKGbWAZNfL/jaUw0i6bNG4xlqZWRPW8+N
 63XClUkN4jj4VGs6nZpKvvCpBTheMtzJvQHQzc5zmJ7Xtv5GtjM8L+A4q4P/NMmDimBM
 zKCXUSpwfATQfYo0KVaFdLu9kdqr7cqPGCL0wUpSlBHqbEhu8FlIFuJYVStg0nvPv5BZ
 E43zhimIo8Zvw1NkLsSaGch9+Q1wEabNEnmiKsHLvRciyi6W+R6bWWyIhHIEXZb0Zji7 fA==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 35cn9rds72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Dec 2020 02:46:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG2jAV8015913;
	Wed, 16 Dec 2020 02:46:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 35e6js2byy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Dec 2020 02:46:27 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BG2kJYw003814;
	Wed, 16 Dec 2020 02:46:20 GMT
Received: from localhost (/67.169.218.210)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 15 Dec 2020 18:46:19 -0800
Date: Tue, 15 Dec 2020 18:46:18 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH v2 0/6] fsdax: introduce fs query to support reflink
Message-ID: <20201216024618.GC6918@magnolia>
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
 <89ab4ec4-e4f0-7c17-6982-4f55bb40f574@oracle.com>
 <bb699996-ddc8-8f3a-dc8f-2422bf990b06@cn.fujitsu.com>
 <3b35604c-57e2-8cb5-da69-53508c998540@oracle.com>
 <20201215231022.GL632069@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201215231022.GL632069@dread.disaster.area>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160014
Message-ID-Hash: VLW5N5CDA23NGALGVGLZ5B7TS3ZBAQP5
X-Message-ID-Hash: VLW5N5CDA23NGALGVGLZ5B7TS3ZBAQP5
X-MailFrom: darrick.wong@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VLW5N5CDA23NGALGVGLZ5B7TS3ZBAQP5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBEZWMgMTYsIDIwMjAgYXQgMTA6MTA6MjJBTSArMTEwMCwgRGF2ZSBDaGlubmVyIHdy
b3RlOg0KPiBPbiBUdWUsIERlYyAxNSwgMjAyMCBhdCAxMTowNTowN0FNIC0wODAwLCBKYW5lIENo
dSB3cm90ZToNCj4gPiBPbiAxMi8xNS8yMDIwIDM6NTggQU0sIFJ1YW4gU2hpeWFuZyB3cm90ZToN
Cj4gPiA+IEhpIEphbmUNCj4gPiA+IA0KPiA+ID4gT24gMjAyMC8xMi8xNSDkuIrljYg0OjU4LCBK
YW5lIENodSB3cm90ZToNCj4gPiA+ID4gSGksIFNoaXlhbmcsDQo+ID4gPiA+IA0KPiA+ID4gPiBP
biAxMS8yMi8yMDIwIDQ6NDEgUE0sIFNoaXlhbmcgUnVhbiB3cm90ZToNCj4gPiA+ID4gPiBUaGlz
IHBhdGNoc2V0IGlzIGEgdHJ5IHRvIHJlc29sdmUgdGhlIHByb2JsZW0gb2YgdHJhY2tpbmcgc2hh
cmVkIHBhZ2UNCj4gPiA+ID4gPiBmb3IgZnNkYXguDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQ2hh
bmdlIGZyb20gdjE6DQo+ID4gPiA+ID4gwqDCoCAtIEludG9yZHVjZSAtPmJsb2NrX2xvc3QoKSBm
b3IgYmxvY2sgZGV2aWNlDQo+ID4gPiA+ID4gwqDCoCAtIFN1cHBvcnQgbWFwcGVkIGRldmljZQ0K
PiA+ID4gPiA+IMKgwqAgLSBBZGQgJ25vdCBhdmFpbGFibGUnIHdhcm5pbmcgZm9yIHJlYWx0aW1l
IGRldmljZSBpbiBYRlMNCj4gPiA+ID4gPiDCoMKgIC0gUmViYXNlZCB0byB2NS4xMC1yYzENCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBUaGlzIHBhdGNoc2V0IG1vdmVzIG93bmVyIHRyYWNraW5nIGZy
b20gZGF4X2Fzc29jYWl0ZV9lbnRyeSgpIHRvIHBtZW0NCj4gPiA+ID4gPiBkZXZpY2UsIGJ5IGlu
dHJvZHVjaW5nIGFuIGludGVyZmFjZSAtPm1lbW9yeV9mYWlsdXJlKCkgb2Ygc3RydWN0DQo+ID4g
PiA+ID4gcGFnZW1hcC7CoCBUaGUgaW50ZXJmYWNlIGlzIGNhbGxlZCBieSBtZW1vcnlfZmFpbHVy
ZSgpIGluIG1tLCBhbmQNCj4gPiA+ID4gPiBpbXBsZW1lbnRlZCBieSBwbWVtIGRldmljZS7CoCBU
aGVuIHBtZW0gZGV2aWNlIGNhbGxzIGl0cyAtPmJsb2NrX2xvc3QoKQ0KPiA+ID4gPiA+IHRvIGZp
bmQgdGhlIGZpbGVzeXN0ZW0gd2hpY2ggdGhlIGRhbWFnZWQgcGFnZSBsb2NhdGVkIGluLCBhbmQg
Y2FsbA0KPiA+ID4gPiA+IC0+c3RvcmFnZV9sb3N0KCkgdG8gdHJhY2sgZmlsZXMgb3IgbWV0YWRh
dGEgYXNzb2NhaXRlZCB3aXRoIHRoaXMgcGFnZS4NCj4gPiA+ID4gPiBGaW5hbGx5IHdlIGFyZSBh
YmxlIHRvIHRyeSB0byBmaXggdGhlIGRhbWFnZWQgZGF0YSBpbiBmaWxlc3lzdGVtIGFuZCBkbw0K
PiA+ID4gPiANCj4gPiA+ID4gRG9lcyB0aGF0IG1lYW4gY2xlYXJpbmcgcG9pc29uPyBpZiBzbywg
d291bGQgeW91IG1pbmQgdG8gZWxhYm9yYXRlDQo+ID4gPiA+IHNwZWNpZmljYWxseSB3aGljaCBj
aGFuZ2UgZG9lcyB0aGF0Pw0KPiA+ID4gDQo+ID4gPiBSZWNvdmVyaW5nIGRhdGEgZm9yIGZpbGVz
eXN0ZW0gKG9yIHBtZW0gZGV2aWNlKSBoYXMgbm90IGJlZW4gZG9uZSBpbg0KPiA+ID4gdGhpcyBw
YXRjaHNldC4uLsKgIEkganVzdCB0cmlnZ2VyZWQgdGhlIGhhbmRsZXIgZm9yIHRoZSBmaWxlcyBz
aGFyaW5nIHRoZQ0KPiA+ID4gY29ycnVwdGVkIHBhZ2UgaGVyZS4NCj4gPiANCj4gPiBUaGFua3Mh
IFRoYXQgY29uZmlybXMgbXkgdW5kZXJzdGFuZGluZy4NCj4gPiANCj4gPiBXaXRoIHRoZSBmcmFt
ZXdvcmsgcHJvdmlkZWQgYnkgdGhlIHBhdGNoc2V0LCBob3cgZG8geW91IGVudmlzaW9uIGl0IHRv
DQo+ID4gZWFzZS9zaW1wbGlmeSBwb2lzb24gcmVjb3ZlcnkgZnJvbSB0aGUgdXNlcidzIHBlcnNw
ZWN0aXZlPw0KPiANCj4gQXQgdGhlIG1vbWVudCwgSSdkIHNheSBubyBjaGFuZ2Ugd2hhdC1zby1l
dmVyLiBUSGUgYmVoYXZpb3VyIGlzDQo+IG5lY2Vzc2FyeSBzbyB0aGF0IHdlIGNhbiBraWxsIHdo
YXRldmVyIHVzZXIgYXBwbGljYXRpb24gbWFwcw0KPiBtdWx0aXBseS1zaGFyZWQgcGh5c2ljYWwg
YmxvY2tzIGlmIHRoZXJlJ3MgYSBtZW1vcnkgZXJyb3IuIFRIZQ0KPiByZWNvdmVyeSBtZXRob2Qg
ZnJvbSB0aGF0IGlzIHVuY2hhbmdlZC4gVGhlIG9ubHkgYWR2YW50YWdlIG1heSBiZQ0KPiB0aGF0
IHRoZSBmaWxlc3lzdGVtIChpZiBybWFwIGVuYWJsZWQpIGNhbiB0ZWxsIHlvdSB0aGUgZXhhY3Qg
ZmlsZQ0KPiBhbmQgb2Zmc2V0IGludG8gdGhlIGZpbGUgd2hlcmUgZGF0YSB3YXMgY29ycnVwdGVk
Lg0KPiANCj4gSG93ZXZlciwgaXQgY2FuIGJlIHdvcnNlLCB0b286IGl0IG1heSBhbHNvIG5vdyBj
b21wbGV0ZWx5IHNodXQgZG93bg0KPiB0aGUgZmlsZXN5c3RlbSBpZiB0aGUgZmlsZXN5c3RlbSBk
aXNjb3ZlcnMgdGhlIGVycm9yIGlzIGluIG1ldGFkYXRhDQo+IHJhdGhlciB0aGFuIHVzZXIgZGF0
YS4gVGhhdCdzIG11Y2ggbW9yZSBjb21wbGV4IHRvIHJlY292ZXIgZnJvbSwgYW5kDQo+IHJpZ2h0
IG5vdyB3aWxsIHJlcXVpcmUgZG93bnRpbWUgdG8gdGFrZSB0aGUgZmlsZXN5c3RlbSBvZmZsaW5l
IGFuZA0KPiBydW4gZnNjayB0byBjb3JyZWN0IHRoZSBlcnJvci4gVGhhdCBtYXkgdHJhc2ggd2hh
dGV2ZXIgdGhlIG1ldGFkYXRhDQo+IHRoYXQgY2FuJ3QgYmUgcmVjb3ZlcmVkIHBvaW50cyB0bywg
c28geW91IHN0aWxsIGhhdmUgYSB1ZXNyIGRhdGENCj4gcmVjb3ZlcnkgcHJvY2VzcyB0byBwZXJm
b3JtIGFmdGVyIHRoaXMuLi4NCg0KLi4udGhvdWdoIGZvciB0aGUgZnV0dXJlIGZ1dHVyZSBJJ2Qg
bGlrZSB0byBieXBhc3MgdGhlIGRlZmF1bHQgYmVoYXZpb3JzDQppZiB0aGVyZSdzIHNvbWVib2R5
IHdhdGNoaW5nIHRoZSBzYiBub3RpZmljYXRpb24gdGhhdCB3aWxsIGFsc28ga2ljayBvZmYNCnRo
ZSBhcHByb3ByaWF0ZSByZXBhaXIgYWN0aXZpdGllcy4gIFRoZSB4ZnMgYXV0by1yZXBhaXIgcGFy
dHMgYXJlIGNvbWluZw0KYWxvbmcgbmljZWx5LiAgRHVubm8gYWJvdXQgdXNlcnNwYWNlLCB0aG91
Z2ggSSBmaWd1cmUgaWYgd2UgY2FuIGRvDQp1c2Vyc3BhY2UgcGFnZSBmYXVsdHMgdGhlbiBzb21l
IHBlb3BsZSBjb3VsZCBwcm9iYWJseSBkbyBhdXRvcmVwYWlyDQp0b28uDQoNCi0tRA0KDQo+ID4g
QW5kIGhvdyBkb2VzIGl0IGhlbHAgaW4gZGVhbGluZyB3aXRoIHBhZ2UgZmF1bHRzIHVwb24gcG9p
c29uZWQNCj4gPiBkYXggcGFnZT8NCj4gDQo+IEl0IGRvZXNuJ3QuIElmIHRoZSBwYWdlIGlzIHBv
aXNvbmVkLCB0aGUgc2FtZSBiZWhhdmlvdXIgd2lsbCBvY2N1cg0KPiBhcyBkb2VzIG5vdy4gVGhp
cyBpcyBzaW1wbHkgZXJyb3IgcmVwb3J0aW5nIGluZnJhc3RydWN0dXJlLCBub3QNCj4gZXJyb3Ig
aGFuZGxpbmcuDQo+IA0KPiBGdXR1cmUgd29yayBtaWdodCBjaGFuZ2UgaG93IHdlIGNvcnJlY3Qg
dGhlIGZhdWx0cyBmb3VuZCBpbiB0aGUNCj4gc3RvcmFnZSwgYnV0IEkgdGhpbmsgdGhlIHVzZXIg
dmlzaWJsZSBiZWhhdmlvdXIgaXMgZ29pbmcgdG8gYmUgImtpbGwNCj4gYXBwcyBtYXBwaW5nIGNv
cnJ1cHRlZCBkYXRhIiBmb3IgYSBsb25nIHRpbWUgeWV0Li4uLg0KPiANCj4gQ2hlZXJzLA0KPiAN
Cj4gRGF2ZS4NCj4gLS0gDQo+IERhdmUgQ2hpbm5lcg0KPiBkYXZpZEBmcm9tb3JiaXQuY29tCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGlt
bSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmli
ZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
