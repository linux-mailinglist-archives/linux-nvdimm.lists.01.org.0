Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DDB1D9790
	for <lists+linux-nvdimm@lfdr.de>; Tue, 19 May 2020 15:23:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 669DA11DED9A0;
	Tue, 19 May 2020 06:19:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.74.46; helo=eur04-db3-obe.outbound.protection.outlook.com; envelope-from=didy2tds@outlook.com; receiver=<UNKNOWN> 
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-oln040092074046.outbound.protection.outlook.com [40.92.74.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 917F211AD8DA0
	for <linux-nvdimm@lists.01.org>; Tue, 19 May 2020 06:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8uZEAQrlCdNcqua7jjGM0qmz8nEqA8J4HVjSj1NkqHFTm42JE1Kz7/43wZD+YPKDJBMIKUNuW7DH2gysb8Zy9mXr+dS1zFs3I8BD95xOoRz/f9tDSY3X9DO5pif+R2Oe6Dl8GwUR7Q7iLOzvzIpmbOvz1h0kohmYOF5kkjiGDeR+eDaljiYhiRAFXXjPaycaI9xFjtTE+gqCJ/oPboaV1SZKRvWkmwIn2D6S5VTx1SHC4t44TNQrznnB9S/66LfYnFrUYQqfrWMGckFPyDkD8LjEWtGBTS5IgBcjxIQDiR0aPhToZCMN5/dGHhz99sRAvDJcnw+pTIRcQLr8UE3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi7z1S197yfjK6P5SFHoRsSD/fPeXXz+nnfojBA5ps0=;
 b=Tqfd/bLRIrwj55qzuw62Sxapzz5qROFJp9b/sO7xHisnxPMf5aaO1PSWbjXKouJNpEl0aaYaBF/oYOmtetKTQziRAh/eHr+kxP5MfTmsi5+WO+fp2xYDsrYGBiqVVNWsLA5LIPBqSLKq31PE7XaXFRPiR8usXr/ln/rAHk+lTH4wKSxLRJlbZ+ory3QVtbr+PXGgTKC6stxnWd8Rl65jF9OK6Okewh8TdkKeCauFRJbVPFSV32y3GmG1I1ImT8Uh/hnRgERFxNf/h+8jLxeEVRmOfTrCVTjD6Q/hfLRPJho696JimvwbfQi7JgmrU9cEvkFpzmpPMYC+IlBP+fgx5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi7z1S197yfjK6P5SFHoRsSD/fPeXXz+nnfojBA5ps0=;
 b=o97OzUZEVOhMeEVfdnuDyuKgws5jyufLvD49bPvbNBnwJGIlo7U5cvS1wAkrP1s3yIi2yHkUiKl9g9ninNY1JweK/OYxjXB/7FQ2fBQbp6ptxfsCvikkplHrwLU4/wETh/Zy8opJivyoTWFKJIIKV4cB4XlbTHYL32Y48FURMSY5f8Gk/9Koq7dvDZP50w2r+IpjCs2R6yWBOjz1S7Y/73KUVMRbnlr+A2S8X35K1+zUuG8rXsAYJS4UyVVtqTMzLtZY9HdYSvJv6YkFOWAO0DfBl21joj1Mmvr38Qo0SYPVFwMXU3YwvIxMd+3QPvFX3Sgxm2wlg8HQSD4DBtn9KQ==
Received: from HE1EUR04FT019.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0d::45) by
 HE1EUR04HT123.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0d::363)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19; Tue, 19 May
 2020 13:22:51 +0000
Received: from DB7PR04MB4124.eurprd04.prod.outlook.com
 (2a01:111:e400:7e0d::48) by HE1EUR04FT019.mail.protection.outlook.com
 (2a01:111:e400:7e0d::117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Tue, 19 May 2020 13:22:51 +0000
Received: from DB7PR04MB4124.eurprd04.prod.outlook.com
 ([fe80::872:91f:9c89:63a5]) by DB7PR04MB4124.eurprd04.prod.outlook.com
 ([fe80::872:91f:9c89:63a5%3]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 13:22:51 +0000
From: MA KM <didy2tds@outlook.com>
Subject: My Greetings 
Thread-Topic: My Greetings 
Thread-Index: AQHWLeB1CBNilu1m7Ua9+TlQI9Xpjw==
Date: Tue, 19 May 2020 13:22:50 +0000
Message-ID: 
 <DB7PR04MB4124CECC308DB94288FF66D49DB90@DB7PR04MB4124.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:7C2C4C7978FB5C897DB2F9536C83145C968BE40D43915911151200AF338E8524;UpperCasedChecksum:BEEAACA0EC9FAD67C0AB6BD794552913AB0F2C775314446F952881A525D3B23B;SizeAsReceived:11861;Count:41
x-tmn: [g/jn/3OMDetezq7U+tc49ERQtl/fE5lH]
x-ms-publictraffictype: Email
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 7b515ef0-64b5-4894-9e1c-08d7fbf7bb14
x-ms-traffictypediagnostic: HE1EUR04HT123:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Dc79bNwPExqbxUDfRtWNwRD/9u+6sJgVy5BjslG/lp1FuvEXTBIu8L/H9x+ZmnPGGAVf8kkai77kXlNxXuHIXcxqbxXzljVBt3nsYxd/+fGq8ZsOIChRY0ltCa8HBxbMj0EKmqzuQNbAFqKyQhHxU6oNYWS+hS7OOKtAiFi6AMk+FDiy9n0qrPUtj53gi1SyIPHtTPuR62AP/DNFtnNDdaDLZFMe0ZklGzSG9ANXOA8xHAbaGHqWR5Xai6nfcJyH
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4124.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
x-ms-exchange-antispam-messagedata: 
 jQ/MdfHOFOa1qloQdZPK/uD34Z5hzIy0Mvx9YazOcOD7exuZMPManaZrUNpl//sGJTENvkJvRIb9IeklGbcjEAaMxIansHQIoredyRIVibYZOiy+YEz/a7+/kkZKJcqS7Qi5HjVcW3Vn7t+OxI+WdA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b515ef0-64b5-4894-9e1c-08d7fbf7bb14
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 13:22:50.9629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR04HT123
Message-ID-Hash: JXCCRR5BAZW5QF2WZHIWFWXFBXGWXNST
X-Message-ID-Hash: JXCCRR5BAZW5QF2WZHIWFWXFBXGWXNST
X-MailFrom: didy2tds@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MJPMPIZK6QX3UK5A2XF25KSN5KMIJUHX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello

With warm hearts, I offer my friendship and my greetings to you.

I have an immediate need for a business cooperation with you. I got
your contact through the Global Business/Investment Network.

I represent an interest  individual who will want to negotiate a possible
working terms with you on an investment interest in your country, worth US$100,000.000.00 (One Hundred Million United States Dollars),
This investment fund is originated from the Angolan National Oil Company {SONANGOL} www.sonangol.co.ao
The percentage will be shared in 20%/80%

Kindly get back to me for more details.

Reply to my private email: johngledhill123@gmx.com


Kind regards
Mr. John Gledhill
Tel:+27 83 369 5008
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
