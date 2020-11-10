Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6749D2ADA19
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Nov 2020 16:16:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 03B7A167A588D;
	Tue, 10 Nov 2020 07:16:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.72.64; helo=eur03-ve1-obe.outbound.protection.outlook.com; envelope-from=dfsgfdhg2@outlook.com; receiver=<UNKNOWN> 
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-oln040092072064.outbound.protection.outlook.com [40.92.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 26126167A588C
	for <linux-nvdimm@lists.01.org>; Tue, 10 Nov 2020 07:16:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itm92mOvCYGu8vz3AYMuUDPJKpVyNL0FPB7m6VuxE3+Favus6Nlhk4hwi0pMeEhN0JY/ZrufLNdG49PGvwer1EYvity+LlRMPx3R1KBWUJnHy0itkPgFBxrA6PKVO0LpBSV+40zRyJsIF7PUOlM9MenQsRWWBTeMPWniusF3wsucloTjHRUKaMAPQBE/X6uEW9Y9DQ73LsXLYuSRKdE85+qwW3/7weOUE5JgLLI6sjyVVIRl0+xClujzsmk+1zhBC24m5zvyDkEkubpUMJO0Vk1ararVfrxHpBCuOU9CRU1cx+czeL7KwT0kd6D5sHNoan8aV8d20o6BwywpodHf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Hfv4a20MNk9GvsVrnre/trTQU8Ve1KD8G/H923vW0M=;
 b=Fa+J0NeQmNUO0uXly5QgF8da2HfuxyidYW776wmfhu7HvWpubqRzqYLJaHHVbJzcj8u5sn0nMeF75L1RB9LfU9UlPrS9IC1Hk5IOmyiMyGUOFnLwsfCh6Gdkywd6/J6vofj0uJnIVNWgGxj5Rz3SBe6UezNynoqQMt5Zl2lp0UCerOBrkhISlJjBch1APHbYsbrdUAHEwQ94nQ23JfSS/fuwYTxYb0FWj4HA78humVdqw8LGTnQjcVZ2zfEVoLnmb4hiWykVnS1m3IttQQWweqbo1tE5Fl6S5Xc62DorbPjLMkaHkduLdzGagaHEK2lYO17aJbNL1jX+V+TJ7WbITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Hfv4a20MNk9GvsVrnre/trTQU8Ve1KD8G/H923vW0M=;
 b=LIKFMb3xsfe05jZba/hodiXxrHKPqlweqkzb4rM8ykXH6L0/HiLuQTmRqTS/Y2Cs3koJuUXeYzvpsP5vM5bQgzoFZvBBoupLAtpp0ySgOfqNgWc9fXkAHoDT0Qg6vOHonU+CSJjmzZNkZBofZLNC1h5davm3oDSGDWJ5WEXdCIZT0RgZuxoFJ3FDrldaFrJPuvqQzlQ3weWHtr18+2gjM9bhHAnHNGbhLO79CpPb1mqwsiWS9bd2hJTHC3GDKrja3ZcAKJiQqDtZw0v6GvJZFO7sNNAsztNCFEldLtyUM7yWTHCkDl0QMmy53EJPNjwzuEpyf/XaD91EnHW/Iva0mA==
Received: from VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:e400:7e09::46) by
 VE1EUR03HT042.eop-EUR03.prod.protection.outlook.com (2a01:111:e400:7e09::478)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3520.15; Tue, 10 Nov
 2020 15:16:00 +0000
Received: from VI1PR09MB2383.eurprd09.prod.outlook.com
 (2a01:111:e400:7e09::51) by VE1EUR03FT061.mail.protection.outlook.com
 (2a01:111:e400:7e09::476) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.17 via Frontend
 Transport; Tue, 10 Nov 2020 15:16:00 +0000
Received: from VI1PR09MB2383.eurprd09.prod.outlook.com
 ([fe80::5d53:5192:6a8f:c188]) by VI1PR09MB2383.eurprd09.prod.outlook.com
 ([fe80::5d53:5192:6a8f:c188%3]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 15:16:00 +0000
From: A1 Haulage Supply <dfsgfdhg2@outlook.com>
Subject: REQUEST FOR QUOTATION 
Thread-Topic: REQUEST FOR QUOTATION 
Thread-Index: AQHWsq72894w7SeKgU+9BGm17cxCMKnBg0Xi
Date: Tue, 10 Nov 2020 15:15:59 +0000
Message-ID: 
 <VI1PR09MB2383895339E851E5F51BB553F5E90@VI1PR09MB2383.eurprd09.prod.outlook.com>
References: 
 <VI1PR09MB2383261C5193EAD72153DF36F5EF0@VI1PR09MB2383.eurprd09.prod.outlook.com>
In-Reply-To: 
 <VI1PR09MB2383261C5193EAD72153DF36F5EF0@VI1PR09MB2383.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:E4F5B78FB4A5BBA30745A6EDB247683EC375F72429C6428CA265E40DBB81ECBE;UpperCasedChecksum:1B5E41CCBAEE9D515E75AFD885484C6DB958E58F72A83EC7A42989EA4FFA8774;SizeAsReceived:19139;Count:42
x-tmn: [bUugcSXeJjKE5dul7fJGYCdGGaqDQiBm]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: f6e8f0b7-2204-48a7-99c9-08d8858b87e9
x-ms-exchange-slblob-mailprops: 
 myhWhilQ5IK4m0lEbpi40x+7dFIcIWUzcTesLql6AeJkQHUErACp5gCFa90Y7Zxp6QTsk5t+SrA3/DqtbiiCLJLmxzj6rRgWTroX6XG9nPT1zI0zygD76rTTBUc3WwAtgA8TsqXnX1Yhra6HbZvlDq9+7krcIgyBtGevDc/hstfpp2ERZAuhjlk/K2RBKjju8xF4kPiC9P8pVEEfc/ZaCTDLwd4WccihJNHycjfD15wypC1DmlKu2yIjeilreZk0P5xFwPdVnccb29UUGaG4J2Skb3zH+turh64j3qd9Rx+RmdzHXxj9Gorfw8PhMEWz8HHj4RlYLncxYqE5j0Kur1ZzxO6OCoVJ86jHAPvbapaPxxnQmL3YIoXI9xP3dKUR8hWGTIkWNi29uRYAD5nMUErEg3E3TsJ81FUtdgfxYVdaIYbuEj9jL5/prqEWgQFPOU1RD/loNFjpgZz8AIuVsRVkDJrobFlRPeC4YNXy9ScEYwEOFvF9fgcs4zQi4RjwdTeJCDmgg71YU+HzHlbfx8+hQys/TiE/OIYTexC2XrS0iJQHH3d3Qke3L4v5gs5QGSI7zQ9NY0wXj8driSJlz7c0hOKX0f1GFBZ0HUd1CeK22Xmygja/FSQapHMf4IJbybQuEvVIjqZGGpyqSXuIe8tE+uWSJaJGFIr7IDpO8V5qw1sxNex0ZuwI/mUrvtyZ
x-ms-traffictypediagnostic: VE1EUR03HT042:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Wvt8o3ZBx+BotC45shA9IVWJa0fWhg3mg9Ki9ZcQfN2++zNYDaTX4KJ4K96WuzERpsB/Xu9/Qr6hkiM31TZl8HoSM4gYZ0+F6DeggZc/mgNaPVXV/cqaqyhONqhqFQB9XeHM98C09q7QEtea8rRJAQA8RXsCD6TJLZjJmaCtrJDyL0ygBe0WWnNlzAU7J7I+paI9rQ+cMOFUv3leis1grw==
x-ms-exchange-antispam-messagedata: 
 QKUI7jS/2vKiP0oHo2PzmgRcDaLxfsdytCoLcOfFDB/9AN4oe3sAOoVmaCkOo5B/UjrOYE591FbsShz0lz5dImRFSl5Efw/xQUNLJ8f9Rk6jwBI4JLQk69tVG0wkNI4HJGuvVgvPk+hM7no3K0H3jA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e8f0b7-2204-48a7-99c9-08d8858b87e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 15:15:59.8267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT042
Message-ID-Hash: FXDFOBF25WIBZ2XE352TSIM5QN7PF4NJ
X-Message-ID-Hash: FXDFOBF25WIBZ2XE352TSIM5QN7PF4NJ
X-MailFrom: dfsgfdhg2@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O4QATLNIXRV2MX462F2H76DP67ZW23XH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Attention: Sir/Ms,



We kindly invite yourself or your company to quote us on the following item listed below:



Product Model Number: LHY578696 VV

Product Category: LHY Hydraulics

Description: LHY Hydraulics Pumps 578696 MPT

Units Required: 26 Units



Quote is to be sent to: supplier@a1haulage.com<mailto:supplier@a1haulage.com>



Kind Regards,



Wahid Abdul-Hassan

A1 Haulage Supply Chain Manager

Tel: +44 (0) 7441 443061

Email: supplier@a1haulage.com<mailto:supplier@a1haulage.com>

Head Office: Kilwinning Road, Irvine

Ayrshire KA12 8TG, United Kingdom
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
