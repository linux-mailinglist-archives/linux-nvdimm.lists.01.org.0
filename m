Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D840E24A358
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 17:41:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2B0621342F390;
	Wed, 19 Aug 2020 08:41:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com; envelope-from=adrianhuang0701@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F00F21342F38C
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 08:41:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so10993615plb.12
        for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MR6pDQU/pCrfoo6cohrKXAcJ2u5y3qBI5bx+uWcEzzw=;
        b=l3QmwBvQg1tI8T+hdzblp52YmrIPsGodBDi0tupyUv/mL6oPSaivJkQTTb89Xg6TDh
         NZjOOQpC1dSEuHEWt49eAOteddvz0nD6lDNKIU6WfO4b9T3pVsC/rY/xG5x+22vNfis6
         QI1zyR7hHHAR8LeXJXzdlb8lzf3/XqfB6W6z1xpTZ57dPeGDZ1b0C+fAkxUiAcxYUKi8
         P0AxlNF5zxV2lYXbuFt2IKlvA0i9JK/rbOsSKUsvZpAXV4DagnQ1Q2LUWYqlpJ3tIQCc
         5CseMqIsqi+oDgzM9rjCyZ5UGuyRWiw9JRPLPnoFDaqj4dbskkJheWXbXgnuVHNmXGFu
         ftrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MR6pDQU/pCrfoo6cohrKXAcJ2u5y3qBI5bx+uWcEzzw=;
        b=Kv0RKML32Q1LU281U+0dJQ6oc02rgjj265F7/EHG2ME9DipSiugs9fi9pPLyXUJbnd
         yrzR9xlL5p7Lf5vGz6vT46HUH5LdUbG6FarKb2xOD8/aEpdJPQDkUxmGbx3eB/2wuv7o
         9P/SQfInQxDG5GLDk5DboNhpo5C7JL6yrTlGPHfLQzZv4bD5VJq+pYik978CSWOku7HU
         wM+ch3FIaGUkUNW6o3ye5DFc4ozZ28YUnSmsIfDSuNOl7VE1dg/7lWuEw6uohb0fgX9Q
         D46evxzSs4JtYAs1VM0I/s07nZh0p3EpbqdQuKibXpM2kRX+wd8FQnbPXVWOERex687O
         +r/Q==
X-Gm-Message-State: AOAM5337l/9YDxFf8WCH6xPyoBbXc4596cKGgtUm2uEujGNFFXLwbCiD
	B43PdBkxPInXeSAFjP44CmFu7qSQy/HZrg==
X-Google-Smtp-Source: ABdhPJwmPg/yfBXaNW/MjehltVmLyM8tfWaa4tSE3SIsEW+yZwX6Nu/8kwz0+p4iCx66XTQuid9J1g==
X-Received: by 2002:a17:902:6545:: with SMTP id d5mr16273252pln.257.1597851695107;
        Wed, 19 Aug 2020 08:41:35 -0700 (PDT)
Received: from AHUANG12-1LT7M0.lenovo.com (220-143-146-169.dynamic-ip.hinet.net. [220.143.146.169])
        by smtp.googlemail.com with ESMTPSA id a8sm14033777pga.69.2020.08.19.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 08:41:34 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH 1/1] dax: do not print error message for non-persistent memory block device
Date: Wed, 19 Aug 2020 23:42:36 +0800
Message-Id: <20200819154236.24191-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Message-ID-Hash: RFA3QBKQ24LXMGZYDECELG24UJ4RKLUK
X-Message-ID-Hash: RFA3QBKQ24LXMGZYDECELG24UJ4RKLUK
X-MailFrom: adrianhuang0701@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Adrian Huang <ahuang12@lenovo.com>, Coly Li <colyli@suse.de>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RFA3QBKQ24LXMGZYDECELG24UJ4RKLUK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RnJvbTogQWRyaWFuIEh1YW5nIDxhaHVhbmcxMkBsZW5vdm8uY29tPg0KDQpGcm9tOiBBZHJpYW4g
SHVhbmcgPGFodWFuZzEyQGxlbm92by5jb20+DQoNCkNvbW1pdCAyMzE2MDk3ODVjYmYgKCJkYXg6
IHByaW50IGVycm9yIG1lc3NhZ2UgYnkgcHJfaW5mbygpDQppbiBfX2dlbmVyaWNfZnNkYXhfc3Vw
cG9ydGVkKCkiKSBoYXBwZW5zIHRvIHByaW50IHRoZSBmb2xsb3dpbmcNCmVycm9yIG1lc3NhZ2Ug
ZHVyaW5nIGJvb3Rpbmcgd2hlbiB0aGUgbm9uLXBlcnNpc3RlbnQgbWVtb3J5IGJsb2NrDQpkZXZp
Y2VzIGFyZSBjb25maWd1cmVkIGJ5IGRldmljZSBtYXBwZXIuIFRob3NlIGVycm9yIG1lc3NhZ2Vz
IGFyZQ0KY2F1c2VkIGJ5IHRoZSB2YXJpYWJsZSAnZGF4X2RldicgaXMgTlVMTC4gVXNlcnMgbWln
aHQgYmUgY29uZnVzZWQNCndpdGggdGhvc2UgZXJyb3IgbWVzc2FnZXMgc2luY2UgdGhleSBkbyBu
b3QgdXNlIHRoZSBwZXJzaXN0ZW50DQptZW1vcnkgZGV2aWNlLiBNb3Jlb3ZlciwgdXNlcnMgbWln
aHQgc2NhcmUgYWJvdXQgIndoYXQncyB3cm9uZw0Kd2l0aCBteSBkaXNrcyIgYmVjYXVzZSB0aGV5
IHNlZSB0aGUgJ2Vycm9yJyBhbmQgJ2ZhaWxlZCcga2V5d29yZHMuDQoNCiAgIyBkbWVzZyB8IGdy
ZXAgZmFpbA0KICBzZGszOiBlcnJvcjogZGF4IGFjY2VzcyBmYWlsZWQgKC05NSkNCiAgc2RrMzog
ZXJyb3I6IGRheCBhY2Nlc3MgZmFpbGVkICgtOTUpDQogIHNkazM6IGVycm9yOiBkYXggYWNjZXNz
IGZhaWxlZCAoLTk1KQ0KICBzZGszOiBlcnJvcjogZGF4IGFjY2VzcyBmYWlsZWQgKC05NSkNCiAg
c2RrMzogZXJyb3I6IGRheCBhY2Nlc3MgZmFpbGVkICgtOTUpDQogIHNkazM6IGVycm9yOiBkYXgg
YWNjZXNzIGZhaWxlZCAoLTk1KQ0KICBzZGszOiBlcnJvcjogZGF4IGFjY2VzcyBmYWlsZWQgKC05
NSkNCiAgc2RrMzogZXJyb3I6IGRheCBhY2Nlc3MgZmFpbGVkICgtOTUpDQogIHNkazM6IGVycm9y
OiBkYXggYWNjZXNzIGZhaWxlZCAoLTk1KQ0KICBzZGIzOiBlcnJvcjogZGF4IGFjY2VzcyBmYWls
ZWQgKC05NSkNCiAgc2RiMzogZXJyb3I6IGRheCBhY2Nlc3MgZmFpbGVkICgtOTUpDQogIHNkYjM6
IGVycm9yOiBkYXggYWNjZXNzIGZhaWxlZCAoLTk1KQ0KICBzZGIzOiBlcnJvcjogZGF4IGFjY2Vz
cyBmYWlsZWQgKC05NSkNCiAgc2RiMzogZXJyb3I6IGRheCBhY2Nlc3MgZmFpbGVkICgtOTUpDQog
IHNkYjM6IGVycm9yOiBkYXggYWNjZXNzIGZhaWxlZCAoLTk1KQ0KICBzZGIzOiBlcnJvcjogZGF4
IGFjY2VzcyBmYWlsZWQgKC05NSkNCiAgc2RiMzogZXJyb3I6IGRheCBhY2Nlc3MgZmFpbGVkICgt
OTUpDQogIHNkYjM6IGVycm9yOiBkYXggYWNjZXNzIGZhaWxlZCAoLTk1KQ0KDQogICMgbHNibGsN
CiAgTkFNRSAgICAgICAgICAgIE1BSjpNSU4gUk0gICBTSVpFIFJPIFRZUEUgTU9VTlRQT0lOVA0K
ICBzZGEgICAgICAgICAgICAgICA4OjAgICAgMCAgIDEuMVQgIDAgZGlzaw0KICDilJzilIBzZGEx
ICAgICAgICAgICAgODoxICAgIDAgICAxNTZNICAwIHBhcnQNCiAg4pSc4pSAc2RhMiAgICAgICAg
ICAgIDg6MiAgICAwICAgIDQwRyAgMCBwYXJ0DQogIOKUlOKUgHNkYTMgICAgICAgICAgICA4OjMg
ICAgMCAgIDEuMVQgIDAgcGFydA0KICBzZGIgICAgICAgICAgICAgICA4OjE2ICAgMCAgIDEuMVQg
IDAgZGlzaw0KICDilJzilIBzZGIxICAgICAgICAgICAgODoxNyAgIDAgICA2MDBNICAwIHBhcnQN
CiAg4pSc4pSAc2RiMiAgICAgICAgICAgIDg6MTggICAwICAgICAxRyAgMCBwYXJ0DQogIOKUlOKU
gHNkYjMgICAgICAgICAgICA4OjE5ICAgMCAgIDEuMVQgIDAgcGFydA0KICAgIOKUnOKUgHJoZWww
MC1zd2FwIDI1NDozICAgIDAgICAgIDRHICAwIGx2bQ0KICAgIOKUnOKUgHJoZWwwMC1ob21lIDI1
NDo0ICAgIDAgICAgIDFUICAwIGx2bQ0KICAgIOKUlOKUgHJoZWwwMC1yb290IDI1NDo1ICAgIDAg
ICAgNTBHICAwIGx2bQ0KICBzZGMgICAgICAgICAgICAgICA4OjMyICAgMCAgIDEuMVQgIDAgZGlz
aw0KICBzZGQgICAgICAgICAgICAgICA4OjQ4ICAgMCAgIDEuMVQgIDAgZGlzaw0KICBzZGUgICAg
ICAgICAgICAgICA4OjY0ICAgMCAgIDEuMVQgIDAgZGlzaw0KICBzZGYgICAgICAgICAgICAgICA4
OjgwICAgMCAgIDEuMVQgIDAgZGlzaw0KICBzZGcgICAgICAgICAgICAgICA4Ojk2ICAgMCAgIDEu
MVQgIDAgZGlzaw0KICBzZGggICAgICAgICAgICAgICA4OjExMiAgMCAgIDMuM1QgIDAgZGlzaw0K
ICDilJzilIBzZGgxICAgICAgICAgICAgODoxMTMgIDAgICA1MDBNICAwIHBhcnQgL2Jvb3QvZWZp
DQogIOKUnOKUgHNkaDIgICAgICAgICAgICA4OjExNCAgMCAgICA0MEcgIDAgcGFydCAvDQogIOKU
nOKUgHNkaDMgICAgICAgICAgICA4OjExNSAgMCAgIDIuOVQgIDAgcGFydCAvaG9tZQ0KICDilJTi
lIBzZGg0ICAgICAgICAgICAgODoxMTYgIDAgMzE0LjZHICAwIHBhcnQgW1NXQVBdDQogIHNkaSAg
ICAgICAgICAgICAgIDg6MTI4ICAwICAgMS4xVCAgMCBkaXNrDQogIHNkaiAgICAgICAgICAgICAg
IDg6MTQ0ICAwICAgMy4zVCAgMCBkaXNrDQogIOKUnOKUgHNkajEgICAgICAgICAgICA4OjE0NSAg
MCAgIDUxMk0gIDAgcGFydA0KICDilJTilIBzZGoyICAgICAgICAgICAgODoxNDYgIDAgICAzLjNU
ICAwIHBhcnQNCiAgc2RrICAgICAgICAgICAgICAgODoxNjAgIDAgMTE5LjJHICAwIGRpc2sNCiAg
4pSc4pSAc2RrMSAgICAgICAgICAgIDg6MTYxICAwICAgMjAwTSAgMCBwYXJ0DQogIOKUnOKUgHNk
azIgICAgICAgICAgICA4OjE2MiAgMCAgICAgMUcgIDAgcGFydA0KICDilJTilIBzZGszICAgICAg
ICAgICAgODoxNjMgIDAgICAxMThHICAwIHBhcnQNCiAgICDilJzilIByaGVsLXN3YXAgICAyNTQ6
MCAgICAwICAgICA0RyAgMCBsdm0NCiAgICDilJzilIByaGVsLWhvbWUgICAyNTQ6MSAgICAwICAg
IDY0RyAgMCBsdm0NCiAgICDilJTilIByaGVsLXJvb3QgICAyNTQ6MiAgICAwICAgIDUwRyAgMCBs
dm0NCiAgc2RsICAgICAgICAgICAgICAgODoxNzYgIDAgMTE5LjJHICAwIGRpc2sNCg0KVGhlIGNh
bGwgcGF0aCBpcyBzaG93biBhcyBmb2xsb3dzOg0KICBkbV90YWJsZV9kZXRlcm1pbmVfdHlwZQ0K
ICAgIGRtX3RhYmxlX3N1cHBvcnRzX2RheA0KICAgICBkZXZpY2Vfc3VwcG9ydHNfZGF4DQogICAg
ICAgZ2VuZXJpY19mc2RheF9zdXBwb3J0ZWQNCiAgICAgICAgX19nZW5lcmljX2ZzZGF4X3N1cHBv
cnRlZA0KDQpXaXRoIHRoZSBkaXNrIGNvbmZpZ3VyYXRpb24gbGlzdGluZyBmcm9tIHRoZSBjb21t
YW5kICdsc2JsaycsDQp0aGUgbWVtYmVyICdkZXYtPmRheF9kZXYnIG9mIHRoZSBibG9jayBkZXZp
Y2VzICdzZGIzJyBhbmQgJ3NkazMnDQooY29uZmlndXJlZCBieSBkZXZpY2UgbWFwcGVyKSBpcyBO
VUxMIGluIGZ1bmN0aW9uDQpnZW5lcmljX2ZzZGF4X3N1cHBvcnRlZCgpIGJlY2F1c2UgdGhlIG1l
bWJlciBpcyBjb25maWd1cmVkIGluDQpmdW5jdGlvbiBvcGVuX3RhYmxlX2RldmljZSgpLg0KDQpU
byBwcmV2ZW50IHRoZSBjb25mdXNpbmcgZXJyb3IgbWVzc2FnZXMgaW4gdGhpcyBzY2VuYXJpbyAo
dGhpcyBpcw0Kbm9ybWFsIGJlaGF2aW9yKSwganVzdCBwcmludCB0aG9zZSBlcnJvciBtZXNzYWdl
cyBieSBwcl9kZWJ1ZygpDQpieSBjaGVja2luZyBpZiBkYXhfZGV2IGlzIE5VTEwgYW5kIHRoZSBi
bG9jayBkZXZpY2UgZG9lcyBub3Qgc3VwcG9ydA0KREFYLg0KDQpGaXhlczogMjMxNjA5Nzg1Y2Jm
ICgiZGF4OiBwcmludCBlcnJvciBtZXNzYWdlIGJ5IHByX2luZm8oKSBpbiBfX2dlbmVyaWNfZnNk
YXhfc3VwcG9ydGVkKCkiKQ0KQ2M6IENvbHkgTGkgPGNvbHlsaUBzdXNlLmRlPg0KQ2M6IERhbiBX
aWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KQ2M6IEFsYXNkYWlyIEtlcmdvbiA8
YWdrQHJlZGhhdC5jb20+DQpDYzogTWlrZSBTbml0emVyIDxzbml0emVyQHJlZGhhdC5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBBZHJpYW4gSHVhbmcgPGFodWFuZzEyQGxlbm92by5jb20+DQotLS0NCiBk
cml2ZXJzL2RheC9zdXBlci5jIHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RheC9zdXBlci5jIGIvZHJpdmVycy9kYXgv
c3VwZXIuYw0KaW5kZXggYzgyY2JjYjY0MjAyLi4zMjY0MjYzNGMxYmIgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2RheC9zdXBlci5jDQorKysgYi9kcml2ZXJzL2RheC9zdXBlci5jDQpAQCAtMTAwLDYg
KzEwMCwxMiBAQCBib29sIF9fZ2VuZXJpY19mc2RheF9zdXBwb3J0ZWQoc3RydWN0IGRheF9kZXZp
Y2UgKmRheF9kZXYsDQogCQlyZXR1cm4gZmFsc2U7DQogCX0NCiANCisJaWYgKCFkYXhfZGV2ICYm
ICFiZGV2X2RheF9zdXBwb3J0ZWQoYmRldiwgYmxvY2tzaXplKSkgew0KKwkJcHJfZGVidWcoIiVz
OiBlcnJvcjogZGF4IHVuc3VwcG9ydGVkIGJ5IGJsb2NrIGRldmljZVxuIiwNCisJCQkJYmRldm5h
bWUoYmRldiwgYnVmKSk7DQorCQlyZXR1cm4gZmFsc2U7DQorCX0NCisNCiAJaWQgPSBkYXhfcmVh
ZF9sb2NrKCk7DQogCWxlbiA9IGRheF9kaXJlY3RfYWNjZXNzKGRheF9kZXYsIHBnb2ZmLCAxLCAm
a2FkZHIsICZwZm4pOw0KIAlsZW4yID0gZGF4X2RpcmVjdF9hY2Nlc3MoZGF4X2RldiwgcGdvZmZf
ZW5kLCAxLCAmZW5kX2thZGRyLCAmZW5kX3Bmbik7DQotLSANCjIuMTcuMQ0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcg
bGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4g
ZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
