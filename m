Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF6B1A9182
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Apr 2020 05:24:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8495E11065560;
	Tue, 14 Apr 2020 20:25:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.6.135.125; helo=sonic310-15.consmr.mail.bf2.yahoo.com; envelope-from=svccv@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic310-15.consmr.mail.bf2.yahoo.com (sonic310-15.consmr.mail.bf2.yahoo.com [74.6.135.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CA52211064B89
	for <linux-nvdimm@lists.01.org>; Tue, 14 Apr 2020 20:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586921084; bh=E8d6yINuGiwhTg99MSrPuu24cfYbI9DLht69LRA8ork=; h=Date:From:Reply-To:Subject:References:From:Subject; b=mA3JmHG9UoWxbDz5TVf21cEc5YXr/pwCv/IDzvXxXsKcR1lWcszMIrGZP6nvlaMBmjkP/Vl7mgGvjuqV7S20xxXdI84COKP2/oJyJC/TSCPvAqM5U7UucOd/gisky+sxkrrU5oxsJ381RS5ZOG1qJt6o9YnpPgH2SJcrjml1xyc4j7ivDUihDh4tM7l2fxb7UW7UXCh2GWzWP1QEOHcCAmjT8VLDnBSON2S71WNcUYA2PxGxFm6909VK2wCzzR2JkHJK7vVUiDgeXsaenmnk/nImqeRi1dAiJtgjRgzDcgrMcfH8WHrZEJarWjGZgC6gOjIaBHVufUNTZid6BUoFAg==
X-YMail-OSG: XhNi2G8VM1kXN1e7Ndi9NXpLpYlXuNMm8r7n6zkf6yUx6uXfla3.t733nxZnYKK
 u6DphPy8eAZqarfqCmiz3n9XZ6i2aZwqbROjrUpEYEpryPe6DtEND_Yk6R0CRdm16TjrEKySpUH0
 giNsnXgI87dQt7QoQhiQWSNYwC85OhcL377SxKeHq8c8DS6yFBLCtApWCfg56cXaS_tbHTH9MZ7q
 SEZScszyXNf74eOm7kCZW9tc9nimz331DcgoVYgJGWenzhbxT6JeHCstKCLv_3uTyLUlQIjgxK35
 1uqGltV1kMm2rWEfdp8Bi7sCZMt1EsTL4ez1.jFCvjCQL44kriQx2lKxf3kXghXfoEIP4OC48rK1
 TJ03UqKbH3n23rURsV.RjbRaTEZAkHEZYaC5MbNEbAU54cXc6jL1jXwE2w9JEITp6LJP9MJocCF4
 wSpjqAiVOhOY89yrLUkwVErIvHbX2m3CMgoyZz64yE5Hvk05KiLpaIs4Om6HkyG_3xxAVSREBNZ_
 jakwGzEOQvFjydCN.C1Qh_ype0tLwhG06LPQpTBg0Nc8AWzdw6KThzTcpzwnqqXNJ80nNIFnIysa
 w_8xHrtESvXemWdZZgO.Czq191fmwsxD_UX4Rmgi2vf3XUXw.nK8.qSSOGquA43b73.y3iGRYXeC
 1.n8sFXf7oS0fwlKKAz9I3MOZiLMB_UdTFg1UfXZe9Pr.aVA5b3z4sS4LhyOHj6bj6iDowbF2XJV
 JEA1joUCUjnaw80rnMxRkhgu8ckrolVM_Quih6ea4qo.m3CwmBZCqOdn3ttYriUTeuv21ksGntuk
 UUaKnOxMsDMG1j0jmpjVCb29_L6puDgGngbpa8VGB.YAu.OBi7N5TaFXIjVDeNXkFBDnmw742G0i
 LGHk_g255Br54Qgcql939xqj4wIMEbrAHT_VZaNfTy21XkoKCKiw9nDsyg_rjPYYFd.AZgrE1j7c
 fQc7OpMZe5V896GA7DnTIpbgCj4UkjM4teqPLIV7k3VVpiolHLF_4ciSwpmGhf5TrckUCDVRBYB9
 PU7OeyLhcM1.lqlv7CChyzHNLHN57NHzN7UAHmg6rMlmJllqVUupMiqErz41s7XwbQVGdQ9cVM4v
 hlFjiwRPPwQtUNPebLQ6pkNIIL1WBsyekPdFvCWhVDVaOdG.jc5pzsDzp_PVZmD1mpZj_5GgpXbA
 1ItSebmBFHMyaBGZ5SB6M2FHc_jYo9ujKTZXG4KA_7OwqZh._MMMv8GLSi_WmV8H24dPZoZKwGwK
 30UQSH62NAn8QxJpANCWYdcRE_AaW9OOPNq.8pw8ds6gRUaw3odWKgQwHoNMn3VVLlFbHcISlERs
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 15 Apr 2020 03:24:44 +0000
Date: Wed, 15 Apr 2020 03:24:43 +0000 (UTC)
From: "Mrs. Rinehart Maaly Bob" <svccv@yahoo.com>
Message-ID: <257891168.496836.1586921083537@mail.yahoo.com>
Subject: Good Day Dear,
MIME-Version: 1.0
References: <257891168.496836.1586921083537.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15651 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:74.0) Gecko/20100101 Firefox/74.0
Message-ID-Hash: DZIC5VBOWTYBAYOVTTLDRY423HHAC2MZ
X-Message-ID-Hash: DZIC5VBOWTYBAYOVTTLDRY423HHAC2MZ
X-MailFrom: svccv@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mrsrinehartm719@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DZIC5VBOWTYBAYOVTTLDRY423HHAC2MZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

R29vZMKgRGF5wqBEZWFyZXN0LA0KDQpJwqBhbcKgTXJzLsKgUmluZWhhcnTCoE0uwqBCb2LCoGZy
b23CoEF1c3RyYWxpYS7CoEl0wqBpc8KgdW5kZXJzdGFuZGFibGXCoHRoYXTCoHlvdcKgbWF5wqBi
ZcKgYcKgYml0wqBhcHByZWhlbnNpdmXCoGJlY2F1c2XCoHlvdcKgZG/CoG5vdMKga25vd8KgbWU7
wqBJwqBmb3VuZMKgeW91csKgZW1haWzCoGFkZHJlc3PCoGZyb23CoGHCoEh1bWFuwqByZXNvdXJj
ZXPCoGRhdGHCoGJhc2XCoGFuZMKgZGVjaWRlZMKgdG/CoGNvbnRhY3TCoHlvdS7CoEnCoHdvdWxk
wqBsb3ZlwqB0b8KgZW1wbG95wqB5b3XCoGludG/CoG15wqBjaGFyaXR5wqB3b3JrO8KgScKgYW3C
oHJlYWR5wqB0b8KgZG9uYXRlwqBzb21lwqBtb25lecKgdG/CoHlvdcKgdG/CoGNhcnJ5wqBvbsKg
dGhlwqBDaGFyaXR5wqB3b3JrwqBpbsKgeW91csKgY291bnRyeS7CoFBsZWFzZcKgcmVwbHnCoHNv
wqB0aGF0wqBJwqB3aWxswqBnaXZlwqB5b3XCoGZ1cnRoZXLCoGRldGFpbHPCoGFuZMKgdGVsbMKg
eW91wqBhYm91dMKgbXlzZWxmwqB2aWHCoGVtYWlsOsKgbXJzcmluZWhhcnRtNzE5QGdtYWlsLmNv
bQ0KDQpUaGFua3PCoGFuZMKgR29kwqBibGVzc8KgeW91LA0KTXJzLsKgUmluZWhhcnTCoE0uwqBC
b2IuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1
YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
