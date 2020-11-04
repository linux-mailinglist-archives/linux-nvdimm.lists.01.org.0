Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3C52A66C4
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Nov 2020 15:53:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 92C6C16576BB3;
	Wed,  4 Nov 2020 06:52:58 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a06:dd00:1:4:1::2c6; helo=s317931.savps.ru; envelope-from=add@s317931.savps.ru; receiver=<UNKNOWN> 
Received: from s317931.savps.ru (unknown [IPv6:2a06:dd00:1:4:1::2c6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6E60716576BB1
	for <linux-nvdimm@lists.01.org>; Wed,  4 Nov 2020 06:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=s317931.savps.ru; s=dkim; h=Sender:Content-Type:MIME-Version:Date:Subject:
	From:Message-ID:Reply-To:To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rHz0YbfLLA50xaURqG8+iOx8+QG/Du2h34EqSjv5PSo=; b=EF47qRS2A+scu3BLOMn/HWv5Es
	h3DYNpRkMDqFYJwkl4NEuvoDykaXF6HrnRQQY6NJEV0ksYMOwjWqGjp8AuXV9iCTXoMMrC/VS9HhI
	i6QoaVKqWYhA7knm8qF6WJNEnTcfVvKJQ+lLWScIcQTveYXRDg/ewRty5ndZZ1EnTETU=;
Received: by s317931.savps.ru with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.94)
	id 1kaK9U-00081w-OJ; Wed, 04 Nov 2020 17:52:44 +0300
Message-ID: <1217A1F2F92D16D5090C45C682E078F6@meta.ua>
From: "ADMIN" <mail-sent@meta.ua>
Subject: =?windows-1251?B?z+4g7+7i7uTzIO/w7uLl5OXt6P8g8OXq6+Ds?=
	=?windows-1251?B?+w==?=
Date: Wed, 4 Nov 2020 16:48:52 +0200
MIME-Version: 1.0
X-Antivirus: Avast (VPS 201104-0, 04.11.2020), Outbound message
X-Antivirus-Status: Clean
Sender: add@s317931.savps.ru
Message-ID-Hash: YRIFIHWIJP3RWK6HD256AFKZJ77EFGEX
X-Message-ID-Hash: YRIFIHWIJP3RWK6HD256AFKZJ77EFGEX
X-MailFrom: add@s317931.savps.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="windows-1251"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YRIFIHWIJP3RWK6HD256AFKZJ77EFGEX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

RW1haWwg7ODw6uXy6O3jDQoNCtDg8fH76+roIP/i6//+8vH/IPLl7CDo7fHy8PPs5e3y7uwsIOru
8u7w++kg4+Dw4O3y6PDu4uDt7e4g7/Do4u7k6PIg6uvo5e3y7uIuIKANCg0K0ODx8fvr6uAg7+jx
5ewg7+4g7O3u4+736PHr5e3t++wgxS1tYWlsIODk8OXx4Owg/+Lr//7y8f8g7vfl7fwg7O757fvs
IOgg8OXn8+v88uDy6OLt++wg6O3x8vDz7OXt8u7sLCDh6+Dj7uTg8P8g6u7y7vDu7PMg4vsg8ezu
5uXy5SDv8O7o7fTu8Ozo8O7i4PL8IPHu8u3oIPL78f/3IOv+5OXpIO4g8eLu6PUg8u7i4PDg9SDo
IPPx6/Pj4PUuIKANCtDg8fH76+rgIO3gIP3r5ery8O7t7fP+IO/u9/LzIOjs5eXyIOzt7ubl8fLi
7iDv8OXo7PP55fHy4joNCjEuoML78e7q4P8g8OXn8+v88uDy6OLt7vHy/DogoA0K7uH/5+Dy5ev8
7e4g9e7y/CDu5OjtIPfl6+7i5eog6Ocg7eXx6u7r/Oro9SDx7vLl7SDn4Ojt8uXw5fHz5fLx/yDi
4Pjo7CDv8OXk6+7m5e3o5ewsIP3y7iDh8+Tl8iDn4OLo8eXy/CDu8iDy7uPuLCD38u4g4vsg7/Dl
5Ovg4+Dl8uUsIOgg9+XsIOTl+OXi6+Ug4fPk5fIg8fLu6PL8IOLg+OAg8/Hr8+PgIOjr6CDy7uLg
8Cwg8u4g8uXsIOHu6/z45SDt4CDt5ePuIOHz5OXyIPHv8O7xLiCgDQoyLqDR6u7w7vHy/DogoA0K
wuD44CDw5err4OzgIO3g9+3l8iDx8uDw8u7i4PL8IPHw4OfzIOblIO/u8evlIOW4IOfg6uDn4C4g
wuDsIO3lIO3z5u3uIOHz5OXyIObk4PL8IO/u9/LoIOzl8f/2LCDq4Oog/fLuIPfg8fLuIPHr8/fg
5fLx/ywg5fHr6CDi+yDn4Org5/vi4OXy5SDw5err4OzzIO3gIPLl6+Xi6OTl7ejlLCDw4OTo7iDo
6+gg4iDv8OXx8eUuIOfg6uDn4CEgoA0KMy6gzeXyIO3g5O7h7e7x8ugg4iDx7uHx8uLl7e3u7CDx
4Ony5TogoA0KwuDsIOLu4vHlIO3lIO3z5u3uIOjs5fL8IPHu4fHy4uXt7fvpIPHg6fIsIO3g+CDu
7/vy7fvpIOTo5+Dp7eXwIOrg9+Xx8uLl7e3uIO707vDs6PIg6/7h7uUg4uD45SDq7uzs5fD35fHq
7uUg7/Dl5Ovu5uXt6OUsIOIg6u7y7vDu7CDi+yDx7O7m5fLlIPPq4Ofg8vwg4vH+IO3l7uH17uTo
7PP+IOjt9O7w7OD26P8g5Ov/IPHi7uj1IOrr6OXt8u7iLiCgDQo0LqDE5e3l5u3g/yD96u7t7uzo
/zogoA0K0ODx8fvr6uAg4fPk5fIg8fLu6PL8IOft4Pfo8uXr/O3uIOTl+OXi6+UsIOXm5evoIOH7
IP3y7iDx8u7o6+Ag6/7h4P8g5PDz4+D/IPDl6uvg7OAsIO3g7/Do7OXwLCDw4OTo7iwg7/Dl8fHg
IOjr6CDy5evl4ujk5e3o5S4g0yDi4PEg7+7/4uv/5fLx/yDi5evo6u7r5e/t4P8g4u7n7O7m7e7x
8vwg5+Ag7OXt/Pjo5SDk5e384+gg7/Do4uvl9/wg4u3o7ODt6OUg8u737e4g8uDq7uUg9+jx6+4g
7+7y5e326ODr/O379SDq6+jl7fLu4iwg5fHr6CDh+yDi+yD98u4g8eTl6+Dr6CDn4CDh7uv8+PP+
IPHz7OzzLg0KNS6gwu7n7O7m7e7x8vwg7+7x8u7/7e3u6SDw4OHu8vs6IKANCsz7IO7h7e7i6//l
7CDFLW1haWwg4eDn+yDq4Obk8/4g7eXk5ev+LCD98u4g7uft4Pfg5fIsIPfy7iDi+yDs7ubl8uUg
7eUg4eXx7+7q7ujy/PH/LCD38u4g4uD48yDw4PHx++vq8yDh8+Tz8iDv7uvz9+Dy/CDu5O3oIOgg
8uUg5uUg6/7k6C4goA0KDQrR8u7o7O7x8vwg8ODx8fvr7uo6DQoNCi0gz/Dl5O/w6P/y6P8g0+rw
4Ojt+6AtIDg1MCDj8O0uoCg2ODUgNjk3IODk8C4pDQotINTo5yDr6PbgINPq8ODo7fsgLaAxNjAw
IOPw7S6gKDUgNDU3IDM5MSDg5PAuKQ0KLSDO4fng/yDw4PHx++vq4CDv7iDT6vDg6O3lIC2gMjAw
MCDj8O0uoCjh7uvl5aA2IDAwMCAwMDAg4OTwLikNCg0K0uDqIOblIO/w7uLu5OjsIEUtTWFpbCDw
4PHx++vq6CDv7iDo7fvsIPHy8ODt4Owg7Ojw4Cwg5fHr6CDC4PEg6O3y5fDl8fPl8iDw4PHx++vq
4CDv7iDq7u3q8OXy7e7pIPHy8ODt5SAtIO3g7+j46PLlLCDoIOz7IO7y4uXy6Owg7+4g8fLu6Ozu
8fLoIOgg6u7r6Pfl8fLi8yDv7uvz9+Dy5evl6S4NCg0KyiDw4PHx++vq4OzoIO/w6O3o7OD+8vH/
IO/o8fzs4CDt5SDv8O7y6OLu8OX34Pno5SDn4Oru7e7k4PLl6/zx8uLzINPq8ODo7fshDQoNCi0t
DQpDIPPi4Obl7ejl7Cwgwuvg5Ojs6PANCg0K0ODn4ujy6OUg4uD45ePuIOHo5+3l8eAg4iDo7fLl
8O3l8uUgoA0KDQrS5evl9O7tOqAzOCAwOTctMjA0LTIwNDANCg0KRS1tYWlsOqBpbmZvby11YUBi
aWdtaXIubmV0DQoNCg0KLS0gDQrd8u4g8e7u4fnl7ejlIO/w7uLl8OXt7iDt4CDi6PDz8fsg4O3y
6OLo8PPx7uwgQXZhc3QuDQpodHRwczovL3d3dy5hdmFzdC5jb20vYW50aXZpcnVzDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFp
bGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2Vu
ZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
