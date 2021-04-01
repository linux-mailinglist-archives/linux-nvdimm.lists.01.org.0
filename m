Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D4D350B7B
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Apr 2021 03:06:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3A1AE100EB35F;
	Wed, 31 Mar 2021 18:06:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.51.48; helo=eur06-db8-obe.outbound.protection.outlook.com; envelope-from=sdgfdghffd5645@outlook.com; receiver=<UNKNOWN> 
Received: from EUR06-DB8-obe.outbound.protection.outlook.com (mail-db8eur06olkn2048.outbound.protection.outlook.com [40.92.51.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 148FE100EC1C8
	for <linux-nvdimm@lists.01.org>; Wed, 31 Mar 2021 18:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKbLH0yfPt0awLDj3olmXN4EJ3Sh7rrORYn2bawHwff0H/jJQ5kgle9vVtHkdqubR1hNTc87UaxndeRNOvB4K6ff+tKUxQgELFCjZ0OSYLSKDuAhSRAYph8r5XJUtYMINPldLfLCRXUZ1n9QEc7mpCcjW7Ob0CK7RwoLj2qAnub2zI8a8eA9uK1dXewCBbsuKY9J1fxfDqXu2IZ0SRZM+Nr8tPC2yZ9T4tYOi1lsSM3QhFUZLf929jN7FrdSbYnAeYH0mnu6F/D8sWTmKmdKtGVQs90Pzh5gOP8IAJ8sJUOFCSaL5m6iuMdkwpKMQa4p3LClZ2WhoIQkjjbkqvokyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ0hpMWrGI0tHNdUVfPZiHMuvBAA55sScIoeXzwR8V8=;
 b=iRM5BUcVVp7+yleIcaQbu1QJgKKcWAKTjqv0mNAqyMZBjw4U9FPjX0fMR31SIdxynZF+6He7/1LzKNFTJ6Qs7U4XzzUfC6VSmyGY3wYbU3VQJe5z4/F/2nK1g/H/+IB+D7ht/mxtGZvL2aeIZTmVJFzAIITWdolywuYKflG+3HCvZIY/daW5U0GwW5HWUCNhqiCF/XWvoZ1TfUD3TJcsBvR6WflXY53C6Zksdx3+LKPeE/osFYgma6IV7qW+nJsM7QxcQDx7ugHrXwOwCyQC1HKwa3W0t4p+fr0K0zMfqbiZVz8mZ8fXy8LKE52TNqZ4k+tSqdHP/vnyKdG2MtrsmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ0hpMWrGI0tHNdUVfPZiHMuvBAA55sScIoeXzwR8V8=;
 b=j33NAGrTPVzYK5hxNb5V+snS+K+tiJyOMlQNiPRXaLvFrqIvv4cpzymY23d7sW2D08kBt7+DCPFjGWW53xOxOcdAcNFKcn2pToiZ+Q5KK6eoClX/yCBOqtfkL+NDZhD8t8ojKZ53hmJWCU9L/gUYR9xAmv7beO2pSyWJciyoJXhIaH870uITBymj2rpFINE/JNwjY/FoXAwcO0HC/38kX2qyOGAZ+13KwoKknPxN4bfwEXk+hxny2ky75em4sGCWy5iIbj9p3hTwgbeqslyYIyWi2DL5N6kauo9q8SWjL1KDCnSMvto9l+1f5Ih4Yva8XhR/k+U4phIN/aDmlH+c/Q==
Received: from DB8EUR06FT059.eop-eur06.prod.protection.outlook.com
 (2a01:111:e400:fc35::49) by
 DB8EUR06HT150.eop-eur06.prod.protection.outlook.com (2a01:111:e400:fc35::260)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 01:05:59 +0000
Received: from DB8PR10MB3353.EURPRD10.PROD.OUTLOOK.COM
 (2a01:111:e400:fc35::40) by DB8EUR06FT059.mail.protection.outlook.com
 (2a01:111:e400:fc35::333) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Thu, 1 Apr 2021 01:05:59 +0000
Received: from DB8PR10MB3353.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c7c:545a:1b08:86fc]) by DB8PR10MB3353.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c7c:545a:1b08:86fc%8]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 01:05:59 +0000
From: Global Financial Services SA. <sdgfdghffd5645@outlook.com>
Subject: Do You Need A Loan? We Offer 3.5% Interest Rate. 
Thread-Topic: Do You Need A Loan? We Offer 3.5% Interest Rate. 
Thread-Index: AQHXFEEEmW8wfR2M6km3Vn7CVHg93KqfL+Xi
Date: Thu, 1 Apr 2021 01:05:58 +0000
Message-ID: 
 <DB8PR10MB33530B71E4A95926BF401D1AC77B9@DB8PR10MB3353.EURPRD10.PROD.OUTLOOK.COM>
References: 
 <DB8PR10MB3353DE13AABA24DBE8B11B56C7939@DB8PR10MB3353.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: 
 <DB8PR10MB3353DE13AABA24DBE8B11B56C7939@DB8PR10MB3353.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:768ADEC17789D391470D9D2ECE74BC658DC2EEF724787C6E620A2D992EEB2417;UpperCasedChecksum:3B117A706DFC54F1EDFE724821782CF693486A21A511D7DFEA2D3EF974BEA63D;SizeAsReceived:33235;Count:42
x-tmn: [W+YQLa097JyLRgxS+eZdsAuJlMInWPNn]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 3421ced0-17d0-47ff-b0d9-08d8f4aa4fb6
x-ms-exchange-slblob-mailprops: 
 UVhqIX3n4Jr7xc0kD6noG7DUtDEI1bO6pOyXIm5Drpu9SZ1paszyVbHHl97fdNbefQ1anXjA/mqLkFAqHQ4xFUYGJe1gioGbei32cV4TQWaWvlDkTwkm1Ki679Nt6F50eQj8MGixsdF+yquFlH1/7/fwMXmx8t8aMlT6SzoVf2/iYA30LvLnSkb4MhoLS+KjMj30fp5O5nDjZsul3d6MiDXGIYeoVaQfovnJxjEtq04WlBLwSEFbfO/HgGLeAX7A4xodh9EIWX2H6FTQUY0JdJsx1Upctc7LG+bGcivzNj/heHeXD0oQK6uyBQdWUussJW/kGCimzS/DFKkYlnvkod+6OCDrCM5lMMYMN656XN88oHyDHw2+vbqHJUggDKxDUWEH/o/CVOzMZds4ujiiA07Rdv43Ewmkf+o5dwFLoCZ95tgiWLsFQlDtGvqU3XB3J3Q16SqeBWW8OwhlqYDSB5yuhSWPEhwja32D+nytZduQareRRZV/L75jATHiMl3y96djpOiZ3wvyTEwosfq/8mq0VmcsSPXJoJCukT+qjwo9qy5WS+b1ODlweJItd1DArz+bncx+7swAdoVEVKOQRbPfZYpOBCm4h1oHZr721fSDNAB5xdL7z28hiGyBsrgenh/n4Ln0V5DezqRZl+3Zu9lWxCLZQZ2j/NK1VgUG4cGGUKIPhvB5sUXvRjUa752e0y3LBwtRZWfA5Sa8Qnyfy8rkGMbPikhLARjjjf1JgjlWbm6dL9jOV5OH5BLS5hzrfZsNVVijKImA2F+zBB9nzw==
x-ms-traffictypediagnostic: DB8EUR06HT150:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 SNNI/8M49rN4zWOxaIWQIuyB+hoBHalsP7SEtvU61yov81sG7u64DJBOSgqzwenQ55gU4FZbCpMNKTq9ry4a/+bqJ7fWpEc3CceRulp8gLr03G4sAIlGks9QEP6fxdzHxkLpF79NNGbW/rXaLkD8YWuRsvBusvkmvnh+dfdv7/G6O5sEd5SA2q0Q0ibT0JR2uIYdeb0ohEOFNUURk61AFYemX1Y+PYQT3foaUZGLU8K0qCgXVxsr/XCIKNFqJ5IyWlFyUEYXMvcBLpPQ59GRjgY6DXh1l4hh2ac+0BCHrZssfOrpLXELmknVycwQoxYU72OjDHqZgOmZVAXkWA+lLfBuYte9uN1IAyOXkuVgkHbrLQmatWH8QoRTYeNMHHvzFGZRV2oWPZ+kLnUIEPG6RYagPFInx3WV9yaQG4yjmM5kW4BVXnAKtO0gIB1scQJZ
x-ms-exchange-antispam-messagedata: 
 TmxI4IrVKUUtlb5CbbFF7BtAaQkvYsyZK0S47gSyHrM8zUyexF6QcK7EBLZAsMgRGqEf470W6EFqiGmgAm+zuCXMTgngw4iWdNfpyvX1Exgc5l3CkX5luHP6Qyoux86EKHUhxDO24DwEhq9/Ek0mTQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR06FT059.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3421ced0-17d0-47ff-b0d9-08d8f4aa4fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 01:05:59.0073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR06HT150
Message-ID-Hash: WISIRNI6FU2USMB7XUMTHJCZVUJ2CO6J
X-Message-ID-Hash: WISIRNI6FU2USMB7XUMTHJCZVUJ2CO6J
X-MailFrom: sdgfdghffd5645@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IGX3EZZTD2LAOCBTQ7VUGXHMEDYHX5ZG/>
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


[https://ipmcdn.avast.com/images/icons/icon-envelope-tick-round-orange-animated-no-repeat-v1.gif]<https://www.avast.com/sig-email?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail>  Virus-free. www.avast.com<https://www.avast.com/sig-email?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
