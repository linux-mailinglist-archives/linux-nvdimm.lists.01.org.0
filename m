Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1D21E67FF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 May 2020 19:01:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 23C40122DCD3F;
	Thu, 28 May 2020 09:56:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.240.27.228; helo=a27-228.smtp-out.us-west-2.amazonses.com; envelope-from=010101725c3b0cb3-61f69e3a-72c8-438c-ad01-5a71cacf7a85-000000@us-west-2.amazonses.com; receiver=<UNKNOWN> 
Received: from a27-228.smtp-out.us-west-2.amazonses.com (a27-228.smtp-out.us-west-2.amazonses.com [54.240.27.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 54E13122DCD3D
	for <linux-nvdimm@lists.01.org>; Thu, 28 May 2020 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=sknkt525wmvsd5qrslvt4aisaznnhvir; d=konnectglobalmarketing.com;
	t=1590685273;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id;
	bh=AcvDgFPydpM3J1pkXQ64yQkPwkSZcAHNdWCGQHh7zSE=;
	b=FJyq159Amfgll2wvBuSPyQVFEdeYhYwUv8LbPdwGEWH2i6BQqZ/yMvns/9jl0U3M
	/FHCqiIsUFxodyU8RH72ioALlYr0+gERhO2TPtXJuDlJSvcS/b5cvqApOjI9NODjYXc
	VITJM432L3gEYwE2u8NMtLtj8YXDkaxr8c1LAD5g=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1590685273;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id:Feedback-ID;
	bh=AcvDgFPydpM3J1pkXQ64yQkPwkSZcAHNdWCGQHh7zSE=;
	b=HkVbIo6x2gCk4c87sD2xeXVtrmnGKMILYm68gvaISOCxxvGm2VBWc00oYZbOalqq
	8pr9Kz9xIpdBWAFX1MGBVh/WSzJ8ViGwQEUNXmFgY7devZpO7usA7usIqgBDTaUsuFX
	rNaEv5IbBwxNAX8td05W9fR6Mc7613jK4Z/m9VUs=
Subject: RE: Proposal
From: =?UTF-8?Q?Hailey_Jones?= <hailey@konnectglobalmarketing.com>
To: =?UTF-8?Q?=27linux-nvdimm=40lists=2E01=2Eorg=27?=
  <linux-nvdimm@lists.01.org>
Date: Thu, 28 May 2020 17:01:13 +0000
Mime-Version: 1.0
References: <mail.379118b9-b9ea-41c3-b94c-efdc6c1d3d0f@storage.wm.amazon.com>
 <mail.379118b9-b9ea-41c3-b94c-efdc6c1d3d0f@storage.wm.amazon.com>
X-Priority: 3 (Normal)
X-Mailer: Amazon WorkMail
Thread-Index: AdY1CTpZ5vLXIXUET/iXms6UWWzTwg==
Thread-Topic: RE: Proposal
Message-ID: <010101725c3b0cb3-61f69e3a-72c8-438c-ad01-5a71cacf7a85-000000@us-west-2.amazonses.com>
X-SES-Outgoing: 2020.05.28-54.240.27.228
Feedback-ID: 1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
Message-ID-Hash: FRU2HYWRG5FS6LIPFEK6MJ7WV4PL7HCP
X-Message-ID-Hash: FRU2HYWRG5FS6LIPFEK6MJ7WV4PL7HCP
X-MailFrom: 010101725c3b0cb3-61f69e3a-72c8-438c-ad01-5a71cacf7a85-000000@us-west-2.amazonses.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FRU2HYWRG5FS6LIPFEK6MJ7WV4PL7HCP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCg0KRGlkIHlvdSBnZXQgYSBjaGFuY2UgdG8gZ28gdGhyb3VnaCBteSBwcmV2aW91cyBl
bWFpbD8gDQoNCg0KS2luZGx5IGxldCBtZSBrbm93IHlvdXIgdGFyZ2V0IGF1ZGllbmNlIChTZWN0
b3JzLCBKb2IgVGl0bGVzICYgR2VvZ3JhcGh5KSB0aGF0IHlvdSB3aXNoIHRvIHRhcmdldCwgc28g
dGhhdCBJIGNhbiBnZXQgYmFjayB3aXRoIHRoZSBjb3VudHMsIHNhbXBsZXMgYW5kIHByaWNpbmcg
ZGV0YWlscyBmb3IgeW91ciByZXZpZXcuIA0KDQrCoA0KQXBwcmVjaWF0ZSB5b3VyIHJlc3BvbnNl
Lg0KDQrCoA0KVGhhbmtzLA0KDQpIYWlsZXkgSm9uZXMgLSBNYXJrZXRpbmcgRXhlY3V0aXZlDQoN
CsKgDQrCoA0KSGksDQoNCsKgDQpXb3VsZCB5b3UgbGlrZSB0byBjb25uZWN0IHdpdGgga2V5IGRl
Y2lzaW9uIG1ha2VycyBmcm9tIHRoZSBiZWxvdyBzZWN0b3JzOw0KDQrCoA0KTWFudWZhY3R1cmlu
ZywgQ29uc3RydWN0aW9uLCBFZHVjYXRpb24sIFJldGFpbCwgSGVhbHRoY2FyZSwgRW5lcmd5LCBV
dGlsaXRpZXMgJiBXYXN0ZSBUcmVhdG1lbnQsIFRyYW5zcG9ydGF0aW9uLCBCYW5raW5nICYgRmlu
YW5jZSwgTWVkaWEgJiBJbnRlcm5ldCwgSG9zcGl0YWxpdHksIGV0Yy4gDQoNCsKgDQpZb3UgY2Fu
IGNvbnRhY3QgdGhlbSB2aWEgZGlyZWN0wqBidXNpbmVzcyBlbWFpbHMgb3IgcGhvbmUgbnVtYmVy
c8KgZm9yIHlvdXIgc2FsZXMgYW5kIG1hcmtldGluZyBpbml0aWF0aXZlcy4gDQoNCsKgDQpXZSBj
YW4gYWxzbyBwcm92aWRlIHlvdSBjb250YWN0cyBmcm9tIGNvbXBhbmllcyBjdXJyZW50bHkgdXNp
bmcgQWx0aXVtDQoNClNvZnR3YXJlLg0KDQrCoA0KS2luZGx5IGxldCBtZSBrbm93IHRoZSBTZWN0
b3JzLCBKb2IgVGl0bGVzICYgR2VvZ3JhcGh5IHRoYXQgeW91IHdpc2ggdG8gdGFyZ2V0LCBzbyB0
aGF0IEkgY2FuIGdldCBiYWNrIHdpdGggdGhlIHNhbXBsZXMsIGNvdW50cyBhbmQgbW9yZSBkZXRh
aWxzIGZvciB5b3VyIHJldmlldy4gDQoNCsKgDQpMb29raW5nIGZvcndhcmQgdG8geW91ciByZXNw
b25zZS4NCg0KwqANClRoYW5rcywNCg0KSGFpbGV5IEpvbmVzIC0gTWFya2V0aW5nIEV4ZWN1dGl2
ZQ0KDQrCoA0KU3RheSBzYWZlLg0KDQpSZXBseSBiYWNrIOKAnFBhc3PigJ0gZm9yIG5vIGZ1cnRo
ZXIgZW1haWxzLg0KDQrCoA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMu
MDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZl
QGxpc3RzLjAxLm9yZwo=
