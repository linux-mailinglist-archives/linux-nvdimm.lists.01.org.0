Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F6F8233A
	for <lists+linux-nvdimm@lfdr.de>; Mon,  5 Aug 2019 18:54:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8F4C82130A4FF;
	Mon,  5 Aug 2019 09:57:06 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EBE5121309D23
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 09:57:05 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DC7FD30832E9;
 Mon,  5 Aug 2019 16:54:34 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 835B260F8C;
 Mon,  5 Aug 2019 16:54:34 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v3 1/8] ndctl/build: Suppress
 -Waddress-of-packed-member
References: <156479006271.707590.298793474092813749.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156479006802.707590.7623788701230232646.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 05 Aug 2019 12:54:33 -0400
In-Reply-To: <156479006802.707590.7623788701230232646.stgit@dwillia2-desk3.amr.corp.intel.com>
 (Dan Williams's message of "Fri, 02 Aug 2019 16:54:28 -0700")
Message-ID: <x491rxzr1rq.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 05 Aug 2019 16:54:34 +0000 (UTC)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

RGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+IHdyaXRlczoKCj4gZ2NjIDku
MS4xIGVtaXRzIGEgc2xldyBvZiB3YXJuaW5ncyBmb3IgbWFueSBvZiB0aGUgY29tbWFuZCBmaWVs
ZAo+IGFjY2Vzc2VzLiBJLmUuIHdhcm5pbmdzIG9mIHRoZSBmb3JtOgo+Cj4gbGlibmRjdGwuYzoy
NTg2OjIxOiB3YXJuaW5nOiB0YWtpbmcgYWRkcmVzcyBvZiBwYWNrZWQgbWVtYmVyIG9mIOKAmHN0
cnVjdCBuZF9jbWRfZ2V0X2NvbmZpZ19kYXRhX2hkcuKAmSBtYXkgcmVzdWx0IGluIGFuIHVuYWxp
Z25lZCBwb2ludGVyIHZhbHVlIFstV2FkZHJlc3Mtb2YtcGFja2VkLW1lbWJlcl0KPiAgMjU4NiB8
ICBjbWQtPml0ZXIub2Zmc2V0ID0gJmNtZC0+Z2V0X2RhdGEtPmluX29mZnNldDsKPiAgICAgICB8
ICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+Cj4gU3VwcHJl
c3MgdGhlc2UgYXMgZml4aW5nIHRoZSB3YXJuaW5nIHdvdWxkIGRlZmVhdCB0aGUgYWJzdHJhY3Rp
b24gb2YgYmVpbmcgYWJsZQo+IHRvIGhhdmUgY29tbW9uIGNvZGUgdGhhdCBvcGVyYXRlcyBvbiBj
b21tYW5kcyB3aXRoIGNvbW1vbiBmaWVsZHMgYXQgZGlmZmVyZW50Cj4gb2Zmc2V0cyBpbiB0aGUg
cGF5bG9hZC4KCkFzIEkgdW5kZXJzdGFuZCBpdCwgdGFraW5nIGEgcG9pbnRlciB0byB0aGlzIHBv
dGVudGlhbGx5IHVuYWxpZ25lZAptZW1iZXIgY2FuIHJlc3VsdCBpbiBidXMgZXJyb3JzIChvciB3
b3JzZSwgYWNjZXNzaW5nIHdyb25nIGRhdGEpIG9uCmFyY2hpdGVjdHVyZXMgdGhhdCBkb24ndCBz
dXBwb3J0IHVuYWxpZ25lZCBhY2Nlc3Nlcy4gIEknZCBiZSBhIHdob2xlIGxvdApoYXBwaWVyIHdp
dGggdGhpcyBjaGFuZ2Vsb2cgaWYgaXQgbWVudGlvbmVkIHRoYXQgeW91IGhhZCBjb25zaWRlcmVk
IHdoYXQKdGhlIHdhcm5pbmcgYWN0dWFsbHkgbWVhbnQsIGFuZCBkZWNpZGVkIGl0IGRpZG4ndCBt
YXR0ZXIgZm9yIHRoZQphcmNoaXRlY3R1cmVzIHlvdSB3YW50IHRvIHN1cHBvcnQuCgp4ODYgaXMs
IG9mIGNvdXJzZSwgc2FmZS4gIEkgYmVsaWV2ZSBhYXJjaDY0IGlzLCBhcyB3ZWxsLiAgSSBkaWRu
J3QgbG9vawppbnRvIG90aGVycy4KCkNoZWVycywKSmVmZgoKCj4gU2lnbmVkLW9mZi1ieTogRGFu
IFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+Cj4gLS0tCj4gIGNvbmZpZ3VyZS5h
YyB8ICAgIDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1n
aXQgYS9jb25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMKPiBpbmRleCA0NzM3Y2ZmZjc3ZjIuLjc5
ZjgyOTc3ZmE0NCAxMDA2NDQKPiAtLS0gYS9jb25maWd1cmUuYWMKPiArKysgYi9jb25maWd1cmUu
YWMKPiBAQCAtMjE0LDYgKzIxNCw3IEBAIG15X0NGTEFHUz0iXAo+ICAtV21heWJlLXVuaW5pdGlh
bGl6ZWQgXAo+ICAtV2RlY2xhcmF0aW9uLWFmdGVyLXN0YXRlbWVudCBcCj4gIC1XdW51c2VkLXJl
c3VsdCBcCj4gKy1Xbm8tYWRkcmVzcy1vZi1wYWNrZWQtbWVtYmVyIFwKPiAgLURfRk9SVElGWV9T
T1VSQ0U9MiBcCj4gIC1PMgo+ICAiCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+IExpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QKPiBMaW51eC1udmRp
bW1AbGlzdHMuMDEub3JnCj4gaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udmRpbW0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0
dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
