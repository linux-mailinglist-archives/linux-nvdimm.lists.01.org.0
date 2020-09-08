Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE32226204E
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Sep 2020 22:11:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A270B13C60A09;
	Tue,  8 Sep 2020 13:11:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0EA4413C4BD14
	for <linux-nvdimm@lists.01.org>; Tue,  8 Sep 2020 13:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1599595892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8K1xYXTYUbnlqXd2ZY48Xr9MumdD7TqIS7rIjkX/laU=;
	b=fPo80OPVtsLQyxNSDLTnlNshggz94Ckne2m7T4WB4U9QkRv6yw8TXbkDYydZOlcyR15dee
	ExEN5TxLHScUavXK5ymgGVWGhjsPLvRWmfKNyW6ZHtFpxk76iJ3GOYVwm1hNB8V73h6uMo
	pV1HkOT9CpYBOVbE+R0YXGa/VMZXgkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-Y-wM1DyKPe22UQB0ydanhg-1; Tue, 08 Sep 2020 16:11:28 -0400
X-MC-Unique: Y-wM1DyKPe22UQB0ydanhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA4DC85C734;
	Tue,  8 Sep 2020 20:11:25 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-46.ams2.redhat.com [10.36.115.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 942655D9E8;
	Tue,  8 Sep 2020 20:11:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] xen/balloon: try to merge system ram resources
Date: Tue,  8 Sep 2020 22:10:11 +0200
Message-Id: <20200908201012.44168-7-david@redhat.com>
In-Reply-To: <20200908201012.44168-1-david@redhat.com>
References: <20200908201012.44168-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: IINQM4O6FGD7OT345A4XO4IPEXJZ2IZX
X-Message-ID-Hash: IINQM4O6FGD7OT345A4XO4IPEXJZ2IZX
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>, Julien Grall <julien@xen.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IINQM4O6FGD7OT345A4XO4IPEXJZ2IZX/>
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
Q2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQpDYzogTWljaGFs
IEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+DQpDYzogQm9yaXMgT3N0cm92c2t5IDxib3Jpcy5vc3Ry
b3Zza3lAb3JhY2xlLmNvbT4NCkNjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQpD
YzogU3RlZmFubyBTdGFiZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPg0KQ2M6IFJvZ2Vy
IFBhdSBNb25uw6kgPHJvZ2VyLnBhdUBjaXRyaXguY29tPg0KQ2M6IEp1bGllbiBHcmFsbCA8anVs
aWVuQHhlbi5vcmc+DQpDYzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGEubGludXhAZ21haWwu
Y29tPg0KQ2M6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPg0KQ2M6IFdlaSBZYW5nIDxyaWNo
YXJkdy55YW5nQGxpbnV4LmludGVsLmNvbT4NClNpZ25lZC1vZmYtYnk6IERhdmlkIEhpbGRlbmJy
YW5kIDxkYXZpZEByZWRoYXQuY29tPg0KLS0tDQogZHJpdmVycy94ZW4vYmFsbG9vbi5jIHwgMiAr
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy94ZW4vYmFsbG9vbi5jIGIvZHJpdmVycy94ZW4vYmFsbG9vbi5jDQpp
bmRleCA3YmFjMzg3NjQ1MTNkLi5iNTdiMjA2N2VjYmZiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy94
ZW4vYmFsbG9vbi5jDQorKysgYi9kcml2ZXJzL3hlbi9iYWxsb29uLmMNCkBAIC0zMzEsNyArMzMx
LDcgQEAgc3RhdGljIGVudW0gYnBfc3RhdGUgcmVzZXJ2ZV9hZGRpdGlvbmFsX21lbW9yeSh2b2lk
KQ0KIAltdXRleF91bmxvY2soJmJhbGxvb25fbXV0ZXgpOw0KIAkvKiBhZGRfbWVtb3J5X3Jlc291
cmNlKCkgcmVxdWlyZXMgdGhlIGRldmljZV9ob3RwbHVnIGxvY2sgKi8NCiAJbG9ja19kZXZpY2Vf
aG90cGx1ZygpOw0KLQlyYyA9IGFkZF9tZW1vcnlfcmVzb3VyY2UobmlkLCByZXNvdXJjZSwgMCk7
DQorCXJjID0gYWRkX21lbW9yeV9yZXNvdXJjZShuaWQsIHJlc291cmNlLCBNRU1IUF9NRVJHRV9S
RVNPVVJDRSk7DQogCXVubG9ja19kZXZpY2VfaG90cGx1ZygpOw0KIAltdXRleF9sb2NrKCZiYWxs
b29uX211dGV4KTsNCiANCi0tIA0KMi4yNi4yDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52
ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1u
dmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
