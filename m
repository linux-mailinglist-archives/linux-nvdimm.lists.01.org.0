Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C027324FFF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Feb 2021 13:56:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C034C100EB34F;
	Thu, 25 Feb 2021 04:56:19 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.73.79; helo=eur04-he1-obe.outbound.protection.outlook.com; envelope-from=jmmmmm1@outlook.com; receiver=<UNKNOWN> 
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-oln040092073079.outbound.protection.outlook.com [40.92.73.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CEC00100EB347
	for <linux-nvdimm@lists.01.org>; Thu, 25 Feb 2021 04:56:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/7KIM7SqIU6xKzjVHnzPRc0teJe4e1HXLZCApm5bF1gH7Gim8wDM62+iL8iNRdZrOr0t0E+agliEHEWN3OGAT4j1IuOEnueZyZnoJj6+iWl2/zLKurnDZ4zC91kMmQVIC1XKJdAjraSkMoADfy/NgW+PEzhaC96iGy5ZC2m/TCJfxwcGWTQ4fEJzGd4SP90LmKyJH/awNITR8j9gR/YvSZAi5A76NES6gCuRhjH79/tUZvIv0s2xUJhgu9XjD13HhWSEcSET0x+kk+D2Ni6t9H2UAmMU7EOFwnAFllisndFuC8BqCk2/5hQVR3OPH6U+f4qG3kNyqkoizWOmhSsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzpj7bTF7jS7l/D8PmkNfcIKENFeE+vt30oi9s2QM9o=;
 b=LpSptTU6/3vXdg2KlmgXKekPYmT2BQSNWVku5W7aGDpkKkvWQO/++Ny6ocaVTW8E2ca+/fSNZu2MT331CmTUIfdWaSqUVqrfuC4jiv6AlLCVnAqKIgtm0buRdkFwFPYFbLa7QTxN1NAUWmHmestyVQS05MkeDl7WUrxBHJEYtxcT7i10g0xfHJd0qvEvZaBrC7axwgYtHHPAYHFF57H4wASbfw9CSB9Eg9Y+96lRZhGxfel7wik07rNCbSYZfCb6Q0y777owPs13PgxQ1bCRjAQMOqsG/GzBcjSPsfvcpcgxFOGS6728qUzB6TQLEKPIuwz15nF48Da1JAlXynEiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzpj7bTF7jS7l/D8PmkNfcIKENFeE+vt30oi9s2QM9o=;
 b=Oue8A7FnjYvSNvtFGpd+UnMOgQFKvvamYzgX68q7VwWszw1SEJFpaSiHGLwY8dkfv9fTvJAmpv82C2sP6X/G1wNxHDd1Gzfrdz3KIr1LkQnWRw/UNNJN56OHmPvK0WeA13xzYTG+paTLcLXHJQaCE0tEAch7sM+dCQOp7C3krMpzQRQJQ+601OYGEHsh5HamBkHTePz+bATI2vHRguwWBLwTvOd/ymxaYx3bl9xC8LVSwdmEatlf7UWJ/QOJ9QvR2TExdB+HnYfD1vJth7JmnduA32tu1NP4bi+AGhLQOiG1pxRcy/69bK4++Jn+EmGadqEvrvsfg9X4q+xwNCyhHA==
Received: from DB3EUR04FT059.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0c::4f) by
 DB3EUR04HT077.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0c::424)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 12:56:02 +0000
Received: from AM0PR07MB4740.eurprd07.prod.outlook.com
 (2a01:111:e400:7e0c::50) by DB3EUR04FT059.mail.protection.outlook.com
 (2a01:111:e400:7e0c::234) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Thu, 25 Feb 2021 12:56:02 +0000
Received: from AM0PR07MB4740.eurprd07.prod.outlook.com
 ([fe80::e8e8:317e:e6c4:1637]) by AM0PR07MB4740.eurprd07.prod.outlook.com
 ([fe80::e8e8:317e:e6c4:1637%5]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 12:56:02 +0000
From: Global Financial Services SA. <jmmmmm1@outlook.com>
Subject: We Offer 3.5% Interest Rate On Personal loans 
Thread-Topic: We Offer 3.5% Interest Rate On Personal loans 
Thread-Index: AQHXA50MpXLTAWKDZUWe24Pi9Va/xapcTZamgAwQBhk=
Date: Thu, 25 Feb 2021 12:56:01 +0000
Message-ID: 
 <AM0PR07MB47404CAADBB5454553196785EA9E9@AM0PR07MB4740.eurprd07.prod.outlook.com>
References: 
 <VI1PR07MB47519801FCA4738439817331EA889@VI1PR07MB4751.eurprd07.prod.outlook.com>,<VI1PR07MB47518FCC9016E4F1CF98210AEA869@VI1PR07MB4751.eurprd07.prod.outlook.com>
In-Reply-To: 
 <VI1PR07MB47518FCC9016E4F1CF98210AEA869@VI1PR07MB4751.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:07BF7620C9784F59015637D3B9DCD22CC5DFF358E12E521075BEA8CEBCC036C9;UpperCasedChecksum:75E7A36FB2961106EF1C6CB5AC2207DA893A26501E34ABE420AF075DBA802CFA;SizeAsReceived:32132;Count:42
x-tmn: [hHme5nrPe4dDtMGw2r+ykCZiALeZ7Gbz]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 373cbdc6-ac39-430e-10cd-08d8d98cb4a7
x-ms-exchange-slblob-mailprops: 
 I5qrvvDeUuR79T/OdSxFaZB0XCNzo1Odo+p1ewVf8ZuyYzFmaqTsDORXvn0qJpzFH11/zjJxl0iC2g9un+GkcB79cHUiSTMXYBvb+uYWOnrw1EgC5wbCpF/gO6qASnnCHc9IuXF5v928SORIDG6f5pxoGrMB8DPH1tJOulj0ZuRk2MN9406BBuxApg4VI93VU5OVQ3OtQEwI//+VGhEslOmez/+Ew+4VDNJNEw9rTT5rzxdwmSqKMdBmB3lf7NVcEgN/5P9Ht4ukaRdhE9OiWW2/LDwWc5iXz+wyPRNN7FJuBrO4PkMmwsYtrkS0hOknYkZnezkTNSpVyUbHImZ5w1FgSJPzOCo1Z5BZSpTBcLaguuvIzdCxFlJaqyaDKg/Obi7wKnsi8JWdqB4pjr8tyXyUBwQq2UOcq53FdwdBrpfJ3Q8COpmB8k6bsl0hF/lskxrfzuBl5NXfwD/lK/mjB1/EYav1aQmpLn9+1AZw0+tPJIxmEp7sGEQNBuqFjs9PqZ3bYczpd7TiCl/8Zirv9HL7ZXSiBlhmPLG5T4ttuk40HxtSPfhz8DSLbvtBNmr5k+qKv56UmRg9XR7rI1zshdfj3jTPD28ziGSOiRmVWbpYFSCP1bVIkNOCpcR5Ccyt4Zt0lJ8lOZTfyWWzBhq2WWdtX8Krrfw3k8CKT3nGeBcR73eAmauNDo+c6aFY9oyAXSOjVv/JqNbBY/f4JCC1T0ntv704qYz/nJmrUvrGFJLilbxhTV7W39yA1W4CvmVWpTVUvy9ZG264lppex5UB6Q==
x-ms-traffictypediagnostic: DB3EUR04HT077:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 GVh3tHkdOc6bGmarngwumeX67V3Q277rgr1Y07tfw3HAwGMmWJhTxj/J7zWZ/AM6RrAmjfX3WmUF9drKWjq+kntZAJRIGX9xPJXQbUD8KQC31oYSP/zMuojJeLdEvmeZrUum3wG/pkbsAUSWmVLbnrI14xHZ9HkehXeTNA+yg3PDDCWhCtP9MYuGIlTfv48npCAt+DQWc6NyEtfLUMgColQyn01p2po5TJFExfaifgQXx5/wAtXNi1WgVGzb6WJZQrprn2KDuHcvN+BkfeHkYeNUAVq3mGk3eowteQYO1AWGPYSyD5L0YVVwborMH91ydNeAv4nCv2IXoYg7QGOtLMKHqLUuq7Ef6N+W15Tr4MUiZRCoAsy3A7urRNA7HDbfSgKmrqn5AuPrGZKhBY5TvA==
x-ms-exchange-antispam-messagedata: 
 g0XAiT7Ue5I0VkLvWvP+xLBibj36nmNAaru+z6KTpNGqNYz5SAC3Zq09M/n9WeFGLheRBQoZiw2pTkiBYdR2HL2C+fBmbzrEkccumA31VFdeMgySgSNEeiY7P7wDHbN0jfFURzwQYJLCrbajcYa6sQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DB3EUR04FT059.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 373cbdc6-ac39-430e-10cd-08d8d98cb4a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 12:56:01.9533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3EUR04HT077
Message-ID-Hash: UD4DSCUJMUADE5F3ECJXFK4T53IUZRMJ
X-Message-ID-Hash: UD4DSCUJMUADE5F3ECJXFK4T53IUZRMJ
X-MailFrom: jmmmmm1@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HNSKD275P64LXBN66ADWLJP36OBORVL5/>
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
