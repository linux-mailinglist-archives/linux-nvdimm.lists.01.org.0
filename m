Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD50B3235DF
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Feb 2021 03:47:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0CFCA100F224E;
	Tue, 23 Feb 2021 18:47:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CFB22100EB35A
	for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 18:47:44 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id g5so639000ejt.2
        for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 18:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=plyZ7GAQ1sguodJFZWB3Wyxamln+YuknxjJ8VQ+lmZk=;
        b=uU6NdlHQLS5/m8Y+LINo6vG60n9UKXoXhUiHlmlu29jVNsub+K0p/vq0FubPFDlcLE
         35hop0g4y2GKwmMcKxaOifKyhuS55u7KpxjbYh/uUEaV3JKDOBo3VGuUmsqB4gLC+NRd
         SHiJ+HUroN4NG7qJ7j/qyjD2mJKQ8upzL1C/2X3Rbixp2J3zJek73/2f/FpiWfgydaU8
         eSnaERxkwJGXLCSnFKiQ8eKFC19VGN4eE1ZhZ/Iq/QUQgYcaoNnM6DKGWMQsI/qUDmlO
         k8TYSQMudoWbhWXToIXMlN6rAkbw42Z3jiSHodBFsL+ykFwQCI8D6La+0kqC+O/Ykym9
         +Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=plyZ7GAQ1sguodJFZWB3Wyxamln+YuknxjJ8VQ+lmZk=;
        b=NgCIFn14SuvToMXZ17+jsFMMw+inCFzdwrRMmCxKISGoCC1V+4JI7hgh3+PrucCkZ9
         mbi2bpJwUa4DuzJ3kRcNthxVN9BYaBBNlatwW9jd7nUpeXklo4CBV5Xa+mCj8DU52WjO
         SUcw7n4GjJzeCjBvv9skidlK+3o3P2lx45pVXnp+wuZsJtpJMDddy6zLj+t91NdoyLRK
         56sOfgwvIk3N/qR3sLZm2WRGMqMGIY6jjoUliYnzbi8t8Pth2Jmv65NdXWbRUllZkH+e
         z4FZwSG6WapANLqFLSb1at1BX1mXZ1t5npbEFup+RQykEIg1JH48y8dpksraK0d2U+u7
         qTyA==
X-Gm-Message-State: AOAM532GgzpEqE2FoP5Y0ylnWRgpzKrGj/X982WIeldetX4uHuhJor4M
	BacZIsUL32gOyQ34CbGiBr4m33m4M7S0Mez5UpiP3A==
X-Google-Smtp-Source: ABdhPJx40sSr690z64AyYJ2UeMEz9ruKpjuG1fr9tJfQjzXttXEB1XNRfp68pnQ+aRSTwtGArdvDSxpkARfCXup4hfE=
X-Received: by 2002:a17:906:f18a:: with SMTP id gs10mr531359ejb.341.1614134862607;
 Tue, 23 Feb 2021 18:47:42 -0800 (PST)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Feb 2021 18:47:38 -0800
Message-ID: <CAPcyv4i1-mwp8B0Y_hR44rGh9qUPuDiZeiUFJ_TJzvPoENa-pQ@mail.gmail.com>
Subject: [GIT PULL] libnvdimm + device-dax for v5.12-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: KBH6BO2GX7XZYCJTGH3JYQYSSAQ4Z7LI
X-Message-ID-Hash: KBH6BO2GX7XZYCJTGH3JYQYSSAQ4Z7LI
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KBH6BO2GX7XZYCJTGH3JYQYSSAQ4Z7LI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTGludXMsIHBsZWFzZSBwdWxsIGZyb206DQoNCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L252ZGltbS9udmRpbW0NCnRhZ3MvbGlibnZkaW1tLWZvci01
LjEyDQoNCi4uLnRvIHJlY2VpdmUgc29tZSBtaXNjZWxsYW5lb3VzIGNsZWFudXBzIGFuZCBhIGZp
eCBmb3IgdjUuMTIuIFRoaXMNCm1haW5seSBjb250aW51ZXMgdGhlIGtlcm5lbCB3aWRlIGVmZm9y
dCB0byByZW1vdmUgYSByZXR1cm4gY29kZSBmcm9tDQp0aGUgcmVtb3ZlKCkgY2FsbGJhY2sgaW4g
dGhlIGRyaXZlciBtb2RlbC4gVGhlIGZpeCBhZGRyZXNzZXMgYSByZXR1cm4NCmNvZGUgcG9sYXJp
dHkgdHlwbyBpbiB0aGUgbmV3IHN5c2ZzIGF0dHJpYnV0ZSB0byBtYW51YWxseSBzcGVjaWZ5IGEN
CmRldmljZS1kYXggaW5zdGFuY2UgbWFwcGluZyByYW5nZS4gVGhpcyBoYXMgYWxsIGFwcGVhcmVk
IGluIC1uZXh0IHdpdGgNCm5vIHJlcG9ydGVkIGlzc3Vlcy4NCg0KLS0tDQoNClRoZSBmb2xsb3dp
bmcgY2hhbmdlcyBzaW5jZSBjb21taXQgMTA0OGJhODNmYjFjMDBjZDI0MTcyZTIzZTgyNjM5NzJm
NmI1ZDlhYzoNCg0KICBMaW51eCA1LjExLXJjNiAoMjAyMS0wMS0zMSAxMzo1MDowOSAtMDgwMCkN
Cg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L252ZGltbS9udmRpbW0NCnRhZ3Mv
bGlibnZkaW1tLWZvci01LjEyDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA2NGZm
ZTg0MzIwNzQ1ZWE4MzY1NTVhZDIwN2ViZmIwZTg5NmI2MTY3Og0KDQogIE1lcmdlIGJyYW5jaCAn
Zm9yLTUuMTIvZGF4JyBpbnRvIGZvci01LjEyL2xpYm52ZGltbSAoMjAyMS0wMi0yMw0KMTg6MTM6
NDUgLTA4MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCmxpYm52ZGltbSArIGRldmljZS1kYXggZm9yIDUuMTINCg0K
LSBGaXggdGhlIGVycm9yIGNvZGUgcG9sYXJpdHkgZm9yIHRoZSBkZXZpY2UtZGF4L21hcHBpbmcg
YXR0cmlidXRlDQoNCi0gRm9yIHRoZSBkZXZpY2UtZGF4IGFuZCBsaWJudmRpbW0gYnVzIGltcGxl
bWVudGF0aW9ucyBzdG9wIGltcGxlbWVudGluZw0KICBhIHVzZWxlc3MgcmV0dXJuIGNvZGUgZm9y
IHRoZSByZW1vdmUoKSBjYWxsYmFjay4NCg0KLSBNaXNjZWxsYW5lb3VzIGNsZWFudXBzDQoNCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCkRhbiBXaWxsaWFtcyAoMSk6DQogICAgICBNZXJnZSBicmFuY2ggJ2Zvci01LjEyL2Rh
eCcgaW50byBmb3ItNS4xMi9saWJudmRpbW0NCg0KU2hpeWFuZyBSdWFuICgxKToNCiAgICAgIGRl
dmljZS1kYXg6IEZpeCBkZWZhdWx0IHJldHVybiBjb2RlIG9mIHJhbmdlX3BhcnNlKCkNCg0KVXdl
IEtsZWluZS1Lw7ZuaWcgKDcpOg0KICAgICAgbGlibnZkaW1tL2RpbW06IFNpbXBsaWZ5IG52ZGlt
bV9yZW1vdmUoKQ0KICAgICAgbGlibnZkaW1tOiBNYWtlIHJlbW92ZSBjYWxsYmFjayByZXR1cm4g
dm9pZA0KICAgICAgZGV2aWNlLWRheDogUHJldmVudCByZWdpc3RlcmluZyBkcml2ZXJzIHdpdGhv
dXQgcHJvYmUgY2FsbGJhY2sNCiAgICAgIGRldmljZS1kYXg6IFByb3Blcmx5IGhhbmRsZSBkcml2
ZXJzIHdpdGhvdXQgcmVtb3ZlIGNhbGxiYWNrDQogICAgICBkZXZpY2UtZGF4OiBGaXggZXJyb3Ig
cGF0aCBpbiBkYXhfZHJpdmVyX3JlZ2lzdGVyDQogICAgICBkZXZpY2UtZGF4OiBEcm9wIGFuIGVt
cHR5IC5yZW1vdmUgY2FsbGJhY2sNCiAgICAgIGRheC1kZXZpY2U6IE1ha2UgcmVtb3ZlIGNhbGxi
YWNrIHJldHVybiB2b2lkDQoNCiBkcml2ZXJzL2RheC9idXMuYyAgICAgICAgIHwgMjQgKysrKysr
KysrKysrKysrKysrKysrLS0tDQogZHJpdmVycy9kYXgvYnVzLmggICAgICAgICB8ICAyICstDQog
ZHJpdmVycy9kYXgvZGV2aWNlLmMgICAgICB8ICA4ICstLS0tLS0tDQogZHJpdmVycy9kYXgva21l
bS5jICAgICAgICB8ICA3ICsrLS0tLS0NCiBkcml2ZXJzL2RheC9wbWVtL2NvbXBhdC5jIHwgIDMg
Ky0tDQogZHJpdmVycy9udmRpbW0vYmxrLmMgICAgICB8ICAzICstLQ0KIGRyaXZlcnMvbnZkaW1t
L2J1cy5jICAgICAgfCAxMyArKysrKy0tLS0tLS0tDQogZHJpdmVycy9udmRpbW0vZGltbS5jICAg
ICB8ICA3ICstLS0tLS0NCiBkcml2ZXJzL252ZGltbS9wbWVtLmMgICAgIHwgIDQgKy0tLQ0KIGRy
aXZlcnMvbnZkaW1tL3JlZ2lvbi5jICAgfCAgNCArLS0tDQogaW5jbHVkZS9saW51eC9uZC5oICAg
ICAgICB8ICAyICstDQogMTEgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgNDEgZGVs
ZXRpb25zKC0pCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpU
byB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4w
MS5vcmcK
