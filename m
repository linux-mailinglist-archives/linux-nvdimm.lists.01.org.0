Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BCA361E21
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Apr 2021 12:41:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CE3AE100EAB60;
	Fri, 16 Apr 2021 03:41:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.89.26; helo=eur05-db8-obe.outbound.protection.outlook.com; envelope-from=sadfsghf76@outlook.com; receiver=<UNKNOWN> 
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2026.outbound.protection.outlook.com [40.92.89.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EA638100EAB56
	for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 03:41:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7B3j+pBx/YCgZ5cqhQi0VvTMqQ2lEzceRW/vPIzQLEyEQIm8f00N6CThyZcQkddWBlOMK9McaIxNgYBICEWsxFbRGQr/y+iaFJ8LTCPLREGyUieHv4OvRU48xQB+SsS0GhcvSoEyaPv+Vsj4Cp6DrcQgjy5dZYKuC+qS/aN38ZowkRUYkVWEAT1gwxegaCPAQLygJ9x9HneNAbcmB7DInNyuDK1xmSKyizIIP5OmJ1SK1DVlXSSrE7kfFXa/emGw5ea7JQHr4OXhhc/eDM/jAlUvtpA0HSYbRPb/UjVDbylTWWCvIQceohgM7/JsMjc1yhHrlNq3G2q6hFUNWj6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqXOSikbo5HDCshM+aUi14Yu8/e3OKuOBeOwiXKWYxo=;
 b=VrbmH/trMLi2t/jWjpwv/vfW5pTNZTIuWm5RBcOsxxuv8UEPdIwjhd7zsKQc8kOdoBP8PGAGhuUT7/SovdT5EjUh06TnkGuYCOzPgYdpCWX9XbBALOfCd+N5j8DouytNIx6ZiX7c8q3JX5yLVe05vJrHs9LMEDwBVa/fcuJNSO+3u/TZJkjPlWELQ2JrVIIelNMZhJ9GxUxT3NU+GOLTzQgtYIN51Gr8HPbZtEMJnVCadmVlz4rAZj/+IKfDcAo+Q4pZjoGJ1VzAFcyHhEOvxs8RmWrOjl29D9P0CVEql4EGP409HUIQ7qO+210fYrr9BsukhHhLvhdx+s5Cg7QNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqXOSikbo5HDCshM+aUi14Yu8/e3OKuOBeOwiXKWYxo=;
 b=bAn9PhNx25AWRP62xDmjvS/ZALR55ZIPWUgL5zuXunWZqSeUQmccW2l7PZUhOP8wbAGh4+NyXWSMzQXu3SgvkyBf1uWsa1klfsPbdJFIFLJnzK4VenKiQ0mhzXpOpiQtvahFrhGjGKDQXbJvNkxoeivNC/s87ZABVUcHeETDqw+AcKdNd2X/ghicEXjpxq57v/5yRgkvorIfLyvMZ+MU0YPNs1WdFgOBiB8/lSyaGJFJV7NOzoBeK+OSxvuURa2X0zYHLfpjs1t0bVnPqE6ULrEjxW+gobUau4K8RbWQpNam5HR3s3L80effNzyieOoS1Kh1/B56WJ5IEl11zbymdA==
Received: from DB8EUR05FT038.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc0f::4e) by
 DB8EUR05HT033.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc0f::394)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 10:41:08 +0000
Received: from VI1PR02MB5869.eurprd02.prod.outlook.com
 (2a01:111:e400:fc0f::40) by DB8EUR05FT038.mail.protection.outlook.com
 (2a01:111:e400:fc0f::246) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 10:41:08 +0000
Received: from VI1PR02MB5869.eurprd02.prod.outlook.com
 ([fe80::e8b4:aa29:79d9:7fb0]) by VI1PR02MB5869.eurprd02.prod.outlook.com
 ([fe80::e8b4:aa29:79d9:7fb0%8]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 10:41:08 +0000
From: Global Financial Services SA. <sadfsghf76@outlook.com>
Subject: Do You Need A Loan? We Offer 3.5% Interest Rate. 
Thread-Topic: Do You Need A Loan? We Offer 3.5% Interest Rate. 
Thread-Index: AQHXEz3PDdIjGSdSGkmMBRrmtnVYY6q3ZaVq
Date: Fri, 16 Apr 2021 10:41:08 +0000
Message-ID: 
 <VI1PR02MB58696346CD07B2544A58C2ADD74C9@VI1PR02MB5869.eurprd02.prod.outlook.com>
References: 
 <VI1PR02MB5869AA7FC31EAEB0AAAC7EAED7949@VI1PR02MB5869.eurprd02.prod.outlook.com>
In-Reply-To: 
 <VI1PR02MB5869AA7FC31EAEB0AAAC7EAED7949@VI1PR02MB5869.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:7A6E70015A5ECAAC60B85143E6093F3B89DCA882AC1FFEF9A063DF5802C476CD;UpperCasedChecksum:83F1CEED7FC0090B83A7A544B1CEC43A81E7121E8A4CC0BB11BA30264C6C9C39;SizeAsReceived:32145;Count:42
x-tmn: [2+WS0nZh2FUHgUvZ9ECdrvlI+65rBs6l]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: a1bcc7a6-16de-4132-2a10-08d900c424f8
x-ms-exchange-slblob-mailprops: 
 7MJMDUNTCtye0yqNGUu7Bti8d1wbIsKK8dxpW77MR1Ps2BKdgP0k1onvUvij/1K/lwjJVJnqZqC8r4pdanO97nmELbh4tsfEGOqItO80xYeFViYHCWvHC9lf4KYqSihRHEpBQndySsKdtgXoy2Rw0qnZ88zxnE4npXOfj5xXYAruphkVUb0sxBhumXKAOrbBekGR51L2ul7rR6datLSrbo9YCsO/nzDt/EvNjFIgeEhjRSv6omJrbInEmxHAMMJ+bKZL04j8IDbR+Z4KttS/Ms5KwMTULl36pVV9U7bCWIfdAjKvKA9xbOphxhF+U+exTyrtCqz49FZoopyp6iVAGhXLMMETpTEylH8FwDHMu2KAsRLr4/DaGIr20YNlV7OgWqgZw0UOMleZgdzuy/gaA4t7oirlw0tlTDP/f1pTwUMA/Sv5XbisJNCBxrGMgyIME1amS9yPKkpnp7Cy6ypk8zUQIHLymvGlc2Wh+tg+/XyPRsh89Y8j7oiN4gMRgTXdSAvyXcpMZ1XuBpPcnBpElVc9YUEaRJhCqEIpsFPepeuA6Jv2PonVCbNAqjcO41K/yZFQZv3lC+ODfi5zwO1zDf30G2UmsIiSVWb59TbN5YcWtlX60oOFbTMhlRPZlBcItp0cqVye0L3brxcKDnrHUFG6pnneTJ2CDwXc8s9NHMWvo2uXe6cSw2J1Mclk299d7wKcWBjsUeAvqj8nZtTtwXg5QhvA05qQDF/2AhPybPTL8uLY3GGJrg==
x-ms-traffictypediagnostic: DB8EUR05HT033:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 70OAlC3cxEys8kkqBeir/eg5CysU4UbDr2UtjSekmy0Q9JaTNBa+1Tb1sCdtboY4f9Z6GWG+RM1zCe7AwC2JEdi/syDPURwVZZBWFtQyBjn2OLoVASIIBvPpy4LJFidL++/RJSlOpC0BNfd6wZhv0o082V+8UVcqF6cfkLgaRLJ3Qq1CJGGeviqK+YdJEBEFg/2gvLJnWtoBeau9J6DGKmmAL4D2wJFhViY10xeMc96DZcWshBFaUTCF/uGfldJXViXmmUMLdeWsgRVAzyEQsKpLhAoTnZcUGquMD46/NwJX0CkcMEVoRQcl3VsDSuGJbA8QbVdesTO6r3wgMRHfPOlrRTqKWFCfb0hG/GMhzHx5zymSkq4ITqrjtYuH8csPEdW6ye4lk5/krxC0CO4h/Q==
x-ms-exchange-antispam-messagedata: 
 EuYdGc0NFgIqPrqyoQQ5rZmAn+5gQTxQSZhuAJ5G/yzkK6PgagmcP6cM+j8n+EITWGuXfpfdMUHaBUJdQtafpSZA+aHPC74NFugalkRh9nPthsYfzzxlRARvyH5+i5oBzhHjyWeHFXswUl07M0coIw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT038.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bcc7a6-16de-4132-2a10-08d900c424f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 10:41:08.1318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR05HT033
Message-ID-Hash: 3VIKMP7XAK26VFW4JGVTFKDBYALIXAJQ
X-Message-ID-Hash: 3VIKMP7XAK26VFW4JGVTFKDBYALIXAJQ
X-MailFrom: sadfsghf76@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VLE5UBL6TU3NLFYJECQ2L5VH6BWCAB46/>
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
