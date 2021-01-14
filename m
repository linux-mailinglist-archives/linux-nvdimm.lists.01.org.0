Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6FE2F6AB2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 Jan 2021 20:18:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5F984100F2243;
	Thu, 14 Jan 2021 11:18:36 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.75.80; helo=eur04-vi1-obe.outbound.protection.outlook.com; envelope-from=sdfdhgfjkertr45@outlook.com; receiver=<UNKNOWN> 
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-oln040092075080.outbound.protection.outlook.com [40.92.75.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1F464100EB352
	for <linux-nvdimm@lists.01.org>; Thu, 14 Jan 2021 11:18:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCsusFvRd9A9vHmZUQp9vF3A7Eis1UPWazRTnZjlVoYYrvl9KK86rtDG5NXWLhcYJMP9MVgrJ0dpCQHe3pIE+iGzqaVtNgrEpbfa+YVcMuu7uLz0jJPPhqaiSuOq+jTz1gLcRO8JIwoCa0aKrdrZdTyx3zV6YCKorAXY5R+IW/HdgW0eqM7OQRbzwTo8dO8nAWW1NzHzMlSZNE/oGoExeNdKp6e8F8Jvtc3GIfaTTtZe0KUomTF6SPfL0Z9D9mpydzIuzrtopy6mG+gXSOQ3oZqEu+OHVYGbXvlcKNOsbUyb3cF6NnWNzk0t1LVeGt+ewMLiSzrwgj4vA/HWn6IbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eev5ulG4OAicKTVPFiSmM9L7y3p1LJWXr6qfEoSdnQ=;
 b=XUoYYuNxx0mnEpKbsCCPlHWNt992fXdifi+aokaCVtnRcwNdiUz78ff1Ee/ibJbteV5qoYLqE5EclWILmrXaRR2sGS5YSyLSI5ELprBeMxnoZn68lVelhcFnzkpLmNdOcZlN4zfaNdCg17OiPkWdojcdDZ6Cj0hPPsXVD3PTzW5dDxidfKkp4EZuQixXm/bTRjN4Ao5A2KVbYtzQryxRnAPMJ5F61y7hetEdXH3g+d+aQxIP91OvY/56rABaBk+9mx1D2kicrIPTO+r/GW4J23tFEvo9GF2bQB0DS+GOPEjTJx3zapC4SHVmOrP1kZnEKrfWg4E6a88Ru9VyKi8Ejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eev5ulG4OAicKTVPFiSmM9L7y3p1LJWXr6qfEoSdnQ=;
 b=siXHzRjCbqYaBMBgY6d7pJ2UCIHsGrjINQqdnh/9MitxEVOHqhAu9us8UAIMiOCyoZqwq8ePyrQv94DN4AAiiabDTPH0oquAPrAyirZ2HTkzy4t2CyzSe7VBKf0iH8L61ywPzU5nsfeYeSinvzgzUdT66DJL9lV4dhmq5xAeOzR36zVfqyOlLrkzvZ4hBs4QhrAzT5NwHaZLqzoPZRWrCwfG6/v/EcpscSx8oZoJ0+zQuS/Chlf3rD0WWFAPJE67ps8X0MP7fLMfGG7CgVXKG+t8i8/kapsGSIA8SBNmBq6lXlvtOI64jO0smSPli9DIk5JMaAm1f7wyupkOPVPesg==
Received: from HE1EUR04FT033.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0d::49) by
 HE1EUR04HT088.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0d::342)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 14 Jan
 2021 19:18:11 +0000
Received: from PR3P193MB0797.EURP193.PROD.OUTLOOK.COM (2a01:111:e400:7e0d::4e)
 by HE1EUR04FT033.mail.protection.outlook.com (2a01:111:e400:7e0d::292) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Thu, 14 Jan 2021 19:18:11 +0000
Received: from PR3P193MB0797.EURP193.PROD.OUTLOOK.COM
 ([fe80::e442:a151:755:9fc7]) by PR3P193MB0797.EURP193.PROD.OUTLOOK.COM
 ([fe80::e442:a151:755:9fc7%6]) with mapi id 15.20.3763.009; Thu, 14 Jan 2021
 19:18:11 +0000
From: Global Financial Services SA. <sdfdhgfjkertr45@outlook.com>
Subject: DO YOU NEED A FINANCIAL LOAN? PLEASE VIEW THE ATTACHED FORM.
Thread-Topic: DO YOU NEED A FINANCIAL LOAN? PLEASE VIEW THE ATTACHED FORM.
Thread-Index: AQHW2Lbshui1wn/wDE2QGLmeaTuoXKonGicF
Date: Thu, 14 Jan 2021 19:18:11 +0000
Message-ID: 
 <PR3P193MB079728F19D2A97A044BD54D1B1A80@PR3P193MB0797.EURP193.PROD.OUTLOOK.COM>
References: 
 <VI1PR0402MB39359810CE1AA613B61AA5DCB1DF0@VI1PR0402MB3935.eurprd04.prod.outlook.com>
In-Reply-To: 
 <VI1PR0402MB39359810CE1AA613B61AA5DCB1DF0@VI1PR0402MB3935.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:A66FA403136344976B0CB6E2DFB68CFDD1FE02DD797C265AFBCF1D8BDCF4B4F6;UpperCasedChecksum:743312039BED3F3699A889959B81F026378B667233BE308F96746FE9478BC249;SizeAsReceived:33105;Count:42
x-tmn: [mCBjw4sUo8mmj7OMGIpW9nSRQmgf9bgW]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: b1469e8c-47c0-40e7-b842-08d8b8c1222d
x-ms-exchange-slblob-mailprops: 
 /ntUcd07dafrfQcVF7VE9ogIEIOIxNOAwEXKKsZAGFT8z7s97GQK1wXqniG19JTXRtrwUyNvhzadVMnlo4kh3vO1x4rYs8MLIExngFxw0blEpZs0VKfu0Qc6izHJyxEgEup1f01RxbOkMGz3z7Gj0moW+7ZJ3o6BFEO8ok169oqoLx+7un2rdvEWmkap+YKbjDUdhziRJXvX5EqqBh3eWQH4BFh3rTOqx5cRYGBCq6NBCMSuQ81LfaWH9GRgzqT7mPO4pWvSlrQ6CntXHGAVBlqvxE+v9NKgMcyTEeW9Cu4KAONtdzipVwqz70z3VoceJGjMg1ty9Tr55udy9XrdMEq72o0KJq6YVFNMCggnzLPzZzYrTmycoHGvqhemOQrqMyg4fwqb8vZn2jHIX/bIf6sMewxfRz5iCrnYJybxeuOwXVvWBEzc1z44n3nryBrqTMaTnDhqhocdQe84K+r0yM/o94tUju5YQsYGppGELQFOGszKxcYB2DrvVm8SS1WsCy6eEuaFxlwzJQmEnIXniFS0U3O31JajjJLxvI/xSe9tA8O0V5yyurTETLi1n/Z75wPQZT7VyNPc4CrOo5tmRUqqDRRX0L/CF74BgTUTh1OyJE6Uhrud4mWAlj0EGE0nqEP54+ynRKl+g0dI66kXlQH9NqJORj9bj8knp20jckqjsY6wFavhVNRxfSto86ig9FB5SmYv+EcncUwnCFLAZnGRdj08bBJ+
x-ms-traffictypediagnostic: HE1EUR04HT088:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AouJ5ojyXFLbHi7iPRG2sAIio3PJSjaW+ReBZlimOf0yzsn5VHnBzgvpPHEjQpjUfF0xj9SY6FR4Qt1SbVlG1to1PdkZHl50iWCSZpAjzzBjbwvELFfdqfF5Kwgzta0uXWAYxdTFFndEHyIcNTqTiSpf8KAmGkc2cxNxeVhICdcRtfRoZzBTyubO27DtEbW50o7VCkPIt9Hw1lY8Qf3UvMwzp7OJCUhbuNyUEH0vw++p41U17ZeE81rhdAxuNjwo
x-ms-exchange-antispam-messagedata: 
 1YpgQIYTJAImN6jazp/kgD23Om46QtMuiKvheMVXavBfnstsyZWWzhuM6zgO/ZwJUXcq9zA3u5XDnI4LgJsHdDNQYGt9wc0njBst6RQE/JHISJUWzA1LLRfd7xmX4NBwDqcRjhS7pcSjYoGlK7XCAg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR04FT033.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b1469e8c-47c0-40e7-b842-08d8b8c1222d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 19:18:11.1797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR04HT088
Message-ID-Hash: NMIUGFH6EBQK26E7G3AXZ4K27TN4BXML
X-Message-ID-Hash: NMIUGFH6EBQK26E7G3AXZ4K27TN4BXML
X-MailFrom: sdfdhgfjkertr45@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KM7P7ISPV373S4WB3WHQRDCCXOFZFJ6I/>
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
