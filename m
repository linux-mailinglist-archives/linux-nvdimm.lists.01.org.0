Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F3D309289
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 Jan 2021 09:04:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9EC52100EC1D9;
	Sat, 30 Jan 2021 00:04:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.100.146.85; helo=can01-to1-obe.outbound.protection.outlook.com; envelope-from=commandes1@portesmilette.com; receiver=<UNKNOWN> 
Received: from CAN01-TO1-obe.outbound.protection.outlook.com (mail-to1can01hn2085.outbound.protection.outlook.com [52.100.146.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D3C2A100EF267;
	Sat, 30 Jan 2021 00:04:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2QmWz6cZq3S+PzdSffatVUzBs+NIMUTf1jKWiALGzXLIfNryfemh9xAxk8EvhAoQhJedZXF0H1WgsPjqT86uDSRQKj71YEr7xoWRrF7AjFJkdwtBpmrUpZOskf0yuED2zhTuuNAKLL9QH1+j1Vll66Hwvmvz+poliLrumdcS8T76n3gK2pYyoAKEL+dLBHUr5jtJbqV7WHVR9VE7xJwqFZ/iDjIsptX25srjtj8gSvTSGd+6ECWbHmwIxP8ZaSiuuVnsgsdpMMeVcl3WW1FD3LYREb0IJYbhzJwwZY5DxGgD00HsSIjYnd31jx+sqObzusj1QqjEv74n4vDQmuI0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrnORU7YcilFO2hhFPw6d/8LB39SGHEP5JEf4+yYR5o=;
 b=BwLfbXQzLGzZmmjmhTPglU9e2psd84HzLwA0nYOWeJdxxCa9D3tMrlXgpbiH5+u6M0bSJVTChc1wJzoVGltS9MEEk9HTc8r7vc7FMUxvIUqml3ARLOH1EAdLyumky0FHE7UxMt/VunOhG5WgjmWf9f2vK11ZTHg3ivOkfw1G4pfz1i2Mju/+5Q8Wm3i2c4baSqtXMGjcmvlF8cMB5dmTZmPsq+R3qidR4u6akkpTCkr8ws58GaVXdyNlPpFkXBSO84JZ8YP5yy4Pxdre3rKv0jLc7C1E5XoHxrLBhed/r5CrX3fv3aMkCr39oR/PxfU0Om86Ic+5Jqw2BdibmGEnDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 184.149.63.217) smtp.rcpttodomain=lists.01.org
 smtp.mailfrom=portesmilette.com; dmarc=none action=none
 header.from=portesmilette.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=portesmiletteinc.onmicrosoft.com;
 s=selector1-portesmiletteinc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrnORU7YcilFO2hhFPw6d/8LB39SGHEP5JEf4+yYR5o=;
 b=Pu1DO4H/5vbMmD37lXVEJxZlfp8hT5s6pyhSsfHAgfaICKKjrxD4avbI9Et3IYYJTcEjcP1/rY6D9XmmeFLpQOwxD1PYNyh/n61vOXfeT54eIjCfHIrJwhrcrD61GNfCXb1a3ZOJ/gf5Vvm9vzQ2ih5if5tUdUMPuw+affmoYekVpC6pKBRF3MQeQtOMr9+w1y0AAZpAcQiUfA4dOL2ognev34y5mrYuDaUemWxB/o01GsU9zy1r34JfPt9nnvnU7hMcGmzAzrxxX6O8z08tf+E7zy3N7aFhDpo+3g6Rc/q18Z6hGk2lO40TGUw5k8wDa5WUfVDuucdbRGVO2ICyZg==
Received: from CH2PR11CA0029.namprd11.prod.outlook.com (2603:10b6:610:54::39)
 by YTBPR01MB2429.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:24::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Sat, 30 Jan
 2021 08:04:42 +0000
Received: from QB1CAN01FT007.eop-CAN01.prod.protection.outlook.com
 (2603:10b6:610:54:cafe::ff) by CH2PR11CA0029.outlook.office365.com
 (2603:10b6:610:54::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Sat, 30 Jan 2021 08:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 184.149.63.217) smtp.mailfrom=portesmilette.com; lists.01.org; dkim=none
 (message not signed) header.d=none;lists.01.org; dmarc=none action=none
 header.from=portesmilette.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 portesmilette.com discourages use of 184.149.63.217 as permitted sender)
Received: from DC2020.portesmilette.com (184.149.63.217) by
 QB1CAN01FT007.mail.protection.outlook.com (10.152.120.75) with Microsoft SMTP
 Server id 15.20.3784.11 via Frontend Transport; Sat, 30 Jan 2021 08:04:41
 +0000
Received: from User ([199.101.103.19]) by DC2020.portesmilette.com with Microsoft SMTPSVC(10.0.17763.1);
	 Sat, 30 Jan 2021 02:47:24 -0500
From: "Elizabeth C Shroeder"<info@portesmilette.com>
Subject: Private information d
Date: Sat, 30 Jan 2021 02:47:37 -0800
MIME-Version: 1.0
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <DC2020bLYluLCTaogxL00001ea9@DC2020.portesmilette.com>
X-OriginalArrivalTime: 30 Jan 2021 07:47:24.0753 (UTC) FILETIME=[2629F410:01D6F6DC]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de3d04aa-49e7-4da4-5021-08d8c4f5b2cb
X-MS-TrafficTypeDiagnostic: YTBPR01MB2429:
X-Microsoft-Antispam-PRVS: 
	<YTBPR01MB242916BFDB4C7EB6B4A559C392B89@YTBPR01MB2429.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?windows-1251?Q?dxlwToLBxJ/Zk1k6RhgBm14bKj6AM11PmoxuiW9fOsWKvAwtrlp5IfLQ?=
 =?windows-1251?Q?wh5/1evjOoNWqUIcl37MrTD1rkufBj/3JpO9rNdl5BIFNRgSgnwrJRZD?=
 =?windows-1251?Q?ogxfeBQ0nViWlFx8/yABj+oHgb+qdVXnNrFZE483hrHH96ZaT3tdCyIp?=
 =?windows-1251?Q?XsdatkRZg2dT56kqX9i+IeSfYu6AOOy25IhSg82RqKhX2XmLip5OThCb?=
 =?windows-1251?Q?7/Rg6dmdkgl4Z8rT9SnnFraCpoAiU0WtkkP6kYZNgBsWKCvMFC9O+R2Y?=
 =?windows-1251?Q?MWpnrc1dazZR5x58YZ4bn/ZNCRk0gspQjmml+BcF97w0jOctjWLyBzsU?=
 =?windows-1251?Q?G6biWku1ZloE0fJtKPLPkzOjjUyGWWF3fE0BYBEaIBCyjmWosppyO9QL?=
 =?windows-1251?Q?DJRAY0X5O8aFqIzB/5sN3TaGgz6CSzhe4TUYC5hAzGKGSjIVpGDmZBWH?=
 =?windows-1251?Q?wHJTMu8DL5d7wADKuiPpsVFI5Yf8TawJpwC0GrPqzmy3y0c9O3392h+B?=
 =?windows-1251?Q?ViFz78iOHYNhs2d0n/tHxV0oFK8S3Ykwk//cB/a3s90hpyMGR1f4yCUV?=
 =?windows-1251?Q?ol/d1JIX/ygAhLG4gmoB7QgKJEBItMvXC3ylcpPIuFmFf5iL2rZg3VQB?=
 =?windows-1251?Q?OV4aWShN6MHVG0YVpzudvPknS1tRb8URM/N/Ray9uUgTmp/JT68eI1zM?=
 =?windows-1251?Q?fODEmeBzuiR3miYLcXBNNQI3eTxPyDXOMK2EQKTkM5aNMKfFkEZ2PB3W?=
 =?windows-1251?Q?Ub2kgbvG+x7OmJ3hKuVa4Y3IfG/+glqNhWtaSQIsPpBOWguUo+pH7qq9?=
 =?windows-1251?Q?Uy5/9ViyTuk7CSzYNlggatlZmHP85G4Ei81pAUQwZeet8eCLrH8Tp+oW?=
 =?windows-1251?Q?mJb303NaymMY1mGbMXAPjvBvRfu32c6QUzU2i3dT+FiLrDuhZUP8YPkp?=
 =?windows-1251?Q?+q8tqSg0nUygLi/PdwqsynFZzkjE95GjfmXgrSLYoUu2JZ1uJVsUdn2j?=
 =?windows-1251?Q?hGoQzCH40OI7mTW5poK4zKTQ6pIOeQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:184.149.63.217;CTRY:CA;LANG:en;SCL:6;SRV:;IPV:NLI;SFV:SPM;H:DC2020.portesmilette.com;PTR:ipagstaticip-afa6a52d-1753-3797-a225-43deffca4f0b.sdsl.bell.ca;CAT:OSPM;SFS:(396003)(346002)(376002)(39860400002)(136003)(46966006)(356005)(450100002)(81166007)(47076005)(508600001)(340484013)(3480700007)(2860700004)(2906002)(82740400003)(6666004)(7116003)(5660300002)(186003)(8936002)(36906005)(26005)(82310400003)(8676002)(316002)(83380400001)(70586007)(956004)(336012)(70206006)(66574015)(109986005)(426003)(5456005);DIR:OUT;SFP:1501;
X-OriginatorOrg: portesmilette.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2021 08:04:41.8445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de3d04aa-49e7-4da4-5021-08d8c4f5b2cb
X-MS-Exchange-CrossTenant-Id: 4a02b35e-e720-46a3-b8d9-173d6bcbe131
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4a02b35e-e720-46a3-b8d9-173d6bcbe131;Ip=[184.149.63.217];Helo=[DC2020.portesmilette.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	QB1CAN01FT007.eop-CAN01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB2429
Message-ID-Hash: 3JXOX4QZEGSSMM6UVZ5MAN4D4QUYPDO5
X-Message-ID-Hash: 3JXOX4QZEGSSMM6UVZ5MAN4D4QUYPDO5
X-MailFrom: commandes1@portesmilette.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: zbthschroder1@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3JXOX4QZEGSSMM6UVZ5MAN4D4QUYPDO5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

My Beloved In God.

Greetings in the name of our lord Jesus Christ. I am Mrs Elizabeth Schroder  from Germany, a widow to late Dr. A. Schroder  l am 51 years old and a converted born again Christian, suffering from long time cancer of the breast, from all indication my condition is really deteriorating and it is quite obvious that I might not live more than two (2) months, according to my doctor because the cancer has gotten to a very worst / dangerous stage.

My late husband and my only child died last five years ago, his death was politically motivated. My late husband was a very rich and wealthy oil business man who was running his oil,Gold/Diamond Business here in West Africa Nigeria. After his death, I inherited all his business and wealth.

My doctors has advised me that I may not live for more than two (2) months, so I now decided to divide the part of this wealth, to contribute to the development of the church in Africa, America, Asia, and Europe. I collected your email address during my desperate search on the internet and I prayed over it. I decided to donate the sum of $17,500,000.00 USD (Seventeen  Million Five hundred thousand United States dollars) to the less privileged because I cannot take this money to the grave.

Please I want you to note that this fund is lodged in a private bank here in Africa(Standard Trust Bank Africa). Once I hear from you, I will forward to you all the information's you will use to get this fund released from the bank and to be transferred to your bank account. I honestly pray that this money when transferred to you will be used for the said purpose because l have come to find out that wealth acquisition without Christ is vanity. May the grace of our lord Jesus the love of God and the fellowship of God be with you and your family.

Reply me on my private email address zbthschroder1@gmail.com Thanks and God bless you.

Your beloved sister in Christ.

Mrs. Elizabeth Schroder
Donor
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
