Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002A41E87A9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 29 May 2020 21:22:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 08F6D100EC1C1;
	Fri, 29 May 2020 12:18:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CCD45100EC1C0
	for <linux-nvdimm@lists.01.org>; Fri, 29 May 2020 12:18:10 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id mb16so3158413ejb.4
        for <linux-nvdimm@lists.01.org>; Fri, 29 May 2020 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9X2RhbHpvQQWdJgG+rpDfMX39zeo7wJFaELQ6KhPm6M=;
        b=rdJ82H+bjX2Gv9A+KMnS2QDMaBvm3JPGpNwdOyKF8paQeibljoeRq8ZqbW5tTPLUnR
         mZpJpiohWBlp8+JSqCs8MK2tQRTQkyaXmf5UohRXwoGKD5FyEC2qMQemf6ZTKESEPSKW
         BgzaWyARf377pTXaDvoZytFxTSNnK+I7hyzQjT5jWSZkmMN6Vjxb7rMHZd08H5EqUHQw
         mntFhUIGIVTuat8+CiRektwy/DRc6nR/68pJqTL95f1qEd+tty0FjQa5WnxywS42tNah
         9ZW49t+DOSaZSOVr2K04KrdHe4v1e0kOrhG7pafH5z2MY5BZu4B7aTiAIU6OugV5TbD+
         eWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9X2RhbHpvQQWdJgG+rpDfMX39zeo7wJFaELQ6KhPm6M=;
        b=PsXEyy9hM24XqKqUP4Sx0mjaDPefXQFGvT4aUAw+nBDrSSbMmMZfk8QTA9xOMJjMFv
         cwJBZN/eiTvmH/BhLGDQS6mCf3okbrD1wObZghiIHJcg4OXkqeoj4hKGB3onSXBUWDjI
         1A8dr5uUvZxB4uncL3OoS/lnJ3F30CE+q5bAcC5opuUs662q+U85x1Li2Hx5tRdVC0ul
         srPJG1YYuQ29jG/1NYpbHHWavuplbVR+uYIlpSAUh+FXQFQCdVCulolzme5Xshi/Gnts
         uVvjYjSXT5wc5yyxXtolETwg1N8RG1fSdvkz8BEurnu7WQs0J45GQzrh+ch9lxSQAXFy
         Mw6Q==
X-Gm-Message-State: AOAM532kJnXY5NLZq5oWIoTe+ntJlfDHyAxfFm8baDdHoG9QzE72tcbu
	I9AEMrvB+T4uWx8PurMtf25zbC6ggW6zdO0g4lJoZw==
X-Google-Smtp-Source: ABdhPJzum/mYcTnGeuqk7gwPNlvHhhq3mfr+YHecVR28MHiifUQfUZlTNj0oRorKQAVZCIu2WSWtv7TSFR0Mfot8Enc=
X-Received: by 2002:a17:906:f745:: with SMTP id jp5mr9489606ejb.440.1590780154704;
 Fri, 29 May 2020 12:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200529054141.156384-1-aneesh.kumar@linux.ibm.com>
 <20200529093310.GL25173@kitsune.suse.cz> <6183cf4a-d134-99e5-936e-ef35f530c2ec@linux.ibm.com>
 <20200529095250.GP14550@quack2.suse.cz> <7e8ee9e3-4d4d-e4b9-913b-1c2448adc62a@linux.ibm.com>
In-Reply-To: <7e8ee9e3-4d4d-e4b9-913b-1c2448adc62a@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 29 May 2020 12:22:23 -0700
Message-ID: <CAPcyv4jrss3dFcCOar3JTFnuN0_pgFNtBPiJzUdKxtiax6pPgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] libnvdimm: Add prctl control for disabling
 synchronous fault support.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: Z55V67QWVVLS2EB4ZQ6V4JA3MN2YXPAW
X-Message-ID-Hash: Z55V67QWVVLS2EB4ZQ6V4JA3MN2YXPAW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, jack@suse.de, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z55V67QWVVLS2EB4ZQ6V4JA3MN2YXPAW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBNYXkgMjksIDIwMjAgYXQgMzo1NSBBTSBBbmVlc2ggS3VtYXIgSy5WDQo8YW5lZXNo
Lmt1bWFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPg0KPiBPbiA1LzI5LzIwIDM6MjIgUE0sIEph
biBLYXJhIHdyb3RlOg0KPiA+IEhpIQ0KPiA+DQo+ID4gT24gRnJpIDI5LTA1LTIwIDE1OjA3OjMx
LCBBbmVlc2ggS3VtYXIgSy5WIHdyb3RlOg0KPiA+PiBUaGFua3MgTWljaGFsLiBJIGFsc28gbWlz
c2VkIEplZmYgaW4gdGhpcyBlbWFpbCB0aHJlYWQuDQo+ID4NCj4gPiBBbmQgSSB0aGluayB5b3Un
bGwgYWxzbyBuZWVkIHNvbWUgb2YgdGhlIHNjaGVkIG1haW50YWluZXJzIGZvciB0aGUgcHJjdGwN
Cj4gPiBiaXRzLi4uDQo+ID4NCj4gPj4gT24gNS8yOS8yMCAzOjAzIFBNLCBNaWNoYWwgU3VjaMOh
bmVrIHdyb3RlOg0KPiA+Pj4gQWRkaW5nIEphbg0KPiA+Pj4NCj4gPj4+IE9uIEZyaSwgTWF5IDI5
LCAyMDIwIGF0IDExOjExOjM5QU0gKzA1MzAsIEFuZWVzaCBLdW1hciBLLlYgd3JvdGU6DQo+ID4+
Pj4gV2l0aCBQT1dFUjEwLCBhcmNoaXRlY3R1cmUgaXMgYWRkaW5nIG5ldyBwbWVtIGZsdXNoIGFu
ZCBzeW5jIGluc3RydWN0aW9ucy4NCj4gPj4+PiBUaGUga2VybmVsIHNob3VsZCBwcmV2ZW50IHRo
ZSB1c2FnZSBvZiBNQVBfU1lOQyBpZiBhcHBsaWNhdGlvbnMgYXJlIG5vdCB1c2luZw0KPiA+Pj4+
IHRoZSBuZXcgaW5zdHJ1Y3Rpb25zIG9uIG5ld2VyIGhhcmR3YXJlLg0KPiA+Pj4+DQo+ID4+Pj4g
VGhpcyBwYXRjaCBhZGRzIGEgcHJjdGwgb3B0aW9uIE1BUF9TWU5DX0VOQUJMRSB0aGF0IGNhbiBi
ZSB1c2VkIHRvIGVuYWJsZQ0KPiA+Pj4+IHRoZSB1c2FnZSBvZiBNQVBfU1lOQy4gVGhlIGtlcm5l
bCBjb25maWcgb3B0aW9uIGlzIGFkZGVkIHRvIGFsbG93IHRoZSB1c2VyDQo+ID4+Pj4gdG8gY29u
dHJvbCB3aGV0aGVyIE1BUF9TWU5DIHNob3VsZCBiZSBlbmFibGVkIGJ5IGRlZmF1bHQgb3Igbm90
Lg0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogQW5lZXNoIEt1bWFyIEsuViA8YW5lZXNo
Lmt1bWFyQGxpbnV4LmlibS5jb20+DQo+ID4gLi4uDQo+ID4+Pj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9mb3JrLmMgYi9rZXJuZWwvZm9yay5jDQo+ID4+Pj4gaW5kZXggOGM3MDBmODgxZDkyLi5kNWE5
YTM2M2U4MWUgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEva2VybmVsL2ZvcmsuYw0KPiA+Pj4+ICsrKyBi
L2tlcm5lbC9mb3JrLmMNCj4gPj4+PiBAQCAtOTYzLDYgKzk2MywxMiBAQCBfX2NhY2hlbGluZV9h
bGlnbmVkX2luX3NtcCBERUZJTkVfU1BJTkxPQ0sobW1saXN0X2xvY2spOw0KPiA+Pj4+ICAgIHN0
YXRpYyB1bnNpZ25lZCBsb25nIGRlZmF1bHRfZHVtcF9maWx0ZXIgPSBNTUZfRFVNUF9GSUxURVJf
REVGQVVMVDsNCj4gPj4+PiArI2lmZGVmIENPTkZJR19BUkNIX01BUF9TWU5DX0RJU0FCTEUNCj4g
Pj4+PiArdW5zaWduZWQgbG9uZyBkZWZhdWx0X21hcF9zeW5jX21hc2sgPSBNTUZfRElTQUJMRV9N
QVBfU1lOQ19NQVNLOw0KPiA+Pj4+ICsjZWxzZQ0KPiA+Pj4+ICt1bnNpZ25lZCBsb25nIGRlZmF1
bHRfbWFwX3N5bmNfbWFzayA9IDA7DQo+ID4+Pj4gKyNlbmRpZg0KPiA+Pj4+ICsNCj4gPg0KPiA+
IEknbSBub3Qgc3VyZSBDT05GSUcgaXMgcmVhbGx5IHRoZSByaWdodCBhcHByb2FjaCBoZXJlLiBG
b3IgYSBkaXN0cm8gdGhhdCB3b3VsZA0KPiA+IGJhc2ljYWxseSBtZWFuIHRvIGRpc2FibGUgTUFQ
X1NZTkMgZm9yIGFsbCBQUEMga2VybmVscyB1bmxlc3MgYXBwbGljYXRpb24NCj4gPiBleHBsaWNp
dGx5IHVzZXMgdGhlIHJpZ2h0IHByY3RsLiBTaG91bGRuJ3Qgd2UgcmF0aGVyIGluaXRpYWxpemUN
Cj4gPiBkZWZhdWx0X21hcF9zeW5jX21hc2sgb24gYm9vdCBiYXNlZCBvbiB3aGV0aGVyIHRoZSBD
UFUgd2UgcnVuIG9uIHJlcXVpcmVzDQo+ID4gbmV3IGZsdXNoIGluc3RydWN0aW9ucyBvciBub3Q/
IE90aGVyd2lzZSB0aGUgcGF0Y2ggbG9va3Mgc2Vuc2libGUuDQo+ID4NCj4NCj4geWVzIHRoYXQg
aXMgY29ycmVjdC4gV2UgaWRlYWxseSB3YW50IHRvIGRlbnkgTUFQX1NZTkMgb25seSB3LnIudA0K
PiBQT1dFUjEwLiBCdXQgb24gYSB2aXJ0dWFsaXplZCBwbGF0Zm9ybSB0aGVyZSBpcyBubyBlYXN5
IHdheSB0byBkZXRlY3QNCj4gdGhhdC4gV2UgY291bGQgaWRlYWxseSBob29rIHRoaXMgaW50byB0
aGUgbnZkaW1tIGRyaXZlciB3aGVyZSB3ZSBsb29rIGF0DQo+IHRoZSBuZXcgY29tcGF0IHN0cmlu
ZyBpYm0scGVyc2lzdGVudC1tZW1vcnktdjIgYW5kIHRoZW4gZGlzYWJsZSBNQVBfU1lOQw0KPiBp
ZiB3ZSBmaW5kIGEgZGV2aWNlIHdpdGggdGhlIHNwZWNpZmljIHZhbHVlLg0KPg0KPiBCVFcgd2l0
aCB0aGUgcmVjZW50IGNoYW5nZXMgSSBwb3N0ZWQgZm9yIHRoZSBudmRpbW0gZHJpdmVyLCBvbGRl
ciBrZXJuZWwNCj4gd29uJ3QgaW5pdGlhbGl6ZSBwZXJzaXN0ZW50IG1lbW9yeSBkZXZpY2Ugb24g
bmV3ZXIgaGFyZHdhcmUuIE5ld2VyDQo+IGhhcmR3YXJlIHdpbGwgcHJlc2VudCB0aGUgZGV2aWNl
IHRvIE9TIHdpdGggYSBkaWZmZXJlbnQgZGV2aWNlIHRyZWUNCj4gY29tcGF0IHN0cmluZy4NCj4N
Cj4gTXkgZXhwZWN0YXRpb24gIHcuci50IHRoaXMgcGF0Y2ggd2FzLCBEaXN0cm8gd291bGQgd2Fu
dCB0byAgbWFyaw0KPiBDT05GSUdfQVJDSF9NQVBfU1lOQ19ESVNBQkxFPW4gYmFzZWQgb24gdGhl
IGRpZmZlcmVudCBhcHBsaWNhdGlvbg0KPiBjZXJ0aWZpY2F0aW9uLiAgT3RoZXJ3aXNlIGFwcGxp
Y2F0aW9uIHdpbGwgaGF2ZSB0byBlbmQgdXAgY2FsbGluZyB0aGUNCj4gcHJjdGwoTU1GX0RJU0FC
TEVfTUFQX1NZTkMsIDApIGFueSB3YXkuIElmIHRoYXQgaXMgdGhlIGNhc2UsIHNob3VsZCB0aGlz
DQo+IGJlIGRlcGVuZGVudCBvbiBQMTA/DQo+DQo+IFdpdGggdGhhdCBJIGFtIHdvbmRlcmluZyBz
aG91bGQgd2UgZXZlbiBoYXZlIHRoaXMgcGF0Y2g/IENhbiB3ZSBleHBlY3QNCj4gdXNlcnNwYWNl
IGdldCB1cGRhdGVkIHRvIHVzZSBuZXcgaW5zdHJ1Y3Rpb24/Lg0KPg0KPiBXaXRoIHBwYzY0IHdl
IG5ldmVyIGhhZCBhIHJlYWwgcGVyc2lzdGVudCBtZW1vcnkgZGV2aWNlIGF2YWlsYWJsZSBmb3IN
Cj4gZW5kIHVzZXIgdG8gdHJ5LiBUaGUgYXZhaWxhYmxlIHBlcnNpc3RlbnQgbWVtb3J5IHN0YWNr
IHdhcyB1c2luZyB2UE1FTQ0KPiB3aGljaCB3YXMgcHJlc2VudGVkIGFzIGEgdm9sYXRpbGUgbWVt
b3J5IHJlZ2lvbiBmb3Igd2hpY2ggdGhlcmUgaXMgbm8NCj4gbmVlZCB0byB1c2UgYW55IG9mIHRo
ZSBmbHVzaCBpbnN0cnVjdGlvbnMuIFdlIGNvdWxkIHNhZmVseSBhc3N1bWUgdGhhdA0KPiBhcyB3
ZSBnZXQgYXBwbGljYXRpb25zIGNlcnRpZmllZC92ZXJpZmllZCBmb3Igd29ya2luZyB3aXRoIHBt
ZW0gZGV2aWNlDQo+IG9uIHBwYzY0LCB0aGV5IHdvdWxkIGFsbCBiZSB1c2luZyB0aGUgbmV3IGlu
c3RydWN0aW9ucz8NCg0KSSB0aGluayBwcmN0bCBpcyB0aGUgd3JvbmcgaW50ZXJmYWNlIGZvciB0
aGlzLiBJIHdhcyB0aGlua2luZyBhIHN5c2ZzDQppbnRlcmZhY2UgYWxvbmcgdGhlIHNhbWUgbGlu
ZXMgYXMgL3N5cy9ibG9jay9wbWVtWC9kYXgvd3JpdGVfY2FjaGUuDQpUaGF0IGF0dHJpYnV0ZSBp
cyB0b2dnbGluZyBEQVhERVZfV1JJVEVfQ0FDSEUgZm9yIHRoZSBkZXRlcm1pbmF0aW9uIG9mDQp3
aGV0aGVyIHRoZSBwbGF0Zm9ybSBvciB0aGUga2VybmVsIG5lZWRzIHRvIGhhbmRsZSBjYWNoZSBm
bHVzaGluZw0KcmVsYXRpdmUgdG8gcG93ZXIgbG9zcy4gQSBzaW1pbGFyIGF0dHJpYnV0ZSBjYW4g
YmUgZXN0YWJsaXNoZWQgZm9yDQpEQVhERVZfU1lOQywgaXQgd291bGQgc2ltcGx5IGRlZmF1bHQg
dG8gb2ZmIGJhc2VkIG9uIGEgY29uZmlndXJhdGlvbg0KdGltZSBwb2xpY3ksIGJ1dCBiZSBkeW5h
bWljYWxseSBjaGFuZ2VhYmxlIGF0IHJ1bnRpbWUgdmlhIHN5c2ZzLg0KDQpUaGVzZSBmbGFncyBh
cmUgZGV2aWNlIHByb3BlcnRpZXMgdGhhdCBhZmZlY3QgdGhlIGtlcm5lbCBhbmQNCnVzZXJzcGFj
ZSdzIGhhbmRsaW5nIG9mIHBlcnNpc3RlbmNlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52
ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1u
dmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
