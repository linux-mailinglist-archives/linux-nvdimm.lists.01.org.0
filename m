Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E00BA36069B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Apr 2021 12:08:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7EB96100EBB61;
	Thu, 15 Apr 2021 03:08:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.210.145.11; helo=co2.sosung.net; envelope-from=zhan.bixia@ysedm.com.cn; receiver=<UNKNOWN> 
Received: from co2.sosung.net (co2.sosung.net [192.210.145.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B61C6100ED484
	for <linux-nvdimm@lists.01.org>; Thu, 15 Apr 2021 03:07:59 -0700 (PDT)
Received: from edm01.bossedm.com (edm01.chinaemail.cn [180.76.132.54])
	by co2.sosung.net (Postfix) with ESMTPS id 3399F24E2596
	for <linux-nvdimm@lists.01.org>; Thu, 15 Apr 2021 06:07:57 -0400 (EDT)
Received: from unknown (unknown [127.0.0.1])
	by edm01.bossedm.com (Bossedm) with SMTP id 6B1F01213CA
	for <linux-nvdimm@lists.01.org>; Thu, 15 Apr 2021 18:07:53 +0800 (CST)
Date: Thu, 15 Apr 2021 18:07:53 +0800 (CST)
From: "=?utf-8?B?WXVtaSA=?=" <yumi@hardfindtronics.com>
To: <linux-nvdimm@lists.01.org>
Subject: =?utf-8?B?UmU6IElucXVpcnkgTWF4aW0gSUM=?=
Mime-Version: 1.0
X-Notify-Mail: No
Message-ID: <1858#78462#linux-nvdimm@lists.01.org#b7685d8384c9a4ec01e29ab9bcfc16eb#1618481273231>
X-Iszbb: Yes
X-ZZY-MESSAGE-ID: FA202007B958274100000000000079107860000000000300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ysedm.com.cn; s=s9527;
	t=1618481273; bh=YrcAlpV4aYM7TKzMbECrA8J3cKr7HJNzz1GsxYuUMd4=;
	h=Date:From:Subject:Message-ID;
	b=sNXpYUuo4U71tb3jbrYrN6gUZvoNhXnLRdKnoof+h3mLGLqpIG1gITPe7zkKm11xo
	 C/d96Zur7zR5iKFI4vgXjJTT9+eA2zlbiGPOVrc/W4HaI2jtcs2DF+L243rYJW/js9
	 zdYZWWBBGlU9gYisAqqUemMwk2QK4jq2Rh5WUM7U=
Message-ID-Hash: KEJMQ4SWUO6AZ6BNNT5UC6JW44AHQL2Q
X-Message-ID-Hash: KEJMQ4SWUO6AZ6BNNT5UC6JW44AHQL2Q
X-MailFrom: zhan.bixia@ysedm.com.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: yumi@hardfindtronics.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KEJMQ4SWUO6AZ6BNNT5UC6JW44AHQL2Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCg0KDQoNCg0KCQ0KCQkmbmJzcDsmbmJzcDtIYXJkJm5ic3A7RmluZCZuYnNwO0VsZWN0cm9u
aWNzIEx0ZC4gDQoJDQoJDQoJCSZuYnNwOyANCgkNCgkNCgkJRGVhciBGcmllbmQsIA0KCQ0KCQ0K
CQlHb29kJm5ic3A7ZGF5LCZuYnNwO2hvdyZuYnNwO2FyZSZuYnNwO3lvdT8mbmJzcDsNCldlIGFy
ZSBnb29kIGF0Jm5ic3A7SGFyZCBGaW5kJm5ic3A7ZWxlY3Ryb25pYyBjb21wb25lbnRz77yaDQoN
CklDOiBBRCxUSSwgTWF4aW0sWGlsaW54LCBBbHRlcmEsIExULi4NCk1MQ0MgQ2FwYWNpdG9yOiBN
dXJhdGEsIFNhbXN1bmcsIFlhZ2VvLCBBVlgsIFRhaXlvLi4NCk1MQ0MgUmVzaXN0b3I6Jm5ic3A7
WWFnZW8sU2Ftc3VuZyxVbmlvaG0sV2Fsc2luLi4uDQpEaW9kZSAmYW1wO1RyYW5zaXN0b3I6Jm5i
c3A7VmlzaGF5LCBEaW9kZXMsTlhQLE9OLFNULi4NCg0KSGVyZSBhcmUgc29tZSBvZiBvdXIgcmVm
ZXJlbmNlczombmJzcDsNCg0KTUFYMjAyRUVTRSsgTWF4aW0gMjAyMCsgMC4zOHVzZCANCk1BWDIz
MkVTRStUIE1heGltIDIwMTkrIDAuMzh1c2QgDQpNQVgzMDgyQ1NBK1QgTWF4aW0gMjAyMCsgMC43
NXVzZCANCk1BWDMxNjFFRUFHK1QgTWF4aW0gMjAyMCsgNS43MnVzZCANCk1BWDQwNjZBQ0VFK1Qg
TWF4aW0gMjAxOSsgMS45MDV1c2QgDQpNQVg3MDdDU0ErVCBNYXhpbSAyMDE5KyAwLjU1dXNkIA0K
TUFYNzIxOUNXRytUIE1heGltIDIwMTkrIDAuOTh1c2QgDQpNQVg5MTUyRVVFK1QgTWF4aW0gMjAx
OSsgMS4wNHVzZCANCiANCg0KV2UgY2FuIHN1cHBvcnQgeW91IDM2NWRheXMgd2FycmFudHkgYW5k
IGhlbHAgeW91IGZpbmQgb2Jzb2xldGUgcGFydHMgd2l0aCBnb29kIHByaWNlLiAoMXBjcyBvcmRl
cikmbmJzcDsgDQoJDQoJDQoJCQ0KCQ0KCQ0KCQkgS2VlcCBzbWlsaW5nIGV2ZXJ5IGRheSZuYnNw
Oygq77+jKe+/oykgDQoJDQoJDQoJCSZuYnNwOyANCgkNCgkNCgkJWXVtaSANCgkNCgkNCgkJQWNj
b3VudCANCk1hbmFnZXIgIA0KCQ0KCQ0KCQlIYXJkIEZpbmQgRWxlY3Ryb25pY3MgTHRkLiANCgkN
CgkNCgkJc291cmNpbmcgaGFyZCBmaW5kIGVsZWN0cm9uaWMgY29tcG9uZW50cyANCgkNCgkNCgkJ
DQozMTUsIFNoYWhlIFJvZCwgTG9uZyBHYW5nIERpc3RyaWN0LCBTaGVuemhlbiwgQ04sIDUxODAw
MA0KVGVsOiArODYtNzU1LTg0MTggODEwMyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAgDQoJDQoJDQoJCVNreXBlL0VtYWls
OiB5dW1pQGhhcmRmaW5kZWxlY3Ryb25pY3MuY29tIA0KCQ0KCQ0KCQlMaW5rZWRsbjogd3d3Lmxp
bmtlZGluLmNvbS9pbi95dW1pLWdhbyANCgkNCgkNCgkJRmFjZWJvb2s6IGZhY2Vib29rLmNvbS9Z
dW1paGFyZGZpbmQgDQoJDQoJDQoJCVdlYjogaHR0cDovL3d3dy5oYXJkZmluZGVsZWN0cm9uaWNz
LmNvbS8gDQoJDQoJDQoJCSZuYnNwOyANCgkNCgkNCgkJDQpJZiB5b3UgZG9uJ3Qgd2FudCB0byBy
ZWNlaXZlIHRoaXMgbWFpbCwgcGxzIHJldHVybiB3aXRoICJyZW1vdmUiIG9uIHRoZSBzdWJqZWN0
IGxpbmUuIA0KCQ0KCQ0KCQkmbmJzcDsgDQoJDQoNCg0KDQoNCgnmoaPpk7rnvZHigJTigJTlnKjn
ur/mlofmoaPlhY3otLnlpITnkIYgDQrlpoLmnpzkvaDkuI3mg7Plho3mlLbliLDor6Xkuqflk4Hn
moTmjqjojZDpgq7ku7bvvIzor7fngrnlh7vov5nph4zpgIDorqIKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAt
LSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwg
dG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
