Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CCB13CB30
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Jan 2020 18:42:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3137C10097DCC;
	Wed, 15 Jan 2020 09:46:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1F47C10097DC9
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 09:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1579110172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGVK8ThFyrWqCP/iFjE4FqksCllQrxiZsUlAeCJZIn8=;
	b=E+MVEjLG0IadGYhPd47vYdgN7yi9oTK8WFEKyyO/JtXm1z2AiacDvl8qMBHkszHp5ZohuN
	xmYf0mGP2QzeVYHv1sCGb6ndkRZV05sBGnMEoXAm7niZlA39mJDpSbjzSp7rjxXrW127Ba
	QzTd039TzSc6zJo47ntSzOX7w43W1Pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-opTDbA2qMXWjsZnVmX5AkA-1; Wed, 15 Jan 2020 12:42:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D71E8800A02;
	Wed, 15 Jan 2020 17:42:43 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BDB510372F3;
	Wed, 15 Jan 2020 17:42:43 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC PATCH] libnvdimm: Update the meaning for persistence_domain values
References: <20200108064905.170394-1-aneesh.kumar@linux.ibm.com>
	<x49o8v4oe0t.fsf@segfault.boston.devel.redhat.com>
	<a87b5da8-54d1-3c1a-f068-4d2f389576c9@linux.ibm.com>
	<0f44df90-1f75-9d0a-10af-6e7f48158bc7@linux.ibm.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Wed, 15 Jan 2020 12:42:42 -0500
In-Reply-To: <0f44df90-1f75-9d0a-10af-6e7f48158bc7@linux.ibm.com> (Aneesh
	Kumar K. V.'s message of "Wed, 15 Jan 2020 23:01:15 +0530")
Message-ID: <x49ftggobu5.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: opTDbA2qMXWjsZnVmX5AkA-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: R7GTPJXNR7WIKRHES4SIJY6XIILNUVBF
X-Message-ID-Hash: R7GTPJXNR7WIKRHES4SIJY6XIILNUVBF
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R7GTPJXNR7WIKRHES4SIJY6XIILNUVBF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

IkFuZWVzaCBLdW1hciBLLlYiIDxhbmVlc2gua3VtYXJAbGludXguaWJtLmNvbT4gd3JpdGVzOg0K
DQo+PiAvKg0KPj4gIMKgKiBQbGF0Zm9ybSBwcm92aWRlcyBtZWNoYW5pc21zIHRvIGZsdXNoIG91
dHN0YW5kaW5nIHdyaXRlIGRhdGENCj4+ICDCoCogdG8gcG1lbSBvbiBzeXN0ZW0gcG93ZXIgbG9z
cy4NCj4+ICDCoCovDQo+Pg0KPg0KPiBXYW50ZWQgdG8gYWRkIG1vcmUgZGV0YWlscy4gU28gd2l0
aCB0aGUgYWJvdmUgaW50ZXJwcmV0YXRpb24sIGlmIHRoZQ0KPiBwZXJzaXN0ZW5jZV9kb21haW4g
aXMgZm91bmQgdG8gYmUgJ2NwdV9jYWNoZScsIGFwcGxpY2F0aW9uIGNhbiBleHBlY3QNCj4gYSBz
dG9yZSBpbnN0cnVjdGlvbiB0byBndWFyYW50ZWUgcGVyc2lzdGVuY2UuIElmIGl0IGlzICdub25l
JyB0aGVyZSBpcw0KPiBubyBwZXJzaXN0ZW5jZSAoIEkgYW0gbm90IHN1cmUgaG93IHRoYXQgaXMg
dGhlIGRpZmZlcmVuY2UgZnJvbQ0KPiAndm9sYXRpbGUnIHBtZW0gcmVnaW9uKS4gSWYgaXQgaXMg
ICdtZW1vcnlfY29udHJvbGxlcicgKCBJIGFtIG5vdCBzdXJlDQo+IHdoZXRoZXIgdGhhdCBpcyB0
aGUgcmlnaHQgdGVybSksIGFwcGxpY2F0aW9uIG5lZWRzIHRvIGZvbGxvdyB0aGUNCj4gcmVjb21t
ZW5kZWQgbWVjaGFuaXNtIHRvIGZsdXNoIHdyaXRlIGRhdGEgdG8gcG1lbS4NCg0KVGhlcmUgaXMg
bm8gZW51bSBmb3IgIk5PTkUiLiAgSWYgdGhlcmUgaXMgbm8gcGVyc2lzdGVuY2UgZG9tYWluDQpz
cGVjaWZpZWQsIHRoZW4gaXQgaXMgdW5kZWZpbmVkL3Vua25vd24sIHdoaWNoIHJlc3VsdHMgaW4g
dGhlIG1lc3NhZ2U6DQoNCiAgbmRfcG1lbSBuYW1lc3BhY2UwLjA6IHVuYWJsZSB0byBndWFyYW50
ZWUgcGVyc2lzdGVuY2Ugb2Ygd3JpdGVzDQoNCk90aGVyIHRoYW4gdGhhdCwgeWVzLCB0aGF0J3Mg
cmlnaHQuDQoNCi1KZWZmDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4w
MS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVA
bGlzdHMuMDEub3JnCg==
