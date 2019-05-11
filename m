Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19DA1A5B7
	for <lists+linux-nvdimm@lfdr.de>; Sat, 11 May 2019 02:13:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0161E2126CFB8;
	Fri, 10 May 2019 17:13:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E983D2125ADD3
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 17:13:36 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 May 2019 17:13:36 -0700
X-ExtLoop1: 1
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga002.jf.intel.com with ESMTP; 10 May 2019 17:13:36 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 10 May 2019 17:13:34 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.30]) by
 FMSMSX112.amr.corp.intel.com ([169.254.5.167]) with mapi id 14.03.0415.000;
 Fri, 10 May 2019 17:13:34 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: [ANNOUNCE] ndctl v65
Thread-Topic: [ANNOUNCE] ndctl v65
Thread-Index: AQHVB45ewXaAXWCdeEab6v6Ye2CdjA==
Date: Sat, 11 May 2019 00:13:33 +0000
Message-ID: <0a3d425cd6c4e19c5f877dfbee2d55556744f3c0.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <EDB35B58C469D648971FDBA86F96296A@intel.com>
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

VGhpcyByZWxlYXNlIGluY29ycG9yYXRlcyBmdW5jdGlvbmFsaXR5IHVwIHRvIHRoZSA1LjEga2Vy
bmVsLCBhbmQgYWRkcyBhDQpudW1iZXIgb2YgYnVnIGZpeGVzIGFuZCBpbXByb3ZlbWVudHMuDQoN
CkhpZ2hsaWdodHMgaW5jbHVkZSBhIG5ldyBjb21tYW5kIHRvIGNsZWFyIGVycm9ycyBvbiBhIGdp
dmVuIG5hbWVzcGFjZSwgYQ0KbmV3IHRyYXZpcyBZQU1MIGNvbmZpZ3VyYXRpb24gdG8gZW5hYmxl
IHRyYXZpcyBidWlsZHMgZm9yIFVidW50dSwgYW4NCmV4YW1wbGUgUUVNVSBzY3JpcHQgaW4gY29u
dHJpYi8gZm9yIEhNQVQgZW11bGF0aW9uLCBhbiBvcHRpb25hbCBwb2xsDQppbnRlcnZhbCBmb3Ig
d2FpdC1zY3J1Yiwgc2V2ZXJhbCBmaXhlcyByZWxhdGVkIHRvIHRoZSBzZWN1cml0eSBjb21tYW5k
cywNCnN1cHBvcnQgZm9yIHRoZSBIWVBFUi1WIGZhbWlseSBvZiBEU00gY29tbWFuZHMsIGFuZCBz
ZXZlcmFsIGZpeGVzIHRvDQp0ZXN0cywgZG9jdW1lbnRhdGlvbiwgYW5kIHJlbGF0ZWQgdG8gYnVp
bGRpbmcuDQoNCg0KU2hvcnRsb2cgZm9yIHRoaXMgcmVsZWFzZToNCg0KRGFuIFdpbGxpYW1zICgy
KToNCiAgICAgIG5kY3RsL2J1czogQWRkIHBvbGwgaW50ZXJ2YWwgdG8gd2FpdC1zY3J1Yg0KICAg
ICAgbmRjdGwvbGlzdDogSW50cm9kdWNlIHJlZ2lvbiBjYXBhYmlsaXR5IG9iamVjdHMNCg0KRGF2
ZSBKaWFuZyAoNyk6DQogICAgICBuZGN0bDogcHJlc2VydmUga2V5cyBhZnRlciBhbiBvdmVyd3Jp
dGUgY29tbWFuZA0KICAgICAgbmRjdGw6IGFsbG93IGEgInplcm8ta2V5IiBmb3Igc2VjdXJlIGVy
YXNlDQogICAgICBuZGN0bDogYWRkIGEgd2FybmluZyBhYm91dCBvdmVyd3JpdGUgdGFraW5nIGEg
bG9uZyB0aW1lDQogICAgICBuZGN0bDogZml4IGEgdHlwbyBpbiB0aGUgbmRjdGwtc2FuaXRpemUt
ZGltbSBtYW4gcGFnZQ0KICAgICAgbmRjdGw6IGZpeCBsb2FkLWtleXMgZm9yIG5vbi1UUE0gbWFz
dGVyLWtleXMNCiAgICAgIG5kY3RsOiBmaXgga2V5IGJsb2IgbG9hZGluZyBmb3Igbm9uLVRQTSBr
ZXlzDQogICAgICBuZGN0bDogYWRkIGEgbG9hZC1rZXlzIHRlc3QgaW4gdGhlIHNlY3VyaXR5IHVu
aXQgdGVzdA0KDQpEZXh1YW4gQ3VpICg1KToNCiAgICAgIGxpYm5kY3RsOiBJbXBsZW1lbnQgdGhl
ICJzbWFydF9nZXRfaGVhbHRoIiBkaW1tLW9wIGZvciBIeXBlci1WDQogICAgICBsaWJuZGN0bDog
SW1wbGVtZW50IHRoZSBzbWFydF9nZXRfc2h1dGRvd25fY291bnQgZGltbS1vcCBmb3INCkh5cGVy
LVYNCiAgICAgIG5kY3RsLCBtb25pdG9yOiBEb24ndCByZXF1aXJlIHRoZSBzdXBwb3J0IG9mDQpO
RF9DTURfU01BUlRfVEhSRVNIT0xEDQogICAgICBsaWJuZGN0bDogQWRkIGEgbmV3IGRpbW0tb3Ag
Y21kX2lzX3N1cHBvcnRlZCgpDQogICAgICBsaWJuZGN0bDogSW1wbGVtZW50IHRoZSAiY21kX2lz
X3N1cHBvcnRlZCIgZGltbS1vcCBmb3IgSHlwZXItVg0KDQpJcmEgV2VpbnkgKDEpOg0KICAgICAg
bmRjdGw6IGdlbmVyYWxpemUgbWFrZS1naXQtc25hcHNob3Quc2gNCg0KUUkgRnVsaSAoMSk6DQog
ICAgICBtb25pdG9yOiByZW1vdmUgdGhlIHJlcXVpcmVtZW50IG9mIGEgZGVmYXVsdCBjb25maWcN
Cg0KUm9iZXJ0IEVsbGlvdHQgKDMpOg0KICAgICAgYXV0b2NvbmY6IHByaW50IG1vcmUgcG9zc2li
bGUgcGFja2FnZSBuYW1lcyBmb3IgPGtleXV0aWxzLmg+DQogICAgICBhdXRvY29uZjogQ2hlY2sg
Zm9yIE1BUF9TSEFSRURfVkFMSURBVEUgYW5kIGtlcm5lbC9nbGliYyBjb25mbGljdHMNCiAgICAg
IG5kY3RsLCB0ZXN0OiBNYWtlIHRlc3RzIHVzaW5nIE1BUF9TWU5DIG9ubHkgaW5jbHVkZSA8c3lz
L21tYW4uaD4NCg0KU3RldmUgU2NhcmdhbGwgKDIpOg0KICAgICAgbmRjdGwvRG9jdW1lbnRhdGlv
bjogRml4IHR5cG8gaW4gc2VjdXJpdHkgbWFuIHBhZ2VzDQogICAgICBuZGN0bC9Eb2N1bWVudGF0
aW9uOiBjaGFuZ2UgZGlzYWJsZS1wYXNzcGhyYXNlIHRvIHJlbW92ZS0NCnBhc3NwaHJhc2UNCg0K
VmlzaGFsIFZlcm1hICgxMSk6DQogICAgICBuZGN0bCwgdGVzdDogZml4IGluY29ycmVjdCAnbmRj
dGwnIHVzYWdlIGluIHNlY3VyaXR5LnNoDQogICAgICBuZGN0bDogdXBkYXRlIFJFQURNRSBmb3Ig
ZGVwbW9kIG92ZXJyaWRlcywgc2hpcCBhIHNhbXBsZSBjb25maWcNCiAgICAgIG5kY3RsL3Rlc3Q6
IGFkZCBkYXhfcG1lbSogbW9kdWxlcyB0byB0aGUgdGVzdC1jb3JlDQogICAgICBuZGN0bDogZW5h
YmxlICd0cmF2aXMtY2knDQogICAgICBjb250cmliOiBhZGQgYW4gZXhhbXBsZSBxZW11IHNldHVw
IHNjcmlwdCBmb3IgSE1BVCBlbXVsYXRpb24NCiAgICAgIG5kY3RsOiBhZGQgYSAnY2xlYXItZXJy
b3JzJyBjb21tYW5kDQogICAgICBuZGN0bC9uYW1lc3BhY2UuYzogZml4IGEgcmVzb3VyY2UgbGVh
ayBpbiBidXNfc2VuZF9jbGVhcigpDQogICAgICBuZGN0bC9uYW1lc3BhY2UuYzogZml4IGFuIHVu
Y2hlY2tlZCByZXR1cm4gdmFsdWUNCiAgICAgIGxpYm5kY3RsOiBmaXggYW4gdW5oYW5kbGVkIHJl
dHVybiBpbg0KbmRjdGxfYnVzX3BvbGxfc2NydWJfY29tcGxldGlvbigpDQogICAgICBuZGN0bC9u
YW1lc3BhY2UuYzogZml4IGEgcG90ZW50aWFsIGludGVnZXIgb3ZlcmZsb3cNCiAgICAgIG5kY3Rs
OiByZWxlYXNlIHY2NQ0KDQpZaSBaaGFuZyAoMSk6DQogICAgICBuZGN0bC9yZWdpb246IGZpeCBl
cnJvciBwcm9wYWdhdGlvbiBpbiByZWdpb25fYWN0aW9uKCkNCg0KxYF1a2FzeiBQbGV3YSAoMSk6
DQogICAgICBuZGN0bDogZml4IGEgbWVtb3J5IGxlYWsgaW4gbGlibmRjdGwNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5n
IGxpc3QKTGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpodHRwczovL2xpc3RzLjAxLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52ZGltbQo=
