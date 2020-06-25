Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631AE20986A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Jun 2020 04:16:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B502710FCD5CA;
	Wed, 24 Jun 2020 19:16:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.140.43; helo=jpn01-ty1-obe.outbound.protection.outlook.com; envelope-from=naoya.horiguchi@nec.com; receiver=<UNKNOWN> 
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (mail-eopbgr1400043.outbound.protection.outlook.com [40.107.140.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8345810FCD5CA
	for <linux-nvdimm@lists.01.org>; Wed, 24 Jun 2020 19:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9OnyzQ9HOZrSsNo9TJ8ZpOLzaM8qC3h4tjpW1z9NL4QGLPFYjsBdTi71KDySfEg3WKUE9txCFcivMqCH6BO/IgL4D5jq55YSRyYiyq93+c+M8ZViP9z4ud8KdFeiVKvRYNi3nxencNPGTfH1Fuhaxl6v3jLsqRYFt4xxl/Mf9Gm78eRB7Wdlhtd1Wg+RavZkZkSLVRbgV9umJEM19n6hy+PrV9eR8Ay4z9OdQWbRNQattMx8yrpckDwfNX895AWt8x1gWr/fc/q/AwLWPvjH0YPWfdm73dgB1uNgUqjHg9lMAuSuPqryRzvMuEsWXR3lUeYIRbpFsyuA5SKqhGL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN+9oBK+Gzj5d84+9f1X9XkuAmr7dVwjxciP1m/OlMw=;
 b=Y6mClWZ6Vxxgvk3yylWAnOn+b/TAmvsV/IyY0A9Y1vrNTfSuVAj5NBuOrXBm8A97zlzXXsebpqXURchim88D3h71l6WQnUkPEm5RMhOSY4hbRFpMPXVfZBsb0Z9s8fY3o0k+gi/IheVBYwjvv7rqUW5MwyY2YEE00hLtfas+kcz4gTQaoZGgN3b0oDlDNgR2teeEb6+z+Mdc+2+PQZGzg1P/Yh08jf9/Iq7puRbc+WVwfjSB8On4sxmOiTE+FAL9fKMGRbOk/Y9/61gf2zOl6vuFvCX7kBD+6mdUm2cXBSEbhGklXUiwGPJwhCVaKAFX+aOcmzbQNPmiIBrKhj90qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN+9oBK+Gzj5d84+9f1X9XkuAmr7dVwjxciP1m/OlMw=;
 b=pQCNbQJLR1M9SEu30g3Ma1XUswZUkGTBefCggGjHKzOkH1CdFo2pfWjB0/pmoUUPOINOAEmGFVICH5H9mgEitqbFn46L0gnPYKjfq/vqbEMUUQwmY3PdPsnQ8tHNye6UDdY4X5OB20fAIFkMMN2yZwuC3uPQt+Frgiz3sN79bno=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYAPR01MB5452.jpnprd01.prod.outlook.com (2603:1096:404:803d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 25 Jun
 2020 02:16:42 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58%5]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 02:16:42 +0000
From: =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?=
	<naoya.horiguchi@nec.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [RFC] Make the memory failure blast radius more precise
Thread-Topic: [RFC] Make the memory failure blast radius more precise
Thread-Index: AQHWSZt3qNTHVUr/sEmZKbB8SUspNajmwT0AgABsioCAAWxVgA==
Date: Thu, 25 Jun 2020 02:16:42 +0000
Message-ID: <20200625021641.GA21811@hori.linux.bs1.fc.nec.co.jp>
References: <20200623201745.GG21350@casper.infradead.org>
 <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
 <alpine.DEB.2.22.394.2006232114100.97817@chino.kir.corp.google.com>
In-Reply-To: 
 <alpine.DEB.2.22.394.2006232114100.97817@chino.kir.corp.google.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c949bdc3-24f2-47c5-02c9-08d818adcd2c
x-ms-traffictypediagnostic: TYAPR01MB5452:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TYAPR01MB545247C6294074D473AEB312E7920@TYAPR01MB5452.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZQ16/yKBgCnCWlKJBVXLfd+Q6Lz/JZzCR0mkSkLoS8E7NkAY4egFdp0+UUH6zsc7wHx3tdxbuXYbgLFE4gpLjCm1+iGauObko578DLDBN8CKPNGpVY3kTqGexwKnD2Zi5jTHp8AimxOSxbrJPROHnMXq+4cDsyUq8HG0pMYrawvmo5DAz+N1wVl6BNGH/iE+9luQALUVVgXj3iELTFT6+abldBdmDxdavarkTSAy6uYgSdEcYimrRPVkYAtsFC/OC5HCl0uuBDz+k0ttqvh61T9u0twHtR8U9KA4/9d52+1DMSb2+xlWZC+XBLlkxNPfEWNru5lpaflGEHASmzqWAw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(66446008)(5660300002)(8676002)(66476007)(7416002)(66556008)(64756008)(66946007)(54906003)(478600001)(8936002)(55236004)(1076003)(71200400001)(316002)(85182001)(86362001)(33656002)(2906002)(4326008)(76116006)(186003)(9686003)(6506007)(6512007)(26005)(6916009)(6486002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 WvVKwgTIwJ/dKZBdAXPen6gmXvMH9J2jO4cchJWoaMewQrAfngEAAvlozJtfQHM8WjRPmvdYojsBpcaPHqqREv04wpxk8DH7x/SKB759qxXJImGgOQEzQU43z02+7QxHJAirKFnHJdXdI8Hly84fATPllFGgCENYy1ptNu0dEgbKHXdNcAkjdXyCStjVMmkkChgfmeKf2u9Ibfuv6bqTghgx6LAREVp2flqXUGPJluRkJmTvzEhAyZrPzVpu92GMFQqcKapI33dKMg4xSvtvpskc6Bks1HFFRRy4CuyGfVTopkRuEmaGo3LetJkcF6mxYojdArqqDG8ZqWLi9nfsUGZrLE+q257OvmTSPuHYLqeKO5WY6dUsrwTxeRSEM8N2p0JDcZAjC+aMEAlf4nSNeApYxJ1ApuA9LJ++Py6HNAzx2hhu6otDl7JcBdhaArOZzjubreLe+KDSpnGCtPdREJXP/AEN6mSbKzclQl5y2dz0EOkv45iWTFqMd+q9/vd8
Content-ID: <B9AE754C81838545900FAB82053D93BD@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c949bdc3-24f2-47c5-02c9-08d818adcd2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 02:16:42.2678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yiuPl0Arpu64Vo5JL2glirCGaAA+j8SzCpg82a1f/3rT7dU7OU9T7S91lXdMTpfElGzRmmburXohEY7Qxx/8aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5452
Message-ID-Hash: HX2TE2DQFYSZNZDHJK54C42FE27RNCJZ
X-Message-ID-Hash: HX2TE2DQFYSZNZDHJK54C42FE27RNCJZ
X-MailFrom: naoya.horiguchi@nec.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Luck, Tony" <tony.luck@intel.com>, Mike Kravetz <mike.kravetz@oracle.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Matthew Wilcox <willy@infradead.org>, Borislav Petkov <bp@alien8.de>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Darrick J. Wong" <darrick.wong@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HX2TE2DQFYSZNZDHJK54C42FE27RNCJZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 23, 2020 at 09:32:41PM -0700, David Rientjes wrote:
> On Tue, 23 Jun 2020, Luck, Tony wrote:
> 
> > > Hardware actually tells us the blast radius of the error, but we ignore
> > > it and take out the entire page.  We've had a customer request to know
> > > exactly how much of the page is damaged so they can avoid reconstructing
> > > an entire 2MB page if only a single cacheline is damaged.
> > > 
> > > This is only a strawman that I did in an hour or two; I'd appreciate
> > > architectural-level feedback.  Should I just convert memory_failure() to
> > > always take an address & granularity?  Should I create a struct to pass
> > > around (page, phys, granularity) instead of reconstructing the missing
> > > pieces in half a dozen functions?  Is this functionality welcome at all,
> > > or is the risk of upsetting applications which expect at least a page
> > > of granularity too high?
> > 
> > What is the interface to these applications that want finer granularity?
> > 
> > Current code does very poorly with hugetlbfs pages ... user loses the
> > whole 2 MB or 1GB. That's just silly (though I've been told that it is
> > hard to fix because allowing a hugetlbfs page to be broken up at an arbitrary
> > time as the result of a mahcine check means that the kernel needs locking
> > around a bunch of fas paths that currently assume that a huge page will
> > stay being a huge page).
> > 
> 
> Thanks for bringing this up, Tony.  Mike Kravetz pointed me to this thread 
> (thanks Mike!) so let's add him in explicitly as well as Andrea, Peter, 
> and David from Red Hat who we've been discussing an idea with that may 
> introduce exactly this needed support but for different purposes :)  The 
> timing of this thread is _uncanny_.
> 
> To improve the performance of userfaultfd for the purposes of post-copy 
> live migration we need to reduce the granularity in which pages are 
> migrated; we're looking at this from a 1GB gigantic page perspective but 
> the same arguments can likely be had for 2MB hugepages as well.  1GB pages 
> are too much of a bottleneck and, as you bring up, 1GB is simply too much 
> memory to poison :)  We don't have 1GB thp support so the big idea was to 
> introduce thp-like DoubleMap support into hugetlbfs for the purposes of 
> post-copy live migration and then I had the idea that this could be 
> extended to memory failure as well.
> 
> (We don't see the lack of 1GB thp here as a deficiency for anything other 
> than these two issues, hugetlb provides strong guarantees.)
> 
> I don't want to hijack Matthew's thread which is primarily about DAX, but 
> did get intrigued by your concerns about hugetlbfs page poisoning.  We can 
> fork the thread off here to discuss only the hugetlb application of this 
> if it makes sense to you or you'd like to collaborate on it as well.
> 
> The DoubleMap support would allow us to map the 1GB gigantic pages with 
> the PUD and the PMDs as well (and, further, the 2MB hugepages with the PMD 
> and PTEs) so that we can copy fragments into PMDs or PTEs and we don't 
> need to migrate the entire gigantic page.  Any access triggers #PF through 
> hugetlb_no_page() -> handle_userfault() which would trigger another 
> UFFDIO_COPY and map another fragment.
>
> Assume a world where this DoubleMap support already exists for hugetlb 
> pages today and all the invariants including page migration are fixed up 
> (since a PTE can now map a hugetlb page and a PMD can now map a gigantic 
> hugetlb page).  It *seems* like we'd be able to reduce the blast radius 
> here too on a hard memory failure: dissolve the gigantic page in place, 
> SIGBUS/SIGKILL on the bad PMD or PTE, and avoid poisoning the head of the 
> hugetlb page.  We agree that poisoning this large amount of memory is not 
> ideal :)
> 
> Anyway, this was some brainstorming that I was doing with Mike and the 
> others based on the idea of using DoubleMap support for post-copy live 
> migration.  If you would be interested or would like to collaborate on 
> it, we'd love to talk.

Thanks for proposing. I think that DoubleMap support could be a good
solution generally (not only for the usecase of post-copy live migration).
Splitting pud/pmd entry into pmd/pte entry makes smaller impact than migrating
all healthy data to somewhere else.  The implementation could be challenging
but not so as thp splitting because we don't have to consider collapsing.

Dax mapping seems to have similar issue. If we can share pmd mapping and pte
mapping to a dax file and covert the pmd mapping into pte mapping, we could
contain errors in smaller granularity for pmem.

Thanks,
Naoya Horiguchi
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
