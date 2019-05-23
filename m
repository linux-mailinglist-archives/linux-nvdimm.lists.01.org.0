Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5583F282B9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 May 2019 18:19:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 38E2221276BA2;
	Thu, 23 May 2019 09:19:34 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2001:41d0:602:dbe::8; helo=tartarus.angband.pl;
 envelope-from=kilobyte@angband.pl; receiver=linux-nvdimm@lists.01.org 
Received: from tartarus.angband.pl (tartarus.angband.pl
 [IPv6:2001:41d0:602:dbe::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0F4C321276B81
 for <linux-nvdimm@lists.01.org>; Thu, 23 May 2019 09:19:31 -0700 (PDT)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
 (envelope-from <kilobyte@angband.pl>)
 id 1hTqQv-0002uo-JE; Thu, 23 May 2019 18:19:09 +0200
Date: Thu, 23 May 2019 18:19:09 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 12/18] btrfs: allow MAP_SYNC mmap
Message-ID: <20190523161909.GA10771@angband.pl>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-13-rgoldwyn@suse.de>
 <20190523134449.GC2949@quack2.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190523134449.GC2949@quack2.suse.cz>
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
Cc: darrick.wong@oracle.com, nborisov@suse.com,
 Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-nvdimm@lists.01.org,
 david@fromorbit.com, dsterba@suse.cz, willy@infradead.org,
 Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-fsdevel@vger.kernel.org,
 hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gVGh1LCBNYXkgMjMsIDIwMTkgYXQgMDM6NDQ6NDlQTSArMDIwMCwgSmFuIEthcmEgd3JvdGU6
Cj4gT24gTW9uIDI5LTA0LTE5IDEyOjI2OjQzLCBHb2xkd3luIFJvZHJpZ3VlcyB3cm90ZToKPiA+
IEZyb206IEFkYW0gQm9yb3dza2kgPGtpbG9ieXRlQGFuZ2JhbmQucGw+Cj4gPiAKPiA+IFVzZWQg
YnkgdXNlcnNwYWNlIHRvIGRldGVjdCBEQVguCj4gPiBbcmdvbGR3eW5Ac3VzZS5jb206IEFkZGVk
IENPTkZJR19GU19EQVggYXJvdW5kIG1tYXBfc3VwcG9ydGVkX2ZsYWdzXQo+IAo+IFdoeSB0aGUg
Q09ORklHX0ZTX0RBWCBiaXQ/IFlvdXIgbW1hcCgyKSBpbXBsZW1lbnRhdGlvbiB1bmRlcnN0YW5k
cwo+IGltcGxpY2F0aW9ucyBvZiBNQVBfU1lOQyBmbGFnIGFuZCB0aGF0J3MgYWxsIHRoYXQncyBu
ZWVkZWQgdG8gc2V0Cj4gLm1tYXBfc3VwcG9ydGVkX2ZsYWdzLgoKR29vZCBwb2ludC4KCkFsc28s
IHRoYXQgY2hlY2sgd2lsbCBuZWVkIHRvIGJlIHVwZGF0ZWQgd2hlbiB0aGUgcG1lbS12aXJ0aW8g
cGF0Y2hzZXQgZ29lcwppbi4KCj4gPiBTaWduZWQtb2ZmLWJ5OiBBZGFtIEJvcm93c2tpIDxraWxv
Ynl0ZUBhbmdiYW5kLnBsPgo+ID4gU2lnbmVkLW9mZi1ieTogR29sZHd5biBSb2RyaWd1ZXMgPHJn
b2xkd3luQHN1c2UuY29tPgo+ID4gLS0tCj4gPiAgZnMvYnRyZnMvZmlsZS5jIHwgNCArKysrCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEv
ZnMvYnRyZnMvZmlsZS5jIGIvZnMvYnRyZnMvZmlsZS5jCj4gPiBpbmRleCA5ZDVhM2M5OWE2Yjku
LjM2MmE5Y2Y5ZGNiMiAxMDA2NDQKPiA+IC0tLSBhL2ZzL2J0cmZzL2ZpbGUuYwo+ID4gKysrIGIv
ZnMvYnRyZnMvZmlsZS5jCj4gPiBAQCAtMTYsNiArMTYsNyBAQAo+ID4gICNpbmNsdWRlIDxsaW51
eC9idHJmcy5oPgo+ID4gICNpbmNsdWRlIDxsaW51eC91aW8uaD4KPiA+ICAjaW5jbHVkZSA8bGlu
dXgvaXZlcnNpb24uaD4KPiA+ICsjaW5jbHVkZSA8bGludXgvbW1hbi5oPgo+ID4gICNpbmNsdWRl
ICJjdHJlZS5oIgo+ID4gICNpbmNsdWRlICJkaXNrLWlvLmgiCj4gPiAgI2luY2x1ZGUgInRyYW5z
YWN0aW9uLmgiCj4gPiBAQCAtMzMxOSw2ICszMzIwLDkgQEAgY29uc3Qgc3RydWN0IGZpbGVfb3Bl
cmF0aW9ucyBidHJmc19maWxlX29wZXJhdGlvbnMgPSB7Cj4gPiAgCS5zcGxpY2VfcmVhZAk9IGdl
bmVyaWNfZmlsZV9zcGxpY2VfcmVhZCwKPiA+ICAJLndyaXRlX2l0ZXIJPSBidHJmc19maWxlX3dy
aXRlX2l0ZXIsCj4gPiAgCS5tbWFwCQk9IGJ0cmZzX2ZpbGVfbW1hcCwKPiA+ICsjaWZkZWYgQ09O
RklHX0ZTX0RBWAo+ID4gKwkubW1hcF9zdXBwb3J0ZWRfZmxhZ3MgPSBNQVBfU1lOQywKPiA+ICsj
ZW5kaWYKPiA+ICAJLm9wZW4JCT0gYnRyZnNfZmlsZV9vcGVuLAo+ID4gIAkucmVsZWFzZQk9IGJ0
cmZzX3JlbGVhc2VfZmlsZSwKPiA+ICAJLmZzeW5jCQk9IGJ0cmZzX3N5bmNfZmlsZSwKPiA+IC0t
IAo+ID4gMi4xNi40Cj4gPiAKPiAtLSAKPiBKYW4gS2FyYSA8amFja0BzdXNlLmNvbT4KPiBTVVNF
IExhYnMsIENSCj4gCgotLSAK4qKA4qO04qC+4qC74qK24qOm4qCAIExhdGluOiAgIG1lb3cgNCBj
aGFyYWN0ZXJzLCA0IGNvbHVtbnMsICA0IGJ5dGVzCuKjvuKggeKioOKgkuKggOKjv+KhgSBHcmVl
azogICDOvM61zr/PhSA0IGNoYXJhY3RlcnMsIDQgY29sdW1ucywgIDggYnl0ZXMK4qK/4qGE4qCY
4qC34qCa4qCLICBSdW5lczogICDhm5fhm5bhm5/hmrkgNCBjaGFyYWN0ZXJzLCA0IGNvbHVtbnMs
IDEyIGJ5dGVzCuKgiOKgs+KjhOKggOKggOKggOKggCBDaGluZXNlOiDllrUgICAxIGNoYXJhY3Rl
ciwgIDIgY29sdW1ucywgIDMgYnl0ZXMgPC0tIGJlc3QhCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QKTGludXgt
bnZkaW1tQGxpc3RzLjAxLm9yZwpodHRwczovL2xpc3RzLjAxLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52ZGltbQo=
