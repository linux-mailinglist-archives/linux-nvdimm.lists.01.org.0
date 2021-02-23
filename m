Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D35322DCF
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Feb 2021 16:46:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8F73A100EBB71;
	Tue, 23 Feb 2021 07:46:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 980B0100EC1E1
	for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 07:46:27 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NFj4rV097550;
	Tue, 23 Feb 2021 15:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=LU6vVAaGOLyRX3x8iIAvzb81rbKPkqldruxnmOICg9E=;
 b=dj6S86EoSQV3+BRAW5o2+nz8PjeAy1uxRLcIw3o1+MUjLeuMbTsq+O18jnEbk8QreUvZ
 FHeofWt3q18UtUaXZn+i1qRUJWDKfq2Rv6fspkgHFnSw6xgU6lGLUcZgJA89yfngflvd
 lt7MYI7UCwy7DrTk76Ai6MRagirzkgvw/RTtiCYs9t10z6onTL0LaZluFNIDrekCmszF
 0nDp4yzSF1tUphSTvoB80XUYsIXHy9IECmllGHH5d2g/ml3nBk/ZZsM6F6F2W1j8PZqO
 drYYd4PNLwpWR2/BMaheXmMgB/zRNw2Xtbn2rAvCTKjWpEn2cVhNxwq256XlYMKMF+Ey Iw==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2130.oracle.com with ESMTP id 36vr6225qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Feb 2021 15:46:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NFQfFQ190445;
	Tue, 23 Feb 2021 15:46:12 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
	by aserp3030.oracle.com with ESMTP id 36v9m4r5fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Feb 2021 15:46:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaO4hsPGW/x4YZeFsg9DRhyvLbXPmv5tEaite65ufJ0lcD4fnetONreM4YKrs4UtDmcUFSL0O5qT5QhITsZe0HlYRnKBIgkKvBuN9yo662+0rZK1HT0IOleFpZIYpU5/ayAmaHwly/nvOSD2TOcBoJ0kNVm55FiWKyWl29l/dhJeeWQZLfRBu9s5h0SLoxNJ+0ihQgKEkQK7i0WZHb2cHFba8DukPowFO2aMAQdWz5ch4FZq0wjlmNWMMgCwaIDyerkl8H4IOuumTNulT1ZYeahp5k94vKPVYvRvszn1VRNN9b5zr2S55zWrPCVq6itEUKrpWZejA9hZ4ImKnXHf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU6vVAaGOLyRX3x8iIAvzb81rbKPkqldruxnmOICg9E=;
 b=KLEJDHYcUO4kylsdr7bf3RRdIhsgeDuSMb6GWh8W3D0LszNymnkXdVeh3JzAykkgWIfv2hkfg19QZZOd0KtGoMu8wd/KND+JEudzOpF+5CMY2xhMag2n0Q551QuAyYu95tpWBZo2qXbU14wZBq+/NmNZ4L+JqJRZNbmyOqeXUBmzg+umquNSOgCvjupo9Oo4dCAyFTFZsz6axOtr0UN5/VR8w+pDDfYMRVQC322sO9OMPyA4kXAz3lDZ1r5HxRJbA38QRJlCuPiQv2jqGLInpPj6lyUKRhzNXD9MyDZgGVXBT3Y+wAK+hWCQnYNpEv/reKbg9Q/jrd/nSUY3E1IsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU6vVAaGOLyRX3x8iIAvzb81rbKPkqldruxnmOICg9E=;
 b=pp13V2IljKG6vbwCXSX0YQf34REVX6VFZKJCkN6aTZGBg38lzwWBE8wIVICjSAXB1+84H97prK4Jl+d82vImad8xiCDhRnxb9BQNVfQGIySoE4yQHFDb7wIWQct1DeC1CBxdT5vF9iz5Qpq1EcJQV/LNmGRU/pa6g7HFxnJmd40=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3685.namprd10.prod.outlook.com (2603:10b6:a03:124::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 23 Feb
 2021 15:46:10 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 15:46:10 +0000
From: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH RFC 1/9] memremap: add ZONE_DEVICE support for compound
 pages
To: Dan Williams <dan.j.williams@intel.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-2-joao.m.martins@oracle.com>
 <7249cfd2-c178-2e6a-6b03-307a05f11785@nvidia.com>
 <CAPcyv4iMzaAqKe6C1Q_feHL5SwppPdBem0i6XfYX4sL1U6sHgg@mail.gmail.com>
 <7e8908ca-4d0f-6549-0442-d4b15fbc90ab@oracle.com>
 <CAPcyv4jDk=ppsR2Pvgpb1DqWk5D8bkrNCAtyRU21ShnC3fzdSA@mail.gmail.com>
Message-ID: <94075df6-ab3b-c6e4-13f1-26dd266dbf82@oracle.com>
Date: Tue, 23 Feb 2021 15:46:01 +0000
In-Reply-To: <CAPcyv4jDk=ppsR2Pvgpb1DqWk5D8bkrNCAtyRU21ShnC3fzdSA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0460.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::16) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO2P265CA0460.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a2::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30 via Frontend Transport; Tue, 23 Feb 2021 15:46:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0e51ca2-aea0-40db-f6c2-08d8d81223e2
X-MS-TrafficTypeDiagnostic: BYAPR10MB3685:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB3685D9AABD8F8883FACD13F4BB809@BYAPR10MB3685.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	t6JfcAOyDl7sYj/B8q0JIxNjWJym2vw87X4uXoaJeJ4guL7s3uJ3dAoj2MK+kSVhL1kAkITCKnyk+/hWlVaG2vBytsPQLHPErMfjEJVIbIF173hQZpG4SpIs3ETaPR2ZU9vKufdAcO2e6FqWfrlLV2Xut5iUlI/bYh3e30Uk2rm2s6wtaNMVPSaqE5NYiKeGFK6ORgwO99WMyZyr/wyvEI0KgA4tYdx8ivxGTTVKjAd8zuIMGwdQxDwXcqXC3LAdIH4rT8do7TsXkrP06Tt0fs52rvMUgK6IX77/3S+26NASHuWhySyVVnoK/DRKzBCDzWGTMzlxY10siysXYeKhLIkwvw92MM7xMteQzWdqjmbabfdmZBN5UyDUgmxSoplfweoAQYpObqzsTIP9r/NIrHbTMT3XkZBucUwXiZbKNUeJ2MCi4z2W6nqZ3Q55aN21n1fQnLdhjJjs2IY7ItHWr8DhR9FSki65MevQYGgdwpbkTCx4DPUsKz+XSpvlsVfDGLeksGDGjP3esVERC6RXLFFi6OFv8ousPIl/zc5uKAYTgXyExwkm2IpnR85k3zs17hawT1dnrfz818DfJa7T1A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(136003)(346002)(396003)(83380400001)(4326008)(8936002)(478600001)(6666004)(6486002)(53546011)(26005)(8676002)(186003)(54906003)(316002)(16576012)(66946007)(86362001)(36756003)(16526019)(31696002)(66556008)(31686004)(66476007)(956004)(5660300002)(2906002)(6916009)(2616005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?SDhPNnB5WUQ4NUdmYnhnTFpKQWFTV3gzbTUzYWxSTE5Ed0FoNmhOZE1UYlB0?=
 =?utf-8?B?Tkl1UkxsZ2ZFMDFmQWpLWGUxV3F1ak1kM2dUTDFFZ3lGMHl2NHRjNDZJOGNM?=
 =?utf-8?B?ekQ4TmE1RlI0WHpQeCtIdVNsSU1jYUlVVnR4WVBpbUlBVEpsVzA5QXpCOHNC?=
 =?utf-8?B?SlpjbnZUSncrd1BLS1dGTytWaFUyTGRQTmVIVnVoRjVzajViWU5iMkc0bzZM?=
 =?utf-8?B?a0lqYmdqaXpIQngvTmRQMGpqdWsrdDBGbGRvaGtaVXZsNnpabmhLdWVsQS8r?=
 =?utf-8?B?VTZ4SVZmcDhWVlY4VkhDYnhNcUZwTTQzTDNoQjBCY25laldPem0yeTFUTlU5?=
 =?utf-8?B?bGdKTzZCWDVuQXlhOVVPVGNjaExBazU3Y1NNOGZac3BvN1RITnhObXNUeWx4?=
 =?utf-8?B?T2s4SFVoMVpTV1l5bVVMN3RYTDNtSEJZTE15eEcyUU41czZrWG1OVVpFU1Zy?=
 =?utf-8?B?em1McjBoQjB6VUx0NlRDZW1pRmt2L2dLYmlnemlkbmV3cmxMOTRvdUVNQUVD?=
 =?utf-8?B?aEhXMGNjYXo4VDltVTNZaVZ6bzZmcks4SUpTVVR1SG85cGlyK25MQk5KRTkw?=
 =?utf-8?B?NXJZUnJJdVJZNktNVEZ4OUxXd3NhY1lkSFRpUHJPRkNmN3RUelFscjl3SHdV?=
 =?utf-8?B?alFPaEFvZTIyWDdBVnhXWSs3S1VRWGducUpuVG12a0pxUWp0aEIrSERzL2JB?=
 =?utf-8?B?K0kxZGxBbVkyTytYQzhQYVYzM1JGQVpjQVZzcDhLSFpJNnlGZ1RnRmFNSGFa?=
 =?utf-8?B?VXpDYUJXcmV2TEhtS0FBdVk2L29MOXVPYW1UdHlDbFU5SzZRUnBYWC9XeG0w?=
 =?utf-8?B?MEd3NThhbFk5TzYrLy9jMk9XQk9UQjRqc3U0QTNrS0t0VStrOG5qVjg3L3NZ?=
 =?utf-8?B?S0RFY003amJSR3RpeUpuNTcwQ2pEZDkzYjM5ZFRoR2N0VHQvODFOMWMybEJz?=
 =?utf-8?B?OTB1N2NTU0N6b2svUkJNTURQcit1TmQ1c0thendkaGFtMUp0Y1UvMlZpcjFr?=
 =?utf-8?B?QjN1ZEU3aHNoQTY4cXd6ZVQ0Ykh2bWNGeW1ZNTJseGZCdUlTMmFwYjR2QWtW?=
 =?utf-8?B?V2FrNnBwYkpVc1p5TStPRnc4Vzh5VGFLZnNFMTAzQ1E4bUNES1VYZzRSOHlh?=
 =?utf-8?B?ckFxck5oaHBBbWR4T2xkaTJQdHI5THBadVdYbmJpY1hZdEZZbFRSQ0RaVzdu?=
 =?utf-8?B?S3MxTUZjL09NbFVVZzJkdmZ6VWc2M3h5dGw1eEhaUEdaL1IzU3R0aGhTQ3Y2?=
 =?utf-8?B?NFU4NU04djEycUt0STQ1MkdNbzRSYXFESi8zazBtZGg3YmdsTVdDb0IxdXFR?=
 =?utf-8?B?cUVsK2ljcnRBSklxZWswVjZZcUhkTkJnSy91SWF3dXVvY2lyMmI1dklLT2k4?=
 =?utf-8?B?ekZtamhQaGV6aGdWSE1pZ3FTVnRncEN3R3pHaEE5RFl2N05FTzl6bXYrRngr?=
 =?utf-8?B?NUVGSVB1dnZRM1JZckhTY1NGZ2MyM010dW8ydG1CSG5DeXRjNzJRMVZxZkV0?=
 =?utf-8?B?cFRneTFZQ3hrNWlYME9aMVJhdWRaaks5NXpCcTJnMnhpamFYcDhIcGh5Q0VL?=
 =?utf-8?B?a3B2S0M2Q1hQbzdxRXVDVkE1Nzg4NTlqdFZLTTR5TWdRK2Rhc3ZmbjVqSmtH?=
 =?utf-8?B?K1AzbmtMYXcrcWR6aFpjb2x6dXRDOXVFME5BL1VlTG5zLzNSWXBwZVBWbUw5?=
 =?utf-8?B?WFhBVWJJcDc3U0N6aG9ORC8wSUZyZVFXaHZ1YkFQRHkrOVMvL1gvRFcyN2k0?=
 =?utf-8?Q?dhjpBGO0AJA/DvH3cfhiyCiCC7EQo8D77RIrPV0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e51ca2-aea0-40db-f6c2-08d8d81223e2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 15:46:10.4518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3Kwa6U2eVBIvH4W50hrYSlZ9DHKAemWIcFJxqWswdEEnlOJ5dqHHjuliFGj2IJZ2V9y+2h/djvzLH7EGNrI31kyQAifk2KJd1QIOJZgNlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3685
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230131
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230132
Message-ID-Hash: U7WQA4KYP5FJKUNJWCDPERCHBMKQ67ZK
X-Message-ID-Hash: U7WQA4KYP5FJKUNJWCDPERCHBMKQ67ZK
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U7WQA4KYP5FJKUNJWCDPERCHBMKQ67ZK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/22/21 8:37 PM, Dan Williams wrote:
> On Mon, Feb 22, 2021 at 3:24 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>> On 2/20/21 1:43 AM, Dan Williams wrote:
>>> On Tue, Dec 8, 2020 at 9:59 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>>> On 12/8/20 9:28 AM, Joao Martins wrote:
>>>>> diff --git a/mm/memremap.c b/mm/memremap.c
>>>>> index 16b2fb482da1..287a24b7a65a 100644
>>>>> --- a/mm/memremap.c
>>>>> +++ b/mm/memremap.c
>>>>> @@ -277,8 +277,12 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>>>>>       memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
>>>>>                               PHYS_PFN(range->start),
>>>>>                               PHYS_PFN(range_len(range)), pgmap);
>>>>> -     percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
>>>>> -                     - pfn_first(pgmap, range_id));
>>>>> +     if (pgmap->flags & PGMAP_COMPOUND)
>>>>> +             percpu_ref_get_many(pgmap->ref, (pfn_end(pgmap, range_id)
>>>>> +                     - pfn_first(pgmap, range_id)) / PHYS_PFN(pgmap->align));
>>>>
>>>> Is there some reason that we cannot use range_len(), instead of pfn_end() minus
>>>> pfn_first()? (Yes, this more about the pre-existing code than about your change.)
>>>>
>>>> And if not, then why are the nearby range_len() uses OK? I realize that range_len()
>>>> is simpler and skips a case, but it's not clear that it's required here. But I'm
>>>> new to this area so be warned. :)
>>>
>>> There's a subtle distinction between the range that was passed in and
>>> the pfns that are activated inside of it. See the offset trickery in
>>> pfn_first().
>>>
>>>> Also, dividing by PHYS_PFN() feels quite misleading: that function does what you
>>>> happen to want, but is not named accordingly. Can you use or create something
>>>> more accurately named? Like "number of pages in this large page"?
>>>
>>> It's not the number of pages in a large page it's converting bytes to
>>> pages. Other place in the kernel write it as (x >> PAGE_SHIFT), but my
>>> though process was if I'm going to add () might as well use a macro
>>> that already does this.
>>>
>>> That said I think this calculation is broken precisely because
>>> pfn_first() makes the result unaligned.
>>>
>>> Rather than fix the unaligned pfn_first() problem I would use this
>>> support as an opportunity to revisit the option of storing pages in
>>> the vmem_altmap reserve soace. The altmap's whole reason for existence
>>> was that 1.5% of large PMEM might completely swamp DRAM. However if
>>> that overhead is reduced by an order (or orders) of magnitude the
>>> primary need for vmem_altmap vanishes.
>>>
>>> Now, we'll still need to keep it around for the ->align == PAGE_SIZE
>>> case, but for most part existing deployments that are specifying page
>>> map on PMEM and an align > PAGE_SIZE can instead just transparently be
>>> upgraded to page map on a smaller amount of DRAM.
>>>
>> I feel the altmap is still relevant. Even with the struct page reuse for
>> tail pages, the overhead for 2M align is still non-negligeble i.e. 4G per
>> 1Tb (strictly speaking about what's stored in the altmap). Muchun and
>> Matthew were thinking (in another thread) on compound_head() adjustments
>> that probably can make this overhead go to 2G (if we learn to differentiate
>> the reused head page from the real head page).
> 
> I think that realization is more justification to make a new first
> class vmemmap_populate_compound_pages() rather than try to reuse
> vmemmap_populate_basepages() with new parameters.
> 
I was already going to move this to vmemmap_populate_compound_pages() based
on your earlier suggestion :)

>> But even there it's still
>> 2G per 1Tb. 1G pages, though, have a better story to remove altmap need.
> 
> The concern that led to altmap is that someone would build a system
> with a 96:1 (PMEM:RAM) ratio where that correlates to maximum PMEM and
> minimum RAM, and mapping all PMEM consumes all RAM. As far as I
> understand real world populations are rarely going past 8:1, that
> seems to make 'struct page' in RAM feasible even for the 2M compound
> page case.
> 
> Let me ask you for a data point, since you're one of the people
> actively deploying such systems, would you still use the 'struct page'
> in PMEM capability after this set was merged?
> 
We might be sticking to RAM stored 'struct page' yes, but hard to say atm
what the future holds.

>> One thing to point out about altmap is that the degradation (in pinning and
>> unpining) we observed with struct page's in device memory, is no longer observed
>> once 1) we batch ref count updates as we move to compound pages 2) reusing
>> tail pages seems to lead to these struct pages staying more likely in cache
>> which perhaps contributes to dirtying a lot less cachelines.
> 
> True, it makes it more palatable to survive 'struct page' in PMEM, but
> it's an ongoing maintenance burden that I'm not sure there are users
> after putting 'struct page' on a diet. 

FWIW all I was trying to point out is that the 2M huge page overhead is still non
trivial. It is indeed much better than it is ATM yes, but still 6G per 1TB with 2M huge
pages. Only with 1G would be non-existent overhead, but then we have a trade-off elsewhere
in terms of poisoning a whole 1G page and what not.

> Don't get me wrong the
> capability is still needed for filesystem-dax, but the distinction is
> that vmemmap_populate_compound_pages() need never worry about an
> altmap.
> 
IMO there's not much added complexity strictly speaking about altmap. We still use the
same vmemmap_{pmd,pte,pgd}_populate helpers which just pass an altmap. So whatever it is
being maintained for fsdax or other altmap consumers (e.g. we seem to be working towards
hotplug making use of it) we are using it in the exact same way.

The complexity of the future vmemmap_populate_compound_pages() has more to do with reusing
vmemmap blocks allocated in previous vmemmap pages, and preserving that across section
onlining (for 1G pages).

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
