Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D261E825C0
	for <lists+linux-nvdimm@lfdr.de>; Mon,  5 Aug 2019 21:54:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5195D2131BA56;
	Mon,  5 Aug 2019 12:57:11 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C9E912131475F
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 12:53:06 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id s20so21252391otp.4
 for <linux-nvdimm@lists.01.org>; Mon, 05 Aug 2019 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EQQ/uVCp/E33zX5AqNGCTSRb0JaexWyIYOAiOAY49Bk=;
 b=Apj5AL1JQO1Y53R5atGuFhoeI2NvfiYp48I7r5SbniQXlqeZ91INUr61gnuq639oyI
 w9OlZEGYC+TS6olOcQ8iGzt07CrvZBmH4MUoxnPYXuE4RTW4UkItnW/MUJFRnUUtudc1
 F1EZ+TxGpKU43Tx4ynQZKaUdkhf19VZTiaYpoO0kEC2Goi1gyFLb+4tv5aHnAfQRlixz
 Og/pemWGzGbB6nZYbbj9s48/fOzQMg9OjrClwWYkUBjyWWfYf2Rm5MQ3fMHpXBHWJCJh
 wwEQhkUfzmFioyKyGlaTLzQXFIqRfEwMPOD6CoKrYjnHRXyR0WC9qD7xZXJ1zH8NZINu
 hzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EQQ/uVCp/E33zX5AqNGCTSRb0JaexWyIYOAiOAY49Bk=;
 b=A3oCIL7tz6PSyy0wjKWajDhQOseegVWpUjIDHVD8Td3FX1E5PNDA/526F86DDMpVGG
 KS3BeeEGTlDzv+ITCvaNxJf5G0DldEvknP/sKXNYrnkkNnDqDqEzDkprIzm+tDHVR9N0
 K2ELozrLDc4kIMCLTm2ik8tQu/jfCqmmq9lT0YUChd7B3D7IMbjSVz3ct5+GIqpynmPh
 jBBMIQ0xQhMS2kaiKjad96wa3pMM9IqGMKIgw0Gs9ow3u8FF8vtLrI78BPr9Q/KOGp1K
 ojt25tl7YfS/xXlDSqaMkpeyqFXfRCJ3Z0qb/sSjTO2Z/Jnx4a42lpQ0l27ULG2DofP+
 F+Yg==
X-Gm-Message-State: APjAAAWECQd2Hu/WNVDas0NqZ4FOmBHQh2Vk+x3/l3znigHc6y8u+Llc
 kXVu/RatJSxpZAn0aIQFAMCH5TCe/dT77nC/H29v8A==
X-Google-Smtp-Source: APXvYqwpAZqlZFLjmlKLDjNb9YLkejY9ZxQOyu8MqdARSX5XAFY9r/tyVDbH+X+8+Q4zFWMePNAZg/0b7tg/BBOktag=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr37212937otn.71.1565034635163; 
 Mon, 05 Aug 2019 12:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <156479006271.707590.298793474092813749.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156479006802.707590.7623788701230232646.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x491rxzr1rq.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4jZVMFqd7G++vsOxCxPWp-bUUQ4KKAq0-oku0=hAE5zzA@mail.gmail.com>
In-Reply-To: <CAPcyv4jZVMFqd7G++vsOxCxPWp-bUUQ4KKAq0-oku0=hAE5zzA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 5 Aug 2019 12:50:23 -0700
Message-ID: <CAPcyv4jxgiJ7DD4ybgSsZ_anecv+4rHfYjYOvqzhQFDTufRrUA@mail.gmail.com>
Subject: Re: [ndctl PATCH v3 1/8] ndctl/build: Suppress
 -Waddress-of-packed-member
To: Jeff Moyer <jmoyer@redhat.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gTW9uLCBBdWcgNSwgMjAxOSBhdCAxMDozNCBBTSBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxp
YW1zQGludGVsLmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIEF1ZyA1LCAyMDE5IGF0IDEwOjA2IEFN
IEplZmYgTW95ZXIgPGptb3llckByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBEYW4gV2lsbGlh
bXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4gd3JpdGVzOgo+ID4KPiA+ID4gZ2NjIDkuMS4x
IGVtaXRzIGEgc2xldyBvZiB3YXJuaW5ncyBmb3IgbWFueSBvZiB0aGUgY29tbWFuZCBmaWVsZAo+
ID4gPiBhY2Nlc3Nlcy4gSS5lLiB3YXJuaW5ncyBvZiB0aGUgZm9ybToKPiA+ID4KPiA+ID4gbGli
bmRjdGwuYzoyNTg2OjIxOiB3YXJuaW5nOiB0YWtpbmcgYWRkcmVzcyBvZiBwYWNrZWQgbWVtYmVy
IG9mIOKAmHN0cnVjdCBuZF9jbWRfZ2V0X2NvbmZpZ19kYXRhX2hkcuKAmSBtYXkgcmVzdWx0IGlu
IGFuIHVuYWxpZ25lZCBwb2ludGVyIHZhbHVlIFstV2FkZHJlc3Mtb2YtcGFja2VkLW1lbWJlcl0K
PiA+ID4gIDI1ODYgfCAgY21kLT5pdGVyLm9mZnNldCA9ICZjbWQtPmdldF9kYXRhLT5pbl9vZmZz
ZXQ7Cj4gPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+Cj4gPiA+Cj4gPiA+IFN1cHByZXNzIHRoZXNlIGFzIGZpeGluZyB0aGUgd2FybmluZyB3
b3VsZCBkZWZlYXQgdGhlIGFic3RyYWN0aW9uIG9mIGJlaW5nIGFibGUKPiA+ID4gdG8gaGF2ZSBj
b21tb24gY29kZSB0aGF0IG9wZXJhdGVzIG9uIGNvbW1hbmRzIHdpdGggY29tbW9uIGZpZWxkcyBh
dCBkaWZmZXJlbnQKPiA+ID4gb2Zmc2V0cyBpbiB0aGUgcGF5bG9hZC4KPiA+Cj4gPiBBcyBJIHVu
ZGVyc3RhbmQgaXQsIHRha2luZyBhIHBvaW50ZXIgdG8gdGhpcyBwb3RlbnRpYWxseSB1bmFsaWdu
ZWQKPiA+IG1lbWJlciBjYW4gcmVzdWx0IGluIGJ1cyBlcnJvcnMgKG9yIHdvcnNlLCBhY2Nlc3Np
bmcgd3JvbmcgZGF0YSkgb24KPiA+IGFyY2hpdGVjdHVyZXMgdGhhdCBkb24ndCBzdXBwb3J0IHVu
YWxpZ25lZCBhY2Nlc3Nlcy4gIEknZCBiZSBhIHdob2xlIGxvdAo+ID4gaGFwcGllciB3aXRoIHRo
aXMgY2hhbmdlbG9nIGlmIGl0IG1lbnRpb25lZCB0aGF0IHlvdSBoYWQgY29uc2lkZXJlZCB3aGF0
Cj4gPiB0aGUgd2FybmluZyBhY3R1YWxseSBtZWFudCwgYW5kIGRlY2lkZWQgaXQgZGlkbid0IG1h
dHRlciBmb3IgdGhlCj4gPiBhcmNoaXRlY3R1cmVzIHlvdSB3YW50IHRvIHN1cHBvcnQuCj4KPiBU
cnVlLCBpdCB3YXMgYSBmbGVldGluZyB0aG91Z2h0LCBidXQgbm90IHNvbWV0aGluZyBJIGNvbnNp
ZGVyZWQKPiBmbGVzaGluZyBvdXQuLi4gSSdsbCBzZW5kIGEgcmV2aXNpb24uCj4KPiA+Cj4gPiB4
ODYgaXMsIG9mIGNvdXJzZSwgc2FmZS4gIEkgYmVsaWV2ZSBhYXJjaDY0IGlzLCBhcyB3ZWxsLiAg
SSBkaWRuJ3QgbG9vawo+ID4gaW50byBvdGhlcnMuCj4gPgo+Cj4gS2VlcCBpbiBtaW5kIHRoYXQg
dGhpcyBjb2RlIGlzIGZvciBpbnRlcmZhY2luZyB3aXRoIHRoZSBBQ1BJIERTTSBwYXRoLgo+IElm
IGFuIHVuYWxpZ25lZC1pbmNhcGFibGUgYXJjaGl0ZWN0dXJlIGRlZmluZWQgYW4gTlZESU1NIGNv
bW1hbmQgc2V0Cj4gaXQgaXMgaGlnaGx5IHVubGlrZWx5IGl0IHdvdWxkIGJlIEFDUEkgYmFzZWQs
IG9yIHBpY2sgdGhlc2UKPiBwcm9ibGVtYXRpYyBjb21tYW5kIGZvcm1hdHMuIEkgY2FuIGFkZCB0
aGVzZSBub3RlcyB0byB0aGUgY2hhbmdlbG9nLAo+IGJ1dCB0aGUgdW5mb3J0dW5hdGUgZGVmaW5p
dGlvbiBvZiB0aGVzZSBwYXlsb2FkcyB0aGF0IHJlcXVpcmUgX19wYWNrZWQKPiBpcyBzb21ldGhp
bmcgSSBob3BlIG90aGVyIGFyY2hpdGVjdHVyZXMgYXZvaWQuCgouLi5hbmQgaXQgdHVybnMgb3V0
IHRoaXMgaXMgd3JvbmcgYmVjYXVzZSB3ZSBoYXZlIHRoZSBkZWZhdWx0IGlvY3Rscwp0aGF0IGFs
c28gdXNlIHRoZXNlIHBhY2tlZCBzdHJ1Y3R1cmVzCgogICAgICAgIE5EX0NNRF9BUlNfQ0FQID0g
MSwKICAgICAgICBORF9DTURfQVJTX1NUQVJUID0gMiwKICAgICAgICBORF9DTURfQVJTX1NUQVRV
UyA9IDMsCiAgICAgICAgTkRfQ01EX0NMRUFSX0VSUk9SID0gNCwKCiAgICAgICAgTkRfQ01EX1NN
QVJUID0gMSwKICAgICAgICBORF9DTURfU01BUlRfVEhSRVNIT0xEID0gMiwKICAgICAgICBORF9D
TURfRElNTV9GTEFHUyA9IDMsCiAgICAgICAgTkRfQ01EX0dFVF9DT05GSUdfU0laRSA9IDQsCiAg
ICAgICAgTkRfQ01EX0dFVF9DT05GSUdfREFUQSA9IDUsCiAgICAgICAgTkRfQ01EX1NFVF9DT05G
SUdfREFUQSA9IDYsCiAgICAgICAgTkRfQ01EX1ZFTkRPUiA9IDksCgpJJ2xsIHRha2UgYSBsb29r
IGF0IHJld29ya2luZyB0aGlzLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGltbUBsaXN0cy4w
MS5vcmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udmRpbW0K
