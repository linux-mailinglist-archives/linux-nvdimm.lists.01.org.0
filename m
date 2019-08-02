Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EB380040
	for <lists+linux-nvdimm@lfdr.de>; Fri,  2 Aug 2019 20:36:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 157AD2130C4BB;
	Fri,  2 Aug 2019 11:39:26 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2001:41d0:602:dbe::8; helo=tartarus.angband.pl;
 envelope-from=kilobyte@angband.pl; receiver=linux-nvdimm@lists.01.org 
Received: from tartarus.angband.pl (tartarus.angband.pl
 [IPv6:2001:41d0:602:dbe::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0D3682130A50A
 for <linux-nvdimm@lists.01.org>; Fri,  2 Aug 2019 11:39:24 -0700 (PDT)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
 (envelope-from <kilobyte@angband.pl>)
 id 1htcQ7-00051b-4X; Fri, 02 Aug 2019 20:36:51 +0200
Date: Fri, 2 Aug 2019 20:36:51 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, 914348@bugs.debian.org
Subject: Re: [PATCH] daxctl: link against libndctl, in case its use doesn't
 get pruned
Message-ID: <20190802183651.GA3797@angband.pl>
References: <20190801010044.56927-1-kilobyte@angband.pl>
 <47f7555596eae0f7daef0d6a0a9ce0bae96f6af4.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47f7555596eae0f7daef0d6a0a9ce0bae96f6af4.camel@intel.com>
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gRnJpLCBBdWcgMDIsIDIwMTkgYXQgMDU6MTU6MjFQTSArMDAwMCwgVmVybWEsIFZpc2hhbCBM
IHdyb3RlOgo+IE9uIFRodSwgMjAxOS0wOC0wMSBhdCAwMzowMCArMDIwMCwgQWRhbSBCb3Jvd3Nr
aSB3cm90ZToKPiA+IHV0aWwvanNvbi5jIHVzZXMgbGlibmRjdGwgc3ltYm9scywgYW5kIGlzIGlu
Y2x1ZGVkIGJ5IGRheGN0bC4gIFRoZXNlCj4gPiBmdW5jdGlvbnMgc2hvdWxkIHRoZW4gZ2V0IHBy
dW5lZCBhcyB1bnVzZWQsIGJ1dCBvbiBzb21lIHBsYXRmb3JtcyB0aGUKPiA+IHRvb2xjaGFpbiBm
YWlscyB0byBkbyBzby4KCj4gPiB0aGlzIGhhcyBiZWVuIHJlcXVlc3RlZCBpbiBodHRwczovL2J1
Z3MuZGViaWFuLm9yZy85MTQzNDgKCj4gVGhhbmtzIGZvciB0aGUgcmVwb3J0IGFuZCB0aGUgcGF0
Y2ggLSBob3dldmVyLCBoaXN0b3JpY2FsbHksIHdlJ3ZlCj4gYXZvaWRlZCBsaW5raW5nIGZyb20g
ZGF4Y3RsIHRvIGxpYm5kY3RsLgo+IAo+IEkgdGhpbmsgd2UgY2FuIHN0aWxsIGF2b2lkIHRoaXMg
YnkgbW92aW5nIHRoZSBsaWJuZGN0bCB1c2VycyBpbgo+IHV0aWwvanNvbi5jIGFuZCB1dGlsL2Zp
bHRlci5jIGludG8gcmVzcGVjdGl2ZSBuZGN0bC91dGlsLyBmaWxlcy4KPiAKPiBUaGUgc2FtZSBn
b2VzIGZvciBsaWJkYXhjdGwgdXNlcnMgaW4gdGhvc2UgZmlsZXMgLSB0aGV5IG1vdmUgaW50bwo+
IGRheGN0bC91dGlsLwo+IAo+IEkgdGhpbmsgdGhhdCB3b3VsZCBiZSBhIGNsZWFuZXIgYXBwcm9h
Y2gsIGFuZCBJIGNhbiB0YWtlIGEgc2hvdCBhdAo+IG1ha2luZyB0aGUgc3BsaXQgbmV4dCB3ZWVr
LCBob3dldmVyIHdlJ3JlIGNsb3NlIHRvIGEgdjY2IHJlbGVhc2UsIGFuZCBpdAo+IHdpbGwgaGF2
ZSB0byBiZSBhZnRlciB0aGF0IGhhcHBlbnMuCj4gCj4gUGVyaGFwcyB0aGUgZGViaWFuIHBhY2th
Z2UgY2FuIHRlbXBvcmFyaWx5IGNhcnJ5IHlvdXIgcGF0Y2ggZm9yIHRoZQo+IGFyY2hzIHRoYXQg
ZmFpbD8KClNvdW5kcyBsaWtlIGEgcGxhbi4KCkNDaW5nIHRoZSBidWcuICBCcmVubzogY291bGQg
eW91IHBsZWFzZSB0YWtlIHRoaXMgcGF0Y2ggZm9yIHY2NSBvciB2NjYsCnVudGlsIGl0IGdldHMg
ZG9uZSBhIGJldHRlciAoYnV0IG1vcmUgaW50cnVzaXZlKSB3YXk/CgoK5Za1IQotLSAK4qKA4qO0
4qC+4qC74qK24qOm4qCAIExhdGluOiAgIG1lb3cgNCBjaGFyYWN0ZXJzLCA0IGNvbHVtbnMsICA0
IGJ5dGVzCuKjvuKggeKioOKgkuKggOKjv+KhgSBHcmVlazogICDOvM61zr/PhSA0IGNoYXJhY3Rl
cnMsIDQgY29sdW1ucywgIDggYnl0ZXMK4qK/4qGE4qCY4qC34qCa4qCLICBSdW5lczogICDhm5fh
m5bhm5/hmrkgNCBjaGFyYWN0ZXJzLCA0IGNvbHVtbnMsIDEyIGJ5dGVzCuKgiOKgs+KjhOKggOKg
gOKggOKggCBDaGluZXNlOiDllrUgICAxIGNoYXJhY3RlciwgIDIgY29sdW1ucywgIDMgYnl0ZXMg
PC0tIGJlc3QhCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QKTGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpodHRw
czovL2xpc3RzLjAxLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52ZGltbQo=
