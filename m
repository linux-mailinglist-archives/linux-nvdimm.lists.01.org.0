Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F16B21A4EC
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jul 2020 18:35:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 86BAC1143B06E;
	Thu,  9 Jul 2020 09:35:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.6.67; helo=eur04-db3-obe.outbound.protection.outlook.com; envelope-from=jgg@mellanox.com; receiver=<UNKNOWN> 
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B249A11427DBD
	for <linux-nvdimm@lists.01.org>; Thu,  9 Jul 2020 09:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYG5juHvfkz1//BFgMW7K7ByZywRZGd48A9mCHXRt4ICGrzeCp4ZSNHRIjvsJGwh2xjPAhEe/Yruz89u0a9fBNs5HUJJe37TM2bz1xu4+jVe8hWSeLwtpUX5d+PaeTDNRb/HLWzjtfalq3fPrNGYVAxJwrSHlCfnGLnEGDzQ0IjtFaWLt8s/9gqssOQTmCRlrSZH/3gOhaYHQ7bIuVWLdN8tKouvtKjPglR4x5HkzScYHmulJnLjtCqTyAuWaxOTZF+FXyLl0P8tpGbtjS1tdoZs1WyH14qg8s5h8oPfFz+5pTQ9RbtjAezVOvHqosL29tMD34EiA5uGqxhEHndG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I3JKPOR1zH8nOihF2OFtOlnTKklEl6kb3lCDua/N98=;
 b=n83zH4Nzr85Rq0OknGDQnHQtIX3VU+hI5OK2xnfIFQBBE0b7uGiXiFz7RetX8IgrDnz6PxsP66o601kGe8ayao/nPgBCvTsG42UE0QZhTEUaS78oLnlG4S0OrhAmaou3ADpY/9nEuGuGuZkg82pK811FXNIWxhTJTSLMXymt4X6vW8i8s6xHCpMeaXdpqFfab/jB2ck7wWtlPrrKXmQki70UIf/BpYYB7u+1vk23la3YHQ+Vh4ffPuSp08BIvshnTCC079acsezv4hP/JvRa+fFtUjRg1e8JgMVtonRTyVfw+XJAFVXy9k65Q9xUZtfwhwL8QTKnmRouaOfKLVKiWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I3JKPOR1zH8nOihF2OFtOlnTKklEl6kb3lCDua/N98=;
 b=ciEH7ddfB0Kuzb93S62xe/iF4y0pBcy37RHmM8urS2phiFj2zAHxPDgDvcVKpfZ6oqTDBpkRiZMFo9AH3W6UrAd0jn+v5EYBKw4AotneszZx1a7ixDv9GaKHdjALiX7mosP9tfAKMN6CAqkDkqrJSm8UULQLFF0CuQkuPzQKVxg=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB5982.eurprd05.prod.outlook.com (2603:10a6:803:e4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 9 Jul
 2020 16:34:58 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3174.022; Thu, 9 Jul 2020
 16:34:58 +0000
Date: Thu, 9 Jul 2020 13:34:55 -0300
From: Jason Gunthorpe <jgg@mellanox.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and
 callback for firmware activation
Message-ID: <20200709163455.GA23821@mellanox.com>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200709150051.GA17342@infradead.org>
 <20200709153854.GY23821@mellanox.com>
 <CAPcyv4hSPWEUih=we5QM_rdk7fLemi8phyk8_0tOd8ieL_=vPg@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAPcyv4hSPWEUih=we5QM_rdk7fLemi8phyk8_0tOd8ieL_=vPg@mail.gmail.com>
X-ClientProxiedBy: MN2PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:208:e8::26) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0013.namprd20.prod.outlook.com (2603:10b6:208:e8::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Thu, 9 Jul 2020 16:34:58 +0000
Received: from jgg by mlx with local (Exim 4.93)	(envelope-from <jgg@mellanox.com>)	id 1jtZVf-007eRH-2H; Thu, 09 Jul 2020 13:34:55 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13597d3d-58ed-45b5-3833-08d8242604ee
X-MS-TrafficTypeDiagnostic: VI1PR05MB5982:
X-Microsoft-Antispam-PRVS: 
	<VI1PR05MB59824D538C077C58E3B5652CCF640@VI1PR05MB5982.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZTKcz6ux2JcsNyzBPY0WgsFBEsbfrKkkma2JNmuvSuBaefYs9/9AJpT6gkdBXb73O1s3VI65CC09vikqNMHE+9f9noU90K8RgjpwAd993NOr10Jic8AgK7qKIQvvJpAJAXRR+GRTBPGngGTqJ7MwjvPYbQngnXMoNUzFmDBhKo78l5+gNLe76YJT0TNtlfek4ebvq29tyl/BS+1rZ7R8XQsm90KvAG7yQBkknDdqH/J1V2HQ8/GcNlsNEwgOHUyU8okTFhmqq78o9WfHavDeNHoRygnHcKkEomZ1wG71CVuBNgDbA9Y/JZlRrFVab56AMTanxvpejL81tNacrL8vMw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(2906002)(36756003)(66946007)(478600001)(8676002)(8936002)(316002)(2616005)(66556008)(7416002)(426003)(1076003)(186003)(4326008)(66476007)(9786002)(53546011)(9746002)(33656002)(54906003)(83380400001)(26005)(86362001)(5660300002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	U2J8laW2GtYJ+Hew9rjmv1wblmff+YannsBw1Mjz+JND8M8ZbMOzE4SnodcCfjohtsP6BK5OuExVfqfEt1aULoOQ3Dh9UD+Nkp2tiewhTr/OlsYrkPDcEB8lIIgZHiXv4p2BM8hxNqjdz7dAvuwtaO18wIWZb+X/pWtWO+I7Pp/7LI57OqOnpXq49WAs8LVSX29M8B1ZySWsceL0xD69/SzGAQRaEpzx2g9fZF7mUx8azHelgspW+AkZLm0R6p0rXjimG/HzF2mgbne/eRq7Q0PX6LK1/ODqKvO4jjTHc52QlcQ228w0bLGN8QtNtKWMvKEFU/HZrnVeCk768E98zJuwBoHdyx0CukyggoahoeE6oUgEDotF8zWwZt2FF88wO5wO29DGMKaFMae3qyQ1rknmek4sXApvPzC0VKNEhzEBA6WUwI9lRHG+4aNaC8n2sNoOvL30bHCupRLhQbh6IQep49Qu5wllJdXRQcmJfsI=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13597d3d-58ed-45b5-3833-08d8242604ee
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 16:34:58.4352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFH47HJlU74F/iO57gR8k0uCA7etsM0zYxq2gyTF9WhuoYUZuzWuhDQxx+gyCfrVQpm2MnxXO/oEQvUXgv4gjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5982
Message-ID-Hash: BYFXCDFNIZMUQCRGTAVFHTPHKAL3JVFP
X-Message-ID-Hash: BYFXCDFNIZMUQCRGTAVFHTPHKAL3JVFP
X-MailFrom: jgg@mellanox.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Doug Ledford <dledford@redhat.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BYFXCDFNIZMUQCRGTAVFHTPHKAL3JVFP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 09, 2020 at 09:10:06AM -0700, Dan Williams wrote:
> On Thu, Jul 9, 2020 at 8:39 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > On Thu, Jul 09, 2020 at 04:00:51PM +0100, Christoph Hellwig wrote:
> > > On Mon, Jul 06, 2020 at 06:59:32PM -0700, Dan Williams wrote:
> > > > The runtime firmware activation capability of Intel NVDIMM devices
> > > > requires memory transactions to be disabled for 100s of microseconds.
> > > > This timeout is large enough to cause in-flight DMA to fail and other
> > > > application detectable timeouts. Arrange for firmware activation to be
> > > > executed while the system is "quiesced", all processes and device-DMA
> > > > frozen.
> > > >
> > > > It is already required that invoking device ->freeze() callbacks is
> > > > sufficient to cease DMA. A device that continues memory writes outside
> > > > of user-direction violates expectations of the PM core to be to
> > > > establish a coherent hibernation image.
> > > >
> > > > That said, RDMA devices are an example of a device that access memory
> > > > outside of user process direction.
> >
> > Are you saying freeze doesn't work for some RDMA drivers? That would
> > be a driver bug, I think.
> 
> Right, it's more my hunch than a known bug at this point, but in my
> experience with testing server class hardware when I've reported a
> power management bugs I've sometimes got the incredulous response "who
> suspends / hibernates servers!?". I can drop that comment.
> 
> Are there protocol timeouts that might need to be adjusted for a 100s
> of microseconds blip in memory controller response?

Survivability depends alot on HW support, it has to suspend, not
discard DMAs that it needs to issue. Most likely things are as you
say, and HW doesn't support safe short time suspend. The usual use of
PM stuff here is to make the machine ready for kexec

Jason
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
