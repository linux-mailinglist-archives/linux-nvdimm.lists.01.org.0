Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A64D8377CDB
	for <lists+linux-nvdimm@lfdr.de>; Mon, 10 May 2021 09:03:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 57AB6100EBBC0;
	Mon, 10 May 2021 00:03:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.255.104; helo=apc01-hk2-obe.outbound.protection.outlook.com; envelope-from=arohi_singh@hotmail.com; receiver=<UNKNOWN> 
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-oln040092255104.outbound.protection.outlook.com [40.92.255.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EF82C100EF264;
	Mon, 10 May 2021 00:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hpfx3e36yipKx7Sdw4kE3clZ1XVhHB/QD0FHU70tRHg9D2XANy1TcW4latGDqjxrC8FT4SNptQvfXDcynu+bZOGDPD+zXovUd09g6R1gMVz+n0qXXis4bYgK7Hgs+t0C9e48G+VRiCNZLhgm7qQJ+f/jJ4FdJHJTxqP83iiYm6Ws33vDoYlebix3KPXfjhf/0rF+JZ5HmPpFM59Hui4RTXh8erfGqswmiOpwiqrVqryJ6I2zmi699j4cXnIdmEsqLnQQvi2powrM4KY/pWGjusTfv6g+d2P+WVgtN53+ThhSc3Xb96J2K3dFCDfd8pHXjUI/msunEM/ROM4M0WkZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU4RDrTkJBHhMDdtMNebisYITLBAMM7ksHDbXXZKHkA=;
 b=WYMb963/sTJQDRLwM0OyaKOF4dg/NiizeJdf8ZJmiKcQ/uSg0jP7et/25M2wPpqPXHEChiNP1+3Q88m4YKy9Boq4+J3oMsE5qkQSILn+njqA2MSusabJJdGyYhFggwDDSX5ZPZmIF7rGELhghfmMLij0jAFIow6hcmfOeWDqX0/jbWIatXifwfcYFiBnFdolZ7U4Gbtnj+h+Ot03W1FnxGpBKCcfxJ+Reh7Q/yWFjFn8fEZj1Yfv48Hf3xPXRBGs0Ko+mHCsvAL9CrlYWx8VVXAjYBgg9GlYQwjNWPXf6RBgQiPC/DmWfIU0oOLKoiMf1Sac1BibNUUTOR9bUvFdcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU4RDrTkJBHhMDdtMNebisYITLBAMM7ksHDbXXZKHkA=;
 b=VQCKyoNdSwwlDhm54ejtfVzMpLbjS7uOirPXiHTUp+iEBomPDYs60n9G8Sb2ROrbTuzDDUPBPArslsYWH6NMFTkrBmRkQPPshBFERX/49PMCLEkdmqDXGg+p0N+Vvwa3cJtOrmAGslxC/oqctHhDfS7HO3XBhEQccSPCNE4xzd5itVD11JkFaoQ5/Tl2xmcBfOdHxtomO98ZEBYNV8rPlMzRXmiSx4fU1jCS9lDZ719CEGWeuYQvRvjPkYFnj9yi/AvzRQ0DWF14xf2Vzpe0Z/aRIzLlgsNm/w+nEwKmDGDPHeP9VqdflUTubEvJUuXvchs9UamtGidRN2r2KqocFg==
Received: from OS0PR01CA0074.jpnprd01.prod.outlook.com (2603:1096:604:99::21)
 by SG2PR01MB2567.apcprd01.prod.exchangelabs.com (2603:1096:4:7f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31; Mon, 10 May
 2021 07:02:03 +0000
Received: from HK2APC01FT004.eop-APC01.prod.protection.outlook.com
 (2603:1096:604:99:cafe::1e) by OS0PR01CA0074.outlook.office365.com
 (2603:1096:604:99::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 10 May 2021 07:02:03 +0000
Received: from MAXPR01MB4064.INDPRD01.PROD.OUTLOOK.COM (10.152.248.52) by
 HK2APC01FT004.mail.protection.outlook.com (10.152.248.125) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 07:02:02 +0000
X-IncomingTopHeaderMarker: 
 OriginalChecksum:0207CADC5392CEFABB5980FAD62F9D14A425CD4C2097E116FEECE11489800432;UpperCasedChecksum:52EF88391D0005F37A8E196E5D2F0FFF69F24AE5D324321F33BE4B01E8076AC9;SizeAsReceived:34653;Count:46
Received: from MAXPR01MB4064.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8cb9:ce5f:fc80:efb1]) by MAXPR01MB4064.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8cb9:ce5f:fc80:efb1%5]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 07:02:01 +0000
From: "Amit" <arohi_singh@hotmail.com>
To: "Amit" <arohi_singh@hotmail.com>
Subject: Re: Apps
Date: Mon, 10 May 2021 12:31:31 +0530
Message-ID: 
 <MAXPR01MB40647FF19CF2050687660E9496549@MAXPR01MB4064.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AddFZ6jtdo9Mt49dRouIuOrI53SkSw==
Content-Language: en-us
X-TMN: [k7R6tVRFiuzU/XowCz7KOKA7CWPUNW7Z]
X-ClientProxiedBy: BMXPR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::14) To MAXPR01MB4064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:61::12)
X-Microsoft-Original-Message-ID: 
 <!&!AAAAAAAAAAAYAAAAAAAAAIu1Qqvox/RNmP1XjBxJnf7CgAAAEAAAAEwyueRJAWxBtQ/fJDsjviQBAAAAAA==@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from adminPC (103.225.59.162) by BMXPR01CA0004.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::14) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 07:01:33 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 46
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 6acff450-8fe0-4cfc-0658-08d913817fe8
X-MS-Exchange-SLBlob-MailProps: 
	aEDjgxGVNaOe5bjt5wYJxdadT3zY46OmcoPpgRikBO0IVD0WDLrrYYSTSrMAwSnAMjwxQoM2HhJDQqLzFE24dK3levDFbNjZcMkmruzQyzYostwSWdSxwpRKbPezZJBoHkBIaqFDwXa7YHzev+zl1ELt7b+mxyI1h4n1J3YBKYz2CuOyVwFCpC8MmF6c/h54wkZODbaK7G99c9Vc+Kgdln8fBzg5n2vqVWlLkvfd7dWDWGgZZSqEN+ohH6rhCagKbvoBkQ7AV0v8fmQPiX6rEZXyi00XnNSZFwUIb68zPz1rMotNhgOxrbOxE6I7QO7HnLKx5jeiZgcIzg4v/EZWsOxzlx7pLpUlswl8I8Rl1ZgjSG+GiryBW4pCVFSIWlEqgna/JaxbP3YOcAVaFG3pHV+5vSUDOWuNzXfPxfdYssxvs7Bt3HIQUjz70oa8dI5AFMdBRe5T7VCfPjonS4OVQAvQIsgeJlLqBV0LbuQ9zeTpAvetvXQqj9SSn1mS9CzPKD/7rznJVrpIGPb4cRl0cjXK3M4kGllhw3YKnrAGv77twL52eNvrGGALL7RO/Z6g
X-MS-TrafficTypeDiagnostic: SG2PR01MB2567:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6vRaMEtz3EkhXeH6xu4OP9Rzn9GkfGHGP/O0LKtm4QEdUcxIqqnZAQEQF6wWXa89elVaAmZg0b9pH3dvgzOiVA5bb8e8lbrLtrfoyV5nSGTAol0S+28RHk2ModdelEV4lqLLMxct4xFmhzbpS0dxKu6uX7OA2Ys10RDLmyskXmeJ37Oze5Ero8ltfpetwcCC/sa5KDt4QjuZg7+IhuGFo9RIpkdADJy8TaKBVoEHreSwRDtQ390lllFM9jK3AZWm2MEQQyvJrOhsTY85aqWeLO6HIZ6WNNqaQBhb8H+35NVYEtDuLlMapbAjuy18NQX2sP/AU1uPKpvjXmP9grCpUZpjN1h2++N8xfzT+mZ25JbOa07yf1LyPudEGiKwi6XuZ6EaKi6TTbgPyOeLX0L0dg==
X-MS-Exchange-AntiSpam-MessageData: 
	9hl8rmfRE36TArTFU4MpTU/JS1z/hz5uTRcHKEiooRD+/TJL3M9T4ef8ytf9pplMk/sezqWmgPeX/990Q35sjxf0Cd+KtCgei7UTRTJlSLJeV24/wjg+LUwqaU4dWu5wiy3kEIEOgkuZ63J6GfQZtA==
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-5c337.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acff450-8fe0-4cfc-0658-08d913817fe8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 07:02:00.9572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: 
	HK2APC01FT004.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2567
Message-ID-Hash: Y6KE2RTKKI4MDNGIHEDH6KTLPF4XHR4J
X-Message-ID-Hash: Y6KE2RTKKI4MDNGIHEDH6KTLPF4XHR4J
X-MailFrom: arohi_singh@hotmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K26W44YIA36G3CRCA7TJUA3RB233SRLX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

I hope you are doing well..

  

Do you want a Mobile Apps (Android/iOS app) for your Business?

 

We have expertise in:

 

. Taxi/Food Delivery App

. Restaurant App

. Health Industry App

. Real-estate listing App

. E-learning App

. E-commerce App

 

Please let us know your Apps idea, exact requirement with us which kinds of
Apps and for which service you want so that we can provide solutions
accordingly.

 

Thanks,

Amit

(India)

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
