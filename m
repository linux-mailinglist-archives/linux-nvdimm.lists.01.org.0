Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24949321DBA
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 18:09:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4D9E8100EB839;
	Mon, 22 Feb 2021 09:09:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BA4E7100EBB86
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 09:09:40 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MH5bKC036750;
	Mon, 22 Feb 2021 17:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=fozLoeosO3ryqrvnyb9GQYhlXBql2Fjhc0GEN65in9c=;
 b=0FqlbNFNK4jMj9CWVcEsZVc6Dcz8aVGH3/8lOmixm9f5NgGeY/MmUR+7inGa2l0HuJyL
 uOiuNEmN31aSXY9qbvkskKTjsQGRueTLJCHmAHuGD5Slx5duwSc7J4fHsy06ho/M+0OF
 MdtiN1427u4XYdQSxJwkJzlH1kyroIyaC7gV1B4jH5AWFALwZeDSsc++GQnu+BWEjufs
 B8gVGfYHI5IEGbv5OlfhNc/Y0whOVImBUenQ/Omt92L6Etw7Et6/V4zLBZEx+2MPpgWv
 kZrMcPVRON4rI4SmnszY+JP/KRvJzsHa7Y+NWrYzMU37uM8n24wb3AWrK48DEnvePDgj lw==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 36tsuqvdqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 17:09:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MH6I4f147915;
	Mon, 22 Feb 2021 17:09:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2057.outbound.protection.outlook.com [104.47.36.57])
	by aserp3030.oracle.com with ESMTP id 36v9m3h8eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 17:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgfHv/KIlYuXgnGFq453IqoxlkXgB/SwQPwhmAFzWNvtwlkbI+XOL3wAZ5dYu2ld97aVIiGtVK5IstQV/jFbe6K6UDZPso/3r+ivP5BMMD+5p48U1H562bknAs9WaFdMXZ47JJkjU1f9vLLmramJbVLhf3oljN84kW0WvF0AQDHWYHogbKNf19v3ede2weBN1UExBz9tAq0BN4HkXHdzTbsAemsI+FaVxgOTnQ4JWfzAz/RG+BaidbfoblFUvaYGbv/1mjw0+tMbDxDlw8ITBJ4ZMF7q/Hae27gs6HXVEcSf+iGpLago5vks7jiTAiYwUVGQtJGov8/njXyFg9CHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fozLoeosO3ryqrvnyb9GQYhlXBql2Fjhc0GEN65in9c=;
 b=Cj5kxstmLSj4FA2R3MAl4E05uS2Ug4n8fu+rae4NOLW6vROIi8jDBQfnvAOtFZrgjgUqH2quQyyzQxQSiGsgzk+Tl8ovud7Idw81H22sJNqtyb0QKZuX1SWiuq77NkZE1jXGeD0MtdAzN1B07+ueICz/NS2O5gTT+twcMDr0JkVOTARqyncqMP3DhEZkcag8q8n5s8z9aAy5p2PZCJHnjanE0d7tCoCfJPtJDXNGT4nb5drgIajg2fRwqZyjc0GcScDbzr86TMSUN+727jgQS6dk4iM65JxQhC2pywvxXRWCTyFBea6TROR+PGuD7+hOXxCMKsv658lC6oFMuJGZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fozLoeosO3ryqrvnyb9GQYhlXBql2Fjhc0GEN65in9c=;
 b=nbvcTuSqX54uJ2x2bkQ7PaxqpJQFAw4cR4SlL70WRtF/TjBAsjm7Jo95+8gyqWmU/g8xvdU8a4hCtreeHGRrB8uG4OuPAV21F2ehrCsIRDSA0CJhwlAjNofinRPaUOvJpJhNE2a6hAmHi5jyuFRVnSucFwwDWAFD+k02s+bGU64=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4116.namprd10.prod.outlook.com (2603:10b6:a03:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Mon, 22 Feb
 2021 17:09:22 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 17:09:22 +0000
Date: Mon, 22 Feb 2021 12:09:17 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v2] cxl/mem: Fix potential memory leak
Message-ID: <YDPlPR4nlVY6ufGi@Konrads-MacBook-Pro.local>
References: <20210220215641.604535-1-ben.widawsky@intel.com>
 <20210221035846.680145-1-ben.widawsky@intel.com>
Content-Disposition: inline
In-Reply-To: <20210221035846.680145-1-ben.widawsky@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: SJ0PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:a03:333::15) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (209.6.208.110) by SJ0PR03CA0100.namprd03.prod.outlook.com (2603:10b6:a03:333::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend Transport; Mon, 22 Feb 2021 17:09:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9daa3f51-32c0-4398-0b42-08d8d754990e
X-MS-TrafficTypeDiagnostic: BY5PR10MB4116:
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB4116AAC630852D5EBA06F30989819@BY5PR10MB4116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AOFHfkSK/MHcjwddJPcxA0TFa20jAKoC8sZRNIcCIUqZQm02TavKw8+uwJjj+xCCKpOHG/W+KlcxCN3hwL+exv25R0MK0d3Cbb4K14UuPbPOy8SAk0pSZ10I0YJPYa7424ReK2lySzwJEuu7AiEXd6V4AdH1DvLhGArNGij355LPMvtn+8qaLoXQm3IxYKEPHhqRSv+LCR8LsmC+Pf0aCPRt578qYNQxSaa0m84fxjL6y/5xm4sJua82MJGt6DvPYVL9u+tL9oATPQka/RpsUqPyIDrh2Pm1qEPvDqgm0Exx6ALkhCK8J+8durvRe5OCeJMeNl701aBQB605hZEFTjSSi8QfsQj47pJuXFTLxozZm0Eookv06dtJuVuHWVygU0wakRZvA50J7zcK9VmdtPC7w3+ndBKTQ/PvJ4YVsrPpUlqDVdvss/Yb+zk36dbxJqEgFoAzIetcmr0VBGZkxWHzfgMczVFwjhERb8M5knhkf/+TXtQNHjrXKuyJfaBwEQw37ZBzz2F/sX5+x8U6sQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(316002)(54906003)(478600001)(16526019)(2906002)(186003)(26005)(4326008)(6506007)(83380400001)(6666004)(8676002)(9686003)(956004)(6916009)(55016002)(5660300002)(52116002)(66556008)(7696005)(66946007)(8936002)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?M+82PcfsfvE6FJcZyaoqC+bDlm1w/zYaaYNRq+uu9fZutClKQWKUBgbJN06G?=
 =?us-ascii?Q?/YE4AgT/qUxTZupKxCilFMvAaCaJEkydHaVtJBWXB2SvZMEdDU+FLP3aiWBZ?=
 =?us-ascii?Q?Um6HHA1lPpR7fa5NRtoGaihIpyolW7GKQoAd36Gj66XHDY88APTDN+LMGsEY?=
 =?us-ascii?Q?5OwcfuWsihx36VPtjqFKoznG06ApPHCL6ev+7NyKsuIwUDQ89Jkpk4DRjz+X?=
 =?us-ascii?Q?vjuW86BR5usgBLKn+UZrewrb5NFO6KDOTcN5A7b5vVaJ1WSpvGVkxWx0GcmL?=
 =?us-ascii?Q?3zLCUKPo+mpqZOw6HG8lvDZIwfonGDqjNhthwxlSobDhAPuVicalAic6sUuC?=
 =?us-ascii?Q?P7VH/y5yuzAis5F0QjUkyIirY6RhhJ22KBn8dBW+X4LjWhJEbTB7QtbHgHmb?=
 =?us-ascii?Q?PTAEUmPcV8V2NeQaJ5+z2R7ET1Dl1GrnVFx8DJNiYDtVE7Gr7Cz0WbBa2DGh?=
 =?us-ascii?Q?Sa0imwrjfYVxj/04dtTUm57prOzYA/sCVQD+DNRvDDiatcT3jV6Fueao0304?=
 =?us-ascii?Q?aNEa1hUt5I4SiigiQVWlVAe7SGMj/WuLMq6Yyy7aZvFLKv1bNRv7+v7nKeg2?=
 =?us-ascii?Q?neJEhLa1iAEEKZIukJ44/ZoKuNvkh0+7JJgFxGSdD1Y7eYcoBuR3ndarD6l6?=
 =?us-ascii?Q?YE+S3uMvonah64zFZ9ZQPr/GbhG7C9kFQzgOdA+2fgajvcW5zrJvs6GewBDw?=
 =?us-ascii?Q?qNnyDJxXPdrrQGiR/JHgEF+FM2vKgfSUwf3zFuA0fj5Giwy+Z824+/bA6nAW?=
 =?us-ascii?Q?nuF3blywxg+ALZij+PFj5Epg4+CUiiCdTeBYO2tpqZj+u+UVgVbkNe/FZmmm?=
 =?us-ascii?Q?D9vQIr87WRYDUpMV7L8wMsIwOk2WMJhfvlA3mD4V+1P5++ZejKYF9fVX8ySj?=
 =?us-ascii?Q?UhT2RcBoTWDrpystG3RNw36SmMHS1g5VlOd3uCrX3VGmC900diPDIQlGbhvh?=
 =?us-ascii?Q?a+qA0KsI5UGnjCTjv3jv4qlRpOx290VvLm7UcphPLiCRY0JiH55POUk4xrGl?=
 =?us-ascii?Q?yrp2LGd+w/W3yZzA+4yM/I9SYd3bmVZhnWpjns86ix++sKCKqLiX4ptemak3?=
 =?us-ascii?Q?ib6IpJV2/9j8432Cwi2l3nDB8Hg0yFBzH1A+Wo143FGXEPan8gI4OnAE1DSG?=
 =?us-ascii?Q?MSHTa9M70wDVEPNqjM+af+264SW/jnweHylM3MPOKWKFS8RAO6jHbWkA9x8K?=
 =?us-ascii?Q?NFBHq7XjSg2tLD8aQHX6bHhD9cSDAXcR40hPUlwESBSMYtzl7TD/Xj26yO9y?=
 =?us-ascii?Q?F7oUrgHqFse3iMgVbI7k5TzN5snra8Q502k/nfpLjZyGqRL+N1G9hvNEyW4D?=
 =?us-ascii?Q?FA22U2OMcmNMs4ZKo/Knk4aa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9daa3f51-32c0-4398-0b42-08d8d754990e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 17:09:22.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFnZvaoR6eaPyltG3lBUdhISY7rTPYtrD9ZNxgCNeUhGBlVjcWrewdOrxRc1UENp2qsDeSa+9Cw7rEt8tyGtzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220153
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1011 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220153
Message-ID-Hash: AJRYVOLXO57RMQFAFCIXP5KU2EABTRPA
X-Message-ID-Hash: AJRYVOLXO57RMQFAFCIXP5KU2EABTRPA
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-nvdimm@lists.01.org, Alison Schofield <alison.schofield@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AJRYVOLXO57RMQFAFCIXP5KU2EABTRPA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Feb 20, 2021 at 07:58:46PM -0800, Ben Widawsky wrote:
> When submitting a command for userspace, input and output payload bounce
> buffers are allocated. For a given command, both input and output
> buffers may exist and so when allocation of the input buffer fails, the
> output buffer must be freed too.
> 
> As far as I can tell, userspace can't easily exploit the leak to OOM a
> machine unless the machine was already near OOM state.
> 
> Fixes: 583fa5e71cae ("cxl/mem: Add basic IOCTL interface")
> Reported-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

And lets add the other R-tag:

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you for quick turn-around!
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index df895bcca63a..244cb7d89678 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -514,8 +514,10 @@ static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
>  	if (cmd->info.size_in) {
>  		mbox_cmd.payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
>  						   cmd->info.size_in);
> -		if (IS_ERR(mbox_cmd.payload_in))
> +		if (IS_ERR(mbox_cmd.payload_in)) {
> +			kvfree(mbox_cmd.payload_out);
>  			return PTR_ERR(mbox_cmd.payload_in);
> +		}
>  	}
>  
>  	rc = cxl_mem_mbox_get(cxlm);
> -- 
> 2.30.1
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
