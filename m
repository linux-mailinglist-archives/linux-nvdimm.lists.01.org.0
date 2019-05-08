Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B30FE16F69
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 May 2019 05:13:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A435521237AC1;
	Tue,  7 May 2019 20:13:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=yi.zhang@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D4334211FB8B7
 for <linux-nvdimm@lists.01.org>; Tue,  7 May 2019 20:13:14 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 756E4821D1;
 Wed,  8 May 2019 03:13:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-41.pek2.redhat.com [10.72.12.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F6B464029;
 Wed,  8 May 2019 03:13:08 +0000 (UTC)
Subject: Re: [PATCH ndctl] ndctl, region: return the rc value in region_action
To: "Elliott, Robert (Servers)" <elliott@hpe.com>
References: <20190415082357.31127-1-yi.zhang@redhat.com>
 <CAPcyv4g5cp=5QZsTi02ouwqLPcoTFmos+146p9_jkgUofEhnzQ@mail.gmail.com>
 <AT5PR8401MB1169A9F7AADEA04F521CBDD0AB2B0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <0fcf4324-4a81-18eb-c4ea-6765b0994fd0@redhat.com>
Date: Wed, 8 May 2019 11:12:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <AT5PR8401MB1169A9F7AADEA04F521CBDD0AB2B0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 08 May 2019 03:13:13 +0000 (UTC)
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

SGkgRWxsaW90dAoKVGhhbmtzIGZvciB5b3VyIHJldmlldy4KCk9uIDQvMTYvMTkgMjoyOSBBTSwg
RWxsaW90dCwgUm9iZXJ0IChTZXJ2ZXJzKSB3cm90ZToKPgo+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQo+PiBGcm9tOiBMaW51eC1udmRpbW0gW21haWx0bzpsaW51eC1udmRpbW0tYm91bmNl
c0BsaXN0cy4wMS5vcmddIE9uIEJlaGFsZiBPZiBEYW4gV2lsbGlhbXMKPj4gU2VudDogTW9uZGF5
LCBBcHJpbCAxNSwgMjAxOSAxMToyOSBBTQo+PiBTdWJqZWN0OiBSZTogW1BBVENIIG5kY3RsXSBu
ZGN0bCwgcmVnaW9uOiByZXR1cm4gdGhlIHJjIHZhbHVlIGluIHJlZ2lvbl9hY3Rpb24KPj4KPj4g
T24gTW9uLCBBcHIgMTUsIDIwMTkgYXQgMToyNCBBTSBZaSBaaGFuZyA8eWkuemhhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4+PiBpZiByZWdpb25fYWN0aW9uIGZhaWxlZCwgcmV0dXJuIHRoZSByYyB2
YWx1ZGUgaW5zdGVhZCBvZiAwCj4gdmFsdWRlIHMvYiB2YWx1ZQoKU29ycnkgZm9yIHRoZSBsYXRl
IHJlc3BvbnNlLCBJIGp1c3QgZm91bmQgdGhpcyBwYXRjaMKgIHdhcyBtZXJnZWQ6CgpodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vdXRpbHMva2VybmVsL25kY3RsL25kY3RsLmdpdC9jb21t
aXQvP2lkPTk4NDA5NDJkNWY2ZGMwZDBlMzY5Mzk1NmY2NzMzYmJiYzRlMDZlM2EKCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBZaSBaaGFuZyA8eWkuemhhbmdAcmVkaGF0LmNvbT4KPj4+IC0tLQo+Pj4gICBu
ZGN0bC9yZWdpb24uYyB8IDIgKy0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL25kY3RsL3JlZ2lvbi5jIGIvbmRj
dGwvcmVnaW9uLmMKPj4+IGluZGV4IDk5M2IzZjguLjc5NDUwMDcgMTAwNjQ0Cj4+PiAtLS0gYS9u
ZGN0bC9yZWdpb24uYwo+Pj4gKysrIGIvbmRjdGwvcmVnaW9uLmMKPj4+IEBAIC04OSw3ICs4OSw3
IEBAIHN0YXRpYyBpbnQgcmVnaW9uX2FjdGlvbihzdHJ1Y3QgbmRjdGxfcmVnaW9uICpyZWdpb24s
IGVudW0gZGV2aWNlX2FjdGlvbiBtb2RlKQo+Pj4gICAgICAgICAgICAgICAgICBicmVhazsKPj4+
ICAgICAgICAgIH0KPj4+Cj4+PiAtICAgICAgIHJldHVybiAwOwo+Pj4gKyAgICAgICByZXR1cm4g
cmM7Cj4+PiAgIH0KPj4gTG9va3MgZ29vZCB0byBtZToKPj4KPj4gUmV2aWV3ZWQtYnk6IERhbiBX
aWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPgo+IFBlcmhhcHMgYSBzaW1pbGFyIGNo
YW5nZSBzaG91bGQgYmUgbWFkZSB0byBuZGN0bF9uYW1lc3BhY2VfZGlzYWJsZV9zYWZlKCksCj4g
b25lIG9mIHRoZSBmdW5jdGlvbnMgY2FsbGVkIGJ5IHJlZ2lvbl9hY3Rpb24oKSB3aG9zZSByYyBp
cyBwcm9wYWdhdGVkLCB0bwo+IHByb3BhZ2F0ZSB0aGUgcmMgZnJvbSBuZGN0bF9uYW1lc3BhY2Vf
ZGlzYWJsZV9pbnZhbGlkYXRlKCkuCgpJJ20gbm90IGZhbWlsaWFyIHdpdGggdGhlIG5kY3RsIGNv
ZGUsIGNvdWxkIHlvdSBoZWxwIHNlbmQgcGF0Y2ggdG8gZml4IAppdCBpZiB0aGUgY2hhbmdlIG5l
ZWRlZC4KCgpUaGFua3MKCllpCgo+Cj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdAo+IExpbnV4LW52
ZGltbUBsaXN0cy4wMS5vcmcKPiBodHRwczovL2xpc3RzLjAxLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52ZGltbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcK
aHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udmRpbW0K
