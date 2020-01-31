Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CEE14E829
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 Jan 2020 06:14:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 61D2C10FC3169;
	Thu, 30 Jan 2020 21:18:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C914D1003E991
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 21:18:03 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id i1so6102542oie.8
        for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 21:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PMcuS4LHry0i7DZ7ldtekzqzj8KrQxFLARw5rUFC3dY=;
        b=YB4BUNePIM6enPmASfYT3cwjHuMA+cOwjd5AU1JFMP5dn8Yq9YXqx0L53gjl6Gyzkl
         5kG1BNLepiYkWJbao814Aj5KzNKw/SxFciSCG9pAPQ1Vl31Lb+FRijSu2RlvWwqxmz1V
         t5OFCVsaMUxgTHH27jx3c7DfQTOYiNeCNZHhh4U1dkxfAuDoeJ0RoCD5pWybXaXBKCgR
         5lg6a4vN6IMCyAVqu8i3QQhIjzPPi0qOUgutCMcqCoyTr/+f3QgmReQ1QgRvUUQDoQAM
         nEeQT5nqUOxl1z7kuLI9kthwhBXP3Zyf9wOXQ/9C1+PkspbY4Qep23XKZEohNh4rbaAF
         79HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PMcuS4LHry0i7DZ7ldtekzqzj8KrQxFLARw5rUFC3dY=;
        b=hkggMJoeE18P7bYL6+E44zNqThDcnwliQ4MsiTMonSnXWAUWJqjLY3uvWLfaKUeLul
         Ip1j9NOusBiJMHqTUejf/rzPzzQC8mZO7sz/aqJfNcpTQ6uq61MZZU+/tDXwTe+xIu25
         2q7X6RnV0Zqp6sfsopZgjJNRMb85FHx0NzMYh4pM6PKkG7DbKK3d797/VAHCmAiKB9tO
         cv4RimD4mCYXdAiFhp08tvb3FuC1P6jDOCu45RigxWctewFOAjn3KQDAW2LuK1Y7WA0i
         ZAd3sQ4D6+7uMS0fNVTRNrvmVOCVwLxTs+U5/y9OnSDHd8QWYECmaFCdfcVJ2ToHvjtT
         +KjQ==
X-Gm-Message-State: APjAAAUZSehNqmQqjaHbEmzCliTRPHip9VD0/+V6uZahuJa4goVIr69X
	LPp0pLc8O5SfXn0h+95cEaAT24whLwb7mnku0HA6Lg==
X-Google-Smtp-Source: APXvYqxj9SjLEO7AhYfAHVo9xLBu9Nup8mW6BzzYMbNeUvMlioFhNe3oNXeD4an0sNTe/yFKjrfStHsB04BMKeaIBuc=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr5446118oij.0.1580447684795;
 Thu, 30 Jan 2020 21:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20191025044721.16617-1-alastair@au1.ibm.com> <20191025044721.16617-10-alastair@au1.ibm.com>
 <3ba57ce6-9135-0d83-b99d-1c5b0c744855@linux.ibm.com> <df24e47c2bd9472c7be06c6c266b2a250c30068f.camel@au1.ibm.com>
In-Reply-To: <df24e47c2bd9472c7be06c6c266b2a250c30068f.camel@au1.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 30 Jan 2020 21:14:33 -0800
Message-ID: <CAPcyv4iwiMS6VZLvJad-Z9Psu9LRwfhqO643EzVRsk89qy6dwA@mail.gmail.com>
Subject: Re: [PATCH 09/10] powerpc: Enable OpenCAPI Storage Class Memory
 driver on bare metal
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Message-ID-Hash: BCKNLRL6HGP34NPY7EJCHBDVD2GMBUNP
X-Message-ID-Hash: BCKNLRL6HGP34NPY7EJCHBDVD2GMBUNP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Frederic Barrat <fbarrat@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, David Hildenbrand <david@redhat.com>, Wei Yang <richard.weiyang@gmail.com>, Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Krzysztof Kozlowski <krzk@kernel.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kurz <groug@kaod.org>, Qian Cai <cai@lca.pw>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Hari Bathini <hbathini@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-founda
 tion.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BCKNLRL6HGP34NPY7EJCHBDVD2GMBUNP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBKYW4gMzAsIDIwMjAgYXQgODo1NyBQTSBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFp
ckBhdTEuaWJtLmNvbT4gd3JvdGU6DQo+DQo+IE9uIEZyaSwgMjAxOS0xMS0wOCBhdCAwODoxMCAr
MDEwMCwgRnJlZGVyaWMgQmFycmF0IHdyb3RlOg0KPiA+DQo+ID4gTGUgMjUvMTAvMjAxOSDDoCAw
Njo0NywgQWxhc3RhaXIgRCdTaWx2YSBhIMOpY3JpdCA6DQo+ID4gPiBGcm9tOiBBbGFzdGFpciBE
J1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4gPiA+DQo+ID4gPiBFbmFibGUgT3BlbkNB
UEkgU3RvcmFnZSBDbGFzcyBNZW1vcnkgZHJpdmVyIG9uIGJhcmUgbWV0YWwNCj4gPiA+DQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4N
Cj4gPiA+IC0tLQ0KPiA+ID4gICBhcmNoL3Bvd2VycGMvY29uZmlncy9wb3dlcm52X2RlZmNvbmZp
ZyB8IDQgKysrKw0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4g
Pg0KPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9jb25maWdzL3Bvd2VybnZfZGVmY29u
ZmlnDQo+ID4gPiBiL2FyY2gvcG93ZXJwYy9jb25maWdzL3Bvd2VybnZfZGVmY29uZmlnDQo+ID4g
PiBpbmRleCA2NjU4Y2NlYjkyOGMuLjQ1YzBlZmY5NDk2NCAxMDA2NDQNCj4gPiA+IC0tLSBhL2Fy
Y2gvcG93ZXJwYy9jb25maWdzL3Bvd2VybnZfZGVmY29uZmlnDQo+ID4gPiArKysgYi9hcmNoL3Bv
d2VycGMvY29uZmlncy9wb3dlcm52X2RlZmNvbmZpZw0KPiA+ID4gQEAgLTM1MiwzICszNTIsNyBA
QCBDT05GSUdfS1ZNX0JPT0szU182ND1tDQo+ID4gPiAgIENPTkZJR19LVk1fQk9PSzNTXzY0X0hW
PW0NCj4gPiA+ICAgQ09ORklHX1ZIT1NUX05FVD1tDQo+ID4gPiAgIENPTkZJR19QUklOVEtfVElN
RT15DQo+ID4gPiArQ09ORklHX09DWExfU0NNPW0NCj4gPiA+ICtDT05GSUdfREVWX0RBWD15DQo+
ID4gPiArQ09ORklHX0RFVl9EQVhfUE1FTT15DQoNClRoaXMgc3BlY2lmaWMgbGluZSBpcyBub3Qg
bmVlZGVkIHNpbmNlIERFVl9EQVhfUE1FTSBhbHJlYWR5IGRlZmF1bHRzIHRvIERFVl9EQVguDQoN
Cj4gPiA+ICtDT05GSUdfRlNfREFYPXkNCj4gPg0KPiA+IElmIHRoaXMgcmVhbGx5IHRoZSBpbnRl
bnQgb3IgZG8gd2Ugd2FudCB0byBhY3RpdmF0ZSBEQVggb25seSBpZg0KPiA+IENPTkZJR19PQ1hM
X1NDTSBpcyBlbmFibGVkPw0KPiA+DQo+ID4gICAgRnJlZA0KPg0KPiBXZSBoYWQgYSBiaXQgb2Yg
YSBwbGF5IGFyb3VuZCB3aXRoIHJld29ya2luZyB0aGlzIHRoZSBvdGhlciBkYXkuDQo+DQo+IFB1
dHRpbmcgdGhlbSBpbiBhcyBkZXBlbmRzIGRpZG4ndCBtYWtlIHNlbnNlLCBhcyB0aGV5IGFyZSAi
c29mdCINCj4gZGVwZW5kYW5jaWVzIC0gdGhlIGRyaXZlciB3b3JrcyBhbmQgeW91IGNhbiBkbyBz
b21lIHRoaW5ncyB3aXRob3V0IERBWC4NCj4NCj4gQWRkaW5nIHRoZW0gYXMgc2VsZWN0cyB3YXMg
cmVqZWN0ZWQgYXMgc2VsZWN0aW5nIHN5bWJvbHMgdGhhdCBjYW4gYWxzbw0KPiBiZSBtYW51YWxs
eSBzZWxlY3QgaXMgZGlzY291cmFnZWQuDQo+DQo+IFdlIGVuZGVkIHVwIGdvaW5nIGZ1bGwgY2ly
Y2xlIGFuZCBhZGRpbmcgdGhlbSBiYWNrIHRvIHRoZSBkZWZjb25maWcuDQoNClRoaXMgZG92ZXRh
aWxzIHdpdGggYSBzdWdnZXN0aW9uIERhdmUgbWFkZSBhIHdoaWxlIGJhY2sgWzFdLiBHaXZlbiBh
bGwNCnRoZSBwaWVjZXMgdGhhdCBuZWVkIHRvIGJlIHR1cm5lZCBvbiB0byBoYXZlIGEgImZlYXR1
cmUgY29tcGxldGUiDQpwZXJzaXN0ZW50IG1lbW9yeSBlbmFibGVkIGJ1aWxkIGl0IHdvdWxkIGJl
IG5pY2UgdG8gaGF2ZSBnZW5lcmFsDQpjb25maWcgc3ltYm9scyB0aGF0IGdvIGFuZCBzZWxlY3Qg
YWxsIHRoZSBuZWNlc3NhcnkgZGVwZW5kZW5jaWVzIGZvcg0KREFYLCBhbmQgbGV0IHRoZSByZXN0
IGhhcHBlbiBieSBkZWZhdWx0Lg0KDQpbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAxNjExMjkwMjEwNTIuR0YyODE3N0BkYXN0YXJkLwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4
LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51
eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
