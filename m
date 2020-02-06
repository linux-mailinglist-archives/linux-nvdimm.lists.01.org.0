Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903731545C5
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Feb 2020 15:12:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D3F2B10FC3404;
	Thu,  6 Feb 2020 06:15:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.6.131.41; helo=sonic303-2.consmr.mail.bf2.yahoo.com; envelope-from=mikebenz550@aol.com; receiver=<UNKNOWN> 
Received: from sonic303-2.consmr.mail.bf2.yahoo.com (sonic303-2.consmr.mail.bf2.yahoo.com [74.6.131.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9B30B10FC3400
	for <linux-nvdimm@lists.01.org>; Thu,  6 Feb 2020 06:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1580998340; bh=aoPnLSnNJjZPPuOCAzh4EwkNWkEpImt2Lwq6nh5NGww=; h=Date:From:Subject:References:From:Subject; b=Kiq5gWRn2gsqdHeM6nagX5cVSP6GDuoidxkUNAeP42aX+EJjspOxJ2c6CB4+7qgMZ6Tlkm5r2OKpjbVZ3xDiqSlqUielFDtbvxJedD7NfWRq8mGDCOQPWj7JMuoZqpgQjvf7VkNhYoL8Fx3odp5oj6re/ulMzrB5oVf1gYwaWYMRBBUO8rMMi70xVyc+3wVNrqC17+jXVSPxFsNjzaJIxqsiZOBJO+dCh5IlutVSM4HGFZdLXfxioP0YhWhQGeQxYROnhFwjKx6PHBnSUTtgLZZlo5XAViqGtWScv5VkT/9Em7dmSQx0VD84/Y0pErB9S/YETDeSBPWdJumkc3swJQ==
X-YMail-OSG: FHX4uDsVM1lisqFAy.2d_iq8fMlTbUnn1cWVyQz4BMrj_1ZIdOkAdXVExOuG6E3
 VncelQZVGujNEq4cCA9iGzlMHYSj_FoN6GCC5J6ifvEAJz3_sP62yAzEJtCagPnYE5i0086gQHqh
 3Z7HH.MdfE380pfaT0Kyijkxi.cU27v.NM4ExdxElfj9hg7pn9__3eJhtjf5XVF6ZmN5omEcK_RC
 nfArz2dtF2T1rF3bUE8jSAVp6yoYJQCwRz_SY2cO7yXKBkz.Y_l9SirWk6.KEhagigsI6KwTkaSP
 BYzDdZhYwn30uyW1Sj.93p4Wtj8GBBnVPw4M9deCqbiY5NFPQbi_kKPlM8y2SRxbtHlhULvuwspX
 FMwkKEzhRKZZgI8.EiNxa02bto5PHci4pf9q5uXq2vhMUSlfV9A5GHNy7.Vz0MyloqLVZuHXTHgm
 Q9SgeM1id6XunjhNLl.3TBkIZzIcEmIwrf9pmDF9.CS2xmzfSdJ0pHJZtJA9oxAFEqBB06PTQ5a5
 7xWBKe_y6HuJegBoi4Xc2C2k5a58xGT3HOkQ0lUsIinTSj0hDOUeXoDq6B6rzfOXao6POaEbfWdo
 CJt04Hf5.3wlEAKClwDmciQ8O3yONwSZyg1r7ZEHEUWCBypCI7xBbUs.v9LIrHGmNkRZZWN3eC1c
 bUxu.dOM8D_vbTjnusgxz7gXAeWqOUCaGWfPlJ8cPfkyd9fX2yvA6aLabR1VNKRAqg.YKYf8Y1z3
 2RGu_jT.EO6_yidOdSj4AgYeHBavGAjONO8T1anVw0HAKe0b.TAY1VB1EUSIDvOh5BZ4LHQJjTOl
 ld_23h0MdRGeQxaX_qXtheONVQykBrlDeoi3LGKlOrgfSl82iDH6UGe.Lxsq2dA4i2pQfWtO.zoP
 mNA1eM9GiW8_ckopYq4M6fIDdljm6rO7zgtVrlkJKqjBcImT6G112J_U6Od6i0ucZ4vrpO3JBqLN
 5Xf6FRCwFF_xD2SiGa6m1hOnnZ7h.hdMYQno26do3rsMg2PcxDNXAFUYujTlD7iqa0.QmAVh.w3A
 9mSSFIGJ.l1x0w2O5uQrmAWCblx_9ySekB414FdIZeRi6zK_Dye5TC_j0i3yWj8tQc_8JoyPBDFR
 QAZHx2XA8DurJuA0nv8eJkM4yJrSnCT0EEXIWuRNl7hOjFmmdYRKBOTrQlJUz.gLM3LOzY4.I.e7
 s5QWv.14pWED_OqKuIw6AMwozachdtWhLu8tc7HsBNNxtHT4f332K4Uxe9L65P1_luHL2jaQBwQJ
 ZB41suYSrAJ5UscHZq3q6beLSaxy3x3dPmqPtTtUqGOOkaU3adqxfFSMD7TqGsGdUgzvS57qj4q5
 sWbX1LMIYt5gzXgP1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Thu, 6 Feb 2020 14:12:20 +0000
Date: Thu, 6 Feb 2020 14:12:18 +0000 (UTC)
From: mike benz <mikebenz550@aol.com>
Message-ID: <1069591791.207224.1580998338297@mail.yahoo.com>
Subject: Contact Federal Reserve Bank New York to receive your inheritance
 contract payment  (US$12.8M)
MIME-Version: 1.0
References: <1069591791.207224.1580998338297.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15185 aolwebmail Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36
Message-ID-Hash: ZBUH7JMWLFPNZIZSMHOKGI2QA4FL5O2I
X-Message-ID-Hash: ZBUH7JMWLFPNZIZSMHOKGI2QA4FL5O2I
X-MailFrom: mikebenz550@aol.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZBUH7JMWLFPNZIZSMHOKGI2QA4FL5O2I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QXR0ZW50aW9uIEZ1bmQgQmVuZWZpY2lhcnkswqBDb250YWN0IEZlZGVyYWwgUmVzZXJ2ZSBCYW5r
IE5ldyBZb3JrIHRvIHJlY2VpdmUgeW91ciBpbmhlcml0YW5jZSBjb250cmFjdCBwYXltZW50wqAg
KFVTJDEyLjhNKVBheW1lbnQgUmVsZWFzZSBJbnN0cnVjdGlvbiBmcm9tIFVTIGRlcGFydG1lbnQg
b2YgSG9tZWxhbmQgU2VjdXJpdHkgTmV3IFlvcmsuQ29udGFjdCBGZWRlcmFsIFJlc2VydmUgQmFu
ayBOZXcgWW9yayB0byByZWNlaXZlIHlvdXIgaW5oZXJpdGFuY2UgY29udHJhY3QgcGF5bWVudMKg
IChVUyQxMi44TSnCoGRlcG9zaXRlZCB0aGlzIG1vcm5pbmcgaW4geW91ciBmYXZvci5Db250YWN0
IFBlcnNvbiwgRHIuIEplcm9tZSBILiBQb3dlbGwuwqBDRU8gRGlyZWN0b3IsIEZlZGVyYWwgUmVz
ZXJ2ZSBCYW5rIE5ldyBZb3JrwqBFbWFpbDogcmVzZXJ2ZWJhbmsubnk5M0BnbWFpbC5jb23CoFRl
bGVwaG9uZS0gKDkxNykgOTgzLTQ4NDYpwqBOb3RlLkkgaGF2ZSBwYWlkIHRoZSBkZXBvc2l0IGFu
ZCBpbnN1cmFuY2UgZmVlIGZvciB5b3UsYnV0IG9ubHkgbW9uZXkgeW91IGFyZSByZXF1aXJlZCB0
byBzZW5kIHRvIHRoZSBiYW5rIGlzICRVUzI1LjAwLHlvdXIgcHJvY2Vzc2luZyBmdW5kcyB0cmFu
c2ZlciBmZWUgb25seSB0byBlbmFibGUgdGhlbSByZWxlYXNlIHlvdXIgZnVuZHMgdG8geW91IHRv
ZGF5LlRoYW5rIHlvdSBmb3IgeW91ciBhbnRpY2lwYXRlZCBjby1vcGVyYXRpb24uVFJFQVQgQVMg
VVJHRU5ULk1yLiBSaWNoYXJkwqBMb25naGFpckRJUkVDVE9SIE9GIEZVTkRTIENMRUFSQU5DRSBV
TklUDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5z
dWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3Jn
Cg==
