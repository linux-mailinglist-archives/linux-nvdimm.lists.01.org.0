Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0AB2A82F5
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Nov 2020 17:03:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ED081163E5747;
	Thu,  5 Nov 2020 08:03:30 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a06:dd00:1:4:1::2c6; helo=s317931.savps.ru; envelope-from=add@s317931.savps.ru; receiver=<UNKNOWN> 
Received: from s317931.savps.ru (unknown [IPv6:2a06:dd00:1:4:1::2c6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C9100163E5745
	for <linux-nvdimm@lists.01.org>; Thu,  5 Nov 2020 08:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=s317931.savps.ru; s=dkim; h=Sender:Content-Type:MIME-Version:Date:Subject:
	From:Message-ID:Reply-To:To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eIZ17VpUxEJ4bv3i9facGsTn54aMzvCQ5Nzvc4RZ4Is=; b=H0pXilhVGcRgkHZDq+m3+MlHdQ
	3k6sXF8kyIrKsDoylnL1fDJdKhfIMrX5TFMhwp+VxHD6eYN6TseGKuYvIjkhY/DUNUAKg+w0Amnuk
	rhuwkZaBnIkn08DWzEINvU1hLJdlqIP3xGxYdaPEHm2qrAUYAb20QGFfkmPXNwqbWhJ8=;
Received: by s317931.savps.ru with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.94)
	id 1kahjK-0004va-0Z; Thu, 05 Nov 2020 19:03:18 +0300
Message-ID: <343187D4DF0B33805C591093D7C5A185@mail.ua>
From: "CASINO" <info-sent@mail.ua>
Subject: =?windows-1251?B?yMPQzsLbxSDRy87S2ywg0NPLxdLKwCAtIMrA?=
	=?windows-1251?B?x8jNziDEy98gz87BxcTI0sXLxcksIM/F0MLO?=
	=?windows-1251?B?xSDKwMfIzc4g0c4gMTAwJSDC28jD29jFzCEh?=
	=?windows-1251?B?IQ==?=
Date: Thu, 5 Nov 2020 17:59:20 +0200
MIME-Version: 1.0
X-Antivirus: Avast (VPS 201105-0, 05.11.2020), Outbound message
X-Antivirus-Status: Clean
Sender: add@s317931.savps.ru
Message-ID-Hash: 3KBGHN4DSIYX7WTLTQRDTWMTJVSQYVCF
X-Message-ID-Hash: 3KBGHN4DSIYX7WTLTQRDTWMTJVSQYVCF
X-MailFrom: add@s317931.savps.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="windows-1251"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3KBGHN4DSIYX7WTLTQRDTWMTJVSQYVCF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

y9PX2MjFIMjD0M7C28UgwMLSzszA0tsgwiDNwNjFzCDKwMfIzc4hDQoNCs3A183IIM/Q38zOINHF
ydfA0SENCg0KyMPQwNLcDQoNCtLz8O3o8PssIO/w6OLl8vHy4uXt7fvpIOHu7fPxIC0gxMDGxSDB
xccgz8XQws7DziDExc/Ox8jSwCENCg0K0c/F2MjSxSAtIM/OysAgzc7CyM3KwCwgwtvIw9Db2Mgg
0dPMwNHYxcTYyMUhDQoNCs/l8OLu5SDq4Ofo7e4g4iDI7fLl8O3l8iANCg0KzcDXwNLcIMjD0MDS
3CDCIMrAx8jNzg0KDQrN5SDg6vLo4u3g/yDq7e7v6uA/IC0g6PHv7uv85/PpIPHx++vq8w0KDQpo
dHRwczovL2JpdC5seS8zbDNQNW5oDQoNCkxURCBDT01QQU5JDQoNCs7y6uDn4PL88f8g7vIg8ODx
8fvr6ugg6OvoIOjn7OXt6PL8IOru7fLg6vLt8/4g6O307vDs4Pbo/g0KDQqpIDIwMjAgQ2FzaW5v
IFVLLiDC8eUg7/Dg4uAg5+D56Pnl7fsuIA0KDQoNCi0tIA0K3fLuIPHu7uH55e3o5SDv8O7i5fDl
7e4g7eAg4ujw8/H7IODt8uji6PDz8e7sIEF2YXN0Lg0KaHR0cHM6Ly93d3cuYXZhc3QuY29tL2Fu
dGl2aXJ1cw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRv
IHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAx
Lm9yZwo=
