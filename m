Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22474264127
	for <lists+linux-nvdimm@lfdr.de>; Thu, 10 Sep 2020 11:14:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C72731414DD5B;
	Thu, 10 Sep 2020 02:14:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EA1F71414DD5C
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1599729288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcPWZv9PYAHyw7ygKg8TV8AW3ZEfFOjouUb95Y7pmVU=;
	b=ggBtz7HKaK9A03rUvqwACI3V5StcqeAQSdpO36PoTftsPskhPBdgrEyTOhwaQYM1OKE3wA
	pR898mI2ALQhwhlu/seAQIRFflXS0KhWRYb2rfmaeXXrFfuPiVz9bwjihsnA5iuft7R37q
	qljDlcUOqpd+I/LtpwnSONGX5aVM+rQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-F3s5MUEMNf-YywNaYeYo4Q-1; Thu, 10 Sep 2020 05:14:44 -0400
X-MC-Unique: F3s5MUEMNf-YywNaYeYo4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E63CB18B9F00;
	Thu, 10 Sep 2020 09:14:41 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-88.ams2.redhat.com [10.36.113.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3BE081A8EC;
	Thu, 10 Sep 2020 09:14:38 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] xen/balloon: try to merge system ram resources
Date: Thu, 10 Sep 2020 11:13:39 +0200
Message-Id: <20200910091340.8654-7-david@redhat.com>
In-Reply-To: <20200910091340.8654-1-david@redhat.com>
References: <20200910091340.8654-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: PZRO7ISXWXPTCL7VTLWXHYWSHVTXENBK
X-Message-ID-Hash: PZRO7ISXWXPTCL7VTLWXHYWSHVTXENBK
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Juergen Gross <jgross@suse.com>, Andrew Morton <akpmt@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <sstabellini@kernel.org>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>, Julien Grall <julien@xen.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PZRO7ISXWXPTCL7VTLWXHYWSHVTXENBK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

TGV0J3MgdHJ5IHRvIG1lcmdlIHN5c3RlbSByYW0gcmVzb3VyY2VzIHdlIGFkZCwgdG8gbWluaW1p
emUgdGhlIG51bWJlcg0Kb2YgcmVzb3VyY2VzIGluIC9wcm9jL2lvbWVtLiBXZSBkb24ndCBjYXJl
IGFib3V0IHRoZSBib3VuZGFyaWVzIG9mDQppbmRpdmlkdWFsIGNodW5rcyB3ZSBhZGRlZC4NCg0K
UmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCkNjOiBBbmRyZXcg
TW9ydG9uIDxha3BtdEBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCkNjOiBNaWNoYWwgSG9ja28gPG1o
b2Nrb0BzdXNlLmNvbT4NCkNjOiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9zdHJvdnNreUBvcmFj
bGUuY29tPg0KQ2M6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCkNjOiBTdGVmYW5v
IFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+DQpDYzogUm9nZXIgUGF1IE1vbm7D
qSA8cm9nZXIucGF1QGNpdHJpeC5jb20+DQpDYzogSnVsaWVuIEdyYWxsIDxqdWxpZW5AeGVuLm9y
Zz4NCkNjOiBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YS5saW51eEBnbWFpbC5jb20+DQpDYzog
QmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+DQpDYzogV2VpIFlhbmcgPHJpY2hhcmR3LnlhbmdA
bGludXguaW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlk
QHJlZGhhdC5jb20+DQotLS0NCiBkcml2ZXJzL3hlbi9iYWxsb29uLmMgfCAyICstDQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3hlbi9iYWxsb29uLmMgYi9kcml2ZXJzL3hlbi9iYWxsb29uLmMNCmluZGV4IDlmNDBh
Mjk0ZDM5OGQuLmI1N2IyMDY3ZWNiZmIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3hlbi9iYWxsb29u
LmMNCisrKyBiL2RyaXZlcnMveGVuL2JhbGxvb24uYw0KQEAgLTMzMSw3ICszMzEsNyBAQCBzdGF0
aWMgZW51bSBicF9zdGF0ZSByZXNlcnZlX2FkZGl0aW9uYWxfbWVtb3J5KHZvaWQpDQogCW11dGV4
X3VubG9jaygmYmFsbG9vbl9tdXRleCk7DQogCS8qIGFkZF9tZW1vcnlfcmVzb3VyY2UoKSByZXF1
aXJlcyB0aGUgZGV2aWNlX2hvdHBsdWcgbG9jayAqLw0KIAlsb2NrX2RldmljZV9ob3RwbHVnKCk7
DQotCXJjID0gYWRkX21lbW9yeV9yZXNvdXJjZShuaWQsIHJlc291cmNlLCBNSFBfTk9ORSk7DQor
CXJjID0gYWRkX21lbW9yeV9yZXNvdXJjZShuaWQsIHJlc291cmNlLCBNRU1IUF9NRVJHRV9SRVNP
VVJDRSk7DQogCXVubG9ja19kZXZpY2VfaG90cGx1ZygpOw0KIAltdXRleF9sb2NrKCZiYWxsb29u
X211dGV4KTsNCiANCi0tIA0KMi4yNi4yDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGlt
bUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRp
bW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
