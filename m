Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E83391D06
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Aug 2019 08:27:31 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56C9420214B4C;
	Sun, 18 Aug 2019 23:28:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=yi.zhang@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CBEE920214B40
 for <linux-nvdimm@lists.01.org>; Sun, 18 Aug 2019 23:28:56 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E730E106E963;
 Mon, 19 Aug 2019 06:27:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-70.pek2.redhat.com [10.72.12.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F5F81C8;
 Mon, 19 Aug 2019 06:27:09 +0000 (UTC)
Subject: Re: create devdax with "-a 1g" failed from 5.3.0-rc1
To: Jeff Moyer <jmoyer@redhat.com>
References: <1254901996.3735926.1564533684889.JavaMail.zimbra@redhat.com>
 <x498srsdhrs.fsf@segfault.boston.devel.redhat.com>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <9d626432-5169-1ca4-330c-ad233ea73137@redhat.com>
Date: Mon, 19 Aug 2019 14:26:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <x498srsdhrs.fsf@segfault.boston.devel.redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 19 Aug 2019 06:27:26 +0000 (UTC)
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
Cc: linux-nvdimm@lists.01.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

VGhhbmtzIEplZmYKClRoaXMgcGF0Y2ggd29ya3Mgb24gbXkgc2lkZS4KCiMgbmRjdGwgY3JlYXRl
LW5hbWVzcGFjZSAtciByZWdpb24wIC1tIGRldmRheCAtYSAxZyAtcyAxMkcKewogwqAgImRldiI6
Im5hbWVzcGFjZTAuMyIsCiDCoCAibW9kZSI6ImRldmRheCIsCiDCoCAibWFwIjoiZGV2IiwKIMKg
ICJzaXplIjoiMTEuMDAgR2lCICgxMS44MSBHQikiLAogwqAgInV1aWQiOiI4NDY0NWEwYS1hZTIx
LTQ2MDgtODUxMi0xMjQ4Y2M0OGIwODUiLAogwqAgImRheHJlZ2lvbiI6ewogwqDCoMKgICJpZCI6
MCwKIMKgwqDCoCAic2l6ZSI6IjExLjAwIEdpQiAoMTEuODEgR0IpIiwKIMKgwqDCoCAiYWxpZ24i
OjEwNzM3NDE4MjQsCiDCoMKgwqAgImRldmljZXMiOlsKIMKgwqDCoMKgwqAgewogwqDCoMKgwqDC
oMKgwqAgImNoYXJkZXYiOiJkYXgwLjMiLAogwqDCoMKgwqDCoMKgwqAgInNpemUiOiIxMS4wMCBH
aUIgKDExLjgxIEdCKSIKIMKgwqDCoMKgwqAgfQogwqDCoMKgIF0KIMKgIH0sCiDCoCAiYWxpZ24i
OjEwNzM3NDE4MjQKfQoKT24gOC8xNy8xOSAzOjM2IEFNLCBKZWZmIE1veWVyIHdyb3RlOgo+IEhp
LCBZaSwKPgo+IFlpIFpoYW5nIDx5aS56aGFuZ0ByZWRoYXQuY29tPiB3cml0ZXM6Cj4KPj4gSGkg
RGFuCj4+Cj4+IEFzIHN1YmplY3QsIEkgZm91bmQgaXQgZmFpbGVkIGZyb20gYmVsbG93IGNvbW1p
dFsxXSwgc3RlcHMgbGlzdCBoZXJlCj4+IFsyXSBhbmQgSSd2ZSBhdHRhY2hlZCB0aGUgZnVsbCBk
bWVzZywgbGV0IG1lIGtub3cgaWYgeW91IG5lZWQgbW9yZQo+PiBpbmZvLCB0aGFua3MuCj4+Cj4+
IFsxXQo+PiBjb21taXQgYTM2MTkxOTBkNjJlZDlkNjY0MTY4OTFiZTI0MTZmNmJlYTJiM2NhNCAo
cmVmcy9iaXNlY3QvYmFkKQo+PiBBdXRob3I6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNA
aW50ZWwuY29tPgo+PiBEYXRlOiAgIFRodSBKdWwgMTggMTU6NTg6NDAgMjAxOSAtMDcwMAo+Pgo+
PiAgICAgIGxpYm52ZGltbS9wZm46IHN0b3AgcGFkZGluZyBwbWVtIG5hbWVzcGFjZXMgdG8gc2Vj
dGlvbiBhbGlnbm1lbnQKPj4KPj4gWzJdCj4+ICMgLi9uZGN0bCBkZXN0cm95LW5hbWVzcGFjZSBh
bGwgLXIgYWxsIC1mCj4+IGRlc3Ryb3llZCA1IG5hbWVzcGFjZXMKPj4gIyAuL25kY3RsIGNyZWF0
ZS1uYW1lc3BhY2UgLXIgcmVnaW9uMSAtbSBkZXZkYXggLWEgMWcgLXMgMTJHIC12dgo+PiBsaWJu
ZGN0bDogbmRjdGxfZGF4X2VuYWJsZTogZGF4MS4wOiBmYWlsZWQgdG8gZW5hYmxlCj4+ICAgIEVy
cm9yOiBuYW1lc3BhY2UxLjA6IGZhaWxlZCB0byBlbmFibGUKPj4KPj4gZmFpbGVkIHRvIGNyZWF0
ZSBuYW1lc3BhY2U6IE5vIHN1Y2ggZGV2aWNlIG9yIGFkZHJlc3MKPj4gIyAuL25kY3RsIC12Cj4+
IDY1Cj4gVGhhbmtzIGZvciBiaXNlY3RpbmcuICBUaGUgcHJvYmxlbSBpcyB0aGF0IHlvdXIgcG1l
bSByZWdpb24gaXMgbm90Cj4gYWxpZ25lZCB0byAxR0IuICBUaGUgY3VycmVudCBjb2RlIGhhbmRs
ZXMgdGhlIHN0YXJ0IG9mZnNldCBqdXN0IGZpbmUsCj4gYnV0IGRvZXMgbm90IGV2ZW4gY29uc2lk
ZXIgdGhhdCB0aGUgZW5kIGFkZHJlc3MgbWlnaHQgYmUgbWlzYWxpZ25lZC4gIFdlCj4gY291bGQg
YnJpbmcgYmFjayBlbmRfdHJ1bmMsIGFuZCB0aGF0IHNvbHZlcyB0aGUgcHJvYmxlbS4gIFVuZm9y
dHVuYXRlbHksCj4gaXQgbWVhbnMgdGhhdCBpZiB5b3UgcmVxdWVzdCBhIDEyR0IgbmFtZXNwYWNl
LCBmb3IgZXhhbXBsZSwgeW91J2xsIG9ubHkKPiBnZXQgMTFHQiBvZiB1c2FibGUgc3BhY2UuICBO
b3RlIHRoYXQgdGhlIG9sZCBjb2RlIGZ1bmN0aW9uZWQgaW4gdGhpcwo+IG1hbm5lciwgdG9vLiAg
QSBiZXR0ZXIgc29sdXRpb24gd291bGQgYmUgdG8gYnVtcCB0aGUgYWxsb2NhdGlvbiBzbyB0aGF0
Cj4geW91IGdldCAxMkdCIG9mIHVzYWJsZSBtZW1vcnkuICBJJ20gbm90IHF1aXRlIHN1cmUgaG93
IHRvIGdvIGFib3V0IHRoYXQsCj4gdGhvdWdoLiAgRGFuPwo+Cj4gQmVsb3cgaXMgYSBwYXRjaCB0
aGF0IGZpeGVzIHRoZSByZWdyZXNzaW9uIG9uIG15IGVuZC4gIEZlZWwgZnJlZSB0byBnaXZlCj4g
aXQgYSB0cnkuCj4KPiAtSmVmZgo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL3Bmbl9k
ZXZzLmMgYi9kcml2ZXJzL252ZGltbS9wZm5fZGV2cy5jCj4gaW5kZXggM2U3YjExYy4uY2I5OGI4
ZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252ZGltbS9wZm5fZGV2cy5jCj4gKysrIGIvZHJpdmVy
cy9udmRpbW0vcGZuX2RldnMuYwo+IEBAIC02NTUsNiArNjU1LDcgQEAgc3RhdGljIGludCBuZF9w
Zm5faW5pdChzdHJ1Y3QgbmRfcGZuICpuZF9wZm4pCj4gICAJcmVzb3VyY2Vfc2l6ZV90IHN0YXJ0
LCBzaXplOwo+ICAgCXN0cnVjdCBuZF9yZWdpb24gKm5kX3JlZ2lvbjsKPiAgIAl1bnNpZ25lZCBs
b25nIG5wZm5zLCBhbGlnbjsKPiArCXUzMiBlbmRfdHJ1bmM7Cj4gICAJc3RydWN0IG5kX3Bmbl9z
YiAqcGZuX3NiOwo+ICAgCXBoeXNfYWRkcl90IG9mZnNldDsKPiAgIAljb25zdCBjaGFyICpzaWc7
Cj4gQEAgLTY5Niw2ICs2OTcsNyBAQCBzdGF0aWMgaW50IG5kX3Bmbl9pbml0KHN0cnVjdCBuZF9w
Zm4gKm5kX3BmbikKPiAgIAlzaXplID0gcmVzb3VyY2Vfc2l6ZSgmbnNpby0+cmVzKTsKPiAgIAlu
cGZucyA9IFBIWVNfUEZOKHNpemUgLSBTWl84Syk7Cj4gICAJYWxpZ24gPSBtYXgobmRfcGZuLT5h
bGlnbiwgKDFVTCA8PCBTVUJTRUNUSU9OX1NISUZUKSk7Cj4gKwllbmRfdHJ1bmMgPSBzdGFydCAr
IHNpemUgLSBBTElHTl9ET1dOKHN0YXJ0ICsgc2l6ZSwgYWxpZ24pOwo+ICAgCWlmIChuZF9wZm4t
Pm1vZGUgPT0gUEZOX01PREVfUE1FTSkgewo+ICAgCQkvKgo+ICAgCQkgKiBUaGUgYWx0bWFwIHNo
b3VsZCBiZSBwYWRkZWQgb3V0IHRvIHRoZSBibG9jayBzaXplIHVzZWQKPiBAQCAtNzE0LDcgKzcx
Niw3IEBAIHN0YXRpYyBpbnQgbmRfcGZuX2luaXQoc3RydWN0IG5kX3BmbiAqbmRfcGZuKQo+ICAg
CQlyZXR1cm4gLUVOWElPOwo+ICAgCX0KPiAgIAo+IC0JbnBmbnMgPSBQSFlTX1BGTihzaXplIC0g
b2Zmc2V0KTsKPiArCW5wZm5zID0gUEhZU19QRk4oc2l6ZSAtIG9mZnNldCAtIGVuZF90cnVuYyk7
Cj4gICAJcGZuX3NiLT5tb2RlID0gY3B1X3RvX2xlMzIobmRfcGZuLT5tb2RlKTsKPiAgIAlwZm5f
c2ItPmRhdGFvZmYgPSBjcHVfdG9fbGU2NChvZmZzZXQpOwo+ICAgCXBmbl9zYi0+bnBmbnMgPSBj
cHVfdG9fbGU2NChucGZucyk7Cj4gQEAgLTcyMyw2ICs3MjUsNyBAQCBzdGF0aWMgaW50IG5kX3Bm
bl9pbml0KHN0cnVjdCBuZF9wZm4gKm5kX3BmbikKPiAgIAltZW1jcHkocGZuX3NiLT5wYXJlbnRf
dXVpZCwgbmRfZGV2X3RvX3V1aWQoJm5kbnMtPmRldiksIDE2KTsKPiAgIAlwZm5fc2ItPnZlcnNp
b25fbWFqb3IgPSBjcHVfdG9fbGUxNigxKTsKPiAgIAlwZm5fc2ItPnZlcnNpb25fbWlub3IgPSBj
cHVfdG9fbGUxNigzKTsKPiArCXBmbl9zYi0+ZW5kX3RydW5jID0gY3B1X3RvX2xlMzIoZW5kX3Ry
dW5jKTsKPiAgIAlwZm5fc2ItPmFsaWduID0gY3B1X3RvX2xlMzIobmRfcGZuLT5hbGlnbik7Cj4g
ICAJY2hlY2tzdW0gPSBuZF9zYl9jaGVja3N1bSgoc3RydWN0IG5kX2dlbl9zYiAqKSBwZm5fc2Ip
Owo+ICAgCXBmbl9zYi0+Y2hlY2tzdW0gPSBjcHVfdG9fbGU2NChjaGVja3N1bSk7Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWls
aW5nIGxpc3QKTGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpodHRwczovL2xpc3RzLjAxLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52ZGltbQo=
