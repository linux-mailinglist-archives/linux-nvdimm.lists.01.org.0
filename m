Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51287257807
	for <lists+linux-nvdimm@lfdr.de>; Mon, 31 Aug 2020 13:15:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D78B513995FA8;
	Mon, 31 Aug 2020 04:15:07 -0700 (PDT)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=66.163.184.200; helo=sonic301-31.consmr.mail.ne1.yahoo.com; envelope-from=aishiag85@gmail.com; receiver=<UNKNOWN> 
Received: from sonic301-31.consmr.mail.ne1.yahoo.com (sonic301-31.consmr.mail.ne1.yahoo.com [66.163.184.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4D8D113995FA4
	for <linux-nvdimm@lists.01.org>; Mon, 31 Aug 2020 04:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598872504; bh=RgqLpqdGDYhM0mKsBksMxBTYdHQLvOTgpdh1n173SR0=; h=Date:From:Subject:References:From:Subject; b=LAGA8vyjyZYuzOq1rQseAJDtuMW+7oNHfuh+sj9E/O8OZa+sdGmKnXEbSXbvrbqlmd/nD1PsB5En2Wc5sLqNn8zdhTbouej7VGEtt9qRT4/m/rDKM63RX9nWQM+HYYIWaYr84sZbdx9bkUlvRgAf7ruBuXw44j08Gr/DYQxZWu7hs2ERpqHlkSrhZrC+3aj2LWcxYFyVvh/8fGMgT7+pkja1kiLXPmee34Xyw0tyN0aXuMB3Yb1PTaIKY2jfBGyLMnOOsgNosiS8ACR7mhDjDDaRfLL6K/h7RPYFRvI6hcf1Ph7IrqygKdUOBV/CFBk0n0u1Ocqs0klCBmZM3IiZvg==
X-YMail-OSG: 6ToWpK8VM1l_F7Z_bbtJuOIkWnWhHP6eOBjLoXm61O8Y7MoSOpEMA0bZtFlAdlZ
 Fo13QrhNMjEQ3cUzbq3PrQsRiQ3bKPQtP93YPUFEM7K6YwPvqZP8sy09oX7lW2COvNKB3R_2FqpT
 kFVZynk8QZohhzqwR_qSef7RTN6ScIiaBVGiVoFZBqFoZTWa9pVbrQkiXNjlBWezaWBPypyG6lX1
 vkuH3pREp2wU4hLICDbb4RC9pcgzjUKSHihOpWwsGQWywotjA0cYhfXkulqCSfbbAp3RCfFjLg0J
 XFIPyz5OMha7z86sFgRrlYQJaFitCQyf8VA9Sr3byKwVl2vd2z08gvAQ4MwDU6lnd1k2EllAfCf5
 v0fhgE5o8rXIOHLXwhsLhWH_xq9Hzns9lX6TLUpVNeSlqCXgqmSiiRc3fx1xFawQjP9Yfjpdgyfz
 YU5_fx8VHY6znUzB11RuzZraGPwzhYm2t8MiJe8iFZ0hXWdXX6b.0eCAT_4SYl13YcqoyKUunaXq
 swmIbtQpvaUYXLmGVyEXuFZWAwWsxycOWP8D7JsKdyIf7xsDl0r5QuiDYypdUejeddEvsqDqc.37
 yszbgO_tc7YAPKaofFm0H6Pdx2theV36ILeCas1pN7otiSPPs6lm60mUmOkw6CB0vQB82ZjoskTf
 yCZIF2NcIPJOixDjvWFyxZzo7iaxmo2ZYJV40x3dig9qB2iR5_n6Z_ILv5DvqBKf4my_QQeQdgxE
 nQB1Keni3mWAp6rzBTaxhLNp5ydeWr7dnVrxlkrkqWdNSdQgDrlXGZcHxggOJGwS4LPX6pZhuEdJ
 eVjXTXViAidbzOqPd52JjDNUIIhdH6pZxY87LYQJnqegNyXWKE8.W1Lj2iTxk9wa1uY46ciBeWYW
 ykHTu_O9Kun6RjlKz59OXYP1uynJD0oP.wNlszBAD7IeVOAk1aP_x.SQLRPUcutIbqP84mwfrdqF
 keNLX160YSN0uViryhdlT1ae0rqq7gxdtDNPWa.0.V5.dJaueuykFkQWmBKf9.Mvok112i7ykDQV
 EdXPmgxUjcU852jhGxAMSVU0vVmHV2VZlrtOxAjW9WXFWmlnacD10IR.vWNYYXAsw6_fH9DlgKho
 ENuGdjvuq8Y1HozHb_uKb2Et.7jaB2cX2uGBU9l5mLdqbTIREN9q8io.9UjT8eDHA30cFqijnZt5
 bOM9ywzsuFYYikcYH2kkcd0uAvKaQFtrissns4OZehlP2MAW_8dFwNJuvyg6x8DxiXOnomH2Icrc
 ROg3ZNQysuuoAcokFqtx89Ixgx3lze.DQHkYQiWdy93A.DVYyH0Fujf4p.tYFxrZ2aRIaa7cD3c9
 US6Q_xiUxPJZQToUNbspM2_vmH2r584yRHyFulgTzJ8Mzwx_x4jbxgSjC623ctSSguAdxqlYu2Wl
 TwL8z6Co6sftYXxxcJkSkHEqK9rSzzlAB9dUY09uHuB3r4g.pUm1zVKZj
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 31 Aug 2020 11:15:04 +0000
Date: Mon, 31 Aug 2020 11:15:02 +0000 (UTC)
From: "aishiag85@gmail.com" <aishiag85@gmail.com>
Message-ID: <1092007894.729671.1598872502813@mail.yahoo.com>
Subject: hello dear please kindly reply my email is very urgent
MIME-Version: 1.0
References: <1092007894.729671.1598872502813.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNorrin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36
Message-ID-Hash: HRDFUZIXGOC7FC6IPSCHR764LOBOJXV6
X-Message-ID-Hash: HRDFUZIXGOC7FC6IPSCHR764LOBOJXV6
X-MailFrom: aishiag85@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HRDFUZIXGOC7FC6IPSCHR764LOBOJXV6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RGVhciBJIE5lZWQgQW4gSW52ZXN0bWVudCBQYXJ0bmVyDQpBc3NhbGFtdSBBbGFpa3VtIFdhIFJh
aG1hdHVsbGFoaSBXYSBCYXJha2F0dWgNCkRlYXIgRnJpZW5kLA0KSSBjYW1lIGFjcm9zcyB5b3Vy
IGUtbWFpbCBjb250YWN0IHByaW9yIGEgcHJpdmF0ZSBzZWFyY2ggd2hpbGUgaW4gbmVlZCBvZiB5
b3VyIGFzc2lzdGFuY2UuIEkgYW0gQWlzaGEgQWwtUWFkZGFmaSwgdGhlIG9ubHkgYmlvbG9naWNh
bCBEYXVnaHRlciBvZiBGb3JtZXIgUHJlc2lkZW50IG9mIExpYnlhIENvbC4gTXVhbW1hciBBbC1R
YWRkYWZpLiBBbSBhIHNpbmdsZSBNb3RoZXIgYW5kIGEgV2lkb3cgd2l0aCB0aHJlZSBDaGlsZHJl
bi4NCkkgaGF2ZSBpbnZlc3RtZW50IGZ1bmRzIHdvcnRoIFR3ZW50eSBTZXZlbiBNaWxsaW9uIEZp
dmUgSHVuZHJlZCBUaG91c2FuZCBVbml0ZWQgU3RhdGUgRG9sbGFyICgkMjcuNTAwLjAwMC4wMCAp
IGFuZCBpIG5lZWQgYSB0cnVzdGVkIGludmVzdG1lbnQgTWFuYWdlci9QYXJ0bmVyIGJlY2F1c2Ug
b2YgbXkgY3VycmVudCByZWZ1Z2VlIHN0YXR1cywgaG93ZXZlciwgSSBhbSBpbnRlcmVzdGVkIGlu
IHlvdSBmb3IgaW52ZXN0bWVudCBwcm9qZWN0IGFzc2lzdGFuY2UgaW4geW91ciBjb3VudHJ5LCBt
YXkgYmUgZnJvbSB0aGVyZSwgd2UgY2FuIGJ1aWxkIGJ1c2luZXNzIHJlbGF0aW9uc2hpcCBpbiB0
aGUgbmVhcmVzdCBmdXR1cmUuDQpJIGFtIHdpbGxpbmcgdG8gbmVnb3RpYXRlIGludmVzdG1lbnQv
YnVzaW5lc3MgcHJvZml0IHNoYXJpbmcgcmF0aW8gd2l0aCB5b3UgYmFzZSBvbiB0aGUgZnV0dXJl
IGludmVzdG1lbnQgZWFybmluZyBwcm9maXRzLsKgSWYgeW91IGFyZSB3aWxsaW5nIHRvIGhhbmRs
ZSB0aGlzIHByb2plY3Qgb24gbXkgYmVoYWxmIGtpbmRseSByZXBseSB1cmdlbnQgdG8gZW5hYmxl
IG1lIHByb3ZpZGUgeW91IG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgdGhlIGludmVzdG1lbnQgZnVu
ZHMuDQoNCllvdXIgVXJnZW50IFJlcGx5IFdpbGwgQmUgQXBwcmVjaWF0ZWRCZXN0IFJlZ2FyZHNN
cnMgQWlzaGEgQWwtUWFkZGFmaQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBs
aXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0t
bGVhdmVAbGlzdHMuMDEub3JnCg==
