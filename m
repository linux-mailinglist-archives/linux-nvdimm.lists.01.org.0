Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B4032150C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 12:26:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 69578100EBB9E;
	Mon, 22 Feb 2021 03:26:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5F1E7100EBB98
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 03:26:41 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MBOnpF088772;
	Mon, 22 Feb 2021 11:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=C7ne5def+lAUqCySC3lN/5zl/xw2L5XrB0X3MXt90lY=;
 b=gGPaNC3rxiSw1etT/K04/hOoGIL3c3ImxMuLxkADmJk+htOMkduc6snTORcup0qXw0PY
 xPkQcC7iz6peR608lZoLtrj8YHdTER2my73MxAdGcuFPysg0p4VBovAlFLiSmUi7FBAo
 YnmyBrVH+TbLyqdcZhP3ArX6bN1UMTCq3JOKVdpZ01q8l1Mt/Eycs2rZzM6nQRrMOsb3
 L+Zf8fQ971auOIWbrNjP6eqNavUKxAeqek6AGKxODgB3mxX/VXbzhL7I2ooHaStMzXLx
 fNd938hUlohOSTNR72IQEgJAZrGmtveGN0UaAAZ8Vu444BmZknq+MVlu+AewSyVEXG8J kA==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2120.oracle.com with ESMTP id 36ttcm39r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 11:26:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MBQV6r108084;
	Mon, 22 Feb 2021 11:26:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by aserp3020.oracle.com with ESMTP id 36ucawwpfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 11:26:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ai9N4rCwRpRztSxEm7bJBF5n5TDOKJ1XXfFyzkDyABo9Cmf2+M3zILJ518dtoaSZhf72IBQx57tOX+w0K5NXKuoWd95doWkvaE6uMFAHdBqoB8mXV2IvTjTg941dwAfQkAZE6LLVAZ+ksHl8K1yens2hl3m0aXhnudpHKzTx0aSrAWPjtJ7PuxkInoueR6ZDD9TNpriwWl9fHj4N2Pl023azDe+a6zY6s8I4QhwgRHfDrgGA9wSBo2lu9VCeGbPVV5KqUkZ2IF6UQgHsRiS2U3Ce8Qzv82QXvcpn+XTOLZBY+p3FabB4Kyrx3WkRaDjY4yLCT/dIdUfdCtu7t2NMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7ne5def+lAUqCySC3lN/5zl/xw2L5XrB0X3MXt90lY=;
 b=kcQV0nZr/r0LgK6zeDmGHiXOaaJaFqnwSDhw9WNod3cGy2yIrswR+5XtchW4HPbAo2DqtW0ETpFVZHIgW9Y0PBfx8FIjokliweSDMdckj5UKPAocnrt75fNtw+nG+mXXdIh0kDjnFgQTmp71X3SCwuHCAVfEgGPHKtedOIZzZQIY4PZjKeP40X7k7d/eETkOvV9WYnIlAIDrAKVo5WFqHvKdeuolPbnmx2VFL3dhH86uzPTZXU8Fkd+KLM4Cq9mDx5SqqY+S1ZYJjxoxWCajXLMY8ff6Te9ekW9yh72deYAfak+2n0i7fquevfDT+gENlGPHthGbW/RLH/T3M1PYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7ne5def+lAUqCySC3lN/5zl/xw2L5XrB0X3MXt90lY=;
 b=NLQCz5MuI/zP7UFM2NwtTBxDnx9Pz9L0Mg1HGu1gPwvQO6xGBXAX/d9iw2S2Xo7vMza32cvj/46mYojfsi/NnjqN+o+1vaoGAKr4+C4E46rEceD7GQSNEXuWtDy7jvkUZDu3mUFsKekWvUDG0J/XXM6yVGEdS7F5zKpbLBgypT4=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3352.namprd10.prod.outlook.com (2603:10b6:a03:159::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Mon, 22 Feb
 2021 11:26:17 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 11:26:17 +0000
Subject: Re: [PATCH RFC 2/9] sparse-vmemmap: Consolidate arguments in vmemmap
 section populate
To: Dan Williams <dan.j.williams@intel.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-3-joao.m.martins@oracle.com>
 <CAPcyv4gXOGZKGkEPKmFa-w=BavUbUH8o9WxpzDugbuOHt-Y8Tw@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <6f4cde44-71df-6231-5de4-f8c87c52d09b@oracle.com>
Date: Mon, 22 Feb 2021 11:26:06 +0000
In-Reply-To: <CAPcyv4gXOGZKGkEPKmFa-w=BavUbUH8o9WxpzDugbuOHt-Y8Tw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0422.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::13) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0422.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18b::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29 via Frontend Transport; Mon, 22 Feb 2021 11:26:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bf4c7d9-82bf-4c56-82e2-08d8d724ab6c
X-MS-TrafficTypeDiagnostic: BYAPR10MB3352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB335212363F62CC9C61F36FB1BB819@BYAPR10MB3352.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YUT7SiPyPDsZ4R/c7vMpiTTkpy57dCOcLzIO8aN2gfKebpaSai5fM+PFrRzng5E15cNpuULWGDvBN016LseG5N8QSx0Ki/xVam4zCtiEkAU2WH6I1NtXGcUdcbjZLsriCB5lhvs6lRM0CZKFrgItahzdAO4b+glDBOdDhOlfwPViczchWUjlroUOpmGQfYOnwWiL51Ea+saebh4q5lpDDH3x14PePPZrI6plugQ65HviVwuGsaWgVZONZNP979seS/UEF6rH5rOe7u46+DlBISzcwxjebEHwavM3S+zIoJBYlKkm5GeartUhtS8A4MDVnCD5dptWJeM5FvmxAqYiH0PXO7YeVsLLyUeffE74SZU0Tyz/bRi3SMwWjplYxK/JrutnuBGP3ooMTThd8XGgUwa4f/3LRudGB54XrpNk3gUArb948cs+e/Lgrat6ATZ+AvF0YyNCehr3V8QPik2miEr+2Lwy61ly36PIL5aHK/b6xTxBz3dnqiBXs/jh8sYejb5CDtvJdYwmUJ7qQD6amgCJyEJucpziBOJzA6NS+bLWkTkPPNBKYpHVblOkOVdpE5EmzzhHOeQ795d+HuJC3Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(39860400002)(136003)(6916009)(2906002)(31696002)(36756003)(86362001)(66946007)(66556008)(66476007)(4326008)(5660300002)(478600001)(53546011)(2616005)(6666004)(956004)(16576012)(54906003)(316002)(26005)(31686004)(186003)(16526019)(6486002)(4744005)(8676002)(8936002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?ejVGL2JsZHAzSHp1cHdLOWUvTVpaY255Zm5ZcFNTZ3dXOEdLV21JR2hFUVhl?=
 =?utf-8?B?aHRQVGlQWjk4MFdVaE5GaHNHVUM1VUw2R2NTclREZkxEMit2cjg1SWtTdG5S?=
 =?utf-8?B?RDY0QTltZHE4eXhscTNlcTEyUi93WHozZ2thVXZ1c0hMc3B5aUtqTmdXdXhH?=
 =?utf-8?B?T2dWdkV1U3RSVlFPNWozQ1NLQUFQUVE1alNNL3ZFZDdnUFJ3cklrZnpNTWNX?=
 =?utf-8?B?ZE5PSVB5UkJxWUFsRWs4b04yVk9mdXpjOVlTRnRlU0JRYlVPcXlzellEZ3Z4?=
 =?utf-8?B?QlMxWVk0blZubmpHZmZRbmdLQzNNMGNMbkRSU0ZxbEpKT1RwR3F6MUpzdDlQ?=
 =?utf-8?B?S0dRSDRvVzBTcEVTSXFxL3pnT2x6M09ReHZUWThEM2xXNEV5T2g4NDBZMjZ3?=
 =?utf-8?B?Ym1KZEJtRW1RcUFnTlFXVG0wZDkvTVZPWVhBR2VBQmNVcTN2cW1DVkM2REl1?=
 =?utf-8?B?RFpwbkExSnBRRyttMXp3VWoyNXhZc1F1MzBuWlVDUXJKQkNpbVdJVFFHNC9N?=
 =?utf-8?B?VEZVeEs2K1J5bC9UVTJuamFqcW1OQ0F6UFRwMlhuWm9XY2FHZUNKcFk0bFVO?=
 =?utf-8?B?THE1NUNWem1wRmJjN0pBVkpPeGJ1WU1HbzV6MXIwQTlZbytoaDlUazlUcHVv?=
 =?utf-8?B?YzhtWmlFdEVzWkFoUW43NEFEVjl6bklZdEZ5a25FYk5sNk14a1puZHlJSHNo?=
 =?utf-8?B?QndVL3VHajNIZUpsb1NBZ0VqVFRlZTBTN2tqeGhqWThCMDA3UTdpdDRpVkpT?=
 =?utf-8?B?YmpzTmFOeHZpai9TaTN0MVRUMmRKeExRclZPRDgyYkgvd2N6UXFiV08rR3ha?=
 =?utf-8?B?Y3BlczRwS1NuWllsRTh4ZnVjcHUwZENhaDNuL0daNjlGMjBvNFYxMDdwQklF?=
 =?utf-8?B?QnhkZ0hKTStQNXN2aXJTR0lDQ3M5RWtWWUJnVjM0OUd1UzVaMWJIMnl1TUxr?=
 =?utf-8?B?VnR0Y1RlRkI3bkx4U0xwaG1PbFhJTTdLQWtnZGgxK3dkVkRyZ0xSOEU5dmFI?=
 =?utf-8?B?TlNDdC8zZGxkMXAxaTJRV2toYTUvVEJXWUsvZlY5cVU0bVhZa2FSTW1ZNkNJ?=
 =?utf-8?B?WWhLa0tpVzhGTGNLWGJTeE9iYkk0RDE1ZFVWUmluVHpGVkdsSkwybzc0dVVP?=
 =?utf-8?B?M0NsL0FRVHlnMlRsbi9jbnZ5RE81MTI2dHBwa1hBRS9Nd29MUWh4a2ZWd0p3?=
 =?utf-8?B?WjIvbGJMZnF3cmF5LzRBa2lkNGY3SnpyMTBpYktkVTk0WThuRldLcEtONGll?=
 =?utf-8?B?WTNHemhJVGtjKzRkR3QvUEZiZEpTTmVFYjM1cThua0E0VTdkdkUwQWJEN2dP?=
 =?utf-8?B?cGRFbHRreHl0TDhwUGlwNHN6aHFrZzg2OENsRVlLS29ZOEoxUm4yREZpMGpx?=
 =?utf-8?B?c2xYMEM1ZmJ0MlVranE5VktXc1M3c1AxeUljdWRkN3d4K0JqTWNWRjR0ZWEv?=
 =?utf-8?B?bnVHRXdSei8zUmlxK3ZTVms3b05nL3U2N2EwekhHSWRFQURqakZxNEszc0h6?=
 =?utf-8?B?QVVhcFpra1NPSVNNQmt6aXBTaXROZ0tCdDhyS0xZNHcrWWwreVpYVjIxb0RB?=
 =?utf-8?B?TzFuZXVVTHdQSVM0eW0wUnhZNW1VdkhpN3BlWWN0Q0tDTzJlRGxXeHI4Y3Ur?=
 =?utf-8?B?c0NTTVFYeTNLSkZtVDZaWHBTVHh5enp6T1BrTzVvaFlHUWM5OW9mSW5RNjd0?=
 =?utf-8?B?bktrakp5NFZoSE5rNzgvUWJTSG9DOW01b243cG0yNEJtZkVGMzFUVkt5RHlX?=
 =?utf-8?Q?wF+WA2TrbccqKBWSVUjKDjuEjR5Snt1DAMQAMJD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf4c7d9-82bf-4c56-82e2-08d8d724ab6c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 11:26:16.9264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsdxGV4T+EEIbwEqbFNvGSMFNqeeW/e0Rx2VPGMNmdmdDcr+7/DICcPrpFW46qE+dNahSMLA8l4K+K/z/BLNHfQYZ1xEdk56pNjZYXKY8Bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3352
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=837 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220106
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=930 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220106
Message-ID-Hash: N6R2MOOTHS6U2COTWDHZSFGSQZCMUAOX
X-Message-ID-Hash: N6R2MOOTHS6U2COTWDHZSFGSQZCMUAOX
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/N6R2MOOTHS6U2COTWDHZSFGSQZCMUAOX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/20/21 1:49 AM, Dan Williams wrote:
> On Tue, Dec 8, 2020 at 9:31 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> Replace vmem_altmap with an vmem_context argument. That let us
>> express how the vmemmap is gonna be initialized e.g. passing
>> flags and a page size for reusing pages upon initializing the
>> vmemmap.
>>
> 
> Per the comment on the last patch, if compound dev_pagemap never
> collides with vmem_altmap then I don't think this patch is needed.
> 
See my previous patch reply. It *might* be worth keeping that around.

And since the RFC, nvdimm is going to need a slight adjustment for the
altmap reserve pfn range, should we keep altmap around.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
