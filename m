Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3457D233904
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Jul 2020 21:28:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 43689127B7F02;
	Thu, 30 Jul 2020 12:28:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.240.27.14; helo=a27-14.smtp-out.us-west-2.amazonses.com; envelope-from=01010173a1326c7d-7b7a923d-952b-4f3d-a89e-b258a6983e63-000000@us-west-2.amazonses.com; receiver=<UNKNOWN> 
Received: from a27-14.smtp-out.us-west-2.amazonses.com (a27-14.smtp-out.us-west-2.amazonses.com [54.240.27.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3794F12765A23
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jul 2020 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=sknkt525wmvsd5qrslvt4aisaznnhvir; d=konnectglobalmarketing.com;
	t=1596137303;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id;
	bh=Jx6r8iVv6aRs7ZqJ2uWIaeqjkofHg97tYCtKVYT7LQ4=;
	b=b6Bse9j/G7S/N/HVtFIHpqq90LkW3DHHCMp9LuqneWyff08Kvajvwc2SX+Qngn1Y
	ZgnVmOYPZIfTqOK1Clut5Z5a4sp4v9pBqhp7r/xKhdfZ0miYia37RwxMWkm5BYz+Zki
	z0otMea0wbwkx+waMczgftGxL9hhrpxeuknCxX8Y=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1596137303;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id:Feedback-ID;
	bh=Jx6r8iVv6aRs7ZqJ2uWIaeqjkofHg97tYCtKVYT7LQ4=;
	b=bXnLLsem7Xvd9F/homF3TVthLMRPzDT7kO0WIBbrPfs5dID3za9Ur2LwYDyv9asQ
	aQRIaifPPqF+Yp/+LTsUfed+VrM69uzFMFPDswCd+soHr3cuQsgQcxtTY2a3elCl465
	4/oZglS5qRd0VQWDwXdNikHTWkX+wqZ0ErsxF55M=
Subject: RE: Altium - Proposal
From: =?UTF-8?Q?Kelsey_Cooper?= <kelsey@konnectglobalmarketing.com>
To: =?UTF-8?Q?=27linux-nvdimm=40lists=2E01=2Eorg=27?=
  <linux-nvdimm@lists.01.org>
Date: Thu, 30 Jul 2020 19:28:23 +0000
Mime-Version: 1.0
References: <mail.946ee849-0faf-4491-a058-e2dccfb7a01a@storage.wm.amazon.com>
 <mail.946ee849-0faf-4491-a058-e2dccfb7a01a@storage.wm.amazon.com>
X-Priority: 3 (Normal)
X-Mailer: Amazon WorkMail
Thread-Index: AdZmpqHldWfySWKaTYWSUDTHo7Fw/Q==
Thread-Topic: RE: Altium - Proposal
X-Wm-Sent-Timestamp: 1596137301
Message-ID: <01010173a1326c7d-7b7a923d-952b-4f3d-a89e-b258a6983e63-000000@us-west-2.amazonses.com>
X-SES-Outgoing: 2020.07.30-54.240.27.14
Feedback-ID: 1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
Message-ID-Hash: MMO4FYLPISJUPM6YD27DK7QFMTFD3Z5C
X-Message-ID-Hash: MMO4FYLPISJUPM6YD27DK7QFMTFD3Z5C
X-MailFrom: 01010173a1326c7d-7b7a923d-952b-4f3d-a89e-b258a6983e63-000000@us-west-2.amazonses.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MMO4FYLPISJUPM6YD27DK7QFMTFD3Z5C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCg0KRGlkIHlvdSBnZXQgYSBjaGFuY2UgdG8gZ28gdGhyb3VnaCBteSBwcmV2aW91cyBl
bWFpbD8gDQoNCg0KS2luZGx5IGxldCBtZSBrbm93IHlvdXIgdGFyZ2V0IGF1ZGllbmNlIEpvYiBU
aXRsZXMgJiBHZW9ncmFwaHkgdGhhdCB5b3Ugd2lzaCB0byB0YXJnZXQsIHNvIHRoYXQgSSBjYW4g
Z2V0IGJhY2sgd2l0aCB0aGUgY291bnRzLCBwcmljaW5nIGFuZCBhbGwgdGhlIGRldGFpbHMgZm9y
IHlvdXIgcmV2aWV3Lg0KDQrCoA0KQXBwcmVjaWF0ZSB5b3VyIHJlc3BvbnNlLg0KDQrCoA0KUmVn
YXJkcywNCg0KS2Vsc2V5IENvb3BlciAtIE1hcmtldGluZyBFeGVjdXRpdmUNCg0KwqANCsKgDQpI
aSwNCg0KwqANCldvdWxkIHlvdSBsaWtlIHRvIHNlbmQgaW4geW91ciBCdXNpbmVzcyBQcm9wb3Nh
bHMvTmV3c2xldHRlciB0byBrZXkgZGVjaXNpb24gTWFrZXJzIGZyb20gY29tcGFuaWVzIGN1cnJl
bnRseSB1c2luZyBBbHRpdW0gU29mdHdhcmU/DQoNCsKgDQpUaXRsZXMgTGlrZTrCoCBJVCBEZWNp
c2lvbiBNYWtlcnMsIEMtbGV2ZWwsIE1hbmFnZXJzIGFuZCBvdGhlciBqb2IgdGl0bGVzIGFzIHBl
ciB5b3VyIHJlcXVpcmVtZW50LiANCg0KwqANCktpbmRseSBsZXQgbWUga25vdyB0aGUgSm9iIFRp
dGxlcyAmIEdlb2dyYXBoeSB0aGF0IHlvdSB3aXNoIHRvIHRhcmdldCwgc28gdGhhdCBJIGNhbiBn
ZXQgYmFjayB3aXRoIHRoZSBzYW1wbGVzLCBjb3VudHMgYW5kIG1vcmUgZGV0YWlscyBmb3IgeW91
ciByZXZpZXcuIA0KDQrCoA0KV2UgY2F0ZXIgb3RoZXIgSW5kdXN0cnkgY29udGFjdHMgc3VjaCBh
czogTWFudWZhY3R1cmluZyzCoENvbnN0cnVjdGlvbizCoEVkdWNhdGlvbizCoFJldGFpbCzCoEhl
YWx0aGNhcmUsIEVuZXJneSwgVXRpbGl0aWVzICYgV2FzdGUgVHJlYXRtZW50LCBUcmFuc3BvcnRh
dGlvbiwgZXRjLiANCg0KwqANCkxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHJlc3BvbnNlLg0KDQrC
oA0KUmVnYXJkcywNCg0KS2Vsc2V5IENvb3BlciAtIE1hcmtldGluZyBFeGVjdXRpdmUNCg0KwqAN
ClN0YXkgc2FmZS4NCg0KUmVwbHkgYmFjayDigJxQYXNz4oCdIGZvciBubyBmdXJ0aGVyIGVtYWls
cy4NCg0KwqANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpU
byB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4w
MS5vcmcK
