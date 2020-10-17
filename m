Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A56FB291208
	for <lists+linux-nvdimm@lfdr.de>; Sat, 17 Oct 2020 15:32:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BAEF7156716A1;
	Sat, 17 Oct 2020 06:32:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=160.16.240.163; helo=ducqcqzy.icu; envelope-from=admin@ducqcqzy.icu; receiver=<UNKNOWN> 
Received: from ducqcqzy.icu (tk2-262-40659.vs.sakura.ne.jp [160.16.240.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 898AC14B41B42
	for <linux-nvdimm@lists.01.org>; Sat, 17 Oct 2020 06:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=ducqcqzy.icu;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type;
 i=admin@ducqcqzy.icu;
 bh=Nkn3k5A3q5sAhDpAfVFWkkuO2Cnag7FGA9gkU5YSpbc=;
 b=MbVkuqQIii6D2i+PHaVX48VaQZ0dQSbqkmuyUL/KXk9CkfarwNwHZbCC5c/7L88yNq3BWJoY0t4R
   dZVRzxU/SW1Xfv6Ge75ywhGjuRdxEWtpYMmFlGWuijlyIeyjCiBq7bPyYA/y3sTHoOn/8qJurgNf
   DgP5cnMdR7xzKd+aS1Y=
Message-ID: <20201017213245585034@ducqcqzy.icu>
From: "Amazon.co.jp" <admin@ducqcqzy.icu>
To: <linux-nvdimm@lists.01.org>
Subject: =?utf-8?B?44GK5pSv5omV44GE5pa55rOV44Gu5oOF5aCx44KS5pu05paw?=
Date: Sat, 17 Oct 2020 21:32:35 +0800
MIME-Version: 1.0
Message-ID-Hash: 7BVWZRF7MFLK7BCQUE5KO6FUCZNRJCBT
X-Message-ID-Hash: 7BVWZRF7MFLK7BCQUE5KO6FUCZNRJCBT
X-MailFrom: admin@ducqcqzy.icu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7BVWZRF7MFLK7BCQUE5KO6FUCZNRJCBT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

IOOBguOBquOBn+OBruOCouOCq+OCpuODs+ODiOOBr+WBnOatouOBleOCjOOBvuOBl+OBnw0KDQog
DQrmlrDjgZfjgYTjg4fjg5DjgqTjgrnjgYvjgonjgqLjgqvjgqbjg7Pjg4jjgrXjg7zjg5Pjgrnj
gbjjga7jgrXjgqTjg7PjgqTjg7PjgYzmpJzlh7rjgZXjgozjgb7jgZfjgZ/jgIINCuiqsOOBi+OB
jOOBguOBquOBn+OBrkFtYXpvbuOCouOCq+OCpuODs+ODiOOBp+S7luOBruODh+ODkOOCpOOCueOB
i+OCieizvOWFpeOBl+OCiOOBhuOBqOOBl+OBvuOBl+OBn+OAgkFtYXpvbuOBruS/neitt+OBq+OB
iuOBkeOCi+OCu+OCreODpeODquODhuOCo+OBqOaVtOWQiOaAp+OBruWVj+mhjOOBq+OCiOOCiuOA
geOCu+OCreODpeODquODhuOCo+S4iuOBrueQhueUseOBi+OCieOCouOCq+OCpuODs+ODiOOBjOOD
reODg+OCr+OBleOCjOOBvuOBmeOAgg0K44Ki44Kr44Km44Oz44OI44KS5byV44GN57aa44GN5L2/
55So44GZ44KL44Gr44Gv44CBMjTmmYLplpPliY3jgavmg4XloLHjgpLmm7TmlrDjgZnjgovjgZPj
gajjgpLjgYrli6fjgoHjgZfjgb7jgZnjgILjgZ3jgozku6XlpJbjga7loLTlkIjjgIHjgYLjgarj
gZ/jga7jgqLjgqvjgqbjg7Pjg4jjga/msLjkuYXjg63jg4Pjgq/jgIIgDQoNCueiuuiqjeeUqOOC
ouOCq+OCpuODs+ODiCANCg0KDQoNCg0KDQoNCsKpIDIwMjAgQW1hem9uLmNvbSwgSW5jLiBvciBp
dHMgYWZmaWxpYXRlcy4gQWxsIHJpZ2h0cyByZXNlcnZlZC4gQW1hem9uLCBBbWF6b24uY28uanAs
IEFtYXpvbiBQcmltZSwgUHJpbWUg44GK44KI44GzQW1hem9uLmNvLmpwIOOBruODreOCtOOBryBB
bWF6b24uY29tICwgSW5jLuOBvuOBn+OBr+OBneOBrumWoumAo+S8muekvuOBruWVhuaomeOBp+OB
meOAgiBBbWF6b24uY29tLCA0MTAgVGVycnkgQXZlbnVlIE4uLCBTZWF0dGxlLCBXQSA5ODEwOS01
MjEwIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5z
dWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3Jn
Cg==
