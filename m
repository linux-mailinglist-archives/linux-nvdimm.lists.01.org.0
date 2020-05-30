Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E93261E92A6
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 May 2020 18:35:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1F214100F227F;
	Sat, 30 May 2020 09:31:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BC2E5100F2278
	for <linux-nvdimm@lists.01.org>; Sat, 30 May 2020 09:30:59 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p18so4084680eds.7
        for <linux-nvdimm@lists.01.org>; Sat, 30 May 2020 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zDPgsDC+Fjw05Uy8ht8rySTjxa/FIb4k6efkMWlug6I=;
        b=ztIv525FWUuRebjARCuK7nVYHZe/dJCKraz620tINksAHNR5k6Z5lnzEUn5rJZllrS
         S7DOl6p7C8eufks3T9AEtPO3wq5N8Bp/Z+xssUrtpYf3IhPdQJZSlEz2CgioQHLtMEfj
         iBTbLnYgbiNr7JDLWkmIRrKWPh2tjGj6U8H4Di0O9zkxp117GVhjqcKHJLD9Go3FQTmq
         9v3ltiQEreNDEqsV9wMWbmW9+MMxrYb8dD39iYHFJCDlFAJpIarZETfxMU04LgUMUkg3
         FbxjN6DXBvH8CrZtAI2gtczDq2o0dC2CKc+xG1jjMK4iunxdoA2lVMUR3WXN1tlg1M2x
         aILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zDPgsDC+Fjw05Uy8ht8rySTjxa/FIb4k6efkMWlug6I=;
        b=IyhafWsN87aMzHqyDSxlS6O1lTjkap+nU0+Ra6/fjMEJB9mXV0gqTAFMspKUU16hZq
         wZElZrBA1Tz2RzXZhuqRwDJjEiVu1PAb0oYc9uDyPPOz+eARc+dXIVmkjsdXF9s6cbDc
         t6fkeseTTwGwSagV6wt0anONRWUemODlMWl/X9sTvbLGToHW1Ey9mHrRebtguzefAMM3
         bfVze6yWK0QlN9fND+AmMFLwUJoyWVTAGuAd8IVNw4jSHKR6OFnpT8H6bVxoBMCd7WtG
         6z6Yv1QWLB9ZQbFuqJpmSwXNCO2rRxRoRusZ7x/OQ91/ukULZpY3q6ia4lEmjwQCBDH7
         O4ng==
X-Gm-Message-State: AOAM532v3/54xyYH6oQ8NJQ+4Cxwr5V4evv0wBfUWNZqu8oum7BGmGRM
	sUghhIsv/PIBIB4DfGRldJE40fTUB/aAcnzjEPqESw==
X-Google-Smtp-Source: ABdhPJzrmF5UxpGeRUgFsqeE7fugpOQNoQE1OdjFRbD2EHpNe1SLiNydKeQ/GpONBeVkNwHIotJ0M9+h2cKe+Pj0T6s=
X-Received: by 2002:a50:f40d:: with SMTP id r13mr13102099edm.93.1590856529133;
 Sat, 30 May 2020 09:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200529054141.156384-1-aneesh.kumar@linux.ibm.com>
 <20200529093310.GL25173@kitsune.suse.cz> <6183cf4a-d134-99e5-936e-ef35f530c2ec@linux.ibm.com>
 <20200529095250.GP14550@quack2.suse.cz> <7e8ee9e3-4d4d-e4b9-913b-1c2448adc62a@linux.ibm.com>
 <CAPcyv4jrss3dFcCOar3JTFnuN0_pgFNtBPiJzUdKxtiax6pPgQ@mail.gmail.com> <7f163562-e7e3-7668-7415-c40e57c32582@linux.ibm.com>
In-Reply-To: <7f163562-e7e3-7668-7415-c40e57c32582@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 30 May 2020 09:35:19 -0700
Message-ID: <CAPcyv4i7k7t8is_6FKAWbWsGHVO0kvj-OqqqJTzw=VS7xtZVvQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] libnvdimm: Add prctl control for disabling
 synchronous fault support.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: 2S2FL7CURCNJQ4MHNUJUVUTL5SL2JO2N
X-Message-ID-Hash: 2S2FL7CURCNJQ4MHNUJUVUTL5SL2JO2N
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, jack@suse.de, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2S2FL7CURCNJQ4MHNUJUVUTL5SL2JO2N/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gU2F0LCBNYXkgMzAsIDIwMjAgYXQgMTI6MTggQU0gQW5lZXNoIEt1bWFyIEsuVg0KPGFuZWVz
aC5rdW1hckBsaW51eC5pYm0uY29tPiB3cm90ZToNCj4NCj4gT24gNS8zMC8yMCAxMjo1MiBBTSwg
RGFuIFdpbGxpYW1zIHdyb3RlOg0KPiA+IE9uIEZyaSwgTWF5IDI5LCAyMDIwIGF0IDM6NTUgQU0g
QW5lZXNoIEt1bWFyIEsuVg0KPiA+IDxhbmVlc2gua3VtYXJAbGludXguaWJtLmNvbT4gd3JvdGU6
DQo+ID4+DQo+ID4+IE9uIDUvMjkvMjAgMzoyMiBQTSwgSmFuIEthcmEgd3JvdGU6DQo+ID4+PiBI
aSENCj4gPj4+DQo+ID4+PiBPbiBGcmkgMjktMDUtMjAgMTU6MDc6MzEsIEFuZWVzaCBLdW1hciBL
LlYgd3JvdGU6DQo+ID4+Pj4gVGhhbmtzIE1pY2hhbC4gSSBhbHNvIG1pc3NlZCBKZWZmIGluIHRo
aXMgZW1haWwgdGhyZWFkLg0KPiA+Pj4NCj4gPj4+IEFuZCBJIHRoaW5rIHlvdSdsbCBhbHNvIG5l
ZWQgc29tZSBvZiB0aGUgc2NoZWQgbWFpbnRhaW5lcnMgZm9yIHRoZSBwcmN0bA0KPiA+Pj4gYml0
cy4uLg0KPiA+Pj4NCj4gPj4+PiBPbiA1LzI5LzIwIDM6MDMgUE0sIE1pY2hhbCBTdWNow6FuZWsg
d3JvdGU6DQo+ID4+Pj4+IEFkZGluZyBKYW4NCj4gPj4+Pj4NCj4gPj4+Pj4gT24gRnJpLCBNYXkg
MjksIDIwMjAgYXQgMTE6MTE6MzlBTSArMDUzMCwgQW5lZXNoIEt1bWFyIEsuViB3cm90ZToNCj4g
Pj4+Pj4+IFdpdGggUE9XRVIxMCwgYXJjaGl0ZWN0dXJlIGlzIGFkZGluZyBuZXcgcG1lbSBmbHVz
aCBhbmQgc3luYyBpbnN0cnVjdGlvbnMuDQo+ID4+Pj4+PiBUaGUga2VybmVsIHNob3VsZCBwcmV2
ZW50IHRoZSB1c2FnZSBvZiBNQVBfU1lOQyBpZiBhcHBsaWNhdGlvbnMgYXJlIG5vdCB1c2luZw0K
PiA+Pj4+Pj4gdGhlIG5ldyBpbnN0cnVjdGlvbnMgb24gbmV3ZXIgaGFyZHdhcmUuDQo+ID4+Pj4+
Pg0KPiA+Pj4+Pj4gVGhpcyBwYXRjaCBhZGRzIGEgcHJjdGwgb3B0aW9uIE1BUF9TWU5DX0VOQUJM
RSB0aGF0IGNhbiBiZSB1c2VkIHRvIGVuYWJsZQ0KPiA+Pj4+Pj4gdGhlIHVzYWdlIG9mIE1BUF9T
WU5DLiBUaGUga2VybmVsIGNvbmZpZyBvcHRpb24gaXMgYWRkZWQgdG8gYWxsb3cgdGhlIHVzZXIN
Cj4gPj4+Pj4+IHRvIGNvbnRyb2wgd2hldGhlciBNQVBfU1lOQyBzaG91bGQgYmUgZW5hYmxlZCBi
eSBkZWZhdWx0IG9yIG5vdC4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmVl
c2ggS3VtYXIgSy5WIDxhbmVlc2gua3VtYXJAbGludXguaWJtLmNvbT4NCj4gPj4+IC4uLg0KPiA+
Pj4+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9mb3JrLmMgYi9rZXJuZWwvZm9yay5jDQo+ID4+Pj4+
PiBpbmRleCA4YzcwMGY4ODFkOTIuLmQ1YTlhMzYzZTgxZSAxMDA2NDQNCj4gPj4+Pj4+IC0tLSBh
L2tlcm5lbC9mb3JrLmMNCj4gPj4+Pj4+ICsrKyBiL2tlcm5lbC9mb3JrLmMNCj4gPj4+Pj4+IEBA
IC05NjMsNiArOTYzLDEyIEBAIF9fY2FjaGVsaW5lX2FsaWduZWRfaW5fc21wIERFRklORV9TUElO
TE9DSyhtbWxpc3RfbG9jayk7DQo+ID4+Pj4+PiAgICAgc3RhdGljIHVuc2lnbmVkIGxvbmcgZGVm
YXVsdF9kdW1wX2ZpbHRlciA9IE1NRl9EVU1QX0ZJTFRFUl9ERUZBVUxUOw0KPiA+Pj4+Pj4gKyNp
ZmRlZiBDT05GSUdfQVJDSF9NQVBfU1lOQ19ESVNBQkxFDQo+ID4+Pj4+PiArdW5zaWduZWQgbG9u
ZyBkZWZhdWx0X21hcF9zeW5jX21hc2sgPSBNTUZfRElTQUJMRV9NQVBfU1lOQ19NQVNLOw0KPiA+
Pj4+Pj4gKyNlbHNlDQo+ID4+Pj4+PiArdW5zaWduZWQgbG9uZyBkZWZhdWx0X21hcF9zeW5jX21h
c2sgPSAwOw0KPiA+Pj4+Pj4gKyNlbmRpZg0KPiA+Pj4+Pj4gKw0KPiA+Pj4NCj4gPj4+IEknbSBu
b3Qgc3VyZSBDT05GSUcgaXMgcmVhbGx5IHRoZSByaWdodCBhcHByb2FjaCBoZXJlLiBGb3IgYSBk
aXN0cm8gdGhhdCB3b3VsZA0KPiA+Pj4gYmFzaWNhbGx5IG1lYW4gdG8gZGlzYWJsZSBNQVBfU1lO
QyBmb3IgYWxsIFBQQyBrZXJuZWxzIHVubGVzcyBhcHBsaWNhdGlvbg0KPiA+Pj4gZXhwbGljaXRs
eSB1c2VzIHRoZSByaWdodCBwcmN0bC4gU2hvdWxkbid0IHdlIHJhdGhlciBpbml0aWFsaXplDQo+
ID4+PiBkZWZhdWx0X21hcF9zeW5jX21hc2sgb24gYm9vdCBiYXNlZCBvbiB3aGV0aGVyIHRoZSBD
UFUgd2UgcnVuIG9uIHJlcXVpcmVzDQo+ID4+PiBuZXcgZmx1c2ggaW5zdHJ1Y3Rpb25zIG9yIG5v
dD8gT3RoZXJ3aXNlIHRoZSBwYXRjaCBsb29rcyBzZW5zaWJsZS4NCj4gPj4+DQo+ID4+DQo+ID4+
IHllcyB0aGF0IGlzIGNvcnJlY3QuIFdlIGlkZWFsbHkgd2FudCB0byBkZW55IE1BUF9TWU5DIG9u
bHkgdy5yLnQNCj4gPj4gUE9XRVIxMC4gQnV0IG9uIGEgdmlydHVhbGl6ZWQgcGxhdGZvcm0gdGhl
cmUgaXMgbm8gZWFzeSB3YXkgdG8gZGV0ZWN0DQo+ID4+IHRoYXQuIFdlIGNvdWxkIGlkZWFsbHkg
aG9vayB0aGlzIGludG8gdGhlIG52ZGltbSBkcml2ZXIgd2hlcmUgd2UgbG9vayBhdA0KPiA+PiB0
aGUgbmV3IGNvbXBhdCBzdHJpbmcgaWJtLHBlcnNpc3RlbnQtbWVtb3J5LXYyIGFuZCB0aGVuIGRp
c2FibGUgTUFQX1NZTkMNCj4gPj4gaWYgd2UgZmluZCBhIGRldmljZSB3aXRoIHRoZSBzcGVjaWZp
YyB2YWx1ZS4NCj4gPj4NCj4gPj4gQlRXIHdpdGggdGhlIHJlY2VudCBjaGFuZ2VzIEkgcG9zdGVk
IGZvciB0aGUgbnZkaW1tIGRyaXZlciwgb2xkZXIga2VybmVsDQo+ID4+IHdvbid0IGluaXRpYWxp
emUgcGVyc2lzdGVudCBtZW1vcnkgZGV2aWNlIG9uIG5ld2VyIGhhcmR3YXJlLiBOZXdlcg0KPiA+
PiBoYXJkd2FyZSB3aWxsIHByZXNlbnQgdGhlIGRldmljZSB0byBPUyB3aXRoIGEgZGlmZmVyZW50
IGRldmljZSB0cmVlDQo+ID4+IGNvbXBhdCBzdHJpbmcuDQo+ID4+DQo+ID4+IE15IGV4cGVjdGF0
aW9uICB3LnIudCB0aGlzIHBhdGNoIHdhcywgRGlzdHJvIHdvdWxkIHdhbnQgdG8gIG1hcmsNCj4g
Pj4gQ09ORklHX0FSQ0hfTUFQX1NZTkNfRElTQUJMRT1uIGJhc2VkIG9uIHRoZSBkaWZmZXJlbnQg
YXBwbGljYXRpb24NCj4gPj4gY2VydGlmaWNhdGlvbi4gIE90aGVyd2lzZSBhcHBsaWNhdGlvbiB3
aWxsIGhhdmUgdG8gZW5kIHVwIGNhbGxpbmcgdGhlDQo+ID4+IHByY3RsKE1NRl9ESVNBQkxFX01B
UF9TWU5DLCAwKSBhbnkgd2F5LiBJZiB0aGF0IGlzIHRoZSBjYXNlLCBzaG91bGQgdGhpcw0KPiA+
PiBiZSBkZXBlbmRlbnQgb24gUDEwPw0KPiA+Pg0KPiA+PiBXaXRoIHRoYXQgSSBhbSB3b25kZXJp
bmcgc2hvdWxkIHdlIGV2ZW4gaGF2ZSB0aGlzIHBhdGNoPyBDYW4gd2UgZXhwZWN0DQo+ID4+IHVz
ZXJzcGFjZSBnZXQgdXBkYXRlZCB0byB1c2UgbmV3IGluc3RydWN0aW9uPy4NCj4gPj4NCj4gPj4g
V2l0aCBwcGM2NCB3ZSBuZXZlciBoYWQgYSByZWFsIHBlcnNpc3RlbnQgbWVtb3J5IGRldmljZSBh
dmFpbGFibGUgZm9yDQo+ID4+IGVuZCB1c2VyIHRvIHRyeS4gVGhlIGF2YWlsYWJsZSBwZXJzaXN0
ZW50IG1lbW9yeSBzdGFjayB3YXMgdXNpbmcgdlBNRU0NCj4gPj4gd2hpY2ggd2FzIHByZXNlbnRl
ZCBhcyBhIHZvbGF0aWxlIG1lbW9yeSByZWdpb24gZm9yIHdoaWNoIHRoZXJlIGlzIG5vDQo+ID4+
IG5lZWQgdG8gdXNlIGFueSBvZiB0aGUgZmx1c2ggaW5zdHJ1Y3Rpb25zLiBXZSBjb3VsZCBzYWZl
bHkgYXNzdW1lIHRoYXQNCj4gPj4gYXMgd2UgZ2V0IGFwcGxpY2F0aW9ucyBjZXJ0aWZpZWQvdmVy
aWZpZWQgZm9yIHdvcmtpbmcgd2l0aCBwbWVtIGRldmljZQ0KPiA+PiBvbiBwcGM2NCwgdGhleSB3
b3VsZCBhbGwgYmUgdXNpbmcgdGhlIG5ldyBpbnN0cnVjdGlvbnM/DQo+ID4NCj4gPiBJIHRoaW5r
IHByY3RsIGlzIHRoZSB3cm9uZyBpbnRlcmZhY2UgZm9yIHRoaXMuIEkgd2FzIHRoaW5raW5nIGEg
c3lzZnMNCj4gPiBpbnRlcmZhY2UgYWxvbmcgdGhlIHNhbWUgbGluZXMgYXMgL3N5cy9ibG9jay9w
bWVtWC9kYXgvd3JpdGVfY2FjaGUuDQo+ID4gVGhhdCBhdHRyaWJ1dGUgaXMgdG9nZ2xpbmcgREFY
REVWX1dSSVRFX0NBQ0hFIGZvciB0aGUgZGV0ZXJtaW5hdGlvbiBvZg0KPiA+IHdoZXRoZXIgdGhl
IHBsYXRmb3JtIG9yIHRoZSBrZXJuZWwgbmVlZHMgdG8gaGFuZGxlIGNhY2hlIGZsdXNoaW5nDQo+
ID4gcmVsYXRpdmUgdG8gcG93ZXIgbG9zcy4gQSBzaW1pbGFyIGF0dHJpYnV0ZSBjYW4gYmUgZXN0
YWJsaXNoZWQgZm9yDQo+ID4gREFYREVWX1NZTkMsIGl0IHdvdWxkIHNpbXBseSBkZWZhdWx0IHRv
IG9mZiBiYXNlZCBvbiBhIGNvbmZpZ3VyYXRpb24NCj4gPiB0aW1lIHBvbGljeSwgYnV0IGJlIGR5
bmFtaWNhbGx5IGNoYW5nZWFibGUgYXQgcnVudGltZSB2aWEgc3lzZnMuDQo+ID4NCj4gPiBUaGVz
ZSBmbGFncyBhcmUgZGV2aWNlIHByb3BlcnRpZXMgdGhhdCBhZmZlY3QgdGhlIGtlcm5lbCBhbmQN
Cj4gPiB1c2Vyc3BhY2UncyBoYW5kbGluZyBvZiBwZXJzaXN0ZW5jZS4NCj4gPg0KPg0KPiBUaGF0
IHdpbGwgbm90IGhhbmRsZSB0aGUgc2NlbmFyaW8gd2l0aCBtdWx0aXBsZSBhcHBsaWNhdGlvbnMg
dXNpbmcgdGhlDQo+IHNhbWUgZnNkYXggbW91bnQgcG9pbnQgd2hlcmUgb25lIGlzIHVwZGF0ZWQg
dG8gdXNlIHRoZSBuZXcgaW5zdHJ1Y3Rpb24NCj4gYW5kIHRoZSBvdGhlciBpcyBub3QuDQoNClJp
Z2h0LCBpdCBuZWVkcyB0byBiZSBhIGdsb2JhbCBzZXR0aW5nIC8gZmxhZyBkYXkgdG8gc3dpdGNo
IGZyb20gb25lDQpyZWdpbWUgdG8gYW5vdGhlci4gUGVyLXByb2Nlc3MgY29udHJvbCBpcyBhIHJl
Y2lwZSBmb3IgZGlzYXN0ZXIuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3Rz
LjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2
ZUBsaXN0cy4wMS5vcmcK
