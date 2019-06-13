Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AD344A9D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 20:27:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C1A9E212966EE;
	Thu, 13 Jun 2019 11:27:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 02DCA2129641B
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 11:27:52 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id g7so60785oia.8
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MQQWIXbMnO77ZtHyX2kfFVvlpzWpGkMLz/R1+ir3QOA=;
 b=crvCEGgkqd+iu3jPAVCgc0rO9kwagRqhiuh9lqc2Ju8CbgOGid+cpJ19wpMCBIaSji
 U8Mz0dX1Um88VCqaKkUNTGuID9Bzc63KYSiIdoNpp/7dpBf8k6fFGIdSQ7ELDhxa2lhq
 O+Cm1rdZssbK5qGXuJrRKvIFe20o9RjF63pnvwmTOEXNE3m0kL4mYXXHPHnWB7iNGKvf
 IRmvCqhPr54CoqyHGAWbyFjtaCU9quXmW4KMHVoz5mhnnS/xbbV6lznIglpAz1QTbisQ
 VH8TIrLDYodoKV2w14PaLsUgipHZwL/KVe25acJc00UDmNqVKP+RWr4Mjo9Lxw4wybxj
 3jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MQQWIXbMnO77ZtHyX2kfFVvlpzWpGkMLz/R1+ir3QOA=;
 b=eBq7ZnD6fMdR/7EGcDIkJK4tFBQpt5FVjJJ49rCI99hiDZQ4i+glijCuoerBsjV68V
 uGsGT4xyPGjZ8CpAKM/N7lc9yVNi/i/CrG82RB9is3ka4BE98szb9rUlLaPUsyblsG0T
 ozDx6y5JMzKlEce1HGq4IOqGAnzE1dtVa6rv0texnj9IycbCCxsQxSH9ZV21CB4V38ls
 hOK19rAcoaQ8fwsNTkvtJ/ifKNYxt+8rihwrkKnqReYvZTC2NSQOUSONBINA0MF2hriQ
 lGeluwjtRerKRMoep+aXuHeixKRHmh1Azf4ftfL1rD3fv2xtqMXSLPHsW5twhejA4tRb
 n6GA==
X-Gm-Message-State: APjAAAVagpBiLvbDSrZXRw6Sa2tOaWSI0V5viHqRzjwVaUm7nVHAJ+eQ
 WKTqLmQZuAR0zJ+gCPAf+MEssV4WaxHQA4ULoPLppLmfmdg=
X-Google-Smtp-Source: APXvYqwS3UGoJsEHP8JK1xPznND3LFKZmK0TBwbTuAL+csM43V1iR6xbM76Rxv8Te4jLIHldpTP2/DzDl/DDdZFYcCo=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr4031867oii.0.1560450471426;
 Thu, 13 Jun 2019 11:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de>
In-Reply-To: <20190613094326.24093-1-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 13 Jun 2019 11:27:39 -0700
Message-ID: <CAPcyv4jBdwYaiVwkhy6kP78OBAs+vJme1UTm47dX4Eq_5=JgSg@mail.gmail.com>
Subject: Re: dev_pagemap related cleanups
To: Christoph Hellwig <hch@lst.de>
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
 linux-pci@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gVGh1LCBKdW4gMTMsIDIwMTkgYXQgMjo0MyBBTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxz
dC5kZT4gd3JvdGU6Cj4KPiBIaSBEYW4sIErDqXLDtG1lIGFuZCBKYXNvbiwKPgo+IGJlbG93IGlz
IGEgc2VyaWVzIHRoYXQgY2xlYW5zIHVwIHRoZSBkZXZfcGFnZW1hcCBpbnRlcmZhY2Ugc28gdGhh
dAo+IGl0IGlzIG1vcmUgZWFzaWx5IHVzYWJsZSwgd2hpY2ggcmVtb3ZlcyB0aGUgbmVlZCB0byB3
cmFwIGl0IGluIGhtbQo+IGFuZCB0aHVzIGFsbG93aW5nIHRvIGtpbGwgYSBsb3Qgb2YgY29kZQo+
Cj4gRGlmZnN0YXQ6Cj4KPiAgMjIgZmlsZXMgY2hhbmdlZCwgMjQ1IGluc2VydGlvbnMoKyksIDgw
MiBkZWxldGlvbnMoLSkKCkhvb3JheSEKCj4gR2l0IHRyZWU6Cj4KPiAgICAgZ2l0Oi8vZ2l0Lmlu
ZnJhZGVhZC5vcmcvdXNlcnMvaGNoL21pc2MuZ2l0IGhtbS1kZXZtZW0tY2xlYW51cAoKSSBqdXN0
IHJlYWxpemVkIHRoaXMgY29sbGlkZXMgd2l0aCB0aGUgZGV2X3BhZ2VtYXAgcmVsZWFzZSByZXdv
cmsgaW4KQW5kcmV3J3MgdHJlZSAoY29tbWl0IGlkcyBiZWxvdyBhcmUgZnJvbSBuZXh0LmdpdCBh
bmQgYXJlIG5vdCBzdGFibGUpCgo0NDIyZWU4NDc2ZjAgbW0vZGV2bV9tZW1yZW1hcF9wYWdlczog
Zml4IGZpbmFsIHBhZ2UgcHV0IHJhY2UKNzcxZjA3MTRkMGRjIFBDSS9QMlBETUE6IHRyYWNrIHBn
bWFwIHJlZmVyZW5jZXMgcGVyIHJlc291cmNlLCBub3QgZ2xvYmFsbHkKYWYzNzA4NWRlOTA2IGxp
Yi9nZW5hbGxvYzogaW50cm9kdWNlIGNodW5rIG93bmVycwplMDA0N2ZmOGFhNzcgUENJL1AyUERN
QTogZml4IHRoZSBnZW5fcG9vbF9hZGRfdmlydCgpIGZhaWx1cmUgcGF0aAowMzE1ZDQ3ZDZhZTkg
bW0vZGV2bV9tZW1yZW1hcF9wYWdlczogaW50cm9kdWNlIGRldm1fbWVtdW5tYXBfcGFnZXMKMjE2
NDc1YzdlYWE4IGRyaXZlcnMvYmFzZS9kZXZyZXM6IGludHJvZHVjZSBkZXZtX3JlbGVhc2VfYWN0
aW9uKCkKCkNPTkZMSUNUIChjb250ZW50KTogTWVyZ2UgY29uZmxpY3QgaW4gdG9vbHMvdGVzdGlu
Zy9udmRpbW0vdGVzdC9pb21hcC5jCkNPTkZMSUNUIChjb250ZW50KTogTWVyZ2UgY29uZmxpY3Qg
aW4gbW0vaG1tLmMKQ09ORkxJQ1QgKGNvbnRlbnQpOiBNZXJnZSBjb25mbGljdCBpbiBrZXJuZWwv
bWVtcmVtYXAuYwpDT05GTElDVCAoY29udGVudCk6IE1lcmdlIGNvbmZsaWN0IGluIGluY2x1ZGUv
bGludXgvbWVtcmVtYXAuaApDT05GTElDVCAoY29udGVudCk6IE1lcmdlIGNvbmZsaWN0IGluIGRy
aXZlcnMvcGNpL3AycGRtYS5jCkNPTkZMSUNUIChjb250ZW50KTogTWVyZ2UgY29uZmxpY3QgaW4g
ZHJpdmVycy9udmRpbW0vcG1lbS5jCkNPTkZMSUNUIChjb250ZW50KTogTWVyZ2UgY29uZmxpY3Qg
aW4gZHJpdmVycy9kYXgvZGV2aWNlLmMKQ09ORkxJQ1QgKGNvbnRlbnQpOiBNZXJnZSBjb25mbGlj
dCBpbiBkcml2ZXJzL2RheC9kYXgtcHJpdmF0ZS5oCgpQZXJoYXBzIHdlIHNob3VsZCBwdWxsIHRo
b3NlIG91dCBhbmQgcmVzZW5kIHRoZW0gdGhyb3VnaCBobW0uZ2l0PwoKSXQgYWxzbyB0dXJucyBv
dXQgdGhlIG52ZGltbSB1bml0IHRlc3RzIGNyYXNoIHdpdGggdGhpcyBzaWduYXR1cmUgb24KdGhh
dCBicmFuY2ggd2hlcmUgYmFzZSB2NS4yLXJjMyBwYXNzZXM6CgogICAgQlVHOiBrZXJuZWwgTlVM
TCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDA4CiAgICBbLi5d
CiAgICBDUFU6IDE1IFBJRDogMTQxNCBDb21tOiBsdC1saWJuZGN0bCBUYWludGVkOiBHICAgICAg
ICAgICBPRQo1LjIuMC1yYzMrICMzMzk5CiAgICBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJk
IFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyAwLjAuMCAwMi8wNi8yMDE1CiAgICBSSVA6
IDAwMTA6cGVyY3B1X3JlZl9raWxsX2FuZF9jb25maXJtKzB4MWUvMHgxODAKICAgIFsuLl0KICAg
IENhbGwgVHJhY2U6CiAgICAgcmVsZWFzZV9ub2RlcysweDIzNC8weDI4MAogICAgIGRldmljZV9y
ZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsweGU4LzB4MWIwCiAgICAgYnVzX3JlbW92ZV9kZXZpY2Ur
MHhmMi8weDE2MAogICAgIGRldmljZV9kZWwrMHgxNjYvMHgzNzAKICAgICB1bnJlZ2lzdGVyX2Rl
dl9kYXgrMHgyMy8weDUwCiAgICAgcmVsZWFzZV9ub2RlcysweDIzNC8weDI4MAogICAgIGRldmlj
ZV9yZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsweGU4LzB4MWIwCiAgICAgdW5iaW5kX3N0b3JlKzB4
OTQvMHgxMjAKICAgICBrZXJuZnNfZm9wX3dyaXRlKzB4ZjAvMHgxYTAKICAgICB2ZnNfd3JpdGUr
MHhiNy8weDFiMAogICAgIGtzeXNfd3JpdGUrMHg1Yy8weGQwCiAgICAgZG9fc3lzY2FsbF82NCsw
eDYwLzB4MjQwCgpUaGUgY3Jhc2ggYmlzZWN0cyB0bzoKCiAgICBkOGNjOGJiZTEwOGMgZGV2aWNl
LWRheDogdXNlIHRoZSBkZXZfcGFnZW1hcCBpbnRlcm5hbCByZWZjb3VudApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBs
aXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udmRpbW0K
