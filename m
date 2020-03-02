Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0AD1762E9
	for <lists+linux-nvdimm@lfdr.de>; Mon,  2 Mar 2020 19:42:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 973FD10FC35BF;
	Mon,  2 Mar 2020 10:43:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4C58D1007B1C5
	for <linux-nvdimm@lists.01.org>; Mon,  2 Mar 2020 10:43:09 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id r16so256354oie.6
        for <linux-nvdimm@lists.01.org>; Mon, 02 Mar 2020 10:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+8nfoKR15NmxwB0eviFINMK7mfZ/bWjSvXOrhjIWgPw=;
        b=CPm8ZJw3+TWEjm2lgHBD+rU3/76tOPOt/12fFrgnw2C+/jUxelaXCBy/mledMuM2H4
         UlAIyFz070RaCXY/KEZln/OokcFWj7YxyxPjwaN35ZO3D/q/BDSWAYwsvNEO+nt31v7D
         49Fax9alh1vhw1rCVJrTQYmQBkemdlKDDBgXcDmdS4MqnUEeqaaULI1Dog21/vZ9Quzl
         U6ZoxWzBEw6oxC63miSYvzacQ3XQyRUEWCwa16y36z1EtbdkjlHFU/DB78WUlcsAgTQj
         X4vnNZR9pmMEaoIOyifJCVVs0MyiH0ZaOQ7V6UDcVmgE5ZGcbH8uFVpH1Adv5G/V1hVJ
         M83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+8nfoKR15NmxwB0eviFINMK7mfZ/bWjSvXOrhjIWgPw=;
        b=WQe3Ktb3lMin9NeA2QhmwVaP0gqyKfm8Vy8+Z2rhMb/C2jpaPdFfTpqa5iuuJOax2Q
         mMOq6/9TPznrmPMjV059tzS1Yvj+abxuGfbbM9bG8JEqeNY5DhD8nRdGssHwEDvrlznj
         eBZaA4TmZL2z4mwyf1XaNljBPwZSbmBzl1Bh0r0A0rKvE473ZGT8MO8ELZc2FgqupdkV
         VIV9kprw2qGmLvEItPLPI0Ww23Kfr/7uhXq9bdYnKi9m3f8md+pIhH5f9zlwGVzvZwss
         1/8Dwruq7nEp0SPjGvZMCurgpy3PZAJ7tX5lDnvFajeKauntNex57k9hjKO59g/IjGxT
         ludA==
X-Gm-Message-State: ANhLgQ1n+R4UFM/J8psbxly7qT+gYfWwBVpOag5cXqaxE6D9x1UgWd3+
	8JUGu/h4nW5SaKCeZH0vSEdJ2/xHjaD1mNiy3Rr35Q==
X-Google-Smtp-Source: ADFU+vvxBj3MBEqz5EKGoBOP9Q8Qnffyo4RLmccwHWhZAvKECUrDC084nmiZgFmtaJWkabRCBnu8WgzsenpBXgnwu2k=
X-Received: by 2002:a54:4098:: with SMTP id i24mr9465oii.149.1583174537330;
 Mon, 02 Mar 2020 10:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20200221032720.33893-1-alastair@au1.ibm.com> <20200221032720.33893-16-alastair@au1.ibm.com>
 <9e40ad40-6fa8-0fd2-a53a-8a3029a3639c@linux.ibm.com>
In-Reply-To: <9e40ad40-6fa8-0fd2-a53a-8a3029a3639c@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 2 Mar 2020 10:42:06 -0800
Message-ID: <CAPcyv4gCCjQFnLaSpRPEuKoDq3gOHSxjxLT_=X3N_nr=2ZOcSA@mail.gmail.com>
Subject: Re: [PATCH v3 15/27] powerpc/powernv/pmem: Add support for near
 storage commands
To: Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID-Hash: ZQBEMAEWOHTNKZ4UKAGZJ5LSNMX3VXRT
X-Message-ID-Hash: ZQBEMAEWOHTNKZ4UKAGZJ5LSNMX3VXRT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashev
 skiy <aik@ozlabs.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZQBEMAEWOHTNKZ4UKAGZJ5LSNMX3VXRT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gTW9uLCBNYXIgMiwgMjAyMCBhdCA5OjU5IEFNIEZyZWRlcmljIEJhcnJhdCA8ZmJhcnJhdEBs
aW51eC5pYm0uY29tPiB3cm90ZToNCj4NCj4NCj4NCj4gTGUgMjEvMDIvMjAyMCDDoCAwNDoyNywg
QWxhc3RhaXIgRCdTaWx2YSBhIMOpY3JpdCA6DQo+ID4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8
YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+ID4NCj4gPiBTaW1pbGFyIHRvIHRoZSBwcmV2aW91cyBw
YXRjaCwgdGhpcyBhZGRzIHN1cHBvcnQgZm9yIG5lYXIgc3RvcmFnZSBjb21tYW5kcy4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEFsYXN0YWlyIEQnU2lsdmEgPGFsYXN0YWlyQGQtc2lsdmEub3Jn
Pg0KPiA+IC0tLQ0KPg0KPg0KPiBJcyBhbnkgb2YgdGhlc2UgbmV3IGZ1bmN0aW9ucyBldmVyIGNh
bGxlZD8NCg0KVGhpcyBpcyBteSBjb25jZXJuIGFzIHdlbGwuIFRoZSBsaWJudmRpbW0gY29tbWFu
ZCBzdXBwb3J0IGlzIGxpbWl0ZWQNCnRvIHRoZSBjb21tYW5kcyB0aGF0IExpbnV4IHdpbGwgdXNl
LiBPdGhlciBwYXNzdGhyb3VnaCBjb21tYW5kcyBhcmUNCnN1cHBvcnRlZCB0aHJvdWdoIGEgcGFz
c3Rocm91Z2ggaW50ZXJmYWNlLiBIb3dldmVyLCB0aGF0IHBhc3N0aHJvdWdoDQppbnRlcmZhY2Ug
aXMgZXhwbGljaXRseSBsaW1pdGVkIHRvIHB1YmxpY2x5IGRvY3VtZW50ZWQgY29tbWFuZCBzZXRz
IHNvDQp0aGF0IHRoZSBrZXJuZWwgaGFzIGFuIG9wcG9ydHVuaXR5IHRvIGNvbnN0cmFpbiBhbmQg
Y29uc29saWRhdGUNCmNvbW1hbmQgaW1wbGVtZW50YXRpb25zIGFjcm9zcyB2ZW5kb3JzLgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0g
bWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUg
c2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
