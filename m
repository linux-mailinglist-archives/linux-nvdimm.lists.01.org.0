Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 428693753A0
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 14:16:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 660EB100EB350;
	Thu,  6 May 2021 05:16:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 51676100EB85C
	for <linux-nvdimm@lists.01.org>; Thu,  6 May 2021 05:15:58 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146CA6WS148508;
	Thu, 6 May 2021 12:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Rvo90rrF9qGNVDhAQDAlqHGWx9hjvLA2uRV+Tb9st5w=;
 b=XShFAyTsOcF+qpMRJkgJtGh7IE8o8kuTOVKsapSnOY0a9km2wWobe36FJpnrwtStW9Uh
 5mkprpwHMohWwQ4FHVseI1ZQOjgnq7SrNPRkuhwEsp3odlWM+jO2mirzPZTNK4H1uPpW
 qFeSKi/CK3bERRdAHFQb2vhGEBGpCuB+fwlFO7s2MXBrR416aTjUOvMi770azmqf1f9R
 zFkAefqCGaG1tYshaAKi1okhQVtd6gcX8z5ImETVbhUxhR6SwxOrFwsvlkUChUfVrrOY
 vaOZkZbx9k17Qt1DO32Dw470tndPLAEEcGGMFhpkNeg/gGtgnvuLASjtiq0vai+4iYJS IQ==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 38beetmrx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 May 2021 12:15:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146CAPot146882;
	Thu, 6 May 2021 12:15:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
	by aserp3020.oracle.com with ESMTP id 38bebm6mkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 May 2021 12:15:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y51ZfvY+Gq1Ihq2BlXg1XR/cJfK/8/EJHodsHKcCD68+1jXIyovnCIwXcOmIqu+ik8Pt9/mwYOoEEJImdkO2JeAjXNDUBDlPv7zblCXieHGQYAJroTDVLAPhx4621DWPjmArR4PUcItPakPh1W2lez9K3ACyVsIANnOyppASj2edGPnTn9B1ogJsS1lt+iFNeNizDTZYH0IaAME1XpGIX4CsbEwEfKXO4nqgIOlrP2VNfXyIdwsgyDL5L1W4NoPL21gAJPVTzlWoEvKAUZGkU2XuGwRvRzuMU+V2ekb9t6DQVLMfLfsLyC+1i2irAwCmK+oQ3D2zsXXKArSDoA7XdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rvo90rrF9qGNVDhAQDAlqHGWx9hjvLA2uRV+Tb9st5w=;
 b=fSuUiaqLfZ4VqjkRo5YT8AdLBAKNuTSGraC+JJXTZsq5/2F3HoaZzWHQIqb2GFZ5oimROqZ+HLYLDXliWvqiGFI3CNZC9+g7uVzCSB24K6S+bkFzV0KJvKsQ7hS/PRhzZLwJDY8qdBqJgMUfdZuvabHJv7zCY/w9NdLiErHOHnr7TJINRy7UkPkdoU8NH7E12nMvzGuuiL/9rCIyk8OlKb7rdiaMI6rt3QmSWSit+KViD+/sDEEl2MZb/9pyDRnOuD9sbPxl5RNDzG2ayBOASEFPC37t72cBYD4pgAhQkUyb1s7HVh2/5jREV5y/fFqfRmufZNa2LPb2wLfzbh3rwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rvo90rrF9qGNVDhAQDAlqHGWx9hjvLA2uRV+Tb9st5w=;
 b=OKpsZit++n6+9FB8JCWIsqogBz7Yn+X1IMdd6IQok7SgBCBzHKxB8ije4MdoxH60zt524xODernpMg7h1FfUhN+D7xr6FfXcXnlAH3kyjDeQP28hSZO4PZS5jUp+IJ/XF+p/+n2WPWtGWzhpYb4rinnObgU44gi2b8jNwofSq3M=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB3987.namprd10.prod.outlook.com (2603:10b6:a03:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 12:15:31 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e%6]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 12:15:31 +0000
Subject: Re: [PATCH v1 04/11] mm/memremap: add ZONE_DEVICE support for
 compound pages
To: Matthew Wilcox <willy@infradead.org>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-5-joao.m.martins@oracle.com>
 <CAPcyv4gs_rHL7FPqyQEb3yT4jrv8Wo_xA2ojKsppoBfmDocq8A@mail.gmail.com>
 <cd1c9849-8660-dbdc-718a-aa4ba5d48c01@oracle.com>
 <CAPcyv4jG8+S6xJyp=1S2=dpit0Hs2+HgGwpWeRROCRuJnQYAxQ@mail.gmail.com>
 <87zgx85ltc.fsf@linux.ibm.com>
 <31563092-a7b8-e6e1-f5ad-a66c02243a9d@oracle.com>
 <20210506114357.GA388843@casper.infradead.org>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <8df871e2-3c36-5fba-c98f-85caef7261b7@oracle.com>
Date: Thu, 6 May 2021 13:15:23 +0100
In-Reply-To: <20210506114357.GA388843@casper.infradead.org>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LNXP265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::22) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LNXP265CA0082.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 12:15:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0178a3d0-deb1-454a-1110-08d91088a449
X-MS-TrafficTypeDiagnostic: BY5PR10MB3987:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB398700D270694B7F60DAD9DFBB589@BY5PR10MB3987.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MKBdVvSg70kldDK67L/+e9rlrmes5SnhSZM9deBfS7rvK08tIlOozAgA7F7rBEj86t+KJXuvWPgcgzquy5TD9BldQRO9wGggUMOwdTyFsEbd1OLC7HyVVWN9ZLgJKR4e5QmbsvQxPv+3DlLd8u/X2+mC+afhkishftXhK8VZRi6NLhoz5K4xIWsqBWhyDcGfvtCpv3zTEduCy9DnSGK+9A2ADeh1su82+zgWvuZaGFmkVpJm3sr7dXJs29sQ0nO5ghjD71jRjDVqnIHlpN9znFfjpziPVbaBYIJzy3/1G2jUe+x8c3pK9qbvE3lcw2vDRQq74GCSrdCz8ytcInSiYAD8nqSugOrtLaMrSxfo74ZZbfoHmmxyRHCowEYW9ZpFGDx80zQPQlwqgsqEL+0W7G0L+J0pzrKE2ELTKPtu7ylXfg7aLClaauFm1s3UeHRod2aV0iTrRhssojE4OCWfgynNbjh8Oj+Z7iwqgkv11krjLyL8bztTWo7AykaV8tW8YAr3gTaSh7NY/Wj6It+2rxvk1ZtKoYsQsB7RtoN4P0D9FAiWn2KQabbx4K9VoJU+UE8+dpLKpMAcwlIVByxyzf3kofIu2T6IvKCu0ythkvw6vVO23uH9o2YIX39j1wwcsEseSzG21eGS1a5I+6J90sf3uZAKHqDvVpLmYMp6VaE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39860400002)(366004)(136003)(6916009)(8936002)(2616005)(6666004)(26005)(2906002)(956004)(38100700002)(8676002)(4326008)(53546011)(316002)(86362001)(478600001)(31696002)(66946007)(66476007)(66556008)(54906003)(16576012)(36756003)(186003)(83380400001)(5660300002)(6486002)(16526019)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?YUZRbnp2dlFWWm53UUxKbG81bU1rcnJqMTZIWmcxK3pjQ2FHVkk2Unp2eCtR?=
 =?utf-8?B?WTJuUXJXblZjaGxnYzZPell4cGVGMzZsZlFaNU9CUXJmSDIxVFdmc3BYNllT?=
 =?utf-8?B?dGlHRzhrL0UxbkxBMTNmMWM0K1JyY01KdGN1d3g1SitGNHQ2WmdGZ0sxL0Rz?=
 =?utf-8?B?WWw4ekppc2ZrVldndThWVnQrSExORWVwenQ2b1JoU0dWaE5OWCt0cTdZMytT?=
 =?utf-8?B?VUNmRHdqMHJSY0MvWGtGWncrUVpQbks3T2IyYzZ3L2Z1aDRvYkhjYTFOUEc0?=
 =?utf-8?B?MFlXaEFMNUNodElDY0ZxYjVzeDV5aWMwMUZxK3lUZU00bEhURVBTVHE1Z0Y2?=
 =?utf-8?B?RGoyOHYvZW9uUGxsRjFPaTB1aHJRWklWaG1yUW8wS2xoSXFHNkR3MVFFMEIw?=
 =?utf-8?B?d0tkZEd5c2NrMW83TnhPMjN3T3dOL1hMOWtXdzNUdFczdThmWHdGMDh0S2pS?=
 =?utf-8?B?Y2pvdE0vTkRkN1doeXVCRmx1Rm91NkQ2eVV3a0tZTXlVRm85M1NLM3JGQlJv?=
 =?utf-8?B?bkJPbWp3QVVGU1NMaHlsU1JLb3IxSU5LSGpjTmdFZ2R4eStuOStlQ0tFdVN2?=
 =?utf-8?B?QkVKb1FOdFJYbmVoR1hXMFlEdnpuWVFDZWxmbnhiVDlBSERjOUlPRGUvQXpY?=
 =?utf-8?B?bU1ZSkZ5SjNsTDBFNlJETU4wWGJObmdtV3kyT09yaVg3WWFWRXBjNzBOTnNL?=
 =?utf-8?B?WklzR3RXVmtuWEM3WkMwWlNydFdyN0lDVUl5dkVjaHJQTm41ZTNHMFB2QTZL?=
 =?utf-8?B?aDNjTkNxajJzbWdjMmNPTGM3elAxU2xsODRKK3IxbGd4Y0xQWTlSSlZzYUVt?=
 =?utf-8?B?TWNzSjd2OGF0a3ZLUjFOazBNaWZWVDRXTXZrR21KZ0hjVXArUWtLVlJCTW9C?=
 =?utf-8?B?eUowSEt1Y1R3ZTlDcDJGMGJvN0ZJOXVZc3YzZ2RGdDlxa2h3ZzhkeXlQdzFs?=
 =?utf-8?B?REFxSTFEdHNQTUdVTTJyU1lFbzhRR2tiaktEQk5BeXNRMDdTL2Jod1JadFp6?=
 =?utf-8?B?Qm1maXRvUlJYdldyUWtzTEhvbXBkLzhsWmlQZWl0SERwRTh3NUdZRVdvWEx0?=
 =?utf-8?B?aXRkUnNwdThqYkFmS3BiSVJvT1J6Z3NQMGk0TmszWVo5ekZ0bFNmL2hjQW5N?=
 =?utf-8?B?VlpMSlZjYnFmdWphL01aZXNMLzRrdDAyM2hPdXZuNElQMC8zMktNRE5qVzZx?=
 =?utf-8?B?NDBOa2ZHTWErSFN6ZWJFckhPN3VEVE11YTJZRUZUR0lDV3lJRUEvMmx0Q2Vp?=
 =?utf-8?B?M3NBRUIvcnozbWxrbmdWZWRHbTlBS0N3eGlkNjVuNlhSTURiRk5oMmR3dEZi?=
 =?utf-8?B?bWlIc2poU09sckt1M1BoT3NTbUZNMC9ucEU1Z25nRHZQRys5RDlnTnhYRnZL?=
 =?utf-8?B?SEFPU1MvMWRTUjZDMk5PY1RNaHlLU04xanRNczJTWHBtcDhJbytrWUtoaFBm?=
 =?utf-8?B?UjJtRGUrNnYxeDRaRGFCUy9lb1A3MWsweXZxNWNsN09HSzljdkZxOUdUTC94?=
 =?utf-8?B?OHpFaE5XZTFkRVpqUEZqcnhBSmcrQWF6aEFNOTVqdDdickRPZEQ3b0hLaElr?=
 =?utf-8?B?eUhva2xqdFJpT210YWZGR20wSTBmQ01OejFLazJ6NktoWGFMcmtxbExmNzhM?=
 =?utf-8?B?SEdVSUJ2NFNFUVFUQjhGZnI4R29hSTBDZlVSdFVNYzJldEFMZ2FBbis5bXRD?=
 =?utf-8?B?R09TNXNZeVpQMUxVaUh0R21HcEZwMi9Dbnl1aUhGakFpZ3Fkam01aUhXWHVF?=
 =?utf-8?Q?rHTSFe8YUU+ou/mkST5vlwe3Nh8ml5OojR3KEKt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0178a3d0-deb1-454a-1110-08d91088a449
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 12:15:31.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMlZiRKZhhxRfDnf5F2hVTJ24NCQ15ojheZia8pN3uKNLwUupRnpXFNdrAs/dibh6P8pL1OzgvylB8Ekqqv5QtX1GunsuzljisPVNjbiLk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3987
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105060086
X-Proofpoint-GUID: knOhPngg0WFCFqnEdu_pwUkQ-Y_-eY0M
X-Proofpoint-ORIG-GUID: knOhPngg0WFCFqnEdu_pwUkQ-Y_-eY0M
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060086
Message-ID-Hash: 2H2276QLLMY6DIICK7KQRLEXTMXEPMVJ
X-Message-ID-Hash: 2H2276QLLMY6DIICK7KQRLEXTMXEPMVJ
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2H2276QLLMY6DIICK7KQRLEXTMXEPMVJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 5/6/21 12:43 PM, Matthew Wilcox wrote:
> On Thu, May 06, 2021 at 11:23:25AM +0100, Joao Martins wrote:
>>>> I think it is ok for dax/nvdimm to continue to maintain their align
>>>> value because it should be ok to have 4MB align if the device really
>>>> wanted. However, when it goes to map that alignment with
>>>> memremap_pages() it can pick a mode. For example, it's already the
>>>> case that dax->align == 1GB is mapped with DEVMAP_PTE today, so
>>>> they're already separate concepts that can stay separate.
>>>
>>> devdax namespace with align of 1G implies we expect to map them with 1G
>>> pte entries? I didn't follow when you say we map them today with
>>> DEVMAP_PTE entries.
>>
>> This sort of confusion is largelly why Dan is suggesting a @geometry for naming rather
>> than @align (which traditionally refers to page tables entry sizes in pagemap-related stuff).
>>
>> DEVMAP_{PTE,PMD,PUD} refers to the representation of metadata in base pages (DEVMAP_PTE),
>> compound pages of PMD order (DEVMAP_PMD) or compound pages of PUD order (DEVMAP_PUD).
>>
>> So, today:
>>
>> * namespaces with align of 1G would use *struct pages of order-0* (DEVMAP_PTE) backed with
>> PMD entries in the direct map.
>> * namespaces with align of 2M would use *struct pages of order-0* (DEVMAP_PTE) backed with
>> PMD entries in the direct map.
>>
>> After this series:
>>
>> * namespaces with align of 1G would use *compound struct pages of order-30* (DEVMAP_PUD)
>> backed with PMD entries in the direct map.
> 
> order-18
> 
Right, thanks for the correction.

Forgot to subtract PAGE_SIZE order (12).

>> * namespaces with align of 1G would use *compound struct pages of order-21* (DEVMAP_PMD)
>> backed with PTE entries in the direct map.
> 
> i think you mean "align of 2M", and order-9.
> 
True.

> (note that these numbers are/can be different for powerpc since it
> supports different TLB page sizes.  please don't get locked into x86
> sizes, and don't ignore the benefits *to software* of managing memory
> in sizes other than just those supported by the hardware).
> 
I am not ignoring that either that I think.

The page size looking values above is also what the consumer of this (device-dax) allows
you to use as @align, hence why you see DEVMAP_PTE, PMD and PUD as the sizes.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
