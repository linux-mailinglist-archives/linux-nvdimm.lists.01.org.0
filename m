Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCA0357EAE
	for <lists+linux-nvdimm@lfdr.de>; Thu,  8 Apr 2021 11:05:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B165100ED48A;
	Thu,  8 Apr 2021 02:05:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.139.122; helo=ind01-bo1-obe.outbound.protection.outlook.com; envelope-from=kevin.bryne@uniqcontacts.biz; receiver=<UNKNOWN> 
Received: from IND01-BO1-obe.outbound.protection.outlook.com (mail-eopbgr1390122.outbound.protection.outlook.com [40.107.139.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CBDF6100EF267
	for <linux-nvdimm@lists.01.org>; Thu,  8 Apr 2021 02:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqSSIsyi72W2JmobziqsHfz91YdwS6SaEkLDKpZbBBHGH1++EZUyNRJW5DSVwBSFsC8Njcwvld+/vi+5lvq1sgpw05K5LSSX5koeNwYi2HmuCw+cfozwJqHjvgPpY/yho1f6nCPSXjwfvPnHyI5ldLEE1lXXNp1RNdT+OCp+qLh+RXMbM5K7FgWqdSXbonZcLSokICoypjhRMGwpqeNBDxTR5sVqrdHUC9rLKoD8NXdSfemitVIH4bnY2Nt8g4OB7svytYj1C6ZRssBgzF/ZhXxyij8nN8YqnD1JRDXG+Gy/gWb08uqs4xpumOjB76worz5gKfLVds0Ht9fSb7rTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xnrPDlC6MWnRsjYUq3Rem73VmUm4xrmS28z/spn7UM=;
 b=VGri8xudseIbBR8twUNJxR4U4ApPmWweVFfcdZmZeX9QWbbdRyvJzG1OuV+TbOKHI/TreO093sUkupW1ZurYocoC4hXYS0OjaGIev9hU804SzKI1vhIwfBiUBNOXi6IN5b1xL8z/rGRwEQ9Lb+Cz8gcfhYBy/hM8Jo84HSeIu8O/nK9tGhPN33qLL9ti0azceFcTdOIJKAu5fGda59Jm4G9D8l55HEAjFZhiTr+uSQ7hePZQY1EtuGRXi1Kp7KTRuf3+eVJ4Rnl/wE3dbSea/PlL9PZh6b8XEHctzde0/CrBD+uQMZIWuW/CXCA/7oWUjqRUUYSPjEgbS6J/fH4GyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uniqcontacts.biz; dmarc=pass action=none
 header.from=uniqcontacts.biz; dkim=pass header.d=uniqcontacts.biz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniqcontacts.biz;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xnrPDlC6MWnRsjYUq3Rem73VmUm4xrmS28z/spn7UM=;
 b=BW8N/PTKhhGiO6tXMs2Dr3Kid0Hjy6Tcby8Mw7xS4PKQ1HFBran9keF11gEHro/Dz8sGwjgdFvP5dv86maPjquAumPFli7HBd8RY9HbUfaREXL0D1YvFwRu1pu098847uNtNjMDT5ViNdLNzo+P7DTFQr84L5cNLVpPjiagJ9AOF110a/EpF6xR2/dLZMolaSfNTHMhcYv5pzvwbDVjW/07cCitj1CDYtn/WNUHaWmNqz6huaiXi6vFwxQLDQIAVb95GYlNJS6iUnXZbJ5ZrX/DPMxJRZovHgyNig34pt1E1H8fm3iIIHnguKMCyyYtS30ZY3+nxrH/Ca5SzZqCMZg==
Received: from PN1PR0101MB1374.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:19::12) by PN2PR01MB5030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:5d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 09:04:54 +0000
Received: from PN1PR0101MB1374.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::de:983d:db84:eda6]) by PN1PR0101MB1374.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::de:983d:db84:eda6%6]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 09:04:54 +0000
From: Kevin Bryne <kevin.bryne@uniqcontacts.biz>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: 2021_Gulf Information Security Expo & Conference, potential emails
Thread-Topic: 2021_Gulf Information Security Expo & Conference, potential
 emails
Thread-Index: AdcsVjoDPdR6EUuRRxGgp6PUvjPbQw==
Date: Thu, 8 Apr 2021 09:04:54 +0000
Message-ID: 
 <PN1PR0101MB1374721710EAD6DE131D111186749@PN1PR0101MB1374.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none
 header.from=uniqcontacts.biz;
x-originating-ip: [156.146.59.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d264dfde-7076-4695-9900-08d8fa6d606e
x-ms-traffictypediagnostic: PN2PR01MB5030:
x-microsoft-antispam-prvs: 
 <PN2PR01MB5030677CCC650E4A9443A42486749@PN2PR01MB5030.INDPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 eBdw+Fmk+LLxC8322Nj9Ib1QJ8nS9w3w4E0Rg6sMEloT2bU33mYYmycKVw+DDwYoti3dyYZtv2mF2sLIw30OGQ+F8ZM4Wcp1PajffA+o6w94+oS3dJ+AfNywXbhXehBPw04xIogNctNAW+EhvfO1MGZ8+cqQizm5Nu9hjRoRcTw97aQXxVWV5ioKD9vP0WhMhEry6QV3LhG8/6OQLBvjvz0mJscNV3Bl7HoAzXLuPYI5Gqf+ak/+nKn+j8FKGV0lvruCpuXLwrj87wm0IA0aTRrxKtyaJimmy04WEYhu0ylOLksq0OwSj4mrSP+EDaskGmck7uL++3YySMQza1Q4cT76g7NZTHDllaGpGbeesxIcckC8iLJPWqPVArvQPd1dPtqCt6D15JxZniPQ9t52GJjTKiE7Lubr6Fiquiz8d2O4NIJqZUP2g2Eij802f1sc0aGx7WLmr1ohRQopcy1hOU3NbR0sstBbKyBgxwtYtEcTiynu+Pw6aHrOxHX8CENTXhk7NrDDfVL7oDcFlOSklZxWIBJeBPRT/YunSyiukJ3xhERhK+fi0GPV+cgI4H1q2pQi4oM/qz2xMIpOoVW3x5+QOxxGEnQOYsAWgR6KV7bzz0yKkrP2YwNHSXvCM9zkbKceQyyfr/Rpia+YlbKalw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN1PR0101MB1374.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39860400002)(376002)(346002)(83380400001)(9686003)(55016002)(6916009)(66476007)(66446008)(26005)(5660300002)(2906002)(6506007)(71200400001)(66556008)(66946007)(76116006)(316002)(8676002)(52536014)(8936002)(64756008)(15650500001)(186003)(44832011)(38100700001)(4744005)(86362001)(7696005)(478600001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?0tPi3OxBGfF1PHn6MiwcTiSRt6e7Ux4n8ALQZGZIaZgNP1umDslsG2oCzpr2?=
 =?us-ascii?Q?7SnDpy1vQuiJnHi35FXHI74Mj37Rxhmi9/OqmVrxFOnDUIJ+NVUg+M5f8dda?=
 =?us-ascii?Q?p3kLpcBkuL56Kb0wgUR7UhLFncx5s15PIQeSJZ7ah4eIWHJfM+H9oXsBngs9?=
 =?us-ascii?Q?MBcO9ZdZq4wFL4CGCeVygX/CH9y8Y4EDHau2V9IM9X/xqwJLir9xV+fWcODJ?=
 =?us-ascii?Q?TsU/4xfb0P7YVfpy9vXT7MqLndNyiP8B6hGh2SvskByF6TYgK1YX74BeSknM?=
 =?us-ascii?Q?Jim2VMLgUqqHwt7ghN33y5jhDKMbYbTUBIdJ+9BEOz1VduZ3mf3tZkxS22Jx?=
 =?us-ascii?Q?c3jXLjt5DrCqNh5ZHJVEKPVLrMxUUKdhFQNvKwm1d0wcW3IlGKbiBR+CRWdZ?=
 =?us-ascii?Q?/HKtlvi6JJGzPwbqbidMe+mQHPPHmlIxJeo2zxuQh4GekUgJPoHQvZpMr1kj?=
 =?us-ascii?Q?7xhEYeUPBapKc14Vh3Ld2JQul72q4fu0m4mmOmZQIDV29zoVruI9v0GVWK9v?=
 =?us-ascii?Q?F+Nmg8meuWIlcs+UfmtaK7lZdecE43a8QhxZKGM7KDuZlzDrFzsvF37VgUQO?=
 =?us-ascii?Q?DSFZbPyFii9RWRjX0vr7eNhTitNzi5zQcF8g9mlRYkrn7Ke560NPrCsUVT8L?=
 =?us-ascii?Q?zzyedTJx6TAnu/tBYkYKhwpt5giQrmHjZRWgYSKbgXSX8yeUMggBL+kCcwWh?=
 =?us-ascii?Q?xeNjG9jDYeZYUQtRn9/2Q6a6unVvVwOY8IEmst9Rq7GZ2xuJ4GKnb2g+A5WW?=
 =?us-ascii?Q?kUCsRpdISrqxZLZAaNjCNTs29qYgfOEJ2jHQHjSmy8CTjh3NilGZv3nRfaEf?=
 =?us-ascii?Q?Nx8sFYmaVVoymgvqFEFULekvT++Svsz3RGWuZeIY8ZhZz/9WRxaQoHlGSH9Q?=
 =?us-ascii?Q?tsQtzZ6Q0t0Lm+4H3In9RReN7sbDfDg+4xTfISlR2vBMwO76JICRYPPLn6AH?=
 =?us-ascii?Q?ZUuwvtMZUCX+zeADvg17vnl88TxKXBb8jX9YUZckPa0vEB1dyXEfn+BELIuV?=
 =?us-ascii?Q?XqEeJRw1PNDx+RHQSXOoVtp8eo6GbxOoHM0bboKZ9gVRaHnBIF7F6+yPHZCu?=
 =?us-ascii?Q?sLlTR0+8GKodWxs4tQMmdlRQOZQQF2OiZVuRlFjifjMHH6Mws+SEXYWVV7ya?=
 =?us-ascii?Q?UzGS9u89ezDNgt/EdXh9++yOQrGeIa2BBKXEHjAkeZ0zSJYrNFVAo73JlnQh?=
 =?us-ascii?Q?8Duo5a4e/nwNozqdsPdJpq4VsAqQCgjbaGfWrO8xQMiyShKwYl7U/0EBu4ac?=
 =?us-ascii?Q?hdy8/QaXOXrEh2LOyDPPZ5lMIqLZN2i81TPfgpK1fv5w0zexEU2ZV6r3X8Aj?=
 =?us-ascii?Q?KefJ3NTsQnUkKZ+t1/wsU3bi?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: uniqcontacts.biz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN1PR0101MB1374.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d264dfde-7076-4695-9900-08d8fa6d606e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 09:04:54.7875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dd2a150e-67b8-4f1d-8f81-202b09f594f5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bz7hXwkX6ycxAdqk4YfYFuMM/5HG+6CsciRS/d2b3XYC2yPqEpp8sLsbsRNrZASLYz0p6BpsIIja0tdz+1oi6Jzqk9mcjqDnKydHC/oT6Hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB5030
Message-ID-Hash: 74QGTEAF623T4Q6W7RL5VJYMUD2GS3ZR
X-Message-ID-Hash: 74QGTEAF623T4Q6W7RL5VJYMUD2GS3ZR
X-MailFrom: kevin.bryne@uniqcontacts.biz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="us-ascii"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BR2U3EFGZT2L5EBSVCZEGQWAYY4RSG6O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

Good Day,

Are you interested in acquiring the latest potential mailing list which may be useful for your marketing campaign?

Gulf Information Security Expo & Conference

31 May - 02 Jun 2021

Dubai World Trade Centre, Dubai, UAE

Visitors - 12,000

Information available - Contact Name | Email ID | Job Title | Phone Number | Company Name | Website/URL

Please let us know if it works for you and get the pricing details.

50% Discount on Pricing

Regards,

Kevin Bryne - Marketing Specialist

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
