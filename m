Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFB4216431
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:56:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 898441108DEAA;
	Mon,  6 Jul 2020 19:56:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2F3111108DEA9
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:56:40 -0700 (PDT)
IronPort-SDR: NgAiLeRABPfnqpD8NKlLE4TrSpHZJtUTUO4+qss8kPgxwbX+riT2JMtvJrrs885d0g/Dm00r98
 wEgVD+7Ayv7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212503340"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="212503340"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:56:39 -0700
IronPort-SDR: nbRpX/zozROd5lWxQx8jfzIXH+gXrxFwmj0/Aqh6JowhhjHATn2cQ0OmbW2hADWp8cdniuxoGj
 0hvypY6yn4Tw==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="482903844"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:56:39 -0700
Subject: [ndctl PATCH 01/16] ndctl/build: Fix zero-length array warnings
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Mon, 06 Jul 2020 19:40:23 -0700
Message-ID: <159408962360.2386154.5219921025264845019.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID-Hash: 6P5J62UUVAHCKXTVEC4VQMRTEVRPZ37A
X-Message-ID-Hash: 6P5J62UUVAHCKXTVEC4VQMRTEVRPZ37A
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6P5J62UUVAHCKXTVEC4VQMRTEVRPZ37A/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

R0NDMTAgZW1pdHMgd2FybmluZ3MgbGlrZToNCg0KbXNmdC5jOiBJbiBmdW5jdGlvbiDigJhtc2Z0
X2NtZF9zbWFydF9nZXRfbWVkaWFfdGVtcGVyYXR1cmXigJk6DQptc2Z0LmM6MTQ2OjI4OiB3YXJu
aW5nOiBhcnJheSBzdWJzY3JpcHQgMCBpcyBvdXRzaWRlIHRoZSBib3VuZHMgb2YgYW4gaW50ZXJp
b3IgemVyby1sZW5ndGggYXJyYXkg4oCYc3RydWN0IG5kbl9tc2Z0X3NtYXJ0X2RhdGFbMF3igJkg
Wy1XemVyby1sZW5ndGgtYm91bmRzXQ0KDQpocGUxLmM6IEluIGZ1bmN0aW9uIOKAmGhwZTFfY21k
X3NtYXJ0X2dldF9mbGFnc+KAmToNCmhwZTEuYzoxMTE6MzM6IHdhcm5pbmc6IGFycmF5IHN1YnNj
cmlwdCAwIGlzIG91dHNpZGUgdGhlIGJvdW5kcyBvZiBhbiBpbnRlcmlvciB6ZXJvLWxlbmd0aCBh
cnJheSDigJhzdHJ1Y3QgbmRuX2hwZTFfc21hcnRfZGF0YVswXeKAmSBbLVd6ZXJvLWxlbmd0aC1i
b3VuZHNdDQoNCmFycy5jOiBJbiBmdW5jdGlvbiDigJhuZGN0bF9jbWRfYXJzX2dldF9yZWNvcmRf
YWRkcuKAmToNCmFycy5jOjI3NDozODogd2FybmluZzogYXJyYXkgc3Vic2NyaXB0IOKAmCg8dW5r
bm93bj4pICsgNDI5NDk2NzI5NeKAmSBpcyBvdXRzaWRlIHRoZSBib3VuZHMgb2YgYW4gaW50ZXJp
b3IgemVyby1sZW5ndGggYXJyYXkg4oCYc3RydWN0IG5kX2Fyc19yZWNvcmRbMF3igJkgWy1XemVy
by1sZW5ndGgtYm91bmRzXQ0KDQpJbiB0aGUgY2FzZSBvZiB0aGUgJ21zZnQnIGFuZCAnaHBlMScg
aW1wbGVtZW50YXRpb24gdGhlIHplcm8tbGVuZ3RoIGFycmF5DQppcyBub3QgbmVlZGVkIGJlY2F1
c2UgdGhleSBhcmUgZGVjbGFyZWQgd2l0aCBhIHVuaW9uIG9mIGEgYnVmZmVyIG9mIHRoZQ0Kc2Ft
ZSBzaXplIGFzIGEgc2luZ2xlIGVsZW1lbnQuIEZpeCB0aG9zZSBjYXNlcyBieSBqdXN0IGRlY2xh
cmluZyBhIHNpbmdsZQ0KZWxlbWVudCBhcnJheS4NCg0KVGhlIEFSUyBjYXNlIGlzIGRpZmZlcmVu
dCwgaXQncyBjb21wbGFpbmluZyBhYm91dCBhbiBpbnRlcm5hbCB6ZXJvLWxlbmd0aA0KbWVtYmVy
LiBTd2l0Y2ggdG8gdGhlIHJlY29tbWVuZGVkIFsxXSBmbGV4aWJsZS1hcnJheSBzeW50YXggZm9y
IHRoYXQgY2FzZS4NCg0KWzFdOiBodHRwczovL2djYy5nbnUub3JnL29ubGluZWRvY3MvZ2NjL1pl
cm8tTGVuZ3RoLmh0bWwNCg0KU2lnbmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxs
aWFtc0BpbnRlbC5jb20+DQotLS0NCiBuZGN0bC9saWIvaHBlMS5oIHwgICAgNCArKy0tDQogbmRj
dGwvbGliL21zZnQuaCB8ICAgIDIgKy0NCiBuZGN0bC9uZGN0bC5oICAgIHwgICAgMiArLQ0KIDMg
ZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvbmRjdGwvbGliL2hwZTEuaCBiL25kY3RsL2xpYi9ocGUxLmgNCmluZGV4IGIwNTA4MzFl
YzJjNC4uMWFmYTU0ZjEyN2E2IDEwMDY0NA0KLS0tIGEvbmRjdGwvbGliL2hwZTEuaA0KKysrIGIv
bmRjdGwvbGliL2hwZTEuaA0KQEAgLTExMSw3ICsxMTEsNyBAQCBzdHJ1Y3QgbmRuX2hwZTFfc21h
cnQgew0KIAlfX3UzMiBzdGF0dXM7DQogCXVuaW9uIHsNCiAJCV9fdTggYnVmWzEyNF07DQotCQlz
dHJ1Y3QgbmRuX2hwZTFfc21hcnRfZGF0YSBkYXRhWzBdOw0KKwkJc3RydWN0IG5kbl9ocGUxX3Nt
YXJ0X2RhdGEgZGF0YVsxXTsNCiAJfTsNCiB9IF9fYXR0cmlidXRlX18oKHBhY2tlZCkpOw0KIA0K
QEAgLTEzNiw3ICsxMzYsNyBAQCBzdHJ1Y3QgbmRuX2hwZTFfc21hcnRfdGhyZXNob2xkIHsNCiAJ
X191MzIgc3RhdHVzOw0KIAl1bmlvbiB7DQogCQlfX3U4IGJ1ZlszMl07DQotCQlzdHJ1Y3QgbmRu
X2hwZTFfc21hcnRfdGhyZXNob2xkX2RhdGEgZGF0YVswXTsNCisJCXN0cnVjdCBuZG5faHBlMV9z
bWFydF90aHJlc2hvbGRfZGF0YSBkYXRhWzFdOw0KIAl9Ow0KIH0gX19hdHRyaWJ1dGVfXygocGFj
a2VkKSk7DQogDQpkaWZmIC0tZ2l0IGEvbmRjdGwvbGliL21zZnQuaCBiL25kY3RsL2xpYi9tc2Z0
LmgNCmluZGV4IDBhMWM3YzZhMDkwNy4uYzQ1OTgxZWRkOGQ3IDEwMDY0NA0KLS0tIGEvbmRjdGwv
bGliL21zZnQuaA0KKysrIGIvbmRjdGwvbGliL21zZnQuaA0KQEAgLTQ2LDcgKzQ2LDcgQEAgc3Ry
dWN0IG5kbl9tc2Z0X3NtYXJ0IHsNCiAJX191MzIJc3RhdHVzOw0KIAl1bmlvbiB7DQogCQlfX3U4
IGJ1Zls5XTsNCi0JCXN0cnVjdCBuZG5fbXNmdF9zbWFydF9kYXRhIGRhdGFbMF07DQorCQlzdHJ1
Y3QgbmRuX21zZnRfc21hcnRfZGF0YSBkYXRhWzFdOw0KIAl9Ow0KIH0gX19hdHRyaWJ1dGVfXygo
cGFja2VkKSk7DQogDQpkaWZmIC0tZ2l0IGEvbmRjdGwvbmRjdGwuaCBiL25kY3RsL25kY3RsLmgN
CmluZGV4IDAwOGY4MWNkZWI5Zi4uZTM2MDViM2Q2NGI0IDEwMDY0NA0KLS0tIGEvbmRjdGwvbmRj
dGwuaA0KKysrIGIvbmRjdGwvbmRjdGwuaA0KQEAgLTkxLDcgKzkxLDcgQEAgc3RydWN0IG5kX2Nt
ZF9hcnNfc3RhdHVzIHsNCiAJCV9fdTMyIHJlc2VydmVkOw0KIAkJX191NjQgZXJyX2FkZHJlc3M7
DQogCQlfX3U2NCBsZW5ndGg7DQotCX0gX19hdHRyaWJ1dGVfXygocGFja2VkKSkgcmVjb3Jkc1sw
XTsNCisJfSBfX2F0dHJpYnV0ZV9fKChwYWNrZWQpKSByZWNvcmRzW107DQogfSBfX2F0dHJpYnV0
ZV9fKChwYWNrZWQpKTsNCiANCiBzdHJ1Y3QgbmRfY21kX2NsZWFyX2Vycm9yIHsNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWls
aW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5k
IGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
