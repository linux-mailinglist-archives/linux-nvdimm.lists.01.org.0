Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919F5216632
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 08:08:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 551DE1108DEAA;
	Mon,  6 Jul 2020 23:08:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.22.80; helo=eur05-am6-obe.outbound.protection.outlook.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 56A2D1108DEA9
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 23:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1+j9ClshorGQ7SpVxIgSgbUxhaHtZ9yGrGWPJxNg/g=;
 b=5hh5fsQ5w1c54pf++kjoXJmERphVB+6gBMAy6Vvajkc4ij/TjWwROM24O9HAY+8wTR66dCf91Dtfa+4Qlskcj37g+6Q+Tjm8s1f3+7xnCVK3wm4CTpzPalbqzy6ed/MoaYloohv28+oO2irWAoasmfvmEIZjs2z7bzOydErnHP8=
Received: from AM6P194CA0071.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::48)
 by AM6PR08MB4657.eurprd08.prod.outlook.com (2603:10a6:20b:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 7 Jul
 2020 06:08:29 +0000
Received: from AM5EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:84:cafe::f5) by AM6P194CA0071.outlook.office365.com
 (2603:10a6:209:84::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend
 Transport; Tue, 7 Jul 2020 06:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.01.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;lists.01.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT063.mail.protection.outlook.com (10.152.16.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Tue, 7 Jul 2020 06:08:29 +0000
Received: ("Tessian outbound e44de778b77e:v62"); Tue, 07 Jul 2020 06:08:29 +0000
X-CR-MTA-TID: 64aa7808
Received: from 513f3cd52b24.3
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 670B9F5A-F7B9-468B-B976-A26459C626F1.1;
	Tue, 07 Jul 2020 06:08:24 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 513f3cd52b24.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 07 Jul 2020 06:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag7ZBpGqAoDqDiBtInl4tAIYS8vh4uO1adx2YmHnXrkVpdtkQteZTPNRAVhjndVvm/STF9Bap16KoV37/tjcHUi57p6Rq/M/nVp88nolNTaiWfukR8cVvJsHvbCF0BLjHwUfvxYuvwxPF3TO36aHS3bsrJmJzWzmxOOXWi5MCOoVEyt0olJ+trajLjHx+qA4eEwyzR8l68aBRLHvRPuSGoKtDWOqTwdP7T6alWFqyIG72bPMS0wgYdYoA57oY52H5HNNG4GaU86AJS7Vy69mD9+g0taIUwla65LA6TJqDomiLMPyXBwqBtNnodr2KH7HVZmZQ0bPncRYiih0Q256wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1+j9ClshorGQ7SpVxIgSgbUxhaHtZ9yGrGWPJxNg/g=;
 b=Dd2V0/6PVTb30VVl0JBxpUnHVVj/X6f6qI8yNDF1mD0V+S+ZOgVqOl8Y0SZ0+FoQf1D0uZPgzV9kT3jlSeKGQ1qzig+7x5P50MGzBYTaCNLE5AUA5ExPoVerHEWB5Ip48HerVQF7UWnZQE5qsj6sDLLyJaIOgharts5gbOaBzO6SnHtzjbXYH7icM2aVsM2BpZqfNE2P9d9L9p8nwtaS9cNjW0LELg07ZbNVBCAGJzh32j10DtH4AodRQV/hjJPbmxVuYnY0xAe5K2HyU1/uyOepdwDn58I9zBFcPmbkyU++pn3umwGCIZCPG9o6hKL7prOmeeeweKbHs2z73lmmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1+j9ClshorGQ7SpVxIgSgbUxhaHtZ9yGrGWPJxNg/g=;
 b=5hh5fsQ5w1c54pf++kjoXJmERphVB+6gBMAy6Vvajkc4ij/TjWwROM24O9HAY+8wTR66dCf91Dtfa+4Qlskcj37g+6Q+Tjm8s1f3+7xnCVK3wm4CTpzPalbqzy6ed/MoaYloohv28+oO2irWAoasmfvmEIZjs2z7bzOydErnHP8=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB5080.eurprd08.prod.outlook.com (2603:10a6:20b:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Tue, 7 Jul
 2020 06:08:21 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.020; Tue, 7 Jul 2020
 06:08:21 +0000
From: Justin He <Justin.He@arm.com>
To: Justin He <Justin.He@arm.com>
Subject: RE: [RFC PATCH v2 2/3] device-dax: use fallback nid when numa_node is
 invalid
Thread-Topic: [RFC PATCH v2 2/3] device-dax: use fallback nid when numa_node
 is invalid
Thread-Index: AQHWVCPVY5+RvFDzZEO2wqan5w9kVKj7n9gQ
Date: Tue, 7 Jul 2020 06:08:21 +0000
Message-ID: 
 <AM6PR08MB40699B8B08470564129F4C44F7660@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-3-justin.he@arm.com>
In-Reply-To: <20200707055917.143653-3-justin.he@arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 87e84cc8-9fac-4593-8fca-6ac71b1809b2.1
x-checkrecipientchecked: true
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45e79a1a-a76c-48ca-c3d0-08d8223c2b82
x-ms-traffictypediagnostic: AM6PR08MB5080:|AM6PR08MB4657:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: 
	<AM6PR08MB4657FB1A6E8D70E0E9BFDDF5F7660@AM6PR08MB4657.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 Zq1R23CPnlG5shxJahYKnGQlI6FR2XdzkPPFKro9AtYsOySD2WJ5FYEynVPdaBg2+d7qaUGE6DAuRViUhDgq5ioxPRidC3LaCD1EuG9UTO66ekZB7X3xKTlnzVq3g68aaUMWhb9IzyW4ww0rdiqtU5E1qGJQwggWgJAqezEmQ497xNACkqVlUmx6WMgrx1BcCp74Dqmx+vuHXwRKEkqjrEk6WCV7/Mbcq//j0bQPixmCuDgaeD66TsD6MrJtMDZLcYzlNLnWtDWY66xgjJh0NmT0py0v8GN/b81c9bHrB0snIsH6omAfYPRaBG+GddYzpbZjtxXBiz8qbwcLoVizBA==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(52536014)(2906002)(5660300002)(54906003)(6200100001)(316002)(83380400001)(8676002)(33656002)(4326008)(66446008)(66946007)(76116006)(66476007)(66556008)(64756008)(26005)(71200400001)(55016002)(186003)(7696005)(8936002)(478600001)(6862004)(86362001)(7416002)(53546011)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 hto7kML7YmEtp8AzOA1llPIrx4Ol2mj+yHsKjov4snxw8PQDhI0kvIoyOziX2h4gXlqUPG+uSRdIL/p+qpzOO8lOuU4NlGcJ5jLgD4k1UGi2JrFlsp0mXSWemvxbwD59/qCwTpR44DnYhO7wlosJQ8UPohhs4v+W0uojuq7XVjWZXIGY0CpZA7ayLd2pMUgfB/xHagSk/oUPqw6r7sBhoMpUh+OePZyaYuARCYfEsJnBU1nyNkFFFZTdjxk1Ki9IOHfK1OCeTfKu2T2bRNCu/jmkZ030GmyUsu8rUVj3ZxG8c0CfFQcVMGaowElLtJcD5N84dVjjwtFblVUIfAFf47CqOaz+yN3jxyI4cP41/0s+VT/r5IlYYvP5poQjLSl06xwWu1LNOCel2XzjhzDuWuLkkMab5nw/OwESdX+HOwe7Nixl4wrdxSvRULCTsLR0GsflkmAZ6W95C+pzlFJCPS6IydsLlh42NAMq9O5+l1I=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5080
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM5EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966005)(7696005)(4326008)(186003)(5660300002)(55016002)(86362001)(356005)(82740400003)(6506007)(53546011)(6862004)(36906005)(316002)(8936002)(26005)(82310400002)(81166007)(52536014)(6200100001)(83380400001)(8676002)(54906003)(2906002)(336012)(70206006)(70586007)(9686003)(478600001)(107886003)(33656002)(47076004);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	939e9621-6bf7-4a66-dab3-08d8223c26b3
X-Forefront-PRVS: 0457F11EAF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	njqtO3iW3Jg4Qt7zfN162qjjbkUIkvIyh1o1PTZFAF/JUS2psnJKPWEnpYgghIL5GxW/DsqtNSKzkTqdiNS54xXly6zsKsMRZkau1PFnzVJE7+2btbLdXmUfAdPamMt+nTd0tVbJWASZioI+L+VipGXDk3IVYmO2Of2fc1n1LMMOQGccyvLXYVZYlVDbSshE7gA3LgxWxak69ICBcO46E2FwhJ4MM5Be/VsfRipgJhXvz2GwnutAWkdmMk25IzyHE6irJB5+nwHUrI3lF9erZ4cQz5Rf/lYRIGOWIgUwK26ibGW47YVf1yivWfzAotgOaoE8A32yewzge2fjScgdLy/POSHOS8Kst7dDESlgIXlHvDh5Pb69rEkMmYIDCR8yUL/aP+Omc2wETz/ze0mYKw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 06:08:29.5359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e79a1a-a76c-48ca-c3d0-08d8223c2b82
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM5EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4657
Message-ID-Hash: 2ZMLMGQMNVANKPHCX3ADXPIARLU6OYC5
X-Message-ID-Hash: 2ZMLMGQMNVANKPHCX3ADXPIARLU6OYC5
X-MailFrom: Justin.He@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F3CM3WBBTVZYJGY6QH4MHKTAN2H4FRSC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

[+] add Powerpc maintainers to check my concern about memory_add_physaddr_to_nid
Exporting


--
Cheers,
Justin (Jia He)



> -----Original Message-----
> From: Jia He <justin.he@arm.com>
> Sent: Tuesday, July 7, 2020 1:59 PM
> To: Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon
> <will@kernel.org>; Dan Williams <dan.j.williams@intel.com>; Vishal Verma
> <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>; Andrew Morton <akpm@linux-
> foundation.org>; Mike Rapoport <rppt@linux.ibm.com>; Baoquan He
> <bhe@redhat.com>; Chuhong Yuan <hslester96@gmail.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> mm@kvack.org; linux-nvdimm@lists.01.org; Kaly Xin <Kaly.Xin@arm.com>;
> Justin He <Justin.He@arm.com>
> Subject: [RFC PATCH v2 2/3] device-dax: use fallback nid when numa_node is
> invalid
> 
> Previously, numa_off is set unconditionally at the end of
> dummy_numa_init(),
> even with a fake numa node. Then ACPI detects node id as NUMA_NO_NODE(-1)
> in
> acpi_map_pxm_to_node() because it regards numa_off as turning off the numa
> node. Hence dev_dax->target_node is NUMA_NO_NODE on arm64 with fake numa.
> 
> Without this patch, pmem can't be probed as a RAM device on arm64 if SRAT
> table
> isn't present:
> $ndctl create-namespace -fe namespace0.0 --mode=devdax --map=dev -s 1g -a
> 64K
> kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with
> invalid node: -1
> kmem: probe of dax0.0 failed with error -22
> 
> This fixes it by using fallback memory_add_physaddr_to_nid() as nid.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
> I noticed that on powerpc memory_add_physaddr_to_nid is not exported for
> module
> driver. Set it to RFC due to this concern.
> 
>  drivers/dax/kmem.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 275aa5f87399..68e693ca6d59 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -28,20 +28,22 @@ int dev_dax_kmem_probe(struct device *dev)
>  	resource_size_t kmem_end;
>  	struct resource *new_res;
>  	const char *new_res_name;
> -	int numa_node;
> +	int numa_node, new_node;
>  	int rc;
> 
>  	/*
>  	 * Ensure good NUMA information for the persistent memory.
> -	 * Without this check, there is a risk that slow memory
> -	 * could be mixed in a node with faster memory, causing
> -	 * unavoidable performance issues.
> +	 * Without this check, there is a risk but not fatal that slow
> +	 * memory could be mixed in a node with faster memory, causing
> +	 * unavoidable performance issues. Furthermore, fallback node
> +	 * id can be used when numa_node is invalid.
>  	 */
>  	numa_node = dev_dax->target_node;
>  	if (numa_node < 0) {
> -		dev_warn(dev, "rejecting DAX region %pR with invalid
> node: %d\n",
> -			 res, numa_node);
> -		return -EINVAL;
> +		new_node = memory_add_physaddr_to_nid(kmem_start);
> +		dev_info(dev, "changing nid from %d to %d for DAX
> region %pR\n",
> +			numa_node, new_node, res);
> +		numa_node = new_node;
>  	}
> 
>  	/* Hotplug starting at the beginning of the next block: */
> @@ -100,6 +102,7 @@ static int dev_dax_kmem_remove(struct device *dev)
>  	resource_size_t kmem_start = res->start;
>  	resource_size_t kmem_size = resource_size(res);
>  	const char *res_name = res->name;
> +	int numa_node = dev_dax->target_node;
>  	int rc;
> 
>  	/*
> @@ -108,7 +111,10 @@ static int dev_dax_kmem_remove(struct device *dev)
>  	 * there is no way to hotremove this memory until reboot because
> device
>  	 * unbind will succeed even if we return failure.
>  	 */
> -	rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
> +	if (numa_node < 0)
> +		numa_node = memory_add_physaddr_to_nid(kmem_start);
> +
> +	rc = remove_memory(numa_node, kmem_start, kmem_size);
>  	if (rc) {
>  		any_hotremove_failed = true;
>  		dev_err(dev,
> --
> 2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
