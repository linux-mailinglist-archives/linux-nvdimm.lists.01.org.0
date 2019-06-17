Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1509F48209
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 14:27:50 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F2EF621296B26;
	Mon, 17 Jun 2019 05:27:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+a9ecd0bfb5b639be820a+5776+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4EC4A2128A65C
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 05:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IiaLcJALEKaB7Li7OAHwGVaUV7J5HHtfGyRFzVhVT5I=; b=nRxanBbFaXKRrfonPCdCK8x8a
 H13NLWpT/FYGEMhPawtjpKXuuFd5AsVGls0FU/bFblMxeQyfmVpGkj8pGsbrVCCWMJWTllTMnGpqR
 lLvHY6XYJAnUlu8naiV+ey/kfflUSIzdOe46iLEfPoDAcpWQgUXfY+Hmls32zlkAUygawRFXkMCHP
 wYZFnLlYcqST58xEgFnwklfAMQdGemLG8MCW+sf8MPt5vq44TqtytxlspPlDutukXjQTeeXjgmomc
 DBnAvx70XsOhTxq4s1gUZqpsTkLMt1yioXaF7KDQUOS+v7Psp7YyIakjW17TKDyANImlYyLvulA8s
 Kdy4HvCiw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hcqjZ-0008K6-5z; Mon, 17 Jun 2019 12:27:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: dev_pagemap related cleanups v2
Date: Mon, 17 Jun 2019 14:27:08 +0200
Message-Id: <20190617122733.22432-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

SGkgRGFuLCBKw6lyw7RtZSBhbmQgSmFzb24sCgpiZWxvdyBpcyBhIHNlcmllcyB0aGF0IGNsZWFu
cyB1cCB0aGUgZGV2X3BhZ2VtYXAgaW50ZXJmYWNlIHNvIHRoYXQKaXQgaXMgbW9yZSBlYXNpbHkg
dXNhYmxlLCB3aGljaCByZW1vdmVzIHRoZSBuZWVkIHRvIHdyYXAgaXQgaW4gaG1tCmFuZCB0aHVz
IGFsbG93aW5nIHRvIGtpbGwgYSBsb3Qgb2YgY29kZQoKTm90ZTogdGhpcyBzZXJpZXMgaXMgb24g
dG9wIG9mIHRoZSByZG1hL2htbSBicmFuY2ggKyB0aGUgZGV2X3BhZ2VtYXAKcmVsZWFzIGZpeCBz
ZXJpZXMgZnJvbSBEYW4gdGhhdCB3ZW50IGludG8gNS4yLXJjNS4KCkdpdCB0cmVlOgoKICAgIGdp
dDovL2dpdC5pbmZyYWRlYWQub3JnL3VzZXJzL2hjaC9taXNjLmdpdCBobW0tZGV2bWVtLWNsZWFu
dXAuMgoKR2l0d2ViOgoKICAgIGh0dHA6Ly9naXQuaW5mcmFkZWFkLm9yZy91c2Vycy9oY2gvbWlz
Yy5naXQvc2hvcnRsb2cvcmVmcy9oZWFkcy9obW0tZGV2bWVtLWNsZWFudXAuMgoKQ2hhbmdlcyBz
aW5jZSB2MToKIC0gcmViYXNlCiAtIGFsc28gc3dpdGNoIHAycGRtYSB0byB0aGUgaW50ZXJuYWwg
cmVmY291bnQKIC0gYWRkIHR5cGUgY2hlY2tpbmcgZm9yIHBnbWFwLT50eXBlCiAtIHJlbmFtZSB0
aGUgbWlncmF0ZSBtZXRob2QgdG8gbWlncmF0ZV90b19yYW0KIC0gY2xlYW51cCB0aGUgYWx0bWFw
X3ZhbGlkIGZsYWcKIC0gdmFyaW91cyB0aWRiaXRzIGZyb20gdGhlIHJldmlld3MKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxp
bmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlzdHMuMDEub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
