Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B181FCE0
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 02:34:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A673E212794C1;
	Wed, 15 May 2019 17:34:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::844; helo=mail-qt1-x844.google.com;
 envelope-from=cai@lca.pw; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7FE41212733EA
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 17:34:22 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h1so1988287qtp.1
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 17:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=ScXaFeR9V6kuvpwBg/U8HCbHPSnAvCsxxSit7yP9Jc8=;
 b=VPAqTble6hRyhsj3VGsjmxvb/J600GeROXMLfbdJ6vJcB2QKVPQa4totwCIhVpAi0n
 fN/2i4xmqUU2K3TkH6isLjLJWlQD30QnMNLx8EUdVTEeWVFZvh/vKoY1nb5krg2tHLCS
 Fub3F2MxHS9blqY/JPQ6blDIYMbCWD0iZTBf3fBxRQFxKqrAD3LbAXUOp4cf1ahMj5mg
 IfS3mvd2iAFmLvH5NZnPLrV+7UsTHdP5gMb058Qqqz20YZd/Hs+TPC9AHHmAkTecNF2H
 MsjLMEBD8xE8AEmL8feaD27CqUASJ7om3ksk/ydwDkv9n/7EMizkt6HnwSCwiQs02cii
 YXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=ScXaFeR9V6kuvpwBg/U8HCbHPSnAvCsxxSit7yP9Jc8=;
 b=nlRgb3NdycYOcOEGVjHc4ptr/J+WO7PqQdM9od9P5fpxmJL/cr2RGVYxTWFj09zZo7
 w63sdl5Nw6M0H16yoJGhOEvjiKaMuzGa5YpTjqajQKZCL5v9hitMaFylRYB5KnAKsgCL
 +jrUMV/x+N9vwCd2OyJwFoGIUkmxmNvuXFSYdILHrnYvOyJaLAAqdgrBUTiIxjm+fClB
 FS0sxWm2qPPzZkPNfY81MFyjCUqkiZIFGNWHRNxYTxSR0VJ76I6XNKC7uqAJdCFlrhH3
 LJd8owOU1kwJux3ihjY+WRl9yxMPhpRMtn7uoo70etQJM6MLDa+0n/uGqawNArriEe4g
 kV6A==
X-Gm-Message-State: APjAAAVjZs08qZ2/S5N7ibxdTQfKQfSDizNIW4H8+xLykryDOMjf8eRm
 WS9JCJNa6JssrRDPfOKxE2/Dnw==
X-Google-Smtp-Source: APXvYqxhnAL2MaTuSVRizp2xd9h/At7dau6miw7VR54nxw0WijrnCLeY+lfrVIB7bfiMVF28SDOghw==
X-Received: by 2002:aed:20c4:: with SMTP id 62mr39762062qtb.256.1557966861491; 
 Wed, 15 May 2019 17:34:21 -0700 (PDT)
Received: from qians-mbp.fios-router.home
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id b22sm2287417qtc.37.2019.05.15.17.34.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 May 2019 17:34:20 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RESEND PATCH] nvdimm: fix some compilation warnings
From: Qian Cai <cai@lca.pw>
In-Reply-To: <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
Date: Wed, 15 May 2019 20:34:19 -0400
Message-Id: <7BCECDBE-EC7B-47C6-AF7F-15C67AAA1D6F@lca.pw>
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

Cgo+IE9uIE1heSAxNSwgMjAxOSwgYXQgNzoyNSBQTSwgRGFuIFdpbGxpYW1zIDxkYW4uai53aWxs
aWFtc0BpbnRlbC5jb20+IHdyb3RlOgo+IAo+IE9uIFR1ZSwgTWF5IDE0LCAyMDE5IGF0IDg6MDgg
QU0gUWlhbiBDYWkgPGNhaUBsY2EucHc+IHdyb3RlOgo+PiAKPj4gU2V2ZXJhbCBwbGFjZXMgKGRp
bW1fZGV2cy5jLCBjb3JlLmMgZXRjKSBpbmNsdWRlIGxhYmVsLmggYnV0IG9ubHkKPj4gbGFiZWwu
YyB1c2VzIE5TSU5ERVhfU0lHTkFUVVJFLCBzbyBtb3ZlIGl0cyBkZWZpbml0aW9uIHRvIGxhYmVs
LmMKPj4gaW5zdGVhZC4KPj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvbnZkaW1tL2Rp
bW1fZGV2cy5jOjIzOgo+PiBkcml2ZXJzL252ZGltbS9sYWJlbC5oOjQxOjE5OiB3YXJuaW5nOiAn
TlNJTkRFWF9TSUdOQVRVUkUnIGRlZmluZWQgYnV0Cj4+IG5vdCB1c2VkIFstV3VudXNlZC1jb25z
dC12YXJpYWJsZT1dCj4+IAo+PiBUaGUgY29tbWl0IGQ5YjgzYzc1Njk1MyAoImxpYm52ZGltbSwg
YnR0OiByZXdvcmsgZXJyb3IgY2xlYXJpbmciKSBsZWZ0Cj4+IGFuIHVudXNlZCB2YXJpYWJsZS4K
Pj4gZHJpdmVycy9udmRpbW0vYnR0LmM6IEluIGZ1bmN0aW9uICdidHRfcmVhZF9wZyc6Cj4+IGRy
aXZlcnMvbnZkaW1tL2J0dC5jOjEyNzI6ODogd2FybmluZzogdmFyaWFibGUgJ3JjJyBzZXQgYnV0
IG5vdCB1c2VkCj4+IFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQo+PiAKPj4gTGFzdCwgc29t
ZSBwbGFjZXMgYWJ1c2UgIi8qKiIgd2hpY2ggaXMgb25seSByZXNlcnZlZCBmb3IgdGhlIGtlcm5l
bC1kb2MuCj4+IGRyaXZlcnMvbnZkaW1tL2J1cy5jOjY0ODogd2FybmluZzogY2Fubm90IHVuZGVy
c3RhbmQgZnVuY3Rpb24gcHJvdG90eXBlOgo+PiAnc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBuZF9k
ZXZpY2VfYXR0cmlidXRlX2dyb3VwID0gJwo+PiBkcml2ZXJzL252ZGltbS9idXMuYzo2Nzc6IHdh
cm5pbmc6IGNhbm5vdCB1bmRlcnN0YW5kIGZ1bmN0aW9uIHByb3RvdHlwZToKPj4gJ3N0cnVjdCBh
dHRyaWJ1dGVfZ3JvdXAgbmRfbnVtYV9hdHRyaWJ1dGVfZ3JvdXAgPSAnCj4gCj4gQ2FuIHlvdSBp
bmNsdWRlIHRoZSBjb21waWxlciB3aGVyZSB0aGVzZSBlcnJvcnMgc3RhcnQgYXBwZWFyaW5nLCBz
aW5jZQo+IEkgZG9uJ3Qgc2VlIHRoZXNlIHdhcm5pbmdzIHdpdGggZ2NjLTguMy4xCgpUaGlzIGNh
biBiZSByZXByb2R1Y2VkIGJ5IHBlcmZvcm1pbmcgZXh0cmEgY29tcGlsZXIgY2hlY2tzLCBpLmUs
ICJtYWtlIFc9buKAnS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3Jn
Cmh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
