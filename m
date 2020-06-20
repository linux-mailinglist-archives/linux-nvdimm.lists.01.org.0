Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B63201FA2
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Jun 2020 04:02:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2DD2F10FCB777;
	Fri, 19 Jun 2020 19:02:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.94.74; helo=nam10-mw2-obe.outbound.protection.outlook.com; envelope-from=rajesh.ananth@smartm.com; receiver=<UNKNOWN> 
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 973C610FCB775
	for <linux-nvdimm@lists.01.org>; Fri, 19 Jun 2020 19:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZtMhlsfxn/rAlpdA3zcZjfDHS5puL1u6+oUOSnIjNFZjKD1udDhmtQdh69+k/xLeWwhSDKqzWaBoFs1eb5L49WBq2B3OPW2r56kvftzhprg3zh0iNbFcbIkF9eZCpM2dg8bGSngKgzI4hHkN4/JZ8eOYNHmSyLc6VBFcVPvFrjm8IANANTKcTlrnR4D5LjySjGDm/p13FQhcLbyMH1Q9QEh3p9JPxTAtIZc2x91JarZhwz80Nz457CH0ZpxEBvGAPogu8xRtAHQo9egbD/UoRJvs8YvKysYiB/dIGENRT5yoYThrxcUOOC9uEpojkC4hUWCsKKYsd03YGJLKPUv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJQ0bUr+hmWTd6ma937ONMP/uIEz05CbhiUAMyxxG9g=;
 b=V3fvVfCWit8PzQGZ1aEyS4qSXCS2QQWtDiH3V3MNv6UErW2ZZB+zOAU2gks6UJTVJAs+m/q2mOb54awbw/br17nQPRZnM5xkwqr6wrBsBA1BQi9uXpl851cNsDdS5ZLSUT3yuJKEx5SIXj3+cf4urygWaavF20a7FQXULdmQvoAPSamHN18lI+DuOQMiiCapJKGDWl7VBUMNV7b/QansFjpN1KLfeIgggX1hrImt17kFftmu/5fPjbXfBfzu/OKdqppqUvNUKqiRdDmcmRiTDtDCDWUT1AHwA6zTU0AgLitBt+PwGEV2Lormcv4WL3k0lJyCtJH9xYWFC+pXEP08fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=smartm.com; dmarc=pass action=none header.from=smartm.com;
 dkim=pass header.d=smartm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smartm.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJQ0bUr+hmWTd6ma937ONMP/uIEz05CbhiUAMyxxG9g=;
 b=AhrseK8R3Q+3eidKReGPQBZRMfjRH4dhQ6SJIv1zxObBdlqKw3GurqJ3qMDvWhcrre9zO1PB9QQ6suVRHz3Sjfre7REGWgoKRFXFZJYTpiMQd7VR7FcgSmaQzHZeXzcAVnfBV4lytBLy4uXwnXdJt1Ad6l7n54HJmnC75QOuRso=
Received: from BYAPR04MB4310.namprd04.prod.outlook.com (2603:10b6:a02:f0::13)
 by BY5PR04MB6565.namprd04.prod.outlook.com (2603:10b6:a03:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Sat, 20 Jun
 2020 02:02:14 +0000
Received: from BYAPR04MB4310.namprd04.prod.outlook.com
 ([fe80::c9ea:3cc4:bce4:44ea]) by BYAPR04MB4310.namprd04.prod.outlook.com
 ([fe80::c9ea:3cc4:bce4:44ea%7]) with mapi id 15.20.3109.023; Sat, 20 Jun 2020
 02:02:14 +0000
From: "Ananth, Rajesh" <Rajesh.Ananth@smartm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: RE: Question on PMEM regions (Linux 4.9 Kernel & above)
Thread-Topic: Question on PMEM regions (Linux 4.9 Kernel & above)
Thread-Index: AdZGj7xlb1bNOIhzRnee4sCHW/WtkQAAmrCAAAAutkAAASDdgAADMNMA
Date: Sat, 20 Jun 2020 02:02:14 +0000
Message-ID: 
 <BYAPR04MB4310B35B8E6A7D66DEB78C0194990@BYAPR04MB4310.namprd04.prod.outlook.com>
References: 
 <BYAPR04MB4310650471DD3C25D77BEA6394980@BYAPR04MB4310.namprd04.prod.outlook.com>
 <CAPcyv4jDgD82S9VHWb-P5iP+UH-gqdsYcNmA=aMFNhKrdSEUqg@mail.gmail.com>
 <BYAPR04MB4310B8A76F318E50237447E294980@BYAPR04MB4310.namprd04.prod.outlook.com>
 <CAPcyv4gLX1p5Amz_9V7SGurX+aTQfmPdTp8DSTm53u2Qgtgj=A@mail.gmail.com>
In-Reply-To: 
 <CAPcyv4gLX1p5Amz_9V7SGurX+aTQfmPdTp8DSTm53u2Qgtgj=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=smartm.com;
x-originating-ip: [65.249.22.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42c8c96b-ef59-4e5d-9ae3-08d814bdf3b3
x-ms-traffictypediagnostic: BY5PR04MB6565:
x-microsoft-antispam-prvs: 
 <BY5PR04MB6565B5C281DE8D43158D915494990@BY5PR04MB6565.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0440AC9990
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QnyieaGiyr8bEbzRyWaLaT6PutSuYytnzbu6mCZVb+cWrGnHptin1Mtp089D9PikQ1t6ELTl+NnMIeJCRY7v6S4XjqfHP6DrGk9QsqrAO6MP/whEzUYWWEex2OqWkWdaVfLFi0lHuw3DVM1USNvX/SN1kbWIGh7E/I/OLCZrzrjeSD2pv49+H74mNAhNHF+qKbxOgNIZDV8H1PmAYa2OpXAV4LZiVPwonDTrXUZyRs7aVOOnPIXT/QDnHMN+iuy8dXHie+8sa1TsLOAR1NPQ0YzZarxaeGiOMoC+SiY/LKoo19QZjo99rIIrDyyt0ViXC1iKDFti97EfGhkRn0tlKgoBY+R1PD/9g8cwyMBvI1Bm7hQB0lF6Ikmie6F3BN3kKPMJ64+6lQNqZl/yjCVdkvldLg1hOih0cJzsLmGg/2/WioY0nOtBh0Uz4DyyxeInRKN0g5o6G97fgtCbZxlQDD1fTqyaUphYMg2Wa4oP8UM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4310.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(376002)(136003)(366004)(39850400004)(83380400001)(66476007)(6916009)(86362001)(8936002)(33656002)(8676002)(66556008)(52536014)(66446008)(76116006)(66946007)(5660300002)(2906002)(64756008)(7696005)(30864003)(966005)(4326008)(9686003)(55016002)(6506007)(53546011)(186003)(26005)(71200400001)(478600001)(316002)(505234006)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 Q5LGTyYP0JFCi5ImMMtnXCiJ6nzbZDdWIfCaRSxtYAdCjbAIIHyxbhIE4NYfDRh24OqFkmO7e+FUzqPNoJtAPm7s5BpvKNPuBKwwdN6rSJ74X3mURNbIrjH45T1leZe62vf+FK/UFBI2yrDUj3msBHHBmUIOOw9qukONrxFMl6dieLhm5tLHDSUqbtLPRFLfO1DLcTsbNjBHPToKNXXSC671eJ1R8FrOOAbT0oRA2XOV6HpOvWyvX6Dezw3EcWIcsGOflf6ANAEczlAzzBHOVZ/Jq7FrwU7FUDmYgObB3oPpeFWUaNzgt1TCehqxxJ2mm+wcyLMM/V3rOTykOMx+ZBP0RLsxndRgiZOfdhiOaR/HlT53CYCr1e3BZO5XZzV8hXNK3I20U0WnWGRNiF3nqNS2mj2FoUnWEaW8cDSmxX4qn63T4kf3xhjrJnBrnbID3l53i6aIPrqTDVEo21Lgk2Q9s9Ipu/vEp4NfS71cwUE=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: smartm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c8c96b-ef59-4e5d-9ae3-08d814bdf3b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2020 02:02:14.0994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f0fd7909-cd13-4779-b0f9-5ced6b7a2c68
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ba2FvUb1psXYSz0/hvEx7qAHtNjj0H3d60+ArLTo35xczF7BAZ38M4twEXlEt6DF43v+/tcDmHylpInQpF/ZvVTWCQEJlfcPJuDpl93tEHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6565
Message-ID-Hash: 7MOESFNIURUYFMMWGXR7MDYEIRYHPFAC
X-Message-ID-Hash: 7MOESFNIURUYFMMWGXR7MDYEIRYHPFAC
X-MailFrom: Rajesh.Ananth@smartm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4ENXEWMJB3YCDXK34FTPRJRI77UZDR3H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We used the Ubuntu 18.04 to get the "acpdump" outputs (This is the only complete package distribution we have. Otherwise, we use mainly the built Kernels).  The NFIT data is all valid, but somehow it is printing the "@ addresss" at the beginning as zeros. 

=============================  acpdump -n NFIT  ========================================

NFIT @ 0x0000000000000000              <<<<  DON'T KNOW WHY. 
  0000: 4E 46 49 54 A4 01 00 00 01 83 41 4C 41 53 4B 41  NFIT......ALASKA
  0010: 41 20 4D 20 49 20 00 00 02 00 00 00 49 4E 54 4C  A M I ......INTL
  0020: 13 10 09 20 00 00 00 00 00 00 38 00 01 00 02 00  ... ......8.....
  0030: 00 00 00 00 00 00 00 00 79 D3 F0 66 F3 B4 74 40  ........y..f..t@
  0040: AC 43 0D 33 18 B7 8C DB 00 00 00 80 40 00 00 00  .C.3........@...
  0050: 00 00 00 00 04 00 00 00 08 80 00 00 00 00 00 00  ................
  0060: 04 00 50 00 01 00 01 94 53 72 01 00 01 94 4E 72  ..P.....Sr....Nr
  0070: 05 00 01 01 20 08 00 00 01 4E 2E ED 01 01 00 00  .... ....N......
  0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  00A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  00B0: 01 00 30 00 20 00 00 00 48 00 00 00 01 00 01 00  ..0. ...H.......
  00C0: 00 00 00 00 04 00 00 00 00 00 00 00 00 00 00 00  ................
  00D0: 00 00 00 00 00 00 00 00 00 00 01 00 21 00 00 00  ............!...
  00E0: 00 00 38 00 02 00 02 00 00 00 00 00 00 00 00 00  ..8.............
  00F0: 79 D3 F0 66 F3 B4 74 40 AC 43 0D 33 18 B7 8C DB  y..f..t@.C.3....
  0100: 00 00 00 80 44 00 00 00 00 00 00 00 04 00 00 00  ....D...........
  0110: 08 80 00 00 00 00 00 00 04 00 50 00 02 00 01 94  ..........P.....
  0120: 53 72 01 00 01 94 4E 72 05 00 01 01 20 08 00 00  Sr....Nr.... ...
  0130: 01 4E 2E ED 01 01 00 00 00 00 00 00 00 00 00 00  .N..............
  0140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0160: 00 00 00 00 00 00 00 00 01 00 30 00 20 00 00 00  ..........0. ...
  0170: 48 00 01 00 02 00 02 00 00 00 00 00 04 00 00 00  H...............
  0180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0190: 00 00 01 00 21 00 00 00 03 00 0C 00 00 00 00 00  ....!...........
  01A0: 48 00 49 00                                                                      H.I.

=============================  acpdump (all)  ========================================

NFIT @ 0x0000000000000000    <<<<  DON'T KNOW WHY.
  0000: 4E 46 49 54 A4 01 00 00 01 83 41 4C 41 53 4B 41  NFIT......ALASKA
  0010: 41 20 4D 20 49 20 00 00 02 00 00 00 49 4E 54 4C  A M I ......INTL
  0020: 13 10 09 20 00 00 00 00 00 00 38 00 01 00 02 00  ... ......8.....
  0030: 00 00 00 00 00 00 00 00 79 D3 F0 66 F3 B4 74 40  ........y..f..t@
  0040: AC 43 0D 33 18 B7 8C DB 00 00 00 80 40 00 00 00  .C.3........@...
  0050: 00 00 00 00 04 00 00 00 08 80 00 00 00 00 00 00  ................
  0060: 04 00 50 00 01 00 01 94 53 72 01 00 01 94 4E 72  ..P.....Sr....Nr
  0070: 05 00 01 01 20 08 00 00 01 4E 2E ED 01 01 00 00  .... ....N......
  0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  00A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  00B0: 01 00 30 00 20 00 00 00 48 00 00 00 01 00 01 00  ..0. ...H.......
  00C0: 00 00 00 00 04 00 00 00 00 00 00 00 00 00 00 00  ................
  00D0: 00 00 00 00 00 00 00 00 00 00 01 00 21 00 00 00  ............!...
  00E0: 00 00 38 00 02 00 02 00 00 00 00 00 00 00 00 00  ..8.............
  00F0: 79 D3 F0 66 F3 B4 74 40 AC 43 0D 33 18 B7 8C DB  y..f..t@.C.3....
  0100: 00 00 00 80 44 00 00 00 00 00 00 00 04 00 00 00  ....D...........
  0110: 08 80 00 00 00 00 00 00 04 00 50 00 02 00 01 94  ..........P.....
  0120: 53 72 01 00 01 94 4E 72 05 00 01 01 20 08 00 00  Sr....Nr.... ...
  0130: 01 4E 2E ED 01 01 00 00 00 00 00 00 00 00 00 00  .N..............
  0140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0160: 00 00 00 00 00 00 00 00 01 00 30 00 20 00 00 00  ..........0. ...
  0170: 48 00 01 00 02 00 02 00 00 00 00 00 04 00 00 00  H...............
  0180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0190: 00 00 01 00 21 00 00 00 03 00 0C 00 00 00 00 00  ....!...........
  01A0: 48 00 49 00                                      H.I.

MCFG @ 0x0000000000000000  <<<<  DON'T KNOW WHY.
  0000: 4D 43 46 47 3C 00 00 00 01 61 41 4C 41 53 4B 41  MCFG<....aALASKA
  0010: 41 20 4D 20 49 00 00 00 09 20 07 01 4D 53 46 54  A M I.... ..MSFT
  0020: 97 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80  ................
  0030: 00 00 00 00 00 00 00 FF 00 00 00 00              ............

EINJ @ 0x0000000000000000   <<<<  DON'T KNOW WHY.
  0000: 45 49 4E 4A 50 01 00 00 01 6E 41 4C 41 53 4B 41  EINJP....nALASKA
  0010: 41 20 4D 20 49 20 00 00 01 00 00 00 49 4E 54 4C  A M I ......INTL
  0020: 01 00 00 00 0C 00 00 00 00 00 00 00 09 00 00 00  ................
  0030: 00 03 01 00 00 40 00 04 18 80 1D 6A 00 00 00 00  .....@.....j....
  0040: AA 55 AA 55 00 00 00 00 FF FF FF FF 00 00 00 00  .U.U............
  0050: 01 00 00 00 00 40 00 04 48 80 1D 6A 00 00 00 00  .....@..H..j....
  0060: 00 00 00 00 00 00 00 00 FF FF FF FF FF FF FF FF  ................
  0070: 02 02 01 00 00 40 00 04 20 80 1D 6A 00 00 00 00  .....@.. ..j....
  0080: 00 00 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  ................
  0090: 03 00 00 00 00 40 00 04 50 80 1D 6A 00 00 00 00  .....@..P..j....
  00A0: 00 00 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  ................
  00B0: 04 03 01 00 00 40 00 04 18 80 1D 6A 00 00 00 00  .....@.....j....
  00C0: 00 00 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  ................
  00D0: 05 03 01 00 01 10 00 02 B2 00 00 00 00 00 00 00  ................
  00E0: 9A 00 00 00 00 00 00 00 FF FF 00 00 00 00 00 00  ................
  00F0: 06 01 00 00 00 40 00 04 58 80 1D 6A 00 00 00 00  .....@..X..j....
  0100: 01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
  0110: 07 00 01 00 00 40 00 04 60 80 1D 6A 00 00 00 00  .....@..`..j....
  0120: 00 00 00 00 00 00 00 00 FE 01 00 00 00 00 00 00  ................
  0130: 08 02 01 00 00 40 00 04 78 80 1D 6A 00 00 00 00  .....@..x..j....
  0140: 00 00 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  ................

  <<< REDACTED. Output too long . On request, attachment will be sent. >>>
   

Thanks,
Rajesh



-----Original Message-----
From: Dan Williams [mailto:dan.j.williams@intel.com] 
Sent: Friday, June 19, 2020 5:12 PM
To: Ananth, Rajesh
Cc: linux-nvdimm
Subject: Re: Question on PMEM regions (Linux 4.9 Kernel & above)

[ add back linux-nvdimm as others may hit the same issue too and I
want this in the archives ]

On Fri, Jun 19, 2020 at 4:49 PM Ananth, Rajesh <Rajesh.Ananth@smartm.com> wrote:
>
> Dan,
>
> Thank you so much for your response.  Our PLATFORM is totally NFIT compliant and does not use the Type-12/E820 maps.

Ah, great.

>
> We have 2 NVDIMMs interleaved in the same Memory Channel, each 16 GB in size.
>
> This is what the 4.7.9 Kernel reports for the for "/proc/iomem":

Can you post the output of:

acpdump -n NFIT

...?

Labels can't create new regions, so there must be a behavior
difference in how these kernels are parsing this NFIT.

>
> 00001000-0009afff : System RAM
> 0009b000-0009ffff : reserved
> 000a0000-000bffff : PCI Bus 0000:00
> 000c0000-000c7fff : Video ROM
>   000c4000-000c7fff : PCI Bus 0000:00
> 000c8000-000c8dff : Adapter ROM
> 000c9000-000c9dff : Adapter ROM
> 000e0000-000fffff : reserved
>   000f0000-000fffff : System ROM
> 00100000-6984ffff : System RAM
>   2e000000-2e7f1922 : Kernel code
>   2e7f1923-2ed448ff : Kernel data
>   2eedb000-2f055fff : Kernel bss
> 69850000-6c1f8fff : reserved
>   6b1dd018-6b1dd018 : APEI ERST
>   6b1dd01c-6b1dd021 : APEI ERST
>   6b1dd028-6b1dd039 : APEI ERST
>   6b1dd040-6b1dd04c : APEI ERST
>   6b1dd050-6b1df04f : APEI ERST
> 6c1f9000-6c322fff : System RAM
> 6c323000-6ce83fff : ACPI Non-volatile Storage
> 6ce84000-6f2fcfff : reserved
> 6f2fd000-6f7fffff : System RAM
>  fec00000-fec003ff : IOAPIC 0
>   fec01000-fec013ff : IOAPIC 1
>   fec08000-fec083ff : IOAPIC 2
>   fec10000-fec103ff : IOAPIC 3
>   fec18000-fec183ff : IOAPIC 4
>   fec20000-fec203ff : IOAPIC 5
>   fec28000-fec283ff : IOAPIC 6
>   fec30000-fec303ff : IOAPIC 7
>   fec38000-fec383ff : IOAPIC 8
> fed00000-fed003ff : HPET 0
>   fed00000-fed003ff : PNP0103:00
> fed12000-fed1200f : pnp 00:01
> fed12010-fed1201f : pnp 00:01
> fed1b000-fed1bfff : pnp 00:01
> fed20000-fed44fff : reserved
> fed45000-fed8bfff : pnp 00:01
> fee00000-feefffff : pnp 00:01
>   fee00000-fee00fff : Local APIC
> ff000000-ffffffff : reserved
>   ff000000-ffffffff : pnp 00:01
> 100000000-407fffffff : System RAM
> 4080000000-487fffffff : Persistent Memory         <<<<<  PERSISTENT MEMORY
>   4080000000-487fffffff : namespace0.0
> 4880000000-887fffffff : System RAM
>
> The same system configuration under 4.16 Kernel (We just rebooted with a new Kernel):
>
> 00001000-0009afff : System RAM
> 0009b000-0009ffff : Reserved
> 000a0000-000bffff : PCI Bus 0000:00
> 000c0000-000c7fff : Video ROM
>   000c4000-000c7fff : PCI Bus 0000:00
> 000c8000-000c8dff : Adapter ROM
> 000c9000-000c9dff : Adapter ROM
> 000e0000-000fffff : Reserved
>   000f0000-000fffff : System ROM
> 00100000-6984ffff : System RAM
> 69850000-6c1f8fff : Reserved
>   6b1dd018-6b1dd018 : APEI ERST
>   6b1dd01c-6b1dd021 : APEI ERST
>   6b1dd028-6b1dd039 : APEI ERST
>   6b1dd040-6b1dd04c : APEI ERST
>   6b1dd050-6b1df04f : APEI ERST
> 6c1f9000-6c322fff : System RAM
> 6c323000-6ce83fff : ACPI Non-volatile Storage
> 6ce84000-6f2fcfff : Reserved
> 6f2fd000-6f7fffff : System RAM
> 6f800000-8fffffff : Reserved
>   80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
> 90000000-9d7fffff : PCI Bus 0000:00
> fec18000-fec183ff : IOAPIC 4
>   fec20000-fec203ff : IOAPIC 5
>   fec28000-fec283ff : IOAPIC 6
>   fec30000-fec303ff : IOAPIC 7
>   fec38000-fec383ff : IOAPIC 8
> fed00000-fed003ff : HPET 0
>   fed00000-fed003ff : PNP0103:00
> fed12000-fed1200f : pnp 00:01
> fed12010-fed1201f : pnp 00:01
> fed1b000-fed1bfff : pnp 00:01
> fed20000-fed44fff : Reserved
> fed45000-fed8bfff : pnp 00:01
> fee00000-feefffff : pnp 00:01
>   fee00000-fee00fff : Local APIC
> ff000000-ffffffff : Reserved
>   ff000000-ffffffff : pnp 00:01
> 100000000-407fffffff : System RAM
> 4080000000-487fffffff : Persistent Memory             <<<  PERSISTENT MEMORY
>   4080000000-447fffffff : namespace0.0
>   4480000000-487fffffff : namespace1.0
> 4880000000-887fffffff : System RAM
>   4d15000000-4d15c031d0 : Kernel code
>   4d15c031d1-4d16387b7f : Kernel data
>   4d1692d000-4d16a82fff : Kernel bss
>
>
> Thanks,
> Rajesh
>
> -----Original Message-----
> From: Dan Williams [mailto:dan.j.williams@intel.com]
> Sent: Friday, June 19, 2020 4:34 PM
> To: Ananth, Rajesh
> Cc: linux-nvdimm@lists.01.org
> Subject: Re: Question on PMEM regions (Linux 4.9 Kernel & above)
>
> SMART Modular Security Checkpoint: External email. Please make sure you trust this source before clicking links or opening attachments.
>
> On Fri, Jun 19, 2020 at 4:18 PM Ananth, Rajesh <Rajesh.Ananth@smartm.com> wrote:
> >
> > I have a question on the default REGION creation (unlabeled NVDIMM) on the Interleave Sets.  I observe that for a Single Interleave Set, the Linux Kernels earlier to 4.9 create only one "Region0->namespace0.0" (pmem0 for the entire size), but in the later Kernels I observe for the same Interleave Set it creates "Region0->namespace0.0" and "Region1->namespace1.0" by default (pmem0, pmem1 for half the size of the Interleave set).
> >
> > I don't have any explicit labels created using the ndctl utilities. I just plug-in the fresh NVDIMM modules like I always do.
> >
> > I searched for and found the relevant information on that front regarding the nd_pmem driver and the support for multiple pmem namespaces.  I am wondering whether is there a way I could -- through Kernel Parameters or something -- get the default behavior the same as it existed before Kernel 4.9 driver changes.
>
> How is your platform BIOS indicating the persistent memory range? I
> suspect you might be using the non-standard Type-12 memory hack and
> are hitting this issue:
>
> 23446cb66c07 x86/e820: Don't merge consecutive E820_PRAM ranges
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=23446cb66c07
>
> For it to show up as one range the BIOS needs to tell Linux that it is
> one coherent range. You can force the kernel to override the BIOS
> provided memory map with the memmap= parameter. Some details of that
> here:
>
> https://nvdimm.wiki.kernel.org/how_to_choose_the_correct_memmap_kernel_parameter_for_pmem_on_your_system
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
