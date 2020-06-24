Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CEE2079AB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jun 2020 18:56:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B435510FC546F;
	Wed, 24 Jun 2020 09:56:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.223.51; helo=nam11-dm6-obe.outbound.protection.outlook.com; envelope-from=rajesh.ananth@smartm.com; receiver=<UNKNOWN> 
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 80E8510FC546F
	for <linux-nvdimm@lists.01.org>; Wed, 24 Jun 2020 09:56:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWpsVkFmFcSiqTpo7p+TLhUld3DFuxvrtH1o7dttY38SpMfHkkyb2J5rpjcCPgiR4d26B73BRop0aqsmBvLmlGsNrH5tILq9qpPkaHrPvqsYkHflLj9QSYvT2SUQ81rm8bvlRX25dHGz6Mot1G+r6vlGpOAsHlmkz+3gnDQYU7fukDNtd/iTxkQBt0M2ah5dlojx+kJnRFqTFVSwnMzuD67FP7CmWg94HdrerlFs6YCvlx6sFQTTxUvgIJCErKLUQnKWw9wGv9aQa4kVhyZft6iMeFV/tD60iOZFAMZhHWylHBc+Zg6yIzdcfxDoCqmoYik250dXdpPR7imwrpAhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eV+Zup60HHp0AtJFuDC3FFzPaizj+D3TVzPm+3mL4qk=;
 b=fQz2es5yXKdc9nLDTySHJRvIysgBCkh+IRhos4v7x7y5mGX+hf7boOsxILsOYXAJC0aHWHkTBUwyxpN+EOF9D+tTDGYY0E+aL5CsP2q2viP0Ur8QfVXsmXTKOBkWXymqMAfeCll93W4AcALsyIsn5mk+dIOe4p3lDkQdRs+RI1RUhxBXqCAhBYdnmmRDflrC5Fug8AqaGCbXuyn8hknd2yvedbpmdKKxq1WTlUzHwUkknpZ7cXvb9x/CHZkYDltAmNeGZa9UyaHb9NEJ6QLgpdnpGcs/egtiLwtvCYckVFlweBqlnCw7nJz7v42JuoiD+gSsO8cb9UY7XARfyFwHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=smartm.com; dmarc=pass action=none header.from=smartm.com;
 dkim=pass header.d=smartm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smartm.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eV+Zup60HHp0AtJFuDC3FFzPaizj+D3TVzPm+3mL4qk=;
 b=ROtjFs32tIsV8PXloDJF0v5BZbUsj1eyfWgzA/wVZl4qkHf+pMJ8igJmM3plFmm1jYMJMz5AhAwrW3GxrGLGrWZk9U5uSIkyTJ0R3ZqngVrAns5CKY1MZAvxT1u9vTCa443G6xD72ICfhI7aeecAbenCPpdU8Rq4chtuXuTsHQI=
Received: from BYAPR04MB4310.namprd04.prod.outlook.com (2603:10b6:a02:f0::13)
 by BYAPR04MB5816.namprd04.prod.outlook.com (2603:10b6:a03:10e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Wed, 24 Jun
 2020 16:56:35 +0000
Received: from BYAPR04MB4310.namprd04.prod.outlook.com
 ([fe80::c9ea:3cc4:bce4:44ea]) by BYAPR04MB4310.namprd04.prod.outlook.com
 ([fe80::c9ea:3cc4:bce4:44ea%7]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 16:56:35 +0000
From: "Ananth, Rajesh" <Rajesh.Ananth@smartm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: RE: Question on PMEM regions (Linux 4.9 Kernel & above)
Thread-Topic: Question on PMEM regions (Linux 4.9 Kernel & above)
Thread-Index: 
 AdZGj7xlb1bNOIhzRnee4sCHW/WtkQAAmrCAAAAutkAAASDdgAADMNMAAANhXgAA5ZJXkA==
Date: Wed, 24 Jun 2020 16:56:34 +0000
Message-ID: 
 <BYAPR04MB4310ECFFE5328E80E8DF5CDB94950@BYAPR04MB4310.namprd04.prod.outlook.com>
References: 
 <BYAPR04MB4310650471DD3C25D77BEA6394980@BYAPR04MB4310.namprd04.prod.outlook.com>
 <CAPcyv4jDgD82S9VHWb-P5iP+UH-gqdsYcNmA=aMFNhKrdSEUqg@mail.gmail.com>
 <BYAPR04MB4310B8A76F318E50237447E294980@BYAPR04MB4310.namprd04.prod.outlook.com>
 <CAPcyv4gLX1p5Amz_9V7SGurX+aTQfmPdTp8DSTm53u2Qgtgj=A@mail.gmail.com>
 <BYAPR04MB4310B35B8E6A7D66DEB78C0194990@BYAPR04MB4310.namprd04.prod.outlook.com>
 <CAPcyv4g3dtqL6SUfwVd7L6h-pFM+wgJYAXBBaRLq447zdHrtAQ@mail.gmail.com>
In-Reply-To: 
 <CAPcyv4g3dtqL6SUfwVd7L6h-pFM+wgJYAXBBaRLq447zdHrtAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=smartm.com;
x-originating-ip: [65.249.22.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34224011-7713-48ba-b20f-08d8185f8da1
x-ms-traffictypediagnostic: BYAPR04MB5816:
x-microsoft-antispam-prvs: 
 <BYAPR04MB581659B470144E07CFF30EF894950@BYAPR04MB5816.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lThdFEPIzj9TiXgHdQoMZPK1RkhtK25fRy/LxDzCGvZtAxzN4JTto5FX2GvkawodjvcS0ZOKPlDkV17s2cCgJ8S70dO0OAaf1GlZ9bVeoH2/2NKq//aLS6KvRvbi9ywBrD/X2m/l1ZHZCRr+13YGqpLwafiAbzTa4nbtSkOZsBLS1kT8d0Q2az7t0VuiqQbHzdlzV74vuhCEp3qdc7C1zx8cpfIW0KiRlv/J39PKN9TMWiA8DklUuHyWnhxnFxazhCzoiqjy5l6s8aMxUaVMTODukrgdsX8OEzberOxnUi6qWQDFV+5B9QDun2tTjb1ZrjLy3ywychBqg7/mIczvlw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4310.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39850400004)(366004)(376002)(136003)(346002)(8936002)(316002)(186003)(8676002)(26005)(6916009)(6506007)(71200400001)(9686003)(55016002)(66446008)(53546011)(66946007)(64756008)(76116006)(83380400001)(7696005)(4326008)(2906002)(66556008)(86362001)(66476007)(5660300002)(33656002)(52536014)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 UU0OVZZTat0BAdRfqTqeeqM5eALlb9PZ9GqdIl01pIAdaveTbOIUaatfDCVqBRWB2HoXO99PA4vE2xc/NG+nMqBiagUmFGmzopEZk2WTWgtMSgED3Khlszmu6PVyaQ1GwSXY/O9+CMaaUGM0S2onu5rTazYxDmIlBprMqjirYC0SWmYL2UJyrWmr2ljd6VmiZISyvssrrNs0uPqvyp4CQhFwCdv4uzwo4+60PMLIeqt+6Q39GePwjdAQjA/aIkKWAIHnLy75H68LhAARhAJkklXYP2ZpO6O4esqsjvuAJITiPgDFXUp5utFwmRcbOE02O+S9CQD9RINyZGFnBKGhd5UFimAb3oH62RzzHyhYKcpWbSf2sJCYeGqqQc4//Vw94PfU8wL/y6k58iASehkj68gPgrIjRd50TZcaD9a+ummlh8APFDKeSBs50gahYPursytW3KyuxngF/XXb2IiHLx/hfOC033xL+FgNVmNzX+U=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: smartm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34224011-7713-48ba-b20f-08d8185f8da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 16:56:34.7550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f0fd7909-cd13-4779-b0f9-5ced6b7a2c68
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yE061X2usZUwfqbqDVV8MDINiunj2tchi9D9MgZkPmy4e4NLpc2oo/dsHELDqrvBDGBFSVBM6HEdBUGAVC48Ar+eGrhGrcDuAp7HXZLhUk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5816
Message-ID-Hash: OFLK6JJHNITCUSZZQBJQEP6IIQXXRK3X
X-Message-ID-Hash: OFLK6JJHNITCUSZZQBJQEP6IIQXXRK3X
X-MailFrom: Rajesh.Ananth@smartm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4B2EVUE2V3GVPPYK2IHW52FAHRD25U6V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thank you so much  for the details you provided.  We are working with our BIOS vendors to resolve the problem.

-Rajesh

-----Original Message-----
From: Dan Williams [mailto:dan.j.williams@intel.com] 
Sent: Friday, June 19, 2020 8:20 PM
To: Ananth, Rajesh
Cc: linux-nvdimm
Subject: Re: Question on PMEM regions (Linux 4.9 Kernel & above)

SMART Modular Security Checkpoint: External email. Please make sure you trust this source before clicking links or opening attachments.

On Fri, Jun 19, 2020 at 7:02 PM Ananth, Rajesh <Rajesh.Ananth@smartm.com> wrote:
>
> We used the Ubuntu 18.04 to get the "acpdump" outputs (This is the only complete package distribution we have. Otherwise, we use mainly the built Kernels).  The NFIT data is all valid, but somehow it is printing the "@ addresss" at the beginning as zeros.
>
> =============================  acpdump -n NFIT  ========================================
>
> NFIT @ 0x0000000000000000              <<<<  DON'T KNOW WHY.

That's fine, acpixtract was still able to convert it... I see this
from disassembling it:

acpixtract -s NFIT nfit.txt
iasl -d nft.dat
cat nfit.dsl


[000h 0000   4]                    Signature : "NFIT"    [NVDIMM
Firmware Interface Table]
[004h 0004   4]                 Table Length : 000001A4
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : 83
[00Ah 0010   6]                       Oem ID : "ALASKA"
[010h 0016   8]                 Oem Table ID : "A M I "
[018h 0024   4]                 Oem Revision : 00000002
[01Ch 0028   4]              Asl Compiler ID : "INTL"
[020h 0032   4]        Asl Compiler Revision : 20091013

[024h 0036   4]                     Reserved : 00000000

[028h 0040   2]                Subtable Type : 0000 [System Physical
Address Range]
[02Ah 0042   2]                       Length : 0038

[02Ch 0044   2]                  Range Index : 0001
[02Eh 0046   2]        Flags (decoded below) : 0002
                   Add/Online Operation Only : 0
                      Proximity Domain Valid : 1
[030h 0048   4]                     Reserved : 00000000
[034h 0052   4]             Proximity Domain : 00000000
[038h 0056  16]             Region Type GUID :
66F0D379-B4F3-4074-AC43-0D3318B78CDB
[048h 0072   8]           Address Range Base : 0000004080000000
[050h 0080   8]         Address Range Length : 0000000400000000
[058h 0088   8]         Memory Map Attribute : 0000000000008008
[..]
[0E0h 0224   2]                Subtable Type : 0000 [System Physical
Address Range]
[0E2h 0226   2]                       Length : 0038

[0E4h 0228   2]                  Range Index : 0002
[0E6h 0230   2]        Flags (decoded below) : 0002
                   Add/Online Operation Only : 0
                      Proximity Domain Valid : 1
[0E8h 0232   4]                     Reserved : 00000000
[0ECh 0236   4]             Proximity Domain : 00000000
[0F0h 0240  16]             Region Type GUID :
66F0D379-B4F3-4074-AC43-0D3318B78CDB
[100h 0256   8]           Address Range Base : 0000004480000000
[108h 0264   8]         Address Range Length : 0000000400000000
[110h 0272   8]         Memory Map Attribute : 0000000000008008


...so Linux is being handed an NFIT with 2 regions. So the 4.16
interpretation looks correct to me. Are you sure you only changed
kernel versions and did not also do a BIOS update? If not the 4.7
result looks like a bug for this NFIT.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
