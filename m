Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D91217CAE
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 03:41:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 832AA110B96A3;
	Tue,  7 Jul 2020 18:41:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.1.59; helo=eur02-he1-obe.outbound.protection.outlook.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10059.outbound.protection.outlook.com [40.107.1.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 55873110B969F
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 18:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eupO9Er5ZfcbCNiFSm1+GrqCsX1S9J7XVa0Xvxph5Yo=;
 b=hWHqFXm5KEPG/dYPQE+SQ86jTUa48YopNWv347vds1MAu4nHnm6+u6BCd2MO1qW/cnSTvAz6ZXKTh2++uvf1OX0w0fwfxcN6/y0JwU6ER3/3r/fjPhjnfe7hSh3qK/NHt5EY6gSOwEA4MvIP2+j3OQupPj6bUsLrQmqX2U42IIo=
Received: from AM6PR05CA0003.eurprd05.prod.outlook.com (2603:10a6:20b:2e::16)
 by DB6PR0801MB2056.eurprd08.prod.outlook.com (2603:10a6:4:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Wed, 8 Jul
 2020 01:41:47 +0000
Received: from AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2e:cafe::91) by AM6PR05CA0003.outlook.office365.com
 (2603:10a6:20b:2e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Wed, 8 Jul 2020 01:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.01.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;lists.01.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT008.mail.protection.outlook.com (10.152.16.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Wed, 8 Jul 2020 01:41:47 +0000
Received: ("Tessian outbound 2dd9eeca983c:v62"); Wed, 08 Jul 2020 01:41:46 +0000
X-CR-MTA-TID: 64aa7808
Received: from 49216f569693.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 29479A2D-34D6-43B3-A907-D5F8CE15721D.1;
	Wed, 08 Jul 2020 01:41:41 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 49216f569693.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 08 Jul 2020 01:41:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJmGgOKU4H4zFKY/2b1TN1pmOFwazUDFvC7cJLe1vulzcorx3v8ZgINaRWjmaPll4VASdWh6c9WRgyIWUYcpRJS6CC6fvqpxfW/hVQZtjcCMx+4Cb2WnTITyT/0txHjK0sMv+botsRne9ZNKv+Zfvho9AP4ETxpRv2hpiSQkZKOAa8XcnH7f8xN8IRhzgwWoH/21qd2arHvILlnCOcrDknTCl0BXw888RC6sQQF4TTJXGpXGtvZh4RjRsGo63sLfTHmxy/qbgc482IdRt81fI3j2Cm2oD/hwhMiS8ZE6Eh92SvBIuTgFeTG0U2wB3rWbt8p8i7fawdBl4kSBrZcW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eupO9Er5ZfcbCNiFSm1+GrqCsX1S9J7XVa0Xvxph5Yo=;
 b=ZPywwhlM3CbgmC/wpNOUackAhm5H2zydPIrdpyJxeSzRxPJNCNCcQd0iFySmhFh1butyP9nvgoYphAW483FJMR8tdUF3RsY+gvUtkcDL1Sn1blQNI2bJty3itCcGhogC/Xd2Pv+VM90QVdn4yL4U3b9tP6jiL7D5Bglmxp4VpF9KnOaMuppc1vtDiJtDh2lWakjszzepTML9u3pcoqyLop+gUSLgc54TD7WVR3VP+FFAjOcmW8kuOdfFa60U/uvDpxmf25g38nO0wI4lShpY14yqxjqGVmwhkYyLNpFbf5EJ4tH8vp0S7Qb24PLc3diUnTJB1+zFgloaPxV3Q9uPpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eupO9Er5ZfcbCNiFSm1+GrqCsX1S9J7XVa0Xvxph5Yo=;
 b=hWHqFXm5KEPG/dYPQE+SQ86jTUa48YopNWv347vds1MAu4nHnm6+u6BCd2MO1qW/cnSTvAz6ZXKTh2++uvf1OX0w0fwfxcN6/y0JwU6ER3/3r/fjPhjnfe7hSh3qK/NHt5EY6gSOwEA4MvIP2+j3OQupPj6bUsLrQmqX2U42IIo=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB4405.eurprd08.prod.outlook.com (2603:10a6:20b:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Wed, 8 Jul
 2020 01:41:40 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 01:41:40 +0000
From: Justin He <Justin.He@arm.com>
To: David Hildenbrand <david@redhat.com>, Catalin Marinas
	<Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dave
 Jiang <dave.jiang@intel.com>
Subject: RE: [RFC PATCH v2 2/3] device-dax: use fallback nid when numa_node is
 invalid
Thread-Topic: [RFC PATCH v2 2/3] device-dax: use fallback nid when numa_node
 is invalid
Thread-Index: AQHWVCPVY5+RvFDzZEO2wqan5w9kVKj7/MoAgADsitA=
Date: Wed, 8 Jul 2020 01:41:40 +0000
Message-ID: 
 <AM6PR08MB4069EDE5D2D539BC186D091EF7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-3-justin.he@arm.com>
 <2409a5d4-e77b-f570-c788-feb4f6ebb498@redhat.com>
In-Reply-To: <2409a5d4-e77b-f570-c788-feb4f6ebb498@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: bec86d11-e5c5-4b6e-9e2c-8c1ac8a218ba.0
x-checkrecipientchecked: true
Authentication-Results-Original: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 850570e0-0a05-4c11-6fd9-08d822e013ac
x-ms-traffictypediagnostic: AM6PR08MB4405:|DB6PR0801MB2056:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: 
	<DB6PR0801MB20567076A2B255700AE234CCF7670@DB6PR0801MB2056.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 lEzGUtPNHLqYjeuRLQOb/srAEqhLIU+mDxQwjfO/QtdelMerRCcJcKwcI20mXcLVEalMhdPO1nOicjpq0zkUZK/j77WYjBnhcX2On2UZimXQYbwPsfHS2zu99O1q15csV6YXF6jW3unKTNjcpZODpbEEC5IKd4B+WrdBirzla6sBmUc84069ocIkh7mND5g9zJ1bf6o1CKOqm5KJRbJsMkilun/2dgbyHWDqzBWJJ21EIKSKGoB2LqJ/9sH221TWM35w+ngiqf3fjtJKajs8LvF+Wlwt9pLZvSJFWDE5PtSG9nfszaQ5THiqd5kGJOO2a5g6Z9z1cs9IEnkfrZcU9w==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(136003)(396003)(366004)(376002)(346002)(66946007)(71200400001)(8676002)(5660300002)(186003)(7696005)(52536014)(6506007)(26005)(86362001)(53546011)(110136005)(4326008)(316002)(66476007)(66556008)(64756008)(66446008)(54906003)(76116006)(8936002)(55016002)(83380400001)(2906002)(33656002)(478600001)(9686003)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 /OkL9YRd6u7ntzMuItcwBAR6NrlKYmkrhpRFpzl4OcX64/TTYnEqJLtFQrYKfUbsC05l9RhjNIjTDvlRs9jjRMa9RMe0M9add3hb30/qDJrsx7neFn37zELCVOlXShUNyziF8HfQs5+uyaCAMnogsSCRxAW3jGp7hfXocr1GFr2WA9UPlFH4d93aEOhOpREAFNAZCMVN18sCWxi02gDOFGef26LSbfws/Swip/S+8sepVjOgjTcrqMG4Ozk/nXeHO6MRwnuEXtkytKXH2PM7o4pyjvXuiyaB2GQr4JOP8pXrzNGsZyGVjw9HmfKXLTS/y0RErU44A2r6ZTBc6SrwXxKbV7oPFZ5b4/VCpdq4/IuH2lJoQpzHZqxFmf778D4g+/gHD+CSeq4HIQ+mYPChgRMXZTRBmEQa7bb0458gfrlff/y5V61g4GN6K3f4EpVvqEYtOltxx6Fst0msnJCaZge0ox2XFsrX/WeuyfyQmTA=
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4405
Original-Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(136003)(376002)(396003)(346002)(46966005)(70586007)(186003)(83380400001)(47076004)(4326008)(5660300002)(7696005)(2906002)(52536014)(82740400003)(8936002)(356005)(86362001)(82310400002)(81166007)(70206006)(55016002)(478600001)(36906005)(54906003)(53546011)(26005)(6506007)(8676002)(9686003)(33656002)(110136005)(316002)(336012);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	aaf9bdd2-4b6c-4831-25da-08d822e00fa1
X-Forefront-PRVS: 04583CED1A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KPTHMwu9HaU4IZXeKoufstzqd7fBD0Q4WBjQFtYOv/R5Q8UNPbyXXTmKPEkrNMTXCWJC2/i7juvvLNp9zmEO95QwVVo1K+Y1itknVsqkIp2xGB5wt8wcGG7F7OEM+TxDif9Qw5bX8k533AV3cURc+Nhqz9TE+EzQ0Zsqkl7HUodTBx23PyPU4ZJ5P8IlvaQvWwqs5ozYTEZkBmUNOcWkme7U7k4M8Kjq1YlTW8udxGs4nggSpwcDoQVf6XhYPHxozKinn1I9SnPqbnXZKvrz82syHzRF7uuud16WmxuH2UfSN9BESwgjlnLb7wyt0LJ7545uscng6POVYQmGHuxbaJ6bjv0w0s2VtjQCW9BntpSaPz0PaudDbSrBaTzcmXe1Km82DKQrYxQcSMP510gTFQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 01:41:47.0362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 850570e0-0a05-4c11-6fd9-08d822e013ac
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2056
Message-ID-Hash: D7FXCHWSTNUVX2DLKSTILSDBRXHCKPRO
X-Message-ID-Hash: D7FXCHWSTNUVX2DLKSTILSDBRXHCKPRO
X-MailFrom: Justin.He@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R5BGSQLWJKECH4SB62R5QSDDZN7X7ESI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi David

> -----Original Message-----
> From: David Hildenbrand <david@redhat.com>
> Sent: Tuesday, July 7, 2020 7:34 PM
> To: Justin He <Justin.He@arm.com>; Catalin Marinas
> <Catalin.Marinas@arm.com>; Will Deacon <will@kernel.org>; Dan Williams
> <dan.j.williams@intel.com>; Vishal Verma <vishal.l.verma@intel.com>; Dave
> Jiang <dave.jiang@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>; Andrew Morton <akpm@linux-
> foundation.org>; Mike Rapoport <rppt@linux.ibm.com>; Baoquan He
> <bhe@redhat.com>; Chuhong Yuan <hslester96@gmail.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> mm@kvack.org; linux-nvdimm@lists.01.org; Kaly Xin <Kaly.Xin@arm.com>
> Subject: Re: [RFC PATCH v2 2/3] device-dax: use fallback nid when
> numa_node is invalid
> 
> On 07.07.20 07:59, Jia He wrote:
> > Previously, numa_off is set unconditionally at the end of
> dummy_numa_init(),
> > even with a fake numa node. Then ACPI detects node id as NUMA_NO_NODE(-1)
> in
> > acpi_map_pxm_to_node() because it regards numa_off as turning off the
> numa
> > node. Hence dev_dax->target_node is NUMA_NO_NODE on arm64 with fake numa.
> >
> > Without this patch, pmem can't be probed as a RAM device on arm64 if
> SRAT table
> > isn't present:
> > $ndctl create-namespace -fe namespace0.0 --mode=devdax --map=dev -s 1g -
> a 64K
> > kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with
> invalid node: -1
> > kmem: probe of dax0.0 failed with error -22
> >
> > This fixes it by using fallback memory_add_physaddr_to_nid() as nid.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> > I noticed that on powerpc memory_add_physaddr_to_nid is not exported for
> module
> > driver. Set it to RFC due to this concern.
> >
> >  drivers/dax/kmem.c | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> > index 275aa5f87399..68e693ca6d59 100644
> > --- a/drivers/dax/kmem.c
> > +++ b/drivers/dax/kmem.c
> > @@ -28,20 +28,22 @@ int dev_dax_kmem_probe(struct device *dev)
> >  	resource_size_t kmem_end;
> >  	struct resource *new_res;
> >  	const char *new_res_name;
> > -	int numa_node;
> > +	int numa_node, new_node;
> >  	int rc;
> >
> >  	/*
> >  	 * Ensure good NUMA information for the persistent memory.
> > -	 * Without this check, there is a risk that slow memory
> > -	 * could be mixed in a node with faster memory, causing
> > -	 * unavoidable performance issues.
> > +	 * Without this check, there is a risk but not fatal that slow
> > +	 * memory could be mixed in a node with faster memory, causing
> > +	 * unavoidable performance issues. Furthermore, fallback node
> > +	 * id can be used when numa_node is invalid.
> >  	 */
> >  	numa_node = dev_dax->target_node;
> >  	if (numa_node < 0) {
> > -		dev_warn(dev, "rejecting DAX region %pR with invalid
> node: %d\n",
> > -			 res, numa_node);
> > -		return -EINVAL;
> > +		new_node = memory_add_physaddr_to_nid(kmem_start);
> > +		dev_info(dev, "changing nid from %d to %d for DAX
> region %pR\n",
> > +			numa_node, new_node, res);
> > +		numa_node = new_node;
> 
> Now, the warning does not really make sense. We have NUMA_NO_NODE (< 0),
> that is not a change in the nid, but a selection of a nid. Printing
> NUMA_NO_NODE does not make too much sense. I suggest just getting rid of
> new_node and turning the dev_info() into something like
> 
> dev_info(dev, "using nid %d for DAX region with undefined nid %pR\n",
>          numa_node, res);
> 
Okay, I will update it as your sugguestion. Thanks

--
Cheers,
Justin (Jia He)


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
