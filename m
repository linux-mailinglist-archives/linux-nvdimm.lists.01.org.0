Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E55C83332BA
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Mar 2021 02:26:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C414D100EBBAF;
	Tue,  9 Mar 2021 17:26:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.159.76; helo=esa5.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 13901100EC1C6
	for <linux-nvdimm@lists.01.org>; Tue,  9 Mar 2021 17:26:26 -0800 (PST)
IronPort-SDR: LWInBUYQ8CWi3LwMRJ3fKcoaMpKZsODLPFQNfc+zqQrsrlEB83UbqF7xjYBDhuKauad6X9ylBQ
 /JgATPkW6hH3myUjERRQjy/S56pYvfwQodzdBJwDUN9wqMaaLkaJQQgwoGHJWx/pD0qQ02RdSx
 bwx+MYA8HMKeqB0WJcM2RMe+dKC9bZyrtE9OoYaBa6iQl9LZNIsZHdHgR3paR17KjQTkXUoAKD
 KucQ2DtJXCvo8HclTuba4g0/G48XCeGv26MEeytHCbBen7lmFPG9x03cNxWzL3vSNHasTUjzM7
 +a4=
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="27600398"
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200";
   d="scan'208";a="27600398"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 10:26:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3y8KvJ5D59XF6F/8DrQF8/2nYbx1drREoXTym0TGuVukB98zDJwz3YkxC+lIlO4VK7V/2l9TlUWYDJFe1QxaHfKaBxhKuw0q81uZxJNkhXyvWWu058jSMFdJt7Xjy399W/dcyPz09dl/AeyrdLJWMmCQOuIlkeqWvAO2fPa1WWrUMptUzuLf09Qc98pgtc4kRwlxRSEll7p92PuPZzAoYG58eqV5HsJbviStXxIKb6gdmUqwe0rWf01tLOvdbMGKtpj8MglFOnBkb+8oxjafAGqL/FGXnctdK4WN880Yxl7/yaaboIOeCygu34k+0L2rYrJkz0jQjYYRVCUiXUAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq9HdTG07oaMRe3NW2euFPhU/i2me455X/Evfi/9dq4=;
 b=XUwV9D6hm3xll4Ir9SDKUNIJTEEyv3ihtLgnFSxmSHpXoEh/23UDj8yGgelEbkKoebF7Cq2w4Q5zl/HRWfXtZ5jV523ZpugoIug9XnbznJrW1Bc/6t2/gyAfKjIis5TK0+bTJgzUFei7G9YBZq/Z6w1JMm/U769IZVhjJ9Ig2iko2AxL67ZM1XRRUycxsgeCWPCIPZ5HbLgsrjWyxebqxYaGMHCgykY8NucjTvuBXcxbhmDArRc09yigGUhvWZzyi9JKJhY8PP1rJtSTQqq8MjvIZvzq+TTsmtJz1kDtROW6Z2ui2Rt3iKNuk0kMTLNio7LFnvg8ihcXcQ6wJ2H+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq9HdTG07oaMRe3NW2euFPhU/i2me455X/Evfi/9dq4=;
 b=QsJzOCg6oYUlMGNp5MZ34hfbohoKdZubgsPXVCk5lyKSpE4HFMf4rKdjIkV66tzYtEO62ZfvKGz7m19edUa8mimJk9VRzhLMTI7VTXqDMCYzIbiKNiBu+WYZ/zMfH/G9n1Yssx0IF7w83eHiTUKolLFjhsGxYDWk/Y0/ZSa30No=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB6194.jpnprd01.prod.outlook.com (2603:1096:604:e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Wed, 10 Mar
 2021 01:26:19 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063%3]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 01:26:19 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Thread-Topic: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Thread-Index: AQHXC9VDEDtEjiYaB0es2cWhy94QfKp76C8AgACWrXM=
Date: Wed, 10 Mar 2021 01:26:18 +0000
Message-ID: 
 <OSBPR01MB2920E8385E22C0DBBC5283B6F4919@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: 
 <20210226002030.653855-1-ruansy.fnst@fujitsu.com>,<20210309161906.jjd7iw2y6hcst5c3@fiona>
In-Reply-To: <20210309161906.jjd7iw2y6hcst5c3@fiona>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [49.74.142.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec4afb0a-1d41-47d2-05bd-08d8e36381c3
x-ms-traffictypediagnostic: OS3PR01MB6194:
x-microsoft-antispam-prvs: 
 <OS3PR01MB6194E918B2A3C7F67C3B78C9F4919@OS3PR01MB6194.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 P+tmAtSxz7f0Fl71slNw82CjEcprY5qY8dNbGWsRRC0HKX9cIag5gV4yagxpE+DqritmQMLgamKn53ZO5NFylPf9XejLDXyp8hnxiKh7C+XYRR/YloAyLUVresYnME+7vconc/KGcjdGRJ2kejQkPjLsOCHW8V+lJcXkhovyQw+CKDexl5IexFSFp50mz0I+wnqBhpZvfxrreuI6Lbz47cm0y/Czl7mLDBQvqfeYOUlbxhw/OA9X8zlDpNE62y41ZiaMXc0sRHsQt2dQYFCGcFWf7O5PibwkTZOJFJRz3g/yR5Z6IEsEQiXkt2exPG3WuTHJ9H6mHcHoWqXnd00fGZp/mqOB3232LJh6zFrjmdwrkWBTGvanOD2oDrAmrL6H7CWsNNCgO+DmRlsgLHSOMICSRs3Eu6+8LuPJNniKn0Lrgp3Znsn3nxCHyZw95PtQjuIwtd5bJ57KI15nPUieLJynt5+4Rtz7J1fhwGHgFKX7ycsnyder4CgbKo1XsyWOiW8ESB5WED12g4GdjSMsO+DuymLg63LK7eA3Wt59Vby5zsc6f43kMEHhe4BbEceSekXrxzeSB6+Tw0HHqvaH7FzMmA/m2Bnl2Jqbp0IetmY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(64756008)(52536014)(7416002)(186003)(8936002)(26005)(2906002)(316002)(76116006)(66446008)(66946007)(478600001)(7696005)(6506007)(66556008)(33656002)(71200400001)(85182001)(4326008)(54906003)(5660300002)(4744005)(9686003)(86362001)(66476007)(8676002)(55016002)(966005)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?QmZWL2tPV3U4YldyZm1jSmRDYmZ4U0ZxVlYycjI1ekJSMEVqV0dZSnVBZ2Ja?=
 =?gb2312?B?NDRuZXV4S2dSUkNxZm9iWi9NczAxT1pYRnJ5VGRnSUI3djhNWHNOVzY3TnlC?=
 =?gb2312?B?QkVTemZjMlQxMXcydXM0T0RiN3J0cjNpODR0K20wRTB0QktWeGppQndPdkh1?=
 =?gb2312?B?WEQ3TkJFcVZHczNnMExiTlN3OEFYQUhQU3lnZDlSQlV6NWlGSFZYaFNVZWtL?=
 =?gb2312?B?WmJzT3RNNzB5OGpXYmVxcWkvTVkwcGdFOFhiUnN5c20rMFJ1TTlpN2ZMVEt3?=
 =?gb2312?B?QWlreXhYejMwR0h5N0huR0p1VDM2Q1QrT3FJdmxhSGFWSCtkYXloeWJaTUtv?=
 =?gb2312?B?S0VhVkNrUC9wZDFkQlBPV3Y0a2hiblZTdDkrelZpbG94MnpOenZFSDcybTQ5?=
 =?gb2312?B?S3JvZk9VSWxGVmdNQmllM2Z0eFdLRHZseDFXU1AwRWQ0UFlDaFN5QythV1RD?=
 =?gb2312?B?RHhzZVp4enh0aXM0Qm1MSWRRTG5ISDFiWFVrZFN0TWNiYUhaVGM5RUM3SFpz?=
 =?gb2312?B?YWFrdEdWUG9BM3ZSY1haeGNrMkFNMXVpcGdsRkIwZnhSRlJqcTJ0ZFB3VHBq?=
 =?gb2312?B?L1Z6azdIdUVIQWtlaTVCZ2xvTW85TUNCaGs3aURoM3JWczdrTVVFNVhpQm1W?=
 =?gb2312?B?ZnlXMTI1VnFnMDRycXNpMjFsdEo3QlA3MEF3TGFzNjZMKy9OYUkvWitrRE1L?=
 =?gb2312?B?MFE4MnFsQ21TZTVEV0NBRXV6WU14ajJiKzFmeU0ydWVaeGtSOUk3cTNKNkdC?=
 =?gb2312?B?aWJ1eXp0Y3BWeEE3UWowNWRKZFN6T3oyY0tQZXQvUHQ3K2dRSmxvQjlQUUtv?=
 =?gb2312?B?TWlsZlpDUWZHMXYyWmJiT0JERllNcE5ZaDZQd3NCQ3hOSE1XcE9Fb3JwQ2o0?=
 =?gb2312?B?UHl3cTBHQXdhRlBJdzhhMi9BS3lVTEI3RjQ5R3hTOXB3T01vVlVxZi9nTUxp?=
 =?gb2312?B?ZnJrS2lmRzRpcWJkZkhhanRUQWRqTFFTdFdGSXE1VFBCbjVnYmhaRVdlMlRP?=
 =?gb2312?B?Q0lGdVZnM1dYTCtPTnRnNjhwbVNOUk1mZElVNDJOa05lRmpVZFUwUjdpS2lT?=
 =?gb2312?B?RTNqcGV1YUlYaTc1RElmUG1iaG5wR3pNL3FyV21pa000ZGJrOGRIZE1zRjVr?=
 =?gb2312?B?MGtDdDJaNWVHTk9RcktWUWdnSVVPYlA4VlBrTEtIK2NadXRkWk5JT1krd3pI?=
 =?gb2312?B?alhpR1ZKQXhEejh5akJPekhDKzVJa0N5em16RnZRM05WUGgvdUcxWTN6dkJs?=
 =?gb2312?B?ZXlVR2ViT042Y2lteEUraDFIOWNPS0tRTzFPS29ZcjBScWVSNVNsMWgzbnBz?=
 =?gb2312?B?Y09TRm5QVnVMVWJhdVpjQUgybWJoN1RCd293ai8zUkZjVUlOS2VCblZmWHgv?=
 =?gb2312?B?N2poQk5VKzlaY0F5RTg5ZkhQbmVncjU3aGpTNkpWcG9JOEptN01UcUx0TGFY?=
 =?gb2312?B?bHJTVFBucmZQT2d1eXV2WUVhYS95eVhyekM5UUUwU1UyWktUa3QzR2FWaERo?=
 =?gb2312?B?aUUwakFKMkw4cVlQS2N3ZDI3WlRQL1AxU3V4ZnlXMGxxalA4V1dFOUJPT3Nn?=
 =?gb2312?B?dDRWRGJTQm84eU1ySmV2REtiMEh3Z3pWZVpWNmF0K0NEdkdGdXJJYzFXSHJs?=
 =?gb2312?B?NzNMZ1hDM09PL2dEMlpyOCsxTTM3T3FaY0IvdkcveVdibGdkdFlkVkxMdWRE?=
 =?gb2312?B?VTJlTU5zSTRMd3FiZmVXd2pNdzJyQzJzRzdUZmM2cytBZW9wV0NianZNYVY3?=
 =?gb2312?Q?M5MNbdBVpxYhQIXD6w=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4afb0a-1d41-47d2-05bd-08d8e36381c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 01:26:18.9985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aG/EIe7Du/iRN3/MVdpH16kQ5SyJ7lYd5mhwqCkHii8TlOgzclAn9Swau5XbWkWtnY0EwdNkOmDusOq+D6klkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6194
Message-ID-Hash: JIZUZYEAM4MM4UQDGFQLIAYHZSJSD2TG
X-Message-ID-Hash: JIZUZYEAM4MM4UQDGFQLIAYHZSJSD2TG
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6AEMEVIHIFFHHSMSSYGB4HK5TTLYDPY4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

>
> Hi Shiang,
> 
> Thanks for picking up this work.
> 
> On  8:20 26/02, Shiyang Ruan wrote:
> > This patchset is attempt to add CoW support for fsdax, and take XFS,
> > which has both reflink and fsdax feature, as an example.
> 
> How does this work for read sequence for two different files
> mapped to the same extent, both residing in DAX?
> 
> If two different files read the same shared extent, which file
> would resultant page->mapping->host point to?
> 
> This problem is listed as a TODO over dax_associate_entry() and is
> still not fixed.

I have posted another patchset which I called "fix dax-rmap"[1]. It is a
try to solve this problem, but still in disscussion for now.

[1] https://lkml.org/lkml/2021/2/8/347

--
Thanks,
Ruan Shiyang.

> 
> <snip>
> 
> --
> Goldwyn
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
