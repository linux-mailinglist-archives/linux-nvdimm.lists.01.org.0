Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1442B3514
	for <lists+linux-nvdimm@lfdr.de>; Sun, 15 Nov 2020 14:43:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CA798100ED482;
	Sun, 15 Nov 2020 05:43:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.106.76.103; helo=nyaaioev9h2; envelope-from=updateaccount@transmit.monster; receiver=<UNKNOWN> 
Received: from nyaaIoEv9H2 (unknown [170.106.76.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1089E100EF27E
	for <linux-nvdimm@lists.01.org>; Sun, 15 Nov 2020 05:43:37 -0800 (PST)
Received: from lgf (unknown [222.247.190.89])
	by nyaaIoEv9H2 (Postfix) with ESMTPA id 566B01F894
	for <linux-nvdimm@lists.01.org>; Sun, 15 Nov 2020 21:38:58 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 nyaaIoEv9H2 566B01F894
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transmit.monster;
	s=default; t=1605447539;
	bh=vLXqldn9V0cuUxjZoUAI/xnUwYvZWIXRWKiEYu0TCMY=;
	h=From:To:Subject:Date:From;
	b=wXipkDUeKYHPLTa3XteH0UowWQdsKUL2jhbHs/mzAZpQCJBWjU/3tcsoLjDDoFiej
	 em2OELvihUVngUnnZsMSX3mjbaouaBsrDHUd8bzfnji5Z1SHyEYM7+x30Wgg/oo/Bb
	 TtI8TzQPfU4QN8T0Fm8Mz/up7Sts24bNNOLSTr1M=
Message-ID: <98CA26804BBFB2E9A3FC930E1061846B@lgf>
From: =?utf-8?B?QW1hem9u44GL44KJ44GuIOOBiuefpeOCieOBmw==?= <updateaccount@transmit.monster>
To: <linux-nvdimm@lists.01.org>
Subject: =?utf-8?B?QW1hem9uLmNvLmpwIOmHjeimgeOBquOBiuefpeOCieOBmw==?=
	=?utf-8?B?77ya44GK5pSv5omV44GE5pa55rOV44Gu5oOF5aCx44KS5pu05paw44GX44Gm44GP44Gg44GV44GE?=
Date: Sun, 15 Nov 2020 21:38:44 +0800
MIME-Version: 1.0
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
Message-ID-Hash: MI5Z6WIPCCJZEPB7FNC3LSZWKQ4QNA3P
X-Message-ID-Hash: MI5Z6WIPCCJZEPB7FNC3LSZWKQ4QNA3P
X-MailFrom: updateaccount@transmit.monster
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MI5Z6WIPCCJZEPB7FNC3LSZWKQ4QNA3P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCg0KDQoNCg0KDQoNCg0KDQpBbWF6b24uY28uanANCuOCq+ODvOODieOBruWIqeeUqOaJv+iq
jeOBjOW+l+OCieOCjOOBvuOBm+OCk+OBp+OBl+OBnw0K55Wq5Y+377yaODYxLTM3MTg4OTYtMDU5
NDEzNg0KbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZ+anmA0KQW1hem9u44OX44Op44Kk44Og44Kk
44Og44Gu54Sh5paZ5L2T6aiT44Gr44GU55m76Yyy44GE44Gf44Gg44GN44G+44GX44Gm6Kqg44Gr
44GC44KK44GM44Go44GG44GU44GW44GE44G+44GZ44CC54Sh5paZ5L2T6aiT55m76Yyy44Gu6Zqb
44Gr5pyJ5Yq544Gq44GK5pSv5omV44GE5pa55rOV44Gu44GU55m76Yyy44KS44GK6aGY44GE44GX
44Gm44GK44KK44G+44GX44Gf44GM44CB6KqN6Ki844Gn44Ko44Op44O844GM55m655Sf44GX44G+
44GX44Gf44CC5Lul5LiL44Gr5b6T44Gj44Gm44GK5pSv5omV44GE5pa55rOV44Gu5YaN55m76Yyy
44KS44GK6aGY6Ie044GX44G+44GZ44CCDQoxLiDjgZPjgaHjgonjgYvjgonjgYrlrqLmp5jjga7j
gqLjgqvjgqbjg7Pjg4jmg4XloLHjgpLjgZTlhaXlipvkuIvjgZXjgYQ6IOaUr+aJleaWueazleOB
ruaDheWgseOCkuabtOaWsOOBmeOCi+OAgg0KMi4gQW1hem9u44OX44Op44Kk44Og44Gr55m76Yyy
44GX44GfQW1hem9uLmNvLmpw44Gu44Ki44Kr44Km44Oz44OI44KS5L2/55So44GX44Gm44K144Kk
44Oz44Kk44Oz44GX44G+44GZ44CCDQozLiDlt6blgbTjgavooajnpLrjgZXjgozjgabjgYTjgovj
gIznj77lnKjjga7mlK/miZXmlrnms5XjgI3jga7kuIvjgavjgYLjgovjgIzmlK/miZXmlrnms5Xj
gpLlpInmm7TjgZnjgovjgI3jga7jg6rjg7Pjgq/jgpLjgq/jg6rjg4Pjgq/jgZfjgb7jgZnjgIIN
CjQuIOacieWKueacn+mZkOOBruabtOaWsOOBvuOBn+OBr+aWsOOBl+OBhOOCr+ODrOOCuOODg+OD
iOOCq+ODvOODieaDheWgseOCkuWFpeWKm+OBl+OBpuOBj+OBoOOBleOBhOOAgg0K5LiL6KiY44Oc
44K/44Oz44KS44Kv44Oq44OD44Kv44GZ44KL44Go44CB44GK5pSv5omV44GE5pa55rOV44KS5aSJ
5pu044Gn44GN44G+44GZ44CCDQoNCg0KDQoNCuaUr+aJleaWueazleOBruaDheWgseOCkuabtOaW
sOOBmeOCiw0KDQoNCg0KDQoy5pel5Lul5YaF44Gr44GK5pSv5omV44GE5pa55rOV44GM5YaN55m7
6Yyy44GV44KM44Gq44GE5aC05ZCI44CB44GK5a6i5qeY44Gu5a6J5YWo44Gu54K644CB44Ki44Kr
44Km44Oz44OI44GuIOWIqeeUqOWItumZkOOCkuOBleOBm+OBpuOBhOOBn+OBoCDjgY3jgb7jgZnj
ga7jgafjgIINCuOBvuOBn+OBruOBlOWIqeeUqOOCkuOBiuW+heOBoeOBl+OBpuOBiuOCiuOBvuOB
meOAgg0KQW1hem9uLmNvLmpwDQoNCg0KDQoNCg0KDQpBbWF6b24uY28uanAg44Gn44Gv44CB44Kr
44O844OJ44Gu5om/6KqN44GM5b6X44KJ44KM44Gq44GL44Gj44Gf55CG55Sx44Gu6Kmz57Sw44KS
56K66KqN44Gn44GN44G+44Gb44KT44CC44Kv44Os44K444OD44OI44Kr44O844OJ5oOF5aCx44Gu
5pu05paw44CB5paw44GX44GE44Kv44Os44K444OD44OI44Kr44O844OJ44Gu6L+95Yqg44Gr44Gk
44GE44Gm44Gv5omL6aCG44KS44GU56K66KqN44GP44Gg44GV44GE44CCDQrjgZPjga5F44Oh44O8
44Or44Ki44OJ44Os44K544Gv6YWN5L+h5bCC55So44Gn44GZ44CC44GT44Gu44Oh44OD44K744O8
44K444Gr6L+U5L+h44GX44Gq44GE44KI44GG44GK6aGY44GE44GE44Gf44GX44G+44GZ44CCDQoN
CjVkZW5qMW1iZQ0KDQoNCg0KDQoNCg0KIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGlt
bUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRp
bW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
