Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBA35B49F
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jul 2019 08:20:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 24112212AB4F5;
	Sun, 30 Jun 2019 23:20:37 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id D11B72194EB77
 for <linux-nvdimm@lists.01.org>; Sun, 30 Jun 2019 23:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ha0G2SIX3qJwQBHCJ94hXS+l70ON3HkLuGbICbqpRXk=; b=McY+jahORBX9m/je/bQ6Q38b0
 28WcXEPXZE6Hcjq+4+sHpTWSUUYsygvbEwNrGXLJDRekMZBBLHs2JA6d74Md5I104lXzbV968Av2Z
 J3DQ3Q8m0Co759Cpf29dQlJNwis3r3MTh0SnOtF3FTLzlzDD1UtJcPF1MrRi/lcAYx9uEtoYU6DI1
 zW2v8jIkosACsyQpdiePRz4xMw1/0Q20ytuHFjDVBFY4moXLnh+l4DZt9Ylgq8UV1BYJzXJjsmDli
 YQZuhtMWHmwqMewYBuiuiE9Re+8KsGcSZTxhoYiwxkwOqQWnvw8dyNpA8uGeK74XtpU4V04Cfy3z7
 hn4lvcOUg==;
Received: from [46.140.178.35] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hhpfz-0002ta-A6; Mon, 01 Jul 2019 06:20:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 04/22] mm/hmm: support automatic NUMA balancing
Date: Mon,  1 Jul 2019 08:20:02 +0200
Message-Id: <20190701062020.19239-5-hch@lst.de>
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
Cc: Philip Yang <Philip.Yang@amd.com>, linux-nvdimm@lists.01.org,
 linux-pci@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

RnJvbTogUGhpbGlwIFlhbmcgPFBoaWxpcC5ZYW5nQGFtZC5jb20+CgpXaGlsZSB0aGUgcGFnZSBp
cyBtaWdyYXRpbmcgYnkgTlVNQSBiYWxhbmNpbmcsIEhNTSBmYWlsZWQgdG8gZGV0ZWN0IHRoaXMK
Y29uZGl0aW9uIGFuZCBzdGlsbCByZXR1cm4gdGhlIG9sZCBwYWdlLiBBcHBsaWNhdGlvbiB3aWxs
IHVzZSB0aGUgbmV3IHBhZ2UKbWlncmF0ZWQsIGJ1dCBkcml2ZXIgcGFzcyB0aGUgb2xkIHBhZ2Ug
cGh5c2ljYWwgYWRkcmVzcyB0byBHUFUsIHRoaXMgY3Jhc2gKdGhlIGFwcGxpY2F0aW9uIGxhdGVy
LgoKVXNlIHB0ZV9wcm90bm9uZShwdGUpIHRvIHJldHVybiB0aGlzIGNvbmRpdGlvbiBhbmQgdGhl
biBobW1fdm1hX2RvX2ZhdWx0CndpbGwgYWxsb2NhdGUgbmV3IHBhZ2UuCgpTaWduZWQtb2ZmLWJ5
OiBQaGlsaXAgWWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogRmVsaXgg
S3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBKw6lyw7RtZSBH
bGlzc2UgPGpnbGlzc2VAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAbWVsbGFub3guY29tPgotLS0KIG1tL2htbS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbW0vaG1tLmMgYi9t
bS9obW0uYwppbmRleCA0ZGI1ZGNmMTEwYmEuLmRjZTRlNzBlNjQ4YSAxMDA2NDQKLS0tIGEvbW0v
aG1tLmMKKysrIGIvbW0vaG1tLmMKQEAgLTU0OCw3ICs1NDgsNyBAQCBzdGF0aWMgaW50IGhtbV92
bWFfaGFuZGxlX3BtZChzdHJ1Y3QgbW1fd2FsayAqd2FsaywKIAogc3RhdGljIGlubGluZSB1aW50
NjRfdCBwdGVfdG9faG1tX3Bmbl9mbGFncyhzdHJ1Y3QgaG1tX3JhbmdlICpyYW5nZSwgcHRlX3Qg
cHRlKQogewotCWlmIChwdGVfbm9uZShwdGUpIHx8ICFwdGVfcHJlc2VudChwdGUpKQorCWlmIChw
dGVfbm9uZShwdGUpIHx8ICFwdGVfcHJlc2VudChwdGUpIHx8IHB0ZV9wcm90bm9uZShwdGUpKQog
CQlyZXR1cm4gMDsKIAlyZXR1cm4gcHRlX3dyaXRlKHB0ZSkgPyByYW5nZS0+ZmxhZ3NbSE1NX1BG
Tl9WQUxJRF0gfAogCQkJCXJhbmdlLT5mbGFnc1tITU1fUEZOX1dSSVRFXSA6Ci0tIAoyLjIwLjEK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
ZGltbSBtYWlsaW5nIGxpc3QKTGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpodHRwczovL2xpc3Rz
LjAxLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52ZGltbQo=
