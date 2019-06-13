Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F201244D4D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 22:21:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 60FDF2129670C;
	Thu, 13 Jun 2019 13:21:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BD41D212966F8
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 13:21:38 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id l15so423875otn.9
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8C1DPfN32M3hy89DclQbm10r/6nHw68ntXJVKpP7b9Y=;
 b=f8QwnyQT51rXgqH07uWM2kqXhbWRJNnV74LW/yRvR2x776SPj5Pfk2O+kG2AmGkO8T
 trYSPptgpa5/GXF/WDtITF1+EbHojK5NlrUWtkmk/zSrRfZi5l9VktyZN13ffa5Hc6Ev
 0msFAvfYWphm24CFoDY7wyxaucG4FVHRbGTisLD6oBUXsztdH3fUW9TN5VMHOpT3cvr0
 sCPmY0lNjqi+LcWw5XMhpewNnmhVYTSePA2WSDRkeUne9k6nQVV9YwwkLBcNkm4aAYQp
 hwiX33VeD0WOTvpFOoQcm71sdbaOX7SnxHZ9aM2nx+Itu4NnNsqFxSwSt5OwJVwaJq25
 COoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8C1DPfN32M3hy89DclQbm10r/6nHw68ntXJVKpP7b9Y=;
 b=SD1PPTobQ2itw3InqzDknjMhf0KRiCM0dYoxpQKd+OlGEvjwm26imxl1dGAQZZ3aef
 EaGnj+R3tfBTy9Txwe1+gtzXcfD6T3UJ13OtFLgMqvNRG3pLe4yBVzNHI1dB2DzOCDuX
 M56g9RUmJN5g7o2v8O2z5HK43r97MLBIdFYEyBLM+nZz0BN0NE+tSIifOlz3x171ETDt
 xc/yUHY6fz0vdfOazgQcn6GcdSN3Hm0rANTqkFbwRlVTqEF3iheRDLcGMWaEhydn6sq8
 AADUenRqN/g3CdYD12aE26XVKulerP5jMbp4jZf1OkSTf0tHLkn+FI1O4DjIEXlqotY2
 V2NA==
X-Gm-Message-State: APjAAAVywdovHtpbdaO+L1duOnFy5sWL1ywG/ZMK7s1vUhazPM3+lkJD
 e5k3X9EDHDwOclvXP4dU9zKExXdK/RXbTri1vuugtQ==
X-Google-Smtp-Source: APXvYqyjtP3QbVJvzI3dCCMhA8qeDJqydQ8D7TK+PF2b5eiWZzF3IhMkwvK4lONxsyfmaoM/M+8Dcj6PJdtpVy6CFmg=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr1406727otk.363.1560457298006; 
 Thu, 13 Jun 2019 13:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de>
 <CAPcyv4jBdwYaiVwkhy6kP78OBAs+vJme1UTm47dX4Eq_5=JgSg@mail.gmail.com>
 <283e87e8-20b6-0505-a19b-5d18e057f008@deltatee.com>
In-Reply-To: <283e87e8-20b6-0505-a19b-5d18e057f008@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 13 Jun 2019 13:21:27 -0700
Message-ID: <CAPcyv4hx=ng3SxzAWd8s_8VtAfoiiWhiA5kodi9KPc=jGmnejg@mail.gmail.com>
Subject: Re: dev_pagemap related cleanups
To: Logan Gunthorpe <logang@deltatee.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, nouveau@lists.freedesktop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 linux-pci@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gVGh1LCBKdW4gMTMsIDIwMTkgYXQgMToxOCBQTSBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0Bk
ZWx0YXRlZS5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIDIwMTktMDYtMTMgMTI6MjcgcC5tLiwgRGFu
IFdpbGxpYW1zIHdyb3RlOgo+ID4gT24gVGh1LCBKdW4gMTMsIDIwMTkgYXQgMjo0MyBBTSBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4gd3JvdGU6Cj4gPj4KPiA+PiBIaSBEYW4sIErDqXLD
tG1lIGFuZCBKYXNvbiwKPiA+Pgo+ID4+IGJlbG93IGlzIGEgc2VyaWVzIHRoYXQgY2xlYW5zIHVw
IHRoZSBkZXZfcGFnZW1hcCBpbnRlcmZhY2Ugc28gdGhhdAo+ID4+IGl0IGlzIG1vcmUgZWFzaWx5
IHVzYWJsZSwgd2hpY2ggcmVtb3ZlcyB0aGUgbmVlZCB0byB3cmFwIGl0IGluIGhtbQo+ID4+IGFu
ZCB0aHVzIGFsbG93aW5nIHRvIGtpbGwgYSBsb3Qgb2YgY29kZQo+ID4+Cj4gPj4gRGlmZnN0YXQ6
Cj4gPj4KPiA+PiAgMjIgZmlsZXMgY2hhbmdlZCwgMjQ1IGluc2VydGlvbnMoKyksIDgwMiBkZWxl
dGlvbnMoLSkKPiA+Cj4gPiBIb29yYXkhCj4gPgo+ID4+IEdpdCB0cmVlOgo+ID4+Cj4gPj4gICAg
IGdpdDovL2dpdC5pbmZyYWRlYWQub3JnL3VzZXJzL2hjaC9taXNjLmdpdCBobW0tZGV2bWVtLWNs
ZWFudXAKPiA+Cj4gPiBJIGp1c3QgcmVhbGl6ZWQgdGhpcyBjb2xsaWRlcyB3aXRoIHRoZSBkZXZf
cGFnZW1hcCByZWxlYXNlIHJld29yayBpbgo+ID4gQW5kcmV3J3MgdHJlZSAoY29tbWl0IGlkcyBi
ZWxvdyBhcmUgZnJvbSBuZXh0LmdpdCBhbmQgYXJlIG5vdCBzdGFibGUpCj4gPgo+ID4gNDQyMmVl
ODQ3NmYwIG1tL2Rldm1fbWVtcmVtYXBfcGFnZXM6IGZpeCBmaW5hbCBwYWdlIHB1dCByYWNlCj4g
PiA3NzFmMDcxNGQwZGMgUENJL1AyUERNQTogdHJhY2sgcGdtYXAgcmVmZXJlbmNlcyBwZXIgcmVz
b3VyY2UsIG5vdCBnbG9iYWxseQo+ID4gYWYzNzA4NWRlOTA2IGxpYi9nZW5hbGxvYzogaW50cm9k
dWNlIGNodW5rIG93bmVycwo+ID4gZTAwNDdmZjhhYTc3IFBDSS9QMlBETUE6IGZpeCB0aGUgZ2Vu
X3Bvb2xfYWRkX3ZpcnQoKSBmYWlsdXJlIHBhdGgKPiA+IDAzMTVkNDdkNmFlOSBtbS9kZXZtX21l
bXJlbWFwX3BhZ2VzOiBpbnRyb2R1Y2UgZGV2bV9tZW11bm1hcF9wYWdlcwo+ID4gMjE2NDc1Yzdl
YWE4IGRyaXZlcnMvYmFzZS9kZXZyZXM6IGludHJvZHVjZSBkZXZtX3JlbGVhc2VfYWN0aW9uKCkK
PiA+Cj4gPiBDT05GTElDVCAoY29udGVudCk6IE1lcmdlIGNvbmZsaWN0IGluIHRvb2xzL3Rlc3Rp
bmcvbnZkaW1tL3Rlc3QvaW9tYXAuYwo+ID4gQ09ORkxJQ1QgKGNvbnRlbnQpOiBNZXJnZSBjb25m
bGljdCBpbiBtbS9obW0uYwo+ID4gQ09ORkxJQ1QgKGNvbnRlbnQpOiBNZXJnZSBjb25mbGljdCBp
biBrZXJuZWwvbWVtcmVtYXAuYwo+ID4gQ09ORkxJQ1QgKGNvbnRlbnQpOiBNZXJnZSBjb25mbGlj
dCBpbiBpbmNsdWRlL2xpbnV4L21lbXJlbWFwLmgKPiA+IENPTkZMSUNUIChjb250ZW50KTogTWVy
Z2UgY29uZmxpY3QgaW4gZHJpdmVycy9wY2kvcDJwZG1hLmMKPiA+IENPTkZMSUNUIChjb250ZW50
KTogTWVyZ2UgY29uZmxpY3QgaW4gZHJpdmVycy9udmRpbW0vcG1lbS5jCj4gPiBDT05GTElDVCAo
Y29udGVudCk6IE1lcmdlIGNvbmZsaWN0IGluIGRyaXZlcnMvZGF4L2RldmljZS5jCj4gPiBDT05G
TElDVCAoY29udGVudCk6IE1lcmdlIGNvbmZsaWN0IGluIGRyaXZlcnMvZGF4L2RheC1wcml2YXRl
LmgKPiA+Cj4gPiBQZXJoYXBzIHdlIHNob3VsZCBwdWxsIHRob3NlIG91dCBhbmQgcmVzZW5kIHRo
ZW0gdGhyb3VnaCBobW0uZ2l0Pwo+Cj4gSG1tLCBJJ3ZlIGJlZW4gd2FpdGluZyBmb3IgdGhvc2Ug
cGF0Y2hlcyB0byBnZXQgaW4gZm9yIGEgbGl0dGxlIHdoaWxlIG5vdyA7KAoKVW5sZXNzIEFuZHJl
dyB3YXMgZ29pbmcgdG8gc3VibWl0IGFzIHY1LjItcmMgZml4ZXMgSSB0aGluayBJIHNob3VsZApy
ZWJhc2UgLyBzdWJtaXQgdGhlbSBvbiBjdXJyZW50IGhtbS5naXQgYW5kIHRoZW4gdGhyb3cgdGhl
c2UgY2xlYW51cHMKZnJvbSBDaHJpc3RvcGggb24gdG9wPwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4
LW52ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udmRpbW0K
