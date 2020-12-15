Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 542DE2DAF10
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Dec 2020 15:38:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8B9D4100EBBD1;
	Tue, 15 Dec 2020 06:38:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.16.70; helo=eur06-am7-obe.outbound.protection.outlook.com; envelope-from=dfsdgfsdsdd@outlook.com; receiver=<UNKNOWN> 
Received: from EUR06-AM7-obe.outbound.protection.outlook.com (mail-am7eur06olkn2070.outbound.protection.outlook.com [40.92.16.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 04535100EBBC7
	for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 06:38:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFOElk06sqiU/JzRG4w5uFxKXM3ZEF1QtEoye6rFHl8y65H8b/+EINKIqwkeTgLHuGNfV09CTNirf9Jlq5aeg6FNUVCUgSlxfQzs90qCWqd5vRY9VgTxnzU+MsAlg3bXljxewYl22dSOd65Uwr2C6yaxMH5pFmH/BKH4LxhLOSrfC/Nt+JsJuJ6Z+zJrKibXNNE2njj0d0vkCoU2aYlHXeidumUxj+ExjPH1TewnIRXF9ULGEnXZFrncnVrX59cg5f2/r8LH3GKlwdNM1RulFqcDfnu1wI+l6syQ7i94wWNq6K5jlqbLgegmNEX9yyAH/Wmqt62NAGGD8kQN69Po0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+w8qNM72P00qf+5ZpupzQlUgD+88FHV3F4XAL0lTxI=;
 b=IVUCyJwDRtdbiWqsSq0dTJUxCWN2TMi4gEt/mW8y63isqGsPBAZi++F5i9NpYYVNlCh+oS5jNbcK3vn1vehb0eQ5KJJ4ZXFzDDhhGceFK6BHoNqEyBd6FKls3257EVLD9BGnzda0dE7oLNFv/wQdrXLzf7lLgFwCgLCWW+b89W1o1/4THiFDrURGqT5um56Tws04lKFaoMxfOZwGLhvPY1y82QO99MMrIl9yAzshEEjUCLSbrClRoo6Bly9gPH9cONW4415E+0MEOa7y6LvHyz7Y4fHp/w4Lq+zfqhgP1MyGGOnijHmu/FHfy8czm5BgM7chrOybVm9Bo/U+qsETmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+w8qNM72P00qf+5ZpupzQlUgD+88FHV3F4XAL0lTxI=;
 b=HX3jOLbBKNDAjNkrLEm0mcztV3smRONGqKDp7Z7W2xEoIXp9VC3f2SgxGOPUgdj6ACwMunAZk0p42EHzMcxf0Dj9YjMKz1jjRQ26GmnUZYlp/GYTqUGeUpliHAAdNmMhpiB9OlFgWvEhXxfjUaeyzRrL24svbivRL8xWZOOYZAJgQVgA903yFpxKhcjK+Zr4kTLDx2gNB/NurGTiuMLDS4uFOdve1zPeymYmW1gza6EbuOIW68KUVChDxP7OsHcqJ3afzp1rqZwRSf+L5NPW4R/3tjaGDBORhfSVZQhN5FRNa4ukYeocGawb0D6TVSZAWCsG9gUWKVCQBPv6NUwblA==
Received: from DB8EUR06FT056.eop-eur06.prod.protection.outlook.com
 (2a01:111:e400:fc35::43) by
 DB8EUR06HT063.eop-eur06.prod.protection.outlook.com (2a01:111:e400:fc35::349)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 15 Dec
 2020 14:38:46 +0000
Received: from VI1PR04MB6959.eurprd04.prod.outlook.com
 (2a01:111:e400:fc35::50) by DB8EUR06FT056.mail.protection.outlook.com
 (2a01:111:e400:fc35::490) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Tue, 15 Dec 2020 14:38:46 +0000
Received: from VI1PR04MB6959.eurprd04.prod.outlook.com
 ([fe80::81a1:f185:f739:faf8]) by VI1PR04MB6959.eurprd04.prod.outlook.com
 ([fe80::81a1:f185:f739:faf8%3]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 14:38:46 +0000
From: Global Financial Services SA. <dfsdgfsdsdd@outlook.com>
Subject: DO YOU NEED A FINANCIAL LOAN? PLEASE VIEW THE ATTACHED FORM. 
Thread-Topic: DO YOU NEED A FINANCIAL LOAN? PLEASE VIEW THE ATTACHED FORM. 
Thread-Index: AQHWw2DOY821OzOzEkuHwcOXaLABPanZOykHgB8/IPE=
Date: Tue, 15 Dec 2020 14:38:45 +0000
Message-ID: 
 <VI1PR04MB6959ECB7FA675C25FC4E5550ACC60@VI1PR04MB6959.eurprd04.prod.outlook.com>
References: 
 <VI1PR04MB695941357E36F1FD5280415BACFA0@VI1PR04MB6959.eurprd04.prod.outlook.com>,<VI1PR04MB69590F37931C8773C01DD996ACFA0@VI1PR04MB6959.eurprd04.prod.outlook.com>
In-Reply-To: 
 <VI1PR04MB69590F37931C8773C01DD996ACFA0@VI1PR04MB6959.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:E28FA5A4E38EAE6F5F379D9371CB27498D6FA43A7B9D18834EA76082E28BC5A2;UpperCasedChecksum:2AD9F5EA367AD048A262386E0875F17A0A15388488190BCF070F0599AE09574B;SizeAsReceived:20114;Count:42
x-tmn: [36oQWaCsRgY51AT4FvzFwob8rwtvRPsp]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 06f3ac1c-9b03-41fc-5784-08d8a10720de
x-ms-exchange-slblob-mailprops: 
 wSipExTYQ2ihVuCkF8Us1a45UHOGahrv5h2/V2JLWQNNQXflXk0CaNQvYkRoJymUQK40ycLez7p5MOeQqQFf1XaZfy/gwwEhcYL29nLawS6s64Rj0DKib1ANlT4hakKdLCWudhEru4KivyLhKPM/xGgetWajYI/9du1e6zQOtb66x7Yb/YAZozCeNQi4OPyDhY0LDTtm1OSUKozdsNHZnoVF2RVLO2jMBP3f2HeOqtt88Pw3IVX8Z9V8rGtOMuGqtBIRYAU4okgO7MwU5gCgHvOkfLkCyFMNms29qefYB+QVZmPDtxfgy3CZqto8OQlHhIOYMN6xraauYxXIpxefXZ2o9MlA9ijYbWAGv561MgIGa8mzmbrhE1ftcxFCPybzV8n8pvOOecYSO6xpwVrNuGVtgNv5Rsct/p5qY1dYp6tSnmiLkDD8lKRg2i7tH6OloH5Fn7YPh2J3/7dYsQqsyIPP2xRmeKzKuiPvQGj73YYAuAAaJB/SiW97KHXH1IY+j6BZMvmCVmYZwKCWNLujve+9so25vmT+FhjrBiBDTPeCoE8PWc900w72ZlXjUS6iCmaT1tVzwUIHFygSIuP/898xkhooYU5v7kqVF6H+kIQVNjEqkObxBn5y3LIqIyCwDosPwFXrsqtkd4Xj3P5PjnCye12o/UAH28FMt6TG88WQmJy+Orvc2DwZ6TfFyKHVEI7uzzg9tF3A73/Tn/nAHA2fupLGbp0g+eswJNwka5Vy3bBoJUllMw==
x-ms-traffictypediagnostic: DB8EUR06HT063:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ysedGOYx+hBln9xKDfQJDRpSnWNvQbyKe2URkLC+WegqXhRSDsENv/xM4nAP8fas4b/waXYWFIDPaVdOZiwHJTeDW2gd/Fz1i92qtMn5xFNAvfxixGbUjsSMFTsxqPEL/PO4bSaXiDZW2QSybG6ng3PzS/1m30q02mejsVoMbeJQVe2vNcc7kljcjVtF3X6DawFhPA/mmU3ttML6EvmAog==
x-ms-exchange-antispam-messagedata: 
 Vm2AVPwrch+W4cEFG+DPNpNhSGYTdQT8GjZLCM0pAN22WetEfAIwtTQkS0xyjNcHs5UF6oXYRtjdknrWugim80Q8qCQ9H57uAtFBybFZRlkaUTW0niTo42loMlcMbU0SQCqAE4T+KY11c+HOsKlDig==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR06FT056.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f3ac1c-9b03-41fc-5784-08d8a10720de
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 14:38:45.9776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR06HT063
Message-ID-Hash: JBWD6UZYKFPR5LIW3C5JC7HYC2WCN7LW
X-Message-ID-Hash: JBWD6UZYKFPR5LIW3C5JC7HYC2WCN7LW
X-MailFrom: dfsdgfsdsdd@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3PIEMSKGBR5NHYTPTFEALE5WNWVZWAWD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Greetings,



To Whom It May Concern,



We, the Global Financial Services are offering loans at a very low interest rate of 3.5% per year. We offer Personal loans, Debt Consolidation Loan, Venture Capital, Business Loan, Education Loan, Home Loan or "Loan for any reason and for all citizens and non-citizens with either a good or bad credit history.



Have you been turned down by your bank? Do you have bad credit? Do you have unpaid bills? Are you in debt? Blacklisted? Are you under Debt review? Do you need to set up a business? Worry no more as we are here to offer you a low interest loan.



Do not hesitate to contact us on the telephone and email address below for further clarification(s).

Tel/WhatsApp:  +27 63 923 1747

Email Address:  global.fs.za@consultant.com<mailto:global.fs.za@consultant.com>



Warm Regards,

Customer Service

Global Financial Services Pty South Africa.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
