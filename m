Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF821F5C8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 15:45:54 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8C11E212794AF;
	Wed, 15 May 2019 06:45:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net;
 receiver=linux-nvdimm@lists.01.org 
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 87826212794AA
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 06:45:50 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id CACC1AAB;
 Wed, 15 May 2019 13:45:47 +0000 (UTC)
Date: Wed, 15 May 2019 07:45:46 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v3 15/18] Documentation: kunit: add documentation for KUnit
Message-ID: <20190515074546.07700142@lwn.net>
In-Reply-To: <20190514231902.GA12893@google.com>
References: <20190514054251.186196-1-brendanhiggins@google.com>
 <20190514054251.186196-16-brendanhiggins@google.com>
 <20190514073422.4287267c@lwn.net>
 <20190514180810.GA109557@google.com>
 <20190514121623.0314bf07@lwn.net>
 <20190514231902.GA12893@google.com>
Organization: LWN.net
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com,
 dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
 yamada.masahiro@socionext.com, mpe@ellerman.id.au,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org,
 linux-nvdimm@lists.01.org, frowand.list@gmail.com, knut.omang@oracle.com,
 kieran.bingham@ideasonboard.com, Felix Guo <felixguoxiuping@gmail.com>,
 wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 tytso@mit.edu, richard@nod.at, sboyd@kernel.org, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org,
 daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org,
 khilman@baylibre.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gVHVlLCAxNCBNYXkgMjAxOSAxNjoxOTowMiAtMDcwMApCcmVuZGFuIEhpZ2dpbnMgPGJyZW5k
YW5oaWdnaW5zQGdvb2dsZS5jb20+IHdyb3RlOgoKPiBIbW1tLi4ucHJvYmFibHkgcHJlbWF0dXJl
IHRvIGJyaW5nIHRoaXMgdXAsIGJ1dCBEb2N1bWVudGF0aW9uL2Rldi10b29scy8KPiBpcyBraW5k
IG9mIHRocm93biB0b2dldGhlci4KCldhaXQgYSBtaW51dGUsIG1hbi4uLiAqSSogY3JlYXRlZCB0
aGF0IGRpcmVjdG9yeSwgYXJlIHlvdSBpbXB1Z25pbmcgbXkKd29yaz8gOikKCkJ1dCB5ZXMsICJr
aW5kIG9mIHRocm93biB0b2dldGhlciIgaXMgYSBnb29kIGRlc2NyaXB0aW9uIG9mIG11Y2ggb2YK
RG9jdW1lbnRhdGlvbi8uICBBIG51bWJlciBvZiBwZW9wbGUgaGF2ZSBiZWVuIHdvcmtpbmcgZm9y
IHllYXJzIHRvIG1ha2UKdGhhdCBiZXR0ZXIsIHdpdGggc29tZSBzdWNjZXNzLCBidXQgdGhlcmUg
aXMgYSBsb25nIHdheSB0byBnbyB5ZXQuICBUaGUKZGV2LXRvb2xzIGRpcmVjdG9yeSBpcyBhbiBp
bXByb3ZlbWVudCBvdmVyIGhhdmluZyB0aGF0IHN0dWZmIHNjYXR0ZXJlZCBhbGwKb3ZlciB0aGUg
cGxhY2Ug4oCUIGF0IGxlYXN0IGl0J3MgYWN0dWFsbHkgdGhyb3duIHRvZ2V0aGVyIOKAlCBidXQg
aXQncyBub3QgdGhlCmVuZCBwb2ludC4KCj4gSXQgd291bGQgYmUgbmljZSB0byBwcm92aWRlIGEg
Y29oZXJlbnQgb3ZlcnZpZXcsIG1heWJlIHByb3ZpZGUgc29tZQo+IGJhc2ljIGdyb3VwaW5nIGFz
IHdlbGwuCj4gCj4gSXQgd291bGQgYmUgbmljZSBpZiB0aGVyZSB3YXMga2luZCBvZiBhIGdlbnRs
ZSBpbnRyb2R1Y3Rpb24gdG8gdGhlCj4gdG9vbHMsIHdoaWNoIG9uZXMgeW91IHNob3VsZCBiZSBs
b29raW5nIGF0LCB3aGVuLCB3aHksIGV0Yy4KClRvdGFsIGFncmVlbWVudC4gIEFsbCB3ZSBuZWVk
IGlzIHNvbWVib2R5IHRvIHdyaXRlIGl0ISAgOikKClRoYW5rcywKCmpvbgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBs
aXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udmRpbW0K
