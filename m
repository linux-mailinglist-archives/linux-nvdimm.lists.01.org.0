Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9608230E640
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Feb 2021 23:50:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 98A1A100EC1CD;
	Wed,  3 Feb 2021 14:50:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.73.108; helo=eur04-he1-obe.outbound.protection.outlook.com; envelope-from=asdcsvxcbv3@outlook.com; receiver=<UNKNOWN> 
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-oln040092073108.outbound.protection.outlook.com [40.92.73.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A296F100EF270
	for <linux-nvdimm@lists.01.org>; Wed,  3 Feb 2021 14:50:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kl8egOa0ywGIkrDkSKCX0UFMQZA+3SVwHosB2m9W9zG1R4HCrDaIsu7oqK5sIAHE/xXiCArp46hH9EXLEOf2F+Tn86Wh3tXuKLyNJ15D4u9i6s8nLI2exbNMa/8NKWz8gZEJ2ayZSrcKOwtmj8P0ouZtjT9sd2lw+T6ijHyihff/302UlJOfXyIGDzmJ4I/XscXkLxuBoozZo1Nt/Toj7qYqfxPoFdiAqKcg+NyIa7te3+OfG2fiLV3+x1vlyWmGWz7TeQh8I7oXQJG6EFQpb++GE6b6Owu2E7XRaYjjUdJD8AGCiqlxIXPsxHEPR6peheR3z/PH3xHZjCnkXY74CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XbJ1Z9UD824nCSXF781UWnXOHTWzlL/uNNQrhzZdDw=;
 b=dbjiYLpYnQr/nGnFaOqbEADpuMTtbL+s4wkZJq5a2yNpZ7xdgknFzStsVdSWdgcceqWUBPNBHanJZg1yMxC9l5NTkzDO7zAJIotLbTelfCVx07sLMXV/CeD5nom5xbHZiGKk0UaDoZClwtCkdkCKyvdEbSOFhJB334K29JY7ou66clSNQJ0FoTmqrCK4jEP8t3NrkvEdJh0BlgxNLBu+ktpv0AucxwdkH915ElCWkMB8T93R/UXd+m256nA5oZtMVZsedUBY1UMUcmi6TJSeLfgPHXZDUQvKRJctUmKZbJlDbXVjK9+cAfFMpDB44WQevzhmrGNxlLpH72iisD5Sxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XbJ1Z9UD824nCSXF781UWnXOHTWzlL/uNNQrhzZdDw=;
 b=anm9YXb+b5f3CE2fcF4k7TRziBegzmAFqomnWuJToL31E/zwtRB6aJpv9uo//Fks60kuimjUXN892TsNNG5ihVj2AvLiFSkmEMC8bbH5ncdL+9z5cCQXEQ+g+fzjZ44m3tw+P/JS1gKUfVh8r9abXd9WNG34vniFgUuula4xucZe33a4fqRocCZejjNr4lXEzTXyFGCbbgGBux9OlNWGN///pQbG9KeUSUZaJCZ3V+MERsKYTwRBPQdbv2+/APbQx6+psul1OucycPYb0aN3uHau7UYTqy0IwxaCODrKS03NwIyMAvY2JDbXIfPEHOI6iDewlluOrO4gmwgXxBXdmg==
Received: from DB3EUR04FT050.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0c::4e) by
 DB3EUR04HT169.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0c::85)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 3 Feb
 2021 22:49:52 +0000
Received: from DBBPR01MB7516.eurprd01.prod.exchangelabs.com
 (2a01:111:e400:7e0c::45) by DB3EUR04FT050.mail.protection.outlook.com
 (2a01:111:e400:7e0c::296) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend
 Transport; Wed, 3 Feb 2021 22:49:52 +0000
Received: from DBBPR01MB7516.eurprd01.prod.exchangelabs.com
 ([fe80::3530:fa48:2c47:4374]) by DBBPR01MB7516.eurprd01.prod.exchangelabs.com
 ([fe80::3530:fa48:2c47:4374%7]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 22:49:52 +0000
From: Global Financial Services SA. <asdcsvxcbv3@outlook.com>
Subject: DO YOU NEED A FINANCIAL LOAN? PLEASE VIEW THE ATTACHED FORM. 
Thread-Topic: DO YOU NEED A FINANCIAL LOAN? PLEASE VIEW THE ATTACHED FORM. 
Thread-Index: AQHWw1yQBTXcqc8ciUCN83zJi9PNn6pHmGUL
Date: Wed, 3 Feb 2021 22:49:52 +0000
Message-ID: 
 <DBBPR01MB7516F782F09C9A059A4EA506F0B49@DBBPR01MB7516.eurprd01.prod.exchangelabs.com>
References: 
 <AM0PR01MB628933E466102D282FD854F2F0FA0@AM0PR01MB6289.eurprd01.prod.exchangelabs.com>
In-Reply-To: 
 <AM0PR01MB628933E466102D282FD854F2F0FA0@AM0PR01MB6289.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:6606F24549EFE434AB7D2B694E5DE6BE0174D27E04E003C09CD8A86EE6BA095B;UpperCasedChecksum:09561204A4F536FC0D6B2B4E83E901794C0814965243C61A5D5D75611B83D742;SizeAsReceived:32875;Count:42
x-tmn: [eF+hIFuWTZA8vyZfUbz6tBvJJzqsQw9g]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: b9361d26-6b7b-4855-827e-08d8c89604f1
x-ms-exchange-slblob-mailprops: 
 vJxI5U0j4N7dxvHrtXwORO8EL4YYK1cBOuavHc3hId6rr4PtBtE1T45yKUxXk0FUaSvLysTgoVJQ92ImgqZt7RFhwe3S3j7nJpZPH+AROiwoijpTKcn3MVgSWnTa57nngih6xwdkxz4B1GfruJVVDYyreQ5HxnCOOM11VucK7As/qT34FnAGyhd+5QaDu/VgAiUmyKMi46S3gZrmIQ6Mbe8aJwHlrQuEsrNC4+lgP4S/P4KJGt8n5A+sEwY96u/WtLTRsO4SFjzACuYcZ6BLryP/v8X4t5Pn/vtvOBdqS/JQmHvvS+ijaTDQI83MLWq0+GQCwmfIepA0+F1zDLIS12nMFl+x9+CmLE6+dDZaaluEBo6PCutUovKw+qlh/8h45AOaEzQUzMCR/cD0cuuhEjq1q64yrIOLj6AyLowbooH9ClMmrkz/plknxMHB6G39UVTifS26XtsICUA2sQK1W/neRgun6dygmJjpvZbTZCxEuHU/f0gnGQiQMC4IVFTbmO/B2w9dK9TxxWLDDmUzRUKtY+/jvIkA0rSB2xwhBHSuRr/Hyukrua3OGGh9S50l3U8Oaf9Sf9ZmgtWAg0FVn486UtFiqLD/dpEqCCwAUB8rcxuHNT4pL8eWwakKB0ul3kdTfEbHw3WTqNtpU+HqSCOGAoyA9A1yNlbR6aycZOaTESMGNk1OlBnap6Czv3NNja43oNxagF9Hin81JXlzLy81nWHxK9k3
x-ms-traffictypediagnostic: DB3EUR04HT169:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 myrelhEpBgnlhANrK38l3ah+kfO8bD7UsO67u1dO0XTd3vv3kfCCXO/dT4jMZ2+U/Mf8U4wmr5medzTJ4S0AsMT4A8YkyfCcTThQ0in3cuRm7ACjQvG/9kVGFqbjC2nA17tzLbZ9C0oDSM7GFLjI8naoMJ+E1EgHhkplBJcUYNF/wP8CluJ6JCGzaoRtvjMf9RCia7jpW+DK9YuCSILX3Ji3MzVusES86gGMJYJHRBUNnPI+xxgjhRs0dRIZsvkn7oUx+kW0FOYAhLXcbguWc37Z5A4p/C4Kc4asw3OFuVpUrps/RgU0wMxqDPCfRE0iq6l7C9qpzoxeYvwtpqtsUIjEXvFNouaTDsBEZv3UFd5Dy4rsh3EmExWhcQ5HTSnIDpwGSjetZeNwvMCX30Y/DQ==
x-ms-exchange-antispam-messagedata: 
 GMWMSE17+NajCtORQX9Elsg0RU31zZH13M1gS8DaUny8NY4S8jfLNbJGI6WTz8h3e2V4tVKQ+BW4SJgFLzqXJcXfzVh7Q1iTLFIa/zpnaqAN7xdgEWuvh+NRzpGVR1GM8DvF86Dp3EvvXayZ/jDrZA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DB3EUR04FT050.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b9361d26-6b7b-4855-827e-08d8c89604f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 22:49:52.4231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3EUR04HT169
Message-ID-Hash: EGROOMUUUASPAK2Z3AEWU2WFMY5YZOPF
X-Message-ID-Hash: EGROOMUUUASPAK2Z3AEWU2WFMY5YZOPF
X-MailFrom: asdcsvxcbv3@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KONPP6BIB6MTGMTH575YI3P5PXO43KUT/>
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
