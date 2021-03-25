Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418F73488BE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Mar 2021 07:08:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8ADC9100EB343;
	Wed, 24 Mar 2021 23:08:08 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 269CB100EB32C
	for <linux-nvdimm@lists.01.org>; Wed, 24 Mar 2021 23:08:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y200so946169pfb.5
        for <linux-nvdimm@lists.01.org>; Wed, 24 Mar 2021 23:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n3UYgEf/j4hD+qRK6vQHmTCmLMgLoJ/jZNakIMvrDWA=;
        b=PpGsnF+T1a7yqvSHRloTgwOSgzAgejrs7sR7Gr+vFZAHd4ZQ9WLogT1USYGdUU6Dge
         n1KEBE03bN5QcEjfnWO9z36E8SfGqVfbJ6xrDOkWBWsMqtjQmQ/jPn+24f1gY4SsopXf
         /RJa9nMXOCP22av31ol781H3s9ZR4fP/4iReEOIUkA0GlTtzb3cYZqNBanyTTFshytUt
         nYhBXC7y8gduwHPWhJ4/djRogj693UvIHUtLqk2EvozlrM4BSNo2oZ1sZMcKOVHEU2hn
         iFkKWULLszqeZhgTIGaa19nqctKyT/XZ0l/tzItH5Q7E+/pp6LB6g49PwlpQ1I7oUJBD
         br4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=n3UYgEf/j4hD+qRK6vQHmTCmLMgLoJ/jZNakIMvrDWA=;
        b=DnWL8MXg2I/F5SMUH/r8MUVMWkga50HDqIIIYFX7/Ad81XvAiptTtmh2xXqPKHgI8s
         qFHPEb0346LXM9WMs15HHIV9Z391NwgWgM55sLgv/IQgeEPGPW8Ivg0yviRfolVqsuyj
         TXiHtVaePA/fGSb6exL2utiDUDt+ADXqLh594JhjjK7xDa8wj3cVpQz5M34Cct7LErBI
         ULpXVKq/lUNNnIfVIY11eoJLbQYpw+wXWXjvh1ZZ+47cQ5LskwTfL9+ryXrGsys3pf22
         0Rw/rGJch/Do3h/sxQIgcJNSGkzqHPS7J2YBaiDQpbahmy/9nP1T2ob1RtKpI7ZL2/6m
         iYMg==
X-Gm-Message-State: AOAM533SCprtzUQnnkIKHjRnwhyB/UYNt8geHAqr9/px0K2TjzQaFu0R
	HF0VxJPcMclNii7X/A+1WQ4w0w==
X-Google-Smtp-Source: ABdhPJzT4F/Gg6JvN30+Oo5pVXb/di6vfj9EUlLCpZvMbckvID07xTQfd9b33LgetkAicYgeF05UAg==
X-Received: by 2002:a17:902:760e:b029:e7:147e:fe96 with SMTP id k14-20020a170902760eb02900e7147efe96mr2518187pll.11.1616652484752;
        Wed, 24 Mar 2021 23:08:04 -0700 (PDT)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id x190sm4394842pfx.166.2021.03.24.23.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 23:08:04 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "sbhat@linux.ibm.com"
 <sbhat@linux.ibm.com>, "linux-nvdimm@lists.01.org"
 <linux-nvdimm@lists.01.org>, "harish@linux.ibm.com"
 <harish@linux.ibm.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
 "vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>
Subject: Re: [ndctl PATCH v3 2/4] test: Don't skip tests if nfit modules are
 missing
In-Reply-To: <7467b623b77b4e7232433632d8b110490ca66473.camel@intel.com>
References: <20210311074652.2783560-1-santosh@fossix.org>
 <20210311074652.2783560-2-santosh@fossix.org>
 <6a62d78cfccf9f544a991df8334433a1e01021ba.camel@intel.com>
 <87czvv1ykm.fsf@santosiv.in.ibm.com>
 <7467b623b77b4e7232433632d8b110490ca66473.camel@intel.com>
Date: Thu, 25 Mar 2021 11:38:00 +0530
Message-ID: <87lfab22bj.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: TKZISWQUARHVM3OUENNUWSZISRTBERSO
X-Message-ID-Hash: TKZISWQUARHVM3OUENNUWSZISRTBERSO
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TKZISWQUARHVM3OUENNUWSZISRTBERSO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

IlZlcm1hLCBWaXNoYWwgTCIgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4gd3JpdGVzOg0KDQo+
IE9uIEZyaSwgMjAyMS0wMy0xOSBhdCAxMToyMCArMDUzMCwgU2FudG9zaCBTaXZhcmFqIHdyb3Rl
Og0KPj4gIlZlcm1hLCBWaXNoYWwgTCIgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4gd3JpdGVz
Og0KPg0KPiBbLi5dDQo+DQo+PiA+IA0KPj4gPiBmaXggbXVsdGkgbGluZSBjb21tZW50IHRvIHRo
ZSByaWdodCBmb3JtYXR0aW5nOg0KPj4gPiAvKg0KPj4gPiDCoCogbGluZSAxLCBldGMNCj4+ID4g
wqAqLw0KPj4gPiANCj4+IA0KPj4gV2lsbCBmaXggdGhhdC4NCj4+IA0KPj4gPiA+ICsJaWYgKGFj
Y2VzcygiL3N5cy9idXMvYWNwaSIsIEZfT0spID09IC0xKSB7DQo+PiA+ID4gKwkJaWYgKGVycm5v
ID09IEVOT0VOVCkNCj4+ID4gPiArCQkJZmFtaWx5ID0gTlZESU1NX0ZBTUlMWV9QQVBSOw0KPj4g
PiA+ICsJfQ0KPj4gPiANCj4+ID4gSW5zdGVhZCBvZiBhIGJsaW5kIGRlZmF1bHQsIGNhbiB3ZSBw
ZXJmb3JtIGEgc2ltaWxhciBjaGVjayBmb3IgcHJlc2VuY2Ugb2YNCj4+ID4gUEFQUiB0b28/DQo+
PiA+IA0KPj4gDQo+PiBZZXMsIEkgd2FudGVkIHRvIGRvIHRoYXQsIGJ1dCB0aGVyZSBpcyBubyBy
ZWxpYWJsZSB3YXkgb2YgY2hlY2sgdGhhdDsgdGhlcmUgaXMNCj4+IG5vIG9mbm9kZSBiZWZvcmUg
bW9kdWxlIGxvYWQsIGFuZCB0aGVyZSB3b24ndCBiZSBhbnkgUEFQUiBzcGVjaWZpYyBEVCBlbnRy
aWVzIGlmDQo+PiB0aGUgcGxhdGZvcm0gaXMgbm90IFBvd2VyLg0KPj4gDQo+PiBJIGFsc28gdGVz
dCB0aGUgJ25kdGVzdCcgbW9kdWxlIG9uIHg4NiB3aXRoIE5EQ1RMX1RFU1RfRkFNSUxZIGVudmly
b25tZW50DQo+PiB2YXJpYWJsZS4gSSBjYW4gbGV0IHRoZSBkZWZhdWx0IGJlIG5maXRfdGVzdCAo
TlZESU1NX0ZBTUlMWV9JTlRFTCkgYW5kIG9ubHkgbG9hZA0KPj4gUEFQUiBtb2R1bGUgd2hlbiB0
aGUgZW52aXJvbm1lbnQgdmFyaWFibGUgaXMgc2V0LiBUaG91Z2h0cz8NCj4+IA0KPiBUaGUgZW52
IHZhcmlhYmxlIHNlZW1zIHJlYXNvbmFibGUgdG8gbWUuIElmIHRoZXJlIGlzIGV2ZXIgYSB0aGly
ZA0KPiAnZmFtaWx5JyBhZGRpbmcgdGVzdHMsIGhhdmluZyBhbiBhcmJpdHJhcnkgZGVmYXVsdCBt
aWdodCBiZSBhd2t3YXJkLg0KPiBJIG1heSBzdWdnZXN0IC0gaWYgYWNwaSBpcyBkZXRlY3RlZCwg
dXNlIE5GSVQuIElmIGVudiBoYXMgc29tZXRoaW5nIHRoYXQNCj4gaXMga25vd24sIGUuZy4gUEFQ
UiwgdXNlIHRoYXQuIElmIGVudiBpcyB1bnNldCBvciBkb2Vzbid0IG1hdGNoIGFueXRoaW5nDQo+
IHdlIGtub3cgYWJvdXQsIHRoZW4gYmFpbCB3aXRoIGFuIGVycm9yIG1lc3NhZ2UuIERvZXMgdGhh
dCBzb3VuZA0KPiByZWFzb25hYmxlPw0KDQpZZXMsIHRoYXQgc291bmRzIHRvbyB0byBtZS4gSSB3
aWxsIHNlbmQgaW4gdGhlIG5leHQgdmVyc2lvbiBzb29uLg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3
IQ0KDQpUaGFua3MsDQpTYW50b3NoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxp
c3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1s
ZWF2ZUBsaXN0cy4wMS5vcmcK
