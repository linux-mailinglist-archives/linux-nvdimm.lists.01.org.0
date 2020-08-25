Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EFD2514F5
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Aug 2020 11:06:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EB75F124DA71E;
	Tue, 25 Aug 2020 02:06:21 -0700 (PDT)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=74.6.129.83; helo=sonic317-28.consmr.mail.bf2.yahoo.com; envelope-from=sgtvivarob@gmail.com; receiver=<UNKNOWN> 
Received: from sonic317-28.consmr.mail.bf2.yahoo.com (sonic317-28.consmr.mail.bf2.yahoo.com [74.6.129.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2D533124DA717
	for <linux-nvdimm@lists.01.org>; Tue, 25 Aug 2020 02:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598346378; bh=I9cE52qY+/L3IUyr11oQWnUCHh04m6b8lIZvgDg8Tc0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=YMa+YvDubUqXyp18tHy5WuOkChqr6xPzGpUWJg3QBauQOSvUZ63S4FFNiGO0kfiONHQcvFW4DE42Mk3gRLrRqsd5VVc0B6q1SX5GkLxg8qtCqhgzi/VopgbLSZ9qb6Q8aar0wRFERkA4mGTGdloq1CxDH0R5vCmt3eNvzrECUcQjdzImJLQK1IADTUj62gp3hRdA9UgQ5bNzWHObrCfutkX45oa6S9VfcTDjxjpH7KvpET74mpZB/oAao2tyBQOpNfaiSPAkvsBruvayk+SafQcJvx/ISV+oQTmN2IPhZ5x5517OhJPCvSuBUVxra2KShVwLH+tgklRLQe7a6HcGwA==
X-YMail-OSG: 1W17tH4VM1kmLSscKhNMmY225XZl.jX1hgrZKijoa_k5XC.FczdPY9TSHeNtZWT
 uES7zejO6nif2B5xYdklqvvSeLJa3ugCn670uXiE4xEPeho5lbdjI2FInp1vZH.thdaRLrNMA7YM
 yCHO132PQpiZlYsmoRewya9d5JDyFn4f0MzpKx4y6u7TZ7AGFmYqcMuP_4KGZGBCcJyUjPO6tsW1
 vUyCKP6IVHGHtOlOQvG1xYPsVkdMwik_Lk9S1xaFUIAdQ8dvG0tQaZxolT6vDkGGkPtZlkesEMpV
 Q4jLkXALTqvBZETvJ4h3c.IJ9V0tc22jOif_fMoWyRCUuCqo_uDKOn34i_FNql6sM7WMCjLhntUh
 7HxNUj3z.xvqhGz6RI27jfBdeWzivcmcTxUx8Ek3_a5Yv7Psuc0Q.cqM0Gk5bAut8URK5rbG71DX
 vbpraYjClNbGegCHe4A4KMXg_qDLeE.hFfns_a2gAmIAiED7kESEYthVEXahi3RFTRNDEsLFuSSg
 MXFg8cikMFIytUS2Br9QRSfyF3I5QafK77uLZ22CwmYoJu_WDIloKkrQTI7UygQowbCXAqLzaW5l
 cSyLedXcKoe4DebKZhj_m_5AbbtgWeFatHfBNqLkjHdp0c_FjuhtiMmwyVRM0K6cYU03VqXHWc9O
 Uei9bb87Mp2.FPWx3INk75r3RBHz4SjG3YU0wsCJn8FTXqZJthkqzdqEEtbQcL6pM80sDkE157c9
 u2vhlAmVkdLLkVgLhzeA_HwBJG_Qul6tGntaM1zgOxANutzEKwJluApqGKupFMMFSsc8d72BOEi_
 8buJH6v.hxaPsA.OBqaTli02MbeZfW_V6RpbCCA17kmF4qYDH9O2aKxoHsadT4.EveWcohp2AFs3
 j.kVeryzFRDzVGc_.8MSMXp2K6cbZtEckZAX7V3VvtAfLydR.AefpaNnUiDW1aKG32oHiu0bZG5v
 eKUpoDAC.8liKNX6Tr_n7zOOC_QHp2VWxv3Fn_n1FZI5WlN6pME8RqZdKLquLJByEWf5f4vv8VTc
 ThY36KoXsGndHygHMawmB5HKKZg6RncKx2dMXnAikwPH.flVDFXULxJOCJt53yZk28KBOvdm55DV
 Kpl9HCKeprOgLM.hVLufTIJ.Eu0FpWqr53gTnxGsKhP9aOMDTwY4Jo_sYagtkfeEmv9r4wlK73TV
 Wn3oY0uimYuBZH_e4Rk7VXU157Quz.rtwnZF0.esP.F13HR.dID7ixeYNq9ipVTBlIPLUyRbKoBP
 y82AlAHL3xqMUpM_qQ_RA8R8VuMdLmH5wnqF2TwUDwt8BBo8477A.BRkK6UnR.IVnQm.d9UJrrQv
 1YYY7yyNGWhuHV09PaSI7lcfSWK5disfnpp1N.svYkxsOEckkbWGprReEliPfEXewbde3YwlDjPT
 TR4_jMQIANtWMKAy.whs4UZRbh.1TBiEQ9d4rM4oMzkE.1.vWSrfJ8Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Tue, 25 Aug 2020 09:06:18 +0000
Date: Tue, 25 Aug 2020 09:06:17 +0000 (UTC)
From: Sgt Vivian Robert <sgtvivarob@gmail.com>
Message-ID: <2141094906.5266174.1598346377848@mail.yahoo.com>
Subject: kindly respond to my mail
MIME-Version: 1.0
References: <2141094906.5266174.1598346377848.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:79.0) Gecko/20100101 Firefox/79.0
Message-ID-Hash: VLCCZCXYOOBN7OEJYDBEVT5VY6XDKG45
X-Message-ID-Hash: VLCCZCXYOOBN7OEJYDBEVT5VY6XDKG45
X-MailFrom: sgtvivarob@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: sgtvivarob@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VLCCZCXYOOBN7OEJYDBEVT5VY6XDKG45/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCkdvb2QgRGF5LCBJIGFtIGdsYWQgdG8gY29udGFjdCB5b3UgdGhyb3VnaCB0aGlzIG1lZGl1
bSBJ4oCZbSBTZ3QgVml2aWFuIFJvYmVydCBhbSBmcm9tIHVuaXRlZCBzdGF0ZSwgMjggeWVhcnMg
b2xkIHNpbmdsZSBJIGFtIHRoZSBvbmx5IHN1cnZpdmluZyBjaGlsZCBvZiBteSBsYXRlIHBhcmVu
dHMsIEkgYW0gQW1lcmljYSBmZW1hbGUgc29sZGllciBwcmVzZW50bHkgaW4gQWZnaGFuaXN0YW4g
Zm9yIHRoZSB0cmFpbmluZywgYWR2aXNpbmcgdGhlIEFmZ2hhbiBmb3JjZXMgYW5kIGFsc28gaGVs
cGluZyBpbiBzdGFiaWxpemluZyB0aGUgY291bnRyeSBhZ2FpbnN0IHNlY3VyaXR5IGNoYWxsZW5n
ZXMsIGFtIEFjdHVhbGx5IHNlZWtpbmcgeW91ciBhc3Npc3RhbmNlIHRvIGV2YWN1YXRlIHRoZSBz
dW0gb2YgJDMuNSBtaWxsaW9uLCBUaGlzIG1vbmV5IEkgZ290IGl0IGFzIG15IHJld2FyZCBpbiBz
ZXJ2aWNlIGJ5IEFmZ2hhbmlzdGFuIGdvdmVybm1lbnQgdG8gc3VwcG9ydCBtZSBmb3IgbXkgR29v
ZCBqb2IgaW4gdGhlaXIgbGFuZC4gUmlnaHQgbm93LCBJIHdhbnQgeW91IHRvIHN0YW5kIGFzIG15
IGJlbmVmaWNpYXJ5IGFuZCByZWNlaXZlIHRoZSBmdW5kIG15IGNlcnRpZmljYXRlIG9mIGRlcG9z
aXQgZnJvbSB0aGUgQmFuayB3aGVyZSB0aGlzIGZ1bmQgZGVwb3NpdGVkIGFuZCBteSBhdXRob3Jp
emF0aW9uIGxldHRlciBpcyB3aXRoIG1lIG5vdy5NeSBjb250YWN0IHdpdGggeW91IGlzIG5vdCBi
eSBteSBwb3dlciBidXQgaXQgaXMgZGl2aW5lbHkgbWFkZSBmb3IgR29kJ3MgcHVycG9zZSB0byBi
ZSBmdWxmaWxsZWQgaW4gb3VyIGxpdmVzLiBJIHdhbnQgeW91IHRvIGJlIHJlc3QgYXNzdXJlZCB0
aGF0IHRoaXMgdHJhbnNhY3Rpb24gaXMgbGVnaXRpbWF0ZSBhbmQgYSAxMDAlIHJpc2sgZnJlZSBp
bnZvbHZlbWVudCwgYWxsIHlvdSBoYXZlIHRvIGRvIGlzIHRvIGtlZXAgaXQgc2VjcmV0IGFuZCBj
b25maWRlbnRpYWwgdG8geW91cnNlbGYgLCB0aGlzIHRyYW5zYWN0aW9uIHdpbGwgbm90IHRha2Ug
bW9yZSB0aGFuIDcgd29ya2luZyBiYW5raW5nIGRheXMgZm9yIHRoZSBtb25leSB0byBnZXQgaW50
byB5b3VyIGFjY291bnQgYmFzZWQgb24geW91ciBzaW5jZXJpdHkgYW5kIGNvb3BlcmF0aW9uLiBp
IHdhbnQgeW91IHRvIHRha2UgNDAlIFBlcmNlbnQgb2YgdGhlIHRvdGFsIG1vbmV5IGZvciB5b3Vy
IHBlcnNvbmFsIHVzZSBXaGlsZSAyMCUgUGVyY2VudCBvZiB0aGUgbW9uZXkgd2lsbCBnbyB0byBj
aGFyaXR5LCBwZW9wbGUgaW4gdGhlIHN0cmVldCBhbmQgaGVscGluZyB0aGUgb3JwaGFuYWdlIHRo
ZSByZW1haW5pbmcgNDAlIHBlcmNlbnQgb2YgdGhlIHRvdGFsIG1vbmV5IC55b3Ugd2lsbCBhc3Np
c3QgbWUgdG8gaW52ZXN0IGl0IGluIGEgZ29vZCBwcm9maXRhYmxlIFZlbnR1cmUgb3IgeW91IGtl
ZXAgaXQgZm9yIG1lIHVudGlsIEkgYXJyaXZlIHlvdXIgY291bnRyeS4gSWYgeW914oCZcmUgd2ls
bGluZyB0byBhc3Npc3QgbWUgY29udGFjdCBtZSB0aHJvdWdoIG15IGVtYWlsIGFkZHJlc3Mg4oCc
c2d0dml2YXJvYkBnbWFpbC5jb20uDQoNClNndCBWaXZpYW4gUm9iZXJ0Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxp
c3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVt
YWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
