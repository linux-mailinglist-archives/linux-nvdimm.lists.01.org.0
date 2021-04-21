Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A806136661D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Apr 2021 09:16:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F3468100EAB48;
	Wed, 21 Apr 2021 00:16:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.75.74; helo=eur04-vi1-obe.outbound.protection.outlook.com; envelope-from=dfsgffjhj87@outlook.com; receiver=<UNKNOWN> 
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-oln040092075074.outbound.protection.outlook.com [40.92.75.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CC950100EAB41
	for <linux-nvdimm@lists.01.org>; Wed, 21 Apr 2021 00:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDkbfsTb+s0TDbQd11pPiqQeTYI88zV9DdRKNwW8Ixsi5Xrmvi0TlVnoUAy99wVmG0e4uFQYIMz5p7H4rA6EAeU8anelSHOKaQqgzRIi+Kzb056QVp4YlQIpeU7/K1VQbVoDvHMXLENJec2F8WjOm/M16SBzceTLQ5kEOrvAWVZA2JFcrxVOg/TlVLTGHbiVNXb4tSNbKveRtaPFcGpO4ofYlF7eMF+IiFShG/X84RM/tYQwNqIX1nUwUjQT/lqkrxR0Q1Vyyhs70v1Ojlhrck2PTW7t3KU/+yiVyXYn+16g4dQZICz4fepFrs/weqQnfYvJAys+EP0+3wN1iKBp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+mulV5rEuLmAM42qGdI/xWC6g7UYk3k7/auFk2CBoE=;
 b=oF06ebCbley8jknjoyhusHXuDUw/llQv8CKDXKO9dKFVvgaKQYshz7dWQKeSatMbvGdXaYiYPkcOzUuT8nkCJgHZCwFTjb0mshsYDM9b14tDyNz+7Fc3iAvceRzj8lOHaWOY5TM0Qai2WxU36CCQpg8yUu7FMJlmMW+SSTRR+dHKsSu84DhTrX9MqtnqaPgy+YsmG34Tejcze1bNNlmt5+u85eszNkbVpS4kLpE+Aiqyp4TnFhNkIo1lJ9vjqW8UZO6tZYuNnJ0ZG5wh2nJx5RmtDHsWbPEAihEKouqujzI1end9jU6VFArdsdpEwOiECNedDotcYdX2cbB9B4cuTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+mulV5rEuLmAM42qGdI/xWC6g7UYk3k7/auFk2CBoE=;
 b=Z2siYegLmL9gzRu+iWiWVM6uGmquolWf9AkQLF5G7UkB6k+vyojI3io05pilDTgjtAjjIIO2EcRltSUKT8FNqUjw9UwLQk8uamcfDZid79iV1wsYSjk8qF12IGIy3ny2VGh/1TcEvifbCHcT+GEdWXuf78kul/d+yMVGxcPRhjY52p97eKKL16V1GT9CqXdzAt6td5lsDnpHEuKE9zXKDduTdgdNL3eDpGhOG9jjkL/+YOGBeyYeJd+c7rou2M94tfQ5YsOsxYTj+AEIPNzuj/m1XE3nrFWD0JxDumlUJqcw3trjBV5GSVupZfETuuyOkrlRiiSmD46jYMSC1Qj4vw==
Received: from DB3EUR04FT033.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0c::41) by
 DB3EUR04HT032.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0c::114)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 21 Apr
 2021 07:16:38 +0000
Received: from DBBPR07MB7482.eurprd07.prod.outlook.com
 (2a01:111:e400:7e0c::50) by DB3EUR04FT033.mail.protection.outlook.com
 (2a01:111:e400:7e0c::78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Wed, 21 Apr 2021 07:16:38 +0000
Received: from DBBPR07MB7482.eurprd07.prod.outlook.com
 ([fe80::c114:8ec0:a15a:f55c]) by DBBPR07MB7482.eurprd07.prod.outlook.com
 ([fe80::c114:8ec0:a15a:f55c%4]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 07:16:37 +0000
From: PFIZER B.V Supply <dfsgffjhj87@outlook.com>
Subject: Request for Quotation (RFQ) 
Thread-Topic: Request for Quotation (RFQ) 
Thread-Index: AQHXKb6/g9hjjOjiikmVZtZEZZA01qq+20C3
Date: Wed, 21 Apr 2021 07:16:37 +0000
Message-ID: 
 <DBBPR07MB748223917430D55FD00CCF4EAD479@DBBPR07MB7482.eurprd07.prod.outlook.com>
References: 
 <DBBPR07MB74821F466B16DF5D1BEFE79EAD779@DBBPR07MB7482.eurprd07.prod.outlook.com>
In-Reply-To: 
 <DBBPR07MB74821F466B16DF5D1BEFE79EAD779@DBBPR07MB7482.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:86E642DEA963E2880B1A275811154F633BEE1A2224986F0F042DC12DC8F40A6C;UpperCasedChecksum:76DBDD89E7094F5535ED06B484C9CE12CE80E062C59AE6C510287AA7BFCE6C5C;SizeAsReceived:32956;Count:42
x-tmn: [un/uFTmfm2zyhZNwHp99LMd+PzRDIo0j]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: d116ae62-72aa-4fb2-54d2-08d90495674d
x-ms-exchange-slblob-mailprops: 
 myhWhilQ5IJ11rYe6Y3fllao2DN6Qj54K5RjtbiIpztg/GIGHwqhTqA35M93JRHl0ewG6UwByy9epzfi9ode4DPtEg04Wp8xSIkGGN2SJH9igmoTtrW/5UR979fH7039jM4T+h68S7NDNm4a0YVZw0ClR+EvEkAXwYdW867u2igckbC48J8/QSIWn4zvOJJiuQp5PSbAqcm+gbJWWMTs7gsXpbtutf3f4qw3bBTZrYmZ/8DaRMUDxGVoy33qGjs4X8dgXMYzmBC+7ZLlrRCji4ukKFhObwYj51EsJdMp7pSXX8ZG58XG2N7k3b156U/HYXTKkvxxXITGCCDlWPYxVIZqwDmQfF0TTkG2HVUsPMTCdDf5hruof2Tp2JtYWzfpSsbf/zDGbCfdeewwAM+ryf7jZB0by4bJiVBnOIC0JKy1kvEiqzCef5EPu4UaHNJ+ChVBP5g/H2y/vhqb1vr1H1ps0N+b5ueM6wrZdHI3waXOoW6mbjjFq+jSUZwmkqSPW9VN+l1E82Hk/PLpC5i4UTJvUH3QK3OhNXl8+ZUN+jtrZCfARQMxm6CNOnp5+NtfX+p7GUmBUqgL03QWB0tFzunbgejI5wB7y9CPUAEFq6j7Y4T9+Lpvm6mRfLp/XiuQzcGO8olRNLGjMx30Zsebip9XIDVat5q4FlxHKoVHZc7yeDmaIZdOtuqYmUkcr6b7
x-ms-traffictypediagnostic: DB3EUR04HT032:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YXLyCr2z2F3x1pm/BiiEqsprqsjg3HS/0A6D9r1Igf7zOdob4UCaACFmo+CeMZtbkgJlP9HhqItQimjP8zVQeJDNwGpU2bEpfgQ9MI0k/5OyQjVnPcYkopunIkPdqASwLNniqEy89rurgKjQ5L2qkxrGbEQY/2SkbcKw384CrzYiKQE1y+5BpTzQRVyJuhhJfaS4nRf3s0uyy6FeMIkiIZ8eRZbAzM/DzoRrSz1g9ZE4A0BUli92VOdHfYUHRqiPF0h7k+tMqUSeHH3A2Nvi2WNUf/OEEOTZ4j4MgcH7vLtYy4ePjYYZafPbICilLiEF4fi2xYjVTxKsbIy93H7GACP0ti/z+DhQYMa+LfdaL5zYpecR1PxHk7mGGGJ0Of1KV1HNR1uQWKwAs9C/10RIYOd1+m1MUYA/rktsNAjvaAK6ATECC+JX2ugAFWAkfAi5
x-ms-exchange-antispam-messagedata: 
 2bxEmLkBpJWJNt4NRJX/2gUYlYqwihqNiD92CyyfR/M8SW8fgRaXTG3u6kj0khQRErXFMKnnYMLfC1o9uA17C1jS6VeBmWS412Io8gP+bUFo7iMaGIVTMc23vGRqe46c/VBeUVjmkt6mLWnarfLTCA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DB3EUR04FT033.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d116ae62-72aa-4fb2-54d2-08d90495674d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 07:16:37.6836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3EUR04HT032
Message-ID-Hash: F4IXQQT2QM47WRWXMQ7K4AWER6M5MC6S
X-Message-ID-Hash: F4IXQQT2QM47WRWXMQ7K4AWER6M5MC6S
X-MailFrom: dfsgffjhj87@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V2EE6TCMJIWWMKQKIJLRQI6CJPJ6667A/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Good Day Sir/Madam,

We are please to invite you or your company to quote the following item listed
below:

Product/Model No: Cetter Actuator model 275
Model Number: 275
Qty. 45

Compulsory,Kindly send your quotation to: quote@pfizereu.com<mailto:quote@pfizereu.com>
for immediate approval.

Kind Regards,
Ajane Bulla
PFIZER B.V Supply Chain Manager
Tel: +31(0)513 78 8206
ADDRESS: Rivium Westlaan 142, 2909 LD
Capelle aan den IJssel, Netherlands


[https://ipmcdn.avast.com/images/icons/icon-envelope-tick-round-orange-animated-no-repeat-v1.gif]<https://www.avast.com/sig-email?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail>  Virus-free. www.avast.com<https://www.avast.com/sig-email?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
