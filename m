Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7961FCDE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 02:31:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DFBC3212794C0;
	Wed, 15 May 2019 17:31:35 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com;
 envelope-from=cai@lca.pw; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D7B562126CFA9
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 17:31:34 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z128so1214718qkb.6
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 17:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=xM+RFeuYKRxsIgkngGYK7F1nhOVwIknDUHFDYwBWS4M=;
 b=ce87YEoHQ3gEM1Pzl/OZnHRrbCQNF03DWhlezURYXEiSlkgU4w4mEO67/poVC2z5le
 a7DclrrqaCnPRhZ2hMIjN2Ax7PaZGQci2kVFNksfsJ7RnluEd6LDYlf3M9b871fljHW8
 4IwjunFUffu8qlpNONdUAYqTISgTgNo/vgKWZWhVNEKDLJeuQ7YzpmGht/RfwqaWBs0W
 xui8kjZq2sEEOlRIiENHuG6jlYQ24vX5rQyKSmP2pAHBBvk3Bh4P30TSBVU6dpTS/M1B
 5zKkeAtsOJF7coQpXiBHJpQM2FeqGxb/MyBSa+Ab3Mq1STKRb06LMCoh1j4bRjVF3so5
 9A4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=xM+RFeuYKRxsIgkngGYK7F1nhOVwIknDUHFDYwBWS4M=;
 b=QwZT6707EpsVFmKL7o2e1zK/FCEqRQHbPMahhu4NVRVp9Ni2JMGmNezP+CwgZ4sGcx
 bMul2Gd+CdErtaMwon99XsIZ21FbwRhQZPipqk7Tp50zP8MHs5wi6upWDHDoj1Q3A+KT
 AA6Y6VAf2N5mBT6Z59kD9vCetJ35UGwljuwDiyqhB9c9iM6qmcc+HqK9G36TCyaW3HYI
 8zRqVqGNcmvrjG2eTcDyvdJr8QjaUIhMzXWRtUK+iFHKUrruH6JIC1bdfxJcXKwiDpIj
 tdhb3Q1eFJ7KRc+AEyCE2aD2VvCsll/Rr8ltcDcxuu6aMpQooE8FE239oHiYJelqfGAB
 z7LA==
X-Gm-Message-State: APjAAAVYfk00ZKeIdR1ivtuOUvc4BRSmLrYhUQ6vophDBKDgoAd7Iy9s
 ZznOjSNXTPyU5ojvyJr4g8Hx/w==
X-Google-Smtp-Source: APXvYqz3fHzTPnf64v8pB/ZHAteLVwxI4396VUH6eGzP3onjT97IZWc+DOk95vqA8DE+NZSD0H/6lw==
X-Received: by 2002:a37:aa42:: with SMTP id t63mr35422129qke.353.1557966692992; 
 Wed, 15 May 2019 17:31:32 -0700 (PDT)
Received: from qians-mbp.fios-router.home
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id m18sm1842826qki.21.2019.05.15.17.31.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 May 2019 17:31:32 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RESEND PATCH] nvdimm: fix some compilation warnings
From: Qian Cai <cai@lca.pw>
In-Reply-To: <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
Date: Wed, 15 May 2019 20:31:31 -0400
Message-Id: <3D0A6725-A738-4778-BB5B-1617B6184337@lca.pw>
References: <20190514150735.39625-1-cai@lca.pw>
 <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Cj4+ICAgICAgICAgICAgICAgIH0KPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9i
dXMuYyBiL2RyaXZlcnMvbnZkaW1tL2J1cy5jCj4+IGluZGV4IDdmZjY4NDE1OWYyOS4uMmViNmE2
Y2ZlOWU0IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL252ZGltbS9idXMuYwo+PiArKysgYi9kcml2
ZXJzL252ZGltbS9idXMuYwo+PiBAQCAtNjQyLDcgKzY0Miw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0
cmlidXRlICpuZF9kZXZpY2VfYXR0cmlidXRlc1tdID0gewo+PiAgICAgICAgTlVMTCwKPj4gfTsK
Pj4gCj4+IC0vKioKPj4gKy8qCj4+ICAqIG5kX2RldmljZV9hdHRyaWJ1dGVfZ3JvdXAgLSBnZW5l
cmljIGF0dHJpYnV0ZXMgZm9yIGFsbCBkZXZpY2VzIG9uIGFuIG5kIGJ1cwo+PiAgKi8KPj4gc3Ry
dWN0IGF0dHJpYnV0ZV9ncm91cCBuZF9kZXZpY2VfYXR0cmlidXRlX2dyb3VwID0gewo+PiBAQCAt
NjcxLDcgKzY3MSw3IEBAIHN0YXRpYyB1bW9kZV90IG5kX251bWFfYXR0cl92aXNpYmxlKHN0cnVj
dCBrb2JqZWN0ICprb2JqLCBzdHJ1Y3QgYXR0cmlidXRlICphLAo+PiAgICAgICAgcmV0dXJuIGEt
Pm1vZGU7Cj4+IH0KPj4gCj4+IC0vKioKPj4gKy8qCj4+ICAqIG5kX251bWFfYXR0cmlidXRlX2dy
b3VwIC0gTlVNQSBhdHRyaWJ1dGVzIGZvciBhbGwgZGV2aWNlcyBvbiBhbiBuZCBidXMKPj4gICov
Cj4gCj4gTGV0cyBqdXN0IGZpeCB0aGlzIHRvIGJlIGEgdmFsaWQga2VybmVsLWRvYyBmb3JtYXQg
Zm9yIGEgc3RydWN0Lgo+IAo+IEBAIC02NzIsNyArNjcyLDcgQEAgc3RhdGljIHVtb2RlX3QgbmRf
bnVtYV9hdHRyX3Zpc2libGUoc3RydWN0IGtvYmplY3QKPiAqa29iaiwgc3RydWN0IGF0dHJpYnV0
ZSAqYSwKPiB9Cj4gCj4gLyoqCj4gLSAqIG5kX251bWFfYXR0cmlidXRlX2dyb3VwIC0gTlVNQSBh
dHRyaWJ1dGVzIGZvciBhbGwgZGV2aWNlcyBvbiBhbiBuZCBidXMKPiArICogc3RydWN0IG5kX251
bWFfYXR0cmlidXRlX2dyb3VwIC0gTlVNQSBhdHRyaWJ1dGVzIGZvciBhbGwgZGV2aWNlcwo+IG9u
IGFuIG5kIGJ1cwo+ICAqLwo+IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgbmRfbnVtYV9hdHRyaWJ1
dGVfZ3JvdXAgPSB7Cj4gICAgICAgIC5hdHRycyA9IG5kX251bWFfYXR0cmlidXRlcywKClRoaXMg
d29u4oCZdCB3b3JrIGJlY2F1c2Uga2VybmVsLWRvYyBpcyB0byBleHBsYWluIGEgc3RydWN0IGRl
ZmluaXRpb24sIGJ1dCB0aGlzIGlzIGEganVzdCBhbiBhc3NpZ25tZW50LgpUaGUgInN0cnVjdCBh
dHRyaWJ1dGVfZ3JvdXDigJ0ga2VybmVsLWRvYyBpcyBpbiBpbmNsdWRlL2xpbnV4L3N5c2ZzLmgu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
ZGltbSBtYWlsaW5nIGxpc3QKTGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpodHRwczovL2xpc3Rz
LjAxLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52ZGltbQo=
