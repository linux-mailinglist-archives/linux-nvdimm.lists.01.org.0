Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF12D202CF0
	for <lists+linux-nvdimm@lfdr.de>; Sun, 21 Jun 2020 23:23:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3657D10FCBAA8;
	Sun, 21 Jun 2020 14:23:22 -0700 (PDT)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=74.6.129.124; helo=sonic309-14.consmr.mail.bf2.yahoo.com; envelope-from=brunelminaa@gmail.com; receiver=<UNKNOWN> 
Received: from sonic309-14.consmr.mail.bf2.yahoo.com (sonic309-14.consmr.mail.bf2.yahoo.com [74.6.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 315B610FC4F6F
	for <linux-nvdimm@lists.01.org>; Sun, 21 Jun 2020 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592774598; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=b1bO6upbLw7Dl678ahO0IAnYfB01qk6otXyMAOxkubjT1OzxHhTHVThGbNCbtCpauTw9J09gS37K2qOjslsYG7O9Wa8LClemOTllyVH3XLHl8wu4n68uwvEBwSnBKXSKznpbHclJZC+QK90nc/Vfnianf39qehKw74GhkIPuaXOFzyUtZGLwOjn3z8PsYiglEbfPPqVi/DQ+pIET7brq2PE8eBmK/vwrdfC1vIQbf/AdVCRAztonnBNO3C/4TuVSWegEuxdWXscK2pLORgm9sDJVBvVrkpEpujw1fdKLoy9Cc2Al5eDurGbB0A0wz9gzq9AV9BUsY0TIDgd9PvsKLw==
X-YMail-OSG: qLZ17fYVM1kegKZ3M8MD2EdER1lxBm4YPwn1r8cGzb2gnMI2Dcd4bNyBj3uEKH6
 oUCUhaCQLGneb.kvGBUfzefXHvuzFguIDzN7_0.ANv3N64ns6pEY9AfEO9D.ruKoz7pxTwee9XVL
 e_gFQsTylsAPFVLJHYwwUGUk8qFuVEU.A7M74n5bivfXKTKBjS1AGeSIhJf6VwtP4VCrywUampNV
 T3iNZLB3GqvraTC4ZBUoQWdaE93D_m5HlANnu0Z45bv7AzQ2xtSG6D1uD..0aLlZF63usr0XG7LL
 eSTYtvhg4gZTbG7v3wusznoedAGu6uSOcowIcAraiaBS3VDLrbxYDYCNjJ0QidU_CXG4yy.FrWqY
 Se2hqMSU1WU_2ZWmMOvk9uO4GQlG1x6C04QGqpACORDPh43zBt69.lLJLpbrUIoRDIW_nfmnoPY7
 6_aKvg69uEVCcMdH7AINbAS8kFUP.udrC.r1FbMgQyb.jOMDVAOuYOFOLgGO6UL0Lplw8UokHgh3
 QejI7ESQrqwN6MC_Wm_vZE_j9nfDPvY96R3MUwxepXEgcplJHqthKIAPEgBIvFbyJWcDS7ASjai1
 nRSjXmuPk2mLycPPw8OxKe0qEP7j_LZYDUX7kXWDS.uwUetG0f9MBu2fENmjPw4SK_jlxzkhuZzV
 FX4fgtNqMxC._xTs6QBy5S4y_SvpTIVbXih_QC9pBW96Xp7xa81EEjWQLuFnWmr5JdVmXqVvCZWN
 eIrEQlCZOegxsFNCzKLPG8ihE83DJWUnU5aBiDOR73Aux8x3WX88vj4XctaqqdEuMC3o92VpTMe1
 E2ZRiRcOmV0xIhnmING5qzvWGhQiUZZwG.Jo4RNXAa95bLvDfgXSsquf2AtdFOnZVi_DdnS3BPtV
 Nr6AxHRkJctDcGQp3mPrk1cgyUYN2UJlSkfuESksJjqKNiyJv6Yo8isGj6rfuy4aQ_8zn1nKdusM
 VfYxceuVgwv9_P517TbvWrlxofuJDCrd0L6CYtfYzSHPItyB9hVE_xCFfePoHYDsAQLOziaLqw9n
 1znRmIaYF0sWfhXyL7q3emSP8ncHCDaTFD6zbOFnGLxVUdKD.UHVpQsQZ5eKkjVQYlbtdyyrnVCE
 7cZNuIgvBbrKyAm.un6gLysZPUpgQdCISj6M1WtHcD3WhxVS9kYcOwtI1QTd1RrVFkq7gvBc1UUz
 ZiQkyhRPfgRfa.RcjKgrhYaET2J3VlOiB8psKgoXoM67UzJT_FpeHJvIkXZVPp1FiRjUOOiZ3ecQ
 yD5eQqeCqWxApNcdgG9ytgVz8yAiueDKYETFIt7_jvIH6bBgdFJ20q1pHYF6wMRSolxQqkL6ZsG6
 QYKADKWlwtQm_dWIpEZoWv5H5er6daEg_RKiWixc_4fY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Sun, 21 Jun 2020 21:23:18 +0000
Date: Sun, 21 Jun 2020 21:23:15 +0000 (UTC)
From: "Mrs. Mina A. Brunel" <brunelminaa@gmail.com>
Message-ID: <1074356789.1082600.1592774595719@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
References: <1074356789.1082600.1592774595719.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16138 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36
Message-ID-Hash: 7PIYUWXUXKTX3WHRI4MJSBM3ENJBJFGZ
X-Message-ID-Hash: 7PIYUWXUXKTX3WHRI4MJSBM3ENJBJFGZ
X-MailFrom: brunelminaa@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mrsminaabrunel63@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7PIYUWXUXKTX3WHRI4MJSBM3ENJBJFGZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCk15IERlYXIgaW4gdGhlIGxvcmQNCg0KDQpNeSBuYW1lIGlzIE1ycy4gTWluYSBBLiBCcnVu
ZWwgSSBhbSBhIE5vcndheSBDaXRpemVuIHdobyBpcyBsaXZpbmcgaW4gQnVya2luYSBGYXNvLCBJ
IGFtIG1hcnJpZWQgdG8gTXIuIEJydW5lbCBQYXRyaWNlLCBhIHBvbGl0aWNpYW5zIHdobyBvd25z
IGEgc21hbGwgZ29sZCBjb21wYW55IGluIEJ1cmtpbmEgRmFzbzsgSGUgZGllZCBvZiBMZXByb3N5
IGFuZCBSYWRlc3lnZSwgaW4geWVhciBGZWJydWFyeSAyMDEwLCBEdXJpbmcgaGlzIGxpZmV0aW1l
IGhlIGRlcG9zaXRlZCB0aGUgc3VtIG9mIOKCrCA4LjUgTWlsbGlvbiBFdXJvKSBFaWdodCBtaWxs
aW9uLCBGaXZlIGh1bmRyZWQgdGhvdXNhbmQgRXVyb3MgaW4gYSBiYW5rIGluIE91YWdhZG91Z291
IHRoZSBjYXBpdGFsIGNpdHkgb2Ygb2YgQnVya2luYSBpbiBXZXN0IEFmcmljYS4gVGhlIG1vbmV5
IHdhcyBmcm9tIHRoZSBzYWxlIG9mIGhpcyBjb21wYW55IGFuZCBkZWF0aCBiZW5lZml0cyBwYXlt
ZW50IGFuZCBlbnRpdGxlbWVudHMgb2YgbXkgZGVjZWFzZWQgaHVzYmFuZCBieSBoaXMgY29tcGFu
eS4NCg0KSSBhbSBzZW5kaW5nIHlvdSB0aGlzIG1lc3NhZ2Ugd2l0aCBoZWF2eSB0ZWFycyBpbiBt
eSBleWVzIGFuZCBncmVhdCBzb3Jyb3cgaW4gbXkgaGVhcnQsIGFuZCBhbHNvIHByYXlpbmcgdGhh
dCBpdCB3aWxsIHJlYWNoIHlvdSBpbiBnb29kIGhlYWx0aCBiZWNhdXNlIEkgYW0gbm90IGluIGdv
b2QgaGVhbHRoLCBJIHNsZWVwIGV2ZXJ5IG5pZ2h0IHdpdGhvdXQga25vd2luZyBpZiBJIG1heSBi
ZSBhbGl2ZSB0byBzZWUgdGhlIG5leHQgZGF5LiBJIGFtIHN1ZmZlcmluZyBmcm9tIGxvbmcgdGlt
ZSBjYW5jZXIgYW5kIHByZXNlbnRseSBJIGFtIHBhcnRpYWxseSBzdWZmZXJpbmcgZnJvbSBMZXBy
b3N5LCB3aGljaCBoYXMgYmVjb21lIGRpZmZpY3VsdCBmb3IgbWUgdG8gbW92ZSBhcm91bmQuIEkg
d2FzIG1hcnJpZWQgdG8gbXkgbGF0ZSBodXNiYW5kIGZvciBtb3JlIHRoYW4gNiB5ZWFycyB3aXRo
b3V0IGhhdmluZyBhIGNoaWxkIGFuZCBteSBkb2N0b3IgY29uZmlkZWQgdGhhdCBJIGhhdmUgbGVz
cyBjaGFuY2UgdG8gbGl2ZSwgaGF2aW5nIHRvIGtub3cgd2hlbiB0aGUgY3VwIG9mIGRlYXRoIHdp
bGwgY29tZSwgSSBkZWNpZGVkIHRvIGNvbnRhY3QgeW91IHRvIGNsYWltIHRoZSBmdW5kIHNpbmNl
IEkgZG9uJ3QgaGF2ZSBhbnkgcmVsYXRpb24gSSBncmV3IHVwIGZyb20gYW4gb3JwaGFuYWdlIGhv
bWUuDQoNCkkgaGF2ZSBkZWNpZGVkIHRvIGRvbmF0ZSB0aGlzIG1vbmV5IGZvciB0aGUgc3VwcG9y
dCBvZiBoZWxwaW5nIE1vdGhlcmxlc3MgYmFiaWVzL0xlc3MgcHJpdmlsZWdlZC9XaWRvd3MgYW5k
IGNodXJjaGVzIGFsc28gdG8gYnVpbGQgdGhlIGhvdXNlIG9mIEdvZCBiZWNhdXNlIEkgYW0gZHlp
bmcgYW5kIGRpYWdub3NlZCB3aXRoIGNhbmNlciBmb3IgYWJvdXQgMyB5ZWFycyBhZ28uIEkgaGF2
ZSBkZWNpZGVkIHRvIGRvbmF0ZSBmcm9tIHdoYXQgSSBoYXZlIGluaGVyaXRlZCBmcm9tIG15IGxh
dGUgaHVzYmFuZCB0byB5b3UgZm9yIHRoZSBnb29kIHdvcmsgb2YgQWxtaWdodHkgR29kOyBJIHdp
bGwgYmUgZ29pbmcgaW4gZm9yIGFuIG9wZXJhdGlvbiBzdXJnZXJ5IHNvb24uDQoNCk5vdyBJIHdh
bnQgeW91IHRvIHN0YW5kIGFzIG15IG5leHQgb2Yga2luIHRvIGNsYWltIHRoZSBmdW5kcyBmb3Ig
Y2hhcml0eSBwdXJwb3Nlcy4gQmVjYXVzZSBvZiB0aGlzIG1vbmV5IHJlbWFpbnMgdW5jbGFpbWVk
IGFmdGVyIG15IGRlYXRoLCB0aGUgYmFuayBleGVjdXRpdmVzIG9yIHRoZSBnb3Zlcm5tZW50IHdp
bGwgdGFrZSB0aGUgbW9uZXkgYXMgdW5jbGFpbWVkIGZ1bmQgYW5kIG1heWJlIHVzZSBpdCBmb3Ig
c2VsZmlzaG5lc3MgYW5kIHdvcnRobGVzcyB2ZW50dXJlcywgSSBuZWVkIGEgdmVyeSBob25lc3Qg
cGVyc29uIHdobyBjYW4gY2xhaW0gdGhpcyBtb25leSBhbmQgdXNlIGl0IGZvciBDaGFyaXR5IHdv
cmtzLCBmb3Igb3JwaGFuYWdlcywgd2lkb3dzIGFuZCBhbHNvIGJ1aWxkIHNjaG9vbHMgYW5kIGNo
dXJjaGVzIGZvciBsZXNzIHByaXZpbGVnZSB0aGF0IHdpbGwgYmUgbmFtZWQgYWZ0ZXIgbXkgbGF0
ZSBodXNiYW5kIGFuZCBteSBuYW1lLg0KDQpJIG5lZWQgeW91ciB1cmdlbnQgYW5zd2VyIHRvIGtu
b3cgaWYgeW91IHdpbGwgYmUgYWJsZSB0byBleGVjdXRlIHRoaXMgcHJvamVjdCwgYW5kIEkgd2ls
bCBnaXZlIHlvdSBtb3JlIGluZm9ybWF0aW9uIG9uIGhvdyB0aGUgZnVuZCB3aWxsIGJlIHRyYW5z
ZmVycmVkIHRvIHlvdXIgYmFuayBhY2NvdW50IG9yIG9ubGluZSBiYW5raW5nLg0KDQpUaGFua3MN
Ck1ycy4gTWluYSBBLiBCcnVuZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlz
dHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxl
YXZlQGxpc3RzLjAxLm9yZwo=
