Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A7932722E
	for <lists+linux-nvdimm@lfdr.de>; Sun, 28 Feb 2021 13:18:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 617EF100EBBBD;
	Sun, 28 Feb 2021 04:18:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.90.81; helo=eur05-vi1-obe.outbound.protection.outlook.com; envelope-from=dfsdgfsdsdd@outlook.com; receiver=<UNKNOWN> 
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2081.outbound.protection.outlook.com [40.92.90.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C1400100ED4AB
	for <linux-nvdimm@lists.01.org>; Sun, 28 Feb 2021 04:18:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3tZWyYxfVq1GsMowe/+z7ejFLP6Pm17ygIERMbSIupGyKVuaxDDDrsdZwJD7DaaeG3XAYXqn6imgS3szBSnyl2Hd2jmfHN2XKEW7I95HdoxzwR/Vpg1qjwcxPgMfqcQu8qJdmXIbLwamI/i/KfDLfEJHZHti2AoQIXJfroPMDe/5XCi7tcUCScTtiSyOfJJc9HYcjYw9QKfYvo1JUK9vGiac6w9vINKz3DPwAGAQt1a2vp7xltHSCHKWcqCDRtTmEV6J+eRhaIBGgD0P5ZUlj5arhNBmLRjukcrUkAUtL0i52saxnC72QDfakCXbI4jWKeZ8QA7JNuwZsb/s3Sj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/c5mKqAtXWrp4/YxHp7Upph3VLBw34CDuoDfjeTkhw=;
 b=IQdvy0CFGITeVhJc+z6N34EcS3IvLb/7ArFXTYqM0DT9hmrCtwwdtXgzyddNo7rWb9b7wo1u12VaU1BJYfUSlBB+okltWqt7CrM0xsczeIwp+X8crEJRukn3XLp4EVjg1luKfBvwNh6D44pFnMhHBt8IovRcmfbCvuzLXtLidCOVIc8rudlRFWXrDsWTbUkUUeE/dTYqamVBFeYvU/hTF1WNy9FInKAr+hNzK3RGPQwuI8CBbooZne5MhopidFPdrPJ0fcsJCR4vJ4SL6gQS3/e49iP6AMTeFPV/g2lK4GPf8oBc5ri22ir5mHaUsCYW8vIN0hxoJY67PbAgcIWKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/c5mKqAtXWrp4/YxHp7Upph3VLBw34CDuoDfjeTkhw=;
 b=Y0pvMwThbYJnVc9Qq2Xe80YDkOH26hmKvkfn+QQrOz1jjcW9z8DvC+bc0F+kJX/DrK4gLLL9eZxjJjZWYYwCteVydAKcfrc5iRrbIGwlWmItuSrKg6+tQXjB7N6kYt719drPLVHwZ/HpbPlBU4FapCh9Vxg9+ltINSVPf/5IV0NrZVwMWuCOq0yyuoncjcCpDWeyqmjeIjf8pB0YJy3BHp40wuMyLXPKPEjpIoHSicOj4x8qZm1TPTxX1R842CNgcaQiXVRWia238/eQ42sFxguLN+C9L/otygGflJFEu0nmLP4HHdLG/+kMwRh7Tca7xfPVP07TH/rXF0kGe8XjRw==
Received: from AM6EUR05FT028.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::4e) by
 AM6EUR05HT204.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::398)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Sun, 28 Feb
 2021 12:18:06 +0000
Received: from VI1PR04MB6959.eurprd04.prod.outlook.com
 (2a01:111:e400:fc11::4a) by AM6EUR05FT028.mail.protection.outlook.com
 (2a01:111:e400:fc11::253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Sun, 28 Feb 2021 12:18:06 +0000
Received: from VI1PR04MB6959.eurprd04.prod.outlook.com
 ([fe80::ed10:8721:cc04:219]) by VI1PR04MB6959.eurprd04.prod.outlook.com
 ([fe80::ed10:8721:cc04:219%8]) with mapi id 15.20.3890.028; Sun, 28 Feb 2021
 12:18:06 +0000
From: Global Financial Services SA. <dfsdgfsdsdd@outlook.com>
Subject: We Offer 3.5% Interest Rate On Personal loans 
Thread-Topic: We Offer 3.5% Interest Rate On Personal loans 
Thread-Index: AQHXA5/9ym1F+tg+OEWm2RNNozkhyKptsVU4
Date: Sun, 28 Feb 2021 12:18:05 +0000
Message-ID: 
 <VI1PR04MB69597D768E3C78108B0AB35DAC9B9@VI1PR04MB6959.eurprd04.prod.outlook.com>
References: 
 <VI1PR04MB6959D10A4C3BBCEA25E3B3D9AC889@VI1PR04MB6959.eurprd04.prod.outlook.com>
In-Reply-To: 
 <VI1PR04MB6959D10A4C3BBCEA25E3B3D9AC889@VI1PR04MB6959.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:C3B062D8A634B18E390EA34ACA6642603DE9FA9455E7486CB4CC4A64A2BE9792;UpperCasedChecksum:87B5C33CD36BBC1FED626DF34BD09029974A235CDBDBDF7A131B5228DF63355D;SizeAsReceived:31822;Count:42
x-tmn: [W0nGyPlxHUwBcw4YgNvoY6+rJztwonbI]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 1254f795-95c0-40ea-3390-08d8dbe2e72d
x-ms-exchange-slblob-mailprops: 
 wSipExTYQ2ggCrwILGGhnOxuGFrX0r+O81ccFq1C+2vYilEFax4qGr32paIxs3S4OXpbia8ztqZZy4oJ7OKoagrgNhjVprMyV4XlpLmMBgeQLvfHNkMWNmeB5ajC5U7/0OuSHRdNoaLrJBiQm5RoKeMm8BKe52zyI5c/sLX15AI4UcCydduRSExy191ctp6pmdV/c6oVBRnW94nA3cc5Ql9V5r1/F6KZVP7LyYzKoTTzHwa1vgeH8XF5GLciufWpYauLEMQbgWLm6Un0fBIqIAktiQdwx+tzX3vjDYegmu5X3QJfO9vuWVjZp+7zVxtWUaD6rivr02Mu/BRfcwZQaMHzI3ksTiOhYYAaaDafEJfawOK0VJ85KhOiGrdjypAjhfUZNcTt6u0z8syeQIp3gA7bTVzTrVjasSmm7nlCVOnbaYT17jgDQ6J4QPDGxqmtosIfO0IK8Ht0RGlvKoiSk0OhXVfs4L5WAelrPlw9GKlcrkgLYUZmuIdWrx764m6GE2cZ22zo2TjpfUQO5Nd6HW2EFEO859C+GmmOqFrsc8JQsly+Du2wjOamWijfFvM7Ul6ekZYUILdT7i18Tk8/JL+Ce7ijWKPQGGY31N0r/TeztcDLLFZt7yVb2qn6ZuuEtupMqD2CZFSKKHP/QSTzYgZsEkn+JHwePIy8wizaoSCMFUf5Z1wRd4Uf5GyE9H/+FvWWVjVlUDJHvjskKJRAZXv/iBUQNPCXY7z6IXwtH4JP1Sd8JPvEsw==
x-ms-traffictypediagnostic: AM6EUR05HT204:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1iN6tqYkBBqfNWTBdUa1UYTdkHSctlHjOzZQXym8l8X6AUZveoEWClxJlndpahOuRjYSR1leRSnBTpbnurzEgKscFi9gaVhFkWOFaQKGSB2nDTTK/ND4MIKsiAmyDi05RpLO6uc395oxaZNrMXeSUTUgkeusyF+hfgBSsHaSye9cciWqiw0XFn5TJJ14G3C0RoN9wZbEm8Q7eZe9KbQ3a3r7cIDuEnmrSNc+UwmOegqLt5mtvWqjMAJdvvDr9R5+MAveRQFJ3s1Yxqb+vVG0iJ+mhh+seTUeX96sCPhxxSMMZzhDQwDpYf33Qv+f9503VnyTVSwerQ5nQASzOCaxQTrsZCh10iR3KwYNWHrKvTg7raKEZ3OXUdygWNEa5a+nRIZB1Fxt7u1vw6x9PnpRbA==
x-ms-exchange-antispam-messagedata: 
 WqzmoObqgtUk+7+k6fiSZAOIFXOLlIEDoFTPEu5qUMf0shGNxs+u7LnA3eXQWGp1FAcbPqihkmDpfz4T3fQalTjt/mlAiU7xUZbt1PKxNVk9iAAqmZErlypUZYIe1LYo0K/sNIx15CBNeKN7MGaPGg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT028.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1254f795-95c0-40ea-3390-08d8dbe2e72d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2021 12:18:05.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT204
Message-ID-Hash: UZBCSR3EWUEGVHF6ST4SMCPIRGS2DP4J
X-Message-ID-Hash: UZBCSR3EWUEGVHF6ST4SMCPIRGS2DP4J
X-MailFrom: dfsdgfsdsdd@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7G6DJCBYNS2HLDLAEYXWGS4ZIBA456JQ/>
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



Our loan ranges from US$2, 000.00 (Two Thousand United States Dollars) to US$25,000,000.00 (Twenty Five Million United States Dollars).



Locally our loan ranges from R15, 000.00 (Fifteen Thousand Rand) up to the sum of R25, 000,000.00(twenty-Five Million Rand).





If you are interested kindly contact us with your:

1. Full Names

2. Contact Address

3. Occupation

4. Contact Telephone Numbers

5. Type of loan

6. Loan Amount

7. Duration of repayment



Do not hesitate to contact us on the telephone and email address below for further clarification(s) email us at: global.fs.za@consultant.com<mailto:global.fs.za@consultant.com>

Mrs Michelle Alinda:

Tel/WhatsApp:  +27 71 817 8194.



Warm Regards,

Customer Service

Global Financial Services Pty South Africa.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
