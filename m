Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE101132A
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 08:09:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C94442123780B;
	Wed,  1 May 2019 23:09:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 959B821237806
 for <linux-nvdimm@lists.01.org>; Wed,  1 May 2019 23:09:19 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 May 2019 23:09:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,420,1549958400"; d="scan'208";a="136147452"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga007.jf.intel.com with ESMTP; 01 May 2019 23:09:18 -0700
Subject: [PATCH v7 02/12] mm/sparsemem: Introduce common definitions for the
 size and mask of a section
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Wed, 01 May 2019 22:55:32 -0700
Message-ID: <155677653274.2336373.11220321059915670288.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
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
Cc: mhocko@suse.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>, osalvador@suse.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

VXAtbGV2ZWwgdGhlIGxvY2FsIHNlY3Rpb24gc2l6ZSBhbmQgbWFzayBmcm9tIGtlcm5lbC9tZW1y
ZW1hcC5jIHRvCmdsb2JhbCBkZWZpbml0aW9ucy4gIFRoZXNlIHdpbGwgYmUgdXNlZCBieSB0aGUg
bmV3IHN1Yi1zZWN0aW9uIGhvdHBsdWcKc3VwcG9ydC4KCkNjOiBNaWNoYWwgSG9ja28gPG1ob2Nr
b0BzdXNlLmNvbT4KQ2M6IFZsYXN0aW1pbCBCYWJrYSA8dmJhYmthQHN1c2UuY3o+CkNjOiBKw6ly
w7RtZSBHbGlzc2UgPGpnbGlzc2VAcmVkaGF0LmNvbT4KQ2M6IExvZ2FuIEd1bnRob3JwZSA8bG9n
YW5nQGRlbHRhdGVlLmNvbT4KU2lnbmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxs
aWFtc0BpbnRlbC5jb20+Ci0tLQogaW5jbHVkZS9saW51eC9tbXpvbmUuaCB8ICAgIDIgKysKIGtl
cm5lbC9tZW1yZW1hcC5jICAgICAgfCAgIDEwICsrKystLS0tLS0KIG1tL2htbS5jICAgICAgICAg
ICAgICAgfCAgICAyIC0tCiAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tem9uZS5oIGIvaW5jbHVkZS9s
aW51eC9tbXpvbmUuaAppbmRleCBmMGJiZDg1ZGMxOWEuLjY3MjZmYzE3NWI1MSAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9saW51eC9tbXpvbmUuaAorKysgYi9pbmNsdWRlL2xpbnV4L21tem9uZS5oCkBA
IC0xMTM0LDYgKzExMzQsOCBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgZWFybHlfcGZu
X3RvX25pZCh1bnNpZ25lZCBsb25nIHBmbikKICAqIFBGTl9TRUNUSU9OX1NISUZUCQlwZm4gdG8v
ZnJvbSBzZWN0aW9uIG51bWJlcgogICovCiAjZGVmaW5lIFBBX1NFQ1RJT05fU0hJRlQJKFNFQ1RJ
T05fU0laRV9CSVRTKQorI2RlZmluZSBQQV9TRUNUSU9OX1NJWkUJCSgxVUwgPDwgUEFfU0VDVElP
Tl9TSElGVCkKKyNkZWZpbmUgUEFfU0VDVElPTl9NQVNLCQkofihQQV9TRUNUSU9OX1NJWkUtMSkp
CiAjZGVmaW5lIFBGTl9TRUNUSU9OX1NISUZUCShTRUNUSU9OX1NJWkVfQklUUyAtIFBBR0VfU0hJ
RlQpCiAKICNkZWZpbmUgTlJfTUVNX1NFQ1RJT05TCQkoMVVMIDw8IFNFQ1RJT05TX1NISUZUKQpk
aWZmIC0tZ2l0IGEva2VybmVsL21lbXJlbWFwLmMgYi9rZXJuZWwvbWVtcmVtYXAuYwppbmRleCA0
ZTU5ZDI5MjQ1ZjQuLmYzNTU1ODZlYTU0YSAxMDA2NDQKLS0tIGEva2VybmVsL21lbXJlbWFwLmMK
KysrIGIva2VybmVsL21lbXJlbWFwLmMKQEAgLTE0LDggKzE0LDYgQEAKICNpbmNsdWRlIDxsaW51
eC9obW0uaD4KIAogc3RhdGljIERFRklORV9YQVJSQVkocGdtYXBfYXJyYXkpOwotI2RlZmluZSBT
RUNUSU9OX01BU0sgfigoMVVMIDw8IFBBX1NFQ1RJT05fU0hJRlQpIC0gMSkKLSNkZWZpbmUgU0VD
VElPTl9TSVpFICgxVUwgPDwgUEFfU0VDVElPTl9TSElGVCkKIAogI2lmIElTX0VOQUJMRUQoQ09O
RklHX0RFVklDRV9QUklWQVRFKQogdm1fZmF1bHRfdCBkZXZpY2VfcHJpdmF0ZV9lbnRyeV9mYXVs
dChzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwKQEAgLTk4LDggKzk2LDggQEAgc3RhdGljIHZv
aWQgZGV2bV9tZW1yZW1hcF9wYWdlc19yZWxlYXNlKHZvaWQgKmRhdGEpCiAJCXB1dF9wYWdlKHBm
bl90b19wYWdlKHBmbikpOwogCiAJLyogcGFnZXMgYXJlIGRlYWQgYW5kIHVudXNlZCwgdW5kbyB0
aGUgYXJjaCBtYXBwaW5nICovCi0JYWxpZ25fc3RhcnQgPSByZXMtPnN0YXJ0ICYgfihTRUNUSU9O
X1NJWkUgLSAxKTsKLQlhbGlnbl9zaXplID0gQUxJR04ocmVzLT5zdGFydCArIHJlc291cmNlX3Np
emUocmVzKSwgU0VDVElPTl9TSVpFKQorCWFsaWduX3N0YXJ0ID0gcmVzLT5zdGFydCAmIH4oUEFf
U0VDVElPTl9TSVpFIC0gMSk7CisJYWxpZ25fc2l6ZSA9IEFMSUdOKHJlcy0+c3RhcnQgKyByZXNv
dXJjZV9zaXplKHJlcyksIFBBX1NFQ1RJT05fU0laRSkKIAkJLSBhbGlnbl9zdGFydDsKIAogCW5p
ZCA9IHBhZ2VfdG9fbmlkKHBmbl90b19wYWdlKGFsaWduX3N0YXJ0ID4+IFBBR0VfU0hJRlQpKTsK
QEAgLTE2MCw4ICsxNTgsOCBAQCB2b2lkICpkZXZtX21lbXJlbWFwX3BhZ2VzKHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IGRldl9wYWdlbWFwICpwZ21hcCkKIAlpZiAoIXBnbWFwLT5yZWYgfHwg
IXBnbWFwLT5raWxsKQogCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKIAotCWFsaWduX3N0YXJ0
ID0gcmVzLT5zdGFydCAmIH4oU0VDVElPTl9TSVpFIC0gMSk7Ci0JYWxpZ25fc2l6ZSA9IEFMSUdO
KHJlcy0+c3RhcnQgKyByZXNvdXJjZV9zaXplKHJlcyksIFNFQ1RJT05fU0laRSkKKwlhbGlnbl9z
dGFydCA9IHJlcy0+c3RhcnQgJiB+KFBBX1NFQ1RJT05fU0laRSAtIDEpOworCWFsaWduX3NpemUg
PSBBTElHTihyZXMtPnN0YXJ0ICsgcmVzb3VyY2Vfc2l6ZShyZXMpLCBQQV9TRUNUSU9OX1NJWkUp
CiAJCS0gYWxpZ25fc3RhcnQ7CiAJYWxpZ25fZW5kID0gYWxpZ25fc3RhcnQgKyBhbGlnbl9zaXpl
IC0gMTsKIApkaWZmIC0tZ2l0IGEvbW0vaG1tLmMgYi9tbS9obW0uYwppbmRleCAwZGI4NDkxMDkw
YjguLmE3ZTdmOGUzM2M1ZiAxMDA2NDQKLS0tIGEvbW0vaG1tLmMKKysrIGIvbW0vaG1tLmMKQEAg
LTM0LDggKzM0LDYgQEAKICNpbmNsdWRlIDxsaW51eC9tbXVfbm90aWZpZXIuaD4KICNpbmNsdWRl
IDxsaW51eC9tZW1vcnlfaG90cGx1Zy5oPgogCi0jZGVmaW5lIFBBX1NFQ1RJT05fU0laRSAoMVVM
IDw8IFBBX1NFQ1RJT05fU0hJRlQpCi0KICNpZiBJU19FTkFCTEVEKENPTkZJR19ITU1fTUlSUk9S
KQogc3RhdGljIGNvbnN0IHN0cnVjdCBtbXVfbm90aWZpZXJfb3BzIGhtbV9tbXVfbm90aWZpZXJf
b3BzOwogCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6
Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udmRpbW0K
