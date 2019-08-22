Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF45988FF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Aug 2019 03:31:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 47E8920213F24;
	Wed, 21 Aug 2019 18:32:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=bhe@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E3AB420212CA7
 for <linux-nvdimm@lists.01.org>; Wed, 21 Aug 2019 18:32:12 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A3BE710F23EC;
 Thu, 22 Aug 2019 01:31:04 +0000 (UTC)
Received: from localhost (ovpn-12-48.pek2.redhat.com [10.72.12.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C02EA3DB3;
 Thu, 22 Aug 2019 01:31:03 +0000 (UTC)
Date: Thu, 22 Aug 2019 09:31:00 +0800
From: Baoquan He <bhe@redhat.com>
To: Qian Cai <cai@lca.pw>
Subject: Re: devm_memremap_pages() triggers a kasan_add_zero_shadow() warning
Message-ID: <20190822013100.GC2588@MiWiFi-R3L-srv>
References: <1565991345.8572.28.camel@lca.pw>
 <CAPcyv4i9VFLSrU75U0gQH6K2sz8AZttqvYidPdDcS7sU2SFaCA@mail.gmail.com>
 <0FB85A78-C2EE-4135-9E0F-D5623CE6EA47@lca.pw>
 <CAPcyv4h9Y7wSdF+jnNzLDRobnjzLfkGLpJsML2XYLUZZZUPsQA@mail.gmail.com>
 <E7A04694-504D-4FB3-9864-03C2CBA3898E@lca.pw>
 <CAPcyv4gofF-Xf0KTLH4EUkxuXdRO3ha-w+GoxgmiW7gOdS2nXQ@mail.gmail.com>
 <0AC959D7-5BCB-4A81-BBDC-990E9826EB45@lca.pw>
 <1566421927.5576.3.camel@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1566421927.5576.3.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 22 Aug 2019 01:31:04 +0000 (UTC)
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
 kasan-dev@googlegroups.com, Linux MM <linux-mm@kvack.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gMDgvMjEvMTkgYXQgMDU6MTJwbSwgUWlhbiBDYWkgd3JvdGU6Cj4gPiA+IERvZXMgZGlzYWJs
aW5nIENPTkZJR19SQU5ET01JWkVfQkFTRSBoZWxwPyBNYXliZSB0aGF0IHdvcmthcm91bmQgaGFz
Cj4gPiA+IHJlZ3Jlc3NlZC4gRWZmZWN0aXZlbHkgd2UgbmVlZCB0byBmaW5kIHdoYXQgaXMgY2F1
c2luZyB0aGUga2VybmVsIHRvCj4gPiA+IHNvbWV0aW1lcyBiZSBwbGFjZWQgaW4gdGhlIG1pZGRs
ZSBvZiBhIGN1c3RvbSByZXNlcnZlZCBtZW1tYXA9IHJhbmdlLgo+ID4gCj4gPiBZZXMsIGRpc2Fi
bGluZyBLQVNMUiB3b3JrcyBnb29kIHNvIGZhci4gQXNzdW1pbmcgdGhlIHdvcmthcm91bmQsIGku
ZS4sCj4gPiBmMjg0NDI0OTdiNWMKPiA+ICjigJx4ODYvYm9vdDogRml4IEtBU0xSIGFuZCBtZW1t
YXA9IGNvbGxpc2lvbuKAnSkgaXMgY29ycmVjdC4KPiA+IAo+ID4gVGhlIG9ubHkgb3RoZXIgY29t
bWl0IHRoYXQgbWlnaHQgcmVncmVzcyBpdCBmcm9tIG15IHJlc2VhcmNoIHNvIGZhciBpcywKPiA+
IAo+ID4gZDUyZTdkNWE5NTJjICgieDg2L0tBU0xSOiBQYXJzZSBhbGwgJ21lbW1hcD0nIGJvb3Qg
b3B0aW9uIGVudHJpZXPigJ0pCj4gPiAKPiAKPiBJdCB0dXJucyBvdXQgdGhhdCB0aGUgb3JpZ2lu
IGNvbW1pdCBmMjg0NDI0OTdiNWMgKOKAnHg4Ni9ib290OiBGaXggS0FTTFIgYW5kCj4gbWVtbWFw
PSBjb2xsaXNpb27igJ0pIGhhcyBhIGJ1ZyB0aGF0IGlzIHVuYWJsZSB0byBoYW5kbGUgIm1lbW1h
cD0iIGluCj4gQ09ORklHX0NNRExJTkUgaW5zdGVhZCBvZiBhIHBhcmFtZXRlciBpbiBib290bG9h
ZGVyIGJlY2F1c2Ugd2hlbiBpdCAoYXMgd2VsbCBhcwo+IHRoZSBjb21taXQgZDUyZTdkNWE5NTJj
KSBjYWxscyBnZXRfY21kX2xpbmVfcHRyKCkgaW4gb3JkZXIgdG8gcnVuCj4gbWVtX2F2b2lkX21l
bW1hcCgpLCAiYm9vdF9wYXJhbXMiIGhhcyBubyBrbm93bGVkZ2Ugb2YgQ09ORklHX0NNRExJTkUu
IE9ubHkgbGF0ZXIKPiBpbiBzZXR1cF9hcmNoKCksIHRoZSBrZXJuZWwgd2lsbCBkZWFsIHdpdGgg
cGFyYW1ldGVycyBvdmVyIHRoZXJlLgoKWWVzLCB3ZSBkaWRuJ3QgY29uc2lkZXIgQ09ORklHX0NN
RExJTkUgZHVyaW5nIGJvb3QgY29tcHJlc3Npbmcgc3RhZ2UuIEl0CnNob3VsZCBiZSBhIGdlbmVy
aWMgaXNzdWUgc2luY2Ugb3RoZXIgcGFyYW1ldGVycyBmcm9tIENPTkZJR19DTURMSU5FIGNvdWxk
CmJlIGlnbm9yZWQgdG9vLCBub3Qgb25seSBLQVNMUiBoYW5kbGluZy4gV291bGQgeW91IGxpa2Ug
dG8gY2FzdCBhIHBhdGNoCnRvIGZpeCBpdD8gT3IgSSBjYW4gZml4IGl0IGxhdGVyLCBtYXliZSBu
ZXh0IHdlZWsuCgpUaGFua3MKQmFvcXVhbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGltbUBs
aXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dmRpbW0K
