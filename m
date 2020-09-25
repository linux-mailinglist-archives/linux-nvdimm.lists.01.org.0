Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7BD27917A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Sep 2020 21:31:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E320215508B0C;
	Fri, 25 Sep 2020 12:31:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ABC1C154F001A
	for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 12:31:04 -0700 (PDT)
IronPort-SDR: QIwm/Oy+tLHFGdIII0/Voc3RGPtmARlb+X3supjAizAlD60ThvM3VbtQYmRayQnyOr6z29FuoQ
 h9jPFH+VuD2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="160874711"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400";
   d="scan'208";a="160874711"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:31:04 -0700
IronPort-SDR: wDDUO0IwgemsmCuNDE3buJ2kW4ZQSpGnWPcgSTUk4v9QcS8b85PXyswDC27AjJI6pce41UpQjf
 4YuL0SpBvPWg==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400";
   d="scan'208";a="413980405"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:31:03 -0700
Subject: [PATCH v5 11/17] mm/memremap_pages: support multiple ranges per
 invocation
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Fri, 25 Sep 2020 12:12:43 -0700
Message-ID: <160106116293.30709.13350662794915396198.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID-Hash: OGJ663AQVQHTXK5Q2E3X5R25JCWJ7YLZ
X-Message-ID-Hash: OGJ663AQVQHTXK5Q2E3X5R25JCWJ7YLZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, dave.hansen@linux.intel.com, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OGJ663AQVQHTXK5Q2E3X5R25JCWJ7YLZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

SW4gc3VwcG9ydCBvZiBkZXZpY2UtZGF4IGdyb3dpbmcgdGhlIGFiaWxpdHkgdG8gZnJvbnQgcGh5
c2ljYWxseQ0KZGlzLWNvbnRpZ3VvdXMgcmFuZ2VzIG9mIG1lbW9yeSwgdXBkYXRlIGRldm1fbWVt
cmVtYXBfcGFnZXMoKSB0byB0cmFjaw0KbXVsdGlwbGUgcmFuZ2VzIHdpdGggYSBzaW5nbGUgcmVm
ZXJlbmNlIGNvdW50ZXIgYW5kIGRldm0gaW5zdGFuY2UuDQoNCkNvbnZlcnQgYWxsIFtkZXZtX11t
ZW1yZW1hcF9wYWdlcygpIHVzZXJzIHRvIHNwZWNpZnkgdGhlIG51bWJlciBvZg0KcmFuZ2VzIHRo
ZXkgYXJlIG1hcHBpbmcgaW4gdGhlaXIgJ3N0cnVjdCBkZXZfcGFnZW1hcCcgaW5zdGFuY2UuDQoN
Ckxpbms6IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMTU5NjQzMTAzNzg5LjQwNjIzMDIuMTg0
MjYxMjgxNzAyMTc5MDM3ODUuc3RnaXRAZHdpbGxpYTItZGVzazMuYW1yLmNvcnAuaW50ZWwuY29t
DQpDYzogUGF1bCBNYWNrZXJyYXMgPHBhdWx1c0BvemxhYnMub3JnPg0KQ2M6IE1pY2hhZWwgRWxs
ZXJtYW4gPG1wZUBlbGxlcm1hbi5pZC5hdT4NCkNjOiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0IDxi
ZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+DQpDYzogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJt
YUBpbnRlbC5jb20+DQpDYzogVml2ZWsgR295YWwgPHZnb3lhbEByZWRoYXQuY29tPg0KQ2M6IERh
dmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPg0KQ2M6IEJlbiBTa2VnZ3MgPGJza2VnZ3NA
cmVkaGF0LmNvbT4NCkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+DQpDYzogRGFu
aWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPg0KQ2M6IElyYSBXZWlueSA8aXJhLndlaW55QGlu
dGVsLmNvbT4NCkNjOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KQ2M6IEJv
cmlzIE9zdHJvdnNreSA8Ym9yaXMub3N0cm92c2t5QG9yYWNsZS5jb20+DQpDYzogSnVlcmdlbiBH
cm9zcyA8amdyb3NzQHN1c2UuY29tPg0KQ2M6IFN0ZWZhbm8gU3RhYmVsbGluaSA8c3N0YWJlbGxp
bmlAa2VybmVsLm9yZz4NCkNjOiAiSsOpcsO0bWUgR2xpc3NlIiA8amdsaXNzZUByZWRoYXQuY29t
Pg0KQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQpTaWduZWQt
b2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCi0tLQ0KIGFy
Y2gvcG93ZXJwYy9rdm0vYm9vazNzX2h2X3V2bWVtLmMgICAgIHwgICAgMSANCiBkcml2ZXJzL2Rh
eC9kZXZpY2UuYyAgICAgICAgICAgICAgICAgICB8ICAgIDEgDQogZHJpdmVycy9ncHUvZHJtL25v
dXZlYXUvbm91dmVhdV9kbWVtLmMgfCAgICAxIA0KIGRyaXZlcnMvbnZkaW1tL3Bmbl9kZXZzLmMg
ICAgICAgICAgICAgIHwgICAgMSANCiBkcml2ZXJzL252ZGltbS9wbWVtLmMgICAgICAgICAgICAg
ICAgICB8ICAgIDEgDQogZHJpdmVycy9wY2kvcDJwZG1hLmMgICAgICAgICAgICAgICAgICAgfCAg
ICAxIA0KIGRyaXZlcnMveGVuL3VucG9wdWxhdGVkLWFsbG9jLmMgICAgICAgIHwgICAgMSANCiBp
bmNsdWRlL2xpbnV4L21lbXJlbWFwLmggICAgICAgICAgICAgICB8ICAgMTAgKw0KIGxpYi90ZXN0
X2htbS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSANCiBtbS9tZW1yZW1hcC5jICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAyNTggKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0NCiAxMCBmaWxlcyBjaGFuZ2VkLCAxNjYgaW5zZXJ0aW9ucygrKSwgMTEwIGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2t2bS9ib29rM3NfaHZfdXZtZW0uYyBi
L2FyY2gvcG93ZXJwYy9rdm0vYm9vazNzX2h2X3V2bWVtLmMNCmluZGV4IDI5ZWM1NTUwNTVjMi4u
ODRlNWEyZGM4YmU1IDEwMDY0NA0KLS0tIGEvYXJjaC9wb3dlcnBjL2t2bS9ib29rM3NfaHZfdXZt
ZW0uYw0KKysrIGIvYXJjaC9wb3dlcnBjL2t2bS9ib29rM3NfaHZfdXZtZW0uYw0KQEAgLTExNzIs
NiArMTE3Miw3IEBAIGludCBrdm1wcGNfdXZtZW1faW5pdCh2b2lkKQ0KIAlrdm1wcGNfdXZtZW1f
cGdtYXAudHlwZSA9IE1FTU9SWV9ERVZJQ0VfUFJJVkFURTsNCiAJa3ZtcHBjX3V2bWVtX3BnbWFw
LnJhbmdlLnN0YXJ0ID0gcmVzLT5zdGFydDsNCiAJa3ZtcHBjX3V2bWVtX3BnbWFwLnJhbmdlLmVu
ZCA9IHJlcy0+ZW5kOw0KKwlrdm1wcGNfdXZtZW1fcGdtYXAubnJfcmFuZ2UgPSAxOw0KIAlrdm1w
cGNfdXZtZW1fcGdtYXAub3BzID0gJmt2bXBwY191dm1lbV9vcHM7DQogCS8qIGp1c3Qgb25lIGds
b2JhbCBpbnN0YW5jZTogKi8NCiAJa3ZtcHBjX3V2bWVtX3BnbWFwLm93bmVyID0gJmt2bXBwY191
dm1lbV9wZ21hcDsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RheC9kZXZpY2UuYyBiL2RyaXZlcnMv
ZGF4L2RldmljZS5jDQppbmRleCBhMTQ0NDhiY2E4M2QuLjVmODA4NjE3NjcyYSAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvZGF4L2RldmljZS5jDQorKysgYi9kcml2ZXJzL2RheC9kZXZpY2UuYw0KQEAg
LTQxNyw2ICs0MTcsNyBAQCBpbnQgZGV2X2RheF9wcm9iZShzdHJ1Y3QgZGV2X2RheCAqZGV2X2Rh
eCkNCiAJCWlmICghcGdtYXApDQogCQkJcmV0dXJuIC1FTk9NRU07DQogCQlwZ21hcC0+cmFuZ2Ug
PSAqcmFuZ2U7DQorCQlwZ21hcC0+bnJfcmFuZ2UgPSAxOw0KIAl9DQogCXBnbWFwLT50eXBlID0g
TUVNT1JZX0RFVklDRV9HRU5FUklDOw0KIAlhZGRyID0gZGV2bV9tZW1yZW1hcF9wYWdlcyhkZXYs
IHBnbWFwKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1X2Rt
ZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfZG1lbS5jDQppbmRleCAyNTgx
MWVkN2UyNzQuLmExM2M2MjE1YmJhOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9ub3V2
ZWF1L25vdXZlYXVfZG1lbS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1
X2RtZW0uYw0KQEAgLTI1MSw2ICsyNTEsNyBAQCBub3V2ZWF1X2RtZW1fY2h1bmtfYWxsb2Moc3Ry
dWN0IG5vdXZlYXVfZHJtICpkcm0sIHN0cnVjdCBwYWdlICoqcHBhZ2UpDQogCWNodW5rLT5wYWdl
bWFwLnR5cGUgPSBNRU1PUllfREVWSUNFX1BSSVZBVEU7DQogCWNodW5rLT5wYWdlbWFwLnJhbmdl
LnN0YXJ0ID0gcmVzLT5zdGFydDsNCiAJY2h1bmstPnBhZ2VtYXAucmFuZ2UuZW5kID0gcmVzLT5l
bmQ7DQorCWNodW5rLT5wYWdlbWFwLm5yX3JhbmdlID0gMTsNCiAJY2h1bmstPnBhZ2VtYXAub3Bz
ID0gJm5vdXZlYXVfZG1lbV9wYWdlbWFwX29wczsNCiAJY2h1bmstPnBhZ2VtYXAub3duZXIgPSBk
cm0tPmRldjsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9wZm5fZGV2cy5jIGIvZHJp
dmVycy9udmRpbW0vcGZuX2RldnMuYw0KaW5kZXggM2M0Nzg3YjkyYTZhLi5iNDk5ZGY2MzBkNGQg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL252ZGltbS9wZm5fZGV2cy5jDQorKysgYi9kcml2ZXJzL252
ZGltbS9wZm5fZGV2cy5jDQpAQCAtNjkzLDYgKzY5Myw3IEBAIHN0YXRpYyBpbnQgX19udmRpbW1f
c2V0dXBfcGZuKHN0cnVjdCBuZF9wZm4gKm5kX3Bmbiwgc3RydWN0IGRldl9wYWdlbWFwICpwZ21h
cCkNCiAJCS5zdGFydCA9IG5zaW8tPnJlcy5zdGFydCArIHN0YXJ0X3BhZCwNCiAJCS5lbmQgPSBu
c2lvLT5yZXMuZW5kIC0gZW5kX3RydW5jLA0KIAl9Ow0KKwlwZ21hcC0+bnJfcmFuZ2UgPSAxOw0K
IAlpZiAobmRfcGZuLT5tb2RlID09IFBGTl9NT0RFX1JBTSkgew0KIAkJaWYgKG9mZnNldCA8IHJl
c2VydmUpDQogCQkJcmV0dXJuIC1FSU5WQUw7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udmRpbW0v
cG1lbS5jIGIvZHJpdmVycy9udmRpbW0vcG1lbS5jDQppbmRleCA2OWNjMGU3ODM3MDkuLjFmNDVh
ZjM2M2E5NCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnZkaW1tL3BtZW0uYw0KKysrIGIvZHJpdmVy
cy9udmRpbW0vcG1lbS5jDQpAQCAtNDQyLDYgKzQ0Miw3IEBAIHN0YXRpYyBpbnQgcG1lbV9hdHRh
Y2hfZGlzayhzdHJ1Y3QgZGV2aWNlICpkZXYsDQogCX0gZWxzZSBpZiAocG1lbV9zaG91bGRfbWFw
X3BhZ2VzKGRldikpIHsNCiAJCXBtZW0tPnBnbWFwLnJhbmdlLnN0YXJ0ID0gcmVzLT5zdGFydDsN
CiAJCXBtZW0tPnBnbWFwLnJhbmdlLmVuZCA9IHJlcy0+ZW5kOw0KKwkJcG1lbS0+cGdtYXAubnJf
cmFuZ2UgPSAxOw0KIAkJcG1lbS0+cGdtYXAudHlwZSA9IE1FTU9SWV9ERVZJQ0VfRlNfREFYOw0K
IAkJcG1lbS0+cGdtYXAub3BzID0gJmZzZGF4X3BhZ2VtYXBfb3BzOw0KIAkJYWRkciA9IGRldm1f
bWVtcmVtYXBfcGFnZXMoZGV2LCAmcG1lbS0+cGdtYXApOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL3AycGRtYS5jIGIvZHJpdmVycy9wY2kvcDJwZG1hLmMNCmluZGV4IDI1Njg1MDUxMzgxMy4u
OWQ1M2MxNmI3MzI5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wY2kvcDJwZG1hLmMNCisrKyBiL2Ry
aXZlcnMvcGNpL3AycGRtYS5jDQpAQCAtMTg3LDYgKzE4Nyw3IEBAIGludCBwY2lfcDJwZG1hX2Fk
ZF9yZXNvdXJjZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgaW50IGJhciwgc2l6ZV90IHNpemUsDQog
CXBnbWFwID0gJnAycF9wZ21hcC0+cGdtYXA7DQogCXBnbWFwLT5yYW5nZS5zdGFydCA9IHBjaV9y
ZXNvdXJjZV9zdGFydChwZGV2LCBiYXIpICsgb2Zmc2V0Ow0KIAlwZ21hcC0+cmFuZ2UuZW5kID0g
cGdtYXAtPnJhbmdlLnN0YXJ0ICsgc2l6ZSAtIDE7DQorCXBnbWFwLT5ucl9yYW5nZSA9IDE7DQog
CXBnbWFwLT50eXBlID0gTUVNT1JZX0RFVklDRV9QQ0lfUDJQRE1BOw0KIA0KIAlwMnBfcGdtYXAt
PnByb3ZpZGVyID0gcGRldjsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi91bnBvcHVsYXRlZC1h
bGxvYy5jIGIvZHJpdmVycy94ZW4vdW5wb3B1bGF0ZWQtYWxsb2MuYw0KaW5kZXggMDkxYjg2Njll
Y2EzLi44YzUxMmVhNTUwYmIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3hlbi91bnBvcHVsYXRlZC1h
bGxvYy5jDQorKysgYi9kcml2ZXJzL3hlbi91bnBvcHVsYXRlZC1hbGxvYy5jDQpAQCAtNDcsNiAr
NDcsNyBAQCBzdGF0aWMgaW50IGZpbGxfbGlzdCh1bnNpZ25lZCBpbnQgbnJfcGFnZXMpDQogCQku
c3RhcnQgPSByZXMtPnN0YXJ0LA0KIAkJLmVuZCA9IHJlcy0+ZW5kLA0KIAl9Ow0KKwlwZ21hcC0+
bnJfcmFuZ2UgPSAxOw0KIAlwZ21hcC0+b3duZXIgPSByZXM7DQogDQogI2lmZGVmIENPTkZJR19Y
RU5fSEFWRV9QVk1NVQ0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaCBiL2lu
Y2x1ZGUvbGludXgvbWVtcmVtYXAuaA0KaW5kZXggMzc1YjllODdhNWNmLi44NmM2YzM2OGNlOWIg
MTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L21lbXJlbWFwLmgNCisrKyBiL2luY2x1ZGUvbGlu
dXgvbWVtcmVtYXAuaA0KQEAgLTk0LDcgKzk0LDYgQEAgc3RydWN0IGRldl9wYWdlbWFwX29wcyB7
DQogLyoqDQogICogc3RydWN0IGRldl9wYWdlbWFwIC0gbWV0YWRhdGEgZm9yIFpPTkVfREVWSUNF
IG1hcHBpbmdzDQogICogQGFsdG1hcDogcHJlLWFsbG9jYXRlZC9yZXNlcnZlZCBtZW1vcnkgZm9y
IHZtZW1tYXAgYWxsb2NhdGlvbnMNCi0gKiBAcmFuZ2U6IHBoeXNpY2FsIGFkZHJlc3MgcmFuZ2Ug
Y292ZXJlZCBieSBAcmVmDQogICogQHJlZjogcmVmZXJlbmNlIGNvdW50IHRoYXQgcGlucyB0aGUg
ZGV2bV9tZW1yZW1hcF9wYWdlcygpIG1hcHBpbmcNCiAgKiBAaW50ZXJuYWxfcmVmOiBpbnRlcm5h
bCByZWZlcmVuY2UgaWYgQHJlZiBpcyBub3QgcHJvdmlkZWQgYnkgdGhlIGNhbGxlcg0KICAqIEBk
b25lOiBjb21wbGV0aW9uIGZvciBAaW50ZXJuYWxfcmVmDQpAQCAtMTA0LDEwICsxMDMsMTIgQEAg
c3RydWN0IGRldl9wYWdlbWFwX29wcyB7DQogICogQG93bmVyOiBhbiBvcGFxdWUgcG9pbnRlciBp
ZGVudGlmeWluZyB0aGUgZW50aXR5IHRoYXQgbWFuYWdlcyB0aGlzDQogICoJaW5zdGFuY2UuICBV
c2VkIGJ5IHZhcmlvdXMgaGVscGVycyB0byBtYWtlIHN1cmUgdGhhdCBubw0KICAqCWZvcmVpZ24g
Wk9ORV9ERVZJQ0UgbWVtb3J5IGlzIGFjY2Vzc2VkLg0KKyAqIEBucl9yYW5nZTogbnVtYmVyIG9m
IHJhbmdlcyB0byBiZSBtYXBwZWQNCisgKiBAcmFuZ2U6IHJhbmdlIHRvIGJlIG1hcHBlZCB3aGVu
IG5yX3JhbmdlID09IDENCisgKiBAcmFuZ2VzOiBhcnJheSBvZiByYW5nZXMgdG8gYmUgbWFwcGVk
IHdoZW4gbnJfcmFuZ2UgPiAxDQogICovDQogc3RydWN0IGRldl9wYWdlbWFwIHsNCiAJc3RydWN0
IHZtZW1fYWx0bWFwIGFsdG1hcDsNCi0Jc3RydWN0IHJhbmdlIHJhbmdlOw0KIAlzdHJ1Y3QgcGVy
Y3B1X3JlZiAqcmVmOw0KIAlzdHJ1Y3QgcGVyY3B1X3JlZiBpbnRlcm5hbF9yZWY7DQogCXN0cnVj
dCBjb21wbGV0aW9uIGRvbmU7DQpAQCAtMTE1LDYgKzExNiwxMSBAQCBzdHJ1Y3QgZGV2X3BhZ2Vt
YXAgew0KIAl1bnNpZ25lZCBpbnQgZmxhZ3M7DQogCWNvbnN0IHN0cnVjdCBkZXZfcGFnZW1hcF9v
cHMgKm9wczsNCiAJdm9pZCAqb3duZXI7DQorCWludCBucl9yYW5nZTsNCisJdW5pb24gew0KKwkJ
c3RydWN0IHJhbmdlIHJhbmdlOw0KKwkJc3RydWN0IHJhbmdlIHJhbmdlc1swXTsNCisJfTsNCiB9
Ow0KIA0KIHN0YXRpYyBpbmxpbmUgc3RydWN0IHZtZW1fYWx0bWFwICpwZ21hcF9hbHRtYXAoc3Ry
dWN0IGRldl9wYWdlbWFwICpwZ21hcCkNCmRpZmYgLS1naXQgYS9saWIvdGVzdF9obW0uYyBiL2xp
Yi90ZXN0X2htbS5jDQppbmRleCA1YjQ1MjE5OTE2MjEuLmUzMDY1ZDYxMjNmMCAxMDA2NDQNCi0t
LSBhL2xpYi90ZXN0X2htbS5jDQorKysgYi9saWIvdGVzdF9obW0uYw0KQEAgLTQ4OSw2ICs0ODks
NyBAQCBzdGF0aWMgYm9vbCBkbWlycm9yX2FsbG9jYXRlX2NodW5rKHN0cnVjdCBkbWlycm9yX2Rl
dmljZSAqbWRldmljZSwNCiAJZGV2bWVtLT5wYWdlbWFwLnR5cGUgPSBNRU1PUllfREVWSUNFX1BS
SVZBVEU7DQogCWRldm1lbS0+cGFnZW1hcC5yYW5nZS5zdGFydCA9IHJlcy0+c3RhcnQ7DQogCWRl
dm1lbS0+cGFnZW1hcC5yYW5nZS5lbmQgPSByZXMtPmVuZDsNCisJZGV2bWVtLT5wYWdlbWFwLm5y
X3JhbmdlID0gMTsNCiAJZGV2bWVtLT5wYWdlbWFwLm9wcyA9ICZkbWlycm9yX2Rldm1lbV9vcHM7
DQogCWRldm1lbS0+cGFnZW1hcC5vd25lciA9IG1kZXZpY2U7DQogDQpkaWZmIC0tZ2l0IGEvbW0v
bWVtcmVtYXAuYyBiL21tL21lbXJlbWFwLmMNCmluZGV4IDdjODk1ZTE0NzdiMC4uMjgyODQ5ZjJl
MzE5IDEwMDY0NA0KLS0tIGEvbW0vbWVtcmVtYXAuYw0KKysrIGIvbW0vbWVtcmVtYXAuYw0KQEAg
LTc3LDE1ICs3NywxOSBAQCBzdGF0aWMgdm9pZCBwZ21hcF9hcnJheV9kZWxldGUoc3RydWN0IHJh
bmdlICpyYW5nZSkNCiAJc3luY2hyb25pemVfcmN1KCk7DQogfQ0KIA0KLXN0YXRpYyB1bnNpZ25l
ZCBsb25nIHBmbl9maXJzdChzdHJ1Y3QgZGV2X3BhZ2VtYXAgKnBnbWFwKQ0KK3N0YXRpYyB1bnNp
Z25lZCBsb25nIHBmbl9maXJzdChzdHJ1Y3QgZGV2X3BhZ2VtYXAgKnBnbWFwLCBpbnQgcmFuZ2Vf
aWQpDQogew0KLQlyZXR1cm4gUEhZU19QRk4ocGdtYXAtPnJhbmdlLnN0YXJ0KSArDQotCQl2bWVt
X2FsdG1hcF9vZmZzZXQocGdtYXBfYWx0bWFwKHBnbWFwKSk7DQorCXN0cnVjdCByYW5nZSAqcmFu
Z2UgPSAmcGdtYXAtPnJhbmdlc1tyYW5nZV9pZF07DQorCXVuc2lnbmVkIGxvbmcgcGZuID0gUEhZ
U19QRk4ocmFuZ2UtPnN0YXJ0KTsNCisNCisJaWYgKHJhbmdlX2lkKQ0KKwkJcmV0dXJuIHBmbjsN
CisJcmV0dXJuIHBmbiArIHZtZW1fYWx0bWFwX29mZnNldChwZ21hcF9hbHRtYXAocGdtYXApKTsN
CiB9DQogDQotc3RhdGljIHVuc2lnbmVkIGxvbmcgcGZuX2VuZChzdHJ1Y3QgZGV2X3BhZ2VtYXAg
KnBnbWFwKQ0KK3N0YXRpYyB1bnNpZ25lZCBsb25nIHBmbl9lbmQoc3RydWN0IGRldl9wYWdlbWFw
ICpwZ21hcCwgaW50IHJhbmdlX2lkKQ0KIHsNCi0JY29uc3Qgc3RydWN0IHJhbmdlICpyYW5nZSA9
ICZwZ21hcC0+cmFuZ2U7DQorCWNvbnN0IHN0cnVjdCByYW5nZSAqcmFuZ2UgPSAmcGdtYXAtPnJh
bmdlc1tyYW5nZV9pZF07DQogDQogCXJldHVybiAocmFuZ2UtPnN0YXJ0ICsgcmFuZ2VfbGVuKHJh
bmdlKSkgPj4gUEFHRV9TSElGVDsNCiB9DQpAQCAtMTE3LDggKzEyMSw4IEBAIGJvb2wgcGZuX3pv
bmVfZGV2aWNlX3Jlc2VydmVkKHVuc2lnbmVkIGxvbmcgcGZuKQ0KIAlyZXR1cm4gcmV0Ow0KIH0N
CiANCi0jZGVmaW5lIGZvcl9lYWNoX2RldmljZV9wZm4ocGZuLCBtYXApIFwNCi0JZm9yIChwZm4g
PSBwZm5fZmlyc3QobWFwKTsgcGZuIDwgcGZuX2VuZChtYXApOyBwZm4gPSBwZm5fbmV4dChwZm4p
KQ0KKyNkZWZpbmUgZm9yX2VhY2hfZGV2aWNlX3BmbihwZm4sIG1hcCwgaSkgXA0KKwlmb3IgKHBm
biA9IHBmbl9maXJzdChtYXAsIGkpOyBwZm4gPCBwZm5fZW5kKG1hcCwgaSk7IHBmbiA9IHBmbl9u
ZXh0KHBmbikpDQogDQogc3RhdGljIHZvaWQgZGV2X3BhZ2VtYXBfa2lsbChzdHJ1Y3QgZGV2X3Bh
Z2VtYXAgKnBnbWFwKQ0KIHsNCkBAIC0xNDQsMjAgKzE0OCwxNCBAQCBzdGF0aWMgdm9pZCBkZXZf
cGFnZW1hcF9jbGVhbnVwKHN0cnVjdCBkZXZfcGFnZW1hcCAqcGdtYXApDQogCQlwZ21hcC0+cmVm
ID0gTlVMTDsNCiB9DQogDQotdm9pZCBtZW11bm1hcF9wYWdlcyhzdHJ1Y3QgZGV2X3BhZ2VtYXAg
KnBnbWFwKQ0KK3N0YXRpYyB2b2lkIHBhZ2V1bm1hcF9yYW5nZShzdHJ1Y3QgZGV2X3BhZ2VtYXAg
KnBnbWFwLCBpbnQgcmFuZ2VfaWQpDQogew0KLQlzdHJ1Y3QgcmFuZ2UgKnJhbmdlID0gJnBnbWFw
LT5yYW5nZTsNCisJc3RydWN0IHJhbmdlICpyYW5nZSA9ICZwZ21hcC0+cmFuZ2VzW3JhbmdlX2lk
XTsNCiAJc3RydWN0IHBhZ2UgKmZpcnN0X3BhZ2U7DQotCXVuc2lnbmVkIGxvbmcgcGZuOw0KIAlp
bnQgbmlkOw0KIA0KLQlkZXZfcGFnZW1hcF9raWxsKHBnbWFwKTsNCi0JZm9yX2VhY2hfZGV2aWNl
X3BmbihwZm4sIHBnbWFwKQ0KLQkJcHV0X3BhZ2UocGZuX3RvX3BhZ2UocGZuKSk7DQotCWRldl9w
YWdlbWFwX2NsZWFudXAocGdtYXApOw0KLQ0KIAkvKiBtYWtlIHN1cmUgdG8gYWNjZXNzIGEgbWVt
bWFwIHRoYXQgd2FzIGFjdHVhbGx5IGluaXRpYWxpemVkICovDQotCWZpcnN0X3BhZ2UgPSBwZm5f
dG9fcGFnZShwZm5fZmlyc3QocGdtYXApKTsNCisJZmlyc3RfcGFnZSA9IHBmbl90b19wYWdlKHBm
bl9maXJzdChwZ21hcCwgcmFuZ2VfaWQpKTsNCiANCiAJLyogcGFnZXMgYXJlIGRlYWQgYW5kIHVu
dXNlZCwgdW5kbyB0aGUgYXJjaCBtYXBwaW5nICovDQogCW5pZCA9IHBhZ2VfdG9fbmlkKGZpcnN0
X3BhZ2UpOw0KQEAgLTE3Nyw2ICsxNzUsMjIgQEAgdm9pZCBtZW11bm1hcF9wYWdlcyhzdHJ1Y3Qg
ZGV2X3BhZ2VtYXAgKnBnbWFwKQ0KIA0KIAl1bnRyYWNrX3BmbihOVUxMLCBQSFlTX1BGTihyYW5n
ZS0+c3RhcnQpLCByYW5nZV9sZW4ocmFuZ2UpKTsNCiAJcGdtYXBfYXJyYXlfZGVsZXRlKHJhbmdl
KTsNCit9DQorDQordm9pZCBtZW11bm1hcF9wYWdlcyhzdHJ1Y3QgZGV2X3BhZ2VtYXAgKnBnbWFw
KQ0KK3sNCisJdW5zaWduZWQgbG9uZyBwZm47DQorCWludCBpOw0KKw0KKwlkZXZfcGFnZW1hcF9r
aWxsKHBnbWFwKTsNCisJZm9yIChpID0gMDsgaSA8IHBnbWFwLT5ucl9yYW5nZTsgaSsrKQ0KKwkJ
Zm9yX2VhY2hfZGV2aWNlX3BmbihwZm4sIHBnbWFwLCBpKQ0KKwkJCXB1dF9wYWdlKHBmbl90b19w
YWdlKHBmbikpOw0KKwlkZXZfcGFnZW1hcF9jbGVhbnVwKHBnbWFwKTsNCisNCisJZm9yIChpID0g
MDsgaSA8IHBnbWFwLT5ucl9yYW5nZTsgaSsrKQ0KKwkJcGFnZXVubWFwX3JhbmdlKHBnbWFwLCBp
KTsNCisNCiAJV0FSTl9PTkNFKHBnbWFwLT5hbHRtYXAuYWxsb2MsICJmYWlsZWQgdG8gZnJlZSBh
bGwgcmVzZXJ2ZWQgcGFnZXNcbiIpOw0KIAlkZXZtYXBfbWFuYWdlZF9lbmFibGVfcHV0KCk7DQog
fQ0KQEAgLTE5NSw5NiArMjA5LDI5IEBAIHN0YXRpYyB2b2lkIGRldl9wYWdlbWFwX3BlcmNwdV9y
ZWxlYXNlKHN0cnVjdCBwZXJjcHVfcmVmICpyZWYpDQogCWNvbXBsZXRlKCZwZ21hcC0+ZG9uZSk7
DQogfQ0KIA0KLS8qDQotICogTm90IGRldmljZSBtYW5hZ2VkIHZlcnNpb24gb2YgZGV2X21lbXJl
bWFwX3BhZ2VzLCB1bmRvbmUgYnkNCi0gKiBtZW11bm1hcF9wYWdlcygpLiAgUGxlYXNlIHVzZSBk
ZXZfbWVtcmVtYXBfcGFnZXMgaWYgeW91IGhhdmUgYSBzdHJ1Y3QNCi0gKiBkZXZpY2UgYXZhaWxh
YmxlLg0KLSAqLw0KLXZvaWQgKm1lbXJlbWFwX3BhZ2VzKHN0cnVjdCBkZXZfcGFnZW1hcCAqcGdt
YXAsIGludCBuaWQpDQorc3RhdGljIGludCBwYWdlbWFwX3JhbmdlKHN0cnVjdCBkZXZfcGFnZW1h
cCAqcGdtYXAsIHN0cnVjdCBtaHBfcGFyYW1zICpwYXJhbXMsDQorCQlpbnQgcmFuZ2VfaWQsIGlu
dCBuaWQpDQogew0KLQlzdHJ1Y3QgcmFuZ2UgKnJhbmdlID0gJnBnbWFwLT5yYW5nZTsNCisJc3Ry
dWN0IHJhbmdlICpyYW5nZSA9ICZwZ21hcC0+cmFuZ2VzW3JhbmdlX2lkXTsNCiAJc3RydWN0IGRl
dl9wYWdlbWFwICpjb25mbGljdF9wZ21hcDsNCi0Jc3RydWN0IG1ocF9wYXJhbXMgcGFyYW1zID0g
ew0KLQkJLyoNCi0JCSAqIFdlIGRvIG5vdCB3YW50IGFueSBvcHRpb25hbCBmZWF0dXJlcyBvbmx5
IG91ciBvd24gbWVtbWFwDQotCQkgKi8NCi0JCS5hbHRtYXAgPSBwZ21hcF9hbHRtYXAocGdtYXAp
LA0KLQkJLnBncHJvdCA9IFBBR0VfS0VSTkVMLA0KLQl9Ow0KIAlpbnQgZXJyb3IsIGlzX3JhbTsN
Ci0JYm9vbCBuZWVkX2Rldm1hcF9tYW5hZ2VkID0gdHJ1ZTsNCiANCi0Jc3dpdGNoIChwZ21hcC0+
dHlwZSkgew0KLQljYXNlIE1FTU9SWV9ERVZJQ0VfUFJJVkFURToNCi0JCWlmICghSVNfRU5BQkxF
RChDT05GSUdfREVWSUNFX1BSSVZBVEUpKSB7DQotCQkJV0FSTigxLCAiRGV2aWNlIHByaXZhdGUg
bWVtb3J5IG5vdCBzdXBwb3J0ZWRcbiIpOw0KLQkJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0K
LQkJfQ0KLQkJaWYgKCFwZ21hcC0+b3BzIHx8ICFwZ21hcC0+b3BzLT5taWdyYXRlX3RvX3JhbSkg
ew0KLQkJCVdBUk4oMSwgIk1pc3NpbmcgbWlncmF0ZV90b19yYW0gbWV0aG9kXG4iKTsNCi0JCQly
ZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCi0JCX0NCi0JCWlmICghcGdtYXAtPm93bmVyKSB7DQot
CQkJV0FSTigxLCAiTWlzc2luZyBvd25lclxuIik7DQotCQkJcmV0dXJuIEVSUl9QVFIoLUVJTlZB
TCk7DQotCQl9DQotCQlicmVhazsNCi0JY2FzZSBNRU1PUllfREVWSUNFX0ZTX0RBWDoNCi0JCWlm
ICghSVNfRU5BQkxFRChDT05GSUdfWk9ORV9ERVZJQ0UpIHx8DQotCQkgICAgSVNfRU5BQkxFRChD
T05GSUdfRlNfREFYX0xJTUlURUQpKSB7DQotCQkJV0FSTigxLCAiRmlsZSBzeXN0ZW0gREFYIG5v
dCBzdXBwb3J0ZWRcbiIpOw0KLQkJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KLQkJfQ0KLQkJ
YnJlYWs7DQotCWNhc2UgTUVNT1JZX0RFVklDRV9HRU5FUklDOg0KLQkJbmVlZF9kZXZtYXBfbWFu
YWdlZCA9IGZhbHNlOw0KLQkJYnJlYWs7DQotCWNhc2UgTUVNT1JZX0RFVklDRV9QQ0lfUDJQRE1B
Og0KLQkJcGFyYW1zLnBncHJvdCA9IHBncHJvdF9ub25jYWNoZWQocGFyYW1zLnBncHJvdCk7DQot
CQluZWVkX2Rldm1hcF9tYW5hZ2VkID0gZmFsc2U7DQotCQlicmVhazsNCi0JZGVmYXVsdDoNCi0J
CVdBUk4oMSwgIkludmFsaWQgcGdtYXAgdHlwZSAlZFxuIiwgcGdtYXAtPnR5cGUpOw0KLQkJYnJl
YWs7DQotCX0NCi0NCi0JaWYgKCFwZ21hcC0+cmVmKSB7DQotCQlpZiAocGdtYXAtPm9wcyAmJiAo
cGdtYXAtPm9wcy0+a2lsbCB8fCBwZ21hcC0+b3BzLT5jbGVhbnVwKSkNCi0JCQlyZXR1cm4gRVJS
X1BUUigtRUlOVkFMKTsNCi0NCi0JCWluaXRfY29tcGxldGlvbigmcGdtYXAtPmRvbmUpOw0KLQkJ
ZXJyb3IgPSBwZXJjcHVfcmVmX2luaXQoJnBnbWFwLT5pbnRlcm5hbF9yZWYsDQotCQkJCWRldl9w
YWdlbWFwX3BlcmNwdV9yZWxlYXNlLCAwLCBHRlBfS0VSTkVMKTsNCi0JCWlmIChlcnJvcikNCi0J
CQlyZXR1cm4gRVJSX1BUUihlcnJvcik7DQotCQlwZ21hcC0+cmVmID0gJnBnbWFwLT5pbnRlcm5h
bF9yZWY7DQotCX0gZWxzZSB7DQotCQlpZiAoIXBnbWFwLT5vcHMgfHwgIXBnbWFwLT5vcHMtPmtp
bGwgfHwgIXBnbWFwLT5vcHMtPmNsZWFudXApIHsNCi0JCQlXQVJOKDEsICJNaXNzaW5nIHJlZmVy
ZW5jZSBjb3VudCB0ZWFyZG93biBkZWZpbml0aW9uXG4iKTsNCi0JCQlyZXR1cm4gRVJSX1BUUigt
RUlOVkFMKTsNCi0JCX0NCi0JfQ0KLQ0KLQlpZiAobmVlZF9kZXZtYXBfbWFuYWdlZCkgew0KLQkJ
ZXJyb3IgPSBkZXZtYXBfbWFuYWdlZF9lbmFibGVfZ2V0KHBnbWFwKTsNCi0JCWlmIChlcnJvcikN
Ci0JCQlyZXR1cm4gRVJSX1BUUihlcnJvcik7DQotCX0NCisJaWYgKFdBUk5fT05DRShwZ21hcF9h
bHRtYXAocGdtYXApICYmIHJhbmdlX2lkID4gMCwNCisJCQkJImFsdG1hcCBub3Qgc3VwcG9ydGVk
IGZvciBtdWx0aXBsZSByYW5nZXNcbiIpKQ0KKwkJcmV0dXJuIC1FSU5WQUw7DQogDQogCWNvbmZs
aWN0X3BnbWFwID0gZ2V0X2Rldl9wYWdlbWFwKFBIWVNfUEZOKHJhbmdlLT5zdGFydCksIE5VTEwp
Ow0KIAlpZiAoY29uZmxpY3RfcGdtYXApIHsNCiAJCVdBUk4oMSwgIkNvbmZsaWN0aW5nIG1hcHBp
bmcgaW4gc2FtZSBzZWN0aW9uXG4iKTsNCiAJCXB1dF9kZXZfcGFnZW1hcChjb25mbGljdF9wZ21h
cCk7DQotCQllcnJvciA9IC1FTk9NRU07DQotCQlnb3RvIGVycl9hcnJheTsNCisJCXJldHVybiAt
RU5PTUVNOw0KIAl9DQogDQogCWNvbmZsaWN0X3BnbWFwID0gZ2V0X2Rldl9wYWdlbWFwKFBIWVNf
UEZOKHJhbmdlLT5lbmQpLCBOVUxMKTsNCiAJaWYgKGNvbmZsaWN0X3BnbWFwKSB7DQogCQlXQVJO
KDEsICJDb25mbGljdGluZyBtYXBwaW5nIGluIHNhbWUgc2VjdGlvblxuIik7DQogCQlwdXRfZGV2
X3BhZ2VtYXAoY29uZmxpY3RfcGdtYXApOw0KLQkJZXJyb3IgPSAtRU5PTUVNOw0KLQkJZ290byBl
cnJfYXJyYXk7DQorCQlyZXR1cm4gLUVOT01FTTsNCiAJfQ0KIA0KIAlpc19yYW0gPSByZWdpb25f
aW50ZXJzZWN0cyhyYW5nZS0+c3RhcnQsIHJhbmdlX2xlbihyYW5nZSksDQpAQCAtMjk0LDE5ICsy
NDEsMTggQEAgdm9pZCAqbWVtcmVtYXBfcGFnZXMoc3RydWN0IGRldl9wYWdlbWFwICpwZ21hcCwg
aW50IG5pZCkNCiAJCVdBUk5fT05DRSgxLCAiYXR0ZW1wdGVkIG9uICVzIHJlZ2lvbiAlI2xseC0l
I2xseFxuIiwNCiAJCQkJaXNfcmFtID09IFJFR0lPTl9NSVhFRCA/ICJtaXhlZCIgOiAicmFtIiwN
CiAJCQkJcmFuZ2UtPnN0YXJ0LCByYW5nZS0+ZW5kKTsNCi0JCWVycm9yID0gLUVOWElPOw0KLQkJ
Z290byBlcnJfYXJyYXk7DQorCQlyZXR1cm4gLUVOWElPOw0KIAl9DQogDQogCWVycm9yID0geGFf
ZXJyKHhhX3N0b3JlX3JhbmdlKCZwZ21hcF9hcnJheSwgUEhZU19QRk4ocmFuZ2UtPnN0YXJ0KSwN
CiAJCQkJUEhZU19QRk4ocmFuZ2UtPmVuZCksIHBnbWFwLCBHRlBfS0VSTkVMKSk7DQogCWlmIChl
cnJvcikNCi0JCWdvdG8gZXJyX2FycmF5Ow0KKwkJcmV0dXJuIGVycm9yOw0KIA0KIAlpZiAobmlk
IDwgMCkNCiAJCW5pZCA9IG51bWFfbWVtX2lkKCk7DQogDQotCWVycm9yID0gdHJhY2tfcGZuX3Jl
bWFwKE5VTEwsICZwYXJhbXMucGdwcm90LCBQSFlTX1BGTihyYW5nZS0+c3RhcnQpLCAwLA0KKwll
cnJvciA9IHRyYWNrX3Bmbl9yZW1hcChOVUxMLCAmcGFyYW1zLT5wZ3Byb3QsIFBIWVNfUEZOKHJh
bmdlLT5zdGFydCksIDAsDQogCQkJcmFuZ2VfbGVuKHJhbmdlKSk7DQogCWlmIChlcnJvcikNCiAJ
CWdvdG8gZXJyX3Bmbl9yZW1hcDsNCkBAIC0zMjYsNyArMjcyLDcgQEAgdm9pZCAqbWVtcmVtYXBf
cGFnZXMoc3RydWN0IGRldl9wYWdlbWFwICpwZ21hcCwgaW50IG5pZCkNCiAJICovDQogCWlmIChw
Z21hcC0+dHlwZSA9PSBNRU1PUllfREVWSUNFX1BSSVZBVEUpIHsNCiAJCWVycm9yID0gYWRkX3Bh
Z2VzKG5pZCwgUEhZU19QRk4ocmFuZ2UtPnN0YXJ0KSwNCi0JCQkJUEhZU19QRk4ocmFuZ2VfbGVu
KHJhbmdlKSksICZwYXJhbXMpOw0KKwkJCQlQSFlTX1BGTihyYW5nZV9sZW4ocmFuZ2UpKSwgcGFy
YW1zKTsNCiAJfSBlbHNlIHsNCiAJCWVycm9yID0ga2FzYW5fYWRkX3plcm9fc2hhZG93KF9fdmEo
cmFuZ2UtPnN0YXJ0KSwgcmFuZ2VfbGVuKHJhbmdlKSk7DQogCQlpZiAoZXJyb3IpIHsNCkBAIC0z
MzUsNyArMjgxLDcgQEAgdm9pZCAqbWVtcmVtYXBfcGFnZXMoc3RydWN0IGRldl9wYWdlbWFwICpw
Z21hcCwgaW50IG5pZCkNCiAJCX0NCiANCiAJCWVycm9yID0gYXJjaF9hZGRfbWVtb3J5KG5pZCwg
cmFuZ2UtPnN0YXJ0LCByYW5nZV9sZW4ocmFuZ2UpLA0KLQkJCQkJJnBhcmFtcyk7DQorCQkJCQlw
YXJhbXMpOw0KIAl9DQogDQogCWlmICghZXJyb3IpIHsNCkBAIC0zNDMsNyArMjg5LDcgQEAgdm9p
ZCAqbWVtcmVtYXBfcGFnZXMoc3RydWN0IGRldl9wYWdlbWFwICpwZ21hcCwgaW50IG5pZCkNCiAN
CiAJCXpvbmUgPSAmTk9ERV9EQVRBKG5pZCktPm5vZGVfem9uZXNbWk9ORV9ERVZJQ0VdOw0KIAkJ
bW92ZV9wZm5fcmFuZ2VfdG9fem9uZSh6b25lLCBQSFlTX1BGTihyYW5nZS0+c3RhcnQpLA0KLQkJ
CQlQSFlTX1BGTihyYW5nZV9sZW4ocmFuZ2UpKSwgcGFyYW1zLmFsdG1hcCk7DQorCQkJCVBIWVNf
UEZOKHJhbmdlX2xlbihyYW5nZSkpLCBwYXJhbXMtPmFsdG1hcCk7DQogCX0NCiANCiAJbWVtX2hv
dHBsdWdfZG9uZSgpOw0KQEAgLTM1NywyMCArMzAzLDExNiBAQCB2b2lkICptZW1yZW1hcF9wYWdl
cyhzdHJ1Y3QgZGV2X3BhZ2VtYXAgKnBnbWFwLCBpbnQgbmlkKQ0KIAltZW1tYXBfaW5pdF96b25l
X2RldmljZSgmTk9ERV9EQVRBKG5pZCktPm5vZGVfem9uZXNbWk9ORV9ERVZJQ0VdLA0KIAkJCQlQ
SFlTX1BGTihyYW5nZS0+c3RhcnQpLA0KIAkJCQlQSFlTX1BGTihyYW5nZV9sZW4ocmFuZ2UpKSwg
cGdtYXApOw0KLQlwZXJjcHVfcmVmX2dldF9tYW55KHBnbWFwLT5yZWYsIHBmbl9lbmQocGdtYXAp
IC0gcGZuX2ZpcnN0KHBnbWFwKSk7DQotCXJldHVybiBfX3ZhKHJhbmdlLT5zdGFydCk7DQorCXBl
cmNwdV9yZWZfZ2V0X21hbnkocGdtYXAtPnJlZiwgcGZuX2VuZChwZ21hcCwgcmFuZ2VfaWQpDQor
CQkJLSBwZm5fZmlyc3QocGdtYXAsIHJhbmdlX2lkKSk7DQorCXJldHVybiAwOw0KIA0KLSBlcnJf
YWRkX21lbW9yeToNCitlcnJfYWRkX21lbW9yeToNCiAJa2FzYW5fcmVtb3ZlX3plcm9fc2hhZG93
KF9fdmEocmFuZ2UtPnN0YXJ0KSwgcmFuZ2VfbGVuKHJhbmdlKSk7DQotIGVycl9rYXNhbjoNCitl
cnJfa2FzYW46DQogCXVudHJhY2tfcGZuKE5VTEwsIFBIWVNfUEZOKHJhbmdlLT5zdGFydCksIHJh
bmdlX2xlbihyYW5nZSkpOw0KLSBlcnJfcGZuX3JlbWFwOg0KK2Vycl9wZm5fcmVtYXA6DQogCXBn
bWFwX2FycmF5X2RlbGV0ZShyYW5nZSk7DQotIGVycl9hcnJheToNCi0JZGV2X3BhZ2VtYXBfa2ls
bChwZ21hcCk7DQotCWRldl9wYWdlbWFwX2NsZWFudXAocGdtYXApOw0KLQlkZXZtYXBfbWFuYWdl
ZF9lbmFibGVfcHV0KCk7DQotCXJldHVybiBFUlJfUFRSKGVycm9yKTsNCisJcmV0dXJuIGVycm9y
Ow0KK30NCisNCisNCisvKg0KKyAqIE5vdCBkZXZpY2UgbWFuYWdlZCB2ZXJzaW9uIG9mIGRldl9t
ZW1yZW1hcF9wYWdlcywgdW5kb25lIGJ5DQorICogbWVtdW5tYXBfcGFnZXMoKS4gIFBsZWFzZSB1
c2UgZGV2X21lbXJlbWFwX3BhZ2VzIGlmIHlvdSBoYXZlIGEgc3RydWN0DQorICogZGV2aWNlIGF2
YWlsYWJsZS4NCisgKi8NCit2b2lkICptZW1yZW1hcF9wYWdlcyhzdHJ1Y3QgZGV2X3BhZ2VtYXAg
KnBnbWFwLCBpbnQgbmlkKQ0KK3sNCisJc3RydWN0IG1ocF9wYXJhbXMgcGFyYW1zID0gew0KKwkJ
LmFsdG1hcCA9IHBnbWFwX2FsdG1hcChwZ21hcCksDQorCQkucGdwcm90ID0gUEFHRV9LRVJORUws
DQorCX07DQorCWNvbnN0IGludCBucl9yYW5nZSA9IHBnbWFwLT5ucl9yYW5nZTsNCisJYm9vbCBu
ZWVkX2Rldm1hcF9tYW5hZ2VkID0gdHJ1ZTsNCisJaW50IGVycm9yLCBpOw0KKw0KKwlpZiAoV0FS
Tl9PTkNFKCFucl9yYW5nZSwgIm5yX3JhbmdlIG11c3QgYmUgc3BlY2lmaWVkXG4iKSkNCisJCXJl
dHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KKw0KKwlzd2l0Y2ggKHBnbWFwLT50eXBlKSB7DQorCWNh
c2UgTUVNT1JZX0RFVklDRV9QUklWQVRFOg0KKwkJaWYgKCFJU19FTkFCTEVEKENPTkZJR19ERVZJ
Q0VfUFJJVkFURSkpIHsNCisJCQlXQVJOKDEsICJEZXZpY2UgcHJpdmF0ZSBtZW1vcnkgbm90IHN1
cHBvcnRlZFxuIik7DQorCQkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQorCQl9DQorCQlpZiAo
IXBnbWFwLT5vcHMgfHwgIXBnbWFwLT5vcHMtPm1pZ3JhdGVfdG9fcmFtKSB7DQorCQkJV0FSTigx
LCAiTWlzc2luZyBtaWdyYXRlX3RvX3JhbSBtZXRob2RcbiIpOw0KKwkJCXJldHVybiBFUlJfUFRS
KC1FSU5WQUwpOw0KKwkJfQ0KKwkJaWYgKCFwZ21hcC0+b3duZXIpIHsNCisJCQlXQVJOKDEsICJN
aXNzaW5nIG93bmVyXG4iKTsNCisJCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCisJCX0NCisJ
CWJyZWFrOw0KKwljYXNlIE1FTU9SWV9ERVZJQ0VfRlNfREFYOg0KKwkJaWYgKCFJU19FTkFCTEVE
KENPTkZJR19aT05FX0RFVklDRSkgfHwNCisJCSAgICBJU19FTkFCTEVEKENPTkZJR19GU19EQVhf
TElNSVRFRCkpIHsNCisJCQlXQVJOKDEsICJGaWxlIHN5c3RlbSBEQVggbm90IHN1cHBvcnRlZFxu
Iik7DQorCQkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQorCQl9DQorCQlicmVhazsNCisJY2Fz
ZSBNRU1PUllfREVWSUNFX0dFTkVSSUM6DQorCQluZWVkX2Rldm1hcF9tYW5hZ2VkID0gZmFsc2U7
DQorCQlicmVhazsNCisJY2FzZSBNRU1PUllfREVWSUNFX1BDSV9QMlBETUE6DQorCQlwYXJhbXMu
cGdwcm90ID0gcGdwcm90X25vbmNhY2hlZChwYXJhbXMucGdwcm90KTsNCisJCW5lZWRfZGV2bWFw
X21hbmFnZWQgPSBmYWxzZTsNCisJCWJyZWFrOw0KKwlkZWZhdWx0Og0KKwkJV0FSTigxLCAiSW52
YWxpZCBwZ21hcCB0eXBlICVkXG4iLCBwZ21hcC0+dHlwZSk7DQorCQlicmVhazsNCisJfQ0KKw0K
KwlpZiAoIXBnbWFwLT5yZWYpIHsNCisJCWlmIChwZ21hcC0+b3BzICYmIChwZ21hcC0+b3BzLT5r
aWxsIHx8IHBnbWFwLT5vcHMtPmNsZWFudXApKQ0KKwkJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwp
Ow0KKw0KKwkJaW5pdF9jb21wbGV0aW9uKCZwZ21hcC0+ZG9uZSk7DQorCQllcnJvciA9IHBlcmNw
dV9yZWZfaW5pdCgmcGdtYXAtPmludGVybmFsX3JlZiwNCisJCQkJZGV2X3BhZ2VtYXBfcGVyY3B1
X3JlbGVhc2UsIDAsIEdGUF9LRVJORUwpOw0KKwkJaWYgKGVycm9yKQ0KKwkJCXJldHVybiBFUlJf
UFRSKGVycm9yKTsNCisJCXBnbWFwLT5yZWYgPSAmcGdtYXAtPmludGVybmFsX3JlZjsNCisJfSBl
bHNlIHsNCisJCWlmICghcGdtYXAtPm9wcyB8fCAhcGdtYXAtPm9wcy0+a2lsbCB8fCAhcGdtYXAt
Pm9wcy0+Y2xlYW51cCkgew0KKwkJCVdBUk4oMSwgIk1pc3NpbmcgcmVmZXJlbmNlIGNvdW50IHRl
YXJkb3duIGRlZmluaXRpb25cbiIpOw0KKwkJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KKwkJ
fQ0KKwl9DQorDQorCWlmIChuZWVkX2Rldm1hcF9tYW5hZ2VkKSB7DQorCQllcnJvciA9IGRldm1h
cF9tYW5hZ2VkX2VuYWJsZV9nZXQocGdtYXApOw0KKwkJaWYgKGVycm9yKQ0KKwkJCXJldHVybiBF
UlJfUFRSKGVycm9yKTsNCisJfQ0KKw0KKwkvKg0KKwkgKiBDbGVhciB0aGUgcGdtYXAgbnJfcmFu
Z2UgYXMgaXQgd2lsbCBiZSBpbmNyZW1lbnRlZCBmb3IgZWFjaA0KKwkgKiBzdWNjZXNzZnVsbHkg
cHJvY2Vzc2VkIHJhbmdlLiBUaGlzIGNvbW11bmljYXRlcyBob3cgbWFueQ0KKwkgKiByZWdpb25z
IHRvIHVud2luZCBpbiB0aGUgYWJvcnQgY2FzZS4NCisJICovDQorCXBnbWFwLT5ucl9yYW5nZSA9
IDA7DQorCWVycm9yID0gMDsNCisJZm9yIChpID0gMDsgaSA8IG5yX3JhbmdlOyBpKyspIHsNCisJ
CWVycm9yID0gcGFnZW1hcF9yYW5nZShwZ21hcCwgJnBhcmFtcywgaSwgbmlkKTsNCisJCWlmIChl
cnJvcikNCisJCQlicmVhazsNCisJCXBnbWFwLT5ucl9yYW5nZSsrOw0KKwl9DQorDQorCWlmIChp
IDwgbnJfcmFuZ2UpIHsNCisJCW1lbXVubWFwX3BhZ2VzKHBnbWFwKTsNCisJCXBnbWFwLT5ucl9y
YW5nZSA9IG5yX3JhbmdlOw0KKwkJcmV0dXJuIEVSUl9QVFIoZXJyb3IpOw0KKwl9DQorDQorCXJl
dHVybiBfX3ZhKHBnbWFwLT5yYW5nZXNbMF0uc3RhcnQpOw0KIH0NCiBFWFBPUlRfU1lNQk9MX0dQ
TChtZW1yZW1hcF9wYWdlcyk7DQogDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBs
aXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0t
bGVhdmVAbGlzdHMuMDEub3JnCg==
