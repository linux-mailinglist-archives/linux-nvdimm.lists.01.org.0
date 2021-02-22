Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BF13214BD
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 12:07:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 90A92100EBB7F;
	Mon, 22 Feb 2021 03:07:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2B248100EBB7E
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 03:07:27 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MB62FG072433;
	Mon, 22 Feb 2021 11:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=I5d1iyLX4D5pS0E1bQjbNPm+NSurUWlqIXdyWKeSRwo=;
 b=OZiUvodSXUYlonv0Frdk9XAH6wpAjUgDDBcGJyb37XVffUl6Stb99kZsp4iQzUJ5u1I1
 AfjnoM4V1KybDsfRfET7dTo8WdoqDfc67IleIgFhV/kQkF+7ox4N5cOiCrdA1+LetsTf
 XgpZ4mI2K3eKoUJIKUT1sSWopGU92JSXaSAx98Qlq3aH69eGsnxXyqfzdqjBNJ3s2una
 Xkp/EWzoA1dPknCZYFnv9OKE4jm76Uu5/evBNvWIHnHJW+D96Qbe8FTjuGTNnAlMFHy4
 xtunrjg6cRNHv6Y8agI8ORmxpaoYSsfZGsrXJIuFu/kcL0z9h+JcdX6ScqppMp+39Usl dg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 36tsuqu8vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 11:07:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MB0Xv6011994;
	Mon, 22 Feb 2021 11:07:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by aserp3020.oracle.com with ESMTP id 36ucaww1d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 11:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRWMmiZgFZfrZZgsUE9C7EKlx+ws2rpf5zz7GZWG4+4gxZ/HS0HJpHCl5zzzsu5Olu00knux0C2u2XM9fMJYitv9Lpt3TZDGBYx/6ipIeYyozuVCdEpHLYkeMi5JrbpatWXE2tElxvtEkao1nOUThFyiCJzCEaw2uQ+Apw5NHirhsMGz/+tCQrhakBE0C63ileqIlckQilSJDKViAGLzMOotr0mddxavf1xpdLlGuRmRMocEOXRyUsFKM7+BuI2GvQ3OAxdx0LQdvVbxIltDI7Lmz32v9tqJkV4IhFd/qYfNl41e01tDng7d52pzzv5jjKsxOORa+eAFaC9dApyE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5d1iyLX4D5pS0E1bQjbNPm+NSurUWlqIXdyWKeSRwo=;
 b=WwWEVLFhesdexBWTkcBWcgg6JIOiVtgAkyzLQYiPVoTa7DbY1EkKGZqUSM9+MXEpzUAmGbjvbIKPEPmkMVIMWgMtRpbT4tPDvg4PNaM5bhe0nS87zUmQx80nGchrJTrcw0n8LpEmoLAdnNMZttu5rcRab0Sl7sjZKtmaH5ej/0jnnPGOaSNwlE7LyZyszNnoXJlcxIpmLtIXJ8qbpRCCPcb1OwSkeV0qhMu2lU0IGtjWhc67DvXigM405Gj1enBB2s3wI9BoXArjUPA4sRNvYsHZl0AA/VjQdcO/mOtfTM+uDTfzfmHjrTOqLkhZ8TeSrw8ByBJ9RPTGsBrIk+RiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5d1iyLX4D5pS0E1bQjbNPm+NSurUWlqIXdyWKeSRwo=;
 b=DBiABfvWFFpoHiG6sDLNHD7+Baunm31Y0/YJti+QEYzrxnSE1pXxBk23l61naZhYbR5QjE9nSjJFfAMwI7ndLvVrozoDkLlo6b+7PFTFCyxa1KLZeRn9UxEsv2ssdUTjoWZ5uvn4rZ0N+4Ylmqmy4zzuv2Uuc0z8KAOeWj01pkk=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4592.namprd10.prod.outlook.com (2603:10b6:a03:2d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Mon, 22 Feb
 2021 11:07:05 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 11:07:04 +0000
Subject: Re: [PATCH RFC 0/9] mm, sparse-vmemmap: Introduce compound pagemaps
To: Dan Williams <dan.j.williams@intel.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <CAPcyv4gQQ03-nhBNwLK6KDc953SVD1rOs7HFBo_Mu9LFTkXRgw@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <ca888299-c576-567b-e6c3-5df3bcd8ca51@oracle.com>
Date: Mon, 22 Feb 2021 11:06:57 +0000
In-Reply-To: <CAPcyv4gQQ03-nhBNwLK6KDc953SVD1rOs7HFBo_Mu9LFTkXRgw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::10) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO2P123CA0095.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:139::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31 via Frontend Transport; Mon, 22 Feb 2021 11:07:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd5a8f6a-c901-4863-ae1e-08d8d721fcb8
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<SJ0PR10MB4592528B0E5F346F6110678ABB819@SJ0PR10MB4592.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3Dl+ERsJ3sujqElFKi5IppvW45W254Puzl37/4TE3uFx7vKBp6/j66C0PBillRJcWyoXS0I6Mg0rSOCRvmDwL9KTAPl9fMRXTAim9/c77EkXl/8tJLS+TZpHhvc1ekTKxqGyRhi5DjVd+XsldvnHr3RbkwIr7N42YuEXrrdlezLejPW87AahT8feQyuNpY6py10c3uzh5a3y3eP9pDGra9l8rrXwo4j0zL+o0926Yyb4j4CShCjFR8GfxqsrCfE8ekZeLu+BTP8NTnVZOAPEV0Ki5Z29Cf1eFVasli8U5+BRQn41h1cdUmb8scYIzNbBDMAfMJgnR/uQhl6KK5hSDjfVUcMNopcM6/KeRynZptBERpr+1fB8TkqKFsloR9oN/pjGZILFaoQeZjvJZ+DBw67K56vKczwhwTeLOeuswe+pZOPYCN3BSqV2AQyJ2Z76AiliXv1Lx/ld2H/fnPsfkcOC62XpUWDAZNvH6ICuSS8qdhwkmlc1RtWifGEjX8cHw76AEKb0nPE8rbuvm0iMdVLpqHubsxhM/fyjBrDtFUK5PQuVnIW3ZBCMN7LYPKx0zqN+YXdb8UIAWkaQbZ/U4HdLZQ2D+EgAdsYasROxRexMCmEHKaYzUREWDQhCvNAvpUQlMnQzeSQLbYlONRhUnYU/h0SF/YT2GDLyo1AP4Eg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(366004)(39860400002)(16576012)(316002)(478600001)(54906003)(16526019)(8936002)(2906002)(186003)(31686004)(4326008)(31696002)(83380400001)(6666004)(36756003)(8676002)(6486002)(26005)(53546011)(966005)(6916009)(956004)(2616005)(86362001)(66556008)(5660300002)(66476007)(66946007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?Z2ZDdS9PeGFPSnF1dVdtRldWTFNoNmQ4Nm5tb09jdm5HS0ZWY1VianpORFNJ?=
 =?utf-8?B?dkRRVlhmejU5bnh2M08xVlZqcHFSSFYxazk0eFJRVzA3NWtTSEt1MTBDdGxQ?=
 =?utf-8?B?ZkhVRGFURDl6RnRQbWQwWVoyZjBMOEViZm1KWStmQXNDR1VPYmdUVDRWY3ht?=
 =?utf-8?B?VmhuSElQMVN5UzNpT2VodXhGdXhzcGptbjdvVWFZdGZldG1MS0xhazE1Z1o1?=
 =?utf-8?B?Qzl2S0JlcHVXVm16di8yMlA1V2pVdjU5OEtNYXIxT21VbTRlamZqRkhOcEZT?=
 =?utf-8?B?NTFiclJycEhJYmRrVzd3NTAvbWc2RDg1OGo3YXBjZHZzUEVvMmNUT2V3aGdF?=
 =?utf-8?B?UXZBYTFRc0pPTkhZUUJVMnJTaTBhTjVyUi9Wemo0M1ppSDZQWnZFOUI2YUxz?=
 =?utf-8?B?YnZvK3RKVzhDNVRMcjFlN1VGak4wN1JJN2ZOSUIyUzVzQjJzeXhhbys0WCtS?=
 =?utf-8?B?MWxSWTZ6SVhKTmk3bjhFZzNGZGJ4N2hhNm9sVkNtMy91NitkODhJektIS3Nj?=
 =?utf-8?B?aVROMEJVU01tOGJ3SGdrZ040YzFrTEdMZlhXUVhOY3cxTkhVMUg4OUFuWWJG?=
 =?utf-8?B?K05yejk4M0V5ZnVkZ3NVK000QUhEZzhneVU3SFFtYnY4VERVa0gwZHk3d3lj?=
 =?utf-8?B?enFPVm1JSnZIRjBsaFZvV1lvdWoxczFyajVwWHhheXVvL20yc0c2ZTRuR3NN?=
 =?utf-8?B?QStOSTdBLzRYcWpYZ2VlV3VxVnFRYWZXcm5tcVlQb0piOW01S3paTGd0Vlhm?=
 =?utf-8?B?RGY4WUxLUXB5Z0RFYks5c2JPUUhqU0ZkYlpodllyVDQyQkJ6aGw1bGtoNys1?=
 =?utf-8?B?Z1BhTWdvcDR3N256UWkydkJGYytCSklJVlhWNXlxN0pqSVlEQkxKNjJlUGtN?=
 =?utf-8?B?OEluM3ZpTjBwZFFmU2hUd1dHdUZrN0RDcExBWDNKTlJISVVjWWhjbkQyOVAx?=
 =?utf-8?B?bjlkSmp4ZmlyV0pBSDhMTDY1SEk5cGQrbEpLTzFVUDA0NW9pdnZ5ckF0dkp6?=
 =?utf-8?B?SldQRmxmY3lva2FqcEZNTks1WVRmWFZuc2d2OTBidDZTcnB3KzR5V2xCSjUv?=
 =?utf-8?B?NlNIc3ZCbVExbGNtdmhwVG82aHVtYW03M1hkb21vSUcrVDVlcElkOVlPbFBT?=
 =?utf-8?B?ZnU0WEswa3ZOQUxUaFQ1MWF1cHVab0RYUmJXbnhpSzhwbTJZeVlxcGF3NEtB?=
 =?utf-8?B?S1dsVnVUbEpkUFpPV09iRUIxMVVvdksvU0RGaGl1RStFNkRSNE44cU03M3Jw?=
 =?utf-8?B?QkFSUXdlSURVQ2pQRzZCenptQTRYMXU1YU5kV0ZjYW9rR0ZHUUFweDI0VVFK?=
 =?utf-8?B?MGd4OThNREtIY3FDcHZNTDlQclJ1WmhGV0tjOGlhSkRyQjUyN3dIdzBHeXBX?=
 =?utf-8?B?cU1kSmdqOFUxa1JPazQ3S2tsQ3RURG42SExnREtIUlpOK2pYdEpGTDRqbUlM?=
 =?utf-8?B?eVJCamJ1cXFvRmU4ZUdkRHRGK3lzKzFKNndqYWRad1o5clJMRUtpbmxXQTln?=
 =?utf-8?B?NmJSSm13ZmF4WklRbkNyMFlHenlXRGJvTlpCUHNHcVlPVTAzeFRJRUVqbUJO?=
 =?utf-8?B?M050ZFRoSitXK2Q0N1FDK3lPeE1SazEyaFVYRzgvQllyZ2dUNlpldEg3VTBY?=
 =?utf-8?B?UnRYMCtqYjJLSEFoWFJrc3YyRlVDU2g0Z2RBVnEyNnhmZzNIbVNmSmtDL3R2?=
 =?utf-8?B?Q0U3bnZZSitPK2h5SWd5L1hHdGZ1R3VzMW9tUEZnS0NlakIvQnRRS3grdEZs?=
 =?utf-8?Q?Jb9U3FNNfbRzhrsw35/LqViSWec0IuWFgo7WkNA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5a8f6a-c901-4863-ae1e-08d8d721fcb8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 11:07:04.8148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dk8i9eSmmAp6fBymjO0+7wbv4KhU9fFKy2Zudv4Vs9+jNFG9k+9pacglcRmIfS2q913wK6Br2kjcikjyJwX+xp992B3AiCXn6TUpZGP7LJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4592
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220102
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220102
Message-ID-Hash: 576L3SUOJKQEJR6NLKMZWJZTZX6AHAND
X-Message-ID-Hash: 576L3SUOJKQEJR6NLKMZWJZTZX6AHAND
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/576L3SUOJKQEJR6NLKMZWJZTZX6AHAND/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/20/21 1:18 AM, Dan Williams wrote:
> On Tue, Dec 8, 2020 at 9:32 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> The link above describes it quite nicely, but the idea is to reuse tail
>> page vmemmap areas, particular the area which only describes tail pages.
>> So a vmemmap page describes 64 struct pages, and the first page for a given
>> ZONE_DEVICE vmemmap would contain the head page and 63 tail pages. The second
>> vmemmap page would contain only tail pages, and that's what gets reused across
>> the rest of the subsection/section. The bigger the page size, the bigger the
>> savings (2M hpage -> save 6 vmemmap pages; 1G hpage -> save 4094 vmemmap pages).
>>
>> In terms of savings, per 1Tb of memory, the struct page cost would go down
>> with compound pagemap:
>>
>> * with 2M pages we lose 4G instead of 16G (0.39% instead of 1.5% of total memory)
>> * with 1G pages we lose 8MB instead of 16G (0.0007% instead of 1.5% of total memory)
> 
> Nice!
> 

I failed to mention this in the cover letter but I should say that with this trick we will
need to build the vmemmap page tables with basepages for 2M align, as opposed to hugepages
in the vmemmap page tables (as you probably could tell from the patches). This means that
we have to allocate a PMD page, and that costs 2GB per 1Tb (as opposed to 4M). This is
fixable for 1G align by reusing PMD pages (albeit I haven't done that in this RFC series).

The footprint reduction is still big, so to iterate the numbers above (and I will fix this
in the v2 cover letter):

* with 2M pages we lose 4G instead of 16G (0.39% instead of 1.5% of total memory)
* with 1G pages we lose 8MB instead of 16G (0.0007% instead of 1.5% of total memory)

For vmemmap page tables, we need to use base pages for 2M pages. So taking that into
account, in this RFC series:

* with 2M pages we lose 6G instead of 16G (0.586% instead of 1.5% of total memory)
* with 1G pages we lose ~2GB instead of 16G (0.19% instead of 1.5% of total memory)

For 1G align, we are able to reuse vmemmap PMDs that only point to tail pages, so
ultimately we can get the page table overhead from 2GB to 12MB:

* with 1G pages we lose 20MB instead of 16G (0.0019% instead of 1.5% of total memory)

>>
>> The RDMA patch (patch 8/9) is to demonstrate the improvement for an existing
>> user. For unpin_user_pages() we have an additional test to demonstrate the
>> improvement.  The test performs MR reg/unreg continuously and measuring its
>> rate for a given period. So essentially ib_mem_get and ib_mem_release being
>> stress tested which at the end of day means: pin_user_pages_longterm() and
>> unpin_user_pages() for a scatterlist:
>>
>>     Before:
>>     159 rounds in 5.027 sec: 31617.923 usec / round (device-dax)
>>     466 rounds in 5.009 sec: 10748.456 usec / round (hugetlbfs)
>>
>>     After:
>>     305 rounds in 5.010 sec: 16426.047 usec / round (device-dax)
>>     1073 rounds in 5.004 sec: 4663.622 usec / round (hugetlbfs)
> 
> Why does hugetlbfs get faster for a ZONE_DEVICE change? Might answer
> that question myself when I get to patch 8.
> 
Because the unpinning improvements aren't ZONE_DEVICE specific.

FWIW, I moved those two offending patches outside of this series:

  https://lore.kernel.org/linux-mm/20210212130843.13865-1-joao.m.martins@oracle.com/

>>
>> Patch 9: Improves {pin,get}_user_pages() and its longterm counterpart. It
>> is very experimental, and I imported most of follow_hugetlb_page(), except
>> that we do the same trick as gup-fast. In doing the patch I feel this batching
>> should live in follow_page_mask() and having that being changed to return a set
>> of pages/something-else when walking over PMD/PUDs for THP / devmap pages. This
>> patch then brings the previous test of mr reg/unreg (above) on parity
>> between device-dax and hugetlbfs.
>>
>> Some of the patches are a little fresh/WIP (specially patch 3 and 9) and we are
>> still running tests. Hence the RFC, asking for comments and general direction
>> of the work before continuing.
> 
> Will go look at the code, but I don't see anything scary conceptually
> here. The fact that pfn_to_page() does not need to change is among the
> most compelling features of this approach.
> 
Glad to hear that :D
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
