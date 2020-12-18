Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D38712DDCCE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 03:15:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 842DA100EB859;
	Thu, 17 Dec 2020 18:14:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AAC70100EB855
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 18:14:57 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI2EQkQ110040;
	Fri, 18 Dec 2020 02:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=jei0s1k0fVoYmzRqbf89htarH1KaZfqimDCWk3L3j0E=;
 b=aCthrytTatjqsIP7bwwGRh6Wky0KcziQgCzrUZgbi6AboCaM74XGO3HgZJcbqISm75sW
 UnikK7hwwmpiTo9dcHeophXq3x54Whz3hj40BgT3OlXiU1zJWdAnCzyoHlaYMwP2mGHP
 NkIpA/bTWMuN5w9SG8A7aYKLnoAGC+Hh/xCK0/hj8Mj1CM8gAHAQu0733MISCB8q94YC
 6fz7zK3wzpe8Z02nyw9QbsFaAea1uzUD1BQz9y7lo4SgufrqOVRdqp9XAcFGt15Dpi/z
 Anf1MzqlDd7Mv8CXbr7rsglury5Xoa8cfgYQ6XgqcKDPL3Wn6pJZRjIBerf7T+WMU2KU Ow==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 35cn9rrayj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Dec 2020 02:14:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI25HNl077619;
	Fri, 18 Dec 2020 02:14:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 35g3rfgvbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Dec 2020 02:14:53 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BI2EqOn009826;
	Fri, 18 Dec 2020 02:14:52 GMT
Received: from paddy.uk.oracle.com (/10.175.180.204)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 17 Dec 2020 18:14:52 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH daxctl v2 0/5] daxctl: range mapping allocation
Date: Fri, 18 Dec 2020 02:14:33 +0000
Message-Id: <20201218021438.8926-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180013
Message-ID-Hash: TNWXMT7A7GR56HN23UD3SI7AIIZ4PB5G
X-Message-ID-Hash: TNWXMT7A7GR56HN23UD3SI7AIIZ4PB5G
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TNWXMT7A7GR56HN23UD3SI7AIIZ4PB5G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGV5LA0KDQpUaGlzIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yOg0KDQogMSkgTGlzdGluZyBtYXBw
aW5ncyB3aGVuIHBhc3NpbmcgLU0gdG8gwrRkYXhjdGwgbGlzdMK0LiBUaGVzZSBhcmUgb21taXRl
ZA0KIGJ5IGRlZmF1bHQuDQoNCiAyKSBJdGVyYXRpb24gQVBJcyBmb3IgdGhlIG1hcHBpbmdzLg0K
DQogMykgQWxsb3cgcGFzc2luZyBhbiBpbnB1dCBKU09OIGZpbGUgd2l0aCB0aGUgbWFudWFsbHkg
c2VsZWN0ZWQgcmFuZ2VzDQogdG8gYmUgdXNlZCB3aGVuIGNyZWF0aW5nIHRoZSBkZXZpY2UtZGF4
IGluc3RhbmNlLg0KDQpUaGlzIGFwcGxpZXMgb24gdG9wIG9mICdqbS9kZXZkYXhfc3ViZGl2JyBi
cmFuY2ggaW4gZ2l0aHViLmNvbTpwbWVtL25kY3RsLmdpdA0KDQpUZXN0aW5nIHJlcXVpcmVzIGEg
NS4xMCsga2VybmVsLg0KDQp2MSAtPiB2MjoNCiAgKiBMaXN0IG1hcHBpbmdzIG9ubHkgd2l0aCAt
TXwtLW1hcHBpbmdzIG9wdGlvbg0KICAqIEFkZHMgYSB1bml0IHRlc3QgZm9yIC0taW5wdXQgZmls
ZSAod2hpbGUgdGVzdGluZyB3aXRoIC1NIGxpc3RpbmcgdG9vKQ0KICAqIFJlbmFtZSAtLXJlc3Rv
cmUgdG8gLS1pbnB1dA0KICAqIEFkZCBEb2N1bWVudGF0aW9uIGZvciAtTSBhbmQgZm9yIC0taW5w
dXQNCg0KSm9hbyBNYXJ0aW5zICg1KToNCiAgbGliZGF4Y3RsOiBhZGQgbWFwcGluZyBpdGVyYXRv
ciBBUElzDQogIGRheGN0bDogaW5jbHVkZSBtYXBwaW5ncyB3aGVuIGxpc3RpbmcNCiAgbGliZGF4
Y3RsOiBhZGQgZGF4Y3RsX2Rldl9zZXRfbWFwcGluZygpDQogIGRheGN0bDogYWxsb3cgY3JlYXRp
bmcgZGV2aWNlcyBmcm9tIGlucHV0IGpzb24NCiAgZGF4Y3RsL3Rlc3Q6IGFkZCBhIHRlc3QgZm9y
IGRheGN0bC1jcmVhdGUgd2l0aCBpbnB1dCBmaWxlDQoNCiBEb2N1bWVudGF0aW9uL2RheGN0bC9k
YXhjdGwtY3JlYXRlLWRldmljZS50eHQgfCAgMTMgKysrDQogRG9jdW1lbnRhdGlvbi9kYXhjdGwv
ZGF4Y3RsLWxpc3QudHh0ICAgICAgICAgIHwgICA0ICsNCiBkYXhjdGwvZGV2aWNlLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAxMjggKysrKysrKysrKysrKysrKysrKysrKysrKy0N
CiBkYXhjdGwvbGliL2xpYmRheGN0bC1wcml2YXRlLmggICAgICAgICAgICAgICAgfCAgIDggKysN
CiBkYXhjdGwvbGliL2xpYmRheGN0bC5jICAgICAgICAgICAgICAgICAgICAgICAgfCAxMTggKysr
KysrKysrKysrKysrKysrKysrKystDQogZGF4Y3RsL2xpYi9saWJkYXhjdGwuc3ltICAgICAgICAg
ICAgICAgICAgICAgIHwgICA3ICsrDQogZGF4Y3RsL2xpYmRheGN0bC5oICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDE0ICsrKw0KIGRheGN0bC9saXN0LmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgNCArDQogdGVzdC9kYXhjdGwtY3JlYXRlLnNoICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDMxICsrKysrKy0NCiB1dGlsL2pzb24uYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgNTcgKysrKysrKysrKystDQogdXRpbC9qc29uLmggICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICsNCiAxMSBmaWxlcyBjaGFuZ2VkLCAz
ODAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCg0KLS0gDQoxLjguMy4xDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFp
bGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2Vu
ZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
