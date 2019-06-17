Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0CE490A2
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 21:55:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B5D752129605C;
	Mon, 17 Jun 2019 12:55:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=213.95.11.211;
 helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 77D6A21250448
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 12:55:55 -0700 (PDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 82B6768B02; Mon, 17 Jun 2019 21:55:26 +0200 (CEST)
Date: Mon, 17 Jun 2019 21:55:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 08/25] memremap: move dev_pagemap callbacks into a
 separate structure
Message-ID: <20190617195526.GB20275@lst.de>
References: <20190617122733.22432-1-hch@lst.de>
 <20190617122733.22432-9-hch@lst.de>
 <CAPcyv4i_0wUJHDqY91R=x5M2o_De+_QKZxPyob5=E9CCv8rM7A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4i_0wUJHDqY91R=x5M2o_De+_QKZxPyob5=E9CCv8rM7A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, nouveau@lists.freedesktop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gTW9uLCBKdW4gMTcsIDIwMTkgYXQgMTA6NTE6MzVBTSAtMDcwMCwgRGFuIFdpbGxpYW1zIHdy
b3RlOgo+ID4gLSAgICAgICBzdHJ1Y3QgZGV2X3BhZ2VtYXAgKnBnbWFwID0gX3BnbWFwOwo+IAo+
IFdob29wcywgbmVlZGVkIHRvIGtlZXAgdGhpcyBsaW5lIHRvIGF2b2lkOgo+IAo+IHRvb2xzL3Rl
c3RpbmcvbnZkaW1tL3Rlc3QvaW9tYXAuYzoxMDk6MTE6IGVycm9yOiDigJhwZ21hcOKAmSB1bmRl
Y2xhcmVkCj4gKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuIOKAmF9w
Z21hcOKAmT8KClNvIEkgcmVhbGx5IHNob3VsZG4ndCBiZSB0cmlwcGluZyBvdmVyIHRoaXMgYW55
bW9yZSwgYnV0IGNhbiB3ZSBzb21laG93CnRoaXMgbWVzcz8KCiAtIGF0IGxlYXN0IGFkZCBpdCB0
byB0aGUgbm9ybWFsIGJ1aWxkIHN5c3RlbSBhbmQga2NvbmZpZyBkZXBzIGluc3RlYWQKICAgb2Yg
c3Rhc2hpbmcgaXQgYXdheSBzbyB0aGF0IHRoaW5ncyBsaWtlIGJ1aWxkYm90IGNhbiBidWlsZCBp
dD8KIC0gYXQgbGVhc3QgYWxsb3cgYnVpbGRpbmcgaXQgKHVuZGVyIENPTVBJTEVfVEVTVCkgaWYg
bmVlZGVkIGV2ZW4gd2hlbgogICBwbWVtLmtvIGFuZCBmcmllbmRzIGFyZSBidWlsdCBpbiB0aGUg
a2VybmVsPwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6
Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udmRpbW0K
