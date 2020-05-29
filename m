Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9781E8654
	for <lists+linux-nvdimm@lfdr.de>; Fri, 29 May 2020 20:09:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A389011541CB4;
	Fri, 29 May 2020 11:05:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.240.27.232; helo=a27-232.smtp-out.us-west-2.amazonses.com; envelope-from=0101017261a02c47-90151aa2-e37c-41f8-9767-689b4427e7bc-000000@us-west-2.amazonses.com; receiver=<UNKNOWN> 
Received: from a27-232.smtp-out.us-west-2.amazonses.com (a27-232.smtp-out.us-west-2.amazonses.com [54.240.27.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C53C611541CB3
	for <linux-nvdimm@lists.01.org>; Fri, 29 May 2020 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=sknkt525wmvsd5qrslvt4aisaznnhvir; d=konnectglobalmarketing.com;
	t=1590775786;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id;
	bh=QZuxwO7fomGQuBLLpAvcxklZaKCRxAjW7vP5PrG8qow=;
	b=AuMveYrdSykKcS3INnwOO232Ia5JUcoMfHwQyTkzF1ia0EHnzf0O+k8ADJuyj62Y
	tIbtopwZzm+TBl779/KNLA1sVdws1vv0BLEIIeCLaoqXEWEVN3+iuuZDJtsfuwWXkhS
	IOdIXMnWNhn/DW28Xn4hH9YFJ4b96kuwtyhvtw3A=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1590775786;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id:Feedback-ID;
	bh=QZuxwO7fomGQuBLLpAvcxklZaKCRxAjW7vP5PrG8qow=;
	b=V/dy0iAMNqfF/G9N8nok4hP077zf3U8avFNgX47N2gKV8yq8tmRgt1BbU2+3gGv0
	nO74er/WnGcQvyutbg0YOttKu3a2LIuCOgYdH2AS1gYcLJ7hFTb//eNvGJDy2NTiSuI
	qN39XmP30ZfEFZa9lgFe0h6BP8erl+abblBMVmBk=
Subject: Re: Proposal
From: =?UTF-8?Q?Hailey_Jones?= <hailey@konnectglobalmarketing.com>
To: =?UTF-8?Q?=27linux-nvdimm=40lists=2E01=2Eorg=27?=
  <linux-nvdimm@lists.01.org>
Date: Fri, 29 May 2020 18:09:46 +0000
Mime-Version: 1.0
References: <mail.b34a3921-f41b-4b8c-bbcd-1db213943a00@storage.wm.amazon.com>
 <mail.b34a3921-f41b-4b8c-bbcd-1db213943a00@storage.wm.amazon.com>
X-Priority: 3 (Normal)
X-Mailer: Amazon WorkMail
Thread-Index: AdY14vTAOstbjzpGTyqdyDmvSX4/NQ==
Thread-Topic: Re: Proposal
Message-ID: <0101017261a02c47-90151aa2-e37c-41f8-9767-689b4427e7bc-000000@us-west-2.amazonses.com>
X-SES-Outgoing: 2020.05.29-54.240.27.232
Feedback-ID: 1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
Message-ID-Hash: ZOCNN3EN2SUIBXNE4GVKCUS2RMSHMN2X
X-Message-ID-Hash: ZOCNN3EN2SUIBXNE4GVKCUS2RMSHMN2X
X-MailFrom: 0101017261a02c47-90151aa2-e37c-41f8-9767-689b4427e7bc-000000@us-west-2.amazonses.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZOCNN3EN2SUIBXNE4GVKCUS2RMSHMN2X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCsKgDQpJIGhhdmUgYmVlbiB0cnlpbmcgdG8gZ2V0IGluIHRvdWNoIHdpdGggeW91IHRv
IHNlZSBpZiB0aGVyZSBpcyBhIG11dHVhbCBmaXQgYmV0d2VlbiBvdXIgY29tcGFueeKAmXMgZXhw
ZXJ0aXNlIGFuZCB5b3VyIGdvYWxzIGFyb3VuZC4NCg0KwqANClBsZWFzZSByZXZpZXcgbXkgcHJl
dmlvdXMgZW1haWxzIGFuZCBsZXQgbWUga25vdyB5b3VyIHRob3VnaHRzLg0KDQrCoA0KQXdhaXQg
eW91ciByZXNwb25zZS4NCg0KwqANClRoYW5rcywNCg0KSGFpbGV5IEpvbmVzIC0gTWFya2V0aW5n
IEV4ZWN1dGl2ZQ0KDQrCoA0KwqANCkhpLA0KDQoNCkRpZCB5b3UgZ2V0IGEgY2hhbmNlIHRvIGdv
IHRocm91Z2ggbXkgcHJldmlvdXMgZW1haWw/IA0KDQoNCktpbmRseSBsZXQgbWUga25vdyB5b3Vy
IHRhcmdldCBhdWRpZW5jZSAoU2VjdG9ycywgSm9iIFRpdGxlcyAmIEdlb2dyYXBoeSkgdGhhdCB5
b3Ugd2lzaCB0byB0YXJnZXQsIHNvIHRoYXQgSSBjYW4gZ2V0IGJhY2sgd2l0aCB0aGUgY291bnRz
LCBzYW1wbGVzIGFuZCBwcmljaW5nIGRldGFpbHMgZm9yIHlvdXIgcmV2aWV3LiANCg0KwqANCkFw
cHJlY2lhdGUgeW91ciByZXNwb25zZS4NCg0KwqANClRoYW5rcywNCg0KSGFpbGV5IEpvbmVzIC0g
TWFya2V0aW5nIEV4ZWN1dGl2ZQ0KDQrCoA0KwqANCkhpLA0KDQrCoA0KV291bGQgeW91IGxpa2Ug
dG8gY29ubmVjdCB3aXRoIGtleSBkZWNpc2lvbiBtYWtlcnMgZnJvbSB0aGUgYmVsb3cgc2VjdG9y
czsNCg0KwqANCk1hbnVmYWN0dXJpbmcsIENvbnN0cnVjdGlvbiwgRWR1Y2F0aW9uLCBSZXRhaWws
IEhlYWx0aGNhcmUsIEVuZXJneSwgVXRpbGl0aWVzICYgV2FzdGUgVHJlYXRtZW50LCBUcmFuc3Bv
cnRhdGlvbiwgQmFua2luZyAmIEZpbmFuY2UsIE1lZGlhICYgSW50ZXJuZXQsIEhvc3BpdGFsaXR5
LCBldGMuIA0KDQrCoA0KWW91IGNhbiBjb250YWN0IHRoZW0gdmlhIGRpcmVjdMKgYnVzaW5lc3Mg
ZW1haWxzIG9yIHBob25lIG51bWJlcnPCoGZvciB5b3VyIHNhbGVzIGFuZCBtYXJrZXRpbmcgaW5p
dGlhdGl2ZXMuIA0KDQrCoA0KV2UgY2FuIGFsc28gcHJvdmlkZSB5b3UgY29udGFjdHMgZnJvbSBj
b21wYW5pZXMgY3VycmVudGx5IHVzaW5nIEFsdGl1bQ0KDQpTb2Z0d2FyZS4NCg0KwqANCktpbmRs
eSBsZXQgbWUga25vdyB0aGUgU2VjdG9ycywgSm9iIFRpdGxlcyAmIEdlb2dyYXBoeSB0aGF0IHlv
dSB3aXNoIHRvIHRhcmdldCwgc28gdGhhdCBJIGNhbiBnZXQgYmFjayB3aXRoIHRoZSBzYW1wbGVz
LCBjb3VudHMgYW5kIG1vcmUgZGV0YWlscyBmb3IgeW91ciByZXZpZXcuIA0KDQrCoA0KTG9va2lu
ZyBmb3J3YXJkIHRvIHlvdXIgcmVzcG9uc2UuDQoNCsKgDQpUaGFua3MsDQoNCkhhaWxleSBKb25l
cyAtIE1hcmtldGluZyBFeGVjdXRpdmUNCg0KwqANClN0YXkgc2FmZS4NCg0KUmVwbHkgYmFjayDi
gJxQYXNz4oCdIGZvciBubyBmdXJ0aGVyIGVtYWlscy4NCg0KwqANCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3Qg
LS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWls
IHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
