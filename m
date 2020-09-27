Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE3827A293
	for <lists+linux-nvdimm@lfdr.de>; Sun, 27 Sep 2020 21:28:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D56E914F28B8C;
	Sun, 27 Sep 2020 12:28:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=160.16.146.195; helo=lzbjoqtmm.icu; envelope-from=admin@lzbjoqtmm.icu; receiver=<UNKNOWN> 
Received: from lzbjoqtmm.icu (tk2-409-45691.vs.sakura.ne.jp [160.16.146.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7379E14C1157E
	for <linux-nvdimm@lists.01.org>; Sun, 27 Sep 2020 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=lzbjoqtmm.icu;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type;
 i=admin@lzbjoqtmm.icu;
 bh=QRISHJV8DdhAfELxa5e94qcK085E8RzLraH9OvKYrV0=;
 b=eysDiz1iYi14qRTxkUTyuTzvNbhOCCd8VCQxWFOhtafnJwI5x9LcFcwxaYwLD9jSLYP9D2G0rKXY
   6EprqPmLM9C84lBLKWbQQs5vUwxuILEmTUDCLhHQzbqFY0pgSA9bvLnqr6deabNwxpmpxXNnvJ8z
   DB47DFH9mGsz5q8+2/w=
Message-ID: <20200928032849845541@lzbjoqtmm.icu>
From: =?utf-8?B?5LiJ5LqV5L2P5Y+L?= <admin@lzbjoqtmm.icu>
To: <linux-nvdimm@lists.01.org>
Subject: =?utf-8?B?5pys44Oh44O844Or44Gv44OJ44Oh44Kk44Oz44Gu6YGL55So77yI44Oh44O844Or6YCB5Y+X5L+h44KE?=
	=?utf-8?B?44Ob44O844Og44Oa44O844K444Gu6KGo56S677yJ44Gr6Zai44KP44KL?=
Date: Mon, 28 Sep 2020 03:28:40 +0800
MIME-Version: 1.0
Message-ID-Hash: 6GQZE433D5CXQEJA4F5RMXY4MH4QMVHT
X-Message-ID-Hash: 6GQZE433D5CXQEJA4F5RMXY4MH4QMVHT
X-MailFrom: admin@lzbjoqtmm.icu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6GQZE433D5CXQEJA4F5RMXY4MH4QMVHT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQogDQoNCg0K5pys44Oh44O844Or44Gv44OJ44Oh44Kk44Oz44Gu6YGL55So77yI44Oh44O844Or
6YCB5Y+X5L+h44KE44Ob44O844Og44Oa44O844K444Gu6KGo56S677yJ44Gr6Zai44KP44KLDQrp
h43opoHjgarpgJrnn6Xjgajjgarjgorjgb7jgZnjgIINCg0KDQoNCg0K44GE44Gk44KCUyBNIEIg
Q+OCq+ODvOODieOCkuOBlOWIqeeUqOOBhOOBn+OBoOOBjeOBguOCiuOBjOOBqOOBhuOBlOOBluOB
hOOBvuOBmeOAgiANCuW8iuekvuOBp+OBr+OAgeOBiuWuouanmOOBq+WuieW/g+OBl+OBpuOCq+OD
vOODieOCkuOBlOWIqeeUqOOBhOOBn+OBoOOBj+OBk+OBqOOCkuebrueahOOBq+OAgQ0K56ys5LiJ
6ICF44Gr44KI44KL5LiN5q2j5L2/55So44KS6Ziy5q2i44GZ44KL44Oi44OL44K/44Oq44Oz44Kw
44KS6KGM44Gj44Gm44GE44G+44GZ44CCDQrlvZPnpL7jga7mpJzlh7rjgpLntYzjgabjgIHnrKwz
6ICF44GM5LiN5rOV5oKq5oSP44Ot44Kw44Kk44Oz44GC44Gq44Gf44Gu5LiJ5LqV5L2P5Y+L44OL
44Kz44K5d2Vi44K144O844OT44K544CCIA0KDQrjgYrlv5njgZfjgYTjgajjgZPjgo3lpKflpInm
gZDjgozlhaXjgorjgb7jgZnjgYzjgIHkuIvjga7jgJDjgYrllY/jgYTlkIjjgo/jgZvnqpPlj6Pj
gJHjgb7jgafjgIENCuOBquOBiuOAgeOBlOWlkee0hOOBhOOBn+OBoOOBhOOBpuOBhOOCi+OCq+OD
vOODieOBq+OBpOOBhOOBpuOBr+OAgeesrOS4ieiAheOBq+OCiOOCi+S4jeato+S9v+eUqOOBrg0K
5Y+v6IO95oCn44GM44GU44GW44GE44G+44GZ44Gu44Gn44CB44Kr44O844OJ44Gu44GU5Yip55So
44KS5LiA5pmC55qE44Gr5YGc5q2i44GV44Gb44Gm44GE44Gf44Gg44GE44Gm44GE44KL44CBDQrj
goLjgZfjgY/jga/ku4rlvozlgZzmraLjgZXjgZvjgabjgYTjgZ/jgaDjgY/loLTlkIjjgYzjgZTj
gZbjgYTjgb7jgZnjgIINCuOBlOS4jeS+v+OBqOOBlOW/g+mFjeOCkuOBiuOBi+OBkeOBl+OBvuOB
l+OBpuiqoOOBq+eUs+OBl+ios+OBlOOBluOBhOOBvuOBm+OCk+OBjOOAgQ0K5L2V44Go44Ge44GU
55CG6Kej6LOc44KK44Gf44GP44GK6aGY44GE55Sz44GX44GC44GS44G+44GZ44CCDQoNCuiHs+aA
peOAgVMgTSBCIEPjgqvjg7zjg4nkvJrlk6HjgrXjg7zjg5Pjgrnjgavkv67mraPmg4XloLHjgpLl
ho3nmbvpjLLjgZfjgabjgY/jgaDjgZXjgYQNCiANCg0KVnBhc3NJRCDjg63jgrDjgqTjg7MNCg0K
DQrjgIANCg0KIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcK
VG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMu
MDEub3JnCg==
