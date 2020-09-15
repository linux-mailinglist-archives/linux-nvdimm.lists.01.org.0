Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B93026A07B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 10:16:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 99B8A13D4EA16;
	Tue, 15 Sep 2020 01:16:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.219.250.4; helo=mail1.bemta24.messagelabs.com; envelope-from=ahuang12@lenovo.com; receiver=<UNKNOWN> 
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com [67.219.250.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 99D4713D4EA15
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 01:16:46 -0700 (PDT)
Received: from [100.112.129.88] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
	by server-4.bemta.az-a.us-west-2.aws.symcld.net id C3/07-25315-C68706F5; Tue, 15 Sep 2020 08:16:44 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUxTVxjGOffe3l4qd7lQGEeQMbuhG9iuhRm
  vsmVfWVJI0E3+2SSmXOSONiul6S1SqC5UFobgMpiCA8UiHR8CDixEJCgMsxGkQRiuMiFzQ1z4
  SgaKCILFtb3Itv9+z3me877vSd5DoAEreAjBmoysQcdoJbgIU0+Nb5J+bkpWyUv/iKZPWwaF9
  OnSIUD33bHgdPdfkxg9WWcDdF7JmJAuKXAidJGrRUjnX1oE9GhxL0KP3CzD392k7Kj4Xai0XZ
  1GlEVn1jDlXJcTVza3OTFlq8P8EX5AoNGlZJiSBep++yOh/pTQdO7sM0EuKMcLgYgIoHIR2HG
  rHuPFDIDLzlvCDee38R/XY6sAttnzgUcAqgaFrm4XzoteDObZpjBetABYtLLgjWFUJwqt935A
  +QJWBJZc6wS8mADwUUcBUggIAqci4YCdKQS+RCD1LYCzrr2eDEqdQmCe/U/vbTHVBGBX9xjKp
  y4CePdXjuc9sNnlwD2MURHwpGMceJikkuFa4731bu6h2u9e9IZ8KQaOTv3iZUC9CJf6mxAPo1
  QwHL1v9TKkKPj91UGU5yA4PbEm4PMnAFw9i/PnsbBuvm+dw+CwtQjwnAArjpcJeN4BHXOTGM8
  ZsKp3TcjzNuh8+PP6+Uuw4etxrBhEV/xnDJ53wKrOhzjPUbD2/Cxa4X2bP7xRfh+rAlgDoFMM
  mjS1MZ3RaKUKuVyqUERLFTFyafTOaBmTI2VkmZw0i+WMUrfM4mRcdvohbapMxxrtwL2AqfpjT
  68A18y87DrYTCCSIPJoVrIq4IWUjNRsNcOpVYZMLctdB1sIQgLJUI/nb2DTWNNnGq17jZ/bkP
  CTBJKpHpvk9Ew6p0njrX4QQxRPV1ajxN9PbNVoAKbL0LEhwWTtYXeU8kTVmbqNQs+/xDAICxG
  TwMfHJ8BPzxrSNcb/+zMgmAASMbnsqeKn0Rk3+rnX1/2KQDJRfNAzipH51wrJRQYSxYNTR1+O
  uT1xcjsZ/86iQ/UMlc/uX80co1rNb366v6ndpLM1nlMNv9dfeKRirK3uadfWvTJSBF5LytNLw
  srEsbddlz/osGBPLKJPtmgc4V01FjL3p9B8Cv1ypHchMHTIVZUUuu/Bwlf1vncECQU9yri3D7
  w/nf44R9xyxHop9vKe7w6/QU98OLpSZzW/tTlPsa3+8WD50hdRkebtx6i4azMjS0GddQlChJn
  b+eqyIWG3f6Ke2XXmxFRET011/I1KtFYVXqm2RGkWh+ZHdh0Pb2DFrVd6vjnYK3r9wiF9eDOn
  jHReiGPTKB/hKx9HDOzLuflgd192e3xS6WgjERZqlmCcmlFEogaO+QcqtUvejQQAAA==
X-Env-Sender: ahuang12@lenovo.com
X-Msg-Ref: server-4.tower-336.messagelabs.com!1600157802!54636!1
X-Originating-IP: [104.232.225.11]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4890 invoked from network); 15 Sep 2020 08:16:43 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.11)
  by server-4.tower-336.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Sep 2020 08:16:43 -0000
Received: from HKGWPEMAIL01.lenovo.com (unknown [10.128.3.69])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Forcepoint Email with ESMTPS id E4059FAAE909D95F72F5;
	Tue, 15 Sep 2020 04:16:39 -0400 (EDT)
Received: from HKGWPEMAIL03.lenovo.com (10.128.3.71) by
 HKGWPEMAIL01.lenovo.com (10.128.3.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Tue, 15 Sep 2020 16:16:37 +0800
Received: from HKEXEDGE02.lenovo.com (10.128.62.72) by HKGWPEMAIL03.lenovo.com
 (10.128.3.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4 via Frontend
 Transport; Tue, 15 Sep 2020 16:16:37 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (104.47.126.51)
 by mail.lenovo.com (10.128.62.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Tue, 15 Sep
 2020 16:16:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kI/iy5SAYsfMtPrPiXe3zTThQHZ6phXpu/WYfNomS7etT94QvxEPYff+swscG59UhVKN2lm+1Wzhk+B3Nfq4QFmCIcABrIdW2wWQC5RNUTty2zEzM+UcgKkX+c+JpENLjFpYpd8Rc/cEhFEIRcJTY8sObkibBgf0eP8PkqV2Xvu4h0nJrdqx1Ub7Oa2ssNLLdHwKGRnTZrKi9UHI+tbPXUBfO27c+gJdRnqks1AxzV+SIhrs57+ZA1vE6zkqEJuAh0+/kXjyoys79LFSq19fb2YdEB1PQOmrXw2ri+UbIcCfN2ZuH0Stf8LiqF4lqiG/nUlpHlhjLL2pEIJo6k2KUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZYD3iyYdGc5OAq6ufgNGT3Wu3OtPhx+LJHIqdTsEMk=;
 b=jaxrlHYmdOCslepXyPxIl3ogZVXiD8VHRa0pEVknuHVInoz5Z1/sPC0ihzeHleP4A6D8p1nZqCSUQWeNbvLX0H/OiYzXZEd+bmcKXc7LYJ6jN6c3EUSRapI4hcHTSss6TDsJJvumn7pkHrbFgXpcTIt2uExyO6A25H8RCZ68aMiEcBdWLelb+xGHKmdIlh4+wbieWvtCS56YSnAx9mqGpjpfrAKz9vFb3eleo+90WlhMcft+gGjqmWKYfZXRKA7R++brtFaYODl9WK76SW39oapQf6L+dXMh0736krsPka86b0xcAYpxHCi0M96dap1WsP4/0O5XMHpLxKcsCPFEjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZYD3iyYdGc5OAq6ufgNGT3Wu3OtPhx+LJHIqdTsEMk=;
 b=YecJsduVvCoE7oF8kIEqOmvG+OzoE5nx1wCvD9je1E5MfEAs151ocfynnwFk8LDbhT3K7Vjil1IQrKUfgKqg4T6N+DfE8n3DdMhFQ42YOsJIdDBtQf0VxuriroIrkbdz2YISsf76errbB6IZUTvFeSB5ToUET9NxoTE8VlrVdTc=
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com (2603:1096:202:c::8)
 by HK2PR0302MB2596.apcprd03.prod.outlook.com (2603:1096:202:b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5; Tue, 15 Sep
 2020 08:16:35 +0000
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164]) by HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164%7]) with mapi id 15.20.3391.009; Tue, 15 Sep 2020
 08:16:35 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Coly Li <colyli@suse.de>, "Dan
 Williams" <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: RE: [External]  regression caused by patch
 6180bb446ab624b9ab8bf201ed251ca87f07b413 ("dax: fix detection of dax support
 for non-persistent memory block devices")
Thread-Topic: [External]  regression caused by patch
 6180bb446ab624b9ab8bf201ed251ca87f07b413 ("dax: fix detection of dax support
 for non-persistent memory block devices")
Thread-Index: AQHWiq6a3lQ9jLTgFkS8+OwP/ESjwalpVzIAgAAC8wA=
Date: Tue, 15 Sep 2020 08:16:35 +0000
Message-ID: <HK2PR0302MB25949D05BC548C6CA2B7C386B3200@HK2PR0302MB2594.apcprd03.prod.outlook.com>
References: <alpine.LRH.2.02.2009141131220.30651@file01.intranet.prod.int.rdu2.redhat.com>
 <HK2PR0302MB259490E9D3F212396ACD0109B3200@HK2PR0302MB2594.apcprd03.prod.outlook.com>
In-Reply-To: <HK2PR0302MB259490E9D3F212396ACD0109B3200@HK2PR0302MB2594.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:b011:e002:f5de:1462:81a7:657b:8410]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ae36513-7a7a-4173-5e3e-08d8594fa9ca
x-ms-traffictypediagnostic: HK2PR0302MB2596:
x-microsoft-antispam-prvs: <HK2PR0302MB259610018034321D21AB05AFB3200@HK2PR0302MB2596.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B/u+4D6tPFC+ChkJXLGsG2yWQ2NzHjyC5cIqgtdQ7JVhzQ3vNsIoEW9ybNMjX0DH98DpS9EdVK4QZPQFDx1WGAoU+8SAK/zARz+65+N9lcHOUDvIXWK2YKEcG3bOFpgtfQy++U/PuDnwQzYD6Te6QgScS4FlM9DH3r1vEJ5Is795byXDRxmdW5oF1YJ2vgiuKjj6FHdduDhkC84KJ7gqsnEuYmuFWyQUes04PtB3XR27oboB3ptD7w4kVS2yboYjs/n2D+t4DhO9aCBIAID1blv4wbNvrrVkpozHmCodT1T89M0jRwOPU+EKNg5JF0Q1MBeEm394vr9aebFa8PIJZYLzJgIaVw4qVaNCFcAi3hi7UhUzY8rfGcI4WypaWFkBYOMq4NBjU6WraNM7C0PQHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR0302MB2594.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(2940100002)(4326008)(6506007)(5660300002)(7696005)(54906003)(52536014)(71200400001)(9686003)(110136005)(4744005)(8676002)(316002)(966005)(66446008)(64756008)(66556008)(55016002)(66476007)(2906002)(186003)(478600001)(76116006)(33656002)(66946007)(8936002)(83380400001)(86362001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: XZa4cCVTErOAJYbuhD361TApDmtX6tDgyBD5b32IWQS8J6JIK8wNj7PEYUkW+Cf9xrPoQOZtWo383/v1zYAIN3RONt99Uxo+raAb3OK16cMlufO+cmGf2OqhTIOR5SUZpN6B7iYv3Dpe+vOnb0q+NNlphclpjt9hZ3906FNqvkoiGNFPgyLptbb4sEnTTtgItLPsmstCIIyqUp9S9P5skVvEICA6XJwHLNlbkP3gokf4tZlwRQyFx8fQHP8BgtvfjD2u/l9p2CfZXo+u7lY0g/KfV6z1NeECYIe1U77H0Y1OTVMbzXI9M8MCy4/dR8A+VWgq8Ep5DsGgVGRltAALc8uBUd44ZBYdkcHbRisBeb9oC77RBSiQ0JQtPJgA6tO47ePidAU06Y9OievlpM9j/cqjyfVr/VuBEXeQOcXaDyOZ2lMWy2H1svNREUhXPNe5lXxWHeQ6K+AfSQq5Z2BFO6BQ8Q9R3rhe8Sp9B002pKu3x9ckHKd3qcnzsZyHR7w5zJuV5BQOW3t0nglKww2ZUmQKVk1VLcy7yyVUhXOc1TT/c5cRWVaNRtQ/dGfD8w5+hGf07CuybADLEQKAB0nUzeiJ5QggXxPf9/ad/hlf5uPlozSF73T4PLZwhg4Q+BuOI+xerBFEtZahlZy3R9Je7a7LLfrMlzVhj6l+qeVqE57P4qN56h+2Ofm9Obv281mxMUTQUPGNx0Hx3ENf4TlO6Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR0302MB2594.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae36513-7a7a-4173-5e3e-08d8594fa9ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 08:16:35.8305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9h7sDNG/XFiUUGHd3DU5e9w++VoR6eykTpPfqVZukWLeTK4/VBE8XBJLH2beeSzKaeTaYI5IJQTq57Q6vtoy6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0302MB2596
X-OriginatorOrg: lenovo.com
Message-ID-Hash: FQ55CK4UFF5VUIW6CZE3KTXLQPPF7NYM
X-Message-ID-Hash: FQ55CK4UFF5VUIW6CZE3KTXLQPPF7NYM
X-MailFrom: ahuang12@lenovo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.com>, "Ira Weiny  <ira.weiny@intel.com>, Mike Snitzer <snitzer@redhat.com>, Pankaj Gupta" <pankaj.gupta.linux@gmail.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Yi Zhang <yi.zhang@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FQ55CK4UFF5VUIW6CZE3KTXLQPPF7NYM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> 
> Hi Mikulas,
> 
> > -----Original Message-----
> > From: Mikulas Patocka <mpatocka@redhat.com>
> >
> > Hi
> >
> > The patch 6180bb446ab624b9ab8bf201ed251ca87f07b413 ("dax: fix
> > detection of dax support for non-persistent memory block devices")
> > causes crash when attempting to mount the ext4 filesystem on
> > /dev/pmem0
> > ("mkfs.ext4 /dev/pmem0; mount -t ext4 /dev/pmem0 /mnt/test"). The
> > device
> > /dev/pmem0 is emulated using the "memmap" kernel parameter.
> >
> 
> Could you please test the following patch? Thanks.
> https://lists.01.org/hyperkitty/list/linux-
> nvdimm@lists.01.org/thread/2JDBSE2WK75LSGCFEOY3RXRN3CNLBPB2/
> 

BTW, I have verified this patch (https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/thread/2JDBSE2WK75LSGCFEOY3RXRN3CNLBPB2/) on local box with the following tests:
1. mount fsdax pmem device
2. Run lvm2-testsuite
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
