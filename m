Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551B41830B
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 May 2019 03:01:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8E9A821256BC8;
	Wed,  8 May 2019 18:01:06 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=frowand.list@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A682B2122C2F3
 for <linux-nvdimm@lists.01.org>; Wed,  8 May 2019 18:01:04 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w22so268943pgi.6
 for <linux-nvdimm@lists.01.org>; Wed, 08 May 2019 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yViYa+n9NYDtvHDz0r+K4+Oq95Cqmi6zykBegH2S9+U=;
 b=q6xuWARhhaCyOtUDiM13Mq2TCdqcqKupS3zwIqMPehPxy2dz2ZMD7U2PVt+jR9lZz+
 2nRqsnpVOKzcK54vtxFntv+RFvdYg4stm9737Agrnk2/tY5aURLb8arfUosWg9ydusYH
 W1TWfgD3pvEWC39AVZVJ4j3ptsQ9ZNc7yOXKPURwxPcO9gN+TT273HnVJ3QjfSDMsugZ
 HwS2354TdboEeYwv/UOXS1+XimZ2WljTCF2XE0z5K9/D/XSnTxbJImLp2p1Y0Y8MbhcW
 ahg4eVcH+uEmwOrLS6T5gfmIwH8EtOEJaiZEHJ2OETOp0h4LkXlUemXkJCW5Vv5rKgFC
 X1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yViYa+n9NYDtvHDz0r+K4+Oq95Cqmi6zykBegH2S9+U=;
 b=MjqpSpz6c7cKT5hlAeOBPJjhagbSk4V8iRaazeGGzvUtkKykoy5iVb31F4428NMD4N
 JeKGF227tyy+BQZxkDj7BYEOaUPolAQPYMFfws18yeT/ltfgYuBdvd1EZwV/m5Qpq0Cg
 EIsxYig1NSlRiRYey5Uk/fGVsB1i6s7TXbuQuXK9uU/auVVkUswOlR34KA6aeTq7FgAZ
 K2JKJp2ctZ+eEc1DOQCC0fTxAuNA1i088oRp9Q/3QsvnGQYCm+LR2dNcexZ6tnkzRzSW
 1/EuQ0Ymb79GR2yg08XXIttr55u5L8MWy3DPLzZiW2fVyq5YcnJN/DTpl3qAE/azyj0y
 JKyg==
X-Gm-Message-State: APjAAAVQbR0aCNqDk58yIh7vDifOmurU3NDWXJ/1QDhlEKXrK4obVDYm
 s7TPoG4atL+th02TIUiPfzQ=
X-Google-Smtp-Source: APXvYqz/V92Failmv0rkia78qR5hdpdS0xfB1JYjVMeOpzkJ527SwnH/qSInDGxbdmN18Nckfk3b+A==
X-Received: by 2002:aa7:8a81:: with SMTP id a1mr900658pfc.121.1557363664135;
 Wed, 08 May 2019 18:01:04 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u66sm553077pfb.76.2019.05.08.18.01.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 May 2019 18:01:03 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: shuah <shuah@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com>
 <1b1efa91-0523-21a9-e541-fdc3612bd117@kernel.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <911e44bb-9bb1-e603-a260-fac63760fff6@gmail.com>
Date: Wed, 8 May 2019 18:01:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1b1efa91-0523-21a9-e541-fdc3612bd117@kernel.org>
Content-Language: en-US
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com,
 Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org,
 Alexander.Levin@microsoft.com, mpe@ellerman.id.au,
 linux-kselftest@vger.kernel.org, robh@kernel.org, linux-nvdimm@lists.01.org,
 khilman@baylibre.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com,
 wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 richard@nod.at, sboyd@kernel.org, linux-kernel@vger.kernel.org,
 mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gNS83LzE5IDg6MjMgQU0sIHNodWFoIHdyb3RlOgo+IE9uIDUvNy8xOSAyOjAxIEFNLCBHcmVn
IEtIIHdyb3RlOgo+PiBPbiBNb24sIE1heSAwNiwgMjAxOSBhdCAwODoxNDoxMlBNIC0wNzAwLCBG
cmFuayBSb3dhbmQgd3JvdGU6Cj4+PiBPbiA1LzEvMTkgNDowMSBQTSwgQnJlbmRhbiBIaWdnaW5z
IHdyb3RlOgo+Pj4+ICMjIFRMRFIKPj4+Pgo+Pj4+IEkgcmViYXNlZCB0aGUgbGFzdCBwYXRjaHNl
dCBvbiA1LjEtcmM3IGluIGhvcGVzIHRoYXQgd2UgY2FuIGdldCB0aGlzIGluCj4+Pj4gNS4yLgo+
Pj4+Cj4+Pj4gU2h1YWgsIEkgdGhpbmsgeW91LCBHcmVnIEtILCBhbmQgbXlzZWxmIHRhbGtlZCBv
ZmYgdGhyZWFkLCBhbmQgd2UgYWdyZWVkCj4+Pj4gd2Ugd291bGQgbWVyZ2UgdGhyb3VnaCB5b3Vy
IHRyZWUgd2hlbiB0aGUgdGltZSBjYW1lPyBBbSBJIHJlbWVtYmVyaW5nCj4+Pj4gY29ycmVjdGx5
Pwo+Pj4+Cj4+Pj4gIyMgQmFja2dyb3VuZAo+Pj4+Cj4+Pj4gVGhpcyBwYXRjaCBzZXQgcHJvcG9z
ZXMgS1VuaXQsIGEgbGlnaHR3ZWlnaHQgdW5pdCB0ZXN0aW5nIGFuZCBtb2NraW5nCj4+Pj4gZnJh
bWV3b3JrIGZvciB0aGUgTGludXgga2VybmVsLgo+Pj4+Cj4+Pj4gVW5saWtlIEF1dG90ZXN0IGFu
ZCBrc2VsZnRlc3QsIEtVbml0IGlzIGEgdHJ1ZSB1bml0IHRlc3RpbmcgZnJhbWV3b3JrOwo+Pj4+
IGl0IGRvZXMgbm90IHJlcXVpcmUgaW5zdGFsbGluZyB0aGUga2VybmVsIG9uIGEgdGVzdCBtYWNo
aW5lIG9yIGluIGEgVk0KPj4+PiBhbmQgZG9lcyBub3QgcmVxdWlyZSB0ZXN0cyB0byBiZSB3cml0
dGVuIGluIHVzZXJzcGFjZSBydW5uaW5nIG9uIGEgaG9zdAo+Pj4+IGtlcm5lbC4gQWRkaXRpb25h
bGx5LCBLVW5pdCBpcyBmYXN0OiBGcm9tIGludm9jYXRpb24gdG8gY29tcGxldGlvbiBLVW5pdAo+
Pj4+IGNhbiBydW4gc2V2ZXJhbCBkb3plbiB0ZXN0cyBpbiB1bmRlciBhIHNlY29uZC4gQ3VycmVu
dGx5LCB0aGUgZW50aXJlCj4+Pj4gS1VuaXQgdGVzdCBzdWl0ZSBmb3IgS1VuaXQgcnVucyBpbiB1
bmRlciBhIHNlY29uZCBmcm9tIHRoZSBpbml0aWFsCj4+Pj4gaW52b2NhdGlvbiAoYnVpbGQgdGlt
ZSBleGNsdWRlZCkuCj4+Pj4KPj4+PiBLVW5pdCBpcyBoZWF2aWx5IGluc3BpcmVkIGJ5IEpVbml0
LCBQeXRob24ncyB1bml0dGVzdC5tb2NrLCBhbmQKPj4+PiBHb29nbGV0ZXN0L0dvb2dsZW1vY2sg
Zm9yIEMrKy4gS1VuaXQgcHJvdmlkZXMgZmFjaWxpdGllcyBmb3IgZGVmaW5pbmcKPj4+PiB1bml0
IHRlc3QgY2FzZXMsIGdyb3VwaW5nIHJlbGF0ZWQgdGVzdCBjYXNlcyBpbnRvIHRlc3Qgc3VpdGVz
LCBwcm92aWRpbmcKPj4+PiBjb21tb24gaW5mcmFzdHJ1Y3R1cmUgZm9yIHJ1bm5pbmcgdGVzdHMs
IG1vY2tpbmcsIHNweWluZywgYW5kIG11Y2ggbW9yZS4KPj4+Cj4+PiBBcyBhIHJlc3VsdCBvZiB0
aGUgZW1haWxzIHJlcGx5aW5nIHRvIHRoaXMgcGF0Y2ggdGhyZWFkLCBJIGFtIG5vdwo+Pj4gc3Rh
cnRpbmcgdG8gbG9vayBhdCBrc2VsZnRlc3QuwqAgTXkgbGV2ZWwgb2YgdW5kZXJzdGFuZGluZyBp
cyBiYXNlZAo+Pj4gb24gc29tZSBzbGlkZSBwcmVzZW50YXRpb25zLCBhbiBMV04gYXJ0aWNsZSwg
aHR0cHM6Ly9rc2VsZnRlc3Qud2lraS5rZXJuZWwub3JnLwo+Pj4gYW5kIGEgX3RpbnlfIGJpdCBv
ZiBsb29raW5nIGF0IGtzZWxmdGVzdCBjb2RlLgo+Pj4KPj4+IHRsO2RyOyBJIGRvbid0IHJlYWxs
eSB1bmRlcnN0YW5kIGtzZWxmdGVzdCB5ZXQuCj4+Pgo+Pj4KPj4+ICgxKSB3aHkgS1VuaXQgZXhp
c3RzCj4+Pgo+Pj4+ICMjIFdoYXQncyBzbyBzcGVjaWFsIGFib3V0IHVuaXQgdGVzdGluZz8KPj4+
Pgo+Pj4+IEEgdW5pdCB0ZXN0IGlzIHN1cHBvc2VkIHRvIHRlc3QgYSBzaW5nbGUgdW5pdCBvZiBj
b2RlIGluIGlzb2xhdGlvbiwKPj4+PiBoZW5jZSB0aGUgbmFtZS4gVGhlcmUgc2hvdWxkIGJlIG5v
IGRlcGVuZGVuY2llcyBvdXRzaWRlIHRoZSBjb250cm9sIG9mCj4+Pj4gdGhlIHRlc3Q7IHRoaXMg
bWVhbnMgbm8gZXh0ZXJuYWwgZGVwZW5kZW5jaWVzLCB3aGljaCBtYWtlcyB0ZXN0cyBvcmRlcnMK
Pj4+PiBvZiBtYWduaXR1ZGVzIGZhc3Rlci4gTGlrZXdpc2UsIHNpbmNlIHRoZXJlIGFyZSBubyBl
eHRlcm5hbCBkZXBlbmRlbmNpZXMsCj4+Pj4gdGhlcmUgYXJlIG5vIGhvb3BzIHRvIGp1bXAgdGhy
b3VnaCB0byBydW4gdGhlIHRlc3RzLiBBZGRpdGlvbmFsbHksIHRoaXMKPj4+PiBtYWtlcyB1bml0
IHRlc3RzIGRldGVybWluaXN0aWM6IGEgZmFpbGluZyB1bml0IHRlc3QgYWx3YXlzIGluZGljYXRl
cyBhCj4+Pj4gcHJvYmxlbS4gRmluYWxseSwgYmVjYXVzZSB1bml0IHRlc3RzIG5lY2Vzc2FyaWx5
IGhhdmUgZmluZXIgZ3JhbnVsYXJpdHksCj4+Pj4gdGhleSBhcmUgYWJsZSB0byB0ZXN0IGFsbCBj
b2RlIHBhdGhzIGVhc2lseSBzb2x2aW5nIHRoZSBjbGFzc2ljIHByb2JsZW0KPj4+PiBvZiBkaWZm
aWN1bHR5IGluIGV4ZXJjaXNpbmcgZXJyb3IgaGFuZGxpbmcgY29kZS4KPj4+Cj4+PiAoMikgS1Vu
aXQgaXMgbm90IG1lYW50IHRvIHJlcGxhY2Uga3NlbGZ0ZXN0Cj4+Pgo+Pj4+ICMjIElzIEtVbml0
IHRyeWluZyB0byByZXBsYWNlIG90aGVyIHRlc3RpbmcgZnJhbWV3b3JrcyBmb3IgdGhlIGtlcm5l
bD8KPj4+Pgo+Pj4+IE5vLiBNb3N0IGV4aXN0aW5nIHRlc3RzIGZvciB0aGUgTGludXgga2VybmVs
IGFyZSBlbmQtdG8tZW5kIHRlc3RzLCB3aGljaAo+Pj4+IGhhdmUgdGhlaXIgcGxhY2UuIEEgd2Vs
bCB0ZXN0ZWQgc3lzdGVtIGhhcyBsb3RzIG9mIHVuaXQgdGVzdHMsIGEKPj4+PiByZWFzb25hYmxl
IG51bWJlciBvZiBpbnRlZ3JhdGlvbiB0ZXN0cywgYW5kIHNvbWUgZW5kLXRvLWVuZCB0ZXN0cy4g
S1VuaXQKPj4+PiBpcyBqdXN0IHRyeWluZyB0byBhZGRyZXNzIHRoZSB1bml0IHRlc3Qgc3BhY2Ug
d2hpY2ggaXMgY3VycmVudGx5IG5vdAo+Pj4+IGJlaW5nIGFkZHJlc3NlZC4KPj4+Cj4+PiBNeSB1
bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlIGludGVudCBvZiBLVW5pdCBpcyB0byBhdm9pZCBib290
aW5nIGEga2VybmVsIG9uCj4+PiByZWFsIGhhcmR3YXJlIG9yIGluIGEgdmlydHVhbCBtYWNoaW5l
LsKgIFRoYXQgc2VlbXMgdG8gYmUgYSBtYXR0ZXIgb2Ygc2VtYW50aWNzCj4+PiB0byBtZSBiZWNh
dXNlIGlzbid0IGludm9raW5nIGEgVU1MIExpbnV4IGp1c3QgcnVubmluZyB0aGUgTGludXgga2Vy
bmVsIGluCj4+PiBhIGRpZmZlcmVudCBmb3JtIG9mIHZpcnR1YWxpemF0aW9uPwo+Pj4KPj4+IFNv
IEkgZG8gbm90IHVuZGVyc3RhbmQgd2h5IEtVbml0IGlzIGFuIGltcHJvdmVtZW50IG92ZXIga3Nl
bGZ0ZXN0Lgo+IAo+IFRoZXkgYXJlIGluIHR3byBkaWZmZXJlbnQgY2F0ZWdvcmllcy4gS3NlbGZ0
ZXN0IGZhbGxzIGludG8gYmxhY2sgYm94Cj4gcmVncmVzc2lvbiB0ZXN0IHN1aXRlIHdoaWNoIGlz
IGEgY29sbGVjdGlvbiBvZiB1c2VyLXNwYWNlIHRlc3RzIHdpdGggYQo+IGZldyBrZXJuZWwgdGVz
dCBtb2R1bGVzIGJhY2stZW5kaW5nIHRoZSB0ZXN0cyBpbiBzb21lIGNhc2VzLgo+IAo+IEtzZWxm
dGVzdCBjYW4gYmUgdXNlZCBieSBib3RoIGtlcm5lbCBkZXZlbG9wZXJzIGFuZCB1c2VycyBhbmQg
cHJvdmlkZXMKPiBhIGdvb2Qgd2F5IHRvIHJlZ3Jlc3Npb24gdGVzdCByZWxlYXNlcyBpbiB0ZXN0
IHJpbmdzLgo+IAo+IEtVbml0IGlzIGEgd2hpdGUgYm94IGNhdGVnb3J5IGFuZCBpcyBhIGJldHRl
ciBmaXQgYXMgdW5pdCB0ZXN0IGZyYW1ld29yawo+IGZvciBkZXZlbG9wbWVudCBhbmQgcHJvdmlk
ZXMgYSBpbi1rZXJuZWwgdGVzdGluZy4gSSB3b3VsZG4ndCB2aWV3IHRoZW0KPiBvbmUgcmVwbGFj
aW5nIHRoZSBvdGhlci4gVGhleSBqdXN0IHByb3ZpZGUgY292ZXJhZ2UgZm9yIGRpZmZlcmVudCBh
cmVhcwo+IG9mIHRlc3RpbmcuCgpJIGRvbid0IHNlZSB3aGF0IGFib3V0IGtzZWxmdGVzdCBvciBL
VW5pdCBpcyBpbmhlcmVudGx5IGJsYWNrIGJveCBvcgp3aGl0ZSBib3guICBJIHdvdWxkIGV4cGVj
dCBib3RoIGZyYW1ld29ya3MgdG8gYmUgdXNlZCBmb3IgZWl0aGVyIHR5cGUKb2YgdGVzdGluZy4K
Cgo+IEkgd291bGRuJ3QgdmlldyBLVW5pdCBhcyBzb21ldGhpbmcgdGhhdCB3b3VsZCBiZSBlYXNp
bHkgcnVuIGluIHRlc3QgcmluZ3MgZm9yIGV4YW1wbGUuCgpJIGRvbid0IHNlZSB3aHkgbm90LgoK
LUZyYW5rCgo+IAo+IEJyZW5kYW4sIGRvZXMgdGhhdCBzb3VuZCBhYm91dCByaWdodD8KPiAKPj4+
Cj4+PiBJdCBzZWVtcyB0byBtZSB0aGF0IEtVbml0IGlzIGp1c3QgYW5vdGhlciBwaWVjZSBvZiBp
bmZyYXN0cnVjdHVyZSB0aGF0IEkKPj4+IGFtIGdvaW5nIHRvIGhhdmUgdG8gYmUgZmFtaWxpYXIg
d2l0aCBhcyBhIGtlcm5lbCBkZXZlbG9wZXIuwqAgTW9yZSBvdmVyaGVhZCwKPj4+IG1vcmUgaW5m
b3JtYXRpb24gdG8gc3R1ZmYgaW50byBteSB0aW55IGxpdHRsZSBicmFpbi4KPj4+Cj4+PiBJIHdv
dWxkIGd1ZXNzIHRoYXQgc29tZSBkZXZlbG9wZXJzIHdpbGwgZm9jdXMgb24ganVzdCBvbmUgb2Yg
dGhlIHR3byB0ZXN0Cj4+PiBlbnZpcm9ubWVudHMgKGFuZCBzb21lIHdpbGwgZm9jdXMgb24gYm90
aCksIHNwbGl0dGluZyB0aGUgZGV2ZWxvcG1lbnQKPj4+IHJlc291cmNlcyBpbnN0ZWFkIG9mIHBv
b2xpbmcgdGhlbSBvbiBhIGNvbW1vbiBpbmZyYXN0cnVjdHVyZS4KPiAKPj4+IFdoYXQgYW0gSSBt
aXNzaW5nPwo+Pgo+PiBrc2VsZnRlc3QgcHJvdmlkZXMgbm8gaW4ta2VybmVsIGZyYW1ld29yayBm
b3IgdGVzdGluZyBrZXJuZWwgY29kZQo+PiBzcGVjaWZpY2FsbHkuwqAgVGhhdCBzaG91bGQgYmUg
d2hhdCBrdW5pdCBwcm92aWRlcywgYW4gImVhc3kiIHdheSB0bwo+PiB3cml0ZSBpbi1rZXJuZWwg
dGVzdHMgZm9yIHRoaW5ncy4KPj4KPj4gQnJlbmRhbiwgZGlkIEkgZ2V0IGl0IHJpZ2h0Pwo+IHRo
YW5rcywKPiAtLSBTaHVhaAo+IC4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QKTGludXgtbnZkaW1tQGxp
c3RzLjAxLm9yZwpodHRwczovL2xpc3RzLjAxLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
ZGltbQo=
