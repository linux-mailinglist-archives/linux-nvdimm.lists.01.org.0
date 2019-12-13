Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F4111E9BF
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Dec 2019 19:11:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4DADC10097F01;
	Fri, 13 Dec 2019 10:14:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=liran.alon@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A2A161011369E
	for <linux-nvdimm@lists.01.org>; Fri, 13 Dec 2019 10:14:32 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDHsZSq145297;
	Fri, 13 Dec 2019 18:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=53hxqoMlf8QDJ3jq3QCCM+0wlUtK9bJy534B+kQRWZ8=;
 b=CFCEeP59ftNzKHEjMdPdb+z5y8cPC0j29595ainF8r4ydRLWPiqvjHP/bL9FFwe4XLF1
 PbS1uslrlTy2u5lHVxGJU9nxGGLN2nhvNAUV0IDvMrbOGttliHlxDLTbz9oIyAosfXLi
 sQ3AO9Ybpqx3Ww4gRCr280fQ23NZ3r/zYhJc/0JUdB9YosdRMNE/QZlsTkZL7o35Lz2E
 yZfG/74A5Ue7C+0nzGvLwR3l5Ek4fO6AgT5XdIyu6lFYsyTdsatLESL1nC+G40VJRnAb
 Yv2NHp/daBXpFmg3EvCSI247OXar4cguohOorUrsKUiTAOsGRSUGg5DViN5idJiTN7QR WQ==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2wr4qs2g8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2019 18:09:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDHsWP8049398;
	Fri, 13 Dec 2019 18:09:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 2wvdwq33d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2019 18:09:05 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBDI94mN002972;
	Fri, 13 Dec 2019 18:09:04 GMT
Received: from [192.168.14.112] (/109.65.223.49)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 13 Dec 2019 10:09:04 -0800
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20191213175031.GC31552@linux.intel.com>
Date: Fri, 13 Dec 2019 20:08:59 +0200
Message-Id: <08D4A158-617C-4043-AA85-B12EE8F062B9@oracle.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-3-brho@google.com>
 <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com>
 <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
 <f8e948ff-6a2a-a6d6-9d8e-92b93003354a@google.com>
 <65FB6CC1-3AD2-4D6F-9481-500BD7037203@oracle.com>
 <20191213171950.GA31552@linux.intel.com>
 <4A5E026D-53E6-4F30-A80D-B5E6AA07A786@oracle.com>
 <20191213175031.GC31552@linux.intel.com>
To: Sean Christopherson <sean.j.christopherson@intel.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130142
Message-ID-Hash: GXDPCTO72KS47Q2KJ2Y45VF7SBVYQW55
X-Message-ID-Hash: GXDPCTO72KS47Q2KJ2Y45VF7SBVYQW55
X-MailFrom: liran.alon@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Barret Rhoden <brho@google.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GXDPCTO72KS47Q2KJ2Y45VF7SBVYQW55/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gT24gMTMgRGVjIDIwMTksIGF0IDE5OjUwLCBTZWFuIENocmlzdG9waGVyc29uIDxzZWFu
LmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgRGVjIDEz
LCAyMDE5IGF0IDA3OjMxOjU1UE0gKzAyMDAsIExpcmFuIEFsb24gd3JvdGU6DQo+PiANCj4+PiBP
biAxMyBEZWMgMjAxOSwgYXQgMTk6MTksIFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW4uai5jaHJp
c3RvcGhlcnNvbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IFRoZW4gYWxsb3dlZF9odWdl
cGFnZV9hZGp1c3QoKSB3b3VsZCBsb29rIHNvbWV0aGluZyBsaWtlOg0KPj4+IA0KPj4+IHN0YXRp
YyB2b2lkIGFsbG93ZWRfaHVnZXBhZ2VfYWRqdXN0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ2Zu
X3QgZ2ZuLA0KPj4+IAkJCQkgICAga3ZtX3Bmbl90ICpwZm5wLCBpbnQgKmxldmVscCwgaW50IG1h
eF9sZXZlbCkNCj4+PiB7DQo+Pj4gCWt2bV9wZm5fdCBwZm4gPSAqcGZucDsNCj4+PiAJaW50IGxl
dmVsID0gKmxldmVscDsJDQo+Pj4gCXVuc2lnbmVkIGxvbmcgbWFzazsNCj4+PiANCj4+PiAJaWYg
KGlzX2Vycm9yX25vc2xvdF9wZm4ocGZuKSB8fCAha3ZtX2lzX3Jlc2VydmVkX3BmbihwZm4pIHx8
DQo+Pj4gCSAgICBsZXZlbCA9PSBQVF9QQUdFX1RBQkxFX0xFVkVMKQ0KPj4+IAkJcmV0dXJuOw0K
Pj4+IA0KPj4+IAkvKg0KPj4+IAkgKiBtbXVfbm90aWZpZXJfcmV0cnkoKSB3YXMgc3VjY2Vzc2Z1
bCBhbmQgbW11X2xvY2sgaXMgaGVsZCwgc28NCj4+PiAJICogdGhlIHBtZC9wdWQgY2FuJ3QgYmUg
c3BsaXQgZnJvbSB1bmRlciB1cy4NCj4+PiAJICovDQo+Pj4gCWxldmVsID0gaG9zdF9wZm5fbWFw
cGluZ19sZXZlbCh2Y3B1LT5rdm0sIGdmbiwgcGZuKTsNCj4+PiANCj4+PiAJKmxldmVscCA9IGxl
dmVsID0gbWluKGxldmVsLCBtYXhfbGV2ZWwpOw0KPj4+IAltYXNrID0gS1ZNX1BBR0VTX1BFUl9I
UEFHRShsZXZlbCkgLSAxOw0KPj4+IAlWTV9CVUdfT04oKGdmbiAmIG1hc2spICE9IChwZm4gJiBt
YXNrKSk7DQo+Pj4gCSpwZm5wID0gcGZuICYgfm1hc2s7DQo+PiANCj4+IFdoeSBkb27igJl0IHlv
dSBzdGlsbCBuZWVkIHRvIGt2bV9yZWxlYXNlX3Bmbl9jbGVhbigpIGZvciBvcmlnaW5hbCBwZm4g
YW5kDQo+PiBrdm1fZ2V0X3BmbigpIGZvciBuZXcgaHVnZS1wYWdlIHN0YXJ0IHBmbj8NCj4gDQo+
IFRoYXQgY29kZSBpcyBnb25lIGluIGt2bS9xdWV1ZS4gIHRocF9hZGp1c3QoKSBpcyBub3cgY2Fs
bGVkIGZyb20NCj4gX19kaXJlY3RfbWFwKCkgYW5kIEZOQU1FKGZldGNoKSwgYW5kIHNvIGl0cyBw
Zm4gYWRqdXN0bWVudCBkb2Vzbid0IGJsZWVkDQo+IGJhY2sgdG8gdGhlIHBhZ2UgZmF1bHQgaGFu
ZGxlcnMuICBUaGUgb25seSByZWFzb24gdGhlIHB1dC9nZXQgcGZuIGNvZGUNCj4gZXhpc3RlZCB3
YXMgYmVjYXVzZSB0aGUgcGFnZSBmYXVsdCBoYW5kbGVycyBjYWxsZWQga3ZtX3JlbGVhc2VfcGZu
X2NsZWFuKCkNCj4gb24gdGhlIHBmbiwgaS5lLiB0aGV5IHdvdWxkIGhhdmUgcHV0IHRoZSB3cm9u
ZyBwZm4uDQoNCkFjay4gVGhhbmtzIGZvciB0aGUgZXhwbGFpbmluZyB0aGlzLg0KDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFp
bGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2Vu
ZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
