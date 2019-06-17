Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64624491F7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 23:08:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CCED121962301;
	Mon, 17 Jun 2019 14:08:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 08C8C21962301
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 14:08:44 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jun 2019 14:06:44 -0700
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jun 2019 14:06:44 -0700
Subject: [PATCH] libnvdimm: Enable unit test infrastructure compile checks
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 17 Jun 2019 13:52:27 -0700
Message-ID: <156080474760.3765313.13075804303259765566.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

VGhlIGluZnJhc3RydWN0dXJlIHRvIG1vY2sgY29yZSBsaWJudmRpbW0gcm91dGluZXMgZm9yIHVu
aXQgdGVzdGluZwpwdXJwb3NlcyBpcyBwcm9uZSB0byBiaXRyb3QgcmVsYXRpdmUgdG8gcmVmYWN0
b3Jpbmcgb2YgdGhhdCBjb3JlLgpBcnJhbmdlIGZvciB0aGUgdW5pdCB0ZXN0IGNvcmUgdG8gYmUg
YnVpbHQgd2hlbiBDT05GSUdfQ09NUElMRV9URVNUPXkuClRoaXMgZG9lcyBub3QgcmVzdWx0IGlu
IGEgZnVuY3Rpb25hbCB1bml0IHRlc3QgZW52aXJvbm1lbnQsIGl0IGlzIG9ubHkgYQpoZWxwZXIg
Zm9yIDBkYXkgdG8gY2F0Y2ggdW5pdCB0ZXN0IGJ1aWxkIHJlZ3Jlc3Npb25zLgoKQ2M6IErDqXLD
tG1lIEdsaXNzZSA8amdsaXNzZUByZWRoYXQuY29tPgpDYzogSmFzb24gR3VudGhvcnBlIDxqZ2dA
bWVsbGFub3guY29tPgpSZXBvcnRlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+
ClNpZ25lZC1vZmYtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPgot
LS0KIGRyaXZlcnMvbnZkaW1tL0tjb25maWcgIHwgICAxMSArKysrKysrKysrKwogZHJpdmVycy9u
dmRpbW0vTWFrZWZpbGUgfCAgICA0ICsrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL0tjb25maWcgYi9kcml2ZXJzL252ZGlt
bS9LY29uZmlnCmluZGV4IDU0NTAwNzk4ZjIzYS4uNTdkM2E2YzNhYzcwIDEwMDY0NAotLS0gYS9k
cml2ZXJzL252ZGltbS9LY29uZmlnCisrKyBiL2RyaXZlcnMvbnZkaW1tL0tjb25maWcKQEAgLTEx
OCw0ICsxMTgsMTUgQEAgY29uZmlnIE5WRElNTV9LRVlTCiAJZGVwZW5kcyBvbiBFTkNSWVBURURf
S0VZUwogCWRlcGVuZHMgb24gKExJQk5WRElNTT1FTkNSWVBURURfS0VZUykgfHwgTElCTlZESU1N
PW0KIAorY29uZmlnIE5WRElNTV9URVNUX0JVSUxECisJYm9vbCAiQnVpbGQgdGhlIHVuaXQgdGVz
dCBjb3JlIgorCWRlcGVuZHMgb24gQ09NUElMRV9URVNUCisJZGVmYXVsdCBDT01QSUxFX1RFU1QK
KwloZWxwCisJICBCdWlsZCB0aGUgY29yZSBvZiB0aGUgdW5pdCB0ZXN0IGluZnJhc3RydWN0dXJl
LiAgVGhlIHJlc3VsdCBvZgorCSAgdGhpcyBidWlsZCBpcyBub24tZnVuY3Rpb25hbCBmb3IgdW5p
dCB0ZXN0IGV4ZWN1dGlvbiwgYnV0IGl0CisJICBvdGhlcndpc2UgaGVscHMgY2F0Y2ggYnVpbGQg
ZXJyb3JzIGluZHVjZWQgYnkgY2hhbmdlcyB0byB0aGUKKwkgIGNvcmUgZGV2bV9tZW1yZW1hcF9w
YWdlcygpIGltcGxlbWVudGF0aW9uIGFuZCBvdGhlcgorCSAgaW5mcmFzdHJ1Y3R1cmUuCisKIGVu
ZGlmCmRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9NYWtlZmlsZSBiL2RyaXZlcnMvbnZkaW1t
L01ha2VmaWxlCmluZGV4IDZmMmEwODhhZmFkNi4uNDAwODBjMTIwMzYzIDEwMDY0NAotLS0gYS9k
cml2ZXJzL252ZGltbS9NYWtlZmlsZQorKysgYi9kcml2ZXJzL252ZGltbS9NYWtlZmlsZQpAQCAt
MjgsMyArMjgsNyBAQCBsaWJudmRpbW0tJChDT05GSUdfQlRUKSArPSBidHRfZGV2cy5vCiBsaWJu
dmRpbW0tJChDT05GSUdfTlZESU1NX1BGTikgKz0gcGZuX2RldnMubwogbGlibnZkaW1tLSQoQ09O
RklHX05WRElNTV9EQVgpICs9IGRheF9kZXZzLm8KIGxpYm52ZGltbS0kKENPTkZJR19OVkRJTU1f
S0VZUykgKz0gc2VjdXJpdHkubworCitUT09MUyA6PSAuLi8uLi90b29scworVEVTVF9TUkMgOj0g
JChUT09MUykvdGVzdGluZy9udmRpbW0vdGVzdAorb2JqLSQoQ09ORklHX05WRElNTV9URVNUX0JV
SUxEKSA6PSAkKFRFU1RfU1JDKS9pb21hcC5vCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGlt
bUBsaXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udmRpbW0K
