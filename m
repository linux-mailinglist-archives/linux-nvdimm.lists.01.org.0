Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAE8201E84
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Jun 2020 01:17:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D2CE410FC72A1;
	Fri, 19 Jun 2020 16:17:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.92.76; helo=nam10-bn7-obe.outbound.protection.outlook.com; envelope-from=rajesh.ananth@smartm.com; receiver=<UNKNOWN> 
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B10F510FC72A1
	for <linux-nvdimm@lists.01.org>; Fri, 19 Jun 2020 16:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/qcjfemB6BRy9nyu4UGHbEaC/1z+KPvW8mmpKzJcSiyRaOvOP93UwoABVhuequB+JRDJVtR58UjoX0ENvvo+yWTfVXLcj1JofmuVyU2YoBx8wgxIpcqFFJOtO1QBPF0op+Z+SzUrC+cAlK3Tdww5xA9XzI5d/GN4Chtw1zLwRKlJCLl2f5CapY+eKQVcC7xJRavEUdDWY/MjAqrfAwerPgncFkcyNWpjIV9vUaYDeWeDNdOuzWY2wc/F1imNcPRtHL5bka7vAhzagm7tFiwHNYUkU6QFv1imrNlEYjoyw4/70XEvbkALBahu7PT+7ul/TFoYpDxrGJrxwERNk1lbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn68CHhSosDuc95mknyEOKPNI31zymucJI2HLPDnI9U=;
 b=oe5YUAx421iNg3hyDVYM954m8plrLOiXpzn4qBn2GiQh4oF7UEPw+xcPL+Nh5bEsJHpmYvlwRiF3DIpYg5UZ0BWhLwRlFt84nfzlDUsXprhRU1Izto3ez53893Vtjt+a3NT/5ZvvgQ4zdqKHJL/4BeNbpqOze+dwlXhDf/PhimX1dpvq+sGGqfuPyPiUYA8oHNg7NFhArVB3199ZXnWz9y1ZxSG5uRr38KJMp1uP64AF1nY9S8wG+u6x346UWvPKNP70wyFtLUfOyh69Bbwyt8aCfMbENJ3xSat8V2uv044jiUOjBrd+JSgEUtQeKvbm416XPlzhY0cY/Y+/JTdpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=smartm.com; dmarc=pass action=none header.from=smartm.com;
 dkim=pass header.d=smartm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smartm.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn68CHhSosDuc95mknyEOKPNI31zymucJI2HLPDnI9U=;
 b=Z1hSS6z5ahCtWTy67pmt6lvjIGYO8cAZQCCYipPbEsQswCw58Hkavk2sLljVDLlUOsDJOHCPpibtcGF6StgHdZRE/tuNUGW0C+HEyk+Xa6/IBlMMTaoyWzHLLUD5cmFSeL1Nef2L9i1DnUjzjS/6/p9ulUjV1x8D0zsypsTc0zo=
Received: from BYAPR04MB4310.namprd04.prod.outlook.com (2603:10b6:a02:f0::13)
 by BYAPR04MB6056.namprd04.prod.outlook.com (2603:10b6:a03:f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 23:17:38 +0000
Received: from BYAPR04MB4310.namprd04.prod.outlook.com
 ([fe80::c9ea:3cc4:bce4:44ea]) by BYAPR04MB4310.namprd04.prod.outlook.com
 ([fe80::c9ea:3cc4:bce4:44ea%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 23:17:38 +0000
From: "Ananth, Rajesh" <Rajesh.Ananth@smartm.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Question on PMEM regions (Linux 4.9 Kernel & above)
Thread-Topic: Question on PMEM regions (Linux 4.9 Kernel & above)
Thread-Index: AdZGj7xlb1bNOIhzRnee4sCHW/WtkQ==
Date: Fri, 19 Jun 2020 23:17:38 +0000
Message-ID: 
 <BYAPR04MB4310650471DD3C25D77BEA6394980@BYAPR04MB4310.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=smartm.com;
x-originating-ip: [65.249.22.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d89e6fe-8a4b-464a-3ca8-08d814a6f532
x-ms-traffictypediagnostic: BYAPR04MB6056:
x-microsoft-antispam-prvs: 
 <BYAPR04MB6056D763D6716FC5DC42A55C94980@BYAPR04MB6056.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vBEbXzBO1YvQF3DfgpnfDwUl0TWcjg4zP+b3tXJ5ohHvr4hdE4jbaa4czErqlvZYEXuIzHo43LYFJhgnIUaqqOQ7LBIy/o6tygH3wh8tKOlUzbbvdgcyq2R46egrRhE2R7bOFGia+JmXhHrkesmKzVh0dZkXXNV8s9Ib7jcN0sioWb5gEIWeV6ZAheSGBzZ8snMSbL1DW+m13UL+1fGt0J7y5/xqN8ZZdRYW4bLxbWy1jlCbfWSxqjMkjXvG5tEA4pI0gg+Oe0fEI24Hii9CZLvf8/+Wo7ogGtdwStxZgOAsq1LsziKfJc2qnR27/giH2R4RbJeFx1KDleiyrfYXCQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4310.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(39850400004)(136003)(376002)(346002)(2906002)(33656002)(316002)(66556008)(66946007)(8676002)(4744005)(9686003)(6916009)(76116006)(66476007)(66446008)(64756008)(55016002)(478600001)(86362001)(8936002)(52536014)(5660300002)(6506007)(71200400001)(7696005)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 nsrh7Tum6UBkPojLKRYBUPt40oijkBp+3HCLEO1ThFOoY/M7JtauZyvl7uMqKmnA7kxsUKbLYebvVCl9gz3BuOto7hgEce4R2atKnX4yGTcA7mvihzkitLPOlNExzZ1hoAtXkGJtQqYc4TQTq/8J+pIL3Gij0m5K+CoFJGhOkUITI90Zigyn9+X4rK4/462AuFcFt4ynsxYd/cEmbZfu1HtPmqtoNuYMXrZCWVy74yB2riHeycAVQq+550XJt00SD2zal8fDeHv59q0GJoJd+1tfaK0r5DFWUofB0aBYERnbeQOfhYFqs2U33i0YWQIg/aoOI+dV6YdDdStYW1Y9Z/3tBHMW0RtBImeC+8VV64y8UP7c9UmwDZg7cUNXwRKy0Ce41yMZ8Xs/tlzy36INorSed+iDftZaaAOONH55Xqy4WvC3hEFyOP1uGMsCzhBiqy5naGylfXoRYlvcEwP/sUr6ElgMzjAAW0ARklfwd64=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: smartm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d89e6fe-8a4b-464a-3ca8-08d814a6f532
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 23:17:38.2492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f0fd7909-cd13-4779-b0f9-5ced6b7a2c68
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ut+BQ85WDrLjq37qjiTmFkoLq7Pr83fAG8hz3Ci+oQeeCvFz7ti+MT5HK8DOy9ClXceo2mW/PyV0Ha4p02V/RdLcHOcIb5qHaIJRsT94buE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6056
Message-ID-Hash: AHSYH5RF3UIRD5G4JS2WDMBVGDLTF35O
X-Message-ID-Hash: AHSYH5RF3UIRD5G4JS2WDMBVGDLTF35O
X-MailFrom: Rajesh.Ananth@smartm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
Content-Type: text/plain; charset="us-ascii"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7WE4L77V7X3UIYNQBMWQOEBCXSMKM3CM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

I have a question on the default REGION creation (unlabeled NVDIMM) on the Interleave Sets.  I observe that for a Single Interleave Set, the Linux Kernels earlier to 4.9 create only one "Region0->namespace0.0" (pmem0 for the entire size), but in the later Kernels I observe for the same Interleave Set it creates "Region0->namespace0.0" and "Region1->namespace1.0" by default (pmem0, pmem1 for half the size of the Interleave set).

I don't have any explicit labels created using the ndctl utilities. I just plug-in the fresh NVDIMM modules like I always do.

I searched for and found the relevant information on that front regarding the nd_pmem driver and the support for multiple pmem namespaces.  I am wondering whether is there a way I could -- through Kernel Parameters or something -- get the default behavior the same as it existed before Kernel 4.9 driver changes.

Thanks,
Rajesh

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
