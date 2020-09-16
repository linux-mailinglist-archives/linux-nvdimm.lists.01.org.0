Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A3826C4A9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 17:56:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 52EBB1454545E;
	Wed, 16 Sep 2020 08:56:56 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a06:dd00:1:4:1::25a; helo=s305957.savps.ru; envelope-from=admin@s305957.savps.ru; receiver=<UNKNOWN> 
Received: from s305957.savps.ru (unknown [IPv6:2a06:dd00:1:4:1::25a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 56DDE1454545C
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=s305957.savps.ru; s=dkim; h=Sender:Content-Type:MIME-Version:Date:Subject:
	From:Message-ID:Reply-To:To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=74It6JeWAVOLELT/s77wTp6rkixC2vqNKKnWnSt1bOI=; b=NzuAXdWBU7xKo1uKtMMpJZwTCZ
	RaWv9yWjuOql/FQ5BvEEb59NCLJGTZZ7LfIcIZ+ktJeroVc2FVfECLoR7r3VEx0xDvxZWMT6h1GLi
	qqanyTlXsZq25pqnvdbfce1MKXQncdzZpIgMcDzta/4ACoRPvnhBDHoYoKk8ZBS6zWD0=;
Received: by s305957.savps.ru with esmtpa (Exim 4.94)
	id 1kIZnB-0005yO-6y; Wed, 16 Sep 2020 18:56:21 +0300
Message-ID: <A9AC1A494296ACBF63662FACE848446C@meta.ua>
From: "SEO-STUDIO" <innforms@meta.ua>
Subject: =?windows-1251?B?0ODn8ODh7vLq4CDx4Ony7uIg6CDv8O7k4ujm?=
	=?windows-1251?B?5e3o5SDiIO/u6PHq7uL79SDx6PHy5ezg9SDt?=
	=?windows-1251?B?4CDv5fDi8/4g8fLw4O3o9vMh?=
Date: Wed, 16 Sep 2020 18:53:03 +0300
MIME-Version: 1.0
X-Antivirus: Avast (VPS 200915-12, 15.09.2020), Outbound message
X-Antivirus-Status: Clean
Sender: admin@s305957.savps.ru
Message-ID-Hash: JJPF4EDOQ7YKC5QWZIKHQSEVOX4CG3GL
X-Message-ID-Hash: JJPF4EDOQ7YKC5QWZIKHQSEVOX4CG3GL
X-MailFrom: admin@s305957.savps.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="windows-1251"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JJPF4EDOQ7YKC5QWZIKHQSEVOX4CG3GL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

x+Tw4OLx8uLz6fLlLg0KDQrM+yDn4O3o7ODl7PH/IPHu5+Tg7ejl7CDoIO/w7uTi6Obl7ejl7CDx
4Ony7uIg4iDSzs8tMyBHT09HTEUg7+4g7fPm7fvsIMLg7CDv7ujx6u7i++wg9PDg5+DsLg0KDQrR
7ufk4O3o5SDx4Ony7uI6DQoNCtHg6fIg4ujn6PLq4CDr4OnyIC0gMjUwMCDj8O0uDQoNCtHg6fIg
4ujn6PLq4CAtIDM1MDAg4/DtLg0KDQrB6Oft5fEg8eDp8iAtIO7yIDYwMDAg4/DtLg0KDQrI7fLl
8O3l8iDs4OPg5+jtIC0g7vIgOTAwMCDj8O0uDQoNCs/w7uTi6Obl7ejlIOggU0VPOg0KDQpTRU8g
7u/y6Ozo5+D26P8g8eDp8uAgLSDu8iA4MDAg4/DtLg0KDQrR7vHy4OLr5e3o5SDx5ezg7fLo9+Xx
6u7j7iD/5PDgIC0g7vIgMTIwMCDj8O0uDQoNCs3g7+jx4O3o5SBTRU8g7u/y6Ozo5+jw7uLg7e37
9SDx8uDy5ekgLSAxMTAg4/DtXDEwMDAg8ejs4u7r7uINCg0Kz/Du5OLo5uXt6OUg8eDp8uAg7+4g
6uv+9+Xi++wg9PDg5+DsIC0g7vIgMzIwMCDj8O1c7OXxDQoNCsDt4Ovo5yDq4OogwuD45ePuIPHg
6fLgLCDy4Oog6CDx4Ony7uIg6u7t6vPw5e3y7uIgLSDh5fHv6+Dy7e4uDQoNCsXx6+ggwuDxIOfg
6O3y5fDl8e7i4OvuIOTg7e3u5SDv8OXk6+7m5e3o5SAtIO/o+Ojy5Swg7vLi5fLo7CDiIO/u5PDu
4e3u8fL/9S4NCg0KLS0NCg0K0SDT4uDm5e3o5ewgwuvg5Ojs6PAgwOvl6vHg7eTw7uLo9w0KDQpU
ZWw6ICszOCgwOTYpMDU4MjM0Mi4gVGVsOiArMzgoMDYzKTQwMTA3NDENCg0Kc2t5cGU6IG9yZy1y
ZWVzdHINCg0KbWFpbDogaW5mb28tdWFAYmlnbWlyLm5ldA0KDQoNCi0tIA0K3fLuIPHu7uH55e3o
5SDv8O7i5fDl7e4g7eAg4ujw8/H7IODt8uji6PDz8e7sIEF2YXN0Lg0KaHR0cHM6Ly93d3cuYXZh
c3QuY29tL2FudGl2aXJ1cw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMu
MDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZl
QGxpc3RzLjAxLm9yZwo=
