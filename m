Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E05311527
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Feb 2021 23:29:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 96119100EBBC1;
	Fri,  5 Feb 2021 14:29:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:c0c:3a97::2; helo=antares.kleine-koenig.org; envelope-from=uwe@kleine-koenig.org; receiver=<UNKNOWN> 
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 71293100ED4BC
	for <linux-nvdimm@lists.01.org>; Fri,  5 Feb 2021 14:29:00 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
	id 745DAAEDEF9; Fri,  5 Feb 2021 23:28:58 +0100 (CET)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/5] dax-device: Prevent registering drivers without probe callback
Date: Fri,  5 Feb 2021 23:28:38 +0100
Message-Id: <20210205222842.34896-2-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205222842.34896-1-uwe@kleine-koenig.org>
References: <20210205222842.34896-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Message-ID-Hash: XMX4EXOJIF3NOBM2CR6OLPYRWBFJZJKG
X-Message-ID-Hash: XMX4EXOJIF3NOBM2CR6OLPYRWBFJZJKG
X-MailFrom: uwe@kleine-koenig.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XMX4EXOJIF3NOBM2CR6OLPYRWBFJZJKG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhlIGJ1cyBwcm9iZSBmdW5jdGlvbiBkYXhfYnVzX3Byb2JlKCkgY2FsbHMgdGhlIHByb2JlIGNh
bGxiYWNrIHdpdGhvdXQNCmNoZWNraW5nIGl0IHRvIGJlIG5vbi1OVUxMLiBQcmV2ZW50IGEgTlVM
TCBwb2ludGVyIGV4Y2VwdGlvbiBpZiBhIGRyaXZlcg0Kd2l0aG91dCBhIHByb2JlIGZ1bmN0aW9u
IGlzIHJlZ2lzdGVyZWQgYnkgcmVmdXNpbmcgdG8gcmVnaXN0ZXIgdGhpcw0KZHJpdmVyLg0KDQpT
aWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dXdlQGtsZWluZS1rb2VuaWcub3JnPg0K
LS0tDQogZHJpdmVycy9kYXgvYnVzLmMgfCA3ICsrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RheC9idXMuYyBiL2RyaXZlcnMv
ZGF4L2J1cy5jDQppbmRleCA3MzdiMjA3YzllMzAuLjcyZmM0YjliOWFlNiAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZGF4L2J1cy5jDQorKysgYi9kcml2ZXJzL2RheC9idXMuYw0KQEAgLTEzOTIsNiAr
MTM5MiwxMyBAQCBpbnQgX19kYXhfZHJpdmVyX3JlZ2lzdGVyKHN0cnVjdCBkYXhfZGV2aWNlX2Ry
aXZlciAqZGF4X2RydiwNCiAJc3RydWN0IGRldmljZV9kcml2ZXIgKmRydiA9ICZkYXhfZHJ2LT5k
cnY7DQogCWludCByYyA9IDA7DQogDQorCS8qDQorCSAqIGRheF9idXNfcHJvYmUoKSBjYWxscyBk
YXhfZHJ2LT5wcm9iZSgpIHVuY29uZGl0aW9uYWxseS4NCisJICogU28gYmV0dGVyIGJlIHNhZmUg
dGhhbiBzb3JyeSBhbmQgZW5zdXJlIGl0IGlzIHByb3ZpZGVkLg0KKwkgKi8NCisJaWYgKCFkYXhf
ZHJ2LT5wcm9iZSkNCisJCXJldHVybiAtRUlOVkFMOw0KKw0KIAlJTklUX0xJU1RfSEVBRCgmZGF4
X2Rydi0+aWRzKTsNCiAJZHJ2LT5vd25lciA9IG1vZHVsZTsNCiAJZHJ2LT5uYW1lID0gbW9kX25h
bWU7DQotLSANCjIuMjkuMg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMu
MDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZl
QGxpc3RzLjAxLm9yZwo=
