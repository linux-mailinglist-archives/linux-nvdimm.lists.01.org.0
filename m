Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFC38240B
	for <lists+linux-nvdimm@lfdr.de>; Mon,  5 Aug 2019 19:34:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4F0CA2130D7E5;
	Mon,  5 Aug 2019 10:37:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E7E822130D7E0
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 10:37:05 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id l12so1998751oil.1
 for <linux-nvdimm@lists.01.org>; Mon, 05 Aug 2019 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zcZNYzAqZYgccEiDGdTCIIXsWC1zQfr9ibUomajxOJA=;
 b=lWJZ7Q9EOrFGfQhkvm/kjDvLVUcYvZOvRk4ovU/I0qFFx3nuCLQOELohT0clPlm8Lk
 en0n2AXWxevMCeau70RFHVGXptibQEdmtoRhx6HVfpQ7SVG7ov8JyIhsDu2kGEQ+KddB
 TH4TVz97CUBebFFvzN+6oV6HpDj1G/wLzzz25NWa8vY0S2Ofixkt816opsFzgO2wn5iL
 u+r2XtfU0sJTzcNFB3ANm6PMHftLHMMLn4qxTWgwrd+lFNSexAA00Mc8Z0kQmKX3vG++
 8LAVlixq16Soi4eSRJVB1uuUWRvSsaYEU6cDCM76QPmCri6zNrpb2KeopRXsRWXA8b22
 HKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zcZNYzAqZYgccEiDGdTCIIXsWC1zQfr9ibUomajxOJA=;
 b=oZnQcb9n+7CeBx40dpv4IwxS+PmBoZysR+b84dOyh4BoPlalTMNRRwJssiPfHcuMx7
 RyUNEXJfa0wVCQFxIuvxICY1fz54uMSkbOc6N9dVzI85puoszTf+7jOIpLBFDld2H4J9
 nMI1OOZnT243Dfq5JeaGYZGO78DP6SwIw4XgmkANvO/zym9uxklLUZRcxiSAD0ydSMhp
 2Xop5iMvzrOnpU4fTjw+Gp6cUw+qVKh387b18OrwLFE3x1BNmYfRQ0J/daBbAxZMBnvP
 I+XR+GqTbGpY0iv2ckOcVeqxtH/c5pCFRLiVgubHt3DyWDCtIeFIJviw/U+clXLcZ4Xh
 UTQw==
X-Gm-Message-State: APjAAAUIvyJ6awHKGaybJ6JECa193tSHthJ5sxuHbeA77JMuUx5hfuyA
 UynNLEy8Np9/hydIs1VssC4NuDrTiMY78xymqzf/xQ==
X-Google-Smtp-Source: APXvYqxKoxMn1s2n5gXn+vITTfYrCEp+bLnIeIyAFpmZQbLW16o3jAibWhABK0RMm2V191cGF1ebHnnjdKCij03bqUI=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr11677322oii.0.1565026474205; 
 Mon, 05 Aug 2019 10:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <156479006271.707590.298793474092813749.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156479006802.707590.7623788701230232646.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x491rxzr1rq.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x491rxzr1rq.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 5 Aug 2019 10:34:23 -0700
Message-ID: <CAPcyv4jZVMFqd7G++vsOxCxPWp-bUUQ4KKAq0-oku0=hAE5zzA@mail.gmail.com>
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

T24gTW9uLCBBdWcgNSwgMjAxOSBhdCAxMDowNiBBTSBKZWZmIE1veWVyIDxqbW95ZXJAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4KPiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4g
d3JpdGVzOgo+Cj4gPiBnY2MgOS4xLjEgZW1pdHMgYSBzbGV3IG9mIHdhcm5pbmdzIGZvciBtYW55
IG9mIHRoZSBjb21tYW5kIGZpZWxkCj4gPiBhY2Nlc3Nlcy4gSS5lLiB3YXJuaW5ncyBvZiB0aGUg
Zm9ybToKPiA+Cj4gPiBsaWJuZGN0bC5jOjI1ODY6MjE6IHdhcm5pbmc6IHRha2luZyBhZGRyZXNz
IG9mIHBhY2tlZCBtZW1iZXIgb2Yg4oCYc3RydWN0IG5kX2NtZF9nZXRfY29uZmlnX2RhdGFfaGRy
4oCZIG1heSByZXN1bHQgaW4gYW4gdW5hbGlnbmVkIHBvaW50ZXIgdmFsdWUgWy1XYWRkcmVzcy1v
Zi1wYWNrZWQtbWVtYmVyXQo+ID4gIDI1ODYgfCAgY21kLT5pdGVyLm9mZnNldCA9ICZjbWQtPmdl
dF9kYXRhLT5pbl9vZmZzZXQ7Cj4gPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgXn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fgo+ID4KPiA+IFN1cHByZXNzIHRoZXNlIGFzIGZpeGluZyB0aGUg
d2FybmluZyB3b3VsZCBkZWZlYXQgdGhlIGFic3RyYWN0aW9uIG9mIGJlaW5nIGFibGUKPiA+IHRv
IGhhdmUgY29tbW9uIGNvZGUgdGhhdCBvcGVyYXRlcyBvbiBjb21tYW5kcyB3aXRoIGNvbW1vbiBm
aWVsZHMgYXQgZGlmZmVyZW50Cj4gPiBvZmZzZXRzIGluIHRoZSBwYXlsb2FkLgo+Cj4gQXMgSSB1
bmRlcnN0YW5kIGl0LCB0YWtpbmcgYSBwb2ludGVyIHRvIHRoaXMgcG90ZW50aWFsbHkgdW5hbGln
bmVkCj4gbWVtYmVyIGNhbiByZXN1bHQgaW4gYnVzIGVycm9ycyAob3Igd29yc2UsIGFjY2Vzc2lu
ZyB3cm9uZyBkYXRhKSBvbgo+IGFyY2hpdGVjdHVyZXMgdGhhdCBkb24ndCBzdXBwb3J0IHVuYWxp
Z25lZCBhY2Nlc3Nlcy4gIEknZCBiZSBhIHdob2xlIGxvdAo+IGhhcHBpZXIgd2l0aCB0aGlzIGNo
YW5nZWxvZyBpZiBpdCBtZW50aW9uZWQgdGhhdCB5b3UgaGFkIGNvbnNpZGVyZWQgd2hhdAo+IHRo
ZSB3YXJuaW5nIGFjdHVhbGx5IG1lYW50LCBhbmQgZGVjaWRlZCBpdCBkaWRuJ3QgbWF0dGVyIGZv
ciB0aGUKPiBhcmNoaXRlY3R1cmVzIHlvdSB3YW50IHRvIHN1cHBvcnQuCgpUcnVlLCBpdCB3YXMg
YSBmbGVldGluZyB0aG91Z2h0LCBidXQgbm90IHNvbWV0aGluZyBJIGNvbnNpZGVyZWQKZmxlc2hp
bmcgb3V0Li4uIEknbGwgc2VuZCBhIHJldmlzaW9uLgoKPgo+IHg4NiBpcywgb2YgY291cnNlLCBz
YWZlLiAgSSBiZWxpZXZlIGFhcmNoNjQgaXMsIGFzIHdlbGwuICBJIGRpZG4ndCBsb29rCj4gaW50
byBvdGhlcnMuCj4KCktlZXAgaW4gbWluZCB0aGF0IHRoaXMgY29kZSBpcyBmb3IgaW50ZXJmYWNp
bmcgd2l0aCB0aGUgQUNQSSBEU00gcGF0aC4KSWYgYW4gdW5hbGlnbmVkLWluY2FwYWJsZSBhcmNo
aXRlY3R1cmUgZGVmaW5lZCBhbiBOVkRJTU0gY29tbWFuZCBzZXQKaXQgaXMgaGlnaGx5IHVubGlr
ZWx5IGl0IHdvdWxkIGJlIEFDUEkgYmFzZWQsIG9yIHBpY2sgdGhlc2UKcHJvYmxlbWF0aWMgY29t
bWFuZCBmb3JtYXRzLiBJIGNhbiBhZGQgdGhlc2Ugbm90ZXMgdG8gdGhlIGNoYW5nZWxvZywKYnV0
IHRoZSB1bmZvcnR1bmF0ZSBkZWZpbml0aW9uIG9mIHRoZXNlIHBheWxvYWRzIHRoYXQgcmVxdWly
ZSBfX3BhY2tlZAppcyBzb21ldGhpbmcgSSBob3BlIG90aGVyIGFyY2hpdGVjdHVyZXMgYXZvaWQu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
ZGltbSBtYWlsaW5nIGxpc3QKTGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpodHRwczovL2xpc3Rz
LjAxLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52ZGltbQo=
