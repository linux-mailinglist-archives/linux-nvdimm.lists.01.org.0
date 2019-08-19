Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF7291D2C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Aug 2019 08:34:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E968F20214B50;
	Sun, 18 Aug 2019 23:35:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8A27120214B25
 for <linux-nvdimm@lists.01.org>; Sun, 18 Aug 2019 23:35:43 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id ED46FAC26;
 Mon, 19 Aug 2019 06:34:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 4D0DC1E155E; Mon, 19 Aug 2019 08:34:12 +0200 (CEST)
Date: Mon, 19 Aug 2019 08:34:12 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ; -)
Message-ID: <20190819063412.GA20455@quack2.suse.cz>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190814101714.GA26273@quack2.suse.cz>
 <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190817022603.GW6129@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gU2F0IDE3LTA4LTE5IDEyOjI2OjAzLCBEYXZlIENoaW5uZXIgd3JvdGU6Cj4gT24gRnJpLCBB
dWcgMTYsIDIwMTkgYXQgMTI6MDU6MjhQTSAtMDcwMCwgSXJhIFdlaW55IHdyb3RlOgo+ID4gT24g
VGh1LCBBdWcgMTUsIDIwMTkgYXQgMDM6MDU6NThQTSArMDIwMCwgSmFuIEthcmEgd3JvdGU6Cj4g
PiA+IE9uIFdlZCAxNC0wOC0xOSAxMTowODo0OSwgSXJhIFdlaW55IHdyb3RlOgo+ID4gPiA+IE9u
IFdlZCwgQXVnIDE0LCAyMDE5IGF0IDEyOjE3OjE0UE0gKzAyMDAsIEphbiBLYXJhIHdyb3RlOgo+
ID4gMikgU2Vjb25kIHJlYXNvbiBpcyB0aGF0IEkgdGhvdWdodCBJIGRpZCBub3QgaGF2ZSBhIGdv
b2Qgd2F5IHRvIHRlbGwgaWYgdGhlCj4gPiAgICBsZWFzZSB3YXMgYWN0dWFsbHkgaW4gdXNlLiAg
V2hhdCBJIG1lYW4gaXMgdGhhdCBsZXR0aW5nIHRoZSBsZWFzZSBnbyBzaG91bGQKPiA+ICAgIGJl
IG9rIElGRiB3ZSBkb24ndCBoYXZlIGFueSBwaW5zLi4uICBJIHdhcyB0aGlua2luZyB0aGF0IHdp
dGhvdXQgSm9obidzIGNvZGUKPiA+ICAgIHdlIGRvbid0IGhhdmUgYSB3YXkgdG8ga25vdyBpZiB0
aGVyZSBhcmUgYW55IHBpbnMuLi4gIEJ1dCB0aGF0IGlzIHdyb25nLi4uCj4gPiAgICBBbGwgd2Ug
aGF2ZSB0byBkbyBpcyBjaGVjawo+ID4gCj4gPiAJIWxpc3RfZW1wdHkoZmlsZS0+ZmlsZV9waW5z
KQo+ID4gCj4gPiBTbyBub3cgd2l0aCB0aGlzIGRldGFpbCBJIHRoaW5rIHlvdSBhcmUgcmlnaHQs
IHdlIHNob3VsZCBiZSBhYmxlIHRvIGhvbGQgdGhlCj4gPiBsZWFzZSB0aHJvdWdoIHRoZSBzdHJ1
Y3QgZmlsZSBldmVuIGlmIHRoZSBwcm9jZXNzIG5vIGxvbmdlciBoYXMgYW55Cj4gPiAicmVmZXJl
bmNlcyIgdG8gaXQgKGllIGNsb3NlcyBhbmQgbXVubWFwcyB0aGUgZmlsZSkuCj4gCj4gSSByZWFs
bHksIHJlYWxseSBkaXNsaWtlIHRoZSBpZGVhIG9mIHpvbWJpZSBsYXlvdXQgbGVhc2VzLiBJdCdz
IGEKPiBuYXN0eSBoYWNrIGZvciBwb29yIGFwcGxpY2F0aW9uIGJlaGF2aW91ci4gVGhpcyBpcyBh
ICJ3ZSBhbGxvdyB1c2UKPiBhZnRlciBsYXlvdXQgbGVhc2UgcmVsZWFzZSIgQVBJLCBhbmQgSSB0
aGluayBlbmNvZGluZyBsYXJnZWx5Cj4gdW50cmFjZWFibGUgem9tYmllIG9iamVjdHMgaW50byBh
biBBUEkgaXMgdmVyeSBwb29yIGRlc2lnbi4KPiAKPiBGcm9tIHRoZSBmY250bCBtYW4gcGFnZToK
PiAKPiBMRUFTRVMKPiAJTGVhc2VzIGFyZSBhc3NvY2lhdGVkIHdpdGggYW4gb3BlbiBmaWxlIGRl
c2NyaXB0aW9uIChzZWUKPiAJb3BlbigyKSkuICBUaGlzIG1lYW5zIHRoYXQgZHVwbGljYXRlIGZp
bGUgZGVzY3JpcHRvcnMKPiAJKGNyZWF0ZWQgYnksIGZvciBleGFtcGxlLCBmb3JrKDIpIG9yIGR1
cCgyKSkgIHJl4oCQIGZlciAgdG8KPiAJdGhlICBzYW1lICBsZWFzZSwgIGFuZCB0aGlzIGxlYXNl
IG1heSBiZSBtb2RpZmllZCBvcgo+IAlyZWxlYXNlZCB1c2luZyBhbnkgb2YgdGhlc2UgZGVzY3Jp
cHRvcnMuICBGdXJ0aGVybW9yZSwgdGhlCj4gCWxlYXNlIGlzIHJlbGVhc2VkIGJ5IGVpdGhlciBh
biBleHBsaWNpdCBGX1VOTENLIG9wZXJhdGlvbiBvbgo+IAlhbnkgb2YgdGhlc2UgZHVwbGljYXRl
IGZpbGUgZGVzY3JpcHRvcnMsIG9yIHdoZW4gYWxsIHN1Y2gKPiAJZmlsZSBkZXNjcmlwdG9ycyBo
YXZlIGJlZW4gY2xvc2VkLgo+IAo+IExlYXNlcyBhcmUgYXNzb2NpYXRlZCB3aXRoICpvcGVuKiBm
aWxlIGRlc2NyaXB0b3JzLCBub3QgdGhlCj4gbGlmZXRpbWUgb2YgdGhlIHN0cnVjdCBmaWxlIGlu
IHRoZSBrZXJuZWwuIElmIHRoZSBhcHBsaWNhdGlvbiBjbG9zZXMKPiB0aGUgb3BlbiBmZHMgdGhh
dCByZWZlciB0byB0aGUgbGVhc2UsIHRoZW4gdGhlIGtlcm5lbCBkb2VzIG5vdAo+IGd1YXJhbnRl
ZSwgYW5kIHRoZSBhcHBsaWNhdGlvbiBoYXMgbm8gcmlnaHQgdG8gZXhwZWN0LCB0aGF0IHRoZQo+
IGxlYXNlIHJlbWFpbnMgYWN0aXZlIGluIGFueSB3YXkgb25jZSB0aGUgYXBwbGljYXRpb24gY2xv
c2VzIGFsbAo+IGRpcmVjdCByZWZlcmVuY2VzIHRvIHRoZSBsZWFzZS4KPiAKPiBJT1dzLCBhcHBs
aWNhdGlvbnMgdXNpbmcgbGF5b3V0IGxlYXNlcyBuZWVkIHRvIGhvbGQgdGhlIGxlYXNlIGZkCj4g
b3BlbiBmb3IgYXMgbG9uZyBhcyB0aGUgd2FudCBhY2Nlc3MgdG8gdGhlIHBoeXNpY2FsIGZpbGUg
bGF5b3V0LiBJdAo+IGlzIGEgYWxzbyBhIHJlcXVpcmVtZW50IG9mIHRoZSBsYXlvdXQgbGVhc2Ug
dGhhdCB0aGUgaG9sZGVyIHJlbGVhc2VzCj4gdGhlIHJlc291cmNlcyBpdCBob2xkcyBvbiB0aGUg
bGF5b3V0IGJlZm9yZSBpdCByZWxlYXNlcyB0aGUgbGF5b3V0Cj4gbGVhc2UsIGV4Y2x1c2l2ZSBs
ZWFzZSBvciBub3QuIENsb3NpbmcgdGhlIGZkIGluZGljYXRlcyB0aGV5IGRvIG5vdAo+IG5lZWQg
YWNjZXNzIHRvIHRoZSBmaWxlIGFueSBtb3JlLCBhbmQgc28gdGhlIGxlYXNlIHNob3VsZCBiZQo+
IHJlY2xhaW1lZCBhdCB0aGF0IHBvaW50Lgo+IAo+IEknbSBvZiBhIG1pbmQgdG8gbWFrZSB0aGUg
bGFzdCBjbG9zZSgpIG9uIGEgZmlsZSBibG9jayBpZiB0aGVyZSdzIGFuCj4gYWN0aXZlIGxheW91
dCBsZWFzZSB0byBwcmV2ZW50IHByb2Nlc3NlcyBmcm9tIHpvbWJpZS1pbmcgbGF5b3V0Cj4gbGVh
c2VzIGxpa2UgdGhpcy4gaS5lLiB5b3UgY2FuJ3QgY2xvc2UgdGhlIGZkIHVudGlsIHJlc291cmNl
cyB0aGF0Cj4gcGluIHRoZSBsZWFzZSBoYXZlIGJlZW4gcmVsZWFzZWQuCgpZZWFoLCBzbyB0aGlz
IHdhcyBteSBpbml0aWFsIHRob3VnaCBhcyB3ZWxsIFsxXS4gQnV0IGFzIHRoZSBkaXNjdXNzaW9u
IGluCnRoYXQgdGhyZWFkIHJldmVhbGVkLCB0aGUgcHJvYmxlbSB3aXRoIGJsb2NraW5nIGxhc3Qg
Y2xvc2UgaXMgdGhhdCBrZXJuZWwKZG9lcyBub3QgcmVhbGx5IGV4cGVjdCBjbG9zZSB0byBibG9j
ay4gWW91IGNvdWxkIGVhc2lseSBkZWFkbG9jayBlLmcuIGlmCnRoZSBwcm9jZXNzIGdldHMgU0lH
S0lMTCwgZmlsZSB3aXRoIGxlYXNlIGhhcyBmZCAxMCwgYW5kIHRoZSBSRE1BIGNvbnRleHQKaG9s
ZGluZyBwYWdlcyBwaW5uZWQgaGFzIGZkIDE1LiBPciB5b3UgY291bGQgd2FpdCBmb3IgYW5vdGhl
ciBwcm9jZXNzIHRvCnJlbGVhc2UgcGFnZSBwaW5zIGFuZCBibG9ja2luZyBTSUdLSUxMIG9uIHRo
YXQgaXMgYWxzbyBiYWQuIFNvIGluIHRoZSBlbmQKdGhlIGxlYXN0IGJhZCBzb2x1dGlvbiB3ZSd2
ZSBjb21lIHVwIHdpdGggd2VyZSB0aGVzZSAiem9tYmllIiBsZWFzZXMgYXMgeW91CmNhbGwgdGhl
bSBhbmQgdHJhY2tpbmcgdGhlbSBpbiAvcHJvYyBzbyB0aGF0IHVzZXJzcGFjZSBhdCBsZWFzdCBo
YXMgYSB3YXkKb2Ygc2VlaW5nIHRoZW0uIEJ1dCBpZiB5b3UgY2FuIGNvbWUgdXAgd2l0aCBhIGRp
ZmZlcmVudCBzb2x1dGlvbiwgSSdtCmNlcnRhaW5seSBub3QgYXR0YWNoZWQgdG8gdGhlIGN1cnJl
bnQgb25lLi4uCgoJCQkJCQkJCUhvbnphCgpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDE5MDYwNjEwNDIwMy5HRjc0MzNAcXVhY2syLnN1c2UuY3oKLS0gCkphbiBLYXJhIDxqYWNr
QHN1c2UuY29tPgpTVVNFIExhYnMsIENSCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QKTGludXgtbnZkaW1tQGxp
c3RzLjAxLm9yZwpodHRwczovL2xpc3RzLjAxLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
ZGltbQo=
