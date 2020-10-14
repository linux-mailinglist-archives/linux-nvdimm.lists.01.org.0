Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C9028DA6B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Oct 2020 09:23:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BEDBB159693A9;
	Wed, 14 Oct 2020 00:23:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.2.183.150; helo=mail150.suw14.mcdlv.net; envelope-from=bounce-mc.us2_146412474.3551972-e3616ba718@mail150.suw14.mcdlv.net; receiver=<UNKNOWN> 
Received: from mail150.suw14.mcdlv.net (mail150.suw14.mcdlv.net [198.2.183.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9D8BB159535C1
	for <linux-nvdimm@lists.01.org>; Wed, 14 Oct 2020 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailchimpapp.net;
	s=k2; t=1602660206; i=neomashreq=3Dgmail.com@mailchimpapp.net;
	bh=G1fz4aHgmeZDQqmsFzC47PgQB8UxlK6ZedZm2ISXOac=;
	h=Subject:From:Reply-To:To:Date:Message-ID:List-ID:List-Unsubscribe:
	 Content-Type:MIME-Version;
	b=jGrcoL9IZ/sdar3bUKDkd1GB8wp8GeX2AnMY9xbYTgxRgOQedzUvqp5uKqq51XXkb
	 zBflBtzRtbjLh3YWtJMWIf4g8ERW4XCU1z/N+g8n+J2RTyYtFOB6vDFnwMcS6iFkCZ
	 M/xFSld/ILEYiEabu3Ka1s9ldgWqdk2wiAjWBorIVCmZDX6+04DJcxMGsMsfL5IXcN
	 uLeTiroN2hpmG+HUj7towxomZ6Vv0456L/ohZD7z9YuTp4w9ONjSbLcefXSXIEDdSY
	 koBz1hLcDX8O4QEJumgrVGOqTyfGy5BOGDLGfB8Z5WvASei6RrU5hsxObVd2xXN0G2
	 JSJkTZwtS7QaA==
Received: from localhost (localhost [127.0.0.1])
	by mail150.suw14.mcdlv.net (Mailchimp) with ESMTP id 4CB3mZ3L8hz1DQZV
	for <linux-nvdimm@lists.01.org>; Wed, 14 Oct 2020 07:23:26 +0000 (GMT)
Subject: =?utf-8?Q?=D8=A3=D9=81=D8=B6=D9=84=20=D8=AA=D8=B7=D8=A8=D9=8A=D9=82=20=D9=85=D8=B5=D8=B1=D9=81=D9=8A=20=D9=81=D9=8A=20=D8=A7=D9=84=D8=A5=D9=85=D8=A7=D8=B1=D8=A7=D8=AA?=
From: =?utf-8?Q?=D9=85=D8=B4=D8=B1=D9=82=20=D9=86=D9=8A=D9=88?= <neomashreq@gmail.com>
To: <linux-nvdimm@lists.01.org>
Date: Wed, 14 Oct 2020 07:23:26 +0000
Message-ID: <2847aeac75bc1f80d89becc33.e3616ba718.20201014072323.9fd8b70ec9.4214bfce@mail150.suw14.mcdlv.net>
X-Mailer: MailChimp Mailer - **CID9fd8b70ec9e3616ba718**
X-Campaign: mailchimp2847aeac75bc1f80d89becc33.9fd8b70ec9
X-campaignid: mailchimp2847aeac75bc1f80d89becc33.9fd8b70ec9
X-Report-Abuse: Please report abuse for this campaign here: https://mailchimp.com/contact/abuse/?u=2847aeac75bc1f80d89becc33&id=9fd8b70ec9&e=e3616ba718
X-MC-User: 2847aeac75bc1f80d89becc33
Feedback-ID: 146412474:146412474.3551972:us2:mc
X-Accounttype: ff
X-Original-Sender: neomashreq@gmail.com
List-Unsubscribe-Post: List-Unsubscribe=One-Click
MIME-Version: 1.0
Message-ID-Hash: JZYOE6DR6N67LGYSZJPGYLSXDTM637R2
X-Message-ID-Hash: JZYOE6DR6N67LGYSZJPGYLSXDTM637R2
X-MailFrom: bounce-mc.us2_146412474.3551972-e3616ba718@mail150.suw14.mcdlv.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="utf-8"; format="fixed"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: neomashreq@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JZYOE6DR6N67LGYSZJPGYLSXDTM637R2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

2KPZgdi22YQg2KrYt9io2YrZgiDZhdi12LHZgdmKINmB2Yog2KfZhNil2YXYp9ix2KfYqi7CoNin
2K3YtdmEINi52YTZiSAxNTAg2K/YsdmH2YUg2YXZg9in2YHYo9ipINin2YTYp9mG2LbZhdin2YXC
oA0KDQrZh9mEINiq2KjYrdirINi52YYg2KPZgdi22YQg2KrYrNix2KjYqSDZhdi12LHZgdmK2Kkg
2YHZiiDYp9mE2KXZhdin2LHYp9iq2J8NCg0K2KXYsNinINmD2YbYqiDYqtio2K3YqyDYudmGINij
2YHYttmEINiq2KzYsdio2Kkg2YXYtdix2YHZitipINmB2YoNCtin2YTYpdmF2KfYsdin2Kog2KfZ
hNi52LHYqNmK2Kkg2KfZhNmF2KrYrdiv2Kkg2Iwg2YHYpdmGINio2K3Yq9mDINmK2YbYqtmH2Yog
2YfZhtinIQ0K2YXYtNix2YIg2YbZitmIINmH2Ygg2KjZhtmDINmE2LnYp9mE2YUg2KzYr9mK2K8g
2YTYp9mF2Lkg2YjZgtivINiq2YUg2KfZhNiq2LXZiNmK2KoNCti52YTZitmHINmD2YAgItmF2YbY
qtisINin2YTYudin2YUiINmB2Yog2LnYp9mFIDIwMTkg2YHZig0K2KzZhdmK2Lkg2KPZhtit2KfY
oSDYp9mE2K7ZhNmK2KwuINi52YYg2LfYsdmK2YIg2KrZhtiy2YrZhCBOZW8g2IwNCtmE2YYg2KrY
rdi12YQg2LnZhNmJINiq2LfYqNmK2YIg2KjYr9mK2YfZiiDZiNi02K7YtdmKINmB2K3Ys9ioINiM
DQrYqNmEINiq2K3YtdmEINi52YTZiSDYqNmG2YMg2YPYp9mF2YQg2KjZitmGINmK2K/ZitmDLg0K
DQrYp9it2LXZhCDYudmE2YkgMTUwINiv2LHZh9mFINmF2YPYp9mB2KPYqSDYudmG2K8g2KfZhNin
2YbYttmF2KfZhQ0KDQrYrNix2Kgg2KfZhNii2YYgKGh0dHBzOi8vZnlzbmV0d29yay51czIubGlz
dC1tYW5hZ2UuY29tL3RyYWNrL2NsaWNrP3U9Mjg0N2FlYWM3NWJjMWY4MGQ4OWJlY2MzMyZpZD1m
MzYzN2ZiZGZhJmU9ZTM2MTZiYTcxOCkNCg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQoNClRoaXMgZW1haWwgd2FzIHNlbnQgdG8g
bGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZyAobWFpbHRvOmxpbnV4LW52ZGltbUBsaXN0cy4wMS5v
cmcpDQp3aHkgZGlkIEkgZ2V0IHRoaXM/IChodHRwczovL2Z5c25ldHdvcmsudXMyLmxpc3QtbWFu
YWdlLmNvbS9hYm91dD91PTI4NDdhZWFjNzViYzFmODBkODliZWNjMzMmaWQ9MDFhZjVkZTU2NCZl
PWUzNjE2YmE3MTgmYz05ZmQ4YjcwZWM5KSAgICAgdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Qg
KGh0dHBzOi8vZnlzbmV0d29yay51czIubGlzdC1tYW5hZ2UuY29tL3Vuc3Vic2NyaWJlP3U9Mjg0
N2FlYWM3NWJjMWY4MGQ4OWJlY2MzMyZpZD0wMWFmNWRlNTY0JmU9ZTM2MTZiYTcxOCZjPTlmZDhi
NzBlYzkpICAgICB1cGRhdGUgc3Vic2NyaXB0aW9uIHByZWZlcmVuY2VzIChodHRwczovL2Z5c25l
dHdvcmsudXMyLmxpc3QtbWFuYWdlLmNvbS9wcm9maWxlP3U9Mjg0N2FlYWM3NWJjMWY4MGQ4OWJl
Y2MzMyZpZD0wMWFmNWRlNTY0JmU9ZTM2MTZiYTcxOCkNCkZZUyBOZXR3b3JrIC4gNTYyIFNoYW50
aW5pdmFzIEdhbGksIEJpbGluYWthIC4gQmlsaW1vcmEgMzk2MzIxIC4gSW5kaWENCg0KRW1haWwg
TWFya2V0aW5nIFBvd2VyZWQgYnkgTWFpbGNoaW1wDQpodHRwOi8vd3d3Lm1haWxjaGltcC5jb20v
ZW1haWwtcmVmZXJyYWwvP3V0bV9zb3VyY2U9ZnJlZW1pdW1fbmV3c2xldHRlciZ1dG1fbWVkaXVt
PWVtYWlsJnV0bV9jYW1wYWlnbj1yZWZlcnJhbF9tYXJrZXRpbmcmYWlkPTI4NDdhZWFjNzViYzFm
ODBkODliZWNjMzMmYWZsPTEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMu
MDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZl
QGxpc3RzLjAxLm9yZwo=
