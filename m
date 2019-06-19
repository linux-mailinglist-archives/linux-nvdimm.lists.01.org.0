Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242AE4C198
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Jun 2019 21:39:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E007821296B08;
	Wed, 19 Jun 2019 12:39:06 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1E09B2194EB70
 for <linux-nvdimm@lists.01.org>; Wed, 19 Jun 2019 12:39:05 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Jun 2019 12:39:05 -0700
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; d="scan'208";a="162306711"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Jun 2019 12:39:05 -0700
Subject: [PATCH v2] libnvdimm: Enable unit test infrastructure compile checks
From: Dan Williams <dan.j.williams@intel.com>
To: hch@lst.de
Date: Wed, 19 Jun 2019 12:24:48 -0700
Message-ID: <156097224232.1086847.9463861924683372741.stgit@dwillia2-desk3.amr.corp.intel.com>
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
 Jason Gunthorpe <jgg@mellanox.com>, linux-kernel@vger.kernel.org,
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
YW4uai53aWxsaWFtc0BpbnRlbC5jb20+Ci0tLQpDaGFuZ2VzIHNpbmNlIHYxOgotIDBkYXkgcmVw
b3J0cyB0aGlzIGZhaWxzIHRvIGNvbXBpbGUgb24gIXg4NiB3aGljaCBpcyBub3Qgc3VycHJpc2lu
Zy4KICBKdXN0IGRpc2FibGUgbm9uLXg4NiBidWlsZHMuCgogZHJpdmVycy9udmRpbW0vS2NvbmZp
ZyAgfCAgIDExICsrKysrKysrKysrCiBkcml2ZXJzL252ZGltbS9NYWtlZmlsZSB8ICAgIDQgKysr
KwogMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9udmRpbW0vS2NvbmZpZyBiL2RyaXZlcnMvbnZkaW1tL0tjb25maWcKaW5kZXggNTQ1MDA3OThm
MjNhLi5mNjYyM2U4MDdmYjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZkaW1tL0tjb25maWcKKysr
IGIvZHJpdmVycy9udmRpbW0vS2NvbmZpZwpAQCAtMTE4LDQgKzExOCwxNSBAQCBjb25maWcgTlZE
SU1NX0tFWVMKIAlkZXBlbmRzIG9uIEVOQ1JZUFRFRF9LRVlTCiAJZGVwZW5kcyBvbiAoTElCTlZE
SU1NPUVOQ1JZUFRFRF9LRVlTKSB8fCBMSUJOVkRJTU09bQogCitjb25maWcgTlZESU1NX1RFU1Rf
QlVJTEQKKwlib29sICJCdWlsZCB0aGUgdW5pdCB0ZXN0IGNvcmUiCisJZGVwZW5kcyBvbiBDT01Q
SUxFX1RFU1QgJiYgWDg2XzY0CisJZGVmYXVsdCBDT01QSUxFX1RFU1QKKwloZWxwCisJICBCdWls
ZCB0aGUgY29yZSBvZiB0aGUgdW5pdCB0ZXN0IGluZnJhc3RydWN0dXJlLiAgVGhlIHJlc3VsdCBv
ZgorCSAgdGhpcyBidWlsZCBpcyBub24tZnVuY3Rpb25hbCBmb3IgdW5pdCB0ZXN0IGV4ZWN1dGlv
biwgYnV0IGl0CisJICBvdGhlcndpc2UgaGVscHMgY2F0Y2ggYnVpbGQgZXJyb3JzIGluZHVjZWQg
YnkgY2hhbmdlcyB0byB0aGUKKwkgIGNvcmUgZGV2bV9tZW1yZW1hcF9wYWdlcygpIGltcGxlbWVu
dGF0aW9uIGFuZCBvdGhlcgorCSAgaW5mcmFzdHJ1Y3R1cmUuCisKIGVuZGlmCmRpZmYgLS1naXQg
YS9kcml2ZXJzL252ZGltbS9NYWtlZmlsZSBiL2RyaXZlcnMvbnZkaW1tL01ha2VmaWxlCmluZGV4
IDZmMmEwODhhZmFkNi4uNDAwODBjMTIwMzYzIDEwMDY0NAotLS0gYS9kcml2ZXJzL252ZGltbS9N
YWtlZmlsZQorKysgYi9kcml2ZXJzL252ZGltbS9NYWtlZmlsZQpAQCAtMjgsMyArMjgsNyBAQCBs
aWJudmRpbW0tJChDT05GSUdfQlRUKSArPSBidHRfZGV2cy5vCiBsaWJudmRpbW0tJChDT05GSUdf
TlZESU1NX1BGTikgKz0gcGZuX2RldnMubwogbGlibnZkaW1tLSQoQ09ORklHX05WRElNTV9EQVgp
ICs9IGRheF9kZXZzLm8KIGxpYm52ZGltbS0kKENPTkZJR19OVkRJTU1fS0VZUykgKz0gc2VjdXJp
dHkubworCitUT09MUyA6PSAuLi8uLi90b29scworVEVTVF9TUkMgOj0gJChUT09MUykvdGVzdGlu
Zy9udmRpbW0vdGVzdAorb2JqLSQoQ09ORklHX05WRElNTV9URVNUX0JVSUxEKSA6PSAkKFRFU1Rf
U1JDKS9pb21hcC5vCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcK
aHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udmRpbW0K
