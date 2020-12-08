Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1F22D3574
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 22:39:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 60855100EB841;
	Tue,  8 Dec 2020 13:38:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.51.14; helo=eur06-db8-obe.outbound.protection.outlook.com; envelope-from=fsdfgasey8@outlook.com; receiver=<UNKNOWN> 
Received: from EUR06-DB8-obe.outbound.protection.outlook.com (mail-db8eur06olkn2014.outbound.protection.outlook.com [40.92.51.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E8803100EB840
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 13:38:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmjOOrfkyeFZpoCoRrVHjGNCfLx09kKnYdlvBMZW8mDxXqUJUh1NBsCe0xWmyZleNJ/BtWGPdTVlCLBiYG4GMx8vVCJLceHFrqfCFCZFQ6rwuA9B3Asd8jL7TFOuedfskDwAb1MOVgzNz93Wy+1d+qk3VHXSzwKeNXyIBFyhtXJN0AubFbdEW50nwedwKGolwhJ6Y8jlQBHHUaftk4o6uaqozJo+y8vUezmHDyj4YV9fjEqjpd+/ZpLGowmcF5kKuY2n2LQC3UAxBOQ44xNsouf4yPYO1jAg9TpqcWd+oRyJ69V7aJeN29MB2UjW+rAN2ggRPXcBg7U8DzfXqlsa/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG3AgLF6y5OIia++7XcdEkyXVhBRRbQbSCXqYsrxvoE=;
 b=IflNnbJ/ddLkcLTovn+kG3Ydf3z6wGAR1df640UssHCL8ejqHjBd+kjDgVN+xhGGz/Mwi45bXuR+WOXsQwqf58ppTLwlnVuhn85QcO/Drb8h72rQRCNQEnlJwScQ8LqBhkZenbKx/G5xuaX9IrV3l58ugpWEuNbATfeBwQhZrCWBis2lQdnBWOvH0iyVV3lHScB09N3V9bOZ40AQKe1Sh98lpyB7VUj466Sbc3y2WYpcyAfPNWUmZLSkq1jj2BCXeY7QsVokUiUVBfYDHXuD7OIcBhdGpzV4xjGdPzKUeqL6SLxA84za1c+07koHDs6SKfZQwMJX3s0vcb15qxeSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG3AgLF6y5OIia++7XcdEkyXVhBRRbQbSCXqYsrxvoE=;
 b=V0b4GZJOuIsCqsXkeGKJikvSYwH+l4oI7+bK0xg6behj2DUZrWC2e7wtwE6xlrt44S3VM8fHfWWvWiGqJt+pvP7N2j61fFiHkAGDrsgtJlY7DJkMWCo98cErV7LfLTNKi0YVoH/WI8r78uQzjO6KGY7fnwRYEPwnx24v3URpiYysmURGwBskM4yWRCwmuU26f1FT/P1uguPavu29PZkpPynzjVN6obpg7TC0tqrRx43Js1Q0FKLH3AzM3MGC5c4zkb8hbgjB+jo7VZyvQkdB7uT5py831P6Gi3F4/iUcw5laUnaUTG8iMzjF23D324Fh9z7iEGXur321wf6TpChrIw==
Received: from DB8EUR06HT184.eop-eur06.prod.protection.outlook.com
 (2a01:111:e400:fc35::196) by
 DB8EUR06HT184.eop-eur06.prod.protection.outlook.com (2a01:111:e400:fc35::196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 21:38:32 +0000
Received: from DB8EUR06HT184.eop-eur06.prod.protection.outlook.com
 (2a01:111:e400:fc35::196) by
 DB8EUR06HT184.eop-eur06.prod.protection.outlook.com (2a01:111:e400:fc35::196)
 with TransportReplication id Version 15.20 (Build 3632.17); Tue, 8 Dec 2020
 21:38:24 +0000
Received: from AM6PR08MB4485.eurprd08.prod.outlook.com
 (2a01:111:e400:fc36::45) by AM7EUR06FT045.mail.protection.outlook.com
 (2a01:111:e400:fc36::383) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Tue, 8 Dec 2020 15:36:23 +0000
Received: from AM6PR08MB4485.eurprd08.prod.outlook.com
 ([fe80::d1fd:d656:6237:acea]) by AM6PR08MB4485.eurprd08.prod.outlook.com
 ([fe80::d1fd:d656:6237:acea%7]) with mapi id 15.20.3654.012; Tue, 8 Dec 2020
 15:36:23 +0000
From: Global Financial Services SA. <fsdfgasey8@outlook.com>
Subject: DO YOU NEED A FINANCIAL LOAN? PLEASE VIEW THE ATTACHED FORM. 
Thread-Topic: DO YOU NEED A FINANCIAL LOAN? PLEASE VIEW THE ATTACHED FORM. 
Thread-Index: AQHWw1oFVkEwSWOS+U+MitIB4a42ganrxjavgAEcj6c=
Date: Tue, 8 Dec 2020 15:36:23 +0000
Message-ID: 
 <AM6PR08MB448578868396CBE13C78A1AD9ACD0@AM6PR08MB4485.eurprd08.prod.outlook.com>
References: 
 <AM6PR08MB4485BF01853CCCEE841D1E0D9AFA0@AM6PR08MB4485.eurprd08.prod.outlook.com>,<AM6PR08MB4485DA06BA7475239EB39C339ACE0@AM6PR08MB4485.eurprd08.prod.outlook.com>
In-Reply-To: 
 <AM6PR08MB4485DA06BA7475239EB39C339ACE0@AM6PR08MB4485.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:AB75A6A733CE58945ACE5BD42FBE920818AEE13280BA3C8A1F8735E5056EAC84;UpperCasedChecksum:85FDE5BAF4CA09DCCE687E538DCFF274DF148DC3525EF6F65E018FE2DDD66FA3;SizeAsReceived:15418;Count:42
x-tmn: [FTSnFIWSefziTK6GAf4Aeq+R4AjJrrbP]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: DB8EUR06HT184:
x-ms-office365-filtering-correlation-id: b5ad7aa2-4ca5-4369-696b-08d89b8f04d0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wdgMBSHIgfEumVtmoNI5mMeSTHoNk7X9P7YzkKfGg+m83rGgnd23VaRyrAq8geHofxLO6MSeBw13flE0qClgTtmkX1jtZzZD/r1b5dZ7JFnzsh5PGI7KUiv7duYcLzV4NWXev1iugfJikT8O8P5EU9WAmIqd4fB1mWyH1QGLqVFWgXVQZ588VkU3DLxIGPksy7LWilPFN+hdasV11s6rlA==
x-ms-exchange-antispam-messagedata: 
 WRSLXjJmVbo2fjW46BVWGhfEKqp1cGavo0WroRq7Qp+FhQRj2Gw2cu3CO0x+04OWTQXOf8pVRpihoiVwA/X//dfXpM/R7+a0tRbEzzXigDUhd9ZbZWacNDn5RWz9lniEArqyrxl5UpezTUin/8AxkQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR06FT045.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ad7aa2-4ca5-4369-696b-08d89b8f04d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 15:36:23.4941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR06HT184
Message-ID-Hash: UUBQHGX32HV4URESLGSG2PMMA2WTFHQ3
X-Message-ID-Hash: UUBQHGX32HV4URESLGSG2PMMA2WTFHQ3
X-MailFrom: fsdfgasey8@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IRNPOVSM5POGNFAZNZNT5JT6QELIGHBQ/>
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
