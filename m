Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5594331FBB
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Mar 2021 08:24:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E654B100EBB94;
	Mon,  8 Mar 2021 23:24:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.89.89; helo=eur05-db8-obe.outbound.protection.outlook.com; envelope-from=asdfsgfdh@outlook.com; receiver=<UNKNOWN> 
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2089.outbound.protection.outlook.com [40.92.89.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6B9C8100EF276
	for <linux-nvdimm@lists.01.org>; Mon,  8 Mar 2021 23:24:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jucVC4I9kGv1Dfbsj7em6NM+aRROjzLQugwmn4IUf79OZuUcOs62ssmSpZoJB5qXJ9hOj/8VhWZ6RSU+8yBzf/e6xPWF2GYHbGpfM2Xlc6XOh8w9JWrXlanWaE57vonrnSJGdLMrVdm8D78Ei22+hzmXuj6kLylVIxyPcbsDx/myEpJUQDnu+mfhTr7eXiWrOuBT4dauoMeY4Catu+3KmM4rsBWCXQga/Hwgx+N/59gckevUAmRYBKykgQqBtav0kQ14TcFagSBpYG2cg4RDZ7QkXtj74LXikYHHnHdkWnG6lMZKVXOn5QjSViITAEHZrE2hNTXJ96f8HIohQ81Kaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsA1NqDF2LqJlfX/2DPSiCNO3+HQdHNkvMjjem+2YuY=;
 b=lMIcUe7OluGjY49E3YCFT2r/QECH17EfXuUMwb+ACmJfEkb/gThTjW/twmBNj8YjakLiXL9y2d+c0MNOczXzB0upPP1UkkfvvfY7ThYtAy36/qDy4hV33FWU9MTmmb/6XGWUbaVKP9HLolHwkfDhujN+S3AL6Isr1kFbE8+QGetMSECq9JMt9oZrcI3/d+LM/i842V9DnBonmd11rMxOd+aLn90an6ecXwakQgzChgNIKkK/QQPYg8rP6DhDBFoQggWrDGjL6ZMvId1Hw12mf+K8d6YF2XDjwgBJgKTNOsRBCmZSFnav84Ajyv6EWyLtTe3phoeZGDJ5RycmJFwmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsA1NqDF2LqJlfX/2DPSiCNO3+HQdHNkvMjjem+2YuY=;
 b=SQN9f2tQqsrWuRbUSCNKPZ7Kx4MZe6jjiRod8p6bSRKeaNYSqggZbs9468oXsnLWXAFLOGslBdeRW5jnExpFyvo3EVX1x8xIaECNaMMOowTx3KHr9S+LYttTFHFpF5/sWZUUEkaIBC31gHBXm/XGhhlr2QkaOGNCRnST/bfGFssuIgl5xKwSE14h6wWOMRHSn2Dkidn9zUkaHyR6TsK/rs0iJNVREjvpY8HFmTA9sFFb7VREtAydJxadVJmYavtuuOFaFWVOxB5IfLABYk0mV6G+M2mCuK8U5vDIJv7kJCnIHOYcZ2C+A+jJXj2eOZBWt2+lT8TRPRIDYi991GArpQ==
Received: from AM6EUR05FT068.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::47) by
 AM6EUR05HT123.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::457)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 07:24:49 +0000
Received: from HE1PR0202MB2572.eurprd02.prod.outlook.com
 (2a01:111:e400:fc11::53) by AM6EUR05FT068.mail.protection.outlook.com
 (2a01:111:e400:fc11::222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Tue, 9 Mar 2021 07:24:49 +0000
Received: from HE1PR0202MB2572.eurprd02.prod.outlook.com
 ([fe80::1d1f:5ef9:da6b:4d05]) by HE1PR0202MB2572.eurprd02.prod.outlook.com
 ([fe80::1d1f:5ef9:da6b:4d05%11]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 07:24:49 +0000
From: Global Financial Services SA. <asdfsgfdh@outlook.com>
Subject: Do You Need A Loan? We Offer 3.5% Interest Rate. 
Thread-Topic: Do You Need A Loan? We Offer 3.5% Interest Rate. 
Thread-Index: AQHXFLVJbZ60wqNDAEi47h9YIc/BAQ==
Date: Tue, 9 Mar 2021 07:24:49 +0000
Message-ID: 
 <HE1PR0202MB2572E8483415418E8D558EB9B2929@HE1PR0202MB2572.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:169C428EE5C4A8EE4E81BD99EF7508A469D48E1C611EC4EAC2E98D8DBF111080;UpperCasedChecksum:5F6055B3D033558485665A499B3395B944113D84CAE8A72F8DC8C801B5EADAE2;SizeAsReceived:19285;Count:40
x-tmn: [UyA2N/sCi08ef88huOdjbU1dY0nczI36]
x-ms-publictraffictype: Email
x-incomingheadercount: 40
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 677ba749-3920-4636-5a67-08d8e2cc6c97
x-ms-exchange-slblob-mailprops: 
 uTXRCFWIEYWThXcHI7xHx8umVRZKhIuXZgObFZAXi62DRSsFgheAabhD5C35kEH0QYSqZb/TmLDmi8vV/Nylq65yCkLRJCTfzl/6nauloV/uqPh2/GudChCxakSYPztZim5/n+yrZGo7xXIOeD1TpprfR6H28whFxNM60eYfoRdiHG6jG2njBkey8aYqQU1TFmkVQSmZDFTo/dqyXKyQVrYPzaZ84V/1SxQmzcf/Lwpi6e6ePH0rffImKxvF8yKMw6v31b3Y0FiyzAtGAeOhSczQ/FrzZXhw0iyKn7sjxKEbgsQIHo6KniOOHx41mOuBKOpnUIw+oo/YpAmTnVR/I5SdrCqZjClZMYCSFMjQ14Tt1Z0rXpaP9PcLUgx6Vg8P9CrOW06nLacrmEjs7Pi+wZkkMGuG3umzipDws6kGGfOjp49DGEceyRYOTyaIRVWsc4T3iVjyfdD9tKNaDTP8eMak/PrV7K+zMwZM361oyJtqi57jOiYSgFWpmoCXJcl0Rb8obvOxU3iytIuCg7aL5g2zwsMUiyB9d4GpK0HsaEMUVGm+QIgywy2H9U0nuwn1mb+nHDrsYi9gu6ZcYGp8/FY2p3PRCzgMiA19nL+hPFJ4ZSG01kIXJ4h5p6bl9ZhG+n4P2U4t6Le2sHio44PKbzfXVjlF1UAu6JOf8FAGKYiupYMtzlouo0ImUEpDjeWEuvv1lwelVjYOGgG2wqdexnViMq/NTq0hXAZPz0V+307GQOfnu7/KeS5DEZc4kjOT
x-ms-traffictypediagnostic: AM6EUR05HT123:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QZzpmrkxKujj6GIaq0vMftbMKF5zRGpK5eZNRhCm5r269p3CA0efC2gJcr6b7Qajob2rt9vwOTmLePuNwXqZLcSdL1ebdEsmK25+LZw8s77eAkDHzn7ngyhsVktnD9tsD93wFFfCksdCDTD3+NFxFvjIc2J2JNB4OQnllta9xG3AQYA/2xQ0nWRQW7fpsKI4purXV1bDMVFdRASPhpQ5BAIIJ2oWkUDnLcQGRHENmF4RKutynDNR1ng4+aYsdl8xIOh6nDHIVG4kT8mpb4zN6GlRy+637MwrFVZWrLFrJiPSfR/vNVPStqajxM0E6to1RWpuosU15ZcTShurFs1YUncq9g0LcyiWxYMSoBdwMNozPMA8GFjoDSEibbbMBvGM5f1F4hMHx14jp4m/xLBXkg==
x-ms-exchange-antispam-messagedata: 
 XLqGZFdgTgB3v144QFMKs3PovRscg9hZliPMY6bmufqVYbSioqtOGRIYJrtMoPsUgoklxe8N4HvJcBJ5/6YII4r02Fgiwuh24zEMyt4rV18mfq+Yz7gXL2iOrh2akfqYquOZ9M7zoxI2LS6xmrYkqg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT068.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 677ba749-3920-4636-5a67-08d8e2cc6c97
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 07:24:49.4190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT123
Message-ID-Hash: RBHJPVFUPJXM4BTFO4TFIACUVI5DFATS
X-Message-ID-Hash: RBHJPVFUPJXM4BTFO4TFIACUVI5DFATS
X-MailFrom: asdfsgfdh@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RQU3X5MV2WMEZWTS22GPYAFK7CW3IXVU/>
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

Our loan ranges from US$2, 000.00 to US$25,000,000.00
Locally our loan ranges from R15, 000.00 to the sum of R25, 000,000.00

If you are interested kindly contact us with your:
1. Full Names
2. Contact Address
3. Occupation
4. Contact Telephone Numbers
5. Type of loan
6. Loan Amount
7. Duration of repayment

Do not hesitate to contact us on the telephone and email address below for further clarification(s) email us at: global.fs.za@consultant.com<mailto:global.fs.za@consultant.com>
Contact Michelle Alinda: Via Tel/WhatsApp:  +27 71 817 8194.

Warm Regards,
Customer Service
Global Financial Services Pty South Africa.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
