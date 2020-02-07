Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C351A15607E
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Feb 2020 22:09:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7ABCC10FC35A1;
	Fri,  7 Feb 2020 13:12:42 -0800 (PST)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=188.127.237.225; helo=s248147.savps.ru; envelope-from=drefggod@ukr.net; receiver=<UNKNOWN> 
Received: from s248147.savps.ru (unknown [188.127.237.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DEDB210FC35A1
	for <linux-nvdimm@lists.01.org>; Fri,  7 Feb 2020 13:12:39 -0800 (PST)
Received: from [62.122.202.195] (helo=knyuem)
	by s248147.savps.ru with esmtpa (Exim 4.92.3)
	(envelope-from <drefggod@ukr.net>)
	id 1j0AsH-0006oM-EC; Sat, 08 Feb 2020 00:09:17 +0300
Message-ID: <1510A6F5FE2A0FFC20256CD0D497E307@ukr.net>
From: =?windows-1251?B?wejn7eXxLdbl7fLwIC0g8eXs6O3g8Psg6CDy?=
	=?windows-1251?B?8OXt6O3j6A==?= <drefggod@ukr.net>
Subject: =?windows-1251?B?z/Do4+vg+ODl7CDt4CDh6Oft5fEg8eXs6O3g?=
	=?windows-1251?B?8PssIPLw5e3o7ePoIOgg7ODx8uXwIOrr4PHx?=
	=?windows-1251?B?+yDi5eTz+ej1IOHo5+3l8ezl7e7iLCDz9+jy?=
	=?windows-1251?B?5evl6SDoIO/x6PXu6+7j7uIh?=
Date: Fri, 7 Feb 2020 23:08:44 +0200
MIME-Version: 1.0
X-Antivirus: Avast (VPS 200206-2, 06.02.2020), Outbound message
X-Antivirus-Status: Clean
Message-ID-Hash: FLTA5MYGWPQV24F3VJWA23Y2PTQIXJQW
X-Message-ID-Hash: FLTA5MYGWPQV24F3VJWA23Y2PTQIXJQW
X-MailFrom: drefggod@ukr.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="windows-1251"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FLTA5MYGWPQV24F3VJWA23Y2PTQIXJQW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

x+Tw4OLx8uLz6fLlIQ0KDQrI5OXg6/zt++wg6O3x8vDz7OXt8u7sIOTr/yDv7uL7+OXt6P8g8/Du
4u3/IO/w7vTl8fHo7u3g6+jn7OAg6CDw4Ofi6PLo/yDv5fDx7u3g6+Ag/+Lr//7y8f8g6vPw8fsg
7+7i+/jl7ejlIOri4Ovo9Ojq4Pbo6C4gyOzl7e3uIOru8O/u8ODy6OLt++kg8vDl7ejt4yDv7ufi
7uvo8iDz9+Xx8vwg4vH+IPHv5fbo9Ojq8yDv8O7i7uTo7O7pIOru7O/g7ejl6SDk5f/y5ev87e7x
8ugsIPPw7uLl7fwg6u7s7+Xy5e3y7e7x8ugg7+Xw8e7t4OvgIOgg7+7n4u7r6PIg4OTg7/Lo8O7i
4PL8IOLx/iDv8O7j8ODs7PMg7uHz9+Xt6P8g6O3k6OLo5PPg6/zt7iDv7uQg7+7y8OXh7e7x8ugg
4uD45ekg6u7s7+Dt6OguDQoNCsHr6Obg6fjo5SDx5ezo7eDw+yDoIPLw5e3o7ePoIOIgyujl4uUN
Cg0Kz+7k8O7h7eXlIO3gIPHg6fLlIC0gaHR0cHM6Ly9iY3UuYmVzdC8NCg0KxfHr6CDv6PH87O4g
7+7v4OvuIOogwuDsIO/uIO746OHq5Swgwvsg7O7m5fLlDQrN5SDv7uvz9+Dy/CDw4PHx++vq8y6g
6OvooO/u5uDr7uLg8vzx/yDt4CBTcGFtDQpMaXN0LVVuc3Vic2NyaWJloGZyb20gdGhlIG5ld3Ns
ZXR0ZXIgb3KgY29tcGxhaW4gYWJvdXQgU3BhbQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1u
dmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgt
bnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
