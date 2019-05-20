Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CB424218
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 May 2019 22:25:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3AE702125583F;
	Mon, 20 May 2019 13:25:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=66.111.4.28; helo=out4-smtp.messagingengine.com;
 envelope-from=nikolaus@rath.org; receiver=linux-nvdimm@lists.01.org 
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CEE032120B104
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 13:25:53 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 01A7524627;
 Mon, 20 May 2019 16:25:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Mon, 20 May 2019 16:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
 :to:cc:subject:references:date:in-reply-to:message-id
 :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
 2s8insJw7SXiaaoi7n/jvMQaGaOOEQGGn9MA9sTXCzY=; b=nTVN23Gom1plLxpc
 7qd56RBh1d3zg39gxTuhjiar9f2o+0UBPe9IZOUFZwuGyCZiz0l6OEjzfyMegQRB
 kpA61V1jEC4TJQ6w/csBHq88m8rH6mzeHd9p3ib/VOh/wcURQ8E4JWe1z+rxoDJS
 riIbZmeDgi+SR5rL4zO6JYWtHsTKgQ1fgrGPdVUDNFDlAUnBW6lV7On+2rf54yIL
 98ercTcOkQk43giawKpcbz/pB31VOiezM2LsBxthPivE5C81+raWg2rB5OuMjRhP
 Bm55qTL1E09AlbLJFdhjjdOC5Zsqy2sf8CEohNnAKruGmn+Ryx6fjXLilfgFcdkx
 FyBTrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=2s8insJw7SXiaaoi7n/jvMQaGaOOEQGGn9MA9sTXC
 zY=; b=piEfKWYZVjjloiN91Gr8WKPqaq5AB5JOvYVIJFVUyuzruj6zx1inX4Ag2
 fHo2iGeXPT2KD4m5QyY9l3y/uzN6Fyc27m+oNff2mjLkQeRPRFkGgd1u2D2MKzyH
 zYPCtPggTO9+u2y2vAfbrikr2neLOK1hRytDAYPuQ4igrL2vHjYpXMVa44QF/+P8
 vi3bP/E0bYzo7EBvOpFJC+A0RMa1rxC91IOX9oU4w4fo/FPaHBzvgcB3CUZdoe0N
 dz84LaB6Wto9snsa10XIiO4I7T5RPSg7eMU3Ybmd6ND8Gx1lK4Dcwbrk+6c6GO/q
 FqfYzEaykUJxI1j2CQEHa+VHKwuIg==
X-ME-Sender: <xms:Tg3jXPSPMV2Zifntr-gXS1Wod57QlBL87TAYu2mgEZ5BEHPu6ehCIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtkedgudehvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvffufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhk
 ohhlrghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuffhomh
 grihhnpehgihhthhhusgdrtghomhenucfkphepudekhedrfedrleegrdduleegnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpefpihhkohhlrghushesrhgrthhhrdhorhhgnecuvehluh
 hsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:Tw3jXHnofyaTWPXOM2EmL4-bZccirz8aglg4Gej6SaqXedM5iw-pJA>
 <xmx:Tw3jXNxHbGqRnanASHfrQtGZr1_gLfZC5xRf-eHKyikxX1k4XJuDvg>
 <xmx:Tw3jXB0MfLetAtMWCuMMAzXvfg_2Dtfd153_MlpY0_ka-S1Cd8Pu1g>
 <xmx:Tw3jXMtNSUyYLa786PlpyrIhNLWWtCZBzCQrj1CGUaRQmT-zupvToQ>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
 by mail.messagingengine.com (Postfix) with ESMTPA id AA09B80061;
 Mon, 20 May 2019 16:25:50 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
 by ebox.rath.org (Postfix) with ESMTPS id CB17360;
 Mon, 20 May 2019 20:25:49 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
 id 9E565E00E1; Mon, 20 May 2019 21:25:49 +0100 (BST)
From: Nikolaus Rath <Nikolaus@rath.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2 02/30] fuse: Clear setuid bit even in cache=never path
References: <20190515192715.18000-1-vgoyal@redhat.com>
 <20190515192715.18000-3-vgoyal@redhat.com>
 <20190520144137.GA24093@localhost.localdomain>
 <20190520144437.GB24093@localhost.localdomain>
Mail-Copies-To: never
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal
 <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-nvdimm@lists.01.org, stefanha@redhat.com, dgilbert@redhat.com,
 swhiteho@redhat.com
Date: Mon, 20 May 2019 21:25:49 +0100
In-Reply-To: <20190520144437.GB24093@localhost.localdomain> (Miklos Szeredi's
 message of "Mon, 20 May 2019 16:44:37 +0200")
Message-ID: <87k1ekub3m.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
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
Cc: kvm@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, dgilbert@redhat.com, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org, swhiteho@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gTWF5IDIwIDIwMTksIE1pa2xvcyBTemVyZWRpIDxtaWtsb3NAc3plcmVkaS5odT4gd3JvdGU6
Cj4gT24gTW9uLCBNYXkgMjAsIDIwMTkgYXQgMDQ6NDE6MzdQTSArMDIwMCwgTWlrbG9zIFN6ZXJl
ZGkgd3JvdGU6Cj4+IE9uIFdlZCwgTWF5IDE1LCAyMDE5IGF0IDAzOjI2OjQ3UE0gLTA0MDAsIFZp
dmVrIEdveWFsIHdyb3RlOgo+PiA+IElmIGZ1c2UgZGFlbW9uIGlzIHN0YXJ0ZWQgd2l0aCBjYWNo
ZT1uZXZlciwgZnVzZSBmYWxscyBiYWNrIHRvIGRpcmVjdCBJTy4KPj4gPiBJbiB0aGF0IHdyaXRl
IHBhdGggd2UgZG9uJ3QgY2FsbCBmaWxlX3JlbW92ZV9wcml2cygpIGFuZCB0aGF0IG1lYW5zIHNl
dHVpZAo+PiA+IGJpdCBpcyBub3QgY2xlYXJlZCBpZiB1bnByaXZpbGlnZWQgdXNlciB3cml0ZXMg
dG8gYSBmaWxlIHdpdGggc2V0dWlkIGJpdCBzZXQuCj4+ID4gCj4+ID4gcGpkZnN0ZXN0IGNobW9k
IHRlc3QgMTIudCB0ZXN0cyB0aGlzIGFuZCBmYWlscy4KPj4gCj4+IEkgdGhpbmsgYmV0dGVyIHN1
bHV0aW9uIGlzIHRvIHRlbGwgdGhlIHNlcnZlciBpZiB0aGUgc3VpZCBiaXQgbmVlZHMgdG8gYmUK
Pj4gcmVtb3ZlZCwgc28gaXQgY2FuIGRvIHNvIGluIGEgcmFjZSBmcmVlIHdheS4KPj4gCj4+IEhl
cmUncyB0aGUga2VybmVsIHBhdGNoLCBhbmQgSSdsbCByZXBseSB3aXRoIHRoZSBsaWJmdXNlIHBh
dGNoLgo+Cj4gSGVyZSBhcmUgdGhlIHBhdGNoZXMgZm9yIGxpYmZ1c2UgYW5kIHBhc3N0aHJvdWdo
X2xsLgoKQ291bGQgeW91IGFsc28gc3VibWl0IHRoZW0gYXMgcHVsbCByZXF1ZXN0cyBhdCBodHRw
czovL2dpdGh1Yi5jb20vbGliZnVzZS9saWJmdXNlL3B1bGxzPwoKQmVzdCwKLU5pa29sYXVzCgot
LSAKR1BHIEZpbmdlcnByaW50OiBFRDMxIDc5MUIgMkM1QyAxNjEzIEFGMzggOEI4QSBEMTEzIEZD
QUMgM0M0RSA1OTlGCgogICAgICAgICAgICAgwrtUaW1lIGZsaWVzIGxpa2UgYW4gYXJyb3csIGZy
dWl0IGZsaWVzIGxpa2UgYSBCYW5hbmEuwqsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1A
bGlzdHMuMDEub3JnCmh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bnZkaW1tCg==
