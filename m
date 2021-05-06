Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6674E375215
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 12:13:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2704F100EBBD9;
	Thu,  6 May 2021 03:13:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 72D05100EC1C8
	for <linux-nvdimm@lists.01.org>; Thu,  6 May 2021 03:13:12 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146AALeL014852;
	Thu, 6 May 2021 10:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZBJ1/u684J1fc8mq1sfkeikNdATROV3Fn5gLtntnyYo=;
 b=DzPiFKXRIuLgkimSOiinNYOTBfqSxQaB74DfRcwlI0Jg7D+XmhEmESJ6KEEralzPKNWN
 PM6+WWS+fx4Ubf4HBx6i3Ws7BXSUHcKjs8vbzdI6nf0AcvqrO386svJ/m2W+wTgyX7PV
 djcmviglqUdxSzyB3NmhLCb9MWabRM0CKbsNS27wJM+jmVtTlkpNnQ2qvYYSii2BOhJJ
 hNKMg8Zill464VS1sVFQ2VbVlU8m6JwyS+cSOyAdo9Bil2mlUmfaGMvavKmzsYGeWMYb
 UwkL8OUhYyOfTIp/mZfzHN32s6H82OmnT3A3Z5UU+27TVsmBBwoaUCw4+3GPKWGaT+xR ZA==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 38bemjmfdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 May 2021 10:13:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146A5Uax147822;
	Thu, 6 May 2021 10:13:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by aserp3030.oracle.com with ESMTP id 38bewshntb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 May 2021 10:13:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXPm2Xpthuyqi/NutL93OX4uWDfH221MGrKoJF1loHFU9aBJcuJUKoKR28WvU6hs0LdUQPrTggTASIpeHiOdsXu3Xsvp3TUzQMOgcmB2EdC5A6j4J7u2TEgBAMHhkd97snAzqjs2RBdqOshKooM0MLI7i9qRpv1p3YrRPDlLqS0yRFKPE8EENSdV3WQqmFcLUB6iNC8O6luz+C5XTYQz15jY6e0DoWmAJfZ4x95S0d0VXsDkdhdkacvs2qEw3cnYIjK+iFJI2aGpTVjSCbHea2YW2OurYmiid5GVaJTBBtWQG1KJLhA9BQB4XMQyNlfYRhotwQwkizd/E8Z266gZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBJ1/u684J1fc8mq1sfkeikNdATROV3Fn5gLtntnyYo=;
 b=geHALSGBjIIhByNC1yJ/Tdw75dOviZW0YoA80Hrs2/UOpwnTtJw5c7/rwbYgmR+i/uXFnzXN3uOUMkJtIRtnHG6U8Du1OMGsjKJFDtaG/SFQj4c10xYN1KqQ38lFUETmlEf3Oras4h36N9doD2+TDGkiP+cPrh4xzDNvv+dGqXN2sVzK7QCCD+20tbmjbva0Q9pRoy3nzCtEVH85QY+wlYs/q+NccHxitHgmkVA86y9hA+5t8lX4KDlMi4S2RMB/es9Vi8cVgEwyOanOzGKruz69X9Gu8XtdacWBm5wLdYRikz6FPpG/qdluQODYmAO7AjbJ74ll0aed0LYA61D2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBJ1/u684J1fc8mq1sfkeikNdATROV3Fn5gLtntnyYo=;
 b=swYdFfbiaD2fOPprYA8Yio0u0iUej5t40VGM/KOQxP6AF+VpqE4gEV/pVVwagIxMW6Bd9FPnVQ5bHIIU1mZ0fN6QGGPodvdQEW3W61tUhRIEgFLb0FWoV4znmGrXRKq9x+RwSvGsbWdsVCkIix4e4k0qe806Ql2yruqSeZYmp3k=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB4211.namprd10.prod.outlook.com (2603:10b6:a03:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.42; Thu, 6 May
 2021 10:13:02 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e%6]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 10:13:02 +0000
Subject: Re: [PATCH v1 04/11] mm/memremap: add ZONE_DEVICE support for
 compound pages
To: Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-5-joao.m.martins@oracle.com>
 <CAPcyv4gs_rHL7FPqyQEb3yT4jrv8Wo_xA2ojKsppoBfmDocq8A@mail.gmail.com>
 <cd1c9849-8660-dbdc-718a-aa4ba5d48c01@oracle.com>
 <CAPcyv4jG8+S6xJyp=1S2=dpit0Hs2+HgGwpWeRROCRuJnQYAxQ@mail.gmail.com>
 <56a3e271-4ef8-ba02-639e-fd7fe7de7e36@oracle.com>
 <CAPcyv4jGgWMoQQnG69UVRt=DW8ii4MLc-vVO2qVLbyCghGu=0Q@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <2c0fe38f-ac2e-7f65-fca8-93d722fa4a4f@oracle.com>
Date: Thu, 6 May 2021 11:12:54 +0100
In-Reply-To: <CAPcyv4jGgWMoQQnG69UVRt=DW8ii4MLc-vVO2qVLbyCghGu=0Q@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0297.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::21) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO2P265CA0297.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a5::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 10:12:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41c963f7-1862-4065-887c-08d910778829
X-MS-TrafficTypeDiagnostic: BY5PR10MB4211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB4211F82245B246857D3F9375BB589@BY5PR10MB4211.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AmSgYHM6+f6K7yhv6eWanB9+iITVpO/vSmyWdTIvK6u/KU8z+2Sy8aPpfLDO2/nGOtWJmsVX7V/RmeKXpbkA3OHu66CRH1BStXR2aRn3nkoS7NcxKOZmdED0fdjX3K+p2D5kcQamY3aye+S/bx9lcvudRmcZDbqU5Ni39CdlaKxKxEy6I22U7O+Dmrw1JHi6FPBUca0h2+ZXuCiUCBd0eZeoDPNcak52EEAbPuQQ6rSt3EfbGQXcZMnhSXW0QJ0CmxzF/XWCJ0id0tnkSQ0ehIV2gFf5eVGCoic53zJE0fh4GXTZtGY5wB0bI8Gqg3BxaYDGhFasS+J2707A7DQybw/CpqbSOR3q0J852Fy0Zkm7YmdB0KSPHHIFt4/cbAUlSVGNQzPO5JSvC9EYiugiJ83x1lubV9uBa9xr0rhVrFw0q53GOlkHenfft4bLWHYW/YooDTLRF4U3E02Ql+FnolN+I9AmlHv9wY58X0PmIyddxfVNkXOvn0Tjr++JhLiGm+pDLKMB1X5mtRPfq8tODMswWNk0c/z8NBwC/dgdLbJyYToUjT7Q441Mv3Q257TseV4oddp9FT2pQ41wfdobHnPK14Be4dfuFOZBR3tSbT7OV5roXYRJ4kYzc4bMYNN90xgXRhWaMBVePlF+AbAgvQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(376002)(136003)(396003)(36756003)(53546011)(478600001)(31696002)(66946007)(86362001)(31686004)(4326008)(66476007)(66556008)(956004)(2906002)(16576012)(16526019)(38100700002)(8936002)(6666004)(2616005)(26005)(54906003)(186003)(6486002)(8676002)(5660300002)(6916009)(4744005)(316002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?eHBYMnNTR1d4SU01MTh6VHY5UjdxK3huUVBrWDhOYlJ4dmpFdzR1TlhCTC96?=
 =?utf-8?B?WHdtaVVqbGsxVGp5QkR4Tmp3R0R2WkwxZmRIaTN0ZXlkZUkzT2pOQXJJMjBD?=
 =?utf-8?B?MklCcUZ0QXJOOU96azRLaGpqSkZ5dHo2WTJpdTdSeEtWM1h4VEx2VEN3Vk5h?=
 =?utf-8?B?WHJrVndUeGlFOFBoeHpwT09vTkJrTFpZSEVxY0tORUJXZVU0azUrcWNKZ2Rs?=
 =?utf-8?B?cHc3c01KL1A5M0svV2xoM0NrWUtYMHhCckVwRTN3STArb051ek1kRUFmZjh4?=
 =?utf-8?B?TUtCbi9LdEwvWUhlazQrME5tYXdqUVFJZmgwRXplZHVGc29iNTRHNnE2OFpX?=
 =?utf-8?B?SVl5OGx5aTVWUDJmMHkzcnkyTlhOUks0R0FKZEVWZ2R6UlVFVGluQUQwcGY3?=
 =?utf-8?B?cjFhMTUrMG9LYnRRem1FUjZ3L0NtZ2hZTkdEb0RnNE1Ham53ZWdzUDI3SUMy?=
 =?utf-8?B?WGJOUURUbUlKMVJtaGZ4d1YxTFhZWG9tREtFNUQ4STV3bFh0WTcyaWlrWGV3?=
 =?utf-8?B?UENaOGprU0xjM1Vqc2JwK00xTUsxSmNzMXUxZFNTVzFhNFV4L1Y3ZTRONXhH?=
 =?utf-8?B?aWtkcXhXa1plVFdPcG9oTDNQTTlQWFc1TzNOc2krbTlmcnhRZ1RVNHZHdzV1?=
 =?utf-8?B?TS9RRXFWd2ltNG1PdGtVMDkwd2s2Z0M5elI3SVBtR0FkTUVqR3ZzbDd1Zmd6?=
 =?utf-8?B?WFh2NTZObzBwYnBvQ2huUktyUGt1MG90UWg2YnFITDN1VDVPdUY1eTRSNld2?=
 =?utf-8?B?Y0tBLy9UZmYveEp0MnBOMXJsSE9hVTd1TVFwNHZqMFQzdnFZSEZGMGRDdkU5?=
 =?utf-8?B?N29HeDkyWStCVi9Ubm85S0RFbzFzMEc2L2oyOFZxNVNxRDQ0RUUzb0NZYzBX?=
 =?utf-8?B?T0IwaW1RU0VOd2RaTzNPbFBoUjJiOGRBemYvRUpOaURZbU1aMWZubFFicVRM?=
 =?utf-8?B?cEZLdXBnTWtuUThuOUQyem5kdGYxY0pUdXdXS1E5TTRnaittbmFoMDBqMDZS?=
 =?utf-8?B?TmxQU0czSFNJeUFqSjBJN1IwdG4waXVmZk9oTGV1L0tWQWFzTENoc0toWU9m?=
 =?utf-8?B?WmZ0M01IUHVrQVIxZDZrbm04WTBqeUVETFJ5STJYTUo5MHBZU1hkTnVHeVJz?=
 =?utf-8?B?SDRuTnVzOGd3Z2liZy9EWlRIZVduVHN3Z1lpV2VGbmJQZUtGTmRrODNCU1kw?=
 =?utf-8?B?SUlqQUhFY3lWNGk1bVQyRzFySDRleWpseGZmdHhGT050VVVadW5nZmFTcUlO?=
 =?utf-8?B?Ly8yY08rZ3p2SW5KaGJXdytnT3FTWmx6T1VGTEhKQTZLcGxFeGF5ZFhOUS82?=
 =?utf-8?B?WXovR3MrYXo4eXRacHZsZUs0bXp6YVkyY2lYM2lCeHNOeVZFMnhVMEJiY3hE?=
 =?utf-8?B?bzMyeUVxTFlHOFB4TExMYm5ucitiUllGRE54bG9GM09YUGd6b2s5SVk5Ty9I?=
 =?utf-8?B?V2NyS21BV2REeHVRc2Q1NnA5aTdzUUJ0elZPOTJ4NDkwUDZCTzNrR1ZWcUlw?=
 =?utf-8?B?VDN4UDV6OVY2aVNxL0lDRzA4WG1EVkdubTY4TUJFTnB0QUI5SnlWQWJIQkNV?=
 =?utf-8?B?cVhHZmVmNXRIL2JHV1hwR3NzRmhlS0NqaGkwTGV0eDJRTnhYNDFPVXcwSk8y?=
 =?utf-8?B?Q2kySDZ4RlhONXUyaDVRWnA0c0RTNVFUWTZ3ekxnTExzSzdYR3ZGZTNaWFBR?=
 =?utf-8?B?OUU3Y1RGUmZoSWxwb3FBV2FIbzY4ajM3dmwvMVhGZlgvZk01dzZvYWN3TUhO?=
 =?utf-8?Q?7ekn1jbfPt5+kzMbaoJFxIEjZ1v7VLrTvZ+P32m?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c963f7-1862-4065-887c-08d910778829
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 10:13:02.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpKlEJy8+CXfnKqBSaIqNa+16IRMuPLjNNjeA/4hY03YABqN2tRw6ZCcwqU38jEprsq/pv9Y9n52d+vvDS6MeiQtMjoxPYnnWmdWF0XBwLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4211
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060069
X-Proofpoint-ORIG-GUID: J0U5dfgug7n4LHAbeEKrNPbm3hBSFmTf
X-Proofpoint-GUID: J0U5dfgug7n4LHAbeEKrNPbm3hBSFmTf
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060069
Message-ID-Hash: 33YMCRAHPALYJ47L7TLDIOHVWVZVMOZA
X-Message-ID-Hash: 33YMCRAHPALYJ47L7TLDIOHVWVZVMOZA
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/33YMCRAHPALYJ47L7TLDIOHVWVZVMOZA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 5/6/21 12:03 AM, Dan Williams wrote:
> On Wed, May 5, 2021 at 3:36 PM Joao Martins <joao.m.martins@oracle.com> wrote:
> [..]
>>> Ah yup, my eyes glazed over that. I think this is another place that
>>> benefits from a more specific name than "align". "pfns_per_compound"
>>> "compound_pfns"?
>>>
>> We are still describing a page, just not a base page. So perhaps @pfns_per_hpage ?
>>
>> I am fine with @pfns_per_compound or @compound_pfns as well.
> 
> My only concern about hpage is that hpage implies PMD, where compound
> is generic across PMD and PUD.
> 
True.

I will stick with your suggestions.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
