Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C622AFA03
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Nov 2020 21:48:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 085AA169A377A;
	Wed, 11 Nov 2020 12:48:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=50.31.38.73; helo=o1.ptr2397.indusdrills.org; envelope-from=bounces+19272268-890e-linux-nvdimm=lists.01.org@em8497.indusdrills.org; receiver=<UNKNOWN> 
Received: from o1.ptr2397.indusdrills.org (o1.ptr2397.indusdrills.org [50.31.38.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 82FC216765347
	for <linux-nvdimm@lists.01.org>; Wed, 11 Nov 2020 12:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=indusdrills.org; h=from:to:subject:mime-version:content-type;
	s=s1; bh=wkdgBlK3V3w26EfUWJIK997b5Gg1YQlvLOzVVaWmp1c=; b=uquBtVi
	wR9KVxKzhoIQBN7tcKLa0T6puA7vWnWYJLcuoSwczkm2CgOpmTkaRmsEzBDTLBHP
	4XkXYkmtKr5XE9eo6u7/EZmHGb4lTBoqG9bEj1PD/bwwQGQCQTTuABNDSfDyrDBT
	BVKydlX8Vo+DaHkYjtfZIU38CKJZwoziawNI=
Received: by filter2727p1mdw1.sendgrid.net with SMTP id filter2727p1mdw1-29611-5FAC4E2C-B
        2020-11-11 20:48:44.213297694 +0000 UTC m=+515640.438828997
Received: from ec2-99-79-56-76.ca-central-1.compute.amazonaws.com (unknown)
	by ismtpd0017p1iad2.sendgrid.net (SG) with ESMTP id nxsnHl0iQ1KLM1JDQuSYPg
	for <linux-nvdimm@lists.01.org>; Wed, 11 Nov 2020 20:48:44.138 +0000 (UTC)
From: "support@lists.01.org" <mail@indusdrills.org>
To: linux-nvdimm@lists.01.org
Subject: New Recording [13913790]
Date: Wed, 11 Nov 2020 20:48:44 +0000 (UTC)
Message-ID: <20201111204844.EEF3BA449B1D3B3C@indusdrills.org>
MIME-Version: 1.0
X-SG-EID: ke+Bwwuh8DadKJDZimY4ZO2X8vVub/nPehTySyaiYrRoVXEpHsk1kEW95V6hvgw2x8ZkvoK+miiN+C
 ygHIoguxA6Dp2DtxzWDhL17UF7EGeZVSjP6xPM9EZ7exDJ004E0SuJ3Ntvj2GEY3H8v2ZED8lBf5d8
 Ndn289W9nYgqtT+Ej/j/kRg3NZsT+GzflbJ/VfkmeelH106t7GXrpIxnKITfY/XlmZ1hltmZ26lLFl
 ykpuyDorq+C2zhHZdezPuH
X-Entity-ID: dhzRN/rFlU4I7ApPkNgmNA==
Message-ID-Hash: GWUSBJ5THLDLQHCTYK4A6ENLBLXX26BR
X-Message-ID-Hash: GWUSBJ5THLDLQHCTYK4A6ENLBLXX26BR
X-MailFrom: bounces+19272268-890e-linux-nvdimm=lists.01.org@em8497.indusdrills.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GWUSBJ5THLDLQHCTYK4A6ENLBLXX26BR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

wqANCsKgDQoNCklEOiA8IGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcgPg0KDQpBIGNhbGxlciBp
biB5b3VyIGRpcmVjdG9yeSBqdXN0IGxlZnQgeW91IGEgbWVzc2FnZS4NCg0KQ2FsbGVyIDogKzEg
NzAxIDMyOCA5MDEwDQpEYXRlOiAxMS0xMC0yMDIwDQpEdXJhdGlvbjogMDE6MHNlYw0KDQpMaXN0
ZW4gdG8gVm9pY2UgTWVzc8SFZ2UgDQoowqBodHRwczovL3UxOTI3MjI2OC5jdC5zZW5kZ3JpZC5u
ZXQvbHMvY2xpY2s/dXBuPWNKRkpueTN4Y1NIZFdGQi0yQm1XZENrS29KN3Y0bGN2WWMtMkJzRlZI
NzRTeE5YbjV4bzAxLTJCem8ySGRTVUtxd1g3TmxSM2swZmhiNkxTNUFnZXVRUlJRREswNkxCc2x4
N3BuUUhmWi0yQmtFbHVvRGhGWHBTMlJwS0M3bmtQVm91V0JkcTQzbUgtMkJDSGxBLTJGVXVMNnh2
cm5EREhaZy0zRC0zRElkTlZfNnB3S0hKOFBoMVhUeXY3T05abE9CSkpRRzJ6NXN3dDEweUJhLTJG
WWNiZVl3THhnNC0yRlhKQ2hycFdHZXV4Y2tISU5nZE5zNjVndWFuMUNPc0N2cGh0M28xQkZvLTJC
RjBCbEg2dFZ2aG8wLTJGWlp1bG1TNm5uSGloTUVzS0ctMkZaZHZ0TGQ2QXFLRmtueGRPZXljVFUx
V0V5NWhwRXRjN29RaEhpNjFNOS0yRlVrMUppOVV5bEw0ZUZhV3JQMG9BcFZULTJGekJQMWRMVzJv
OGtYdVZ5eDA0ZjVCdlhFcGlURzJYNmZlc01VUXpsUjgwT3dFbXNvLTNEDQoNCkVtYWlsIHdhcyBz
ZW50IHRvIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcNCg0KWW91ciBtZXNzYWdlIGxpbmsgbGFz
dCBmb3IgMTIgaG91cnPCoApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4w
MS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVA
bGlzdHMuMDEub3JnCg==
