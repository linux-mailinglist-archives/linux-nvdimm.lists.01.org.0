Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A86316E4E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 19:18:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 05550100EA917;
	Wed, 10 Feb 2021 10:18:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 38A09100EA915
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 10:18:50 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AIDkVP116969;
	Wed, 10 Feb 2021 18:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ohGq6eEJX7JYWdlL17KxdXJ6R7Tq81Q8fQjrlmt+/ec=;
 b=vFF60VYe+4GQWSIel+3D/5ndJmpcK+GR+nWqp8RcCHu7i3cjRqyvX2Yzv4RyyhU+vACe
 De5mP7CYLLqlsaLf6HQHKGX/062DxbDWIbT4/xv7iumYG1H+JvYjpTU+JWuyG8qzuv46
 HLpz1cR5c0aWGv4Fbvp4HazZYris4ILSZ0fv2JSCN0I2TUm8rloP9XhHCOG+5LeLFfib
 uGLRiNEZ4vXb8qvI87CTstqELvcBJyVNFUd6BfzcnR24vRiVAxe0YjyHq+cxGEHzjPF4
 MXyu3rzlFTS+0wcquHTDpVbqH5eoZ+JqXRc4a5AUmG4e24g4/Y3KD9wPjzpZjmcNk4Z/ aQ==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 36hkrn4fu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Feb 2021 18:18:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AIA00f074633;
	Wed, 10 Feb 2021 18:18:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
	by aserp3030.oracle.com with ESMTP id 36j4pqgd1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Feb 2021 18:18:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0kwjX5HKrP8K71qGx0b3alIymgDWzCDnkA4jUkeapvRFETMDdosghArKVf3odbrEeFQ8wGjxo2jMRl++gUtchTcXcApHWCv0O5tZY1rkqs/5n2cAr0KC4k2mrTyqOZJSUVn7oPxLHbd1epf2qRp39gt0nl34poDsAShxbKU68gAg/6KmRHQM3rtrJ0PiIoiCT72UG2BNCEM1Z0OZt0NhL3QbZrxhNn+m5rRH806CzlkrWRz2QK1MoaowV9iPLrfR9Hsyx9WgvdD3Ou0V+v/E6Aj2JbHLaZ7To3ZsYtKF7L9jiauky2ZC/zDFiShZ6PLn3FXwJIcW6ySoq4nOoZ2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohGq6eEJX7JYWdlL17KxdXJ6R7Tq81Q8fQjrlmt+/ec=;
 b=mQ537keoIrLtJm8rP/TZPrCn22U3yUcAJpz8nFZ10vItnbaBG5BTmR1zkhmRjDA2vD3QN/n8m7mA6NtT5EhuFpCc2ry1k6bpnWfJyL0dD2R3kkXMSoR7Q4gJs7tNU2G087Z+dXnr7lCt4ADOLWqshQmwxb6p+zrp7fgjjIwn7GbpZAUXQgWhDus19yznX6LkWaJwg0i9NxZANoSOmUzjZOVED0/Lg+ZWzC6qWviNAKG7NA6HNFNxqbsThTEPr+V9RZRyZ8unV5fdhFZ0wgvc/h8bLEukw4WChOVZ5DDW1SUeD5ci4wTlldjujgqjhVN2jp8g8M3X5tIvjog2q21+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohGq6eEJX7JYWdlL17KxdXJ6R7Tq81Q8fQjrlmt+/ec=;
 b=c0vjFfRGX+MHPJuoabKiwUsnpJxk2JBq/7QVYqlnrEb5596pswPwq7sZXhfaysPaMof7jwmzQFjYv27mCr65boqUNZ8eRnnN8SwKwLPV0Xf27hvCS6Z/Z6LlPFAlRZn2lGUXolmduoKfGzL2CVETYRcnvMs5sTwMCc3vebyDnis=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3349.namprd10.prod.outlook.com (2603:10b6:a03:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.29; Wed, 10 Feb
 2021 18:18:42 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 18:18:42 +0000
Subject: Re: [PATCH] dax: fix default return code of range_parse()
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
References: <20210126021331.1059933-1-ruansy.fnst@cn.fujitsu.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <b685493f-98f5-9717-f88a-308e96440dcd@oracle.com>
Date: Wed, 10 Feb 2021 18:18:35 +0000
In-Reply-To: <20210126021331.1059933-1-ruansy.fnst@cn.fujitsu.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0212.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::19) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0212.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a5::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Wed, 10 Feb 2021 18:18:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2378be1-550b-44be-69f9-08d8cdf04be9
X-MS-TrafficTypeDiagnostic: BYAPR10MB3349:
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB3349ADC749C396A7532A05ABBB8D9@BYAPR10MB3349.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NjPQiefl9QYKQrjICU/AFUFprBe3EAogREPfuAaCYUH5HIg9bibCtDq+vZt1PNYQHAA1NSDWmwyg4+8OQgUp8X3gRnaZgueflmKziQlLiPPSQnG9UzcEyqRQM846ZSB46jdC/rZ+Ku8eZ079BaN1po+u+oV8+Yg6h08uLLSAjFHreInW3QuJT+g6St16uLpThPoR7sLOfxnfgxWjQb3inRvxmzhVf/UevjBLCUBZg042MEDLiwYOCenEmGPFy2oOE090V8Yu1Ax39y/IoSFbUFPg09Wax0/jM3JR9FqMlrEllENg4Z2XF3hOoObBf5csT90AsEbMsqzJNayFMS3O+LynfGmCCtdHBXGNMQFIoZC1DKGiddd19CU2Ngrzaaeo4JE582GZRXLQcgTcGkKhcLAZwNWlq1U6zHWy+YTNbu2uHNAk2LtWmkJU3oZAtLJUb3vrgWqS9BKUiYnQpmfvaPcClfkXFuLP7TB2uWgYWODXeNQ/+KRotV0s7fWNON3BG7VKta8RK/oJW2Y1urW+9yHQzmb70/OZ0Fu2ic283mnhiSqJC7zjaaHi82C0rQQRWbcNtJ9tsCeElVWCpVPyPOZ0z/Bng5DEQoQkpQfVASGO9y8+JnuVK5QR9Ds7YIaY7mD8nTnRxjvzSEVNNaNJ+56WSVh+NnAZpOGMqULsctI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(366004)(376002)(136003)(86362001)(36756003)(31686004)(478600001)(66946007)(66476007)(66556008)(83380400001)(31696002)(956004)(2616005)(53546011)(8936002)(16526019)(186003)(8676002)(26005)(16576012)(316002)(4744005)(6916009)(2906002)(4326008)(5660300002)(6666004)(966005)(6486002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?UXErV2lnTmVJaGVGRm1WUW5WTlNMM2NQK2t3MDFLckZaTjlSMDVsNDRTM0xy?=
 =?utf-8?B?SjNOdUs2ejl4dHhNVGJQU204QXJ2L1NqbCszdnRRdVEzM0ZWZk9KMlRzSklq?=
 =?utf-8?B?TDFZZDFuSGRrcklZdjY0WXNyNE5aK21KQzNIVU5OWHp6MHVmcG1RYW1uZkww?=
 =?utf-8?B?aU9BZ29ETHYxVDhBK2NyNVVjaHczWFRKVHNneEZaMUFaTjM0UXJ4NE1KL3NR?=
 =?utf-8?B?elE2MDhDTmFEaENySitLbVEvYzVRUHhITUZMek93bDcwYXh4SEZuU05seUZC?=
 =?utf-8?B?Vm9qZW9Ma3NML0YvaTd4NW44VkVWeTN1R3EyZUhBMGtJbXBCdURxcUtGWjM2?=
 =?utf-8?B?UnFvUG1BKy8raVR2RjJsU1dpMXZub2wxTmFnOFhvWElPVUdVS3puSVVuYjFo?=
 =?utf-8?B?ZlBUc09wRkZlRGhaUTkvQkhvNXBXVmVzRDl0TDJtN2tiV2lJOXNNZ2gyZlNx?=
 =?utf-8?B?aEFRS1h5SmRCWUJaR1NSeDkweWU3clNpRlJOQ3lvcm9zN1RKOFhEQStvcDI0?=
 =?utf-8?B?VmJQeHNkclhYMW9pM2dZYVVTVVM2alN1R09xWFpaVkZTNHpFWnlJZ1BTYUtt?=
 =?utf-8?B?NDJSVjA4WnM1WmdKM2Q4Z2ZDRDFnTGZhdHFRY1VJN1lMTEVZbXFBZDZ4cUJI?=
 =?utf-8?B?VndwRW5sVkZqZEFTWjNjL2dqTUVOMzk0ektEZ0k2UTMzWjVoclB5WUgvb2RZ?=
 =?utf-8?B?WkZhdmQ4QWRxOUdoZ3Ayd25sVEpDdE5aaTRJaHk4Y24xSDZaNnZMcmFPTXVZ?=
 =?utf-8?B?OUlXa3JuelczQWN5UFQ2amVQbUFUZElOeGpCVlBuSXdZWXYxRVltL3pUNXdJ?=
 =?utf-8?B?OUVucTUvRTRmb0hCOTBXbWFETXREbktUZUMwbktudHBOVW1JM0pQQmhHdExV?=
 =?utf-8?B?cVNzR2EzZDAwMFpzdmluVjJNQ3FCdU13Wi9hS0gwbmRxdTJacWJiQzA3V2NR?=
 =?utf-8?B?cnN1RVhwcHJxaFFpMzNCWU9LRFF5ZlNSUnZCUStpdVluREtNOWZFY2NNRWxu?=
 =?utf-8?B?TC9XZzV2S1VSOWFPa0U1T2IzeTBUZGhVZ3U1VzdDYi93ZlVqUUFtQk9GZmdo?=
 =?utf-8?B?TFJ5cHNZYzBhd0lxLzNyQlE2V3FZVXRXQUthdlYzME9UYXdkZXI5KzB3Njg3?=
 =?utf-8?B?VmRCeVJwbzVVMHVNeFduR2c3eUI5Y2RXc1FialNCcGUzd2ZxUlRxVjdXT0hl?=
 =?utf-8?B?cmc3TGxtNmVycGN2ejlSQTRVYWNETS9TeHgvVnU5NTFZbjFrN3Yrc29xS0hE?=
 =?utf-8?B?aGZ6MFdvRUxZZlRPZGNENzRDMHR4WjREbHFGdjlCNDBzMGluYUV0TythSU55?=
 =?utf-8?B?eDlESEFpdExFallkN1lzRU84Y09UZUppaXY4TUk4dFA1TXp6N0FXSjJNYldZ?=
 =?utf-8?B?Z24vLzZtak5UaCs0aDhyaVJDcHlrYjVjK0ptVkxLcTBWdmV4RklSMnIwdWNY?=
 =?utf-8?B?b2VTYTNWYk10dFh2ZDN2dWs4RjE4OXA1T1E5WFBKUjR5WFRxbVhlampJR0Zq?=
 =?utf-8?B?b2tLaWJMbng4S3ZpQmNrUFNuaTl3eXJJdEFQK2E4R1V4RlBCbnR2SUZOMlEx?=
 =?utf-8?B?TnBERjBWUVlaZGF5MWZWWnI5ZTV6VVVKanY3MjdSS3g2bkpCWklSTTJ0amVR?=
 =?utf-8?B?cDZaSkdETlVpZXUxdFpobThmMVBwaFllS3NxTkRXbHAyeWloV1dkMmdOSUVX?=
 =?utf-8?B?T2tEZTZUL2UxZEJXVFpxTlhDempIakFwVGJvcnVvUmZEVmhYTWJ4dnNHeG9k?=
 =?utf-8?Q?ZdI45X0n45hc3mpli17qbVb0AlcO0uCV4eAvdGw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2378be1-550b-44be-69f9-08d8cdf04be9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 18:18:42.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvwnhhh8qmoVDHMGHRKNVwVcYTaNrXkvtqnbmfg6nEtT+0cQ8qwjSh2s9K+JeCA0FnnUM5+8RrSthmQdC25Keq3JL88QoGbzTG8cRaJe8aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3349
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100166
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100166
Message-ID-Hash: SYRBTAH7CIXLDCY5J6GRXO6LILATYHKK
X-Message-ID-Hash: SYRBTAH7CIXLDCY5J6GRXO6LILATYHKK
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SYRBTAH7CIXLDCY5J6GRXO6LILATYHKK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/26/21 2:13 AM, Shiyang Ruan wrote:
> The return value of range_parse() indicates the size when it is
> positive.  The error code should be negative.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

Although, FWIW, there was another patch exactly like this a couple
months ago, albeit it didn't get pulled for some reason:

https://lore.kernel.org/linux-nvdimm/20201026110425.136629-1-zhangqilong3@huawei.com/

> ---
>  drivers/dax/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 737b207c9e30..3003558c1a8b 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -1038,7 +1038,7 @@ static ssize_t range_parse(const char *opt, size_t len, struct range *range)
>  {
>  	unsigned long long addr = 0;
>  	char *start, *end, *str;
> -	ssize_t rc = EINVAL;
> +	ssize_t rc = -EINVAL;
>  
>  	str = kstrdup(opt, GFP_KERNEL);
>  	if (!str)
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
