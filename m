Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE171600BB
	for <lists+linux-nvdimm@lfdr.de>; Sat, 15 Feb 2020 22:50:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 08A9C1007B1FD;
	Sat, 15 Feb 2020 13:53:28 -0800 (PST)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=66.163.185.148; helo=sonic305-22.consmr.mail.ne1.yahoo.com; envelope-from=jblipx@gmail.com; receiver=<UNKNOWN> 
Received: from sonic305-22.consmr.mail.ne1.yahoo.com (sonic305-22.consmr.mail.ne1.yahoo.com [66.163.185.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 78E051007B1FD
	for <linux-nvdimm@lists.01.org>; Sat, 15 Feb 2020 13:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581803407; bh=0C1gHCSgrrt9FY5xDQl3lJd8RWsKWOylxtagExLzOmM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=k2k7JTokMsQTacbrAYIGdtFQOzlaBjot8i11Eg5cnSZL9pnlZY/LXOvDiS8mOfy52/fa/srA9VWJF6Rlzd3Mc/Lf+fJcximB3rJ76nbxfQ6vHkG/mpT3oaa/cq3I8rnrr1xIirdfMShGAU8vqvBIeTpuvZCslS9J05TBhH9htlRLTldADSnVyIVSDWxTkU/CiwYr5CRxFt3yJ9ABIJegoxP+uv88ArkznbooEy7E9Qk9fQfR+VdrmKK2Ha1BBgjae5IP7eO3GS5bOmtmygyrfSpGlFhHEaEaNYVV275HfFCRkqXz/rgqGt9xSLgmHMuVhJAPhn5GEjZlUcd1fXn/iQ==
X-YMail-OSG: jKYvWI4VM1mYeBMTpbcJUgp5EZnoFORAnZzTxJ._ENdk5ZfrdBBzwLr.YF8RFgV
 OeDu4xccHVGE5b9_vnIq.54WKjDtLu7KNfD8EORGsdAPUpp56hQKkhIxRrpXB_j7j907LQ2BJRwv
 zvyzibJ8PzDsbs6O2qN4G5hkmxAfNne4Vxgm7STDabNrdAyTgSO0VGWvU5AR0FvPYFpgVDTJexuS
 1Rx8ToqtxTqp1940nsTzKiAHoAGU2duQ3aX8gvyLCdnLya20EsJMJfbQR17huTjM7g_mjidYVASq
 GGy9VPJ503lnw.EqHOkBNms5zYYy_WvDER1etsjJgwcH2by77MfN43B7ZdK1Hz500rIhSOhIwuMI
 LI9QcfGGomg9l8ha54V3xsFIM2T0w6WwPA.FjsZdUuJW5ExzyI6SzJXqjZnFGx_GOdCSibxm7miy
 5SAlTIrzoC7mUwsFOc_ty0I64HsMGIh2H77nrfgSatk3dpqbpJacQ_2fQz.D2yJO.wj6GPhM_8k5
 T9PCAQEbwyyYBiZYbrCy5hy03tvSg6jgKBFam7vZ2imRBYlfu0OPCVyudLNqPQZKEit4kb1zCl5z
 _O7EFTJ3qj_uplPGtGxpCdaZnOse_F6tgiuBf7dhY9CmXScnR.iThZKqbpMzkv22gIszRaXTZbi2
 85gNDIbc2TfSxDrttyKFdIDnVUWEZPgw91G_mtgsihiUzzwITjzMXYWgY1grih8yugyZAywX6.yZ
 9cUP34JpA.VwZEMzs5jVAYSFnjoQFQV5GF_rbNKO9zbb.i0LEbdvuV7bz4W.zlEQkUdrFVCGr5fM
 8Agt19ojXDyDI0sKjULYEQfBRGC3ZIeHbu69_8sFpN8Bfd2k8slh1Ob4P1zfdQ4RbRqvPKfUiYIT
 lJqpnH5Y6RK0BHGUbDflNaYo7Nuiu3cnNc8_gIBe98QccvfRmWCi0GfxKd3esaGNql4.lwd7gsqv
 BQ3mo.W9FfGT8eQQKR3DZckP6Dbe1OVZ643oYlPHOJ31YeExs_fkvxSvnh9CTsVz7JpdyJsiwJE_
 1isTmHTKOBSsf8GeGADqXfPrmmfEoUromhvIqZROawzJpVL.uXoR.O4Qhq.wPCIXilHSoEmrguoE
 SJeLMTjaYFtsiG3uq15pD2U9AJDddGqCgRFTu7SuJKmOifAo2SXwlU8WwrERGFbIhUR.7RAGIqvx
 f1a8i3Uo94yYKBnPMYurzCa5_DGl6iNgD8RIFW_sBIKb7Wuv6VPIJMG3aIMr8DPtIyAjzRC_ou2A
 RYL6RPTq51k8Id2J7E1gW69lk1CVdXXXEzeGY4jrO4ikism7zE6wZNm0pK5jBO.ESHtVAin_Y2HE
 Y9TcJYfJDB8lttG0S
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Sat, 15 Feb 2020 21:50:07 +0000
Date: Sat, 15 Feb 2020 21:50:04 +0000 (UTC)
From: "Mrs.Nona Santa" <jblipx@gmail.com>
Message-ID: <980209783.3557837.1581803404279@mail.yahoo.com>
Subject: Your  $15.5 Million  Payment Alert.
MIME-Version: 1.0
References: <980209783.3557837.1581803404279.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNorrin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0
Message-ID-Hash: 2KU2P5HGI4W2V6QSJPKOE6JYOPCKWWCP
X-Message-ID-Hash: 2KU2P5HGI4W2V6QSJPKOE6JYOPCKWWCP
X-MailFrom: jblipx@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: "Mrs.Nona Santa" <info.8373@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2KU2P5HGI4W2V6QSJPKOE6JYOPCKWWCP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpBdHRlbjogQmVuZWZpY2lhcnkuDQoNCkkgYW0gTXJzLiBOb25hIFNhbnRhLiBDb250YWN0aW5n
IGZyb20gQ2l0aWJhbmsgaGVyZSBpbiDCoFUuUy5BIFdlIHJlY2VpdmVkIHRyYW5zZmVyIGluIHR1
bmUgb2bCoCAkMTUuNSBNaWxsaW9uIFVTRCB2aWEgVmlzYSBDYXJkIGZyb20gQmFuayBPZkFmcmlj
YSBhbmQgd29ybGTCoCBiYW5rIHdpdGggcmVmZXJlbmNlY29kZS54bjg3Nm43LiBJdCB3YXMgaW5z
dHJ1Y3RlZCB0byBwYXkgdG8geW91IGFzIHBhcnQgb2YgeW91ciBpbmhlcml0YW5jZSBmdW5kc2Fi
YW5kb25lZCBpbiBBZnJpY2EuIEV1cm9wZSBhbmQgQXNpYW4gYmFuayB5ZWFycyBiYWNrLg0KDQpP
biB0aGUgQnV0dG9uIGxpbmUgb2Z0aGUgbWVzc2FnZSB3ZSB3YXMgaW5zdHJ1Y3RlZCB0byBjb250
YWN0IHlvdSB0byBpbmZvcm0geW91IGFib3V0IHlvdXIgZnVuZHMgYW5kaXQgY3VycmVudCBsb2Nh
dGlvbi4gV2UgY29uY2x1ZGVkIHRvIGNvbnRhY3QgeW91IGRpcmVjdGx5IHZpYSBtYWlsIHRvZGF5
IHJlZ2FyZGluZ3lvdXIgZnVuZHMgd2hpY2ggd2lsbCBiZSBwYWlkIHRvIHlvdSB0aHJvdWdoIG91
ciBDaXRpYmFuayBwYXltZW50IG1ldGhvZC4NCg0KTWVhbndoaWxlIGNvbnRhY3QgVHJhbnNmZXJE
ZXB0LiBNci4gV2lsc29uIFdpbGxpYW1zIGF0IGJlbG93IEUtbWFpbDo6IMKgwqDCoMKgwqAoIGlu
Zm8uODM3M0BnbWFpbC5jb20gKS4gZm9yIGNsYWltIGFuZCByZW1lbWJlciB0byB1c2UgdGhlIHNh
bWUgcmVmZXJlbmNlIGNvZGUgKC54bjg3Nm43KSB3aGlsZSBjb250YWN0aW5nIGhpbSBzbyBoZSBj
YW4gZWFzaWx5IGxvY2F0ZSB5b3VyIHBheW1lbnTCoCBmaWxlLg0KDQpUaGFua3MNCg0KTXJzLiBO
b25hIFNhbnRhDQoNClBvc2l0aW9uIFNlY3JldGFyeS4gKENpdGlCYW5rKSAuDQoNClNhbiBBbnRv
bmlvLCBUeCA3ODI0NSwgDQoNClVuaXRlZCBTdGF0ZSBvZiBBbWVyaWNhDQoNCsKgDQoNCsKgDQoN
Cg0KDQoNCsKgDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9y
ZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0
cy4wMS5vcmcK
