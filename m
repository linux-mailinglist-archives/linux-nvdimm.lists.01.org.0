Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA04B7E8B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Sep 2019 17:50:59 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 85DB4202EBECC;
	Thu, 19 Sep 2019 08:50:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2001:41d0:602:dbe::8; helo=tartarus.angband.pl;
 envelope-from=kilobyte@angband.pl; receiver=linux-nvdimm@lists.01.org 
Received: from tartarus.angband.pl (tartarus.angband.pl
 [IPv6:2001:41d0:602:dbe::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A6ECB202EA94D
 for <linux-nvdimm@lists.01.org>; Thu, 19 Sep 2019 08:50:01 -0700 (PDT)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
 (envelope-from <kilobyte@angband.pl>)
 id 1iAyhq-0006cK-KL; Thu, 19 Sep 2019 17:50:54 +0200
Date: Thu, 19 Sep 2019 17:50:54 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: hang in dax_pmem_compat_release on changing namespace mode
Message-ID: <20190919155054.GB24650@angband.pl>
References: <20190919115547.GA17963@angband.pl>
 <CAPcyv4jYE_vmEqe+m7spaXV4FDgHLJpE9cp3Ry2e8vU0JZEFCA@mail.gmail.com>
 <20190919154708.GA24650@angband.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190919154708.GA24650@angband.pl>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gVGh1LCBTZXAgMTksIDIwMTkgYXQgMDU6NDc6MDhQTSArMDIwMCwgQWRhbSBCb3Jvd3NraSB3
cm90ZToKPiBPbiBUaHUsIFNlcCAxOSwgMjAxOSBhdCAwODoxMDo0N0FNIC0wNzAwLCBEYW4gV2ls
bGlhbXMgd3JvdGU6Cj4gPiBPbiBUaHUsIFNlcCAxOSwgMjAxOSBhdCA0OjU2IEFNIEFkYW0gQm9y
b3dza2kgPGtpbG9ieXRlQGFuZ2JhbmQucGw+IHdyb3RlOgo+ID4gPiBJZiBJIHRyeSB0byBjaGFu
Z2UgdGhlIG1vZGUgb2YgYSBkZXZkYXggbmFtZXNwYWNlIHRoYXQncyBpbiB1c2UgKG1hcHBlZCBi
eQo+ID4gPiBzb21lIHByb2Nlc3MpLCBuZGN0bCBoYW5nczoKPiA+IAo+ID4gSXMgaXQgbWVyZWx5
IG1hcHBlZCwgb3IgbWlnaHQgdGhlIHBhZ2VzIGJlIGFjdGl2ZWx5IHBpbm5lZCAvIGluIHVzZSBi
eQo+ID4gYW5vdGhlciBwYXJ0IG9mIHRoZSBrZXJuZWw/IFRoZSBrZXJuZWwgaGFzIG5vIGNob2lj
ZSBidXQgdG8gd2FpdCBmb3IKPiA+IGFjdGl2ZSBwYWdlIHBpbnMgdG8gZHJhaW4uIENhbiB5b3Ug
Z2V0IGEgc3RhY2sgdHJhY2Ugb2YgdGhlIHByb2Nlc3MKPiA+IHdpdGggdGhlIGRldi1kYXggaW5z
dGFuY2UgbWFwcGVkPwo+IAo+IExvb2tzIGxpa2UgdGhlIGJlaGF2aW91ciBpcyBkaWZmZXJlbnQg
ZGVwZW5kaW5nIG9uIHdoYXQgdGhlIG90aGVyIHByb2Nlc3MKPiBpczoKPiAqIHdpdGggcWVtdSwg
dGhlIGhhbmcgaXMgMTAwJSByZXByb2R1Y2libGUsIHRoZSBndWVzdCBjb250aW51ZXMgdG8gd29y
ayBhbmQKPiAgIGNsZWFubHkgZXhpdHMgLS0gcWVtdSBkb2VzIG5vdCBleGl0IG9uIGl0cyBvd24g
KHVubGlrZSBub3JtYWwgY2FzZSkgYnV0Cj4gICBTSUdURVJNIHRlcm1pbmF0ZXMgaXQgY29ycmVj
dGx5LiAgVGh1cywgcWVtdSBpcyBub3Qgc3R1Y2ssIG9ubHkgbmRjdGwgaXMuCgpDb3JyZWN0aW9u
OiBub3QgMTAwJS4gIEkganVzdCBoYWQgcWVtdSBkaWUgd2l0aCBTSUdCVVMgaW5zdGVhZC4KCgpN
ZW93IQotLSAK4qKA4qO04qC+4qC74qK24qOm4qCAIEEgTUFQMDcgKERlYWQgU2ltcGxlKSByYXNw
YmVycnkgdGluY3R1cmUgcmVjaXBlOiAwLjVsIDk1JSBhbGNvaG9sLArio77ioIHioqDioJLioIDi
o7/ioYEgMWtnIHJhc3BiZXJyaWVzLCAwLjRrZyBzdWdhcjsgcHV0IGludG8gYSBiaWcgamFyIGZv
ciAxIG1vbnRoLgrior/ioYTioJjioLfioJrioIvioIAgRmlsdGVyIG91dCBhbmQgdGhyb3cgYXdh
eSB0aGUgZnJ1aXRzIChjYW4gZHVtcCB0aGVtIGludG8gYSBjYWtlLArioIjioLPio4TioIDioIDi
oIDioIAgZXRjKSwgbGV0IHRoZSBkcmluayBhZ2UgYXQgbGVhc3QgMy02IG1vbnRocy4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1h
aWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlzdHMuMDEub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
