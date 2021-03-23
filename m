Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EC9345C83
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Mar 2021 12:12:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0974A100EC1E7;
	Tue, 23 Mar 2021 04:12:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.255.22; helo=apc01-hk2-obe.outbound.protection.outlook.com; envelope-from=anupamgoyalseo@outlook.com; receiver=<UNKNOWN> 
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-oln040092255022.outbound.protection.outlook.com [40.92.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DC2B5100EC1D7
	for <linux-nvdimm@lists.01.org>; Tue, 23 Mar 2021 04:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ87QkNu722dpPGZOcQB6/Wr7HZbSxMJvQXeri79uSuGZ6j8o5V5wuhqYttC+O1zn47bp0WH8x8jsvRfw6wyQqoYhZGeui02fFqojXThsXQNfXEj0RpPHdvnmdckmaXtNq4cgCG2Ju1haEufxZb4GxBk4bktwY2qio2DWA4BjzO82fWNr1CkWjQy4sHhnoEjeyJXlNXV3A4F6C/axo3CP885dOM3Vhfwt5cf8t9xLjeYqos2tuf5wsDHFmx/v2gFGpMckEjTGHG7+ola1zBo5kXdS4CxagttUx2Omzyc88qF06eQrjWsJc304t1WGkvtYzDGaSeefm0MtyNtoL/Jyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsDchYZVQQr2yc4qMDUNRU4kIiYadiBlv95ELa1szK0=;
 b=JHccxQ4xMZZ2Va+R6qD40XTw4cr9Z2SHLj9A8BHRfEE1Bjt9iwxMT5gYi2FgA7pq4Ie9mi4s/ktfiZlFuuUHQgq2sERXMkLwiZ+qgaV8/lFGNqY+0vi33HCdracXz2y5lzPdnlGF99PvczmymtQS2TvNEV4Ue3vzRmYFpBj/ukeRRYqBXoZLRsj/9VCHsKD0tO9idGuNsTragT3VbxNVipZAiXeBMNCVzuvJLZGmDWaeh82tMTO1RNLH02cObN5hOO7XLJNLcjdV5wajJ3wM01v+weZJjj1usvE+EEc3YVdlm9OzllqYc95V6a57gZhPPdhVwTHvhYPjH5qcH4BhVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsDchYZVQQr2yc4qMDUNRU4kIiYadiBlv95ELa1szK0=;
 b=Ts2ZaRawerf+OdLgg/ULzmODgHy8vXtXwIbrtGH/MowUtqCQfkIfxr/UXWpTxZ1btrfHxSIx5Na2qWQ9Vr8wAw7a3fiha6Ib7JWMtVATp0T4mDsSq+Nl029i+dApN9sBGRcc0BZlxGI9MOZzSBbJ2eXk/bNFmgLKeTMtOvhoD0c7g12iVutaw0+HbjKBsjvlybf1uuAG/96a/p8eEicyb4CTBJeb7WCY73foOc7X2gQC9zTP1OZhKoN1ShmS+kCIS1qa7Z3zHd1BUHg+jULeOP2FlgRJ/K8nkm3nH4aA8ppHHNQw197wSKX4/GwdJE6pbLAYY5fpGswG83bO2yFscw==
Received: from TYZPR03MB5245.apcprd03.prod.outlook.com (2603:1096:400:36::9)
 by TY2PR03MB3997.apcprd03.prod.outlook.com (2603:1096:404:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9; Tue, 23 Mar
 2021 11:12:25 +0000
Received: from TYZPR03MB5245.apcprd03.prod.outlook.com
 ([fe80::f01d:3fa4:efe4:2772]) by TYZPR03MB5245.apcprd03.prod.outlook.com
 ([fe80::f01d:3fa4:efe4:2772%6]) with mapi id 15.20.3977.024; Tue, 23 Mar 2021
 11:12:25 +0000
From: "Amit" <anupamgoyalseo@outlook.com>
To: <linux-nvdimm@lists.01.org>
Subject: APPs
Date: Tue, 23 Mar 2021 16:32:59 +0530
Message-ID: 
 <TYZPR03MB5245E62416057AAB1AD949CDDF649@TYZPR03MB5245.apcprd03.prod.outlook.com>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: Adcf0/ZYUD1kgRTnQzWEa1+P7VRPMA==
Content-Language: en-us
X-TMN: [89RjWA3fb1OsilzmQzLJ24XcSJxg+L7e]
X-ClientProxiedBy: MAXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::25) To TYZPR03MB5245.apcprd03.prod.outlook.com
 (2603:1096:400:36::9)
X-Microsoft-Original-Message-ID: <e97001d71fd5$25d8f6b0$718ae410$@com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from adminPC (171.48.41.238) by MAXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::25) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 11:10:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e71af359-663d-4d86-0695-08d8edec4773
X-MS-TrafficTypeDiagnostic: TY2PR03MB3997:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bNbkC7y+tcq7CMWlkq7GaJz3PEnPQrW+xx/LrkBReI6i+SQ/R4+t6mLDi5VeVFhpYPvptmsAKcsrGXLJ7ZE259Dr9k4iKUED+pQY1C7ACINw7zyjPsIf8KBImUs8igVZXwer/GKoS9gjeDnYGHvrXQZVrQ5y9kO9xWndZ/rbV8qlaS4cwSzv8X032duKYYipdZz/lqmjKdJqE7ZWTCrZLxIAcgB65cKSAOmyIDm4bi+5VAcdtJDfNljgKixr8YDWvQk+/oZu5NPwcQRURZ6pM3sa6enF//llLf2lKnEk9hHxy9COGW8Yx6j1ABtD13+d/RaV5vGWoNx/ooWaxaiJG8FKlg4leNkCb2h47VHPiVJE8dPKc1tfumji4HThvY/P/i+3PAoIlTt6DuRY2Js0mw==
X-MS-Exchange-AntiSpam-MessageData: 
	QhWfOSNo0AhOl3c59dQQ57PTc3CcCgO2w1Dbi6nx7LZWtzYkf+pLPTB2Y53YzWKVn3D0VVh4s7kbxImtUD2V9gFS3aKADeqgvMoFMW9jW5ByMQcDcik42rV6Us2cSrpc8c/wMGC1alZdWxaZBH+jbA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71af359-663d-4d86-0695-08d8edec4773
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5245.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 11:10:34.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB3997
Message-ID-Hash: 5CI2KK25LDJFY67GWPNVJX32KY4ST7QH
X-Message-ID-Hash: 5CI2KK25LDJFY67GWPNVJX32KY4ST7QH
X-MailFrom: anupamgoyalseo@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IMG5LHJ4ZQWXZYUCVCPPBQL4Q6A5BALH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, linux-nvdimm@lists.01.org

 

Greetings of the day!

 

Do you want Mobile Apps (Android/iOS) for your Business?

 

We develop mobile applications for global enterprises that help them grow
their business.

 

We have expertise in:

 

. Food Delivery Apps // Restaurant Apps

. E- Commerce apps//M- Commerce Apps// E-learning App

. Health & Wellness Apps

. Shop & Store APPS

. Logistics and Accessibility Apps

. Taxi and Travel Apps

. Your Business Apps (Billing, buying, booking, finance, tracking Apps
etc...)

. Lifestyle Apps (Texting, Music, Book & Utility, Shopping Apps etc.)

 

Please let us know your Apps idea/exact requirement with us which kinds of
Apps and for which service you want so that we can provide solutions
accordingly.

 

Thanks,

Amit

(India)

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
