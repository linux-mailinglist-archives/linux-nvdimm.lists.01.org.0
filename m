Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C7312E91
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 14:57:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 463672124B907;
	Fri,  3 May 2019 05:57:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2EB3121244A78
 for <linux-nvdimm@lists.01.org>; Fri,  3 May 2019 05:57:22 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id f37so5864781edb.13
 for <linux-nvdimm@lists.01.org>; Fri, 03 May 2019 05:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VaxPQ6IeVmYMFGePLBrY6yLBQaxZgQlHXQuFLzQ/+d4=;
 b=Q1s+yLF06i2mWw5XUZDrN3OrhZkHA8MeRl3UBfwzVL1qD0zqGe2QutTZhtxhQAoE9D
 xvQ5wXPYNODkqxiQUF3mOTp7pZE9B7BCM+r90yRx6rXkZ45fnVut3oNIknNMHV9McNkz
 gnPbaALBFQupBUtkVTqzWtVenkPE2fscTIKqyRkAgsETnrM+I6zEsxcVGWz+wqVSLltU
 /EYGqnwmMsMHGuJW2fhPE0vGgNHR0K9Q8kz4UKmPnoynnLJRvhF0Cch3nRtebAg2LxL7
 sWpRPHoR6w4Xyl/FMtZRKVQr4qwfszDvBPp+SUx3ktr5jhhURApDYJ2I0IcQGnJaUENr
 hK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VaxPQ6IeVmYMFGePLBrY6yLBQaxZgQlHXQuFLzQ/+d4=;
 b=K2z2YcX9hhM0/IbGmQ2s9y9ECTQkKKlFQjliB31Q4NQvZWCub3XbZUPQU6IdAHWjw5
 o2eVMNOj9UVwOKEkQotcKW8FQEHbx/bZgi7aeXnxJetqx6BGG6L2LOi/Rre+wfzwCijV
 UuoXyN0wdMFPZJ7GobbvgCI/n/18Hh0xHrn5S1M/KscyRJ1AgV3dPysySZiLmaMpmfLQ
 posAzXYYEw9DA7H5ZjbKBmFAOXyKaa2RpTdn9liBVtbvPoGdA9nPKyLKvEGubiCcgAxj
 0zQsWomgAJcLO8cb/N+p+8zqXAguNqA7LmajwNk89qg+mFVIn6oHNkDoqxO4vC+kRatv
 3zkg==
X-Gm-Message-State: APjAAAVHPIgu1Nf24kboIgvy1cAWkjvDVLdzWdf1xWOjYRhEbTEM/DSq
 n24tZTmw/IdNj2t/orOY2f2vuEXlSoz6asx96Q1oYw==
X-Google-Smtp-Source: APXvYqxGpxdtpUzePQzoj8+ABR2xl3yPHLROkt/fFrbcMScpdOGg5GoJBHZkg6V088MaY7vMf4/rxnhdCFk/G/55mD8=
X-Received: by 2002:a50:b56a:: with SMTP id z39mr8130377edd.91.1556888240692; 
 Fri, 03 May 2019 05:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634586.2015392.2662168839054356692.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+CK2bCkqLc82G2MW+rYrKTi4KafC+tLCASkaT8zRfVJCCe8HQ@mail.gmail.com>
 <CAPcyv4g+KNu=upejy7Xm=jWR0cdhygPAdSRbkfFGpJeHFGc4+w@mail.gmail.com>
 <bd76cb2f-7cdc-f11b-11ec-285862db66f3@arm.com>
In-Reply-To: <bd76cb2f-7cdc-f11b-11ec-285862db66f3@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 3 May 2019 08:57:09 -0400
Message-ID: <CA+CK2bBS5Csz0O9sDVwt_NjtrBtLaMfkycjhaOmR7mXoKJ5XEg@mail.gmail.com>
Subject: Re: [PATCH v6 02/12] mm/sparsemem: Introduce common definitions for
 the size and mask of a section
To: Robin Murphy <robin.murphy@arm.com>
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
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 David Hildenbrand <david@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gRnJpLCBNYXkgMywgMjAxOSBhdCA2OjM1IEFNIFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5
QGFybS5jb20+IHdyb3RlOgo+Cj4gT24gMDMvMDUvMjAxOSAwMTo0MSwgRGFuIFdpbGxpYW1zIHdy
b3RlOgo+ID4gT24gVGh1LCBNYXkgMiwgMjAxOSBhdCA3OjUzIEFNIFBhdmVsIFRhdGFzaGluIDxw
YXNoYS50YXRhc2hpbkBzb2xlZW4uY29tPiB3cm90ZToKPiA+Pgo+ID4+IE9uIFdlZCwgQXByIDE3
LCAyMDE5IGF0IDI6NTIgUE0gRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+
IHdyb3RlOgo+ID4+Pgo+ID4+PiBVcC1sZXZlbCB0aGUgbG9jYWwgc2VjdGlvbiBzaXplIGFuZCBt
YXNrIGZyb20ga2VybmVsL21lbXJlbWFwLmMgdG8KPiA+Pj4gZ2xvYmFsIGRlZmluaXRpb25zLiAg
VGhlc2Ugd2lsbCBiZSB1c2VkIGJ5IHRoZSBuZXcgc3ViLXNlY3Rpb24gaG90cGx1Zwo+ID4+PiBz
dXBwb3J0Lgo+ID4+Pgo+ID4+PiBDYzogTWljaGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+Cj4g
Pj4+IENjOiBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNlLmN6Pgo+ID4+PiBDYzogSsOpcsO0
bWUgR2xpc3NlIDxqZ2xpc3NlQHJlZGhhdC5jb20+Cj4gPj4+IENjOiBMb2dhbiBHdW50aG9ycGUg
PGxvZ2FuZ0BkZWx0YXRlZS5jb20+Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IERhbiBXaWxsaWFtcyA8
ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPgo+ID4+Cj4gPj4gU2hvdWxkIGJlIGRyb3BwZWQgZnJv
bSB0aGlzIHNlcmllcyBhcyBpdCBoYXMgYmVlbiByZXBsYWNlZCBieSBhIHZlcnkKPiA+PiBzaW1p
bGFyIHBhdGNoIGluIHRoZSBtYWlubGluZToKPiA+Pgo+ID4+IDdjNjk3ZDdmYjVjYjE0ZWY2MGUy
YjY4NzMzM2JhM2VmYjc0ZjczZGEKPiA+PiAgIG1tL21lbXJlbWFwOiBSZW5hbWUgYW5kIGNvbnNv
bGlkYXRlIFNFQ1RJT05fU0laRQo+ID4KPiA+IEkgc2F3IHRoYXQgcGF0Y2ggZmx5IGJ5IGFuZCBh
Y2tlZCBpdCwgYnV0IEkgaGF2ZSBub3Qgc2VlbiBpdCBwaWNrZWQgdXAKPiA+IGFueXdoZXJlLiBJ
IGdyYWJiZWQgbGF0ZXN0IC1saW51cyBhbmQgLW5leHQsIGJ1dCBkb24ndCBzZWUgdGhhdAo+ID4g
Y29tbWl0Lgo+ID4KPiA+ICQgZ2l0IHNob3cgN2M2OTdkN2ZiNWNiMTRlZjYwZTJiNjg3MzMzYmEz
ZWZiNzRmNzNkYQo+ID4gZmF0YWw6IGJhZCBvYmplY3QgN2M2OTdkN2ZiNWNiMTRlZjYwZTJiNjg3
MzMzYmEzZWZiNzRmNzNkYQo+Cj4gWWVhaCwgSSBkb24ndCByZWNvZ25pc2UgdGhhdCBJRCBlaXRo
ZXIsIG5vciBoYXZlIEkgaGFkIGFueSBub3RpZmljYXRpb25zCj4gdGhhdCBBbmRyZXcncyBwaWNr
ZWQgdXAgYW55dGhpbmcgb2YgbWluZSB5ZXQgOi8KClNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLiBJ
IHRob3VnaHQgSSBjaGVja2VkIGluIGEgbWFzdGVyIGJyYW5jaCwgYnV0CnR1cm5zIG91dCBJIGNo
ZWNrZWQgaW4gYSBicmFuY2ggd2hlcmUgSSBhcHBsaWVkIGFybSBob3RyZW1vdmUgcGF0Y2hlcwph
bmQgUm9iaW4ncyBwYXRjaCBhcyB3ZWxsLiBUaGVzZSB0d28gcGF0Y2hlcyBhcmUgZXNzZW50aWFs
bHkgdGhlIHNhbWUsCnNvIHdoaWNoIG9uZSBnb2VzIGZpcnN0IHRoZSBvdGhlciBzaG91bGQgYmUg
ZHJvcHBlZC4KClJldmlld2VkLWJ5OiBQYXZlbCBUYXRhc2hpbiA8cGFzaGEudGF0YXNoaW5Ac29s
ZWVuLmNvbT4KClRoYW5rIHlvdSwKUGFzaGEKCj4KPiBSb2Jpbi4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdApM
aW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZkaW1tCg==
