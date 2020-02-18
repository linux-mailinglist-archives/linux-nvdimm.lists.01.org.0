Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D5D162A32
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 17:16:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A997F10FC33E6;
	Tue, 18 Feb 2020 08:19:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=106.12.150.83; helo=bhd3.sosung.net; envelope-from=raymond@adv.unimelbes.xyz; receiver=<UNKNOWN> 
Received: from bhd3.sosung.net (bhd3.sosung.net [106.12.150.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 769F210FC3398
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 08:19:25 -0800 (PST)
Received: from edm01.bossedm.com (edm01.chinaemail.cn [180.76.132.54])
	by bhd3.sosung.net (Postfix) with ESMTPS id AB2A8101E40
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 21:25:53 +0800 (CST)
Received: from unknown (unknown [127.0.0.1])
	by edm01.bossedm.com (Bossedm) with SMTP id BE1602E272D
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 20:43:33 +0800 (CST)
Date: Tue, 18 Feb 2020 20:43:33 +0800 (CST)
From: "=?utf-8?B?QmlsbGllIA==?=" <billie@onerivertronics.com>
To: <linux-nvdimm@lists.01.org>
Subject: =?utf-8?B?TmVlZCBHUk0xODhSNjBHMTA2TUU0N0QgLSAyMCAwMDAgcGNz?=
Mime-Version: 1.0
X-Notify-Mail: No
Message-ID: <1858#54479#linux-nvdimm@lists.01.org#e358f98847f1ee53ccc515b2fd0679bf#1582029813567>
X-Iszbb: Yes
X-ZZY-MESSAGE-ID: FA163E85126BBC2D000000000000F5DB4B5E000000000600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=adv.unimelbes.xyz;
	s=s9527; t=1582029813;
	bh=NPsvoxIV4ouozY6UEmrsWy87BK/bnk21q1SIBhS2qY4=;
	h=Date:From:Subject:Message-ID;
	b=0J4bb5XKlGnMfS92nWPGbCYOA1fVgnUBtaJTLeheIKdbriaIi9K5KaTxy2REp3HM1
	 bKTBB4kAZEioL+JekWckhGAAQrbe/kwl5K4scHPSiirsCPsR2C2pWi0c5GHHMKAZmr
	 KNnt97J7XzOiqO2JxhSe3ursbWiVNR3YDtR19lt4=
Message-ID-Hash: YS3QKZKJESOXBWFCDV26UOVJDYFBO5QM
X-Message-ID-Hash: YS3QKZKJESOXBWFCDV26UOVJDYFBO5QM
X-MailFrom: raymond@adv.unimelbes.xyz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: billie@onerivertronics.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YS3QKZKJESOXBWFCDV26UOVJDYFBO5QM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCg0KDQoNCg0KCQ0KCQkgDQoJDQoJDQoJCSANCgkNCgkNCgkJJm5ic3A7IA0KCQ0KCQ0KCQlI
ZWxsbyBkZWFyLCANCgkNCgkNCgkJJm5ic3A7IA0KCQ0KCQ0KCQlIb3cgYXJlIHlvdT8gDQoJDQoJ
DQoJCUkgYW0mbmJzcDtCaWxsaWUgZnJvbSBPbmUgUml2ZXIgRWxlY3Ryb25pYyBMaW1pdGVkIHdp
dGggb3ZlciAxMCB5ZWFyc+KAmSBleHBlcmllbmNl77yMY292ZXJpbmcgZ29vZCBxdWFsaXR5IGFu
ZCBPbmUteWVhci13YXJyYW50eSBlbGVjdHJvbmljIGNvbXBvbmVudHMuIA0KCQ0KCQ0KCQkmbmJz
cDsgDQoJDQoJDQoJCVBscyZuYnNwO2NoZWNrJm5ic3A7b3VyIGhvdCZuYnNwO29mZmVyIHRoaXMg
d2VlazoNCg0KUkMwNDAySlItMDczSzNMIDEwSy9SIFlBR0VPIDIwMTgrIDAuMDAwNHVzZCANClJD
MDQwMkpSLTA3M1IzTCAxMEsvUiBZQUdFTyAyMDE4KyAwLjAwMDR1c2QgDQpSQzA2MDNGUi0wNzEw
MFJMIDVLL1IgWUFHRU8gMjAxOCsgMC4wMDF1c2QgDQpSQzA4MDVKUi0wNzEwS0wgNUsvUiBZQUdF
TyAyMDE4KyAwLjAwMXVzZCANClJDMDgwNUpSLTA3MTBLTCA1Sy9SIFlBR0VPIDIwMTgrIDAuMDAx
dXNkIA0KUkMwODA1SlItMDcxMktMIDVLL1IgWUFHRU8gMjAxOCsgMC4wMDF1c2QgDQpSQzA4MDVK
Ui0wNzMzS0wgNUsvUiBZQUdFTyAyMDE4KyAwLjAwMXVzZCANClJDMDgwNUpSLTA3NEs3TCA1Sy9S
IFlBR0VPIDIwMTgrIDAuMDAxdXNkIA0KUkMwODA1SlItMDc0SzdMIDVLL1IgWUFHRU8gMjAxOCsg
MC4wMDF1c2QgDQpSQzEyMDZGUi0wNzRLM0wgNUsvUiBZQUdFTyAyMDE4KyAwLjAwMTR1c2QgDQpS
QzEyMDZKUi0wNzIyUkwgNUsvUiBZQUdFTyAyMDE4KyAwLjAwMTR1c2QNCg0KQ0wwNUExMDZNUDVO
VU5DIDEwSy9SIFNhbXN1bmcgMjAxOCsgMC4wMDg4dXNkIA0KQ0wxMEIxMDJLQzhOTk5DIDRLL1Ig
U2Ftc3VuZyAyMDE4KyAwLjAwNTl1c2QgDQpDTDEwQjEwM0tCOE5OTkMgNEsvUiBTYW1zdW5nIDIw
MTgrIDAuMDAyOXVzZCANCkNMMjFCMTA1S0JGTk5ORSAySy9SIFNhbXN1bmcgMjAxOCsgMC4wMTJ1
c2QgDQpDTDIxQjQ3NEtPRk5OTkcgM0svUiBTYW1zdW5nIDIwMTgrIDAuMDEwN3VzZCANCkNMMzFC
MTA2S09ITk5ORSAySy9SIFNhbXN1bmcgMjAxOCsgMC4wMzF1c2QgDQpDTDMyQTIyNktBSk5OTkUg
MUsvUiBTYW1zdW5nIDIwMTgrIDAuMDY0MXVzZA0KDQogDQoJDQoJDQoJCQ0KCQ0KCQ0KCQlXYWl0
IGZvciB5b3VyIGlucXVpcnkuDQpTaG9ydCBsZWFkIHRpbWUmYW1wO2dvb2QgcHJpY2U6IE1pY3Jv
Y2hpcCwgWGlsaW54LCBBbHRlcmEgQkdBIENQTEQsIGNhcGFjaXRvcnMmYW1wO3Jlc2lzdG9ycyhP
cmRlciBmcm9tIDEgcGNzLCAxIHllYXIgd2FycmFudHkpIA0KCQ0KCQ0KCQkmbmJzcDsgDQoJDQoJ
DQoJCUJlc3QgUmVnYXJkcw0KIA0KCQ0KCQ0KCQlCaWxsaWUgDQoJDQoJDQoJCVNhbGVzIG1hbmFn
ZXIgDQoJDQoJDQoJCU9uZSBSaXZlciBFbGVjdHJvbmljIExpbWl0ZWQNCm9uZSB5ZWFyIGd1YXJh
bnRlZWQgZWxlY3Ryb25pYyANCmRpc3RyaWJ1dG9yIA0KCQ0KCQ0KCQk4MjggTm9ydGgsIENlbnRl
ciwgTHVvSHUgRGlzdCwgU2hlbnpoZW4sIEd1YW5nZG9uZywgQ2hpbmEsIDUxODAwMCANCgkNCgkN
CgkJVGVsOiArODYtNzU1LTg0MTcgNTcwOQ0KU2t5cGUvRW1haWw6Jm5ic3A7YmlsbGllQG9uZXJp
dmVyaGsuY29tDQogDQoJDQoJDQoJCVdlYjpodHRwczovL3d3dy5vbmVyaXZlcmhrLmNvbSANCgkN
CgkNCgkJDQoJDQoJDQoJCQ0KCQ0KCQ0KCQlJZiB5b3UgZG9uJ3Qgd2FudCB0byByZWNlaXZlIHRo
aXMgbWFpbCwgcGxzIHJldHVybiB3aXRoICJyZW1vdmUiIG9uIHRoZSBzdWJqZWN0IGxpbmUgDQoJ
DQoNCg0KDQoNCgnmoaPpk7rnvZHigJTigJTlnKjnur/mlofmoaPlhY3otLnlpITnkIYgDQrlpoLm
npzkvaDkuI3mg7Plho3mlLbliLDor6Xkuqflk4HnmoTmjqjojZDpgq7ku7bvvIzor7fngrnlh7vo
v5nph4zpgIDorqIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3Jn
ClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3Rz
LjAxLm9yZwo=
