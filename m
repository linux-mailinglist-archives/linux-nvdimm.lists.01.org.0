Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789893412AC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Mar 2021 03:18:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D55A1100F2265;
	Thu, 18 Mar 2021 19:18:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.71.158.65; helo=esa20.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C00F0100EB345
	for <linux-nvdimm@lists.01.org>; Thu, 18 Mar 2021 19:17:57 -0700 (PDT)
IronPort-SDR: zPm2+2pF97Uawy83ONfC05LFNPRQ36uG/xzkeleXDHb8tgMwe9a0MF8/bAQoZt55tjF6IcxVAm
 Zg3OlWY89fu5rjmF6q2P5WwFkeTWR5MBFWVkE0RSVI8B6Zjja3qpmZ5L8TPioLMu+pzRZMLC28
 gO0vOR+71Q4CDdrNuUBJRyIBCCRhBD4mM1EchbSWaHxebOA4rcyK6z3CmaTGPoERzWV+fRhEuk
 5HGWnOnUU7AXzaRZsvy81/1KUA0jD3FpxhbPL6rZAvHEFm9dTZ5pwBnBNbzi/7Ys9aco06FjOI
 WBg=
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="28071189"
X-IronPort-AV: E=Sophos;i="5.81,259,1610377200";
   d="scan'208";a="28071189"
Received: from mail-os2jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 11:17:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fw8x9liisHjDbNdOVf7KubHN84gYArYeojF6mbDC469R6yd2wjtfFQu45RKckm+qaF4+QMo98Npe86NmN0vn5ho6D+ixZsSYxPUN1ti8GGUp5wMziaAzo/JQ0Qs3EB2g6ytIzidhdfpGjVcl1RW3/TDkDd5v0CWRjErqJLHAYEba9NV8qZXA/xnK8PHk26KhAqqY8WHiGbefbbjZrJf7FiHabIDPI1v/r8tZC15sn+aQtMlx0JX41/oGvuaAG4EjRBbCvRnSbrdc3jVAH/ueedpcAPlBiImXlSTnNmiwvCJOpL72ngRP/Dbj5Fq/HG8nhvqj4xgdD7V1VkhohK/WGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F4LqsAZPiy6OnHttdKA01dvnBJHXapPoQs/RrbEhJM=;
 b=NW/ZnZdC8SQ87z2X0pz8gcgD//kTmEQHG7yTGertbiBFaoQ03qcdv6mSWob4Fjy0neDBSjVGy+Z8qFgAskSaz0t2UgVZ1PWYgwdBmPjVvm3lpL6QG+ON0OmSgGF2zHofvPYDBQcpvD6op09A/mEACncYkEZ1/C6+ZNzhS1wZQBsHtPuxaNH+djevB7AYQI5Fm1dvL3ltSIR7NPw/tleJWS0pLleMm2egOyDZZi8UKjLBHZRRy0/gZ3UkO7Ja0slTvh1AJdAOGy/mCzDfJgQf8EhH8MCVU8jpRNPavruPArc1tNKmaV+RpbOYKMKXTtfL7TZAr+9S7dBsUmtStIBfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F4LqsAZPiy6OnHttdKA01dvnBJHXapPoQs/RrbEhJM=;
 b=ceVO6aQc1xxsWzP4nfvrooZ3h6Et915Nh3cjWslmt9wbMYdyj80d+DSR3LCDXozbTUoIblkYbnJrhNgK0yoDjz/aB5XXeFUvfz66tbLAXP6M/ZXZhGNw13fFdBaB5GA0LeRrnADGEHKwnRq3RFXPpyeDN1yJ085inamQuAcu1iI=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS0PR01MB5586.jpnprd01.prod.outlook.com (2603:1096:604:bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 02:17:49 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::68f4:1e20:827c:a2ca]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::68f4:1e20:827c:a2ca%4]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 02:17:49 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>, Dan Williams
	<dan.j.williams@intel.com>
Subject: RE: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Topic: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Index: 
 AQHW/gjzAa5hnh6PaUq187fVBTbxkqp3lL+AgAIDAHSAACKcgIAARgh1gACNxwCABb8rEIAKgTOg
Date: Fri, 19 Mar 2021 02:17:49 +0000
Message-ID: 
 <OSBPR01MB29208779955B49F84D857F80F4689@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com>
 <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
 <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com>
 <OSBPR01MB29203F891F9584CC53616FB8F4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4gn_AvT6BA7g4jLKRFODSpt7_ORowVd3KgyWxyaFG0k9g@mail.gmail.com>
 <OSBPR01MB2920E46CBE4816CDF711E004F46F9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB2920E46CBE4816CDF711E004F46F9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fc31437-9f03-4cca-a5a2-08d8ea7d31ae
x-ms-traffictypediagnostic: OS0PR01MB5586:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OS0PR01MB558677EF19197E54EB7615EBF4689@OS0PR01MB5586.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6rqyAY+ZpT6uZj2rIajFHn8MhSqCsNudK7LVXsCrUzKZmi4FkqNcK+hnsImJsenvWK+B5uTfULNcXwECr0ZMSNffBw6YRUTb3WW1VXxi7QNk1YL0mcAA44JcGIvXC0MBNZ0u72Q947YcnmJWdbwNqSqQuGpIlGrBZRpM5WTCsqeJKovr5ok7Vhu0ggSiKWhFzpfgVZytPHtRSAfaZqBXPJbNMjnfomthuowqT5pEGe5XbngWiYAQCPpZMcYIWVIw2MKfJ4rUkG+r2lNX5kVrbRyPx9nujEm8dISOCEMuim5tOuHmexH+cSpP/hQtrRbXnbhOma6ru39aAPxFCOXrIOBLG40xfylaaPHMN9FXfxTWDpomBnBxlBA8n0F8AAbKQdtLqxTx2UxSijWlGnYcep7p46/PDHDqJFJnKK++lBOmG+uRamir40Q1da5VNQQQk0tboGuc0BmmOD8za9y/gyXyLrBgUZ/mebfvOFym+cTJ2I+vToXEPV9ir+aWEq4RxhY21H8MtfCtchIMcJYEG/4Nu5pH+AciZgFQw0YvOx06Z+2Rlx/kum/7NBapH1OmYsckb1ygEYHLYNLKlsYczc1jZDsH2GyDJ817uqEuk5U+wF47eYk3FtA5U7F/JHktIjVnwu7SJIqbMAB0L1ExNit/xkRMq67v+IXcEzAru6Y=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(5660300002)(83380400001)(26005)(85182001)(71200400001)(7696005)(6506007)(186003)(86362001)(107886003)(66556008)(55016002)(38100700001)(54906003)(8936002)(64756008)(66946007)(9686003)(66446008)(2906002)(110136005)(33656002)(316002)(7416002)(66476007)(4326008)(478600001)(76116006)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?MUg3ek5qR0dLeU12L2FWam1waVYvTjRzQ2x3TFFTLzFEOU4yTmN4MGpscS9s?=
 =?gb2312?B?Rk15QmsxYzJ0NmJabCs0OXlzL1cwY0pIakdWZDUzSTl2Y1pKUHpCeDhST0Z2?=
 =?gb2312?B?Rnd5L0xzbXlRVGdMWGlxdXVVMzRXVFgzMWx6WlVOWU50dDFTcnpZQ1g3aElt?=
 =?gb2312?B?cXVvSy9BNG9MSXM0Mkp3bWVSOW9XSVZIN1d0NzZpSy9XaEVKQnhpNXJVRUJR?=
 =?gb2312?B?cDhnb1RwMlhnd3Y2YzIvNjFtbjNnUFdMdmZnRkJDRkdxREtUbFJEMjFBTEFn?=
 =?gb2312?B?bnVNSThEbFFlYWs0UUlRS2JpZVNuMjFHUmZDUXU3R3gzRXlPSWN2cXlWSFly?=
 =?gb2312?B?VE5Fc2djalM2L0c5b1JYQ2hvK0d3NXN6TjBGMEVjVCtRYkVpbm1PbFVidkhG?=
 =?gb2312?B?S3ZETGlsc3dxdDF0NUtJUHoySElxOU8xSG1ESmgvNDh4QkFrMVlNSWw3VXhs?=
 =?gb2312?B?SE9iTEpPWFhiSlpScHZmbGI3b0M4K3gxVEdXL2tnVE5vM01KcUFISkpKejF2?=
 =?gb2312?B?aGVXUG1paDZTUVc1YmIwc3BLVTREMjRCOXZ6WTExY0hGRklQbUVEOTVNVzJp?=
 =?gb2312?B?YlN6dXdaYS9Gd2Y4enBsQmY2cklITkhOa3VHd3RlblhXam0wMWRZOFRzUFpi?=
 =?gb2312?B?NUNNOGFkOURWSEQ3d3dldW03QktJZ3Y1ZU9TRlpLY3ZpZCt2aThSNGZiOTlD?=
 =?gb2312?B?Z2tzdXlJQzRPY1pwai9QVjVsZWVaUlZ4cUpPSjRwWVdjemppYlR2c2gwK0da?=
 =?gb2312?B?ZEVLMUFYOUZ2L0w0WjF1UFlLVHROdWFUVHdWMlllUnBHNDkxS0Q0MXh6TWVD?=
 =?gb2312?B?Yk5rN1JzRVBMbVNkY2t2dWV0N2tqdXRGK3Z0WVNrblRDMDdqTGw0b2UzL0ND?=
 =?gb2312?B?MFRKaDFNYVVjbUpUdE9UNU8yTy9GTHFMT2tNUTRVSjBEZjlERnB1SFFkUDc2?=
 =?gb2312?B?NER5ZS9QTGtXZEdBSVlqcnpySStmNnZvNTVLNVRMenI0Y1hPNmxaQi9OMmpj?=
 =?gb2312?B?cW1pbXEzSklJSzl5TWtvL04zUWdBRTl5M0FVSGhHdVVIcjVmUFlGZjJhVW9j?=
 =?gb2312?B?N2hOYkNSbTlmSDdpTERlcTVIWURMRUVjU0FhVG1JWXdGemNzb0ZtRWpqOU5H?=
 =?gb2312?B?d1dOZTVxWmF6TjZkWXRaUnNhSnlsTzdwS2xXbFhuUHYyelZQRTBtTFV0NS8w?=
 =?gb2312?B?d0tjT2gvU3NaVzVZelRSQkRXYzM5aDA0QzdBYzU2V2twemlWaEw3YVIxOW1X?=
 =?gb2312?B?MGZndDVoTGpJSnJSZlNnOXc3TWxCdzYwYmRtZW5haXA3VTdjTXpRNnp2RlI2?=
 =?gb2312?B?NDFNei8vYlNZdHh4S1B5SDdBTlJpSjBjRHlXZEg3TmllbGV4Rytib3hYQU9M?=
 =?gb2312?B?SWtkVXk4QStDOGNrRHJsUWEyWnhHMCt4L3pPQ3BQdkpGUlZJNENYTWFHYy90?=
 =?gb2312?B?dzZSWnlMVXkvNHFIMkd5dzFweUlYZTcrdE1nNTIyTDBPaEt2RnQvdmJ1dlZZ?=
 =?gb2312?B?OGRUNjBBazRGeDRuaDBETHJsRkxRZTJpYXREd2pMYWxOOHQ0dE5jVm5FSjh4?=
 =?gb2312?B?dDY3OVhKT1crdnNRTFpsVHVxOE5Wc1lFd2lWQVYyTERiRVhiUVdTZCtJZUFF?=
 =?gb2312?B?MnJHbUtIUU5MV2dEZllBQWx1cWl2VVFLRUZUM051UTlEM2YydlFXbENaQ3pr?=
 =?gb2312?B?Zmo2THZmdHNsMGU3WHBNcURyUHFmeWN5MjB3bEJWZHRLU3NOV0diQ2MxZ2FZ?=
 =?gb2312?Q?nPgsR0DuoBaYxdbSnhkgVB/pG+FMz7qWIWMESSN?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc31437-9f03-4cca-a5a2-08d8ea7d31ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 02:17:49.7406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9NWQbpQ6JT53B9DiakKDwOlCjixYEn4XWmiNnx92zzDxiaxyZy9GfBCzc+YRrDbHUUkZ9QegUj/cVDrNg1e3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5586
Message-ID-Hash: OGALCC4IXGXMPRP3JTLHSUCDIEC5OHY6
X-Message-ID-Hash: OGALCC4IXGXMPRP3JTLHSUCDIEC5OHY6
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, device-mapper development <dm-devel@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Goldwyn Rodrigues <rgoldwyn@suse.de>, "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>, "y-goto@fujitsu.com" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T6UD2YP4K7XHWC4YWTKMBNQU5QMFEAU7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: ruansy.fnst@fujitsu.com <ruansy.fnst@fujitsu.com>
> Subject: RE: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
> > > > > >
> > > > > > After the conversation with Dave I don't see the point of this.
> > > > > > If there is a memory_failure() on a page, why not just call
> > > > > > memory_failure()? That already knows how to find the inode and
> > > > > > the filesystem can be notified from there.
> > > > >
> > > > > We want memory_failure() supports reflinked files.  In this
> > > > > case, we are not able to track multiple files from a page(this
> > > > > broken
> > > > > page) because
> > > > > page->mapping,page->index can only track one file.  Thus, I
> > > > > page->introduce this
> > > > > ->memory_failure() implemented in pmem driver, to call
> > > > > ->->corrupted_range()
> > > > > upper level to upper level, and finally find out files who are
> > > > > using(mmapping) this page.
> > > > >
> > > >
> > > > I know the motivation, but this implementation seems backwards.
> > > > It's already the case that memory_failure() looks up the
> > > > address_space associated with a mapping. From there I would expect
> > > > a new 'struct address_space_operations' op to let the fs handle
> > > > the case when there are multiple address_spaces associated with a given
> file.
> > > >
> > >
> > > Let me think about it.  In this way, we
> > >     1. associate file mapping with dax page in dax page fault;
> >
> > I think this needs to be a new type of association that proxies the
> > representation of the reflink across all involved address_spaces.
> >
> > >     2. iterate files reflinked to notify `kill processes signal` by the
> > >           new address_space_operation;
> > >     3. re-associate to another reflinked file mapping when unmmaping
> > >         (rmap qeury in filesystem to get the another file).
> >
> > Perhaps the proxy object is reference counted per-ref-link. It seems
> > error prone to keep changing the association of the pfn while the reflink is
> in-tact.
> Hi, Dan
> 
> I think my early rfc patchset was implemented in this way:
>  - Create a per-page 'dax-rmap tree' to store each reflinked file's (mapping,
> offset) when causing dax page fault.
>  - Mount this tree on page->zone_device_data which is not used in fsdax, so
> that we can iterate reflinked file mappings in memory_failure() easily.
> In my understanding, the dax-rmap tree is the proxy object you mentioned.  If
> so, I have to say, this method was rejected. Because this will cause huge
> overhead in some case that every dax page have one dax-rmap tree.
> 

Hi, Dan

How do you think about this?  I am still confused.  Could you give me some advice?


--
Thanks,
Ruan Shiyang.

> 
> --
> Thanks,
> Ruan Shiyang.
> >
> > > It did not handle those dax pages are not in use, because their
> > > ->mapping are not associated to any file.  I didn't think it through
> > > until reading your conversation.  Here is my understanding: this
> > > case should be handled by badblock mechanism in pmem driver.  This
> > > badblock mechanism will call
> > > ->corrupted_range() to tell filesystem to repaire the data if possible.
> >
> > There are 2 types of notifications. There are badblocks discovered by
> > the driver (see notify_pmem()) and there are memory_failures()
> > signalled by the CPU machine-check handler, or the platform BIOS. In
> > the case of badblocks that needs to be information considered by the
> > fs block allocator to avoid / try-to-repair badblocks on allocate, and
> > to allow listing damaged files that need repair. The memory_failure()
> > notification needs immediate handling to tear down mappings to that
> > pfn and signal processes that have consumed it with
> > SIGBUS-action-required. Processes that have the poison mapped, but have not
> consumed it receive SIGBUS-action-optional.
> >
> > > So, we split it into two parts.  And dax device and block device
> > > won't be
> > mixed
> > > up again.   Is my understanding right?
> >
> > Right, it's only the filesystem that knows that the block_device and
> > the dax_device alias data at the same logical offset. The requirements
> > for sector error handling and page error handling are separate like
> > block_device_operations and dax_operations.
> >
> > > But the solution above is to solve the hwpoison on one or couple
> > > pages, which happens rarely(I think).  Do the 'pmem remove'
> > > operation
> > cause hwpoison too?
> > > Call memory_failure() so many times?  I havn't understood this yet.
> >
> > I'm working on a patch here to call memory_failure() on a wide range
> > for the surprise remove of a dax_device while a filesystem might be
> > mounted. It won't be efficient, but there is no other way to notify
> > the kernel that it needs to immediately stop referencing a page.
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org To unsubscribe send an
> email to linux-nvdimm-leave@lists.01.org
> 

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
