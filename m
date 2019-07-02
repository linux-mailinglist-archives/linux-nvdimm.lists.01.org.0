Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B01985C948
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Jul 2019 08:25:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 10709212AB4E2;
	Mon,  1 Jul 2019 23:25:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.130.88; helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=ceo@teo-en-ming-corp.com; receiver=linux-nvdimm@lists.01.org 
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300088.outbound.protection.outlook.com [40.107.130.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9B71E21A02937
 for <linux-nvdimm@lists.01.org>; Mon,  1 Jul 2019 23:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78dBxQVbrRJztw+ILP92/uE0pZCTv0tzJTo5SQPotMs=;
 b=dW/MSTWB5PaqRkq+QsE3FLN4l0Ywsg6a9FCTnBrv16R8yKDv1zfzZ5AgiqGfT40fUD92tBY1GipmFg9/YsLjk+otacxaOyKfaG3Dv2iBmjA2icPOOXFyvVL7PBr1kMbRTYgnvErvjFJK072bNN4ihnyv2QcWCFkZFZfxkwxv9S8=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3352.apcprd01.prod.exchangelabs.com (20.178.152.142) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Tue, 2 Jul 2019 06:25:40 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::d503:3d71:ce06:19d2]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::d503:3d71:ce06:19d2%6]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 06:25:40 +0000
From: Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Is this list related to NVDIMM (Non-Volatile Memory Device)
 Persistent Memory (PMEM) Driver in Linux?
Thread-Topic: Is this list related to NVDIMM (Non-Volatile Memory Device)
 Persistent Memory (PMEM) Driver in Linux?
Thread-Index: AdUwns0h56Q3ss5YRXmSw7/aqveNCw==
Date: Tue, 2 Jul 2019 06:25:40 +0000
Message-ID: <SG2PR01MB214186B07E8D593AC2D62B1587F80@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 017cb41b-6b45-471d-82ae-08d6feb61ab9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:SG2PR01MB3352; 
x-ms-traffictypediagnostic: SG2PR01MB3352:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <SG2PR01MB3352C31FB7AF7F86D46A7A0A87F80@SG2PR01MB3352.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(39830400003)(366004)(376002)(346002)(189003)(199004)(6916009)(5660300002)(4744005)(256004)(508600001)(7736002)(66476007)(52536014)(73956011)(107886003)(186003)(606006)(66446008)(8676002)(4326008)(66556008)(64756008)(2906002)(76116006)(486006)(66946007)(71200400001)(2501003)(25786009)(71190400001)(8936002)(3846002)(21615005)(74316002)(66066001)(68736007)(81166006)(81156014)(14454004)(790700001)(33656002)(6116002)(99286004)(5640700003)(476003)(6306002)(7696005)(54896002)(966005)(236005)(6436002)(86362001)(316002)(55016002)(102836004)(53936002)(6506007)(2351001)(26005)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SG2PR01MB3352;
 H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KBudYAiWhSwnjcZbfOVk6kvEKRuY1PMuBmd2RonGBDX44xVIs+6fg57EoDj3oiBcvp0FdZUx5yQ17qsUHkghgaCFlBjKHyeIlWdG5z79NOxrRGOlB13JgOGhdwgK/qOF689tatsQw1o9bLUEY2TUtvqObr34NluPxO7Bk/Z/n3a5m27tek24dRgUtHTGzTWmfnlinYXlU3rXx0+89b5OCDodl72N5IENTF0ImldcYDn7fharQlWiPS16Y4aFvZaejRfFuKrlolSuhpB4K7iCZxKzdC1f2jGFWt6elQJMOjTCoPuFj/AxOQZk2iESVaf+JWHmhVBFirWe8DZT5Zd5pX4gxNFJSPiKXfZuXohFk3zqo7Ug+5LOfI+KIF643Tfi+bbvyfdOKbO4WmFx/ZSwDY65EwTeV0Y8Q79fN9frj6U=
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017cb41b-6b45-471d-82ae-08d6feb61ab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 06:25:40.3603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceo@teo-en-ming-corp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3352
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Good afternoon from Singapore,

Is this list related to NVDIMM (Non-Volatile Memory Device) Persistent Memory (PMEM) Driver in Linux?

Article: Persistent Memory Wiki
Link: https://nvdimm.wiki.kernel.org/

Thank you.




-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
