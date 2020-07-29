Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7006232062
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 16:30:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E0A9F126CA4E9;
	Wed, 29 Jul 2020 07:30:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.240.27.125; helo=a27-125.smtp-out.us-west-2.amazonses.com; envelope-from=010101739afbb321-07340dbd-d249-4568-b7c4-270e5c48a7e0-000000@us-west-2.amazonses.com; receiver=<UNKNOWN> 
Received: from a27-125.smtp-out.us-west-2.amazonses.com (a27-125.smtp-out.us-west-2.amazonses.com [54.240.27.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D79AF126CA4D2
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 07:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=sknkt525wmvsd5qrslvt4aisaznnhvir; d=konnectglobalmarketing.com;
	t=1596033053;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id;
	bh=FZzJH97scOHM8/b5TEbrT7YKC4ShVNoIL7VKzCiRytQ=;
	b=Zr6Ki0XqZLe7l47C9rsy9sOWfWUrq+9Mopdt42yALHkKrt6Wg+yjpvbZ7DwQUTSE
	HCKKCgX7T5tl8nH2qzikGnhRq58m1+Sr3KjMJPGDLqOUd0jUQ63fgIT6liEWtcISOrb
	b8kWMVg1b+YG/XV9I9hOuYWsomo0XkPzIAZJry2k=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1596033053;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id:Feedback-ID;
	bh=FZzJH97scOHM8/b5TEbrT7YKC4ShVNoIL7VKzCiRytQ=;
	b=gpKm6proCgqKPqWs9SpP/pjoTLjOsG/Pq+Aux0EsD05w0iKDXzBTnfQqb3ZuUPPC
	Y2sd/9N4rt7NocZozJ4eFY+orLAn+F05So693gcDdd0NhbuPlHdWOOuAzXSV4RD1QuB
	4/tVcWZDD3ThqUraanL3CKZbIfd5NCXz07Rodfgc=
Subject: Altium - Proposal
From: =?UTF-8?Q?Kelsey_Cooper?= <kelsey@konnectglobalmarketing.com>
To: =?UTF-8?Q?linux-nvdimm=40lists=2E01=2Eorg?= <linux-nvdimm@lists.01.org>
Date: Wed, 29 Jul 2020 14:30:53 +0000
Mime-Version: 1.0
References: <mail.e9d03447-21e1-4234-ba12-11ff93eadb5f@storage.wm.amazon.com>
 <mail.e9d03447-21e1-4234-ba12-11ff93eadb5f@storage.wm.amazon.com>
X-Priority: 3 (Normal)
X-Mailer: Amazon WorkMail
Thread-Index: AdZltM7vznOg6ggXSXm9m0/G60iiNg==
Thread-Topic: Altium - Proposal
X-Wm-Sent-Timestamp: 1596033052
Message-ID: <010101739afbb321-07340dbd-d249-4568-b7c4-270e5c48a7e0-000000@us-west-2.amazonses.com>
X-SES-Outgoing: 2020.07.29-54.240.27.125
Feedback-ID: 1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
Message-ID-Hash: C2UFVEXXSIDO5MKDHIXIMRKXMEIGH3U5
X-Message-ID-Hash: C2UFVEXXSIDO5MKDHIXIMRKXMEIGH3U5
X-MailFrom: 010101739afbb321-07340dbd-d249-4568-b7c4-270e5c48a7e0-000000@us-west-2.amazonses.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C2UFVEXXSIDO5MKDHIXIMRKXMEIGH3U5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCsKgDQpXb3VsZCB5b3UgbGlrZSB0byBzZW5kIGluIHlvdXIgQnVzaW5lc3MgUHJvcG9z
YWxzL05ld3NsZXR0ZXIgdG8ga2V5IGRlY2lzaW9uIE1ha2VycyBmcm9tIGNvbXBhbmllcyBjdXJy
ZW50bHkgdXNpbmcgQWx0aXVtIFNvZnR3YXJlPw0KDQrCoA0KVGl0bGVzIExpa2U6wqAgSVQgRGVj
aXNpb24gTWFrZXJzLCBDLWxldmVsLCBNYW5hZ2VycyBhbmQgb3RoZXIgam9iIHRpdGxlcyBhcyBw
ZXIgeW91ciByZXF1aXJlbWVudC4gDQoNCsKgDQpLaW5kbHkgbGV0IG1lIGtub3cgdGhlIEpvYiBU
aXRsZXMgJiBHZW9ncmFwaHkgdGhhdCB5b3Ugd2lzaCB0byB0YXJnZXQsIHNvIHRoYXQgSSBjYW4g
Z2V0IGJhY2sgd2l0aCB0aGUgc2FtcGxlcywgY291bnRzIGFuZCBtb3JlIGRldGFpbHMgZm9yIHlv
dXIgcmV2aWV3LiANCg0KwqANCldlIGNhdGVyIG90aGVyIEluZHVzdHJ5IGNvbnRhY3RzIHN1Y2gg
YXM6IE1hbnVmYWN0dXJpbmcswqBDb25zdHJ1Y3Rpb24swqBFZHVjYXRpb24swqBSZXRhaWwswqBI
ZWFsdGhjYXJlLCBFbmVyZ3ksIFV0aWxpdGllcyAmIFdhc3RlIFRyZWF0bWVudCwgVHJhbnNwb3J0
YXRpb24sIGV0Yy4gDQoNCsKgDQpMb29raW5nIGZvcndhcmQgdG8geW91ciByZXNwb25zZS4NCg0K
wqANClJlZ2FyZHMsDQoNCktlbHNleSBDb29wZXIgLSBNYXJrZXRpbmcgRXhlY3V0aXZlDQoNCsKg
DQpTdGF5IHNhZmUuDQoNClJlcGx5IGJhY2sg4oCcUGFzc+KAnSBmb3Igbm8gZnVydGhlciBlbWFp
bHMuDQoNCsKgDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcK
VG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMu
MDEub3JnCg==
