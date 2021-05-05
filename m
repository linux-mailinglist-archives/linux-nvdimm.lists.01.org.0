Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9113A374B50
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 00:38:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3FB1A100F225D;
	Wed,  5 May 2021 15:38:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 33469100F225A
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 15:38:06 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145MZ14o106603;
	Wed, 5 May 2021 22:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=hG2KInLIA7pTpOAhka6+89fTSjD3ylqw0Ijx3nA2TFE=;
 b=MbweAFNjUGNV+cJ4WbqqqKNjzZjchhcqxY5UoOAA1OKAD3Rcg0yjC8B6NDzczgphV3rS
 DD2gZ8xJlF5qZNP3wBRUPM2EcXLJNtjEMwJXrkfz7S8Owrpg8XOiJ2LjbjLLr9wZgQqb
 hTvXoRedKXKxDZ+g1nB5KGAPqyzfHnZURgS2epAIt9WGw6TEowGX2NO/x1l+tfoTwm/R
 L8tX9QW5aAUC2j+CFFNJxqyLq+zH1SPNDnMqAmjgTNiab05J2MzKL0xyp7PIVI7BoAj0
 SuDSP+jNiCMXf9cYIiBnEHc9yrZEqmCHtQ7PAFR7mMU4pPGLKSUV8MoTNEg+YyAhixS4 5g==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 38bebc3by4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 May 2021 22:37:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145MZR34168823;
	Wed, 5 May 2021 22:37:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
	by aserp3030.oracle.com with ESMTP id 38bewrjq8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 May 2021 22:37:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QitukmL1/SFeQ7SSNdpcDWdrK2KQENAQ1oIO7gsEgCqhBL8stivWyby1NbsKJKiPF9vJW4krvx7HfyFpXSLxLA5kZ4pI8tCk9aBURreLED5G9SitDtbRFYuSIQ0x/k5fDk/TUCSpTJczcnNhah1HJqCiJ1F4MKLxJVw2yw/kJTgQhY4BD9FMubatESnHAGOukXLMFLTUmGea35zW4nuBI6o10WmE++1nrHttJcbPoq25HB1TMeXlD9wjfbgCQKqRdCxkriWUCeGQ1CTurvrOwfDpYP3g2eIjHaGPzGXiEJZ++G650Urixh4Pt0BhZKROXMVcT22Ra/e6U8U49P82Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hG2KInLIA7pTpOAhka6+89fTSjD3ylqw0Ijx3nA2TFE=;
 b=bbvX2VEJ4HafKMRvMndk40iwKdYQkuZpDoNRw3A7Xq0I+bwoTD9WeAocKGsuSIajTEBOoa2KIiVz/92i1wwTjUHUaT8Lk8uhD6dIPmT7IKXDsr+NMRaP2lb8eOkLXdOIQBR68VJp3cuzhKKLtktysh0KNh3oXLbV50Opj6tOpIeDrBx7OXiIHl+GWUekc3IvNg8FKtDb6ToAfc/MSTh60NZGj9sWpdmdfOw2qXHibJhQgkiQ4l38PoaYThG0fBAv5SLTzZdJysvTYJYkbkvdqo+HA/umL/6SH9GAM3l4Mwf6mwR+xSiwHh5Md1PE7mrmzy/zxQBc0ZV8V9yYr9fWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hG2KInLIA7pTpOAhka6+89fTSjD3ylqw0Ijx3nA2TFE=;
 b=xBoCB4it7xhIrCp9JGsL0zG2nivoOlDz3EYC6WnCQNIsfhMV8KtrdMHPNJx9MY8ykYNtz1fj9MEYRJXdB6Tg0e0gsB7G2yZX0xRc7zDmEMZDd7mhCWzcToHJ54fHJrJ7POzBp3kmQlKiC6mew5UgJBikmld2fvCOGf1EL+Rt4d8=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB4115.namprd10.prod.outlook.com (2603:10b6:a03:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 22:37:54 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e%6]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 22:37:54 +0000
Subject: Re: [PATCH v1 05/11] mm/sparse-vmemmap: add a pgmap argument to
 section activation
To: Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-6-joao.m.martins@oracle.com>
 <CAPcyv4iOh5wS04F=hftcwN1e3DJTg-qUhw8KHR=+wncqJ2KZsg@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <52195943-3344-ec9b-3c7f-1e6d415c390e@oracle.com>
Date: Wed, 5 May 2021 23:37:45 +0100
In-Reply-To: <CAPcyv4iOh5wS04F=hftcwN1e3DJTg-qUhw8KHR=+wncqJ2KZsg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: PR0P264CA0220.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::16) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by PR0P264CA0220.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Wed, 5 May 2021 22:37:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86288165-3515-4cca-7c97-08d910166c0c
X-MS-TrafficTypeDiagnostic: BY5PR10MB4115:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB411565AD5F4FD0D88AEDDDEEBB599@BY5PR10MB4115.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S1TEkQmqP2dsR0SWVhVPn9JTO6KoEQDYEkD5WpcJqnN/X0lujnuVUs8XqygZumUzcELpYSzx+8ajkh3A9Qy0rJQUU3HfIJIp9iU4/2Lbte65JPBn/l9/KwqmY3Ty7RlaI6Rdb3KjqByugLawlSVzV4pg3nBGQZr3Ynkrfslvuwj1jUoGsF1pUn1WnYO49D5GN6872xu/DtxVi6scEMLkBy14sJMi3IQpdiaTfQ/xfbwa1hH6L0ZXr0qhwRyGIGWN09KBdDkKJ2Y4/MuHm40bkOXFwN9kTOgkJYdh0zOHkeklv2+A0LaYmxw+pBH4rihHck+4XlX9XWEnqfdesI1hCC20PGXU6GBVPzVszhTZGKD6YKRyfL85BQQsll/zqLO8Z6y/Tgl2L/U2Tu2rR50HWvSKKKfjPY3T6FYPbFfOJ1t0LrQNIvHV5XVuf5fW4l4d1hRonO1n6rf2QUWs1tCM983eAoOdsOjXg4oGdmtlH9UyJ2S5h1AeKOZZDZ/LDE7mPlSD3EeTZB8VjRH/uy/24a8QBYYfHQKTQ24ovvkpW08tPQeNTufVXqg0LVtvmUdZKfIZDcxVnMJjVMHrcmwIO0nix6HVswl5fpVapKTwpjTLLBxngwNI/z7hjS3zIE0ps69wpOrAj4RlaD1F9QvtPA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39860400002)(376002)(346002)(31696002)(8936002)(8676002)(53546011)(66946007)(66556008)(54906003)(31686004)(478600001)(6666004)(66476007)(86362001)(956004)(36756003)(4744005)(6486002)(38100700002)(186003)(16526019)(83380400001)(26005)(16576012)(2906002)(316002)(2616005)(6916009)(5660300002)(4326008)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?N3RQSm01eXQydlJXc09WZ3hBQkVNK21yUmZVcjFUYkh3SXlwSVBMeFU0dW1W?=
 =?utf-8?B?dmYwdkpWWDZSd2V1VnNiWUVpbXBZZTEvYjJ3a2RvSTNQRlFRTm1qWUZpMndK?=
 =?utf-8?B?cE5RS3NnVzBJUEVWVGNkck12N0ZYaWhCRVhkZGY3c09nSkFXOC9PdERKaEFJ?=
 =?utf-8?B?QnkweFZVdmdSa25qVSs0dXlQbi9oeklhZjBUWjA2Um5ndklzN3FlWUFZaTds?=
 =?utf-8?B?UkpwOUdHRE5TWlh0ekVzSXE3UG5xSVRkQmdFUnhPQjA0azJXVnFNc2V2WU9x?=
 =?utf-8?B?RHhyNWVpSmRtZkliWVRONHVyVlZxYndKZm1JMnR0T3VVV2xER1RzMWpWTXRi?=
 =?utf-8?B?OCtEVTZtTUYxNmdLSHJMNUJNd1dTSXRKSDI1ZGZaUllKa1RrcnBQeVZTdm85?=
 =?utf-8?B?Q2tJdDRHaDJEQ3BzKzcrTlE1MjBPKzIyb1BPd2FOMGkxcHZIVm81S0JVSFNX?=
 =?utf-8?B?VjNOWDNWNDA2dTNKR05mcmlHQXJTS1g4VU5vVHVDQ0h6akc5Y0pTTytyQmNB?=
 =?utf-8?B?WStRWFR1Yk1mVHM3WjZtY1p1ajdoZnhETkQwYjByZFBXL1lOTWRSU1kySFo4?=
 =?utf-8?B?K21QMGFub1FqaTQxTkdwbWZvWS8zZnpIc09TZHozUERXWDNSc1laaXZTbmVX?=
 =?utf-8?B?cEprcGs3cEFOR3RVMFhZUGowMG0zV2JzckM2czgydE8yUVVzNzNNbjdHa25B?=
 =?utf-8?B?akNaOVBoaHJOaVVCS2FpdFZacU9jclZwOTJhL0lrOUErMlNpR0JHTkRyRjMy?=
 =?utf-8?B?MmRsMndTSU53SUErYVR2SHJDb0FyUU1iNEFHQXFidTlHNnR1TG1tWUpZclFL?=
 =?utf-8?B?ZnNFWlZ0L1dXQXFDQTVhMHl6aks4OURZOW1ZRFpCWTNPVFZHektMd1UyNnNo?=
 =?utf-8?B?RHEwK1VOZS96blhxOUdyd3N0elZ2TlU5M21hbnAxbWthVjBKWmNxdklqRStI?=
 =?utf-8?B?T2dWRkFBSUNUbjZqaSt6ZWxZSllYYWpZb1QyeDJINFVDMTN5R29QRFpqVXVV?=
 =?utf-8?B?Sjg5d1d2dWE5UnYzdWM0OVBCTzdIT1JHaWNGUit4QnNuemxtMUM0TGRMSm5i?=
 =?utf-8?B?OWhpay8yaEhabXRzZmpPV09lc3J2em5zOFlTRWhRNVdWWEZvdzF5YzJ1aXV3?=
 =?utf-8?B?OHllQUhtcWNXa1FleUdiZkFzRjFjempiUi9kaE84UzlvYWRsRnZGV0w4d2R6?=
 =?utf-8?B?ZzFCcVhyQlUxT3RYNkVuYklVZ1VrR3lIVkFtV3g1aFdMMi9sU29XdnZkUjlB?=
 =?utf-8?B?RnNySVBrcGZnVVRXUlVqTWRxN2hsenZBcUtrTGgxengxc2NPakZSeUdlNXBF?=
 =?utf-8?B?QzJRcGo4UW9XaDN3K1VPVUhmZHJNOWR0K0Q0TGhkbXlTOE14WEFKZjZaVWF0?=
 =?utf-8?B?Sk5SL1B1SmVibVZ6bS91U0QwZzlIZmZZbVNDdzZWRDRSOHEwVHUwSW1zcDhz?=
 =?utf-8?B?SkY4Ymsvdno1RXYya3k2V2xGb0prRGlYNWgrU1U4bW9qWlNKZWFNdWtxci83?=
 =?utf-8?B?YUNKRzhHVWJhRmRPd0lGc1N3Y25CQVdoVXVOOTNoMTB3TEZ1K0hkNisyTU5R?=
 =?utf-8?B?V0ZEVDlQOW1WajZhY2h0aGIvT1lOS0ZYK1B6QlJiaHAwUGRpaTdCZGFoMEMy?=
 =?utf-8?B?ekl6anJ1SEtpaEN6Ni8wcyt0WWVZVzBKZzJOZzFGaTBzWTFsTHpUMFN5ZkNS?=
 =?utf-8?B?TE9LZWdqZ3dtN1hVS2xaYXozNDV6VHAxUDZZMmg5c3drRTJFN2N1NTMyZDkv?=
 =?utf-8?Q?SKIB6ED/ob5acDxP/trjcM6lGsJD1GSwVUcdBRn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86288165-3515-4cca-7c97-08d910166c0c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 22:37:53.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lI5L08GpZvAe9qptgCdqLgJa2i0QiM2NlwdLRyPMXVnHTl1fzj/fiG7hGo56uMVZEcK0hacBSlceyLBETCcv2gl+bHNdeZCfoUTDTrJ3X3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4115
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050155
X-Proofpoint-ORIG-GUID: qCCL0sF1UPehoyFoXQXDJzijBTLkfjkH
X-Proofpoint-GUID: qCCL0sF1UPehoyFoXQXDJzijBTLkfjkH
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105050155
Message-ID-Hash: IRHPA3RH6ABM4WVCWIUJFR4HZNPYLQEH
X-Message-ID-Hash: IRHPA3RH6ABM4WVCWIUJFR4HZNPYLQEH
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IRHPA3RH6ABM4WVCWIUJFR4HZNPYLQEH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 5/5/21 11:34 PM, Dan Williams wrote:
> On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> @altmap is stored in a dev_pagemap, but it will be repurposed for
>> hotplug memory for storing the memmap in the hotplugged memory[*] and
>> reusing the altmap infrastructure to that end. This is to say that
>> altmap can't be replaced with a @pgmap as it is going to cover more than
>> dev_pagemap backend altmaps.
> 
> I was going to say, just pass the pgmap and lookup the altmap from
> pgmap, but Oscar added a use case for altmap independent of pgmap. So
> you might refresh this commit message to clarify why passing pgmap by
> itself is not sufficient.
> 
Isn't that what I am doing above with that exact paragraph? I even
reference his series at the end of commit description :) in [*]

> Other than that, looks good.
> 
/me nods
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
