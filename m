Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824DE2A4BB0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Nov 2020 17:36:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 21BA81646FB77;
	Tue,  3 Nov 2020 08:36:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.73.54; helo=eur04-he1-obe.outbound.protection.outlook.com; envelope-from=zcxbcvyuxcv@outlook.com; receiver=<UNKNOWN> 
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-oln040092073054.outbound.protection.outlook.com [40.92.73.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9A4811646FB68
	for <linux-nvdimm@lists.01.org>; Tue,  3 Nov 2020 08:36:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTz7yAbbCob6H1IY1TWa2jY+7gHK4Kdoucte7X0i5MKviMEg3gbV5GcZSwMOpB6E0XdQ3hCjjpd+5Ox6Pm/Ml/F1AIrlLKWTuqrVrT+RIe/Y/vdttLz+mXu+EehsvEL+sEDKUun3U1Cr0re2XLOvy7cQ9VrhyxskPU48xvxMVWguwqVR+lSEyMWYO3r0Ml/cjYRSuj5IW6wzslPA2MrnGGPIwtNDCmlFyMIVBN2AqqgNfkbQcTncaalJkCiujwhRukv9YW6VLDV5sgPlEZ26XFS9tTkxzhRf+c7aYzTjxt9qFzw//BkXKzXZrzL08wZcfn+poQPjQuqd8OjygXIjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EgsBlqHtXGuqzcCQlKeyTjbRf+37S9q+vvuDzuYqWo=;
 b=YJSRMJEgIdl4wJIyeYJIOI2y07EiSflddpxrogfpNN3qsNkjFAA4VaYaYPRTOZiJU4ZRRnLTciMK8KZFRZkoaz7Sr3L20DX/EdWuBAi3SR3LpQ45DB6se7tI+4fVuIf9O0FhDjhHAACVRTN4qPCROFZSnPjsyPy7Uv7Qh9uCnigHbr2lzgXQQRuz/+1xLJQhMSmSOSIcUHqofBjUYvK3hrto2JSVumhx37d+/fzweg1xmf+R/kF+zuRC1OqE4xqf1xTGk04DZgC0fUWR4R32QI7mNcEv58lS9No86456BNZFDAE3CyqGi5/RVYUhTtd90PCsYs2dUsa8QELSL1INow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EgsBlqHtXGuqzcCQlKeyTjbRf+37S9q+vvuDzuYqWo=;
 b=OPfynkFg6RlvwCeL4+gCh5TrOpHxuT/85BfZlP9QDUt9sh1OQ2v/DgHGgUUnJyfgSIjNt30davB//7jy//jx9zDKT1wbjR9Kk/WlTCwjz4R8/8AsXyKYLUsm8IWQc75mGhDBCgjQ+EUFCO2CKoez5L+oB4soYlgj8TnR7tfM+uQyy4llFGs0fn6dErDC77LitLyLYti8D+ItsQbGi3tXTcC+MDdW0jSS3QBwqFnF4Jb03O2wDmcF2Pc1wgCjQEUrlP5OAZ9w/97aEtn9FpMOmkNSulEQ/GRGdGsqxXeBmQg5wjSeNziLt9xmAbueShDYudcakrmBdW6hpqe9JyLpNg==
Received: from VI1EUR04FT008.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::53) by
 VI1EUR04HT149.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::380)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3520.15; Tue, 3 Nov
 2020 16:36:36 +0000
Received: from DB7PR10MB2393.EURPRD10.PROD.OUTLOOK.COM
 (2a01:111:e400:7e0e::4e) by VI1EUR04FT008.mail.protection.outlook.com
 (2a01:111:e400:7e0e::406) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3520.15 via Frontend
 Transport; Tue, 3 Nov 2020 16:36:36 +0000
Received: from DB7PR10MB2393.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::48df:1437:b23f:417b]) by DB7PR10MB2393.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::48df:1437:b23f:417b%5]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 16:36:36 +0000
From: Global Financial Services SA <Zcxbcvyuxcv@outlook.com>
Subject: DO YOU NEED A FINANCIAL LOAN? 
Thread-Topic: DO YOU NEED A FINANCIAL LOAN? 
Thread-Index: AQHWrgQ7lqHRSg5HR0ylVHX0A6+Yuam2otm5
Date: Tue, 3 Nov 2020 16:36:36 +0000
Message-ID: 
 <DB7PR10MB2393C86B52585D860AE8F3E7AB110@DB7PR10MB2393.EURPRD10.PROD.OUTLOOK.COM>
References: 
 <AM0PR10MB23875D2644DB762FA2D54C47AB140@AM0PR10MB2387.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: 
 <AM0PR10MB23875D2644DB762FA2D54C47AB140@AM0PR10MB2387.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:F339D6AC41383524E38F47EABD5B3A97A0EAF306B92E0A3200428981974114DD;UpperCasedChecksum:F54DC8B2B096F7A159A464374B489E477B349FD6628D5832FCC68C49EBA8C802;SizeAsReceived:19637;Count:42
x-tmn: [cnLaAJavYo+UvT2RHqa03nPc1adIWO4XD/JUjpP61as=]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 6fb0c68f-3628-454f-a97a-08d88016a1c4
x-ms-exchange-slblob-mailprops: 
 myhWhilQ5IIeOHgs/GtBJ5pHrw43kPriC3sZ7EAZLGI6eRTWBkQBJJ2GUccm5wJj7qmPBC75OyOTRyfDEhX4DX5QZCALL1mbnKOk9pYtQQWW24bVn6/k+cfm9yjmln4XlUGEaVrmtlg4nbOr0Qu6NptDTqYwAa7SLwO0w82pHAgG9L27K2XHaUt2ck2t/R/vhcJFwZkEjzeMjhTa19G1M+2Z8u6lbzCZ9f7ueVe0JpVHTs/SThXNzXoz3SPYbyorWLARyAsvNuTxIoQuWGEnLVAfems2kOeIQh8m9lXLU39fTa+6CPdNK1cces6OItP6eTvbOcVqthGg1KL1eF4tgyznYHfHn8LCwIQxJ0Fw8FawC6eh6LtB7ndCr1QrNhZ6FgeuPGtmnrJ7yIS0+uNXHZGp0EFzXkb7rqY+LNlxO5bbcpsEnj6bzGYz4GzqhXoaeSFSiSJT492UK7kNrzUlBHOx0bOAg+hg6cH9IaT8TmzboaKVEv3G3E7ZfQ3S2Cu/uMQ+cupeiS/ztr4p/7orR3Y1vilL6WFoQsdMFKJCrI2s9pssEb9J/LXMlz7Nt9R5BfGhBd5w3/poAjDaHY906QZBWQHEqqAXcn4SlTTdYnQMEqMu19CtTU4YMTURvoslbHlxsiRAtNP3CWetd9psaXCBfM3ic/TQESRqTzPjeytmEtqCmpe/ZZDhoGoHy0sH
x-ms-traffictypediagnostic: VI1EUR04HT149:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZD6lRblwVaDjSfPKVc89InMoSNkpPBdiq+py0EuChMR8z04kPG+QK84UjDs7RAzkP/7JJjZWsyycxifEm8+1q1GeiDWENbrAoZR/TOF5kSZTPg+CZHSPs9l50/zc63rhMQPylQ3Ay7sV/odMZH+YMVZ8Njn9gJ5TPLFcjnvc0VUGLe9sLh6QhAHgELd2fQUbWxd/jXL4GNtG16HYGtSLtA==
x-ms-exchange-antispam-messagedata: 
 57jU3HEjB8q9gGFfh3KvrR9zZ1hxBHtfKwP2Ce1frYjYXP/038XnsG0vs6Qoxv6buNOCFuj20UEQ+pwjr5789m2uEL/p9oWcIWfy54HN+eLV/CtNFgQZqkQCSP9qDuyJFxCoL9boDP/pvTQhhb4z+A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR04FT008.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb0c68f-3628-454f-a97a-08d88016a1c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 16:36:36.3202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT149
Message-ID-Hash: XBWL7XELSE7X22TRGB2BRZL6U34TXSOT
X-Message-ID-Hash: XBWL7XELSE7X22TRGB2BRZL6U34TXSOT
X-MailFrom: Zcxbcvyuxcv@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZKARRBV3DGL4TNBCWYBJX5SRRZG4IBME/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Greetings,



To Whom It May Concern,



We, the Global Financial Services are offering loans at a very low interest rate of 3% per year. We offer Personal loans, Debt Consolidation Loan, Venture Capital, Business Loan, Education Loan, Home Loan or "Loan for any reason and for all citizens and non-citizens with either a good or bad credit history.



Have you been turned down by your bank? Do you have bad credit? Do you have unpaid bills? Are you in debt? Blacklisted? Are you under Debt review? Do you need to set up a business? Worry no more as we are here to offer you a low interest loan.



Our loan ranges from US$10, 000.00 (Ten Thousand United States Dollars) to US$25,000,000.00 (Twenty Five Million United States Dollars).



Locally our loan ranges from R20, 000.00 (Twenty Thousand Rand) up to the sum of R5, 000,000.00(Five Million Rand).





If you are interested kindly contact us with your:

1. Full Names

2. Contact Address

3. Occupation

4. Contact Telephone Numbers

5. Type of loan

6. Loan Amount

7. Duration of repayment



Do not hesitate to contact us on the telephone and email address below for further clarification(s).

Tel/WhatsApp:  +27 68 231 5874

Email Address:  global.fs.za@consultant.com<mailto:global.fs.za@consultant.com>



Warm Regards,

Customer Service

Global Financial Services Pty South Africa.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
