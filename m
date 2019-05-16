Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9539D1FF84
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 08:28:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 955B3212657BD;
	Wed, 15 May 2019 23:28:26 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C5A5F21250C96
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 23:28:23 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 21F1B3DDBE;
 Thu, 16 May 2019 06:28:23 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F29145D9C3;
 Thu, 16 May 2019 06:28:22 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 973501806B11;
 Thu, 16 May 2019 06:28:21 +0000 (UTC)
Date: Thu, 16 May 2019 02:28:20 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Message-ID: <1906905099.29162562.1557988100975.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4gEr_zPJEQp3k89v2UXfHp9PQwnJXY+W99HwXfxpvua_w@mail.gmail.com>
References: <20190514145422.16923-1-pagupta@redhat.com>
 <20190514145422.16923-2-pagupta@redhat.com>
 <CAPcyv4gEr_zPJEQp3k89v2UXfHp9PQwnJXY+W99HwXfxpvua_w@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] libnvdimm: nd_region flush callback support
MIME-Version: 1.0
X-Originating-IP: [10.65.16.97, 10.4.195.4]
Thread-Topic: libnvdimm: nd_region flush callback support
Thread-Index: VrjlK3y+QUdLL94hHE7OyUkrop5Ojw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 16 May 2019 06:28:23 +0000 (UTC)
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
Cc: cohuck@redhat.com, Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 david <david@fromorbit.com>, Qemu Developers <qemu-devel@nongnu.org>,
 virtualization@lists.linux-foundation.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, jstaron@google.com,
 linux-nvdimm <linux-nvdimm@lists.01.org>, David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 Adam Borowski <kilobyte@angband.pl>, Rik van Riel <riel@surriel.com>,
 yuval shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>,
 Theodore Ts'o <tytso@mit.edu>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Darrick J. Wong" <darrick.wong@oracle.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Cj4gPgo+ID4gVGhpcyBwYXRjaCBhZGRzIGZ1bmN0aW9uYWxpdHkgdG8gcGVyZm9ybSBmbHVzaCBm
cm9tIGd1ZXN0Cj4gPiB0byBob3N0IG92ZXIgVklSVElPLiBXZSBhcmUgcmVnaXN0ZXJpbmcgYSBj
YWxsYmFjayBiYXNlZAo+ID4gb24gJ25kX3JlZ2lvbicgdHlwZS4gdmlydGlvX3BtZW0gZHJpdmVy
IHJlcXVpcmVzIHRoaXMgc3BlY2lhbAo+ID4gZmx1c2ggZnVuY3Rpb24uIEZvciByZXN0IG9mIHRo
ZSByZWdpb24gdHlwZXMgd2UgYXJlIHJlZ2lzdGVyaW5nCj4gPiBleGlzdGluZyBmbHVzaCBmdW5j
dGlvbi4gUmVwb3J0IGVycm9yIHJldHVybmVkIGJ5IGhvc3QgZnN5bmMKPiA+IGZhaWx1cmUgdG8g
dXNlcnNwYWNlLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFBhbmthaiBHdXB0YSA8cGFndXB0YUBy
ZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9hY3BpL25maXQvY29yZS5jICAgICB8ICA0
ICsrLS0KPiA+ICBkcml2ZXJzL252ZGltbS9jbGFpbS5jICAgICAgIHwgIDYgKysrKy0tCj4gPiAg
ZHJpdmVycy9udmRpbW0vbmQuaCAgICAgICAgICB8ICAxICsKPiA+ICBkcml2ZXJzL252ZGltbS9w
bWVtLmMgICAgICAgIHwgMTMgKysrKysrKystLS0tLQo+ID4gIGRyaXZlcnMvbnZkaW1tL3JlZ2lv
bl9kZXZzLmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKystLQo+ID4gIGluY2x1ZGUvbGlu
dXgvbGlibnZkaW1tLmggICAgfCAgOCArKysrKysrLQo+ID4gIDYgZmlsZXMgY2hhbmdlZCwgNDYg
aW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYWNwaS9uZml0L2NvcmUuYyBiL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUuYwo+ID4gaW5kZXgg
NWEzODlhNGY0ZjY1Li4wOGRkZTc2Y2Y0NTkgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkv
bmZpdC9jb3JlLmMKPiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUuYwo+ID4gQEAgLTI0
MzQsNyArMjQzNCw3IEBAIHN0YXRpYyB2b2lkIHdyaXRlX2Jsa19jdGwoc3RydWN0IG5maXRfYmxr
ICpuZml0X2JsaywKPiA+IHVuc2lnbmVkIGludCBidywKPiA+ICAgICAgICAgICAgICAgICBvZmZz
ZXQgPSB0b19pbnRlcmxlYXZlX29mZnNldChvZmZzZXQsIG1taW8pOwo+ID4KPiA+ICAgICAgICAg
d3JpdGVxKGNtZCwgbW1pby0+YWRkci5iYXNlICsgb2Zmc2V0KTsKPiA+IC0gICAgICAgbnZkaW1t
X2ZsdXNoKG5maXRfYmxrLT5uZF9yZWdpb24pOwo+ID4gKyAgICAgICBudmRpbW1fZmx1c2gobmZp
dF9ibGstPm5kX3JlZ2lvbiwgTlVMTCk7Cj4gPgo+ID4gICAgICAgICBpZiAobmZpdF9ibGstPmRp
bW1fZmxhZ3MgJiBORklUX0JMS19EQ1JfTEFUQ0gpCj4gPiAgICAgICAgICAgICAgICAgcmVhZHEo
bW1pby0+YWRkci5iYXNlICsgb2Zmc2V0KTsKPiA+IEBAIC0yNDgzLDcgKzI0ODMsNyBAQCBzdGF0
aWMgaW50IGFjcGlfbmZpdF9ibGtfc2luZ2xlX2lvKHN0cnVjdCBuZml0X2Jsawo+ID4gKm5maXRf
YmxrLAo+ID4gICAgICAgICB9Cj4gPgo+ID4gICAgICAgICBpZiAocncpCj4gPiAtICAgICAgICAg
ICAgICAgbnZkaW1tX2ZsdXNoKG5maXRfYmxrLT5uZF9yZWdpb24pOwo+ID4gKyAgICAgICAgICAg
ICAgIG52ZGltbV9mbHVzaChuZml0X2Jsay0+bmRfcmVnaW9uLCBOVUxMKTsKPiA+Cj4gPiAgICAg
ICAgIHJjID0gcmVhZF9ibGtfc3RhdChuZml0X2JsaywgbGFuZSkgPyAtRUlPIDogMDsKPiA+ICAg
ICAgICAgcmV0dXJuIHJjOwo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL2NsYWltLmMg
Yi9kcml2ZXJzL252ZGltbS9jbGFpbS5jCj4gPiBpbmRleCBmYjY2N2JmNDY5YzcuLjEzNTEwYmFl
MWU2ZiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbnZkaW1tL2NsYWltLmMKPiA+ICsrKyBiL2Ry
aXZlcnMvbnZkaW1tL2NsYWltLmMKPiA+IEBAIC0yNjMsNyArMjYzLDcgQEAgc3RhdGljIGludCBu
c2lvX3J3X2J5dGVzKHN0cnVjdCBuZF9uYW1lc3BhY2VfY29tbW9uCj4gPiAqbmRucywKPiA+ICAg
ICAgICAgc3RydWN0IG5kX25hbWVzcGFjZV9pbyAqbnNpbyA9IHRvX25kX25hbWVzcGFjZV9pbygm
bmRucy0+ZGV2KTsKPiA+ICAgICAgICAgdW5zaWduZWQgaW50IHN6X2FsaWduID0gQUxJR04oc2l6
ZSArIChvZmZzZXQgJiAoNTEyIC0gMSkpLCA1MTIpOwo+ID4gICAgICAgICBzZWN0b3JfdCBzZWN0
b3IgPSBvZmZzZXQgPj4gOTsKPiA+IC0gICAgICAgaW50IHJjID0gMDsKPiA+ICsgICAgICAgaW50
IHJjID0gMCwgcmV0ID0gMDsKPiA+Cj4gPiAgICAgICAgIGlmICh1bmxpa2VseSghc2l6ZSkpCj4g
PiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gPiBAQCAtMzAxLDcgKzMwMSw5IEBAIHN0YXRp
YyBpbnQgbnNpb19yd19ieXRlcyhzdHJ1Y3QgbmRfbmFtZXNwYWNlX2NvbW1vbgo+ID4gKm5kbnMs
Cj4gPiAgICAgICAgIH0KPiA+Cj4gPiAgICAgICAgIG1lbWNweV9mbHVzaGNhY2hlKG5zaW8tPmFk
ZHIgKyBvZmZzZXQsIGJ1Ziwgc2l6ZSk7Cj4gPiAtICAgICAgIG52ZGltbV9mbHVzaCh0b19uZF9y
ZWdpb24obmRucy0+ZGV2LnBhcmVudCkpOwo+ID4gKyAgICAgICByZXQgPSBudmRpbW1fZmx1c2go
dG9fbmRfcmVnaW9uKG5kbnMtPmRldi5wYXJlbnQpLCBOVUxMKTsKPiA+ICsgICAgICAgaWYgKHJl
dCkKPiA+ICsgICAgICAgICAgICAgICByYyA9IHJldDsKPiA+Cj4gPiAgICAgICAgIHJldHVybiBy
YzsKPiA+ICB9Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udmRpbW0vbmQuaCBiL2RyaXZlcnMv
bnZkaW1tL25kLmgKPiA+IGluZGV4IGE1YWMzYjI0MDI5My4uMGM3NGQyNDI4YmQ3IDEwMDY0NAo+
ID4gLS0tIGEvZHJpdmVycy9udmRpbW0vbmQuaAo+ID4gKysrIGIvZHJpdmVycy9udmRpbW0vbmQu
aAo+ID4gQEAgLTE1OSw2ICsxNTksNyBAQCBzdHJ1Y3QgbmRfcmVnaW9uIHsKPiA+ICAgICAgICAg
c3RydWN0IGJhZGJsb2NrcyBiYjsKPiA+ICAgICAgICAgc3RydWN0IG5kX2ludGVybGVhdmVfc2V0
ICpuZF9zZXQ7Cj4gPiAgICAgICAgIHN0cnVjdCBuZF9wZXJjcHVfbGFuZSBfX3BlcmNwdSAqbGFu
ZTsKPiA+ICsgICAgICAgaW50ICgqZmx1c2gpKHN0cnVjdCBuZF9yZWdpb24gKm5kX3JlZ2lvbiwg
c3RydWN0IGJpbyAqYmlvKTsKPiAKPiBTbyB0aGlzIHRyaWdnZXJzOgo+IAo+IEluIGZpbGUgaW5j
bHVkZWQgZnJvbSBkcml2ZXJzL252ZGltbS9lODIwLmM6NzoKPiAuL2luY2x1ZGUvbGludXgvbGli
bnZkaW1tLmg6MTQwOjUxOiB3YXJuaW5nOiDigJhzdHJ1Y3QgYmlv4oCZIGRlY2xhcmVkCj4gaW5z
aWRlIHBhcmFtZXRlciBsaXN0IHdpbGwgbm90IGJlIHZpc2libGUgb3V0c2lkZSBvZiB0aGlzIGRl
ZmluaXRpb24KPiBvciBkZWNsYXJhdGlvbgo+ICAgaW50ICgqZmx1c2gpKHN0cnVjdCBuZF9yZWdp
b24gKm5kX3JlZ2lvbiwgc3RydWN0IGJpbyAqYmlvKTsKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn4KClNvcnJ5ISBmb3IgdGhpcy4gRml4ZWQg
bm93LgoKPiBJIHdhcyBhbHJlYWR5IGZlZWxpbmcgdW5lYXN5IGFib3V0IHRyeWluZyB0byBzcXVl
ZXplIHRoaXMgaW50byB2NS4yLAo+IGJ1dCB0aGlzIHdhcm5pbmcgYW5kIHRoZSBjb250aW51ZWQg
ZHJpcCBvZiBjb21tZW50cyBsZWFkcyBtZSB0bwo+IGNvbmNsdWRlIHRoYXQgdGhpcyBkcml2ZXIg
d291bGQgZG8gd2VsbCB0byB3YWl0IG9uZSBtb3JlIGRldmVsb3BtZW50Cj4gY3ljbGUuIExldHMg
Y2xvc2Ugb3V0IHRoZSBmaW5hbCBmaXh1cHMgYW5kIGxldCB0aGlzIGRyaXZlciBzb2FrIGluCj4g
LW5leHQuIFRoZW4gZm9yIHRoZSB2NS4zIGN5Y2xlIEknbGwgcmVkb3VibGUgbXkgZWZmb3J0cyB0
b3dhcmRzIHRoZQo+IGdvYWwgb2YgY2xvc2luZyBwYXRjaCBhY2NlcHRhbmNlIGF0IHRoZSAtcmM2
IC8gLXJjNyBkZXZlbG9wbWVudAo+IG1pbGVzdG9uZS4KCm8uay4gV2lsbCB3YWl0IGZvciBNaWtl
J3MgQUNLIG9uIGRldmljZSBtYXBwZXIgcGF0Y2ggYW5kIHNlbmQgdGhlIHYxMAp3aXRoIGZpbmFs
IGZpeC11cHMuIFRoYW5rIHlvdSBmb3IgeW91ciBoZWxwLgoKQmVzdCByZWdhcmRzLApQYW5rYWoK
CgoKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZkaW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8v
bGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
