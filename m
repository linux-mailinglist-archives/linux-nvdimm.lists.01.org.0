Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAF0568CB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 14:27:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 55371212AAB86;
	Wed, 26 Jun 2019 05:27:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+ab1f803c58217d155be4+5785+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 99F35212AAB71
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YGx69ktqFfd50Mnd66pLKlz3uikDiZWUcfJ3jfUuvQk=; b=e05g33Wex+0CQQ9qi04aK+PPD
 72YJJQlOybfiI5HDpvAwNw3qyS9BQ2WnPDw3YMr+fSZN7R9d4Tn5T/Kg6qLvyaoDaHQZ0vlVbYbhx
 sH7r9sk7n9uAVs7ytRQPMUWtpIBu34n75RQsdX09ZN7vTlq63SjgxFL3+W2CGRZnbY4b1uq2QoXC9
 wfCap12FyOEmQpV3o8HSsJ+3sDUypgYRRenguNdBNIJhO4plDWVryg6VP0j/VmweKz3YUcCgDWjkR
 wJkxMMcljSkpHVx1W9E80XqfefYKjbk4v/9jvt3SU/bAHja9Xecuu8HugJFvBvJ02cUDAF0fQb/UW
 LymOmxY1g==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hg71L-0001Kf-Nf; Wed, 26 Jun 2019 12:27:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: dev_pagemap related cleanups v3
Date: Wed, 26 Jun 2019 14:26:59 +0200
Message-Id: <20190626122724.13313-1-hch@lst.de>
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
dG9wIG9mIExpbnV4IDUuMi1yYzUgYW5kIGhhcyBzb21lIG1pbm9yCmNvbmZsaWN0cyB3aXRoIHRo
ZSBobW0gdHJlZSB0aGF0IGFyZSBlYXN5IHRvIHJlc29sdmUuCgpEaWZmc3RhdCBzdW1tYXJ5OgoK
IDMyIGZpbGVzIGNoYW5nZWQsIDM2MSBpbnNlcnRpb25zKCspLCAxMDEyIGRlbGV0aW9ucygtKQoK
R2l0IHRyZWU6CgogICAgZ2l0Oi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMvaGNoL21pc2MuZ2l0
IGhtbS1kZXZtZW0tY2xlYW51cC4zCgpHaXR3ZWI6CgogICAgaHR0cDovL2dpdC5pbmZyYWRlYWQu
b3JnL3VzZXJzL2hjaC9taXNjLmdpdC9zaG9ydGxvZy9yZWZzL2hlYWRzL2htbS1kZXZtZW0tY2xl
YW51cC4zCgoKQ2hhbmdlcyBzaW5jZSB2MjoKIC0gZml4IG52ZGltbSBrdW5pdCBidWlsZAogLSBh
ZGQgYSBuZXcgbWVtb3J5IHR5cGUgZm9yIGRldmljZSBkYXgKIC0gZml4IGEgZmV3IGlzc3VlcyBp
biBpbnRlcm1lZGlhdGUgcGF0Y2hlcyB0aGF0IGRpZG4ndCBzaG93IHVwIGluIHRoZSBlbmQKICAg
cmVzdWx0CiAtIGluY29ycG9yYXRlIGZlZWRiYWNrIGZyb20gTWljaGFsIEhvY2tvLCBpbmNsdWRp
bmcga2lsbGluZyBvZgogICB0aGUgREVWSUNFX1BVQkxJQyBtZW1vcnkgdHlwZSBlbnRpcmVseQoK
Q2hhbmdlcyBzaW5jZSB2MToKIC0gcmViYXNlCiAtIGFsc28gc3dpdGNoIHAycGRtYSB0byB0aGUg
aW50ZXJuYWwgcmVmY291bnQKIC0gYWRkIHR5cGUgY2hlY2tpbmcgZm9yIHBnbWFwLT50eXBlCiAt
IHJlbmFtZSB0aGUgbWlncmF0ZSBtZXRob2QgdG8gbWlncmF0ZV90b19yYW0KIC0gY2xlYW51cCB0
aGUgYWx0bWFwX3ZhbGlkIGZsYWcKIC0gdmFyaW91cyB0aWRiaXRzIGZyb20gdGhlIHJldmlld3MK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZk
aW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlzdHMu
MDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
