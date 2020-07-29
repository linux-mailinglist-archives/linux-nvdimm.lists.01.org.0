Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A74A232B11
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Jul 2020 06:52:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3D5661270AC0A;
	Wed, 29 Jul 2020 21:52:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=106.12.154.80; helo=bhd2.sosung.com.cn; envelope-from=newsletter@a.simins.xyz; receiver=<UNKNOWN> 
Received: from bhd2.sosung.com.cn (bhd2.sosung.com.cn [106.12.154.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6933E1270AC09
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 21:52:19 -0700 (PDT)
Received: from edm01.bossedm.com (edm01.chinaemail.cn [180.76.132.54])
	by bhd2.sosung.com.cn (Postfix) with ESMTPS id A87FB1061F3
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 20:21:23 +0800 (CST)
Received: from unknown (unknown [127.0.0.1])
	by edm01.bossedm.com (Bossedm) with SMTP id 104A41213AC
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 20:21:22 +0800 (CST)
Date: Wed, 29 Jul 2020 20:21:21 +0800 (CST)
From: "=?utf-8?B?WXVtaSA=?=" <yumi@hardfindelec.com>
To: <linux-nvdimm@lists.01.org>
Subject: =?utf-8?B?UmVxdWVzdDogQUQ4NTQxQVJUWiBBRA==?=
Mime-Version: 1.0
X-Notify-Mail: No
Message-ID: <1883#65061#linux-nvdimm@lists.01.org#e358f98847f1ee53ccc515b2fd0679bf#1596025281858>
X-Iszbb: Yes
X-ZZY-MESSAGE-ID: FA163E85126BD22A000000000000C269215F000000001900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=a.simins.xyz; s=s9527;
	t=1596025282; bh=YESkmgXEYXE4rV8w9AD0oPIi69Jrh5E0YtCl5uJ6RcE=;
	h=Date:From:Subject:Message-ID;
	b=gYo50mApUk3DgJ2e2E8qERo6bE/Anu06zO+w471bkC5pL4lZ+SBFr+EhWIhdInl5V
	 PZLe3ZpSlOdcbLfOvzeCPYnThYBCQpy/GsV+Fw3FedGnXtsxG7OvxTPgTV7rst6a1A
	 P068edWzjeFfo4aQ2iLgiNF1N9wbHC6LTHK+gAJk=
Message-ID-Hash: BOBHMX5RQXUCVOGUCQOJMZAQAT5DJICI
X-Message-ID-Hash: BOBHMX5RQXUCVOGUCQOJMZAQAT5DJICI
X-MailFrom: newsletter@a.simins.xyz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: yumi@hardfindelec.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BOBHMX5RQXUCVOGUCQOJMZAQAT5DJICI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCg0KDQoNCg0KCQ0KCQkmbmJzcDsmbmJzcDtIYXJkJm5ic3A7RmluZCZuYnNwO0VsZWN0cm9u
aWNzIEx0ZC4NCnNvdXJjaW5nIGhhcmQgZmluZCBlbGVjdHJvbmljIGNvbXBvbmVudHMgDQoJDQoJ
DQoJCSZuYnNwOyANCgkNCgkNCgkJRGVhciBGcmllbmQsIA0KCQ0KCQ0KCQlHb29kIGRheSB0byB5
b3UhDQpUaGlzIGlzIFl1bWkgZnJvbSBIYXJkIEZpbmQgRWxlY3Ryb25pY3MgTHRkKHd3dy5oYXJk
ZmluZGVsZWN0cm9uaWNzLmNvbSkmbmJzcDt3aGljaCBpcyBhIHByb2Zlc3Npb25hbCBlbGVjdHJv
bmljcyBkaXN0cmlidXRvciB3aXRoIDEwIHllYXJzIG9mIGV4cGVyaWVuY2VzLiZuYnNwOw0KV2Ug
YXJlIGdvb2QgYXQmbmJzcDtIYXJkIEZpbmQmbmJzcDtlbGVjdHJvbmljIGNvbXBvbmVudHPvvJoN
Cg0KSUM6IFhpbGlueCwgQWx0ZXJhLCBUSSwgTWF4aW0sIEFELi4NCk1MQ0MgQ2FwYWNpdG9yOiBN
dXJhdGEsIFNhbXN1bmcsIFlhZ2VvLCBBVlgsIEtlbWV0Li4NCkRpb2RlJmFtcDtUcmFuc2lzdG9y
OiBWaXNoYXksVEksU1QuLg0KDQril49GcmVlIHNhbXBsZXMNCuKXj09uZSB5ZWFyIGd1YXJhbnRl
ZQ0KDQpSZWNlbnRseSB3ZSBkbyBzb21lIHJlc2VhcmNoIGluIHRoZSBtYXJrZXQsIGFuZCBmaW5k
IHRoYXQgSUMgZnJvbSBBRCwgTWF4aW0sIFRJIHNhbGVzIHZlcnkgd2VsbC4NCkhlcmUgYXJlIHNv
bWUgb2Ygb3VyIHJlZmVyZW5jZXM6Jm5ic3A7IA0KCQ0KCQ0KCQkgDQpBRDg1MTVBUlRaIEFEIDIw
MTkrIDAuMjk3dXNkICANCkFEODUzMUFSVFogQUQgMjAxOSsgMC4xOTJ1c2QmbmJzcDsgIA0KQUQ4
NTMyQVJaIEFEIDIwMTkrIDAuMjQ5dXNkJm5ic3A7ICZuYnNwOyAmbmJzcDsgDQpBRDg1MzRBUlog
QUQgMjAxOSsgMC4yNjh1c2QmbmJzcDsgIA0KQUQ4NTM4QVVKWiBBRCAyMDE5KyAwLjUxNXVzZCZu
YnNwOyAgDQpBRDg1MzlBUlogQUQgMjAxOSsgMC41MDh1c2QmbmJzcDsgJm5ic3A7IA0KQUQ4NTQx
QVJUWiBBRCAyMDE5KyAwLjE0NHVzZA0KDQoNCg0KV2UgY2FuIHN1cHBvcnQgeW91IDM2NWRheXMg
d2FycmFudHkgYW5kIGhlbHAgeW91IGZpbmQgb2Jzb2xldGUgcGFydHMgd2l0aCBnb29kIHByaWNl
LiAoMXBjcyBvcmRlcikNCiANCgkNCgkNCgkJS2VlcCBzbWlsaW5nIGV2ZXJ5IGRheSZuYnNwOygq
77+jKe+/oykgDQoJDQoJDQoJCVl1bWkmbmJzcDsoUHJvZHVjdCZuYnNwO01hbmFnZXIpIA0KCQ0K
CQ0KCQlIYXJkJm5ic3A7RmluZCZuYnNwO0VsZWN0cm9uaWNzIEx0ZC4NCnNvdXJjaW5nIGhhcmQg
ZmluZCBlbGVjdHJvbmljIGNvbXBvbmVudHMNCg0KMzE1LCBTaGFoZSBSb2QsIExvbmcgR2FuZyBE
aXN0cmljdCwgU2hlbnpoZW4sIENOLCA1MTgwMDANClRlbDogKzg2LTc1NS04NDE4IDgxMDMmbmJz
cDsmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsNClNreXBlICZhbXA7IEVtYWlsOiZuYnNwO3l1
bWlAaGFyZGZpbmRlbGVjdHJvbmljcy5jb20NCkxpbmtlZGxuOnd3dy5saW5rZWRpbi5jb20vaW4v
eXVtaS1nYW8NCkZhY2Vib29rOiZuYnNwO2ZhY2Vib29rLmNvbS9ZdW1paGFyZGZpbmQNCiZuYnNw
OyANCgkNCgkNCgkJSWYgeW91IGRvbid0IHdhbnQgdG8gcmVjZWl2ZSB0aGlzIG1haWwsIHBscyBy
ZXR1cm4gd2l0aCAicmVtb3ZlIiBvbiB0aGUgc3ViamVjdCBsaW5lLiANCgkNCgkNCgkJJm5ic3A7
IA0KCQ0KDQoNCg0KDQoJ5qGj6ZO6572R4oCU4oCU5Zyo57q/5paH5qGj5YWN6LS55aSE55CGIA0K
5aaC5p6c5L2g5LiN5oOz5YaN5pS25Yiw6K+l5Lqn5ZOB55qE5o6o6I2Q6YKu5Lu277yM6K+354K5
5Ye76L+Z6YeM6YCA6K6iCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAx
Lm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBs
aXN0cy4wMS5vcmcK
