Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D20D2322EB6
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Feb 2021 17:29:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0E247100EB835;
	Tue, 23 Feb 2021 08:29:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0E1D5100EBB8F
	for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 08:29:26 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NGSeFr161296;
	Tue, 23 Feb 2021 16:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=CfDMq3SZzMQp0DFqIqNj3KFTTVwPbmTk88rn3fFOWrk=;
 b=xajCN4zHY1meED186FKwSnP/Og83UAe9MWnHx+NyahXs5Sc8eoe6Dd0NqsyPSCIOvqiv
 LvQh3t6AYvXt2UJNtLq4x9zrbw5ZOo0ejSZtp9DK4W9eeZkT2yagm+F6NLFLmjMpyaIK
 Guv4HtqdZ5dOKWFd55PqkzF3z44SVVXoKpoUlqwyrEBPyVaxB6BjpAHdXZ1BFt15vtKH
 zSkUbKFc2LGl1kRnarJAunMb3hOyO28r4dpAS3XiGNPwmsAnSHQEmdDpzIOLSNsf40+G
 pl2UAXzZLagMWE2oFmLSYYJCIeEp0p8zLlRHu3dGahDsDcJsowYUZaJwbQbHwQH6Mv+d dQ==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2130.oracle.com with ESMTP id 36vr622b3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Feb 2021 16:29:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NGGRGM084215;
	Tue, 23 Feb 2021 16:29:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by aserp3030.oracle.com with ESMTP id 36v9m4t6dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Feb 2021 16:29:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLmLr2W82X+ZfV0YMyeW+FfF6HlOwXPW8Ia84RAUyw5qWWLAor7O/cY7nNVtBpX5VsUDM/ZaR4S0FNuBBH50593h86eiIjLxiN1E0C84TyUG7H1r93RMurDiAl7KHepEcA4Bbqv8Kcui9wsuHhtjd42/ApSD3jtfUlfi11Jc6G8g5sWUXx1BY0s6VFfJiSjQe8HXu7+OoxP5SbFNSkL1PnN+FqD/xkMHlr8h0SYCM8/6CaZZsv7MV7ukEJ8GFY8jEAUyBgAX3lNo8zSbf6hndoaKsF5OA3Yc6Td0RsimM7gJ9pmUIh99zsnLQVm0B2XsioRv5Sz6nf90VzcHaqTmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfDMq3SZzMQp0DFqIqNj3KFTTVwPbmTk88rn3fFOWrk=;
 b=Z8caBhVQpRxSEqBTtYX1Sig6SCsxrMpBD9y0F8Wxa6rXGes8Vsf9tcm183avrAbIGKPlA7L+UQ05npmBFo2F/9l1XHdlR9td7O7MwdhOIbW+gYsUUql7155sUIQ+6lsUnM/jXzpGSNsd3aeouzFu8CCe3cP9JXfU3zinFTJ8/J9zuUKgEY5PY/I1OxExQNds9rCm4kJ6kSWw0QscqnySJ+ZPWhmJQ0nLllN68yfNsJbPoXicuiRowdOEESgPv+/kTrAsNSjDXpHLNXjxNEJ44F2WLRC6jUrPw5/AvbD5IwC4N1XOZbHIw+LWZ6XCq2Sx/6l191aXgPeGIZzlR5XFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfDMq3SZzMQp0DFqIqNj3KFTTVwPbmTk88rn3fFOWrk=;
 b=g810SqRK6rynWMXrCRuo11B9fnMGOD4WwDRJCr5xNoq5oSVoZqOxofgQdz97n8j1XUb93cijUEwcURA22FPcWWAhjzq3l2OeSqGFSW9VE/HZaPysZAG9TwrJRugLDiSXmgDKJubEYwslqKKyToiqzjNEeOfmhhxq0GW1khfS4C0=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2695.namprd10.prod.outlook.com (2603:10b6:a02:b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28; Tue, 23 Feb
 2021 16:29:06 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 16:29:06 +0000
Subject: Re: [PATCH RFC 0/9] mm, sparse-vmemmap: Introduce compound pagemaps
To: Dan Williams <dan.j.williams@intel.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <CAPcyv4gQQ03-nhBNwLK6KDc953SVD1rOs7HFBo_Mu9LFTkXRgw@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <6a18179e-65f7-367d-89a9-d5162f10fef0@oracle.com>
Date: Tue, 23 Feb 2021 16:28:57 +0000
In-Reply-To: <CAPcyv4gQQ03-nhBNwLK6KDc953SVD1rOs7HFBo_Mu9LFTkXRgw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0346.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::22) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO2P265CA0346.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31 via Frontend Transport; Tue, 23 Feb 2021 16:29:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c5fbd81-6a62-4547-679d-08d8d8182357
X-MS-TrafficTypeDiagnostic: BYAPR10MB2695:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB2695B087BAD14FB49492B153BB809@BYAPR10MB2695.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BpTEUkMzr3nlIkGq9zd9eA0viPFRMK0VBtnG16S8fN4ibRGjBZTcA0NrRVhyasScY5ciYj/vd2NGgC2vP1EdXf+H+TzOh5Okq8dnd4Wh1KWX5HPKemEiAZFkeCZgiS+LyDPloSsk63irUYQIkrENH0YkXsIo+djHqLeHCRo73PnV3Nq4fq+aJUW6qce0aEtDnyxl8AZFma3EvPXmc7KRghUNs02x9qOLPUlFLO4lnE1Plq95nz91z2fNgSHvP9qK3bq9i2MScyE5dPReHxhtXtRTsitQHPl8FCDG6wiNc16rNKFqPu4LQJ8ucIr9/Fp+Bfjyj+mJJGfTrk/AJihYfF9QsBx00Qy2zK1tM2aX+8Ny6n3nSqdERrSW3AgjVaLtF4eHUA7ILPjN/4IOW8VRXr4RpE6LTbUWlR4BCZ4YpM3N5PCTBtzRB4BJqDvTDAhjwGc9sNLbcl/fkqXoLfGxuT5MDB9lveZplQwldvTHr3FGui8wRHP4fyYDLjUEJruBDS9mkUppNlNOGMiw8V8dtFpt9WG5hB9nkJAHviOCHWOP3cQQKVPwUOzbj8HwsYs23ZxhEEjVp7bx7bgb5/xQ9A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(366004)(136003)(346002)(186003)(26005)(16526019)(6486002)(83380400001)(86362001)(316002)(8676002)(53546011)(31696002)(6666004)(2906002)(66476007)(8936002)(5660300002)(2616005)(16576012)(66556008)(31686004)(478600001)(6916009)(66946007)(54906003)(4326008)(36756003)(956004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?Y1M5Qy9FOUtOM0pFQkx6Q0FST0UrY05jcGpIRzg2NUdFNy8wYm90MW5SUkxj?=
 =?utf-8?B?THZUQ2N5OVRjMUVvcnFFWTkwRE0yYTdQaGJibXhGTFVuR2NmVWJhYjlHVXdD?=
 =?utf-8?B?Y2RrZDdMQUNJclpjL0VWSkwyaVI1M1RuTzNvc0FQWTMxZEUySGkwNmhHV3F3?=
 =?utf-8?B?azhaK0ZrTldLSWtwS1ZZK2RmNlhiMkVsZjY1UUhSS0dSeTFPY1ZwS3JXSHNt?=
 =?utf-8?B?SkpuQ1VkMnROZXJVZ1dGenJFWlJVeFVwRHNWL05weXpra1NTQVVwYlVuSnBm?=
 =?utf-8?B?UFphY1RPcThHNG0veldKZENXL28xbU9YYmJzdFQ4Q1YwS0NpWGxKNkZDcElR?=
 =?utf-8?B?RzBxNmVlMktDU0RocWljQ1dhVmF4dDRxWmNrZ0hCeHZud1BHUmdnZmlKYUZ4?=
 =?utf-8?B?VUVVSzM4Wk5Tc2dFdGY2Ykg4R3VCbDR3SkthOG94ejFFT3owWTZDQk50U3hl?=
 =?utf-8?B?NG11NGF4Z3VHVDVwOGlNYjhQRVhYdElmMFl1d3pqSll0TmRCb2htVmtnaUs2?=
 =?utf-8?B?UHJIbDllUC9HNVdKaUJXSDRXQUNVcTJCMm9RYVAvbXUyUFVBTFJ4WDBIR2x2?=
 =?utf-8?B?MnVFRUNhWGJOMzdFaTIrMmV0WGNPZ0s4Z1h3dXpTMFNKSWRrZ0FQOElQUisz?=
 =?utf-8?B?M0hzanVkdTdmVWZkeFFtQjczYktNN1AzcVNEKzcwajVHVHh3d1VuMGlJOGdD?=
 =?utf-8?B?WGVrOEk3Rk9CbmFEcWJJdVRWUFl3WDVKa2FXaWJ0ZlJlcHpCMXlDQUFhS0wx?=
 =?utf-8?B?MCtLMVY5LzZEZUdSU1pOK3F6dlJjcmlhQlJDZXhhRmRRcXBEL0dLd3gvV3F6?=
 =?utf-8?B?Q1lWVDdUMzFNYTlQSzhZUGw2Qzk2ZUk0QzVIZFFNSC81Vjk3eXNLSGRRbDl1?=
 =?utf-8?B?QXBPdmpRbHFWTTZmZnYzL3o3YnFqd05HVlZJWEhDWlpSZDlhNThMSk9HR1VT?=
 =?utf-8?B?U05GRTZ3OWpVUC9penErZ2xCSUZUbm5Eejl6a00vT2UrZGZPbGx6VFA5THY1?=
 =?utf-8?B?dHRXeUNaaFJMaWQ2dTR3M3ZzVTNSU0hNZTlnQVBYVk9KV2Q4VTAwK1NmenVn?=
 =?utf-8?B?bEpOWkQxbzFBTVRXT1ZGYnlrdGE3ekNrRk15Z2FqRC91bFNtSWE3aDdjcVgw?=
 =?utf-8?B?VjhINElwTnB3S0EwVzR3TlZPMW93YW0vM08zbFViTnhkNTlRMWRCZ1dqaU5K?=
 =?utf-8?B?MVRjbkt2NzNUM1JwaG5mUG1QeTAxUFJtZHFpTVVtT3FSS3QyTFAyaWYyNnNm?=
 =?utf-8?B?VnVrVUl5NndLTld4WjI0a1JzSThWTnZxSlBLM3dMdjBIMjNrUC9KU3lIcFdY?=
 =?utf-8?B?akpVUkkwbzNPZktiNHh2dWhaYWpHWmxsWHF4cmZ0blBBRjhOVUpodENCOTNt?=
 =?utf-8?B?ckp4M3JKMnRDdzBNQkEyZ2JDcmNYdkdwMzlHWGFXd0I1aG00UWlEREV3RjR4?=
 =?utf-8?B?Ymk2NzB6cmlYUXhmRkdHS1BoQTF6Vzc3Y3RRSWpoQ3RyUWRrUW91Qi9tbGlO?=
 =?utf-8?B?dVhPSlA2VzA2WjhONnNYN21EU2M1TGlSenZPa1F3a0lFZVdRUTl3RnpPanFN?=
 =?utf-8?B?UndJUW5xcnpYNTREVFhyVHU2NXlUajhSWGd3ZFVCRjhWcjdWTGRJVUh4bTEz?=
 =?utf-8?B?Z29lTEtHT2g1bnc5RUZlQkZoS0tVUkMxWm1hMGRVb0FHVkRQWEVPbHFzUTcy?=
 =?utf-8?B?MlFTYmNocnBLWUxXOGs0UnFPM0hicEExcmU3dTlmY1hPeTRtMFdmMjlQTnRE?=
 =?utf-8?Q?mEHZzxauBKn88oD/ODXHGviQCKvBcZi4YH2SC0B?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5fbd81-6a62-4547-679d-08d8d8182357
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 16:29:06.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2z+OBlyWS/Q/zJIBNBg7w2fDTo7jHPRJFVlm0Zy8mo630lbIuZr+1ftBqACZN5120/+ejVFYhTgnW2Y+EwgvsrQ4OOGJg2gkBfajO+0G5wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2695
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=982 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230137
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230138
Message-ID-Hash: CQISQICOR7JO7WDRCSWHHC5AFY4REVG5
X-Message-ID-Hash: CQISQICOR7JO7WDRCSWHHC5AFY4REVG5
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CQISQICOR7JO7WDRCSWHHC5AFY4REVG5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/20/21 1:18 AM, Dan Williams wrote:
> On Tue, Dec 8, 2020 at 9:32 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>> Patch 6 - 8: Optimize grabbing/release a page refcount changes given that we
>> are working with compound pages i.e. we do 1 increment/decrement to the head
>> page for a given set of N subpages compared as opposed to N individual writes.
>> {get,pin}_user_pages_fast() for zone_device with compound pagemap consequently
>> improves considerably, and unpin_user_pages() improves as well when passed a
>> set of consecutive pages:
>>
>>                                            before          after
>>     (get_user_pages_fast 1G;2M page size) ~75k  us -> ~3.2k ; ~5.2k us
>>     (pin_user_pages_fast 1G;2M page size) ~125k us -> ~3.4k ; ~5.5k us
> 
> Compelling!
> 

BTW is there any reason why we don't support pin_user_pages_fast() with FOLL_LONGTERM for
device-dax?

Looking at the history, I understand that fsdax can't support it atm, but I am not sure
that the same holds for device-dax. I have this small chunk (see below the scissors mark)
which relaxes this for a pgmap of type MEMORY_DEVICE_GENERIC, albeit not sure if there is
a fundamental issue for the other types that makes this an unwelcoming change.

	Joao

--------------------->8---------------------

Subject: [PATCH] mm/gup: allow FOLL_LONGTERM pin-fast for
 MEMORY_DEVICE_GENERIC

The downside would be one extra lookup in dev_pagemap tree
for other pgmap->types (P2P, FSDAX, PRIVATE). But just one
per gup-fast() call.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/linux/mm.h |  5 +++++
 mm/gup.c           | 24 +++++++++++++-----------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 32f0c3986d4f..c89a049bbd7a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1171,6 +1171,11 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
 }

+static inline bool devmap_longterm_available(const struct dev_pagemap *pgmap)
+{
+	return pgmap->type == MEMORY_DEVICE_GENERIC;
+}
+
 /* 127: arbitrary random number, small enough to assemble well */
 #define page_ref_zero_or_close_to_overflow(page) \
 	((unsigned int) page_ref_count(page) + 127u <= 127u)
diff --git a/mm/gup.c b/mm/gup.c
index 222d1fdc5cfa..03e370d360e6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2092,14 +2092,18 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned
long end,
 			goto pte_unmap;

 		if (pte_devmap(pte)) {
-			if (unlikely(flags & FOLL_LONGTERM))
-				goto pte_unmap;
-
 			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
 			if (unlikely(!pgmap)) {
 				undo_dev_pagemap(nr, nr_start, flags, pages);
 				goto pte_unmap;
 			}
+
+			if (unlikely(flags & FOLL_LONGTERM) &&
+			    !devmap_longterm_available(pgmap)) {
+				undo_dev_pagemap(nr, nr_start, flags, pages);
+				goto pte_unmap;
+			}
+
 		} else if (pte_special(pte))
 			goto pte_unmap;

@@ -2195,6 +2199,10 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 			return 0;
 		}

+		if (unlikely(flags & FOLL_LONGTERM) &&
+		    !devmap_longterm_available(pgmap))
+			return 0;
+
@@ -2356,12 +2364,9 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;

-	if (pmd_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
+	if (pmd_devmap(orig))
 		return __gup_device_huge_pmd(orig, pmdp, addr, end, flags,
 					     pages, nr);
-	}

 	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
@@ -2390,12 +2395,9 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (!pud_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;

-	if (pud_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
+	if (pud_devmap(orig))
 		return __gup_device_huge_pud(orig, pudp, addr, end, flags,
 					     pages, nr);
-	}

 	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
