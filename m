Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 182E45B4AE
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jul 2019 08:20:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BCBB721959CB2;
	Sun, 30 Jun 2019 23:20:45 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id 60464212A36ED
 for <linux-nvdimm@lists.01.org>; Sun, 30 Jun 2019 23:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6YVs6Gmoqc0otAH1cnOxSKX8bCa6JUPIlHPM9q8lNZk=; b=QJEmvFA0ZXqEAKaJiHM/HXwFE
 BSDxo8D5Gtm1+W+1HqT50hAN9Vh8w++KZFTiCpoIRCsYVHvPKzZ98vwHICze2dMHHTu3MsptL1C6n
 O7g1pctaJ6PIxWWaR5gx83uyX1fdaWlJFe+20rb2/lZKp2kvGbX/hePtlJ+l1VRy9cv2q0Pl47sDG
 hujb0eQDbUAEB4ydfc/IjZP6MvWHN4HqpeTZB5VBq8IphPMfDVqZdFKemBiZSdAOokusox6fM/e83
 lBP6J/AanqzUQcGlT6hto+xPFgmHndkzmYuFM2q3Nj++ZQg8nkmgRFK6bl0H0cuLbH771Sx7SdPMa
 obMHsTfmg==;
Received: from [46.140.178.35] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hhpg8-0002w7-AT; Mon, 01 Jul 2019 06:20:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 08/22] mm/hmm: Hold a mmgrab from hmm to mm
Date: Mon,  1 Jul 2019 08:20:06 +0200
Message-Id: <20190701062020.19239-9-hch@lst.de>
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

RnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgoKU28gbG9uZyBhcyBhIHN0
cnVjdCBobW0gcG9pbnRlciBleGlzdHMsIHNvIHNob3VsZCB0aGUgc3RydWN0IG1tIGl0IGlzCmxp
bmtlZCB0b28uIEhvbGQgdGhlIG1tZ3JhYigpIGFzIHNvb24gYXMgYSBobW0gaXMgY3JlYXRlZCwg
YW5kIG1tZHJvcCgpIGl0Cm9uY2UgdGhlIGhtbSByZWZjb3VudCBnb2VzIHRvIHplcm8uCgpTaW5j
ZSBtbWRyb3AoKSAoaWUgYSAwIGtyZWYgb24gc3RydWN0IG1tKSBpcyBub3cgaW1wb3NzaWJsZSB3
aXRoIGEgIU5VTEwKbW0tPmhtbSBkZWxldGUgdGhlIGhtbV9obW1fZGVzdHJveSgpLgoKU2lnbmVk
LW9mZi1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgpSZXZpZXdlZC1ieTog
SsOpcsO0bWUgR2xpc3NlIDxqZ2xpc3NlQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBKb2huIEh1
YmJhcmQgPGpodWJiYXJkQG52aWRpYS5jb20+ClJldmlld2VkLWJ5OiBSYWxwaCBDYW1wYmVsbCA8
cmNhbXBiZWxsQG52aWRpYS5jb20+ClJldmlld2VkLWJ5OiBJcmEgV2VpbnkgPGlyYS53ZWlueUBp
bnRlbC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KVGVz
dGVkLWJ5OiBQaGlsaXAgWWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4KLS0tCiBpbmNsdWRlL2xp
bnV4L2htbS5oIHwgIDMgLS0tCiBrZXJuZWwvZm9yay5jICAgICAgIHwgIDEgLQogbW0vaG1tLmMg
ICAgICAgICAgICB8IDIyICsrKystLS0tLS0tLS0tLS0tLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L2htbS5oIGIvaW5jbHVkZS9saW51eC9obW0uaAppbmRleCAxZmJhNjk3OWFkZjQuLjFkOTdi
NmQ2MmM1YiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9obW0uaAorKysgYi9pbmNsdWRlL2xp
bnV4L2htbS5oCkBAIC01NzcsMTQgKzU3NywxMSBAQCBzdGF0aWMgaW5saW5lIGludCBobW1fdm1h
X2ZhdWx0KHN0cnVjdCBobW1fbWlycm9yICptaXJyb3IsCiB9CiAKIC8qIEJlbG93IGFyZSBmb3Ig
SE1NIGludGVybmFsIHVzZSBvbmx5ISBOb3QgdG8gYmUgdXNlZCBieSBkZXZpY2UgZHJpdmVyISAq
Lwotdm9pZCBobW1fbW1fZGVzdHJveShzdHJ1Y3QgbW1fc3RydWN0ICptbSk7Ci0KIHN0YXRpYyBp
bmxpbmUgdm9pZCBobW1fbW1faW5pdChzdHJ1Y3QgbW1fc3RydWN0ICptbSkKIHsKIAltbS0+aG1t
ID0gTlVMTDsKIH0KICNlbHNlIC8qIElTX0VOQUJMRUQoQ09ORklHX0hNTV9NSVJST1IpICovCi1z
dGF0aWMgaW5saW5lIHZvaWQgaG1tX21tX2Rlc3Ryb3koc3RydWN0IG1tX3N0cnVjdCAqbW0pIHt9
CiBzdGF0aWMgaW5saW5lIHZvaWQgaG1tX21tX2luaXQoc3RydWN0IG1tX3N0cnVjdCAqbW0pIHt9
CiAjZW5kaWYgLyogSVNfRU5BQkxFRChDT05GSUdfSE1NX01JUlJPUikgKi8KIApkaWZmIC0tZ2l0
IGEva2VybmVsL2ZvcmsuYyBiL2tlcm5lbC9mb3JrLmMKaW5kZXggNzU2NzViOWJmNmRmLi5jNzA0
YzNjZWRlZTcgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9mb3JrLmMKKysrIGIva2VybmVsL2ZvcmsuYwpA
QCAtNjczLDcgKzY3Myw2IEBAIHZvaWQgX19tbWRyb3Aoc3RydWN0IG1tX3N0cnVjdCAqbW0pCiAJ
V0FSTl9PTl9PTkNFKG1tID09IGN1cnJlbnQtPmFjdGl2ZV9tbSk7CiAJbW1fZnJlZV9wZ2QobW0p
OwogCWRlc3Ryb3lfY29udGV4dChtbSk7Ci0JaG1tX21tX2Rlc3Ryb3kobW0pOwogCW1tdV9ub3Rp
Zmllcl9tbV9kZXN0cm95KG1tKTsKIAljaGVja19tbShtbSk7CiAJcHV0X3VzZXJfbnMobW0tPnVz
ZXJfbnMpOwpkaWZmIC0tZ2l0IGEvbW0vaG1tLmMgYi9tbS9obW0uYwppbmRleCAyMmE5N2FkYTEw
OGIuLjA4MGIxN2EyZTg3ZSAxMDA2NDQKLS0tIGEvbW0vaG1tLmMKKysrIGIvbW0vaG1tLmMKQEAg
LTIwLDYgKzIwLDcgQEAKICNpbmNsdWRlIDxsaW51eC9zd2Fwb3BzLmg+CiAjaW5jbHVkZSA8bGlu
dXgvaHVnZXRsYi5oPgogI2luY2x1ZGUgPGxpbnV4L21lbXJlbWFwLmg+CisjaW5jbHVkZSA8bGlu
dXgvc2NoZWQvbW0uaD4KICNpbmNsdWRlIDxsaW51eC9qdW1wX2xhYmVsLmg+CiAjaW5jbHVkZSA8
bGludXgvZG1hLW1hcHBpbmcuaD4KICNpbmNsdWRlIDxsaW51eC9tbXVfbm90aWZpZXIuaD4KQEAg
LTczLDYgKzc0LDcgQEAgc3RhdGljIHN0cnVjdCBobW0gKmhtbV9nZXRfb3JfY3JlYXRlKHN0cnVj
dCBtbV9zdHJ1Y3QgKm1tKQogCWhtbS0+bm90aWZpZXJzID0gMDsKIAlobW0tPmRlYWQgPSBmYWxz
ZTsKIAlobW0tPm1tID0gbW07CisJbW1ncmFiKGhtbS0+bW0pOwogCiAJc3Bpbl9sb2NrKCZtbS0+
cGFnZV90YWJsZV9sb2NrKTsKIAlpZiAoIW1tLT5obW0pCkBAIC0xMDAsNiArMTAyLDcgQEAgc3Rh
dGljIHN0cnVjdCBobW0gKmhtbV9nZXRfb3JfY3JlYXRlKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQog
CQltbS0+aG1tID0gTlVMTDsKIAlzcGluX3VubG9jaygmbW0tPnBhZ2VfdGFibGVfbG9jayk7CiBl
cnJvcjoKKwltbWRyb3AoaG1tLT5tbSk7CiAJa2ZyZWUoaG1tKTsKIAlyZXR1cm4gTlVMTDsKIH0K
QEAgLTEyMSw2ICsxMjQsNyBAQCBzdGF0aWMgdm9pZCBobW1fZnJlZShzdHJ1Y3Qga3JlZiAqa3Jl
ZikKIAkJbW0tPmhtbSA9IE5VTEw7CiAJc3Bpbl91bmxvY2soJm1tLT5wYWdlX3RhYmxlX2xvY2sp
OwogCisJbW1kcm9wKGhtbS0+bW0pOwogCW1tdV9ub3RpZmllcl9jYWxsX3NyY3UoJmhtbS0+cmN1
LCBobW1fZnJlZV9yY3UpOwogfQogCkBAIC0xMjksMjQgKzEzMyw2IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBobW1fcHV0KHN0cnVjdCBobW0gKmhtbSkKIAlrcmVmX3B1dCgmaG1tLT5rcmVmLCBobW1f
ZnJlZSk7CiB9CiAKLXZvaWQgaG1tX21tX2Rlc3Ryb3koc3RydWN0IG1tX3N0cnVjdCAqbW0pCi17
Ci0Jc3RydWN0IGhtbSAqaG1tOwotCi0Jc3Bpbl9sb2NrKCZtbS0+cGFnZV90YWJsZV9sb2NrKTsK
LQlobW0gPSBtbV9nZXRfaG1tKG1tKTsKLQltbS0+aG1tID0gTlVMTDsKLQlpZiAoaG1tKSB7Ci0J
CWhtbS0+bW0gPSBOVUxMOwotCQlobW0tPmRlYWQgPSB0cnVlOwotCQlzcGluX3VubG9jaygmbW0t
PnBhZ2VfdGFibGVfbG9jayk7Ci0JCWhtbV9wdXQoaG1tKTsKLQkJcmV0dXJuOwotCX0KLQotCXNw
aW5fdW5sb2NrKCZtbS0+cGFnZV90YWJsZV9sb2NrKTsKLX0KLQogc3RhdGljIHZvaWQgaG1tX3Jl
bGVhc2Uoc3RydWN0IG1tdV9ub3RpZmllciAqbW4sIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQogewog
CXN0cnVjdCBobW0gKmhtbSA9IGNvbnRhaW5lcl9vZihtbiwgc3RydWN0IGhtbSwgbW11X25vdGlm
aWVyKTsKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEu
b3JnCmh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
