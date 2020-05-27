Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8641E4BAE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 May 2020 19:17:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D4BC31211408C;
	Wed, 27 May 2020 10:12:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.240.27.218; helo=a27-218.smtp-out.us-west-2.amazonses.com; envelope-from=01010172572315ab-04f70da6-b52d-43d5-8abe-3efc2bae4984-000000@us-west-2.amazonses.com; receiver=<UNKNOWN> 
Received: from a27-218.smtp-out.us-west-2.amazonses.com (a27-218.smtp-out.us-west-2.amazonses.com [54.240.27.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1A60A1211408A
	for <linux-nvdimm@lists.01.org>; Wed, 27 May 2020 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=sknkt525wmvsd5qrslvt4aisaznnhvir; d=konnectglobalmarketing.com;
	t=1590599816;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id;
	bh=rxnNHOt91ytxmxcPgpragSzRru2YFJ9Fmr5Z6uuLCYI=;
	b=aWyW6G0xsHi8kRm/dqL0T3/QPvKUuJJXTs1b1wQPq4PYAR1HuU5kNWrI9m7eP/gK
	jFoQ9z4JRWZXzpZQVYIN5cGP2aJ6F43iQhn1fAod3dGdh3/fG9b64yQsiB1EuP1neEH
	qsDo1JNq/CKneQpAs4GSXRBMk7IpME75tSHQF6gE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1590599816;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id:Feedback-ID;
	bh=rxnNHOt91ytxmxcPgpragSzRru2YFJ9Fmr5Z6uuLCYI=;
	b=nUlwKV9i/uKsg8gbK/QmQkqqHevbhkGkckv/rDs4f56U4aBqjqCoPHp9rGGOpfsa
	P+UVuo9eT3PVnx+5H6fNY+uSKJD+RDD4iapY+OSZBcl2cLrQ0ASKcxlN5A0U3UzjEGB
	NFxmQQaZCccfKandQevkN4gVov16+aYHWgBAtl/g=
Subject: Proposal
From: =?UTF-8?Q?Hailey_Jones?= <hailey@konnectglobalmarketing.com>
To: =?UTF-8?Q?linux-nvdimm=40lists=2E01=2Eorg?= <linux-nvdimm@lists.01.org>
Date: Wed, 27 May 2020 17:16:56 +0000
Mime-Version: 1.0
References: <mail.a21a9fea-90d8-42f9-aa98-bc9f48247cbe@storage.wm.amazon.com>
 <mail.a21a9fea-90d8-42f9-aa98-bc9f48247cbe@storage.wm.amazon.com>
X-Priority: 3 (Normal)
X-Mailer: Amazon WorkMail
Thread-Index: AdY0R04E5QjDrLfvR2KMY4gnAXI2Yw==
Thread-Topic: Proposal
Message-ID: <01010172572315ab-04f70da6-b52d-43d5-8abe-3efc2bae4984-000000@us-west-2.amazonses.com>
X-SES-Outgoing: 2020.05.27-54.240.27.218
Feedback-ID: 1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
Message-ID-Hash: FHSWPGYEFNQ4JZGV5RHOF3HC2C4RFVXH
X-Message-ID-Hash: FHSWPGYEFNQ4JZGV5RHOF3HC2C4RFVXH
X-MailFrom: 01010172572315ab-04f70da6-b52d-43d5-8abe-3efc2bae4984-000000@us-west-2.amazonses.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FHSWPGYEFNQ4JZGV5RHOF3HC2C4RFVXH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCsKgDQpXb3VsZCB5b3UgbGlrZSB0byBjb25uZWN0IHdpdGgga2V5IGRlY2lzaW9uIG1h
a2VycyBmcm9tIHRoZSBiZWxvdyBzZWN0b3JzOw0KDQrCoA0KTWFudWZhY3R1cmluZywgQ29uc3Ry
dWN0aW9uLCBFZHVjYXRpb24sIFJldGFpbCwgSGVhbHRoY2FyZSwgRW5lcmd5LCBVdGlsaXRpZXMg
JiBXYXN0ZSBUcmVhdG1lbnQsIFRyYW5zcG9ydGF0aW9uLCBCYW5raW5nICYgRmluYW5jZSwgTWVk
aWEgJiBJbnRlcm5ldCwgSG9zcGl0YWxpdHksIGV0Yy4gDQoNCsKgDQpZb3UgY2FuIGNvbnRhY3Qg
dGhlbSB2aWEgZGlyZWN0wqBidXNpbmVzcyBlbWFpbHMgb3IgcGhvbmUgbnVtYmVyc8KgZm9yIHlv
dXIgc2FsZXMgYW5kIG1hcmtldGluZyBpbml0aWF0aXZlcy4gDQoNCsKgDQpXZSBjYW4gYWxzbyBw
cm92aWRlIHlvdSBjb250YWN0cyBmcm9tIGNvbXBhbmllcyBjdXJyZW50bHkgdXNpbmcgQWx0aXVt
DQoNClNvZnR3YXJlLg0KDQrCoA0KS2luZGx5IGxldCBtZSBrbm93IHRoZSBTZWN0b3JzLCBKb2Ig
VGl0bGVzICYgR2VvZ3JhcGh5IHRoYXQgeW91IHdpc2ggdG8gdGFyZ2V0LCBzbyB0aGF0IEkgY2Fu
IGdldCBiYWNrIHdpdGggdGhlIHNhbXBsZXMsIGNvdW50cyBhbmQgbW9yZSBkZXRhaWxzIGZvciB5
b3VyIHJldmlldy4gDQoNCsKgDQpMb29raW5nIGZvcndhcmQgdG8geW91ciByZXNwb25zZS4NCg0K
wqANClRoYW5rcywNCg0KSGFpbGV5IEpvbmVzIC0gTWFya2V0aW5nIEV4ZWN1dGl2ZQ0KDQrCoA0K
U3RheSBzYWZlLg0KDQpSZXBseSBiYWNrIOKAnFBhc3PigJ0gZm9yIG5vIGZ1cnRoZXIgZW1haWxz
Lg0KDQrCoA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRv
IHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAx
Lm9yZwo=
