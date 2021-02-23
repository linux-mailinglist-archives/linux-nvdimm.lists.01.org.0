Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02072322DD0
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Feb 2021 16:46:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B2E5E100EB835;
	Tue, 23 Feb 2021 07:46:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DE29A100EBB71
	for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 07:46:51 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NFifsL096821;
	Tue, 23 Feb 2021 15:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BfSN1ooi8Ix6K7atrzalvEVOE6V0NnDcCsvH2ZQjBkY=;
 b=o/zJ8j5NKwP0oRGKE9bWBGWIfiQMN7SL2/piucaMMZ2XjULGgtBekpG59C5OThytb1a4
 USfWx3vv0erM7ivXnvevA3VGWtudvmeeBDia1iu1WHLFslFk5aifIXZRlliW0gGb9DEh
 pZO93TLScLaeTn6dscFKZe55ziRvlBycaE479PqQE7ogm+R6kHB7NxUfVFI4CWJT/oXY
 7C1xZ3mKxQRRyN0UP8L4wQnEnUJ0fQ17ftNDQB8sR30ryttUDYZGCpGtUXdzYp0ToMok
 2vs0mNbgNHOpu0nWNmros212/PAEDaDAa/bp5oypli5kaf5fUUacnAfNTTeRhtgXLwmY rA==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2130.oracle.com with ESMTP id 36vr6225s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Feb 2021 15:46:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NFkTQT050048;
	Tue, 23 Feb 2021 15:46:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by userp3030.oracle.com with ESMTP id 36ucbxmma2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Feb 2021 15:46:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LefAAwkQu4nV3aGPqoFXi/mfhMRRhNYo7JznvZ3L7lYMnp1W/z6WjcSUWGMpZ1PHlqPtflGdG0K9oCNm24LGioxK/zMV0oAEJjoZPNR00UOXEetEOOhMhEsNaYJSkCR7PkmqU4oFlVxB521uj9n/lzVarrtcszjDFjoas+Nq3o15nGN4XERNj/9zDoNOFJcbc9NAQv50YwVfUXYv/EgQWUWESejpR8uMaAodLW7bmWT/uSeKcIEKNGXITJUUJ7NlmKck4zvCWSD9QcSl6AGHGbKKG6LAvCSufRAuj0fcegoKGOo+xUviQGV/A0010yr+IpU3prSRysa2tUT8tqO/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfSN1ooi8Ix6K7atrzalvEVOE6V0NnDcCsvH2ZQjBkY=;
 b=OSowQ08GZz1cqmI8RemlCRH2DoyZBgzeINf5PwS9EAV6IouJ+B+zIoDp0XZw8ctRj6jWFLKriqblegpfCez8JbvlSctTy8BsysZskAJpfFk9GpyDClTxmuJTJtUWkxwgvT0o1Eioso7hrbELEamyexr9n9gBxqqrXk67CbLi9fXRbq3gWjATPVYm0f2yrVVTdcCOmSNws8V8KybfRVIHfRnEYoHI23EOnS8M1OKCzIVRXv9+b9V/p+uRr6NQdt6ncmC3I0t0tmMuqrE8EzodGAXcPRuF/BygSMmyIEIyuf4g9SYknkaqFz3DdsIXFY/C5oqN94RdlmvIRpDFIyEYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfSN1ooi8Ix6K7atrzalvEVOE6V0NnDcCsvH2ZQjBkY=;
 b=sZwRjgsx+UsMZzgfFdRW2UTbT1l4sRDonAic5xztkSaPzYbNlfCL2+cck3J/Js1sGmJRv9HeDZBDbnt6d51U//fxQ8v8SC8Hg2OZ9hxOow9Y1s1qMA4PHWTuJe5w34HG1/aNq3Gnw4EjTtCYNlYlBG+TGyM6NSAP8dpokNrORVE=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3685.namprd10.prod.outlook.com (2603:10b6:a03:124::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 23 Feb
 2021 15:46:18 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 15:46:18 +0000
Subject: Re: [PATCH RFC 3/9] sparse-vmemmap: Reuse vmemmap areas for a given
 page size
To: Dan Williams <dan.j.williams@intel.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-5-joao.m.martins@oracle.com>
 <CAPcyv4ixD6_KEpuXkpeH6JNLvoahch8rm8J55o1B97ghrtcbjQ@mail.gmail.com>
 <621ff98b-cb75-e4d7-8f09-882cb2b984d2@oracle.com>
 <CAPcyv4i1YxFRFVz9itTkH7aLHR9GXdidTLDQHaqCG-n4EEzusQ@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <00b3b94c-1f12-d05e-c885-674becbe64c5@oracle.com>
Date: Tue, 23 Feb 2021 15:46:10 +0000
In-Reply-To: <CAPcyv4i1YxFRFVz9itTkH7aLHR9GXdidTLDQHaqCG-n4EEzusQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0471.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::27) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO2P265CA0471.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31 via Frontend Transport; Tue, 23 Feb 2021 15:46:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e3915f5-607a-408e-7d5d-08d8d8122910
X-MS-TrafficTypeDiagnostic: BYAPR10MB3685:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB36857A2F7226D745910F58DEBB809@BYAPR10MB3685.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l8vDulyYxZOMzGioWvr5yU9TNpjNdHiGNnKKZ5U0wbhkOKixcp778nfbwKFSzc0kYsdUoyQXQP6rb2FWAv6SOppRu3gRYXFCAGXSpfPib42b61rK1eYV1/f9nhIhqW4idPRSbFJaVkQaMrYjbLE/ICigE6sZ2yeerlRnYZusVQKkJInCbCwHAuXfSSdr6rVEpVuA+hRMSBMDdKH++CvhCpYXaEpXO8JowEtZa8+xvOo6IuOz0u1tuQMQu/UFOv6wp/qukVW2X8YTTZEMOmx6Pw5XS4XsXj92E0Fxq28gBqys/bUhw8BmGg2tOgzdMuUP1bY41DKDuh7pdHtWqTuYo81qLB3M4Bn1a7DWkH1OTtCZDep1iVLUvD6EoReayFJb/bZ9mz2+QTdyhnoSopv49sbZ8Ztx/jK0kE4nVTy0k9fjeJ+EOVL5hznsRxZRuEOEi1h+g9UxfANLqXHqIvlWXeQkn6BOdyaTauekpxso9zN+oF7L+K9uVSkEFxefkHEhF4MQl8n4XEB+0nzKSb0uFNAm+5464rZGZGefKtGaAMvSG3QkpAcPI8a8yzJxX6heTFrJBWFqLZOEYZINQtcUZw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(136003)(346002)(396003)(83380400001)(4326008)(8936002)(478600001)(6666004)(6486002)(53546011)(26005)(8676002)(186003)(54906003)(316002)(16576012)(66946007)(86362001)(36756003)(16526019)(31696002)(66556008)(31686004)(66476007)(956004)(5660300002)(2906002)(6916009)(2616005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?TkVRRmdFSXRLWHBDK0tOUE94YkNLdmV2R2VmQzlSM2NBdnlhNkVaU0FhNzRi?=
 =?utf-8?B?OEJOYU51bFNHc2krQzlkTzNSa1Urek1STnd1a1RDNXdFSUViMjdXcFRKNC9B?=
 =?utf-8?B?VWIyWlNsd0lVMyt2bGE5MWtKMW96Sk9aTU56WVBNVzBSK3Y5S0J0RHBGQVEx?=
 =?utf-8?B?NjdvK0toNDBiejJJemJRTlRTU1I0b3NPb0tRNVdLYnhJVkJUYU9id0pIY1pl?=
 =?utf-8?B?eE9HbDBZdDZ1VENZVk9EejhuSC9YMk44NkdOa2duY0lJQ05oWEpLanN2dzcr?=
 =?utf-8?B?TkxkTGx2SjRwZGRuMVpvTWFFNzgwb0hzZEZBejlRUDBjTytHRXdjd3J0YXVl?=
 =?utf-8?B?Z0VLWXBpdERIT2Zac21DVk00N2pKUjRSUmllWlF1TjhvZS84ellObm1YUlN5?=
 =?utf-8?B?WDdLeGU0MUNzVmxBbS9oNHg4RHVNMlJqZUZiNHFjK2MxeVRhdjR3bjVhVERG?=
 =?utf-8?B?NGwrZ3p1NGorWUwrTlpLZHRYY212cXpaVkE2eEdXTzdydWQ1a3owNnVBL2Vq?=
 =?utf-8?B?RHZOci9MamZQYlFMQi9vUjJoMThDT25sTGxlVUk5WDV1WmIvTFhsdldoVGZh?=
 =?utf-8?B?RHY4ZU1FZmNFajNCVUxiTDVwWG1RVE9QTEYveDBsMXN6alFKRnZPeVdxblY4?=
 =?utf-8?B?TTVkZmlYOHc3YUJyajhjL1pOMWtMVzJxaFFhcGlxYXRyM1VYMXV5dFptYW55?=
 =?utf-8?B?Y1dGa3BxenUzUjE5TmphMWtEQzZaT010eFlmc0U4dzh4bzU5cVYyWFpYdXF1?=
 =?utf-8?B?TkZERVRBZ1hzZ0VSVkcrZU0wTm5BVE9kaWhyR29aM3pzQmt0VTZDU3ltOWZo?=
 =?utf-8?B?c0NzeERaazJNaHRFMlVRNStIejlHb2gwNjRheFZreWxaNWJuM3UrYWNDT2Vx?=
 =?utf-8?B?U0RXM291WWlpVmc3TkdFMGQ2L0xYM3VlWktubGVlYnpiVXNVc2pPSHBLNzMr?=
 =?utf-8?B?Y3Z6OTBJRVdRb21jUnRyUG81bmowRlJ6b3YzOFhMYnJ0L2I5QlZxNitiMlRG?=
 =?utf-8?B?bnd3MzRpamJMVld1YlpGeGN2OXlLREZ2SnJMd2tkZmVYNUZlZ2FFbDg1em5H?=
 =?utf-8?B?YVpBZ0hrSTRJSWtuU0ZET3pMREx1V3V6cGNnbjY4dVpORVlpWFZRU0kzSXd6?=
 =?utf-8?B?MG5GNzZXUXJyRC9qMTlsZ2E0Uk5CNklHUEM1UFl1MTcyVTNzNDQ5aDBlbG1O?=
 =?utf-8?B?UVpjVUMxblUwRFJ1QVQvMVd6U296VkNVak5rVEN5T2QzVHlIRnZJcjZnK2NS?=
 =?utf-8?B?dHRTMkw5aC9QUS9hamd0VldTQWFPSnI5UU5RTTVSWVZSeEJ1NE43MWM3cE1v?=
 =?utf-8?B?cFh5ZkVTV0Mvb2lGK2JhaXlOTldrWmVCYU02QWVhek5KbVVPelFGdVZoRjRQ?=
 =?utf-8?B?YmFTTGE1ajduUGVzdytra2RXU0l6Nys5V1JPb2JDdjJLazR0ZHRGL2luWmlX?=
 =?utf-8?B?NFZvNHVhbHRGQzhFUXg2bVNzR2N0emljQVpUZjB5WXhmNWg5b0RYSEJTeENp?=
 =?utf-8?B?VGJGcHFnZE1jb3Q2cVBYZkZUN1YwaDBOL01kWE9iczBMNHcwWnczZ0c4azY0?=
 =?utf-8?B?cTZsSFlNRG9KZWpNVHpXU3VVT2poMHYrVkhlME9KaXJHVVd5SDFVTTUxMk9C?=
 =?utf-8?B?N1NOOGlBOGY0b0Yya2wzVzdZa0JlakwzZzJjRnIydHJ2aXFwUUFsdVBMRzJn?=
 =?utf-8?B?cmQxNlpMQXFFUXZtL0U1ci9UejhNcWlsaytaT1M5SFdyU1cwTURaSmNnT0Ns?=
 =?utf-8?Q?BVicFup8QoKqzhNixJq/Ut03aQdkn1MNfRnRowb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3915f5-607a-408e-7d5d-08d8d8122910
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 15:46:18.4321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFeG9hDfd1OJcl1QPwnfxkvF7NOuoFaKvpakiovYcor1mophdndpKijF+ZSC/XzTq9fKCJT1ojgVLduTHgaBB13+4G1Idw66hFXIJzvBVeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3685
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230132
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230132
Message-ID-Hash: TDGTLT4JMQOMHIWJS7DUAGRUJPSX2RKG
X-Message-ID-Hash: TDGTLT4JMQOMHIWJS7DUAGRUJPSX2RKG
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TDGTLT4JMQOMHIWJS7DUAGRUJPSX2RKG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/22/21 10:40 PM, Dan Williams wrote:
> On Mon, Feb 22, 2021 at 3:42 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>> On 2/20/21 3:34 AM, Dan Williams wrote:
>>> On Tue, Dec 8, 2020 at 9:32 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>>> Sections are 128M (or bigger/smaller),
>>>
>>> Huh?
>>>
>>
>> Section size is arch-dependent if we are being hollistic.
>> On x86 it's 64M, 128M or 512M right?
>>
>>  #ifdef CONFIG_X86_32
>>  # ifdef CONFIG_X86_PAE
>>  #  define SECTION_SIZE_BITS     29
>>  #  define MAX_PHYSMEM_BITS      36
>>  # else
>>  #  define SECTION_SIZE_BITS     26
>>  #  define MAX_PHYSMEM_BITS      32
>>  # endif
>>  #else /* CONFIG_X86_32 */
>>  # define SECTION_SIZE_BITS      27 /* matt - 128 is convenient right now */
>>  # define MAX_PHYSMEM_BITS       (pgtable_l5_enabled() ? 52 : 46)
>>  #endif
>>
>> Also, me pointing about section sizes, is because a 1GB+ page vmemmap population will
>> cross sections in how sparsemem populates the vmemmap. And on that case we gotta reuse the
>> the PTE/PMD pages across multiple invocations of vmemmap_populate_basepages(). Either
>> that, or looking at the previous page PTE, but that might be ineficient.
> 
> Ok, makes sense I think saying this description of needing to handle
> section crossing is clearer than mentioning one of the section sizes.
> 
I'll amend the commit message to have this.

>>
>>>> @@ -229,38 +235,95 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
>>>>         for (; addr < end; addr += PAGE_SIZE) {
>>>>                 pgd = vmemmap_pgd_populate(addr, node);
>>>>                 if (!pgd)
>>>> -                       return -ENOMEM;
>>>> +                       return NULL;
>>>>                 p4d = vmemmap_p4d_populate(pgd, addr, node);
>>>>                 if (!p4d)
>>>> -                       return -ENOMEM;
>>>> +                       return NULL;
>>>>                 pud = vmemmap_pud_populate(p4d, addr, node);
>>>>                 if (!pud)
>>>> -                       return -ENOMEM;
>>>> +                       return NULL;
>>>>                 pmd = vmemmap_pmd_populate(pud, addr, node);
>>>>                 if (!pmd)
>>>> -                       return -ENOMEM;
>>>> -               pte = vmemmap_pte_populate(pmd, addr, node, altmap);
>>>> +                       return NULL;
>>>> +               pte = vmemmap_pte_populate(pmd, addr, node, altmap, block);
>>>>                 if (!pte)
>>>> -                       return -ENOMEM;
>>>> +                       return NULL;
>>>>                 vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
>>>>         }
>>>>
>>>> +       return __va(__pfn_to_phys(pte_pfn(*pte)));
>>>> +}
>>>> +
>>>> +int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
>>>> +                                        int node, struct vmem_altmap *altmap)
>>>> +{
>>>> +       if (!__vmemmap_populate_basepages(start, end, node, altmap, NULL))
>>>> +               return -ENOMEM;
>>>>         return 0;
>>>>  }
>>>>
>>>> +static struct page * __meminit vmemmap_populate_reuse(unsigned long start,
>>>> +                                       unsigned long end, int node,
>>>> +                                       struct vmem_context *ctx)
>>>> +{
>>>> +       unsigned long size, addr = start;
>>>> +       unsigned long psize = PHYS_PFN(ctx->align) * sizeof(struct page);
>>>> +
>>>> +       size = min(psize, end - start);
>>>> +
>>>> +       for (; addr < end; addr += size) {
>>>> +               unsigned long head = addr + PAGE_SIZE;
>>>> +               unsigned long tail = addr;
>>>> +               unsigned long last = addr + size;
>>>> +               void *area;
>>>> +
>>>> +               if (ctx->block_page &&
>>>> +                   IS_ALIGNED((addr - ctx->block_page), psize))
>>>> +                       ctx->block = NULL;
>>>> +
>>>> +               area  = ctx->block;
>>>> +               if (!area) {
>>>> +                       if (!__vmemmap_populate_basepages(addr, head, node,
>>>> +                                                         ctx->altmap, NULL))
>>>> +                               return NULL;
>>>> +
>>>> +                       tail = head + PAGE_SIZE;
>>>> +                       area = __vmemmap_populate_basepages(head, tail, node,
>>>> +                                                           ctx->altmap, NULL);
>>>> +                       if (!area)
>>>> +                               return NULL;
>>>> +
>>>> +                       ctx->block = area;
>>>> +                       ctx->block_page = addr;
>>>> +               }
>>>> +
>>>> +               if (!__vmemmap_populate_basepages(tail, last, node,
>>>> +                                                 ctx->altmap, area))
>>>> +                       return NULL;
>>>> +       }
>>>
>>> I think that compound page accounting and combined altmap accounting
>>> makes this difficult to read, and I think the compound page case
>>> deserves it's own first class loop rather than reusing
>>> vmemmap_populate_basepages(). With the suggestion to drop altmap
>>> support I'd expect a vmmemap_populate_compound that takes a compound
>>> page size and goes the right think with respect to mapping all the
>>> tail pages to the same pfn.
>>>
>> I can move this to a separate loop as suggested.
>>
>> But to be able to map all tail pages in one call of vmemmap_populate_compound()
>> this might requires changes in sparsemem generic code that I am not so sure
>> they are warranted the added complexity. Otherwise I'll have to probably keep
>> this logic of @ctx to be able to pass the page to be reused (i.e. @block and
>> @block_page). That's actually the main reason that made me introduce
>> a struct vmem_context.
> 
> Do you need to pass in a vmem_context, isn't that context local to
> vmemmap_populate_compound_pages()?
> 

Hmm, so we allocate a vmem_context (inited to zeroes) in __add_pages(), and then we use
the same vmem_context across all sections we are onling from the pfn range passed in
__add_pages(). So all sections use the same vmem_context. Then we take care in
vmemmap_populate_compound_pages() to check whether there was a @block allocated that needs
to be reused.

So while the content itself is private/local to vmemmap_populate_compound_pages() we still
rely on the ability that vmemmap_populate_compound_pages() always gets the same
vmem_context location passed in for all sections being onlined in the whole pfn range.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
