Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3877990C23
	for <lists+linux-nvdimm@lfdr.de>; Sat, 17 Aug 2019 04:27:22 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7A3EF202E8432;
	Fri, 16 Aug 2019 19:29:06 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=211.29.132.249;
 helo=mail105.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au
 [211.29.132.249])
 by ml01.01.org (Postfix) with ESMTP id 6F5D720251A3B
 for <linux-nvdimm@lists.01.org>; Fri, 16 Aug 2019 19:29:04 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-190-67.pa.nsw.optusnet.com.au
 [49.195.190.67])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D0D423617AF;
 Sat, 17 Aug 2019 12:27:10 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
 (envelope-from <david@fromorbit.com>)
 id 1hyoPr-0000Wh-58; Sat, 17 Aug 2019 12:26:03 +1000
Date: Sat, 17 Aug 2019 12:26:03 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ; -)
Message-ID: <20190817022603.GW6129@dread.disaster.area>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190814101714.GA26273@quack2.suse.cz>
 <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
 a=TR82T6zjGmBjdfWdGgpkDw==:117 a=TR82T6zjGmBjdfWdGgpkDw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=FmdZ9Uzk2mMA:10
 a=7-415B0cAAAA:8 a=r7a9GJFEl8VWeONERSwA:9 a=QEXdDO2ut3YA:10
 a=biEYGPWJfzWAr4FL6Ov7:22
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
Cc: Michal Hocko <mhocko@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gRnJpLCBBdWcgMTYsIDIwMTkgYXQgMTI6MDU6MjhQTSAtMDcwMCwgSXJhIFdlaW55IHdyb3Rl
Ogo+IE9uIFRodSwgQXVnIDE1LCAyMDE5IGF0IDAzOjA1OjU4UE0gKzAyMDAsIEphbiBLYXJhIHdy
b3RlOgo+ID4gT24gV2VkIDE0LTA4LTE5IDExOjA4OjQ5LCBJcmEgV2Vpbnkgd3JvdGU6Cj4gPiA+
IE9uIFdlZCwgQXVnIDE0LCAyMDE5IGF0IDEyOjE3OjE0UE0gKzAyMDAsIEphbiBLYXJhIHdyb3Rl
Ogo+IDIpIFNlY29uZCByZWFzb24gaXMgdGhhdCBJIHRob3VnaHQgSSBkaWQgbm90IGhhdmUgYSBn
b29kIHdheSB0byB0ZWxsIGlmIHRoZQo+ICAgIGxlYXNlIHdhcyBhY3R1YWxseSBpbiB1c2UuICBX
aGF0IEkgbWVhbiBpcyB0aGF0IGxldHRpbmcgdGhlIGxlYXNlIGdvIHNob3VsZAo+ICAgIGJlIG9r
IElGRiB3ZSBkb24ndCBoYXZlIGFueSBwaW5zLi4uICBJIHdhcyB0aGlua2luZyB0aGF0IHdpdGhv
dXQgSm9obidzIGNvZGUKPiAgICB3ZSBkb24ndCBoYXZlIGEgd2F5IHRvIGtub3cgaWYgdGhlcmUg
YXJlIGFueSBwaW5zLi4uICBCdXQgdGhhdCBpcyB3cm9uZy4uLgo+ICAgIEFsbCB3ZSBoYXZlIHRv
IGRvIGlzIGNoZWNrCj4gCj4gCSFsaXN0X2VtcHR5KGZpbGUtPmZpbGVfcGlucykKPiAKPiBTbyBu
b3cgd2l0aCB0aGlzIGRldGFpbCBJIHRoaW5rIHlvdSBhcmUgcmlnaHQsIHdlIHNob3VsZCBiZSBh
YmxlIHRvIGhvbGQgdGhlCj4gbGVhc2UgdGhyb3VnaCB0aGUgc3RydWN0IGZpbGUgZXZlbiBpZiB0
aGUgcHJvY2VzcyBubyBsb25nZXIgaGFzIGFueQo+ICJyZWZlcmVuY2VzIiB0byBpdCAoaWUgY2xv
c2VzIGFuZCBtdW5tYXBzIHRoZSBmaWxlKS4KCkkgcmVhbGx5LCByZWFsbHkgZGlzbGlrZSB0aGUg
aWRlYSBvZiB6b21iaWUgbGF5b3V0IGxlYXNlcy4gSXQncyBhCm5hc3R5IGhhY2sgZm9yIHBvb3Ig
YXBwbGljYXRpb24gYmVoYXZpb3VyLiBUaGlzIGlzIGEgIndlIGFsbG93IHVzZQphZnRlciBsYXlv
dXQgbGVhc2UgcmVsZWFzZSIgQVBJLCBhbmQgSSB0aGluayBlbmNvZGluZyBsYXJnZWx5CnVudHJh
Y2VhYmxlIHpvbWJpZSBvYmplY3RzIGludG8gYW4gQVBJIGlzIHZlcnkgcG9vciBkZXNpZ24uCgpG
cm9tIHRoZSBmY250bCBtYW4gcGFnZToKCkxFQVNFUwoJTGVhc2VzIGFyZSBhc3NvY2lhdGVkIHdp
dGggYW4gb3BlbiBmaWxlIGRlc2NyaXB0aW9uIChzZWUKCW9wZW4oMikpLiAgVGhpcyBtZWFucyB0
aGF0IGR1cGxpY2F0ZSBmaWxlIGRlc2NyaXB0b3JzCgkoY3JlYXRlZCBieSwgZm9yIGV4YW1wbGUs
IGZvcmsoMikgb3IgZHVwKDIpKSAgcmXigJAgZmVyICB0bwoJdGhlICBzYW1lICBsZWFzZSwgIGFu
ZCB0aGlzIGxlYXNlIG1heSBiZSBtb2RpZmllZCBvcgoJcmVsZWFzZWQgdXNpbmcgYW55IG9mIHRo
ZXNlIGRlc2NyaXB0b3JzLiAgRnVydGhlcm1vcmUsIHRoZQoJbGVhc2UgaXMgcmVsZWFzZWQgYnkg
ZWl0aGVyIGFuIGV4cGxpY2l0IEZfVU5MQ0sgb3BlcmF0aW9uIG9uCglhbnkgb2YgdGhlc2UgZHVw
bGljYXRlIGZpbGUgZGVzY3JpcHRvcnMsIG9yIHdoZW4gYWxsIHN1Y2gKCWZpbGUgZGVzY3JpcHRv
cnMgaGF2ZSBiZWVuIGNsb3NlZC4KCkxlYXNlcyBhcmUgYXNzb2NpYXRlZCB3aXRoICpvcGVuKiBm
aWxlIGRlc2NyaXB0b3JzLCBub3QgdGhlCmxpZmV0aW1lIG9mIHRoZSBzdHJ1Y3QgZmlsZSBpbiB0
aGUga2VybmVsLiBJZiB0aGUgYXBwbGljYXRpb24gY2xvc2VzCnRoZSBvcGVuIGZkcyB0aGF0IHJl
ZmVyIHRvIHRoZSBsZWFzZSwgdGhlbiB0aGUga2VybmVsIGRvZXMgbm90Cmd1YXJhbnRlZSwgYW5k
IHRoZSBhcHBsaWNhdGlvbiBoYXMgbm8gcmlnaHQgdG8gZXhwZWN0LCB0aGF0IHRoZQpsZWFzZSBy
ZW1haW5zIGFjdGl2ZSBpbiBhbnkgd2F5IG9uY2UgdGhlIGFwcGxpY2F0aW9uIGNsb3NlcyBhbGwK
ZGlyZWN0IHJlZmVyZW5jZXMgdG8gdGhlIGxlYXNlLgoKSU9XcywgYXBwbGljYXRpb25zIHVzaW5n
IGxheW91dCBsZWFzZXMgbmVlZCB0byBob2xkIHRoZSBsZWFzZSBmZApvcGVuIGZvciBhcyBsb25n
IGFzIHRoZSB3YW50IGFjY2VzcyB0byB0aGUgcGh5c2ljYWwgZmlsZSBsYXlvdXQuIEl0CmlzIGEg
YWxzbyBhIHJlcXVpcmVtZW50IG9mIHRoZSBsYXlvdXQgbGVhc2UgdGhhdCB0aGUgaG9sZGVyIHJl
bGVhc2VzCnRoZSByZXNvdXJjZXMgaXQgaG9sZHMgb24gdGhlIGxheW91dCBiZWZvcmUgaXQgcmVs
ZWFzZXMgdGhlIGxheW91dApsZWFzZSwgZXhjbHVzaXZlIGxlYXNlIG9yIG5vdC4gQ2xvc2luZyB0
aGUgZmQgaW5kaWNhdGVzIHRoZXkgZG8gbm90Cm5lZWQgYWNjZXNzIHRvIHRoZSBmaWxlIGFueSBt
b3JlLCBhbmQgc28gdGhlIGxlYXNlIHNob3VsZCBiZQpyZWNsYWltZWQgYXQgdGhhdCBwb2ludC4K
CkknbSBvZiBhIG1pbmQgdG8gbWFrZSB0aGUgbGFzdCBjbG9zZSgpIG9uIGEgZmlsZSBibG9jayBp
ZiB0aGVyZSdzIGFuCmFjdGl2ZSBsYXlvdXQgbGVhc2UgdG8gcHJldmVudCBwcm9jZXNzZXMgZnJv
bSB6b21iaWUtaW5nIGxheW91dApsZWFzZXMgbGlrZSB0aGlzLiBpLmUuIHlvdSBjYW4ndCBjbG9z
ZSB0aGUgZmQgdW50aWwgcmVzb3VyY2VzIHRoYXQKcGluIHRoZSBsZWFzZSBoYXZlIGJlZW4gcmVs
ZWFzZWQuCgpDaGVlcnMsCgpEYXZlLgotLSAKRGF2ZSBDaGlubmVyCmRhdmlkQGZyb21vcmJpdC5j
b20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZkaW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlz
dHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
