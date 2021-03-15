Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC9A33C8B7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Mar 2021 22:48:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 460C3100EBB6A;
	Mon, 15 Mar 2021 14:48:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.89.61; helo=eur05-db8-obe.outbound.protection.outlook.com; envelope-from=sdgfdghffd5645@outlook.com; receiver=<UNKNOWN> 
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2061.outbound.protection.outlook.com [40.92.89.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3DF16100EBBCD
	for <linux-nvdimm@lists.01.org>; Mon, 15 Mar 2021 14:48:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj/ZzUGQiLNOiA6yby4eyPWwKuRnQU7JjJYcq15tkvvDF+iYuR9azq3ltIzoUhfCMDEPHvtL5CB5sG91PxA+GK2Usq8zWM+WaqsWGvpYIStWiOVms4KJSDcMOSk8pEtQre7ywhN5xRxeIjYukqFK8yaC7LRCq0i7CxV2y8gDEQhWhZhQdg0wVOXkoVRwskTdb9Yp60QwUxK+2Tzq0wEJXuBB95cdgdQL8XJ4/Bao8gbZYF+YGo5ma83G9ZIgZTYH+3nuq7IModxNIrqQhMNSSOdsybuidue1ELzt8LvAdQKqUy+EkaaIAMr4fZ2SVdOEGwYpqo7dz+QtqNW/8DNmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhlcGvM/48ps+vs2azeUZwf51Dp1fQlzCuqmh+y3z5M=;
 b=aMtGZFz50ypHqKyxVK/Ps3cnN1vYVw8FAvar3hiW/3odg+wBfhOJKdOx7/aImuOknZ/eozgagM/LTkK9WKf0yTF2QVVtH4gKRTN0j98lZ7Jfida1uQXhD6zJaa9YxsRcjr6dx8vAWQ462iePvDb5XWgsw8P8wTtF8hANEgdN57DvytdLsImXH6qvxWsmPOW5v966RRDkqM13bJXnrjm0URbTN33X4aIrkXjKNezTnNDuGawusD46QHJZTFUL+4LiidOpf0NpiV3BFoEFInJZ8jSPKggQUzOpfwR2z7OjYT0sRbuSPgaUhn7+dzaCuAdZhCWAjUxgHFSVrSPQcNy2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhlcGvM/48ps+vs2azeUZwf51Dp1fQlzCuqmh+y3z5M=;
 b=jyMpe6Lr1BK7tx62mnIYAR3n8uL8o93PoHU+Bx91udB8kIGLFRcTTQA+WJx9HPhibFkf1Kk0ifnDap2Ioh2Znsa9TOJMYHw5HwmZDeSJCsuQ72qVAO2BA0ra0S1V6D03BMZSf5H1Aap2GeAOdE+V/WYOFAp8qmbB700zJXP+JM5IFOiuoQid80CVW7pEZgOPhdVu7dbHXKXcjRqxbgp7uf+NYngTq21RYdi/TqGFRNUJJx1wuBcPWrkyFIyHr8mPHcsxSMOytzcfu8oOmQAU3BBEuzp5is2JD9zTCD4q5zVZgpPJli1sATuiQOsUtZl7N+XSo87JqR7gAZb+f9hDlw==
Received: from VI1EUR05FT058.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc12::44) by
 VI1EUR05HT062.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc12::193)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 21:48:00 +0000
Received: from DB8PR10MB3353.EURPRD10.PROD.OUTLOOK.COM
 (2a01:111:e400:fc12::4d) by VI1EUR05FT058.mail.protection.outlook.com
 (2a01:111:e400:fc12::344) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Mon, 15 Mar 2021 21:47:59 +0000
Received: from DB8PR10MB3353.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c7c:545a:1b08:86fc]) by DB8PR10MB3353.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c7c:545a:1b08:86fc%8]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 21:47:59 +0000
From: Global Financial Services SA. <sdgfdghffd5645@outlook.com>
Subject: Do You Need A Loan? We Offer 3.5% Interest Rate. 
Thread-Topic: Do You Need A Loan? We Offer 3.5% Interest Rate. 
Thread-Index: AQHXGeTd9NpO/hshskinSBrb+/zW0Q==
Date: Mon, 15 Mar 2021 21:47:59 +0000
Message-ID: 
 <DB8PR10MB3353847024966B3C8B611E72C76C9@DB8PR10MB3353.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:59CF148DBE6DD3BF7A20114A7A95836FC8A388131095A86305FF2A982F0D4165;UpperCasedChecksum:8398B84ED8DFE0165D454B6F2E2CE7FACCFE4C5FC2552AC97288AC22760A07C6;SizeAsReceived:19899;Count:40
x-tmn: [uuOlgZn0nOjMmw5ReXhp5tNbeInCAfGV]
x-ms-publictraffictype: Email
x-incomingheadercount: 40
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 5ae729c8-4f49-4939-1f9b-08d8e7fc0078
x-ms-exchange-slblob-mailprops: 
 fLsTTQ1haZT0LNdsGDUbFwFcWnqMsGrTCUQv068k5+IB4kNmOUKFsc3z23JbRjZUTk/ToVFJZcH9xoJZFh6bG4+KpGhJ92m/pMxdADxTp95T+YUuNYIdt9e6P6sLj8NzylR6Qyn48SoPde0l2Q9Qa7y4mcRkFv9JTs/gV16SpkAUwyzc0jf0DaYXa4fkcMEVoV+Wc6UIxCWPz5Dd4d3Je8XPhU0ygLLXNlissDo4QvcPm/MJEeA168NF31bFiYtqQDNG/R1RLI5nF+WB2q6vM+NbXC3QRmwKF2z0rgrqIrrfU2BzXi5hGjWDlB2iQ8RTrQ7K541MARKR+ODhKcNQsxCFdDGb4/HaNUnAM6idVpajDmCp1qtirY0aDBXKhJ0ZJ1ykqq1HJnB9WUb2OKJ8wcZ56Ogo3qp2QqOB1LsKViZ3XUE7GFyywIDjBWVCZFXOxctiJp4fJx4HYtnUb3bDp/CygyzQvdazenmkU+ghbJ1bstqYfvA1P2ohd3F4L9uF86zZRy7nz/7kr174ck1Sl7KV9XaS57EvS5zVu6/c/T6GYH4fxPZBkdrsnUv3vVq8B6jNtwg7BF8IL8telqwrgkkgIUZtvMjqzBznfTrCfcM7F3E0LU5VsAyoOIu/xs2z1JbkgkOPb1di5G6P0Aj8sjnNa3Pq9IN9kdimr59D82BN8WWQFPbxeERzckWAj2fG5rr4O1WZyIAMtF8CvPlDs63b1FUsc1SwTuLwbsjZnCwbRLuaCSxHB2mjOaN5uVx1yLsbD7OkQ0SCewRrmArsvKuRGISqBKV7/MgXcoQaCwc=
x-ms-traffictypediagnostic: VI1EUR05HT062:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9K0wD8rk62ysVsZqIogHw8eBx9eEcRWi7nCDcc/d7utLJ/qkKY/voDZiMk8bbleQBD0ECSJoREEEuFZ3b7grtfZGMV6d80wDeGuWkT9IT9cRa3eb0NA4GtdVXr6ZgZWnzIys/9n8iWF47AULxcmsmFUYwuU98Rveo3ALS5AEz1dVthUee0xfNH1POfnjNR3mWqHhHtlbR9UD/zo77zXvjQYO0yzA+dAce2IyVz26JFglC6QEvbiF8KySpLLu3RsHjDgjS6Sra2290A8sVNl0yjW5/q0vUmUCx97g+uWV4cXS0XuCP95Utc5vsP0AgswD/+sDn48DCy3LqcQWtJLsctR1UKTDLiF4K/ODlYIEExHNNPckBs9g7c5Y2M+QytCqbSHmRl39mI9f7RC95WP8fOLYCobMe3Q/FvKexONKq3+WdBqGQM7OQ3ibnL0Y2IYI
x-ms-exchange-antispam-messagedata: 
 qd7ZdZ6dMVmasxPG+pVnGMCopaFbgQuEbm60sxYp1JO/yMjhAkEgFYbVOXBUsngsRCa1bCJs5OWxp6qYcxshgFtLF+74RsDC0WmOq+5mWx5/hwTJbX8OvwGa2fcKiyFoUqqQjjOdm+uTkc+dtTQwEg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT058.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae729c8-4f49-4939-1f9b-08d8e7fc0078
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 21:47:59.7173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR05HT062
Message-ID-Hash: PULSVBAOWO7LMIBOH46EPJIFZHLBYLF5
X-Message-ID-Hash: PULSVBAOWO7LMIBOH46EPJIFZHLBYLF5
X-MailFrom: sdgfdghffd5645@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PIUH26PRHZWLDZUY3YZVN7FQEC6NQZA5/>
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
