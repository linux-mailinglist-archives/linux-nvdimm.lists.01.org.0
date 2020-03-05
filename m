Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D7117A7F9
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Mar 2020 15:42:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E35410FC3778;
	Thu,  5 Mar 2020 06:43:32 -0800 (PST)
Received-SPF: Pass (helo) identity=helo; client-ip=40.107.77.53; helo=nam02-sn1-obe.outbound.protection.outlook.com; envelope-from=thomas.lendacky@amd.com; receiver=<UNKNOWN> 
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-eopbgr770053.outbound.protection.outlook.com [40.107.77.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D35E710FC3773
	for <linux-nvdimm@lists.01.org>; Thu,  5 Mar 2020 06:43:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAYoVveKr+0whWC1sXkCu2oWDfs6TEyJU04JC7UMq1Wp2G0/1iq3TZTkNaMTlqCd+Gz+et5EDwAUhlsF05uRSAdutsGJhqSV3dpKLt1j8S9zeQRmg3YukVS2ATPSVxNv5G6yhXbxMl0aJt9l1NQT3imQ4+iQBnA4qBFvFaTkiyJIL1OYQENFzLFxRz0Bs3Ybz6FBy6SVc2w0Jji8yDxUkn8PM2Mi7AbLvRI91N10AHM61Ke9fhk5BsIFYrOnpuf6Pmk2DNGko9/TjYtJyUI+HALmPt7uruGP/XvWUqx7IAuEeK4ek3Ex43LS94F2J+TqekZs6sJWpLurJq9HFOiLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMXRCG4luskE4aTNnrxlY6n5n4w4U50ZDLne7Mn2vQk=;
 b=L17I9pDQxJi6i2JyMDYO4PKB2WEjUv1ub92z0QxAbFcPtOtGHe55X0hsn+amN5MrqdbljbDoB1l3zQsMqn46Qq/KEtjRvqbPt/Y5TiAu4M3a4E3BJdMkDvB++XtHo1C6KhKq4aaHO7WRnY6Va5qB5DiPHC72tXDNR7SGDJkVBP11jCd2FVoEGaXSMdaV3gWv8N20GCelnawGPY3ue23N+zsBfScu0HrZ+eHWPePkddUEXKuXAoAbqWT/Gve2r8n5z+WLC1GjsvKRdI1605JCIrA7e9c/XDdTBNnaRwUcROW9iB/JtZDqYmirvmS066AJYnWcmPkc5RPjpCp9DVtyrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMXRCG4luskE4aTNnrxlY6n5n4w4U50ZDLne7Mn2vQk=;
 b=k1TwbLI12iIMXpDWOfzaEMRG4GuenUlwvpKs2eSMes2Fj6b95jBVQ3yUtXFUMdoFvErc9LiyDn1vTw9ZaQBd9y9uxkiJ/6m8CHsUHLNKbBuVc/b1AzZ7DhPwHgALDsEcZWU/CKKSwiUNVnxUSdi4v2VN6DmbNTh7PYD7CNPdwgg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB3818.namprd12.prod.outlook.com (2603:10b6:5:1cf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 14:42:36 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 14:42:36 +0000
Subject: Re: [PATCH 4/5] resource: Report parent to walk_iomem_res_desc()
 callback
To: Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158318762012.2216124.16408566404290491508.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <1848cdb9-8c19-d7fe-870c-175bd60bc364@amd.com>
Date: Thu, 5 Mar 2020 08:42:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <158318762012.2216124.16408566404290491508.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-ClientProxiedBy: DM5PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:3:93::24) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by DM5PR20CA0014.namprd20.prod.outlook.com (2603:10b6:3:93::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Thu, 5 Mar 2020 14:42:35 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4c772fb-13c5-4122-5d14-08d7c1137253
X-MS-TrafficTypeDiagnostic: DM6PR12MB3818:
X-Microsoft-Antispam-PRVS: 
	<DM6PR12MB38185BA08B9400303E4C5692ECE20@DM6PR12MB3818.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: 
	SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(189003)(199004)(478600001)(2906002)(26005)(36756003)(16526019)(6486002)(81156014)(956004)(8936002)(81166006)(8676002)(2616005)(54906003)(52116002)(316002)(16576012)(66476007)(66946007)(31686004)(5660300002)(66556008)(86362001)(53546011)(186003)(4326008)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3818;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0cJz7G22y0PPbY9AoBk49CytOAY3nG7DDdApNsITCl9pZUnl2isduLB6JLo+TF93SVO/U7ZIHSMH3RC0idvji3qdQRsp2Elr6iBQ/qExaEMV7HxoE+WuvVvSUciCC0BDReBDWr/jFHL9uzi9ZOjOJyulog4GtgfmfI5VOiGYY87zrGdlZcM5jJ/0h6orIHgo72aR7UCsu70nk+kJax65Y8S46af+CB1nX2B4LVt4zSk8X+DRBfa3lXtWx9mXtFN5Tpbx0itnqeWAbqbpLBInX+azoNMDnSI/wEn77nqhlKnr+3sBQOAdxc+kY0J5igpRToeSlC2jggz4X7MiCyHJiylaYlvkpSHBPmi7YUco0eeTp8m2Ec6votoNPbgaF2GcmoRrbaujnNj1mmuaC4RsVejYlH0sGqsYyTWB/S92KlTdlvfmLypg3Dg0BsCbZ6M8
X-MS-Exchange-AntiSpam-MessageData: 
	m5SZs6/E1qVL4e5yuqQdyYp6RyWdY7w/OPD8p9J3CfgLLtBfrObOuszqaglm0qpaeNX6Y9t36pV1fapQM7yvsYu2S9r6uukOUe8Lxi6lEWDguMEmvShy17SuNC+XWdfYcsQ3jEQipvjdmh/82u8y1A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c772fb-13c5-4122-5d14-08d7c1137253
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 14:42:36.4458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKYvPNOsVIXUdZgoP1/dvcvNy4CrrBrRlezdgGt50xJCnZFVPUqMuJbUVgxfRXyWv3CA8RRgC5M+oiUtjQt2jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3818
Message-ID-Hash: 2OTM5MIO7OMBXIL5X7QUVLBMCWUCXF7U
X-Message-ID-Hash: 2OTM5MIO7OMBXIL5X7QUVLBMCWUCXF7U
X-MailFrom: Thomas.Lendacky@amd.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, peterz@infradead.org, ard.biesheuvel@linaro.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2OTM5MIO7OMBXIL5X7QUVLBMCWUCXF7U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/2/20 4:20 PM, Dan Williams wrote:
> In support of detecting whether a resource might have been been claimed,
> report the parent to the walk_iomem_res_desc() callback. For example,
> the ACPI HMAT parser publishes "hmem" platform devices per target range.
> However, if the HMAT is disabled / missing a fallback driver can attach
> devices to the raw memory ranges as a fallback if it sees unclaimed /
> orphan "Soft Reserved" resources in the resource tree.
> 
> Otherwise, find_next_iomem_res() returns a resource with garbage data
> from the stack allocation in __walk_iomem_res_desc() for the res->parent
> field.

Just wondering if we shouldn't just copy the complete resource struct and
just override the start and end values? That way, if some code in the
future wants to look at sibling or child values, another change isn't needed.

Just a thought.

Thanks,
Tom

> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  kernel/resource.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 76036a41143b..6e22e312fd55 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -386,6 +386,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>  		res->end = min(end, p->end);
>  		res->flags = p->flags;
>  		res->desc = p->desc;
> +		res->parent = p->parent;
>  	}
>  
>  	read_unlock(&resource_lock);
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
