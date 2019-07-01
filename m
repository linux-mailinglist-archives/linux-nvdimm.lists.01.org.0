Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA35B4B6
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jul 2019 08:20:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B6D90212ABA47;
	Sun, 30 Jun 2019 23:20:52 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id BF5872194EB77
 for <linux-nvdimm@lists.01.org>; Sun, 30 Jun 2019 23:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RrOFns7vEPB9glYGnT15vcTk3dkoPLH+jZ0rXH1XhbY=; b=pj6y6zwWdYnnlShOohzj0+FeT
 ua95uB5pQbHGN7V1dXDgEO0XeP6NGP6wP9CsUw1MUxCczmfajEPQhpUmNuVemHicYTtOPwEIh4UZj
 haBcU1PuN/lbwsjtaumcMo2KOmzjIEUoauiWhV2s6QwwZAVMRb4f5gzsTcRERX7bZ7spwXs6dcJ43
 sRidW9kePUxliDSVB1n3yeaQo3+ui72nerrRiMi1f6EkTszO9712nLpu1yAs93if+p9DwRqXZ6zCd
 edma9n2V5pe+Luqle1eHfjwGFKvLPdkMzMs3gC2ttY0DPQRzYIJHcaA6t8Npl1EcNh3JUa+mKozuw
 56C4YQTVw==;
Received: from [46.140.178.35] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hhpgF-000304-Cn; Mon, 01 Jul 2019 06:20:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 11/22] mm/hmm: Do not use list*_rcu() for hmm->ranges
Date: Mon,  1 Jul 2019 08:20:09 +0200
Message-Id: <20190701062020.19239-12-hch@lst.de>
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
 linux-pci@vger.kernel.org, Ira Weiny <iweiny@intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, Souptick Joarder <jrdr.linux@gmail.com>,
 nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

RnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgoKVGhpcyBsaXN0IGlzIGFs
d2F5cyByZWFkIGFuZCB3cml0dGVuIHdoaWxlIGhvbGRpbmcgaG1tLT5sb2NrIHNvIHRoZXJlIGlz
Cm5vIG5lZWQgZm9yIHRoZSBjb25mdXNpbmcgX3JjdSBhbm5vdGF0aW9ucy4KClNpZ25lZC1vZmYt
Ynk6IEphc29uIEd1bnRob3JwZSA8amdnQG1lbGxhbm94LmNvbT4KUmV2aWV3ZWQtYnk6IErDqXLD
tG1lIEdsaXNzZSA8amdsaXNzZUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogSm9obiBIdWJiYXJk
IDxqaHViYmFyZEBudmlkaWEuY29tPgpBY2tlZC1ieTogU291cHRpY2sgSm9hcmRlciA8anJkci5s
aW51eEBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBSYWxwaCBDYW1wYmVsbCA8cmNhbXBiZWxsQG52
aWRpYS5jb20+ClJldmlld2VkLWJ5OiBJcmEgV2VpbnkgPGl3ZWlueUBpbnRlbC5jb20+ClJldmll
d2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KVGVzdGVkLWJ5OiBQaGlsaXAg
WWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4KLS0tCiBtbS9obW0uYyB8IDQgKystLQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9t
bS9obW0uYyBiL21tL2htbS5jCmluZGV4IDA0MjNmNGNhM2E3ZS4uNzNjOGFmNDgyN2ZlIDEwMDY0
NAotLS0gYS9tbS9obW0uYworKysgYi9tbS9obW0uYwpAQCAtOTEyLDcgKzkxMiw3IEBAIGludCBo
bW1fcmFuZ2VfcmVnaXN0ZXIoc3RydWN0IGhtbV9yYW5nZSAqcmFuZ2UsCiAKIAlyYW5nZS0+aG1t
ID0gaG1tOwogCWtyZWZfZ2V0KCZobW0tPmtyZWYpOwotCWxpc3RfYWRkX3JjdSgmcmFuZ2UtPmxp
c3QsICZobW0tPnJhbmdlcyk7CisJbGlzdF9hZGQoJnJhbmdlLT5saXN0LCAmaG1tLT5yYW5nZXMp
OwogCiAJLyoKIAkgKiBJZiB0aGVyZSBhcmUgYW55IGNvbmN1cnJlbnQgbm90aWZpZXJzIHdlIGhh
dmUgdG8gd2FpdCBmb3IgdGhlbSBmb3IKQEAgLTk0Miw3ICs5NDIsNyBAQCB2b2lkIGhtbV9yYW5n
ZV91bnJlZ2lzdGVyKHN0cnVjdCBobW1fcmFuZ2UgKnJhbmdlKQogCQlyZXR1cm47CiAKIAltdXRl
eF9sb2NrKCZobW0tPmxvY2spOwotCWxpc3RfZGVsX3JjdSgmcmFuZ2UtPmxpc3QpOworCWxpc3Rf
ZGVsKCZyYW5nZS0+bGlzdCk7CiAJbXV0ZXhfdW5sb2NrKCZobW0tPmxvY2spOwogCiAJLyogRHJv
cCByZWZlcmVuY2UgdGFrZW4gYnkgaG1tX3JhbmdlX3JlZ2lzdGVyKCkgKi8KLS0gCjIuMjAuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZk
aW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlzdHMu
MDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
