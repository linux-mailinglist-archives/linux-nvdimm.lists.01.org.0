Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E198A45D7
	for <lists+linux-nvdimm@lfdr.de>; Sat, 31 Aug 2019 21:07:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 033B120251A04;
	Sat, 31 Aug 2019 12:08:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E794D2020D32A
 for <linux-nvdimm@lists.01.org>; Sat, 31 Aug 2019 12:08:41 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Aug 2019 12:07:05 -0700
X-IronPort-AV: E=Sophos;i="5.64,451,1559545200"; d="scan'208";a="206430450"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Aug 2019 12:07:05 -0700
Subject: [PATCH v3] libnvdimm: Enable unit test infrastructure compile checks
From: Dan Williams <dan.j.williams@intel.com>
To: jgg@ziepe.ca
Date: Sat, 31 Aug 2019 11:52:47 -0700
Message-ID: <156727753022.2310789.16427613406082399871.stgit@dwillia2-desk3.amr.corp.intel.com>
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
ZXNrMy5hbXIuY29ycC5pbnRlbC5jb20KLS0tCkNoYW5nZXMgc2luY2UgdjI6Ci0gRml4ZWQgYSAw
ZGF5IHJlcG9ydCB3aGVuIHRoZSB1bml0IHRlc3QgaW5mcmFzdHJ1Y3R1cmUgaXMgYnVpbHQtaW4u
CiAgQXJyYW5nZSBmb3IgaXQgdG8gb25seSBjb21waWxlIGFzIGEgbW9kdWxlLiBUaGlzIGhhcyBy
ZWNlaXZlZCBhIGJ1aWxkCiAgc3VjY2VzcyBub3RpZmNhdGlvbiBmcm9tIHRoZSByb2JvdCBvdmVy
IDE0MiBjb25maWdzLgoKSGkgSmFzb24sCgpBcyB3ZSBkaXNjdXNzZWQgcHJldmlvdXNseSBwbGVh
c2UgdGFrZSB0aGlzIHRocm91Z2ggdGhlIGhtbSB0cmVlIHRvIGdpdmUKY29tcGlsZSBjb3ZlcmFn
ZSBmb3IgZGV2bV9tZW1yZW1hcF9wYWdlcygpIHVwZGF0ZXMuCgogZHJpdmVycy9udmRpbW0vS2Nv
bmZpZyAgfCAgIDEyICsrKysrKysrKysrKwogZHJpdmVycy9udmRpbW0vTWFrZWZpbGUgfCAgICA0
ICsrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZkaW1tL0tjb25maWcgYi9kcml2ZXJzL252ZGltbS9LY29uZmlnCmluZGV4IGE1ZmRl
MTVlOTFkMy4uMzZhZjdhZjZiN2NmIDEwMDY0NAotLS0gYS9kcml2ZXJzL252ZGltbS9LY29uZmln
CisrKyBiL2RyaXZlcnMvbnZkaW1tL0tjb25maWcKQEAgLTExOCw0ICsxMTgsMTYgQEAgY29uZmln
IE5WRElNTV9LRVlTCiAJZGVwZW5kcyBvbiBFTkNSWVBURURfS0VZUwogCWRlcGVuZHMgb24gKExJ
Qk5WRElNTT1FTkNSWVBURURfS0VZUykgfHwgTElCTlZESU1NPW0KIAorY29uZmlnIE5WRElNTV9U
RVNUX0JVSUxECisJdHJpc3RhdGUgIkJ1aWxkIHRoZSB1bml0IHRlc3QgY29yZSIKKwlkZXBlbmRz
IG9uIG0KKwlkZXBlbmRzIG9uIENPTVBJTEVfVEVTVCAmJiBYODZfNjQKKwlkZWZhdWx0IG0gaWYg
Q09NUElMRV9URVNUCisJaGVscAorCSAgQnVpbGQgdGhlIGNvcmUgb2YgdGhlIHVuaXQgdGVzdCBp
bmZyYXN0cnVjdHVyZS4gVGhlIHJlc3VsdCBvZgorCSAgdGhpcyBidWlsZCBpcyBub24tZnVuY3Rp
b25hbCBmb3IgdW5pdCB0ZXN0IGV4ZWN1dGlvbiwgYnV0IGl0CisJICBvdGhlcndpc2UgaGVscHMg
Y2F0Y2ggYnVpbGQgZXJyb3JzIGluZHVjZWQgYnkgY2hhbmdlcyB0byB0aGUKKwkgIGNvcmUgZGV2
bV9tZW1yZW1hcF9wYWdlcygpIGltcGxlbWVudGF0aW9uIGFuZCBvdGhlcgorCSAgaW5mcmFzdHJ1
Y3R1cmUuCisKIGVuZGlmCmRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9NYWtlZmlsZSBiL2Ry
aXZlcnMvbnZkaW1tL01ha2VmaWxlCmluZGV4IGNlZmUyMzNlMGI1Mi4uNjU1N2UxMjY4OTJmIDEw
MDY0NAotLS0gYS9kcml2ZXJzL252ZGltbS9NYWtlZmlsZQorKysgYi9kcml2ZXJzL252ZGltbS9N
YWtlZmlsZQpAQCAtMjksMyArMjksNyBAQCBsaWJudmRpbW0tJChDT05GSUdfQlRUKSArPSBidHRf
ZGV2cy5vCiBsaWJudmRpbW0tJChDT05GSUdfTlZESU1NX1BGTikgKz0gcGZuX2RldnMubwogbGli
bnZkaW1tLSQoQ09ORklHX05WRElNTV9EQVgpICs9IGRheF9kZXZzLm8KIGxpYm52ZGltbS0kKENP
TkZJR19OVkRJTU1fS0VZUykgKz0gc2VjdXJpdHkubworCitUT09MUyA6PSAuLi8uLi90b29scwor
VEVTVF9TUkMgOj0gJChUT09MUykvdGVzdGluZy9udmRpbW0vdGVzdAorb2JqLSQoQ09ORklHX05W
RElNTV9URVNUX0JVSUxEKSA6PSAkKFRFU1RfU1JDKS9pb21hcC5vCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0
CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udmRpbW0K
