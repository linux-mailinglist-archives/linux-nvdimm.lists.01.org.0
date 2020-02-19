Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8C2163A2A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Feb 2020 03:30:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C40A910FC3585;
	Tue, 18 Feb 2020 18:31:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=183.79.57.67; helo=ns502-vm12.bullet.mail.kks.yahoo.co.jp; envelope-from=rosemaryjones_01@yahoo.co.jp; receiver=<UNKNOWN> 
Received: from ns502-vm12.bullet.mail.kks.yahoo.co.jp (ns502-vm12.bullet.mail.kks.yahoo.co.jp [183.79.57.67])
	by ml01.01.org (Postfix) with SMTP id 2C23E10FC341C
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 18:31:17 -0800 (PST)
Received: from [183.79.100.138] by ns502.bullet.mail.kks.yahoo.co.jp with NNFMP; 19 Feb 2020 02:30:24 -0000
Received: from [183.79.100.135] by t501.bullet.mail.kks.yahoo.co.jp with NNFMP; 19 Feb 2020 02:30:24 -0000
Received: from [127.0.0.1] by omp504.mail.kks.yahoo.co.jp with NNFMP; 19 Feb 2020 02:30:24 -0000
X-Yahoo-Newman-Property: ymail-5
X-Yahoo-Newman-Id: 653545.9371.bm@omp504.mail.kks.yahoo.co.jp
X-YMail-OSG: YCE.s4AVM1nKVOO1Q.QtqZtYmotS86GpExC5T036_c26hKFFgnprFX.18wBaxMc
 g5SpcOz.PW5kPSgqbe9OMTbcUO1S_317w5TlXT9dGdln4Mo2Zct0VssRNIqRQRerLjZAWpbmOZAy
 e0MQYpwWbRtFOe7WqIK_k33B7x6urlFgEZxCStA2e7Hj5vpeY8yB8L7XLVBMXKoa7Tg26DNPDS1.
 dq6Etwgwmn48consTn8E3annjZSSWyqvndlSmU2DTrFBV_4FQSWccZ7VNfEbqUzJT5gP1aOY35hb
 uiRMu_EAmYKr0G1Q1kGjhRE5GGcRuIpOnbOebwdAiaT79UMxZHDCqtORB99_f5iLHnkP5kGIAD64
 EZ206y9XD2mY9fRdmwOEVW5yVZz9m9.BTNGj1Mze9.m1Dr36VDZiaKaLbxyzgAteWP.wH_fu.HMD
 spn0eBbGF2WwF.Ed21ptuB0Jt_kmvge2jh7pXoXXMkSx8Hg9sXzRZD.MBaYoYRLw8WhQs3drqAFL
 yQT1UIoGQiBShGj6c4nF0uZBEj0Cw8CSjNuEpnmew2MDiB0S_h.MSAi63hJYh6JXxcEqazYH.nzH
 aMBRce35JwXDjNQFPgPt6EIgh3PRtLl4IbXwUF.c_Ynn3fAIP.kpPSk3RaK0JVicXMTwCT8kbhMk
 SL189YlW1fctQieK3_806iLP_VnVGwFiusAn_1ICCAO354QrxOJ5rM3Zm.B_NoJeV0lxJjRVNeVN
 WTqpOZdIQAOpfMFjRy6HIfvos_SvmRM0eG6DzeKUzXx31b_f9y39fQlWVPo_8lfZBUrn.iq8W0RM
 ct0k.wS7IPFbHFtEdgB3w.Xff1IjlBhE-
Received: from jws701002.mail.kks.yahoo.co.jp by sendmailws516.mail.kks.yahoo.co.jp; Wed, 19 Feb 2020 11:30:24 +0000; 1582079424.097
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1582079424;
	s=yj20110701; d=yahoo.co.jp;
	h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:Content-Type:References;
	bh=UwB9QDq3ew7ynL28VW/xuOGo54tLX5nkWJgNfPM5JYU=;
	b=kXXS3bN9sxw1KYSlHBjlRKrd/uyRA1EDTufb8Ivfd3oSh9temnHUU4wIrP7snn7E
	lq6DICMZV/IMe/2VfGs8E3CjaebHyNuHjWBrZGVwn3g1IZtqbIG5ATwrpUTiCmvD1vU
	Faa2hom+OS46ond71o6xKaCR2+zQOnnoliqc8BnI=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=yj20110701; d=yahoo.co.jp;
	h=Date:From:Reply-To:Message-ID:MIME-Version:Content-Type:References;
	b=QXICp/HiI3TG9O3Ccq9P9/ufodWqY+aUsxl0ViJ7omIge6/dFtm1n738RD31OOGs
	Y0NfOGWBpbQ07aAfURUJCGcbdhQFTTksEuwt60LFA1cl9T4Zew8WqBlz+mLZ2vcC+FX
	mvO8L4NUnmAQXSsZlI536/WAmCt23irq1pNyibWw=;
X-yjpVirusScan: Scanned
Date: Wed, 19 Feb 2020 11:30:23 +0900 (JST)
From: Rosemary Jones <rosemaryjones_01@yahoo.co.jp>
To: Rosemary Jones <rosemaryjones_01@yahoo.co.jp>
Message-ID: <1227117293.41447.1582079423325.JavaMail.yahoo@mail.yahoo.co.jp>
Subject: RE:MAIL
MIME-Version: 1.0
References: <1227117293.41447.1582079423325.JavaMail.yahoo.ref@mail.yahoo.co.jp>
Message-ID-Hash: EJUMPRRTYJDP3KRPDSAORDJWTMBUG3B5
X-Message-ID-Hash: EJUMPRRTYJDP3KRPDSAORDJWTMBUG3B5
X-MailFrom: rosemaryjones_01@yahoo.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: Rosemary Jones <rosemarryjones123@hotmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EJUMPRRTYJDP3KRPDSAORDJWTMBUG3B5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

S29tcGxpbWVudCBkZXMgVGFnZXMNClZvbiBSb3NlbWFyeSBKb25lcw0KV2VzdGFmcmlrYSBFbGZl
bmJlaW5rw7xzdGUNCkxpZWJzdGUNCkVzIGlzdCBtaXIgZWluZSBGcmV1ZGUsIElocmUgTWVpbnVu
ZyBlaW56dWhvbGVuIHVuZCBzaWNoIElobmVuIGbDvHIgZWluZSBnZXNjaMOkZnRsaWNoZSBQYXJ0
bmVyc2NoYWZ0IGFuenV2ZXJ0cmF1ZW4uIFdpciBoYWJlbiB1bnMgendhciBub2NoIG5pZSBnZXRy
b2ZmZW4sIGFiZXIgaWNoIGdsYXViZSwgbWFuIG11c3MgZGFzIFJpc2lrbyBlaW5nZWhlbiwgc2lj
aCBqZW1hbmRlbSBhbnp1dmVydHJhdWVuLCB1bSBtYW5jaG1hbCBpbSBMZWJlbiBlcmZvbGdyZWlj
aCB6dSBzZWluLiBJY2ggYmluIEZyw6R1bGVpbiBSb3NlbWFyeSBKb25lczsgSWNoIGtvbW1lIGF1
cyBkZXIgd2VzdGFmcmlrYW5pc2NoZW4gUmVnaW9uIEVsZmVuYmVpbmvDvHN0ZS4gSWNoIGhhYmUg
U2llIHdlZ2VuIGRpZXNlciBlZGxlbiBUcmFuc2FrdGlvbiBrb250YWt0aWVydCwgdW0gSWhyZSBI
aWxmZSB1bmQgSWhyZW4gUmF0IGVpbnp1aG9sZW4sIGRhIGljaCB6dSBqdW5nIGJpbiwgdW0gc2ll
IGFsbGVpbmUgenUgZXJsZWRpZ2VuLg0KDQpEaWUgU3VtbWUgdm9uIHplaG4gTWlsbGlvbmVuIGbD
vG5maHVuZGVydHRhdXNlbmQgVVMtRG9sbGFyIHd1cmRlIHZvbiBtZWluZW0gVmF0ZXIgYW4gZGVy
IEVsZmVuYmVpbmvDvHN0ZSBiZWkgZWluZXIgQmFuayBoaW50ZXJsZWd0LCBkaWUgZXIgZsO8ciBz
ZWluZSBwb2xpdGlzY2hlbiBBbWJpdGlvbmVuIHZlcndlbmRlbiB3b2xsdGUsIGJldm9yIGVyIGVy
bW9yZGV0IHd1cmRlLiBBdWZncnVuZCBkZXIgU2l0dWF0aW9uLCBpbiBkZXIgaWNoIG1pY2ggYmVm
YW5kLCBoYWJlIGljaCBiZXNjaGxvc3NlbiwgZGllc2VzIEdlbGQgd2VnZW4gZGVyIGjDpHVmaWdl
biBwb2xpdGlzY2hlbiBJbnN0YWJpbGl0w6R0IHVuZCBhdWNoIGF1cyBTaWNoZXJoZWl0c2dyw7xu
ZGVuIGluIElociBMYW5kIHp1IGludmVzdGllcmVuLiBEYXMgU2NobGltbXN0ZSBkYXJhbiBpc3Qs
IGRhc3MgbWVpbmUgT25rZWwgdmVyc3VjaGVuLCBtaWNoIHdlZ2VuIGRpZXNlcyBHZWxkZXMgdW16
dWJyaW5nZW4gSWNoIGhhYmUgbWljaCBnZXdlaWdlcnQsIGRpZSBVbnRlcmxhZ2VuIMO8YmVyIGRp
ZXNlcyBHZWxkIGFuIHNpZSB3ZWl0ZXJ6dWdlYmVuLiBTaWUgaGFiZW4gYWxsZSBHcnVuZHN0w7xj
a2UgbWVpbmVzIFZhdGVycyB2ZXJrYXVmdCwgZGllIG1pciByZWNodG3DpMOfaWcgZ2Vow7ZyZW4s
IHVuZCB3YXJlbiBhdWYgZGVyIEh1dCwgaWhuZW4gRWluemVsaGVpdGVuIHp1IGRlbSBlaW5nZXph
aGx0ZW4gR2VsZCBtaXR6dXRlaWxlbiwgZGFzIGljaCBhYmxlaG50ZS4gTWVpbiBMZWJlbiBzdGVo
dCBqZXR6dCBhdWYgZGVtIFNwaWVsLCBhbHNvIGJpbiBpY2ggdm9uIG1laW5lciBTdGFkdCBuYWNo
IEFiaWRqYW4gZ2VmbG9oZW4gdW5kIGhhYmUgbWljaCBpbiBlaW5lbSBIb3RlbCB2ZXJzdGVja3Qs
IGJpcyBkaWVzZXMgR2VsZCBmcmVpZ2VnZWJlbiB3aXJkLg0KDQpJY2ggYml0dGUgU2llIGF1ZiBm
b2xnZW5kZSBXZWlzZSB1bSBIaWxmZToNCg0KKDEuKSBWb3JrZWhydW5nZW4genUgdHJlZmZlbiwg
ZGFtaXQgaWNoIG5hY2ggZGVyIGVyZm9sZ3JlaWNoZW4gw5xiZXJ3ZWlzdW5nIGRpZXNlcyBHZWxk
ZXMgYXVmIElociBLb250byBpbiBJaHIgTGFuZCBrb21tZSB1bmQgbWVpbmUgQXVzYmlsZHVuZyBm
b3J0c2V0emUuDQooMi4pIFVtIGRpZXNlcyBHZWxkIGluIGVpbiBwcm9maXRhYmxlcyBHZXNjaMOk
ZnQgenUgaW52ZXN0aWVyZW4sIGRhIGljaCBuaWNodCBhbHQgZ2VudWcgYmluLCB1bSBzb2xjaGUg
QW5nZWxlZ2VuaGVpdGVuIHp1IGVybGVkaWdlbg0KKDMpLiBJY2ggbcO2Y2h0ZSwgZGFzcyBTaWUg
bWlyIHZlcnNwcmVjaGVuLCBkYXNzIFNpZSBtaWNoIG5pY2h0IGJldHLDvGdlbiB3ZXJkZW4sIG5h
Y2hkZW0gZGFzIEdlbGQgYXVmIElociBLb250byBlaW5nZWdhbmdlbiBpc3QsIGRhIGljaCBkYXMg
w7xicmlnIGhhYmUuDQpHZXJuZSBiaWV0ZSBpY2ggSWhuZW4gMzAlIGRlcyBHZXNhbXRmb25kcyBh
biwgd8OkaHJlbmQgZGVyIFJlc3RiZXRyYWcgbWl0IElocmVyIEhpbGZlIGludmVzdGllcnQgd2ly
ZC4gSElOV0VJUzogSWNoIGhhYmUgYWxsZSBlcmZvcmRlcmxpY2hlbiBEb2t1bWVudGUsIGRpZSBt
aWNoIGFscyBBbmdlaMO2cmlnZW4gdW50ZXJzdMO8dHplbi4gV2VubiBTaWUgYmVyZWl0IHNpbmQs
IG1pY2ggenUgdW50ZXJzdMO8dHplbiwgesO2Z2VybiBTaWUgYml0dGUgbmljaHQsIG1pY2ggZsO8
ciB3ZWl0ZXJlIEVpbnplbGhlaXRlbiB6dSBrb250YWt0aWVyZW4sIHVuZCBob2ZmZW4gU2llLCBk
YXNzIFNpZSBkaWVzZSBUcmFuc2FrdGlvbiBtaXQgZmFzdCBkZXIgVmVydHJhdWxpY2hrZWl0IHVu
ZCBUcmFuc3BhcmVueiBhYndpY2tlbG4sIGRpZSBzaWUgdmVyZGllbnQgLg0KRGVpbg0KRnLDpHVs
ZWluIFJvc2VtYXJ5IEpvbmVzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3Rz
LjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2
ZUBsaXN0cy4wMS5vcmcK
