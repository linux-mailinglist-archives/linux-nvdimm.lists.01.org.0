Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAD024EF5E
	for <lists+linux-nvdimm@lfdr.de>; Sun, 23 Aug 2020 21:09:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 99A261360A370;
	Sun, 23 Aug 2020 12:09:08 -0700 (PDT)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=77.238.177.82; helo=sonic305-20.consmr.mail.ir2.yahoo.com; envelope-from=bell.val@hotmail.com; receiver=<UNKNOWN> 
Received: from sonic305-20.consmr.mail.ir2.yahoo.com (sonic305-20.consmr.mail.ir2.yahoo.com [77.238.177.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 930C71216B38D
	for <linux-nvdimm@lists.01.org>; Sun, 23 Aug 2020 12:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598209744; bh=xqLytl9SaMxbq7E4XpYqfxEXmGbXz9/e0+E3fhi3pro=; h=Date:From:Reply-To:Subject:References:From:Subject; b=MjoUHT+x1AcDHTJDuBFmzlsiOZqq9ba33NIQtKm+AcKN12srrKnFXhZCvd9L7MmvG7qH6g6ETXGIjuezCh7v6VdNVFKgUAQ3TaXHWAJ21GdzlnfotScPxEbUxUiWhss0AXTYLN6hRGYV+Rv7eo+u7QtcpmUdyDgH5MV0Gjzbdr24NFUUV7FUuCsN/vEt8mNaTeFEbkU590wh4hBQ/nJMJT4ydEPVy+UsqBtct/YuRkbdHge+5+qEx+8IcfxL5cwjR0VuZAIDs0d5lGZtInf7E/0INOBFveyWAs+xsThDkou6NsIC7cbKBUCIVvZ5P4moJ4hQ5ZgtltfXPkjIZGNsYQ==
X-YMail-OSG: 1HeY3bQVM1ndbVDN0wAbpl0PzCc.oTB8vAvDiDA8j3gGK0j2ebtAzm0kKm9c0gO
 8DmNgamU_rOh_Q1MuoicgJtN4gEtSCvxldFKeD3.nJCGNdIfXYWlcyJXGCqFjmKPZLYQjTCMdoS5
 eBkxjdxmjityYtiZBlEUgtaJ5RkcWgQdtW8ES6HqyP7IynH9Dt7d1U1aseLbNy5VfW3toHYc56jh
 zg2FT7wtc4Qrn035sH3tfPJGstLfeVA_Ffnn0KtCcteL5yVkN9ei4gV3fXSzbX8QKusWo8nnTcyY
 g5zssipVv2h9Ehydm0HrEyxoYfkEjBLncBqM6sySdBtaow8tNmLcztoESu99QmCslH536lLLWlDj
 FlvhMQQqB91mhCDY5umyA67hfUr9VcoaixTir1X.ObQfnp0vcrbtjRTtSFR4ZWJHIBz6QCnNDJ0D
 iMxNL6AjXKiUVzCa6rBxmcIlyVs.k12L7n_FbZ77BOygqG8lvj023006CLTFHWoDovpEv2KjSib3
 cl2tqts96Y69rwy17HrITF3YGQk4FTP4IP2nIraA5IG6d3Sr07RqbNgsavOGw53Z_P9YutBVUW.6
 t_IeXdh59jEwGd2oKDZKveoD.HEKQjzIPe66dnXfcLVRrd85EVcCm97rg0q99u3spi962jJrlqUR
 3Pxu6KBv8udnUegMdJ6m7jXsH_4BGut3Yitt.Dyp1p_Ele1kuMy28.eNSPACOVbtvUqe8.m13U2r
 7a2RMSHcqx4HkVvHIPBns0StvvNQVHYj7_znFyh0iZuXSDxtZ2nEVY_VfsAeu9T7cqpSSOT10Ivp
 3l6KNu21Yzqomus3wcG.uTQg7Qp1xzd9_EBBmT7EAx5ZpTnOtuDFBBw4uypg04kVs4wYCi0vn8gF
 AfS4POCHppL75_utiF8zpb.KjItjhRKafHUd7Tho0Nj21mpdkykXSTBajO2eh6HjkYWcDNOHWMW.
 TEq7imgfkAjc9FeaFjlV2i0J8oqJHawh78VvpC7PijCcjUpC0Azu79SCjw1sayCY3nSkVyNAzC4x
 ePrcZsUdJAqvNf59m5JcFYa.FzEQZw2qhNJksl.cgJ8umDLpuRxYkLzAZTcnksZgKWmNL2QpJTSB
 bnpvHK9K5Fd.1bnrIhmZqrxz_EiTzvLe50zflokjIQjEDJkFLKTGxHKB5V9lmciW6vh9oESBHqfc
 vAhEvWHaDFszUGEdveVTcvcdVml5eZ9rHT.Egv7PdUdPEqIuCx0lOEKT2wcZTdufuKxsVsrnxXcA
 9Y6CqDMxIxvkwfxjeP51OPrmo47VKvY08TxhMsgFqfCCreM7o0g8QkjBZgQX77fpX7Y49tlhWduG
 tLy9wjSkdwe7h_BPFimTftCgCPh_4hJf_EExU.WDH6zNZoHhUfmsOmjk8iAvz2ngx39cn.METGXp
 NOsj62SO.w641jiEZQoo3nW1QMbxsTjmxONh9pLl0YhFQi0UJr0Y-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Sun, 23 Aug 2020 19:09:04 +0000
Date: Sun, 23 Aug 2020 19:09:01 +0000 (UTC)
From: Valerie Bell <bell.val@hotmail.com>
Message-ID: <495092292.7378370.1598209741137@mail.yahoo.com>
Subject: Salut
MIME-Version: 1.0
References: <495092292.7378370.1598209741137.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNorrin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.0 Safari/537.36
Message-ID-Hash: 7TQABVVVTXYQBWNP3NZHAX5Q4P6UJQ22
X-Message-ID-Hash: 7TQABVVVTXYQBWNP3NZHAX5Q4P6UJQ22
X-MailFrom: bell.val@hotmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: Valerie Bell <bell-va@hotmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7TQABVVVTXYQBWNP3NZHAX5Q4P6UJQ22/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCg0KDQpEw6lzb2zDqWUgcG91ciBjZXR0ZSBhcHByb2NoZSBpbmF0dGVuZHVlLCBqZSBzdWlz
IFZhbMOpcmllIHF1aSBkw6lzaXJlIHZvdHJlIGFtaXRpw6kgc2luY8OocmUgc2kgY2VsYSBuZSB2
b3VzIGEgZMOpcmFuZ2UgcGFzLCBqZSByZXN0ZSDDoCBsIMOpY291dGUNCg0KU2luY8OocmVzIFNh
bHV0YXRpb25zDQpWYWzDqXJpZSBCZWxsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1t
QGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGlt
bS1sZWF2ZUBsaXN0cy4wMS5vcmcK
