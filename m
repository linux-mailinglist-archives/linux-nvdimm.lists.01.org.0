Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E925B4C0
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jul 2019 08:21:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B24E9212ABA4E;
	Sun, 30 Jun 2019 23:20:59 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id 597672194EB7A
 for <linux-nvdimm@lists.01.org>; Sun, 30 Jun 2019 23:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=icobwArBtoR8ReDHxdM0OSV/BylGVPj9OXDCrOjLCSM=; b=lwamREa5NpF4Qy4jd8BtxYQJa
 nM99VD+71jHSg4TsNOy4V5G/VKSIbY7ElfpDGBN9sHF8BUifq4wO1dXZmE6pBZ4vL7wLR7K8dZ/gx
 6SulrBoI6nnYyGZydRsfQjI68/LqnectAYeHOE8Xn2orshZkeo9o8NZPwuHmQlHIEeAeqX00o+USL
 R4PXEYmlglHfipdXdcexTu/a3rT0JHtQiFUQO7u19oa9teCY4agjpix8VB7C1Umr4kK5eQIt5Pxsf
 rXLjXGbbtyfO/TWua4uZNeT4G8Lrq7IN8aXw4oJyDXtZLqX1hx9G3HmFSRTa30Cy96bwJq41j1Hry
 Xbg6lO60A==;
Received: from [46.140.178.35] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hhpgM-00033L-98; Mon, 01 Jul 2019 06:20:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 14/22] mm/hmm: Remove racy protection against
 double-unregistration
Date: Mon,  1 Jul 2019 08:20:12 +0200
Message-Id: <20190701062020.19239-15-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701062020.19239-1-hch@lst.de>
References: <20190701062020.19239-1-hch@lst.de>
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
Cc: Philip Yang <Philip.Yang@amd.com>, Ralph Campbell <rcampbell@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-nvdimm@lists.01.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

RnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgoKTm8gb3RoZXIgcmVnaXN0
ZXIvdW5yZWdpc3RlciBrZXJuZWwgQVBJIGF0dGVtcHRzIHRvIHByb3ZpZGUgdGhpcyBraW5kIG9m
CnByb3RlY3Rpb24gYXMgaXQgaXMgaW5oZXJlbnRseSByYWN5LCBzbyBqdXN0IGRyb3AgaXQuCgpD
YWxsZXJzIHNob3VsZCBwcm92aWRlIHRoZWlyIG93biBwcm90ZWN0aW9uLCBhbmQgaXQgYXBwZWFy
cyBub3V2ZWF1CmFscmVhZHkgZG9lcy4KClNpZ25lZC1vZmYtYnk6IEphc29uIEd1bnRob3JwZSA8
amdnQG1lbGxhbm94LmNvbT4KUmV2aWV3ZWQtYnk6IErDqXLDtG1lIEdsaXNzZSA8amdsaXNzZUBy
ZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlkaWEuY29t
PgpSZXZpZXdlZC1ieTogUmFscGggQ2FtcGJlbGwgPHJjYW1wYmVsbEBudmlkaWEuY29tPgpSZXZp
ZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+ClRlc3RlZC1ieTogUGhpbGlw
IFlhbmcgPFBoaWxpcC5ZYW5nQGFtZC5jb20+Ci0tLQogbW0vaG1tLmMgfCA4ICstLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvbW0vaG1tLmMgYi9tbS9obW0uYwppbmRleCA2ZjVkYzZkNTY4ZmUuLjJlZjE0YjJiNTUwNSAx
MDA2NDQKLS0tIGEvbW0vaG1tLmMKKysrIGIvbW0vaG1tLmMKQEAgLTI3NiwxNyArMjc2LDExIEBA
IEVYUE9SVF9TWU1CT0woaG1tX21pcnJvcl9yZWdpc3Rlcik7CiAgKi8KIHZvaWQgaG1tX21pcnJv
cl91bnJlZ2lzdGVyKHN0cnVjdCBobW1fbWlycm9yICptaXJyb3IpCiB7Ci0Jc3RydWN0IGhtbSAq
aG1tID0gUkVBRF9PTkNFKG1pcnJvci0+aG1tKTsKLQotCWlmIChobW0gPT0gTlVMTCkKLQkJcmV0
dXJuOworCXN0cnVjdCBobW0gKmhtbSA9IG1pcnJvci0+aG1tOwogCiAJZG93bl93cml0ZSgmaG1t
LT5taXJyb3JzX3NlbSk7CiAJbGlzdF9kZWxfaW5pdCgmbWlycm9yLT5saXN0KTsKLQkvKiBUbyBw
cm90ZWN0IHVzIGFnYWluc3QgZG91YmxlIHVucmVnaXN0ZXIgLi4uICovCi0JbWlycm9yLT5obW0g
PSBOVUxMOwogCXVwX3dyaXRlKCZobW0tPm1pcnJvcnNfc2VtKTsKLQogCWhtbV9wdXQoaG1tKTsK
IH0KIEVYUE9SVF9TWU1CT0woaG1tX21pcnJvcl91bnJlZ2lzdGVyKTsKLS0gCjIuMjAuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1t
IG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlzdHMuMDEu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
