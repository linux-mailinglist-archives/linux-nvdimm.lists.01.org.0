Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D096269DA1
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 07:00:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C5DB714B8CCC6;
	Mon, 14 Sep 2020 21:59:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.70.68; helo=eur03-am5-obe.outbound.protection.outlook.com; envelope-from=ddddaabx@outlook.com; receiver=<UNKNOWN> 
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-oln040092070068.outbound.protection.outlook.com [40.92.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 85A2014B47CA8;
	Mon, 14 Sep 2020 21:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsrNKlheNbzgxuEYH3/64rmn9JMiDWasuE6XOpyXunpTKJmwdDyEU6xrrpgge92R2Pmccb3wW18hBy0z3FfvQsptHhK56uV0JoM0bK07SbZrgDj3+HqybIZ/OY8LcgdNUBTlkMElyuDen4XMGtDUIxBj6PLb+MFe61dwU2OsrMb5KLPnKS9QsyNQ6e2ug6WAkaFe6sZtfX9Y22p/PZUlHzI0B2wireOaYqTvs07fJGFxYf9pD70ks+VKgp1nLjTwnxX9c19v9k9cSg4NbJVflwBP+bQKFIMtWmAUclJZwDIs/G/i/qJkxT7qqDkkAhMnjMfIQuo7j0IfUnCAyYs51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfFruzxRc9ZgKYrzEmDPX3d5x0UyFv3erPLjiH/upg0=;
 b=aXVh0vbNLU6wzNe+Bc9YgpNVKQIwL9E6OBpN4/gf03xsurUJipyaYNr2peSQ2DOUOqan5GSWeV4fi1ZO/TzuCmxFrea+zlVxu/iPJ9qg6lxJxu94licPo9TNUtY3V3g4tshbW494fX7z34pgIIDenybpARThB+e0yEDVqXD+PXWa8etwT5wsJbkWtS+17DvTlQnP593099BSd6c8gqi765mZmTfOwDvYDLJwUfJ5OkVOpsmXyeTXsmLVYvb+mpaJLFlmN5dJ5NJSO8A6WLfpZp1j7PSCz3ImX61KHjge9XeteoWo+OYAIURHeNVBvSGPO6FmH31Yx4sbb/GdtkVrIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfFruzxRc9ZgKYrzEmDPX3d5x0UyFv3erPLjiH/upg0=;
 b=klFGSvZLwrHBhom44jYKyLtluUYVMx1RXOjDic2Jl+NltgoHuBVlvkxVNxQOjONJZhzhu9CysQUb7HClOI6D1qLICUSth8SVVxGqSDjKjdzWqU7yF2KysFOjfqsgrqmW71IEEnQYfnN3Ows2OKSUlNnjatYhVJvv54l8ZSc/UNzt+k4YQvqLFaHUMfRyTvAzA/a9mpWQVb+rLUpt9MBxpvEw6d6ruCYxAuDNL0jRDwfGOPJRBtOSfiN24xfCX/fjzOTj2HdKQKMLQVNI5begjnPQX1UWQN34zjMxAfVhI1xPvGhuyKeaEOQjUz2reCo1wkEGaNEHb3oEqFPLQyxf0w==
Received: from AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2a01:111:e400:7e08::44) by
 AM5EUR03HT044.eop-EUR03.prod.protection.outlook.com (2a01:111:e400:7e08::378)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 04:59:49 +0000
Received: from VI1PR09MB2429.eurprd09.prod.outlook.com
 (2a01:111:e400:7e08::4f) by AM5EUR03FT013.mail.protection.outlook.com
 (2a01:111:e400:7e08::140) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Tue, 15 Sep 2020 04:59:49 +0000
Received: from VI1PR09MB2429.eurprd09.prod.outlook.com
 ([fe80::50cb:e19e:f926:36fd]) by VI1PR09MB2429.eurprd09.prod.outlook.com
 ([fe80::50cb:e19e:f926:36fd%7]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 04:59:49 +0000
From: aaa aaa <ddddaabx@outlook.com>
Subject: Apply For Loan!
Thread-Topic: Apply For Loan!
Thread-Index: AQHWixzQKsdXcpoSwEqwasSdd2uKTA==
Date: Tue, 15 Sep 2020 04:59:48 +0000
Message-ID: 
 <VI1PR09MB24299D1F1FB934F6DB8AD5C8C6200@VI1PR09MB2429.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:1EA99770A0F765B353E4CF5EE5B8CA21B01BE5AEA6FD05352CD62FB9E4F663CC;UpperCasedChecksum:A01D8A701B8A19EDE0EF19CE1F31AD4C43FBDFB0B58316C0A319E2BC61C81C96;SizeAsReceived:30286;Count:39
x-tmn: [pId6GGfWjnf2vgkkyDtUXv5wz+3F+h/q]
x-ms-publictraffictype: Email
x-incomingheadercount: 39
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: f04d4a32-efa2-4926-a10d-08d859342c77
x-ms-traffictypediagnostic: AM5EUR03HT044:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HmSHgVj3IOJNm3cNQ/2VntiP0IHDfzeHuf233HLc6MpEvvxAp/AhBa0cEFCTDUpkZFaLXv0LEfJ4ZTdT2H/roBxfOo3/7MQhCsJ2aNkNz5CGpQY1MwTShOU1lcNofWb723nmSvob412vSsmPOVtR0qrBFlKCGBCL7i5TkSKacLxWjd2VloNIsJlwvWiZsEa8
x-ms-exchange-antispam-messagedata: 
 1CtWkmdR6dTwYsjvbZvHnO/mhVeV+9Jx1BlnQbPNR5yhHNAxKUC6tQXKDzYXmtvAPmgKqpICtyjvYA+TwFl2TdTjef9q9GKTpIsvKEES9FdAuA9zh1pszOh9lQyXbraZ1NQXhrFSE75LqllDGA2DlQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f04d4a32-efa2-4926-a10d-08d859342c77
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 04:59:48.9775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR03HT044
Message-ID-Hash: ZRMYKLKQY54ISTTKU3HMRW4WY22LTEKM
X-Message-ID-Hash: ZRMYKLKQY54ISTTKU3HMRW4WY22LTEKM
X-MailFrom: ddddaabx@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GXNCYROZU7NVACXV4QOIZJSUNPZKNZLV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

View Attachment!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
