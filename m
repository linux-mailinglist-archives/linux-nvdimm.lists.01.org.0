Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7C911D59C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 19:32:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B59310113670;
	Thu, 12 Dec 2019 10:35:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=liran.alon@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AF3071011366F
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 10:35:51 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCIL1Y9048633;
	Thu, 12 Dec 2019 18:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=VNKl5CWbdSpN+Y7fCNta6wdQX8x1ddy6iAvSnWfUssY=;
 b=I6F3qqoXqHAHEXfCss0+urIzy+fVDLvbYUoR6WTt1/zaJyXu5zkYVrNjt6htgFhl3Lrp
 Y/dPbSU0TOJPFKt/bmFXYIrUlDabL6z5skYUdrW9SHCOJvkW0RGAHdVl4KdMFJidJPdb
 oV7Xfa7fhZf4nWlLdd6OIwFSXNrMxz0qe2THcLZyny8vIZXboJygZqeEI8pvf9iNqHbG
 9vJVue4uRPQHXuWExKYuWe8zLY6ubFxbC3Ro0JOfNl4+aDYlrBeoJGVEeBF1mkn/uzpR
 SiijjmLtLCD9wz78zkPMPTJBuGGR82uEOSRsi6SSUU5YBZvnAoro3c6j+DLFuLlwsLpO uQ==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2wr4qrvr8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2019 18:32:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCILNfq101182;
	Thu, 12 Dec 2019 18:32:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3020.oracle.com with ESMTP id 2wumw0vm11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2019 18:32:24 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBCIWMmE005263;
	Thu, 12 Dec 2019 18:32:22 GMT
Received: from [192.168.14.112] (/109.65.223.49)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 12 Dec 2019 10:32:22 -0800
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <CAPcyv4i5ZaiA+KeraXzz-0vs25UGEmZ2ka9Z-PUT3T_7URAFMA@mail.gmail.com>
Date: Thu, 12 Dec 2019 20:32:17 +0200
Message-Id: <5F859A55-C964-4362-9A25-3F4BA72E7326@oracle.com>
References: <20191211213207.215936-1-brho@google.com>
 <20191211213207.215936-3-brho@google.com>
 <376DB19A-4EF1-42BF-A73C-741558E397D4@oracle.com>
 <CAPcyv4gpYF=D323G+69FhFZw4i5W-15_wTRa1xNPdmear0phTw@mail.gmail.com>
 <F19843AB-1974-4E79-A85B-9AE00D58E192@oracle.com>
 <CAPcyv4i5ZaiA+KeraXzz-0vs25UGEmZ2ka9Z-PUT3T_7URAFMA@mail.gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120141
Message-ID-Hash: K2IZW7BAJH2QHSYHOL3PRNLPWQ3TUQLX
X-Message-ID-Hash: K2IZW7BAJH2QHSYHOL3PRNLPWQ3TUQLX
X-MailFrom: liran.alon@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Barret Rhoden <brho@google.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zeng, Jason" <jason.zeng@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K2IZW7BAJH2QHSYHOL3PRNLPWQ3TUQLX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gT24gMTIgRGVjIDIwMTksIGF0IDE5OjU5LCBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxp
YW1zQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIERlYyAxMiwgMjAxOSBhdCA5OjM5
IEFNIExpcmFuIEFsb24gPGxpcmFuLmFsb25Ab3JhY2xlLmNvbT4gd3JvdGU6DQo+PiANCj4+IA0K
Pj4gDQo+Pj4gT24gMTIgRGVjIDIwMTksIGF0IDE4OjU0LCBEYW4gV2lsbGlhbXMgPGRhbi5qLndp
bGxpYW1zQGludGVsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gVGh1LCBEZWMgMTIsIDIwMTkg
YXQgNDozNCBBTSBMaXJhbiBBbG9uIDxsaXJhbi5hbG9uQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+
PiANCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4gT24gMTEgRGVjIDIwMTksIGF0IDIzOjMyLCBCYXJyZXQg
UmhvZGVuIDxicmhvQGdvb2dsZS5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBUaGlzIGNoYW5n
ZSBhbGxvd3MgS1ZNIHRvIG1hcCBEQVgtYmFja2VkIGZpbGVzIG1hZGUgb2YgaHVnZSBwYWdlcyB3
aXRoDQo+Pj4+PiBodWdlIG1hcHBpbmdzIGluIHRoZSBFUFQvVERQLg0KPj4+Pj4gDQo+Pj4+PiBE
QVggcGFnZXMgYXJlIG5vdCBQYWdlVHJhbnNDb21wb3VuZC4gIFRoZSBleGlzdGluZyBjaGVjayBp
cyB0cnlpbmcgdG8NCj4+Pj4+IGRldGVybWluZSBpZiB0aGUgbWFwcGluZyBmb3IgdGhlIHBmbiBp
cyBhIGh1Z2UgbWFwcGluZyBvciBub3QuICBGb3INCj4+Pj4+IG5vbi1EQVggbWFwcywgZS5nLiBo
dWdldGxiZnMsIHRoYXQgbWVhbnMgY2hlY2tpbmcgUGFnZVRyYW5zQ29tcG91bmQuDQo+Pj4+PiBG
b3IgREFYLCB3ZSBjYW4gY2hlY2sgdGhlIHBhZ2UgdGFibGUgaXRzZWxmLg0KPj4+PiANCj4+Pj4g
Rm9yIGh1Z2V0bGJmcyBwYWdlcywgdGRwX3BhZ2VfZmF1bHQoKSAtPiBtYXBwaW5nX2xldmVsKCkg
LT4gaG9zdF9tYXBwaW5nX2xldmVsKCkgLT4ga3ZtX2hvc3RfcGFnZV9zaXplKCkgLT4gdm1hX2tl
cm5lbF9wYWdlc2l6ZSgpDQo+Pj4+IHdpbGwgcmV0dXJuIHRoZSBwYWdlLXNpemUgb2YgdGhlIGh1
Z2V0bGJmcyB3aXRob3V0IHRoZSBuZWVkIHRvIHBhcnNlIHRoZSBwYWdlLXRhYmxlcy4NCj4+Pj4g
U2VlIHZtYS0+dm1fb3BzLT5wYWdlc2l6ZSgpIGNhbGxiYWNrIGltcGxlbWVudGF0aW9uIGF0IGh1
Z2V0bGJfdm1fb3BzLT5wYWdlc2l6ZSgpPT1odWdldGxiX3ZtX29wX3BhZ2VzaXplKCkuDQo+Pj4+
IA0KPj4+PiBPbmx5IGZvciBwYWdlcyB0aGF0IHdlcmUgb3JpZ2luYWxseSBtYXBwZWQgYXMgc21h
bGwtcGFnZXMgYW5kIGxhdGVyIG1lcmdlZCB0byBsYXJnZXIgcGFnZXMgYnkgVEhQLCB0aGVyZSBp
cyBhIG5lZWQgdG8gY2hlY2sgZm9yIFBhZ2VUcmFuc0NvbXBvdW5kKCkuIEFnYWluLCBpbnN0ZWFk
IG9mIHBhcnNpbmcgcGFnZS10YWJsZXMuDQo+Pj4+IA0KPj4+PiBUaGVyZWZvcmUsIGl0IHNlZW1z
IG1vcmUgbG9naWNhbCB0byBtZSB0aGF0Og0KPj4+PiAoYSkgSWYgREFYLWJhY2tlZCBmaWxlcyBh
cmUgbWFwcGVkIGFzIGxhcmdlLXBhZ2VzIHRvIHVzZXJzcGFjZSwgaXQgc2hvdWxkIGJlIHJlZmxl
Y3RlZCBpbiB2bWEtPnZtX29wcy0+cGFnZV9zaXplKCkgb2YgdGhhdCBtYXBwaW5nLiBDYXVzaW5n
IGt2bV9ob3N0X3BhZ2Vfc2l6ZSgpIHRvIHJldHVybiB0aGUgcmlnaHQgc2l6ZSB3aXRob3V0IHRo
ZSBuZWVkIHRvIHBhcnNlIHRoZSBwYWdlLXRhYmxlcy4NCj4+PiANCj4+PiBBIGdpdmVuIGRheC1t
YXBwZWQgdm1hIG1heSBoYXZlIG1peGVkIHBhZ2Ugc2l6ZXMgc28gLT5wYWdlX3NpemUoKQ0KPj4+
IGNhbid0IGJlIHVzZWQgcmVsaWFibHkgdG8gZW51bWVyYXRpbmcgdGhlIG1hcHBpbmcgc2l6ZS4N
Cj4+IA0KPj4gTmFpdmUgcXVlc3Rpb246IFdoeSBkb27igJl0IHNwbGl0IHRoZSBWTUEgaW4gdGhp
cyBjYXNlIHRvIG11bHRpcGxlIFZNQXMgd2l0aCBkaWZmZXJlbnQgcmVzdWx0cyBmb3IgLT5wYWdl
X3NpemUoKT8NCj4gDQo+IEZpbGVzeXN0ZW1zIHRyYWRpdGlvbmFsbHkgaGF2ZSBub3QgcG9wdWxh
dGVkIC0+cGFnZXNpemUoKSBpbiB0aGVpcg0KPiB2bV9vcGVyYXRpb25zLCB0aGVyZSB3YXMgbm8g
Y29tcGVsbGluZyByZWFzb24gdG8gZ28gYWRkIGl0IGFuZCB0aGUNCj4gY29tcGxleGl0eSBzZWVt
cyBwcm9oaWJpdGl2ZS4NCg0KSSB1bmRlcnN0YW5kLiBUaG91Z2ggdGhpcyBpcyB0ZWNobmljYWwg
ZGVidCB0aGF0IGJyZWFrcyAtPnBhZ2Vfc2l6ZSgpIHNlbWFudGljcyB3aGljaCBtaWdodCBjYXVz
ZSBhIGNvbXBsZXggYnVnIHNvbWUgZGF5Li4uDQoNCj4gDQo+PiBXaGF0IHlvdSBhcmUgZGVzY3Jp
YmluZyBzb3VuZHMgbGlrZSBEQVggaXMgYnJlYWtpbmcgdGhpcyBjYWxsYmFjayBzZW1hbnRpY3Mg
aW4gYW4gdW5wcmVkaWN0YWJsZSBtYW5uZXIuDQo+IA0KPiBJdCdzIG5vdCB1bnByZWRpY3RhYmxl
LiB2bWFfa2VybmVsX3BhZ2VzaXplKCkgcmV0dXJucyBQQUdFX1NJWkUuDQoNCk9mIGNvdXJzZS4g
OikgSSBtZWFudCBpdCBtYXkgYmUgdW5leHBlY3RlZCBieSB0aGUgY2FsbGVyLg0KDQo+IEh1Z2UN
Cj4gcGFnZXMgaW4gdGhlIHBhZ2UgY2FjaGUgaGFzIGEgc2ltaWxhciBpc3N1ZS4NCg0KT2suIEkg
aGF2ZW7igJl0IGtub3duIHRoYXQuIFRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uLg0KDQo+IA0K
Pj4+PiAoYikgSWYgREFYLWJhY2tlZCBmaWxlcyBzbWFsbC1wYWdlcyBjYW4gYmUgbGF0ZXIgbWVy
Z2VkIHRvIGxhcmdlLXBhZ2VzIGJ5IFRIUCwgdGhlbiB0aGUg4oCcc3RydWN0IHBhZ2XigJ0gb2Yg
dGhlc2UgcGFnZXMgc2hvdWxkIGJlIG1vZGlmaWVkIGFzIHVzdWFsIHRvIG1ha2UgUGFnZVRyYW5z
Q29tcG91bmQoKSByZXR1cm4gdHJ1ZSBmb3IgdGhlbS4gSeKAmW0gbm90IGhpZ2hseSBmYW1pbGlh
ciB3aXRoIHRoaXMgbWVjaGFuaXNtLCBidXQgSSB3b3VsZCBleHBlY3QgVEhQIHRvIGJlIGFibGUg
dG8gbWVyZ2UgREFYLWJhY2tlZCBmaWxlcyBzbWFsbC1wYWdlcyB0byBsYXJnZS1wYWdlcyBpbiBj
YXNlIERBWCBwcm92aWRlcyDigJxzdHJ1Y3QgcGFnZeKAnSBmb3IgdGhlIERBWCBwYWdlcy4NCj4+
PiANCj4+PiBEQVggcGFnZXMgZG8gbm90IHBhcnRpY2lwYXRlIGluIFRIUCBhbmQgZG8gbm90IGhh
dmUgdGhlDQo+Pj4gUGFnZVRyYW5zQ29tcG91bmQgYWNjb3VudGluZy4gVGhlIG9ubHkgbWVjaGFu
aXNtIHRoYXQgcmVjb3JkcyB0aGUNCj4+PiBtYXBwaW5nIHNpemUgZm9yIGRheCBpcyB0aGUgcGFn
ZSB0YWJsZXMgdGhlbXNlbHZlcy4NCj4+IA0KPj4gV2hhdCBpcyB0aGUgcmF0aW9uYWwgYmVoaW5k
IHRoaXM/IEdpdmVuIHRoYXQgREFYIHBhZ2VzIGNhbiBiZSBkZXNjcmliZWQgd2l0aCDigJxzdHJ1
Y3QgcGFnZeKAnSAoaS5lLiBaT05FX0RFVklDRSksIHdoYXQgcHJldmVudHMgVEhQIGZyb20gbWFu
aXB1bGF0aW5nIHBhZ2UtdGFibGVzIHRvIG1lcmdlIG11bHRpcGxlIERBWCBQRk5zIHRvIGEgbGFy
Z2VyIHBhZ2U/DQo+IA0KPiBUSFAgYWNjb3VudGluZyBpcyBhIGZ1bmN0aW9uIG9mIHRoZSBwYWdl
IGFsbG9jYXRvci4gWk9ORV9ERVZJQ0UgcGFnZXMNCj4gYXJlIGV4Y2x1ZGVkIGZyb20gdGhlIHBh
Z2UgYWxsb2NhdG9yLiBaT05FX0RFVklDRSBpcyBqdXN0IGVub3VnaA0KPiBpbmZyYXN0cnVjdHVy
ZSB0byBzdXBwb3J0IHBmbl90b19wYWdlKCksIHBhZ2VfYWRkcmVzcygpLCBhbmQNCj4gZ2V0X3Vz
ZXJfcGFnZXMoKS4gT3RoZXIgcGFnZSBhbGxvY2F0b3Igc2VydmljZXMgYmV5b25kIHRoYXQgYXJl
IG5vdA0KPiBwcmVzZW50Lg0KDQpPay4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRp
bW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZk
aW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
