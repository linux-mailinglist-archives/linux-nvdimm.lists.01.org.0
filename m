Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B0237524C
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 12:28:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A470100EAB44;
	Thu,  6 May 2021 03:28:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 87B26100EB34D
	for <linux-nvdimm@lists.01.org>; Thu,  6 May 2021 03:28:10 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146AK7bk032832;
	Thu, 6 May 2021 10:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8xr23SvbHtbLfMGhVZB7EJfXMxNcZNQ0aEp50nuxcF8=;
 b=UNwvc7goJ50xDHisv5/zD+6PotImOQHoulvAHmZDaIaZ63RxDKgC24WrdSR+nK1ShXlT
 aAI2OsXyypj+wgMtyYlnmvzQVIVor8WkOLE1J28gN18Kmiy8Ri8VpdVpwPhfB64gprWr
 X6OwN+obitgNuBuKRtYhyn93nnyOUE3ONpsqKBZfbzySFfVpWtBFgvdJs0TLqMOtkXOm
 vCGnYrbFiBa8QPUVKnMd6RPeJiu7ufpeX2yTdc3TkB8FZKjB8XIGWPQBv9GKj7SeKPtS
 0I4EpbLvMMNc3/qnsYqj1MzDfKrjJSrjA62FkJ9bh3u3fISKsNYZvwjM17ix9oElme1d 7A==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2120.oracle.com with ESMTP id 38bemjmgh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 May 2021 10:28:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146AJeuw054802;
	Thu, 6 May 2021 10:28:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by userp3020.oracle.com with ESMTP id 38bfutc6qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 May 2021 10:28:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAk35kNBWzl2h6rrf6tbEhSoPKg94569ZHJPl3/P0r7MGTLfy6NHRM9y/i0MmcZSQ4VwkBSRFnfmg769b+ej5JRkr1HhJ/8O6u2gn/12CGcKx5qY4DSnIronZ6gfDnPJieOjkRyjU+DZIdTH6Ksegs//9sOGq0IT0QOvohhRWBlmwdAfDr3u/PnIT1zNrmpkSqaeWDe5Gvo0piuVEvByrBzSjRUx/kBoH6Mv2hbwuzIitvfNebGRuDOvigXBm9TzauefrVnU6J0RTKFb/F148YQuE2nK4nvZ+hQkQbDtTvGg7iRI/muazTjwOC++UyP6JlGevPT7nm3f0Efolh+wDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xr23SvbHtbLfMGhVZB7EJfXMxNcZNQ0aEp50nuxcF8=;
 b=P0mk6jTHq1s1kx5aA9AsW7+6wLBmbSCoCJzelA6rK6RHkCIdY2GnZc2biR3Du4ro+/tiWcRmZdO9LHFVnOlyfFp9/NKw8zeQlVHTp0Z/qHAX3y3vJ6TYRejxUMDXI2BePfX+F2Qkl5xYxPYsfsaiKUEODQW3MwXMTd8qvYvvBpZL+b4DAAEbmGum4d2nQ/jm8bcousI1Pk0YpgfCkeFcAQb6qI304kpD41YkSxs9EVwzo9d8bpWrUd9gl07NoZ86kfGixRiXVB8BXdivrHosqEutypsTjQJyU7MLYg/oJFeVmkriD3gHrEkJ//Orm/hOS5FWcd0DR0ZduuFBFpSGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xr23SvbHtbLfMGhVZB7EJfXMxNcZNQ0aEp50nuxcF8=;
 b=n1vs/ogTRe+CQE7ziviM5wbHGrFbgGSuyrVlHVQIXAuKQhuIfubbfkR7pRJe/KU/bF/54UODS1ADWBNDRV/lrFls0nhupiBQJpuT3vh//WO19FHVfZGQKRUzQWB8cA+TM93pH6Vz/nPsddqhfW+vUgsA1eBtEEZ2oAgLZ/4psxs=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3735.namprd10.prod.outlook.com (2603:10b6:a03:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Thu, 6 May
 2021 10:28:00 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e%6]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 10:28:00 +0000
Subject: Re: [PATCH v1 06/11] mm/sparse-vmemmap: refactor
 vmemmap_populate_basepages()
To: Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-7-joao.m.martins@oracle.com>
 <CAPcyv4gf_gc6pGSZYaDp3A++enFF1aTdDVA2YbxHX_v_TM3rpg@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <ccceef6c-e87f-10a5-1cbb-d2b2e65823f1@oracle.com>
Date: Thu, 6 May 2021 11:27:53 +0100
In-Reply-To: <CAPcyv4gf_gc6pGSZYaDp3A++enFF1aTdDVA2YbxHX_v_TM3rpg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0176.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::19) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0176.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18a::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 10:27:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c6a0299-2c21-4e74-6623-08d910799fa1
X-MS-TrafficTypeDiagnostic: BYAPR10MB3735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB3735685A9A7097C4BF2F21D5BB589@BYAPR10MB3735.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2QZBMUrf9V/KluwU7Odjt0mH+smytS503bGSeXxTgJauuiBooitXUWn8QrUQ5cA3XQAF4LhzMDUCAuYEtYRF29WCPhZz8zV2c2cEg4Bh+Kn/rswuv/o7DTErw0Gvf4bLDZN7RuCoGV/KUtKpL034R/K5EKz0I62q+5DV8I29O0U6AKd0FNk6YdA4TM5EDEeuW4rTJdPv+Z0L7jFf0jTGcIdbw8ZEeI+0JDWd6BOShSJR/4Q6amBy+a3pB0KL7k6GNodW1NmuELZZh+ImrLx9Q6apnS5egHGbVvXzXP66WfGN0SefOqEljs8KHeQRG7Xwns3WIiDRK3V5hpb8ogg9kkvQhWMWWclyQMMrshMhmtS5nGce7IBP7SfXM6rZ+yXnGnResPPa5Y1yr0DlOeMv4+YEtq5a7svLM10LTrZodv7CNf2xXHOTIbth91LVjSFWSVMEVZd139lv3NU49GMJVPK0wwrKs1qM5aWw5AoKHxXKBGhTwDJ65mGhlSL22x4ZufRmWiqBIF+72t1FHQrOZ15PatHTKzpkTfkxzb0Em9tWd7FnQVo2XNE99YwS90XetUkkEObz7lsK4KlGo+H52gsk45b2MLRljv37VbcjtIYRuSN48zCfU8tMB47w46uvNPgmX4ohCZDaSiikvQJj1wiuKJJU19UIEH/Bf4zXF44=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(376002)(136003)(346002)(16576012)(86362001)(54906003)(8936002)(4326008)(478600001)(66556008)(66946007)(53546011)(31696002)(36756003)(8676002)(316002)(66476007)(5660300002)(6486002)(38100700002)(6916009)(2906002)(31686004)(16526019)(26005)(956004)(2616005)(186003)(6666004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?WkdTVUppa3hBQ0ErV2lLZ0ZCVVBRY2VZaE5Od3dpZ3hVSTh2QjAzdms4bG1a?=
 =?utf-8?B?VTNJcUZWaHRNL0hzNlZocS9sUWFocjY0TS8zVDFBWXZTalJlYXpjVlRnd2N6?=
 =?utf-8?B?c281S3pIOUdvb3RMU2UrUk8way9qYUZPWWd4QUkvcDljKzZSeEwwWWJVS2dM?=
 =?utf-8?B?RE01Z0svSTRONEFBVlZkSlFJQ01DNkJ6bUt6QS9iVWFUODlVZ3dNVlNXSHJB?=
 =?utf-8?B?amFiSDEwUzNkemphZXA3ZTl1dm5NS29tbitLK1ZiMTUxZjJFV0RBaHBTZC9L?=
 =?utf-8?B?VmszWk1MMk9oT3JrNEhTNVh3aDRPWlJqR3A3cWNmQ3dlQ0NjRWh4ck1qSmNZ?=
 =?utf-8?B?UGtOaGFUNmk4YzJpQWp4MHQxOWNQUzJyVml1WjFueG1takxVRG5PWWhTN25S?=
 =?utf-8?B?Y2wwVVRKeTlxOTRQc1BvaFUyOVlGZnpqK0ZvNWk4V3B3T2Fpb3RZT2hwbmRp?=
 =?utf-8?B?VGtHODRCajZKaEh4aVJoMXpSczRBdnZuRnlTNkRVTEJhZWg5b0RqV3VFMXU5?=
 =?utf-8?B?QXJQbGhLRkUyZ2dpOGNWQ2pMVDJTWk1mZDhDdkREbkFEanRXNzFXdHV2aWZv?=
 =?utf-8?B?Y1F1M2duNGpXQ0FTRTh2QitIQ3cxMEdlamtwTlA3WWdROVNTVThvMW4zc2pU?=
 =?utf-8?B?bmY0T2xWUHdDaHRCYm9UT3dWT2tGd0Nrbys0ZU03V2ZSMXVIQXA0ai9pTEtH?=
 =?utf-8?B?d0hyTzJnMnUrYXF6NHExV2krNWo5Ny9SL0hlcDVYZ1c4a1AwWC9zOExCemxQ?=
 =?utf-8?B?N3JRSGxCOC9OM2lZVEtYRTM0cFZTYmJtVG9lZ1ViQnQ2bnVtVGtUcjhOaVBs?=
 =?utf-8?B?MXRPcVljV2pxMFJXek11NHNSY1lUWXg2UXV6VnVXMVFyRUVnV0tucHArRGdk?=
 =?utf-8?B?dVRyYm9HRzdqVlNwRFdsZHdWYlNaVFJkVUs2ZEhMN0EyN2o3SmpISnBnc3Rv?=
 =?utf-8?B?aHFsWUluUDEvZStlaXZEYVJGMWVtZmdvdFE5SHVlSW5jTlJjS1VzcUYzRm9C?=
 =?utf-8?B?TVJHOW00YnBnODlISUNjK0U3ZkM3ejJKTndzekxTNWdibjIrZXNaZmJscHgx?=
 =?utf-8?B?d3RBcmdHQ3hmcWFqNHRYTHZnTC9tSzRsY0J3bnhZSXFxRFFTTUFnaFlGcDh0?=
 =?utf-8?B?SEt1am9PdmJBbGw1T1QwcDNXRkVBZ0ZuYWs4S0VVQmIyT3MzK0s2NXAycFZM?=
 =?utf-8?B?UjJRN3lIZkxWNnNRcTQvZ2E4U3gyWGlQSW5sQ1RRa2hobUVCd0xySVcraS9O?=
 =?utf-8?B?Y1BmZXVsUXhOcmMvSHpjWDNXTFdjUHlWWGpDQWtpWGJKQ0x0SmdpMldsNXJr?=
 =?utf-8?B?QVl2bFZFRU5iQ3ptelVYYWNDQklMeFZpS0dvUElmNlFsNHU3VjhjY3ZWdmhm?=
 =?utf-8?B?aVJPUU1jL3VkRUtGOTk0dVJIZmw5ZkM1LzRWeXcyYUl1Q3pERWRDOVhON25k?=
 =?utf-8?B?TlppL2RlYS9Xa3ZXOUdBVTNWTjhLbkJOd1Bjbno2UTRRMjNkTXVzSXFLcFNK?=
 =?utf-8?B?NUErbTRWMUNMNU94eEdGdlJSSFhhbjJwWm1wVUpiaGlVSTZGb2dSMzNGVEpQ?=
 =?utf-8?B?Lzc0b3dHR0xrMVdmUHI4NHgzT0xtTWFpc0VCUWVETVBid2djQzhWd2RHNFBp?=
 =?utf-8?B?ZE5QN0pHbWROWkhXS1ZXYW9HMGRzSGR0WWY0VmpkY1M2QWlYdUNsck9WeVh0?=
 =?utf-8?B?V0p3dkNTRjh2Z0FCZ3Ara2p0dis2bktjc0JPMzdJM2QrTEhxdTNJdFhMU2I3?=
 =?utf-8?Q?sX7/pTpQ7DcdEu9riXHYgY6TyxIn5YMv2WpNE2Q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6a0299-2c21-4e74-6623-08d910799fa1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 10:28:00.6177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAsasB+vK8oBujH32RTme6TcWf1qUsA6yz+d9gUL3bFd5qy5HrcYbfn/EQto62sFNO+ICitrdQgGP99gi0hgF8wOnbuL0iZqFvZZiCxokms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3735
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105060071
X-Proofpoint-ORIG-GUID: p3rHwBxNd4H6MdyJiNfFuSX9NTlhFtSY
X-Proofpoint-GUID: p3rHwBxNd4H6MdyJiNfFuSX9NTlhFtSY
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060071
Message-ID-Hash: VSBRKYVP2U5OYTA7OUNO3GK5NBBHO2Z7
X-Message-ID-Hash: VSBRKYVP2U5OYTA7OUNO3GK5NBBHO2Z7
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VSBRKYVP2U5OYTA7OUNO3GK5NBBHO2Z7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 5/5/21 11:43 PM, Dan Williams wrote:
> I suspect it's a good sign I'm only finding cosmetic and changelog
> changes in the review... 

Hopefully it continues that way, but the meat of the series is located
in patches 4, 6, 7 and 11. *Specially* 6 and 7.

I very strongly suspect I am gonna get non-cosmetic comments there.

> I have some more:
> 
> A year for now if I'm tracking down a problem and looking through mm
> commits I would appreciate a subject line like the following:
> "refactor core of vmemmap_populate_basepages() to helper" that gives
> an idea of the impact and side effects of the change.
> 
Fixed.

> On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
> 
> I would add a lead in phrase like: "In preparation for describing a
> memmap with compound pages, move the actual..."
> 
>> Move the actual pte population logic into a separate function
>> vmemmap_populate_address() and have vmemmap_populate_basepages()
>> walk through all base pages it needs to populate.
> 
> Aside from the above, looks good.
>
Cool!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
