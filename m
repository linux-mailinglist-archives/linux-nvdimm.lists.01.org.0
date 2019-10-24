Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292C2E3E02
	for <lists+linux-nvdimm@lfdr.de>; Thu, 24 Oct 2019 23:16:18 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6D30F100EEBA4;
	Thu, 24 Oct 2019 14:17:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=180.76.109.225; helo=bhd5.sosung.com.cn; envelope-from=zhan.bixia@e.t-email.top; receiver=<UNKNOWN> 
Received: from bhd5.sosung.com.cn (bhd4.sosung.net.cn [180.76.109.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 040BC100EEBA3
	for <linux-nvdimm@lists.01.org>; Thu, 24 Oct 2019 14:17:11 -0700 (PDT)
Received: from edm01.bossedm.com (edm01.chinaemail.cn [180.76.132.54])
	by bhd5.sosung.com.cn (Postfix) with ESMTPS id 5825C1019A5
	for <linux-nvdimm@lists.01.org>; Thu, 24 Oct 2019 19:05:59 +0800 (CST)
Received: from unknown (unknown [127.0.0.1])
	by edm01.bossedm.com (Bossedm) with SMTP id 64A94120987
	for <linux-nvdimm@lists.01.org>; Thu, 24 Oct 2019 19:04:22 +0800 (CST)
Date: Thu, 24 Oct 2019 19:04:22 +0800 (CST)
From: "=?utf-8?B?QmlsbGllIA==?=" <billie@onerivertronics.com>
To: <linux-nvdimm@lists.01.org>
Subject: =?utf-8?B?UmU6IE1BWDYzOTRVUzMxMEQzK1Q=?=
Mime-Version: 1.0
X-Notify-Mail: No
Message-ID: <1858#49563#linux-nvdimm@lists.01.org#e358f98847f1ee53ccc515b2fd0679bf#1571915062196>
X-Iszbb: Yes
X-ZZY-MESSAGE-ID: FA163E85126BF7020000000000003685B15D000000000200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=e.t-email.top; s=s9527;
	t=1571915062; bh=dZm0gFGagY+vmZKYGoAXNCU+007cLQoS/xeb2soTspA=;
	h=Date:From:Subject:Message-ID;
	b=yrz6m7alcnpQHcluOnNhMoGn/bGmYINtYQ5F56XCT8wiyrGcJQckgfB6MwQDz5tOu
	 klgQlBmPl2+SYQU7DbNgECnlEflOCd+EwcpUW2SZ0y8D26qngxg1ta1uegiN+tRVOb
	 DPq/f6JRFXjOwXduzLEf2bQuGMPpWFNcE5aGiiDY=
Message-ID-Hash: UH66GEDX2U5JQGY7ZQZ4JRY4KORSIFXZ
X-Message-ID-Hash: UH66GEDX2U5JQGY7ZQZ4JRY4KORSIFXZ
X-MailFrom: zhan.bixia@e.t-email.top
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: billie@onerivertronics.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UH66GEDX2U5JQGY7ZQZ4JRY4KORSIFXZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCg0KDQoNCg0KCQ0KCQkgDQoJDQoJDQoJCSANCgkNCgkNCgkJJm5ic3A7IA0KCQ0KCQ0KCQlI
ZWxsbyBkZWFyLCANCgkNCgkNCgkJJm5ic3A7IA0KCQ0KCQ0KCQlIb3cgYXJlIHlvdT8gDQoJDQoJ
DQoJCUkgYW0mbmJzcDtCaWxsaWUgZnJvbSBPbmUgUml2ZXIgRWxlY3Ryb25pYyBMaW1pdGVkIHdp
dGggb3ZlciAxMCB5ZWFyc+KAmSBleHBlcmllbmNl77yMY292ZXJpbmcgZ29vZCBxdWFsaXR5IGFu
ZCBPbmUteWVhci13YXJyYW50eSBlbGVjdHJvbmljIGNvbXBvbmVudHMuIA0KCQ0KCQ0KCQkmbmJz
cDsgDQoJDQoJDQoJCVBscyZuYnNwO2NoZWNrJm5ic3A7b3VyIGhvdCZuYnNwO29mZmVyIHRoaXMg
d2VlazoNCiANCgkNCgkNCgkJDQoNCk1BWDMwODJFRVNBK1QgTUFYSU0gMjAxOCsgMC4zMXVzZCAN
Ck1BWDM0ODNFQ1NBK1QgTUFYSU0gMjAxOCsgMC4zdXNkIA0KTUFYNDgzQ1NBK1QgTUFYSU0gMjAx
OCsgMC4zM3VzZCANCk1BWDQ4M0VFU0ErVCBNQVhJTSAyMDE4KyAwLjQ3MXVzZCANCk1BWDQ4MUVT
QStUIE1BWElNIDIwMTgrIDAuNDQxdXNkIA0KTUFYNDgxRUVTQStUIE1BWElNIDIwMTgrIDAuNDUz
dXNkIA0KDQoNCiANCgkNCgkNCgkJDQoJDQoJDQoJCSANCgkNCgkNCgkJDQpXYWl0IGZvciB5b3Vy
IGlucXVpcnkuDQpTaG9ydCBsZWFkIHRpbWUmYW1wO2dvb2QgcHJpY2U6IE1pY3JvY2hpcCwgWGls
aW54LCBBbHRlcmEgQkdBIENQTEQsIGNhcGFjaXRvcnMmYW1wO3Jlc2lzdG9ycyhPcmRlciBmcm9t
IDEgcGNzLCAxIHllYXIgd2FycmFudHkpIA0KCQ0KCQ0KCQkmbmJzcDsgDQoJDQoJDQoJCUJlc3Qg
UmVnYXJkcyANCgkNCgkNCgkJQmlsbGllIA0KCQ0KCQ0KCQlTYWxlcyBtYW5hZ2VyIA0KCQ0KCQ0K
CQlPbmUgUml2ZXIgRWxlY3Ryb25pYyBMaW1pdGVkDQpvbmUgeWVhciBndWFyYW50ZWVkIGVsZWN0
cm9uaWMgDQpkaXN0cmlidXRvciANCgkNCgkNCgkJODI4IE5vcnRoLCBDZW50ZXIsIEx1b0h1IERp
c3QsIFNoZW56aGVuLCBHdWFuZ2RvbmcsIENoaW5hLCA1MTgwMDAgDQoJDQoJDQoJCVRlbDogKzg2
LTc1NS04NDE3IDU3MDkNClNreXBlL0VtYWlsOiZuYnNwO2JpbGxpZUBvbmVyaXZlcmhrLmNvbQ0K
IA0KCQ0KCQ0KCQlXZWI6aHR0cHM6Ly93d3cub25lcml2ZXJoay5jb20gDQoJDQoJDQoJCQ0KCQ0K
CQ0KCQkNCgkNCgkNCgkJSWYgeW91IGRvbid0IHdhbnQgdG8gcmVjZWl2ZSB0aGlzIG1haWwsIHBs
cyByZXR1cm4gd2l0aCAicmVtb3ZlIiBvbiB0aGUgc3ViamVjdCBsaW5lIA0KCQ0KDQoNCg0KDQoJ
5qGj6ZO6572R4oCU4oCU5Zyo57q/5paH5qGj5YWN6LS55aSE55CGIA0K5aaC5p6c5L2g5LiN5oOz
5YaN5pS25Yiw6K+l5Lqn5ZOB55qE5o6o6I2Q6YKu5Lu277yM6K+354K55Ye76L+Z6YeM6YCA6K6i
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNj
cmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
