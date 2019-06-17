Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C428D48ACC
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 19:52:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 51CBE21295CB6;
	Mon, 17 Jun 2019 10:52:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BC90921283A5A
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 10:52:03 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id j19so10183460otq.2
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 10:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GjmvPRW/EB2UZMiXQmlwdUn3cNZy7MEt9OXtWGJNxz0=;
 b=aTNnToCYbt/RLgFmZg1PIvrCe0JVP4C32RN5cfyMVp2zYXXYY11JnD0P5Xn5tfOK6Y
 voW3Syk7UYIIG5SF4LSMDVtOlpmEa0YxFfvlu8+J6wAb/HPFiX2GuYxqo+V2fpMpF+jS
 NlrpFBkRARTzBSJzVDZzE7bQS2UMHOvFRAjYRiT9xL8/lOeALYe1ebk8LfMUYkoFpZaD
 PAFxFM2FYNf4FyGaTFye24KEnD9WdtERxcyZTxLFaidHht03PVJNbu4TuZbdbzHMaWbM
 oEiXMcpcSzAKgjPufMTuJybkt3G4uT6kQCK3aNOgUOJV87J/VA4uKxPCVrEi1MqSqx3i
 hB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GjmvPRW/EB2UZMiXQmlwdUn3cNZy7MEt9OXtWGJNxz0=;
 b=jTYSv9x3KrJ45ALFLS+W/vNJursO35K7D7Ei+5YSvb06pasSeKsvF7IlN/RRD1MJ5J
 HbZuO8mg5ZCsEZNXPBRvCit5GNcIT0UrHSBZd7qm52wIZsnGWxyh6gGWdDZjPzLKLNe4
 ozRbYk9nu+SaNd6WGFIgrepJZGihbiGFAXJseb/jnBwMhaF7D1+tAgc0GJ4qNbkETRD6
 vq4f4ro6HHI3trDdp2LIWdRdAZJtGRR1T38fsZUEz0kK6esl3FCJVoKInv91BrJZ7FOl
 uQo97NN8CCzHyvau9cmk6hDEkcJncmEJX0b2asA8U5UfE4fvGYMC3gyHBpUJoDt77Z10
 ST/A==
X-Gm-Message-State: APjAAAVPmV3/xbhuj+GfJWX1MZBDD1ZVqoTMlUw31veyTUTdlHo75WmE
 EOQoOl8LpUCUajeiVICVGbsEwru7i+quHiWlkTZyCQ==
X-Google-Smtp-Source: APXvYqyhtBEP50oerFZs8TdK9nCsvOJRWYCWzRd2vhiNPfCpga0Ba5N2yHiBCHm+W4K6XflHhEhbg4A9IXDkc+ucm/c=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr54836696otn.247.1560793907524; 
 Mon, 17 Jun 2019 10:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de>
 <20190617122733.22432-9-hch@lst.de>
In-Reply-To: <20190617122733.22432-9-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 17 Jun 2019 10:51:35 -0700
Message-ID: <CAPcyv4i_0wUJHDqY91R=x5M2o_De+_QKZxPyob5=E9CCv8rM7A@mail.gmail.com>
Subject: Re: [PATCH 08/25] memremap: move dev_pagemap callbacks into a
 separate structure
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
 linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gTW9uLCBKdW4gMTcsIDIwMTkgYXQgNToyNyBBTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxz
dC5kZT4gd3JvdGU6Cj4KPiBUaGUgZGV2X3BhZ2VtYXAgaXMgYSBncm93aW5nIHRvbyBtYW55IGNh
bGxiYWNrcy4gIE1vdmUgdGhlbSBpbnRvIGEKPiBzZXBhcmF0ZSBvcHMgc3RydWN0dXJlIHNvIHRo
YXQgdGhleSBhcmUgbm90IGR1cGxpY2F0ZWQgZm9yIG11bHRpcGxlCj4gaW5zdGFuY2VzLCBhbmQg
YW4gYXR0YWNrZXIgY2FuJ3QgZWFzaWx5IG92ZXJ3cml0ZSB0aGVtLgo+Cj4gU2lnbmVkLW9mZi1i
eTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gUmV2aWV3ZWQtYnk6IExvZ2FuIEd1
bnRob3JwZSA8bG9nYW5nQGRlbHRhdGVlLmNvbT4KPiBSZXZpZXdlZC1ieTogSmFzb24gR3VudGhv
cnBlIDxqZ2dAbWVsbGFub3guY29tPgo+IC0tLQo+ICBkcml2ZXJzL2RheC9kZXZpY2UuYyAgICAg
ICAgICAgICAgfCAxMSArKysrKystLS0tCj4gIGRyaXZlcnMvZGF4L3BtZW0vY29yZS5jICAgICAg
ICAgICB8ICAyICstCj4gIGRyaXZlcnMvbnZkaW1tL3BtZW0uYyAgICAgICAgICAgICB8IDE5ICsr
KysrKysrKy0tLS0tLS0KPiAgZHJpdmVycy9wY2kvcDJwZG1hLmMgICAgICAgICAgICAgIHwgIDkg
KysrKystLS0KPiAgaW5jbHVkZS9saW51eC9tZW1yZW1hcC5oICAgICAgICAgIHwgMzYgKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLQo+ICBrZXJuZWwvbWVtcmVtYXAuYyAgICAgICAgICAg
ICAgICAgfCAxOCArKysrKysrKy0tLS0tLS0tCj4gIG1tL2htbS5jICAgICAgICAgICAgICAgICAg
ICAgICAgICB8IDEwICsrKysrKy0tLQo+ICB0b29scy90ZXN0aW5nL252ZGltbS90ZXN0L2lvbWFw
LmMgfCAgOSArKysrLS0tLQo+ICA4IGZpbGVzIGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKyksIDQ5
IGRlbGV0aW9ucygtKQo+ClsuLl0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9udmRpbW0v
dGVzdC9pb21hcC5jIGIvdG9vbHMvdGVzdGluZy9udmRpbW0vdGVzdC9pb21hcC5jCj4gaW5kZXgg
MjE5ZGQwYTFjYjA4Li5hNjY3ZDk3NDE1NWUgMTAwNjQ0Cj4gLS0tIGEvdG9vbHMvdGVzdGluZy9u
dmRpbW0vdGVzdC9pb21hcC5jCj4gKysrIGIvdG9vbHMvdGVzdGluZy9udmRpbW0vdGVzdC9pb21h
cC5jCj4gQEAgLTEwNiwxMSArMTA2LDEwIEBAIEVYUE9SVF9TWU1CT0woX193cmFwX2Rldm1fbWVt
cmVtYXApOwo+Cj4gIHN0YXRpYyB2b2lkIG5maXRfdGVzdF9raWxsKHZvaWQgKl9wZ21hcCkKPiAg
ewo+IC0gICAgICAgc3RydWN0IGRldl9wYWdlbWFwICpwZ21hcCA9IF9wZ21hcDsKCldob29wcywg
bmVlZGVkIHRvIGtlZXAgdGhpcyBsaW5lIHRvIGF2b2lkOgoKdG9vbHMvdGVzdGluZy9udmRpbW0v
dGVzdC9pb21hcC5jOjEwOToxMTogZXJyb3I6IOKAmHBnbWFw4oCZIHVuZGVjbGFyZWQKKGZpcnN0
IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuIOKAmF9wZ21hcOKAmT8KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1h
aWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlzdHMuMDEub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
