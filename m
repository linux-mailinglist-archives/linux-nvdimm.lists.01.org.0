Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9BC5B497
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jul 2019 08:20:32 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2CFF921959CB2;
	Sun, 30 Jun 2019 23:20:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+bb02ddf78a79a38d855c+5790+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B1FB821296400
 for <linux-nvdimm@lists.01.org>; Sun, 30 Jun 2019 23:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6xqIf0xVqrmwyuBYUV8qbkcY4fEJxDo5YYvPGQNv0Dg=; b=GnFpJ4/Oc/100n/wlMN0yyuTT
 qBVa3bbru2+kI55sKA82ZcwWbugtiuZLwkxnhpe5470h26XmfvTn4dShhCGDC99YkHXONgWcU6z0S
 5t/erBmlFFzhqv1WZ+ZnfPaiEb7cET33XrkX7TjbDP0GDKX4lTAs35mFDMwJwFFJXsTbjCCnz9Qsb
 T3LnzxrWgwM+9wArnuvCnRPC5yeDP07v4E+ncJnB+zriXMvtCe7R2MCuImkRo0lDXVWrImhTs8/Hp
 vF2SD1TvWGF7X/3d5CVihaeKKlUv9boEcAw2xU/YcQWyjar7krBJ5gs3T6qNDPoM5TghNpS8HWW4h
 KPFEdN94g==;
Received: from [46.140.178.35] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hhpfq-0002sH-DB; Mon, 01 Jul 2019 06:20:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: dev_pagemap related cleanups v4
Date: Mon,  1 Jul 2019 08:19:58 +0200
Message-Id: <20190701062020.19239-1-hch@lst.de>
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
dG9wIG9mIExpbnV4IDUuMi1yYzYgYW5kIGhhcyBzb21lIG1pbm9yCmNvbmZsaWN0cyB3aXRoIHRo
ZSBobW0gdHJlZSB0aGF0IGFyZSBlYXN5IHRvIHJlc29sdmUuCgpEaWZmc3RhdCBzdW1tYXJ5OgoK
IDM0IGZpbGVzIGNoYW5nZWQsIDM3OSBpbnNlcnRpb25zKCspLCAxMDE2IGRlbGV0aW9ucygtKQoK
R2l0IHRyZWU6CgogICAgZ2l0Oi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMvaGNoL21pc2MuZ2l0
IGhtbS1kZXZtZW0tY2xlYW51cC40CgpHaXR3ZWI6CgogICAgaHR0cDovL2dpdC5pbmZyYWRlYWQu
b3JnL3VzZXJzL2hjaC9taXNjLmdpdC9zaG9ydGxvZy9yZWZzL2hlYWRzL2htbS1kZXZtZW0tY2xl
YW51cC40CgoKQ2hhbmdlcyBzaW5jZSB2MzoKIC0gcHVsbCBpbiAibW0vc3dhcDogRml4IHJlbGVh
c2VfcGFnZXMoKSB3aGVuIHJlbGVhc2luZyBkZXZtYXAgcGFnZXMiIGFuZAogICByZWJhc2UgdGhl
IG90aGVyIHBhdGNoZXMgb24gdG9wIG9mIHRoYXQKIC0gZm9sZCB0aGUgaG1tX2Rldm1lbV9hZGRf
cmVzb3VyY2UgaW50byB0aGUgREVWSUNFX1BVQkxJQyBtZW1vcnkgcmVtb3ZhbAogICBwYXRjaAog
LSByZW1vdmUgX3ZtX25vcm1hbF9wYWdlIGFzIGl0IGlzbid0IG5lZWRlZCB3aXRob3V0IERFVklD
RV9QVUJMSUMgbWVtb3J5CiAtIHBpY2sgdXAgdmFyaW91cyBBQ0tzCgpDaGFuZ2VzIHNpbmNlIHYy
OgogLSBmaXggbnZkaW1tIGt1bml0IGJ1aWxkCiAtIGFkZCBhIG5ldyBtZW1vcnkgdHlwZSBmb3Ig
ZGV2aWNlIGRheAogLSBmaXggYSBmZXcgaXNzdWVzIGluIGludGVybWVkaWF0ZSBwYXRjaGVzIHRo
YXQgZGlkbid0IHNob3cgdXAgaW4gdGhlIGVuZAogICByZXN1bHQKIC0gaW5jb3Jwb3JhdGUgZmVl
ZGJhY2sgZnJvbSBNaWNoYWwgSG9ja28sIGluY2x1ZGluZyBraWxsaW5nIG9mCiAgIHRoZSBERVZJ
Q0VfUFVCTElDIG1lbW9yeSB0eXBlIGVudGlyZWx5CgpDaGFuZ2VzIHNpbmNlIHYxOgogLSByZWJh
c2UKIC0gYWxzbyBzd2l0Y2ggcDJwZG1hIHRvIHRoZSBpbnRlcm5hbCByZWZjb3VudAogLSBhZGQg
dHlwZSBjaGVja2luZyBmb3IgcGdtYXAtPnR5cGUKIC0gcmVuYW1lIHRoZSBtaWdyYXRlIG1ldGhv
ZCB0byBtaWdyYXRlX3RvX3JhbQogLSBjbGVhbnVwIHRoZSBhbHRtYXBfdmFsaWQgZmxhZwogLSB2
YXJpb3VzIHRpZGJpdHMgZnJvbSB0aGUgcmV2aWV3cwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4LW52
ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udmRpbW0K
