Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93D9380CB
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Jun 2019 00:31:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C5D452194D3B8;
	Thu,  6 Jun 2019 15:31:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22a; helo=mail-lj1-x22a.google.com;
 envelope-from=swanson@eng.ucsd.edu; receiver=linux-nvdimm@lists.01.org 
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7E07A212909FF
 for <linux-nvdimm@lists.01.org>; Thu,  6 Jun 2019 15:29:36 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id k18so10052ljc.11
 for <linux-nvdimm@lists.01.org>; Thu, 06 Jun 2019 15:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eng.ucsd.edu; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=q4j7x31i6rFLlSXtWt71cVWGpDLKLLlylAlIJ/GH3P4=;
 b=MUUZ/otqQNQ+4JUyizBlfUvT3pgeF9hBWSrPrunXuPlc5RSAyKK12brIgdR6Nv3UCR
 fcX6RjJJkZx4+zPQTdyUlgliamV3BgwfGx3ANTvJfkA7Y8vg6lWAKNHNQeVAxi8iDLL4
 W1i1FLUFwmdOhsmVC8GTUASrZ3VmtK5t36k1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=q4j7x31i6rFLlSXtWt71cVWGpDLKLLlylAlIJ/GH3P4=;
 b=TvNy3Obf5rZJjI7zm/c6HsCQV17xX9MpA3tDudb9NqY7MckCzzlLm2rTdCzfUPD7KG
 5oVOKE1/dpNVfIbDSNfc478DAxAKYCifyzV7ldv6TVZg+pO39vLd8FMZvT8SGM0XXyDV
 vnVJq1qCf+DE6zHcvKS825rE0UWPOuOnHtQ4UDUzUhlF3Rw60yd2F7n/14iPSzif1WEl
 hk2KJIxNgVmLrc3xP13tNIdOLy2nYjJAFjns33VTI1w89VpI7iV+0RZACeQYmnOrGIDt
 MGSe29qHkq0/HmdIJk7HJwnVLxaNS5wYT656bPFaDRRmhOWovGh/b6z2aAKjESGf84zn
 VBcw==
X-Gm-Message-State: APjAAAUwyyXMYN1MjN+h1lsYTgJeSwTe00lUrCidzVO3wh9LJ5fwoNyp
 /SrjDI+/HxqSVlkNblG0T/da5hFIn8WRahpV4f92KGspaRA=
X-Google-Smtp-Source: APXvYqzL68WQwyP+3Wgcz1zNzFdT7kIBVKfHz0BOIrqUEG/XeKPZrE+Mgdyvi1XdfQTzVLjr6rQTkjrxebXBN8bfhl8=
X-Received: by 2002:a2e:3913:: with SMTP id g19mr11709170lja.212.1559860174208; 
 Thu, 06 Jun 2019 15:29:34 -0700 (PDT)
MIME-Version: 1.0
From: Steven Swanson <swanson@eng.ucsd.edu>
Date: Thu, 6 Jun 2019 15:29:23 -0700
Message-ID: <CABjYnA6fxLO1HnLgV17TJAYADNamJ729BS=6CsxoU2kCiJ-RVQ@mail.gmail.com>
Subject: Persistent Programming in Real Life (PIRL) Call for Presentations
To: linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

WW91IGFyZSBpbnZpdGVkIHRvIHByb3Bvc2UgYSBwcmVzZW50YXRpb24gYXQgdGhlIGZpcnN0IGFu
bnVhbCBQZXJzaXN0ZW50ClByb2dyYW1taW5nIGluIFJlYWwgTGlmZSAoUElSTCkgKGh0dHBzOi8v
cGlybC5udnNsLmlvLykuICBQSVJMIGJyaW5ncwp0b2dldGhlciBzb2Z0d2FyZSBkZXZlbG9wbWVu
dCBsZWFkZXJzIGludGVyZXN0ZWQgaW4gbGVhcm5pbmcgYWJvdXQKcHJvZ3JhbW1pbmcgbWV0aG9k
b2xvZ2llcyBmb3IgcGVyc2lzdGVudCBtZW1vcmllcyAoZS5nLiBOVkRJTU1zLCBPcHRhbmUgREMp
CmFuZCBzaGFyaW5nIHRoZWlyIGV4cGVyaWVuY2VzIHdpdGggb3RoZXJzLgoKVGVsbCB1cyBhYm91
dCB3aGF0IHlvdSBoYXZlIGRvbmUgKGFuZCB3YW50IHRvIGRvKSB3aXRoIHBlcnNpc3RlbnQgbWVt
b3J5LAp3aGF0IHdvcmtlZCwgd2hhdCBkaWRu4oCZdCwgd2hhdCB3YXMgaGFyZCwgd2hhdCB3YXMg
ZWFzeSwgd2hhdCB3YXMKc3VycHJpc2luZywgYW5kIHdoYXQgZGlkIHlvdSBsZWFybj8gSG93IGNh
biBvdGhlcnMgbGVhcm4gZnJvbSB5b3VyCmV4cGVyaWVuY2U/CgpQSVJMIGlzIHNtYWxsLiAgV2Ug
YXJlIGxpbWl0aW5nIGF0dGVuZGFuY2UgdGhpcyB5ZWFyIHRvIHVuZGVyIDEwMCBwZW9wbGUsCmlu
Y2x1ZGluZyBzcGVha2Vycy4gIFRoZXJlIHdpbGwgYmUgbG90cyBvZiB0aW1lIGZvciBpbmZvcm1h
bCBkaXNjdXNzaW9uIGFuZApuZXR3b3JraW5nLgoKV2UgaGF2ZSBhbiBleGNpdGluZyBzbGF0ZSBv
ZiBrZXlub3RlIHNwZWFrZXJzIGxpbmVkIHVwOgoKUHJhdGFwIFN1YnJhaG1hbnlhbSAoVk13YXJl
KQpKaWEgU2hpIChPcmFjbGUpCkRhbiBXaWxsaWFtcyAoSW50ZWwgQ29ycG9yYXRpb24pClNjb3R0
IE1pbGxlciAoRHJlYW13b3JrcykKU3RlcGhlbiBCYXRlcyAoRWlkZXRpY29tKQoKSWYgeW91IHdv
dWxkIGxpa2UgdG8gcHJlc2VudCBhdCBQSVJMLCBmaWxsIG91dCB0aGlzIGZvcm0gKApodHRwczov
L2RvY3MuZ29vZ2xlLmNvbS9mb3Jtcy9kL2UvMUZBSXBRTFNmS3dLem5hT1VrS2h3dmJTbGhUU1dN
Q3lPLVJYUnkyUVZoZVV3QVR6QTdudnpRelEvdmlld2Zvcm0pLgpGb3IgaW5zdGFuY2UsICBhIHBy
b3Bvc2FsIG1pZ2h0IGluY2x1ZGU6CjEuIFdoYXQgeW91IGRpZCBvciBhcmUgdHJ5aW5nIHRvIGRv
LgoyLiBZb3VyIGV4cGVyaWVuY2UsIGFuZCB0aGUgbGVzc29ucyBvdGhlcnMgY2FuIGxlYXJuIGZy
b20gaXQuCjMuIFdlIGV4cGVjdCB0byBzZWUgY29kZSEKCldlIHdlbGNvbWUgdGFsa3MgdGhhdCBk
ZXNjcmliZSBuZXcgdG9vbHMsIGJ1dCB3ZSBhcmUgbm90IGludGVyZXN0ZWQgaW4Kc2FsZXMgcGl0
Y2hlcy4gIEF0dGVuZGVlcyBzaG91bGQgY29tZSBhd2F5IGZyb20gZXZlcnkgc2Vzc2lvbiB3aXRo
CmFjdGlvbmFibGUgaW5mb3JtYXRpb24gdGhhdCBjYW4gYmUgdXRpbGl6ZWQgdG8gdXNlIHBlcnNp
c3RlbnQgbWVtb3J5IG1vcmUKZWZmZWN0aXZlbHkuClByZXNlbnRhdGlvbiBGb3JtYXQKCldlIGFy
ZSBvcGVuIHRvIG1hbnkgZGlmZmVyZW50IGtpbmRzIG9mIHRhbGtzLiAgUG9zc2liaWxpdGllcyBp
bmNsdWRlOgoxLiBUYWxrcyBhYm91dCBleHBlcmllbmNlcyBvbiBhIHBhcnRpY3VsYXIgcHJvamVj
dC4KMi4gUG90ZW50aWFsbHkgZGV2ZWxvcCBvciB3cml0ZSBjb2RlIGxpdmUgb3IgcHJvdmlkZSBz
YW1wbGVzIGR1cmluZyB0aGUKcHJlc2VudGF0aW9uLgozLiBEbyB5b3UgaGF2ZSBhIGZ1biBjaGFs
bGVuZ2UgZm9yIHBlcnNpc3RlbnQgY29kaW5nPyAgV2XigJlyZSBhY2NlcHRpbmcgY29kZQpjaGFs
bGVuZ2VzLCBhbmQgd2XigJlsbCBiZSBvZmZlcmluZyB0d28gb3IgdGhyZWUgb2YgdGhlbSBzbyB5
b3UgY2FuIHNob3cKb3RoZXJzIHlvdXIgc2tpbGxzLgoKUElSTCB3aWxsIGJlIGhvc3RlZCBieSB0
aGUgTm9uLVZvbGF0aWxlIFN5c3RlbXMgTGFib3JhdG9yeSBhdCB0aGUKVW5pdmVyc2l0eSBvZiBD
YWxpZm9ybmlhLCBTYW4gRGllZ28uICBJdCB3aWxsIGJlIGhlbGQgYXQgU2NyaXBwcyBGb3J1bSAo
Cmh0dHBzOi8vc2NyaXBwcy51Y3NkLmVkdS9hYm91dC92ZW51ZXMvc2Vhc2lkZS1mb3J1bSkgb24g
SnVseSAyMm5kIHRvIDIzcmQsCjIwMTksIHdpdGggYSBzb2NpYWwgZXZlbnQgdGhlIGV2ZW5pbmcg
b2YgSnVseSAyMXN0LgoKUHJlLXJlZ2lzdHJhdGlvbiBpcyBvcGVuICgKaHR0cHM6Ly93d3cuZXZl
bnRicml0ZS5jb20vZS9waXJsLXJlZ2lzdHJhdGlvbi02MjIxOTQ5ODE5NCkgYW5kIHdpbGwgYmUK
JDQwMC4gU3BhY2UgaXMgbGltaXRlZC4KCklmIHlvdSBoYXZlIGFueSBxdWVzdGlvbnMsIHBsZWFz
ZSBjb250YWN0IFN0ZXZlbiBTd2Fuc29uICgKc3dhbnNvbkBjcy51Y3NkLmVkdSkuCk9yZ2FuaXpp
bmcgQ29tbWl0dGVlCgpTdGV2ZW4gU3dhbnNvbiAoVUNTRCkgSmltIEZpc3RlciAoU05JQSkgQW5k
eSBSdWRvZmYgKEludGVsKQoKSmlzaGVuIFpoYW8gKFVDU0QpIEpvZSBJenJhZWxldml0eiAoVUNT
RCkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZkaW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlz
dHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
