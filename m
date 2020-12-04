Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0342E2CEEC7
	for <lists+linux-nvdimm@lfdr.de>; Fri,  4 Dec 2020 14:28:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 36E13100EBBB0;
	Fri,  4 Dec 2020 05:28:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=184.150.200.208; helo=torfep01.bell.net; envelope-from=dave.anglin@bell.net; receiver=<UNKNOWN> 
Received: from torfep01.bell.net (simcoe208srvr.owm.bell.net [184.150.200.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D38D1100EC1E9
	for <linux-nvdimm@lists.01.org>; Fri,  4 Dec 2020 05:28:48 -0800 (PST)
Received: from bell.net torfep01 184.150.200.158 by torfep01.bell.net
          with ESMTP
          id <20201204132847.RSVU6892.torfep01.bell.net@torspm01.bell.net>
          for <linux-nvdimm@lists.01.org>; Fri, 4 Dec 2020 08:28:47 -0500
Received: from [192.168.2.49] (really [67.70.16.145]) by torspm01.bell.net
          with ESMTP
          id <20201204132847.HJEQ29322.torspm01.bell.net@[192.168.2.49]>;
          Fri, 4 Dec 2020 08:28:47 -0500
Subject: Re: PATCH] fs/dax: fix compile problem on parisc and mips
To: Matthew Wilcox <willy@infradead.org>, Helge Deller <deller@gmx.de>
References: <fb91b40d258414b0fdce2c380752e48daa6a70d6.camel@HansenPartnership.com>
 <20201204034843.GM11935@casper.infradead.org>
 <0f0ac7be-0108-0648-a4db-2f37db1c8114@gmx.de>
 <20201204124402.GN11935@casper.infradead.org>
From: John David Anglin <dave.anglin@bell.net>
Message-ID: <3648e8d5-be75-ea2e-ddbc-5117fcd50a2b@bell.net>
Date: Fri, 4 Dec 2020 08:28:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201204124402.GN11935@casper.infradead.org>
Content-Language: en-US
X-CM-Analysis: v=2.3 cv=ZryT1OzG c=1 sm=1 tr=0 a=ch4VMz8uGZlcRCFa+4Q1bQ==:117 a=ch4VMz8uGZlcRCFa+4Q1bQ==:17 a=IkcTkHD0fZMA:10 a=zTNgK-yGK50A:10 a=FBHGMhGWAAAA:8 a=ybeIS4x6i_o_-C6kCnkA:9 a=QEXdDO2ut3YA:10 a=9gvnlMMaQFpL9xblJ6ne:22
X-CM-Envelope: MS4wfKtNUfRu/DXyTZPn7Pfd4YNoPaiTiBDkNP5Ayf+Vk7AF/O6TOTxeU/Kkq3dDtqHlLw5SfwdBEGtzfi1ydnG/NlGna3I0WQGkBu/HR1Z1quyVYE9sP7uO HQSDprhtoujUIJ04X3Zp7eyhuU9uU91potCJmweuMP68b8eNRUyG4pIPiRm7+33WSHQF3p2U3EkKXQ==
Message-ID-Hash: D3WTW3VVK7MYXSRFTP66RGCHSBVKAUCR
X-Message-ID-Hash: D3WTW3VVK7MYXSRFTP66RGCHSBVKAUCR
X-MailFrom: dave.anglin@bell.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: James Bottomley <James.Bottomley@hansenpartnership.com>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D3WTW3VVK7MYXSRFTP66RGCHSBVKAUCR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gMjAyMC0xMi0wNCA3OjQ0IGEubS4sIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPiBZb3UnbGwN
Cj4gc3RpbGwgbmVlZCB0byBhbGxvY2F0ZSB0aGVtIHNlcGFyYXRlbHkgaWYgdmFyaW91cyBkZWJ1
Z2dpbmcgb3B0aW9ucw0KPiBhcmUgZW5hYmxlZCAoc2VlIHRoZSBBTExPQ19TUExJVF9QVExPQ0tT
IGZvciBkZXRhaWxzKSwgYnV0IHVzdWFsbHkNCj4gdGhpcyB3aWxsIHNhdmUgeW91IGEgbG90IG9m
IG1lbW9yeS4NCldlIG5lZWQgYWxsIHdlIGNhbiBnZXQ6DQooLm1sb2NhdGUpOiBwYWdlIGFsbG9j
YXRpb24gZmFpbHVyZTogb3JkZXI6NSwgbW9kZToweDQwY2MwKEdGUF9LRVJORUx8X19HRlBfQ09N
UCksIG5vZGVtYXNrPShudWxsKSxjcHVzZXQ9LyxtZW1zX2FsbG93ZWQ9MA0KQ1BVOiAyIFBJRDog
MjgyNzEgQ29tbTogKC5tbG9jYXRlKSBOb3QgdGFpbnRlZCA1LjkuMTErICMxDQpIYXJkd2FyZSBu
YW1lOiA5MDAwLzgwMC9ycDM0NDANCkJhY2t0cmFjZToNCsKgWzwwMDAwMDAwMDQwMThkMDUwPl0g
c2hvd19zdGFjaysweDUwLzB4NzANCsKgWzwwMDAwMDAwMDQwODI2MzU0Pl0gZHVtcF9zdGFjaysw
eGJjLzB4MTMwDQrCoFs8MDAwMDAwMDA0MDMzZGMxND5dIHdhcm5fYWxsb2MrMHgxNDQvMHgxZTAN
CsKgWzwwMDAwMDAwMDQwMzNlOTMwPl0gX19hbGxvY19wYWdlc19zbG93cGF0aC5jb25zdHByb3Au
MCsweGM4MC8weGNmOA0KwqBbPDAwMDAwMDAwNDAzM2VjNDg+XSBfX2FsbG9jX3BhZ2VzX25vZGVt
YXNrKzB4MmEwLzB4MmYwDQrCoFs8MDAwMDAwMDA0MDM1MWEyYz5dIGNhY2hlX2FsbG9jX3JlZmls
bCsweDZiNC8weGU1MA0KwqBbPDAwMDAwMDAwNDAzNTQxNmM+XSBfX2ttYWxsb2MrMHg1ZTQvMHg3
NDANCsKgWzwwMDAwMDAwMDA0MGRkYmU4Pl0gbmZzZF9yZXBseV9jYWNoZV9pbml0KzB4MWQwLzB4
MzYwIFtuZnNkXQ0KwqBbPDAwMDAwMDAwMDQwZDExMTg+XSBuZnNkX2luaXRfbmV0KzB4YjAvMHgx
YzAgW25mc2RdDQrCoFs8MDAwMDAwMDA0MDZhNTg2MD5dIG9wc19pbml0KzB4NjgvMHgxNzgNCsKg
WzwwMDAwMDAwMDQwNmE1YjI0Pl0gc2V0dXBfbmV0KzB4MWI0LzB4MzQ4DQrCoFs8MDAwMDAwMDA0
MDZhNmUyMD5dIGNvcHlfbmV0X25zKzB4MWYwLzB4NDUwDQrCoFs8MDAwMDAwMDA0MDFlNjU3OD5d
IGNyZWF0ZV9uZXdfbmFtZXNwYWNlcysweDFiMC8weDQxOA0KwqBbPDAwMDAwMDAwNDAxZTcyYWM+
XSB1bnNoYXJlX25zcHJveHlfbmFtZXNwYWNlcysweDhjLzB4ZjANCsKgWzwwMDAwMDAwMDQwMWI2
YWNjPl0ga3N5c191bnNoYXJlKzB4MWJjLzB4NDQwDQrCoFs8MDAwMDAwMDA0MDFiNmQ3MD5dIHN5
c191bnNoYXJlKzB4MjAvMHgzOA0KwqBbPDAwMDAwMDAwNDAxODgwMTg+XSBzeXNjYWxsX2V4aXQr
MHgwLzB4MTQNCg0KTWVtLUluZm86DQphY3RpdmVfYW5vbjoxMjA5OTU3IGluYWN0aXZlX2Fub246
NDM4MTcxIGlzb2xhdGVkX2Fub246MA0KwqBhY3RpdmVfZmlsZTozODk3MSBpbmFjdGl2ZV9maWxl
OjIxNzQxIGlzb2xhdGVkX2ZpbGU6MA0KwqB1bmV2aWN0YWJsZTo0NjYyIGRpcnR5OjE0NCB3cml0
ZWJhY2s6MA0KwqBzbGFiX3JlY2xhaW1hYmxlOjQ1NzQ4IHNsYWJfdW5yZWNsYWltYWJsZTo1MTU0
OA0KwqBtYXBwZWQ6MzQ5NDAgc2htZW06MTQ3MTg1OSBwYWdldGFibGVzOjU0MjkgYm91bmNlOjAN
CsKgZnJlZToyMTM2NzYgZnJlZV9wY3A6MzE3IGZyZWVfY21hOjANCk5vZGUgMCBhY3RpdmVfYW5v
bjo0ODM5ODI4a0IgaW5hY3RpdmVfYW5vbjoxNzUzMjAwa0IgYWN0aXZlX2ZpbGU6MTU1ODg0a0Ig
aW5hY3RpdmVfZmlsZTo4Njk2NGtCIHVuZXZpY3RhYmxlOjE4NjQ4a0IgaXNvbGF0ZWQoYW5vbik6
MGtCDQppc29sYXRlZChmaWxlKTowa0IgbWFwcGVkOjEzOTc2MGtCIGRpcnR5OjU3NmtCIHdyaXRl
YmFjazowa0Igc2htZW06NTg4NzQzNmtCIHdyaXRlYmFja190bXA6MGtCIGtlcm5lbF9zdGFjazo2
MDMya0IgYWxsX3VucmVjbGFpbWFibGU/IG5vDQpOb3JtYWwgZnJlZTo4NTM5NDhrQiBtaW46MTE0
NDhrQiBsb3c6MTk2MzZrQiBoaWdoOjI3ODI0a0IgcmVzZXJ2ZWRfaGlnaGF0b21pYzowS0IgYWN0
aXZlX2Fub246NDgzOTgyOGtCIGluYWN0aXZlX2Fub246MTc1MzU0NGtCDQphY3RpdmVfZmlsZTox
NTU4ODRrQiBpbmFjdGl2ZV9maWxlOjg2OTY0a0IgdW5ldmljdGFibGU6MTg2NDhrQiB3cml0ZXBl
bmRpbmc6NTc2a0IgcHJlc2VudDo4Mzg2NTYwa0IgbWFuYWdlZDo4MjExNzU2a0IgbWxvY2tlZDox
ODY0OGtCDQpwYWdldGFibGVzOjIxNzE2a0IgYm91bmNlOjBrQiBmcmVlX3BjcDoxMTY4a0IgbG9j
YWxfcGNwOjM1MmtCIGZyZWVfY21hOjBrQg0KbG93bWVtX3Jlc2VydmVbXTogMCAwDQpOb3JtYWw6
IDU4ODYwKjRrQiAoVU1FKSA0ODE1NSo4a0IgKFVNRSkgMTE0MTQqMTZrQiAoVU1FKSAxMjkxKjMy
a0IgKFVNRSkgMTM0KjY0a0IgKFVNRSkgMCoxMjhrQiAwKjI1NmtCIDAqNTEya0IgMCoxMDI0a0Ig
MCoyMDQ4a0IgMCo0MDk2a0IgPQ0KODUzMTkya0INCjE2MDc3MTcgdG90YWwgcGFnZWNhY2hlIHBh
Z2VzDQo3MzgyMiBwYWdlcyBpbiBzd2FwIGNhY2hlDQpTd2FwIGNhY2hlIHN0YXRzOiBhZGQgMjEy
NTI0NTQsIGRlbGV0ZSAyMTE3ODA4MywgZmluZCA1NzAyNzIzLzY4MTU0OTgNCkZyZWUgc3dhcMKg
ID0gMzM3NDI2NTJrQg0KVG90YWwgc3dhcCA9IDQ5NzU4NjUya0INCjIwOTY2NDAgcGFnZXMgUkFN
DQowIHBhZ2VzIEhpZ2hNZW0vTW92YWJsZU9ubHkNCjQzNzAxIHBhZ2VzIHJlc2VydmVkDQoNCkNo
ZWVycywNCkRhdmUNCg0KLS0gDQpKb2huIERhdmlkIEFuZ2xpbiAgZGF2ZS5hbmdsaW5AYmVsbC5u
ZXQNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1
YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
