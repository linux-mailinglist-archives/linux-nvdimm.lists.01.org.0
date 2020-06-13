Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2B31F8400
	for <lists+linux-nvdimm@lfdr.de>; Sat, 13 Jun 2020 17:43:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 549AF10FC3613;
	Sat, 13 Jun 2020 08:43:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=77.238.176.98; helo=sonic301-21.consmr.mail.ir2.yahoo.com; envelope-from=rose_gomoo101@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic301-21.consmr.mail.ir2.yahoo.com (sonic301-21.consmr.mail.ir2.yahoo.com [77.238.176.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0568F10106A08
	for <linux-nvdimm@lists.01.org>; Sat, 13 Jun 2020 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592063012; bh=EdQ6J0sRRv3XBxt3j7IlulUVvRg4uKdicik//r5GkY8=; h=Date:From:To:Subject:References:From:Subject; b=eqKtCIPL7N9QYQmvpanbwPtGj9DgzEaHYboa5olHPICzZQkdevlP/KJgsK4mC6O9vD+XCThtQ/8tMOs5YSHD2HLo4G44d+KJ5El9sDDBqGQwNeQ9FiQpisRcKrB6W65qvG0VoHIVVTKnneuajBRAvIjtOJIdWKW3jiVnbNjJRVj6A366ntPigDkhZc8vg1agTNf7sxB1RSfaSxgXyLjle4mbXZJ7mEQDLznVpjsZKbVI7CL6gWBt4inEa5Ydjb9Ta1jYJ6TTBfUxXHLzt7YJ0KEbkSPkSiDAhK6KDIXPyJW2OvTnhtA+wMkbRoE5Q8TpnxWE+8CBVmZINccnbXHZ1Q==
X-YMail-OSG: LPRBtNsVM1nCmhVC1amy5jcW7SC4kovqhhhyZo_ouicxjxcyZ6QkT6O3_3THinP
 _ySqGi7Z7mErY_JZutb1DXbTo7zAxl7FMbm3oHaBQl2.miOr2_eMRI9pk1Q3bokXZc33U7zHs05a
 MaDXot7nNfT7r1pY57evKeikrvCxuZ7x3hAIvz5xjrtIZ2qsjl0bWQKI7Mox1Vjz7Mm29McsuJsM
 y.Ga_QM1AMKZa3odD_HcjZ_bxGnNtBvvTl63iBl_SLWfKxH5vIdGrXhUgvsSNq3ounCyQ1o3Qnp2
 XCsqYIUj5sQ2ez3xKYAqC1lLD.gy_NRcAGPjjHkQFAVsj_HeVU5hPbis9fQpiUJ63tmjwaUtwbmk
 giShiFzMF.8kryE4YX8MFgoQM6AnD7xm0YUOtJ1bGMrzt7IdVq9qOZ62pIErqR86KCqxADzwgC7i
 N2LMiKu_Ug0lM5YKDiT7bU9WnWuOyQ4DmEOe_JjRcBm_ToCl.Jb9euw6QP.i31J3z4m7ju8yLYze
 GgtjOX_Nz.wQ62kR.pG4qW0cociGvlLDgR1I22hkqBorAt9ZDgti8VW1u3yq7i5hxqASq1QUt1s1
 ev6cdDjG.MCYVi4dhCMY5WVJ9RHmQNkBC6YlSsnUzJ8bU3IpgkwVlr2kl8aBoOxr8HN_UqAVCdGE
 nwg7dqOePh1dJEw4VjpyGihgoWz4onIe.OzBOYnKvzowDQx5But.wehGmOtPOVaV_4SzQLVSLYSj
 5Vj2INA9v472fNk8aXzIQgCXvHB5C.1StRGgAi1QXu8a9lImLV03CyBmg7xIzz4VnvrDzjc52tsc
 NEL3eDVGgzNYyzbNMDkE4Wu1Q8xNd05GqyeFGMGguHcdofTKGS8xjOCbYQh_Z.D41Lu7vTFQgMgY
 Q94362CVLeJEnd1XTaxtHXzyqF7bSlc8Qn1CzrTy_PiGaARNyHELC9I09P511j6Gw2MXWA9p05LP
 imiIHhoTUw.3moqflnWwQ1lYsq5IoSDskY4y2hT4JCUpcGRuqAORuC5uCCByQAQ3qp98JJjcnabI
 sNO98Rh9gM218W0yuuXwFWTosmaOEsXbzxdqKoYXHW2VV3OreCVJKiXO0e1rkhAuezqrejJuihq3
 mR6Ce00XrL9PbOy5w1dTCwf8WFesNbe6afVxyEucZK4AoqcJF5w_1Mo1z7vCoNPAXUg11zcM3VTx
 SxokaQBEhufTXbvxJS9hHOz55xFS5IJS3JjOns3SJZTu_o24QloK2GhFd.sq5ETxjof1XkFxd9pT
 jE.4LGGr1TeePEqh.uT6vyXwtf4ZxrPy08hq9FcW4xPcOrVenvSL.TV7tRQhxZvU2RQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sat, 13 Jun 2020 15:43:32 +0000
Date: Sat, 13 Jun 2020 15:43:27 +0000 (UTC)
From: Rose Gomo <rose_gomoo101@yahoo.com>
To: rose_gomoo101@yahoo.com
Message-ID: <7709890.448665.1592063007309@mail.yahoo.com>
Subject: Dear Good Friend.
MIME-Version: 1.0
References: <7709890.448665.1592063007309.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16119 YMailNodin Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; GTB7.5; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.2)
Message-ID-Hash: PFVQKPPFNFQUZEMPWERV7XXVVU74S3C3
X-Message-ID-Hash: PFVQKPPFNFQUZEMPWERV7XXVVU74S3C3
X-MailFrom: rose_gomoo101@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PFVQKPPFNFQUZEMPWERV7XXVVU74S3C3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RGVhciBHb29kIEZyaWVuZC4NCg0KUGxlYXNlIGNhbiB5b3UgaGVscCBtZSB0byByZWNlaXZlIHRo
ZSBmdW5kIEkgaW5oZXJpdGVkIGZyb20gbXkgZmF0aGVyIHRvIHlvdXIgYWNjb3VudCBpbiB5b3Vy
IGNvdW50cnkgZm9yIGJ1c2luZXNzIGludmVzdG1lbnQ/IFJpZ2h0IG5vdyB0aGUgZnVuZCBpcyBp
biB0aGUgYmFuayBoZXJlIHdoZXJlIG15IGZhdGhlciBkZXBvc2l0ZWQgaXQgYmVmb3JlIGhlIGRp
ZWQgYW5kIHRoZSBhbW91bnQgaXMg4oKsMi41bWlsbGlvbiBFdXJvcyAoVHdvIE1pbGxpb24gRml2
ZSBIdW5kcmVkIFRob3VzYW5kIEV1cm9zKQ0KDQpQbGVhc2UgaWYgeW91IGFyZSBpbnRlcmVzdGVk
IHlvdSBjYW4gY29udGFjdCBtZSBhcyBzb29uIGFzIHBvc3NpYmxlIGZvciBtb3JlIGRldGFpbHMu
DQoNCkJlc3QgcmVnYXJkcw0KUm9zZSBHb21vLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52
ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1u
dmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
