Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAB22C232F
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Nov 2020 11:45:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EAAC7100EB82C;
	Tue, 24 Nov 2020 02:45:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=106.12.154.80; helo=bhd2.sosung.com.cn; envelope-from=joha.zhu@ed.stahlcons.top; receiver=<UNKNOWN> 
Received: from bhd2.sosung.com.cn (bhd2.sosung.com.cn [106.12.154.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D76D7100EB82B
	for <linux-nvdimm@lists.01.org>; Tue, 24 Nov 2020 02:45:19 -0800 (PST)
Received: from edm01.bossedm.com (edm01.chinaemail.cn [180.76.132.54])
	by bhd2.sosung.com.cn (Postfix) with ESMTPS id E242E103897
	for <linux-nvdimm@lists.01.org>; Tue, 24 Nov 2020 17:35:24 +0800 (CST)
Received: from unknown (unknown [127.0.0.1])
	by edm01.bossedm.com (Bossedm) with SMTP id 16719121375
	for <linux-nvdimm@lists.01.org>; Tue, 24 Nov 2020 17:35:37 +0800 (CST)
Date: Tue, 24 Nov 2020 17:35:36 +0800 (CST)
From: "=?utf-8?B?WXVtaSA=?=" <yumi@hardfindtronics.com>
To: <linux-nvdimm@lists.01.org>
Subject: =?utf-8?B?UXVvdGUgR1JNMzFDUjYxRTEwNktBMTJMIE1VUkFUQSAwLjAyNnVzZCAgICA=?=
Mime-Version: 1.0
X-Notify-Mail: No
Message-ID: <2935#71508#linux-nvdimm@lists.01.org#b7685d8384c9a4ec01e29ab9bcfc16eb#1606210536884>
X-Iszbb: Yes
X-ZZY-MESSAGE-ID: FA202007B9585F33000000000000E9D3BC5F000000000000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ed.stahlcons.top;
	s=s9527; t=1606210537;
	bh=hbd5lH58Ulk5bK38mpnzY3HrNCSO64OMljykC8OO+JQ=;
	h=Date:From:Subject:Message-ID;
	b=lwhYqhrQ8poXcAsSbewTYwt2PfmXUF1W/qt4CitFc5Lybe/+s5fDC7G6p/PUOyex9
	 Cgr3W3O7PHQfztQ3fXtIt2UnkNMhZKNY6EvT2aDY58m+7yrZYg9akgR2tc4xCxe3tE
	 XTSqULw4rdtsGulkG5T4uIZPi+/xPK3ihn6SUj94=
Message-ID-Hash: MO7URMLOAJPXTXPHHKMQQTECSPYPQ4HL
X-Message-ID-Hash: MO7URMLOAJPXTXPHHKMQQTECSPYPQ4HL
X-MailFrom: joha.zhu@ed.stahlcons.top
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: yumi@hardfindtronics.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MO7URMLOAJPXTXPHHKMQQTECSPYPQ4HL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCg0KDQoNCg0KCQ0KCQkmbmJzcDsmbmJzcDtIYXJkJm5ic3A7RmluZCZuYnNwO0VsZWN0cm9u
aWNzIEx0ZC4gDQoJDQoJDQoJCSZuYnNwOyANCgkNCgkNCgkJRGVhciBGcmllbmQsIA0KCQ0KCQ0K
CQlUaGlzIGlzIFl1bWkgZnJvbSBIYXJkIEZpbmQgRWxlY3Ryb25pY3MgTHRkKHd3dy5oYXJkZmlu
ZGVsZWN0cm9uaWNzLmNvbSkmbmJzcDt3aGljaCBpcyBhIHByb2Zlc3Npb25hbCBlbGVjdHJvbmlj
cyBkaXN0cmlidXRvciB3aXRoIDEwIHllYXJzIG9mIGV4cGVyaWVuY2VzLiZuYnNwOw0KV2UgYXJl
IGdvb2QgYXQmbmJzcDtIYXJkIEZpbmQmbmJzcDtlbGVjdHJvbmljIGNvbXBvbmVudHPvvJoNCg0K
SUM6IE1heGltLCZuYnNwO0FELFhpbGlueCwgQWx0ZXJhLCBUSSwgTFQuLg0KTUxDQyBDYXBhY2l0
b3IgOiBNdXJhdGEsIFNhbXN1bmcsIFlhZ2VvLCBBVlgsIFRhaXlvLi4NCk1MQ0MgUmVzaXN0b3Im
bmJzcDs6IFlhZ2VvLFNhbXN1bmcsVW5pb2htLFdhbHNpbi4uLg0KRGlvZGUgJmFtcDtUcmFuc2lz
dG9yOiZuYnNwO1Zpc2hheSwgRGlvZGVzLE5YUCxPTixTVC4uDQoNCklmIHlvdSZuYnNwO25lZWQm
bmJzcDtzYW1wbGUsIHBscyBmZWVsIGZyZWUgdG8gY29udGFjdCBtZS4mbmJzcDsNClBscyBjaGVj
ayBvdXIgaG90Jm5ic3A7b2ZmZXIsIHdhaXQmbmJzcDtmb3IgeW91ciBraW5kbHkgUkZROiANCgkN
CgkNCgkJIA0KQ0FQIENFUiAxMFVGIDI1ViBYNVIgMDYwMyBHUk0xODhSNjFFMTA2TUE3M0QgNEsv
UiBNdXJhdGEgMjAyMCsgMC4wMzJ1c2QmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
IA0KQ0FQIENFUiAxMFVGIDI1ViBYNVIgMDYwMyBHUk0xODhSNjFFMTA2S0E3M0QgNEsvUiBNdXJh
dGEgMjAyMCsgMC4wMjkxdXNkICANCkNBUCBDRVIgMjJVRiAyNVYgWDVSIDA4MDUgR1JNMjFCUjYx
RTIyNk1FNDRMIDNLL1IgTXVyYXRhIDIwMjArIDAuMDN1c2QmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7IA0KQ0FQIENFUiAxMFVGIDUwViBYNVIgMTIwNiBHUk0zMUNSNjFI
MTA2S0ExMkwgMksgTVVSQVRBIDIwMjArIDAuMDN1c2QmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICANCkNBUCBDRVIgMTBVRiAyNVYgWDdSIDEyMDYgR1JNMzFDUjcxRTEw
NktBMTJMIDJLIE1VUkFUQSAyMDIwKyAwLjAyOHVzZCZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgIA0KQ0FQ
IENFUiAxMFVGIDI1ViBYNVIgMTIwNiBHUk0zMUNSNjFFMTA2S0ExMkwgMksgTVVSQVRBIDIwMjAr
IDAuMDI2dXNkJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7IA0KQ0FQIENFUiAxMFVGIDUwViBYN1IgMTIxMCBHUk0zMkVSNzFIMTA2S0ExMkwgMUsv
UiBNdXJhdGEgMjAyMCsgMC4wNzl1c2QNCg0KIA0KIA0KCQ0KCQ0KCQkgS2VlcCBzbWlsaW5nIGV2
ZXJ5IGRheSZuYnNwOygq77+jKe+/oykgDQoJDQoJDQoJCSZuYnNwOyANCgkNCgkNCgkJWXVtaSAN
CgkNCgkNCgkJQWNjb3VudCANCk1hbmFnZXIgIA0KCQ0KCQ0KCQlIYXJkIEZpbmQgRWxlY3Ryb25p
Y3MgTHRkLiANCgkNCgkNCgkJc291cmNpbmcgaGFyZCBmaW5kIGVsZWN0cm9uaWMgY29tcG9uZW50
cyANCgkNCgkNCgkJDQozMTUsIFNoYWhlIFJvZCwgTG9uZyBHYW5nIERpc3RyaWN0LCBTaGVuemhl
biwgQ04sIDUxODAwMA0KVGVsOiArODYtNzU1LTg0MTggODEwMyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAgDQoJDQoJDQoJ
CVNreXBlL0VtYWlsOiB5dW1pQGhhcmRmaW5kZWxlY3Ryb25pY3MuY29tIA0KCQ0KCQ0KCQlMaW5r
ZWRsbjogd3d3LmxpbmtlZGluLmNvbS9pbi95dW1pLWdhbyANCgkNCgkNCgkJRmFjZWJvb2s6IGZh
Y2Vib29rLmNvbS9ZdW1paGFyZGZpbmQgDQoJDQoJDQoJCVdlYjogaHR0cDovL3d3dy5oYXJkZmlu
ZGVsZWN0cm9uaWNzLmNvbS8gDQoJDQoJDQoJCSZuYnNwOyANCgkNCgkNCgkJDQpJZiB5b3UgZG9u
J3Qgd2FudCB0byByZWNlaXZlIHRoaXMgbWFpbCwgcGxzIHJldHVybiB3aXRoICJyZW1vdmUiIG9u
IHRoZSBzdWJqZWN0IGxpbmUuIA0KCQ0KCQ0KCQkmbmJzcDsgDQoJDQoNCg0KDQoNCgnmoaPpk7rn
vZHigJTigJTlnKjnur/mlofmoaPlhY3otLnlpITnkIYgDQrlpoLmnpzkvaDkuI3mg7Plho3mlLbl
iLDor6Xkuqflk4HnmoTmjqjojZDpgq7ku7bvvIzor7fngrnlh7vov5nph4zpgIDorqIKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1h
aWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNl
bmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
