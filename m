Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A6A96C6
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Sep 2019 00:57:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E3E9421962301;
	Wed,  4 Sep 2019 15:58:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B0B9D20212CA8
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 15:58:52 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 15:57:49 -0700
X-IronPort-AV: E=Sophos;i="5.64,468,1559545200"; d="scan'208";a="177109951"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 15:57:48 -0700
Subject: [PATCH v4] libnvdimm: Enable unit test infrastructure compile checks
From: Dan Williams <dan.j.williams@intel.com>
To: jgg@ziepe.ca
Date: Wed, 04 Sep 2019 15:43:31 -0700
Message-ID: <156763690875.2556198.15786177395425033830.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: linux-kernel@vger.kernel.org,
 =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

VGhlIGluZnJhc3RydWN0dXJlIHRvIG1vY2sgY29yZSBsaWJudmRpbW0gcm91dGluZXMgZm9yIHVu
aXQgdGVzdGluZwpwdXJwb3NlcyBpcyBwcm9uZSB0byBiaXRyb3QgcmVsYXRpdmUgdG8gcmVmYWN0
b3Jpbmcgb2YgdGhhdCBjb3JlLgpBcnJhbmdlIGZvciB0aGUgdW5pdCB0ZXN0IGNvcmUgdG8gYmUg
YnVpbHQgd2hlbiBDT05GSUdfQ09NUElMRV9URVNUPXkuClRoaXMgZG9lcyBub3QgcmVzdWx0IGlu
IGEgZnVuY3Rpb25hbCB1bml0IHRlc3QgZW52aXJvbm1lbnQsIGl0IGlzIG9ubHkgYQpoZWxwZXIg
Zm9yIDBkYXkgdG8gY2F0Y2ggdW5pdCB0ZXN0IGJ1aWxkIHJlZ3Jlc3Npb25zLgoKTm90ZSB0aGF0
IHRoZXJlIGFyZSBhIGZldyB4ODZpc21zIGluIHRoZSBpbXBsZW1lbnRhdGlvbiwgc28gdGhpcyBk
b2VzCm5vdCBib3RoZXIgY29tcGlsZSB0ZXN0aW5nIHRoaXMgYXJjaGl0ZWN0dXJlcyBvdGhlciB0
aGFuIDY0LWJpdCB4ODYuCgpDYzogSsOpcsO0bWUgR2xpc3NlIDxqZ2xpc3NlQHJlZGhhdC5jb20+
CkNjOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BtZWxsYW5veC5jb20+ClJlcG9ydGVkLWJ5OiBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KU2lnbmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxk
YW4uai53aWxsaWFtc0BpbnRlbC5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Iv
MTU2MDk3MjI0MjMyLjEwODY4NDcuOTQ2Mzg2MTkyNDY4MzM3Mjc0MS5zdGdpdEBkd2lsbGlhMi1k
ZXNrMy5hbXIuY29ycC5pbnRlbC5jb20KLS0tCkNoYW5nZXMgc2luY2UgdjM6CgotIFN3aXRjaCB0
aGUgTWFrZWZpbGUgb3BlcmF0b3IgZnJvbSA6PSB0byArPSB0byBtYWtlIHN1cmUgdGhlIHVuaXQg
dGVzdAogIGluZnJhc3RydWN0dXJlIGlzIGluY3JlbWVudGFsbHkgaW5jbHVkZWQuCgpKYXNvbiwg
bGV0cyB0cnkgdGhpcyBhZ2Fpbi4gVGhpcyBzZWVtcyB0byByZXNvbHZlIHRoZSBidWlsZCBlcnJv
ciBmb3IKbWUuIEkgYmVsaWV2ZSAiOj0iIHdvdWxkIGhhdmUgaW50ZXJtaXR0ZW50IHJlc3VsdHMg
aW4gYSBwYXJhbGxlbCBidWlsZAphbmQgc29tZXRpbWVzIHJlc3VsdCBpbiBvdGhlciB0YXJnZXRz
IGluIGRyaXZlcnMvbnZkaW1tL01ha2VmaWxlIGJlaW5nCmJ5cGFzc2VkLiBUaGlzIGhhcyBiZWVu
IGV4cG9zZWQgdG8gdGhlIDBkYXkgcm9ib3QgZm9yIGEgZGF5IHdpdGggbm8KcmVwb3J0cy4KCgog
ZHJpdmVycy9udmRpbW0vS2NvbmZpZyAgfCAgIDEyICsrKysrKysrKysrKwogZHJpdmVycy9udmRp
bW0vTWFrZWZpbGUgfCAgICA0ICsrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL0tjb25maWcgYi9kcml2ZXJzL252ZGltbS9L
Y29uZmlnCmluZGV4IGE1ZmRlMTVlOTFkMy4uMzZhZjdhZjZiN2NmIDEwMDY0NAotLS0gYS9kcml2
ZXJzL252ZGltbS9LY29uZmlnCisrKyBiL2RyaXZlcnMvbnZkaW1tL0tjb25maWcKQEAgLTExOCw0
ICsxMTgsMTYgQEAgY29uZmlnIE5WRElNTV9LRVlTCiAJZGVwZW5kcyBvbiBFTkNSWVBURURfS0VZ
UwogCWRlcGVuZHMgb24gKExJQk5WRElNTT1FTkNSWVBURURfS0VZUykgfHwgTElCTlZESU1NPW0K
IAorY29uZmlnIE5WRElNTV9URVNUX0JVSUxECisJdHJpc3RhdGUgIkJ1aWxkIHRoZSB1bml0IHRl
c3QgY29yZSIKKwlkZXBlbmRzIG9uIG0KKwlkZXBlbmRzIG9uIENPTVBJTEVfVEVTVCAmJiBYODZf
NjQKKwlkZWZhdWx0IG0gaWYgQ09NUElMRV9URVNUCisJaGVscAorCSAgQnVpbGQgdGhlIGNvcmUg
b2YgdGhlIHVuaXQgdGVzdCBpbmZyYXN0cnVjdHVyZS4gVGhlIHJlc3VsdCBvZgorCSAgdGhpcyBi
dWlsZCBpcyBub24tZnVuY3Rpb25hbCBmb3IgdW5pdCB0ZXN0IGV4ZWN1dGlvbiwgYnV0IGl0CisJ
ICBvdGhlcndpc2UgaGVscHMgY2F0Y2ggYnVpbGQgZXJyb3JzIGluZHVjZWQgYnkgY2hhbmdlcyB0
byB0aGUKKwkgIGNvcmUgZGV2bV9tZW1yZW1hcF9wYWdlcygpIGltcGxlbWVudGF0aW9uIGFuZCBv
dGhlcgorCSAgaW5mcmFzdHJ1Y3R1cmUuCisKIGVuZGlmCmRpZmYgLS1naXQgYS9kcml2ZXJzL252
ZGltbS9NYWtlZmlsZSBiL2RyaXZlcnMvbnZkaW1tL01ha2VmaWxlCmluZGV4IGNlZmUyMzNlMGI1
Mi4uMjkyMDNmM2QzMDY5IDEwMDY0NAotLS0gYS9kcml2ZXJzL252ZGltbS9NYWtlZmlsZQorKysg
Yi9kcml2ZXJzL252ZGltbS9NYWtlZmlsZQpAQCAtMjksMyArMjksNyBAQCBsaWJudmRpbW0tJChD
T05GSUdfQlRUKSArPSBidHRfZGV2cy5vCiBsaWJudmRpbW0tJChDT05GSUdfTlZESU1NX1BGTikg
Kz0gcGZuX2RldnMubwogbGlibnZkaW1tLSQoQ09ORklHX05WRElNTV9EQVgpICs9IGRheF9kZXZz
Lm8KIGxpYm52ZGltbS0kKENPTkZJR19OVkRJTU1fS0VZUykgKz0gc2VjdXJpdHkubworCitUT09M
UyA6PSAuLi8uLi90b29scworVEVTVF9TUkMgOj0gJChUT09MUykvdGVzdGluZy9udmRpbW0vdGVz
dAorb2JqLSQoQ09ORklHX05WRElNTV9URVNUX0JVSUxEKSArPSAkKFRFU1RfU1JDKS9pb21hcC5v
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0
cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udmRpbW0K
