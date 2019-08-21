Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 970A89829A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Aug 2019 20:19:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 70D7720213F14;
	Wed, 21 Aug 2019 11:20:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9CBDE20212CBC
 for <linux-nvdimm@lists.01.org>; Wed, 21 Aug 2019 11:20:55 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6D97AAEFC;
 Wed, 21 Aug 2019 18:19:44 +0000 (UTC)
Date: Wed, 21 Aug 2019 20:19:43 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [ndctl PATCH v2 14/26] ndctl/namespace: Handle
 'create-namespace' in label-less mode
Message-ID: <20190821201943.5d24eb9e@kitsune.suse.cz>
In-Reply-To: <c92890eae097e27edb65afd4fc969f032fb9a18d.camel@intel.com>
References: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156426363655.531577.4504452379578995249.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190821145605.206372a0@kitsune.suse.cz>
 <c92890eae097e27edb65afd4fc969f032fb9a18d.camel@intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gV2VkLCAyMSBBdWcgMjAxOSAxODowMzoxOCArMDAwMAoiVmVybWEsIFZpc2hhbCBMIiA8dmlz
aGFsLmwudmVybWFAaW50ZWwuY29tPiB3cm90ZToKCj4gT24gV2VkLCAyMDE5LTA4LTIxIGF0IDE0
OjU2ICswMjAwLCBNaWNoYWwgU3VjaMOhbmVrIHdyb3RlOgo+ID4gSGVsbG8sCj4gPiAKPiA+IHRo
aXMgcGF0Y2ggaXMgbWFya2VkIGFzIHN1cGVyc2VkZWQgaW4gdGhlIHBhdGNod29yay4KPiA+IAo+
ID4gV2hhdCBpcyB0aGUgaW50ZW5kZWQgcmVwbGFjZW1lbnQ/Cj4gPiAgIAo+IAo+IEhpIE1pY2hh
bCwKPiAKPiBUaGUgcGF0Y2ggd2FzIHN1cGVyc2VkZWQgYnkgdjMgb2YgdGhlIHNlcmllcywgYW5k
IGlzIHByZXNlbnQgaW4gdGhlCj4gbGF0ZXN0IHJlbGVhc2UgKHY2Nik6Cj4gCj4gNzk2NmM5MiBu
ZGN0bC9uYW1lc3BhY2U6IEhhbmRsZSAnY3JlYXRlLW5hbWVzcGFjZScgaW4gbGFiZWwtbGVzcyBt
b2RlCj4gCj4gCS1WaXNoYWwKCkkgc2VlLCBpdCB3YXMgYWxyZWFkeSBtZXJnZWQgYXMgcGFydCBv
ZiB1cGRhdGVkIHNlcmllcy4gTWlzc2VkIHRoYXQuCgpUaGFua3MKCk1pY2hhbApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGlu
ZyBsaXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udmRpbW0K
