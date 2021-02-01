Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2656630AE12
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 18:39:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 88CB2100EB842;
	Mon,  1 Feb 2021 09:39:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 25D92100EB83C
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 09:39:22 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111HU9qn047692;
	Mon, 1 Feb 2021 17:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=Ou0WWH6+8eAmABBDyRQJqZ5DYvCY2OAPH37dm+YRjH0=;
 b=nGNocFO8feNRY0fd0hhGJcHpP6qkGoAWLoFvSrKeeE7LiojybDMcNISyTzL8rbvwnNPI
 MutAhjsE4gXC2eBFLnLf1O3WH/hC7Zn5NCQJvDJPmU6AfcrtiRtnxjnlrC0zdDRWVyZ1
 HquN8XINUFZrQB58QUIoQ2Gn0Tk07x+1efbpf3Gom4EoAh3uX8Y2dfQ6o3WiuReq1DvK
 KhXbHM5+YOXgKOeuMEms2ysAjTeBTTmqDxxcskbpUBqq1UGV8wE4KlRURaRrcOd7eq3c
 Vrq91UHXnQMm+QbSWWGEjwmqqGvTgc2E1O/b7+AVLUgAK0SgpWczvlQHPfYM7MgI1QAa Tg==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 36cxvqxkfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 17:38:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111HVQnY080841;
	Mon, 1 Feb 2021 17:36:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by aserp3030.oracle.com with ESMTP id 36dh1mq43n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 17:36:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYAHKtcj/27TdTlaIKMs5/zURKlCXVf4fsvd45oGxuKZG+aGwAPNGwVWJLQluFBcwBRjz8V29c2u3NWOmQv60MiejCjY3OgR/p9CUNS8d/gCF78ZmkX/7Lclymp1FUZerX4qu6l67LgKxaFuxGJtHhL8sIh4vntvA9QzDb3Pgj9rDQYhpNVYLvBf73uj+bs0iSsVfD5ZzH2vTdhFNqAMMCwunOOINe+iQ6UTKHKY6oFGoM4keOcgE9qaedXUvrjZjMjrQHJnczgASwt+MViEvodfB6vP57KM2sznpP31NDnQR2jfH8OW8xxPhim6NETkIPuLkcld5V4LOtc3V/p6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou0WWH6+8eAmABBDyRQJqZ5DYvCY2OAPH37dm+YRjH0=;
 b=MBTbTmnwdZ2WM5+7yHjxdpeiL/gwz/p/QSaRboBuZWeFuoAUAxRIaRzvnSs+fVYbZlCCfi4ppfilsCJgvE39oCTEV9fgIQO7tgMQnAF32aICq9yRQ1XUH9X2KSStycF7smcYbMvElqTTriOG4i/2Tq/weV9hI3nbrzHMls2YSZydW0gGIUfZNDYcq/xlNNnN2t2x3xhUg/989MIUUMdSLBpvPbfEjTjeDwjGI41BEbTpTtkk7UthDDVrfvxF6R1O64Pejpvs0BnIHpBozknlOk7go9nehgVhS+EIi8D2nlS/KH0XkQZutlQTKYz33Tp3IM8b7qKv48RnSFMn3E2XKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou0WWH6+8eAmABBDyRQJqZ5DYvCY2OAPH37dm+YRjH0=;
 b=PuQwItLUArYnyAdPmpm9gOpUhNhrP/iF2jlbGsu6NUXSy8UxNYiyYhqTiKSFilNh75EVpK9TBjg9vwkKDHHRUnag4LruKEioN7sUhheYW4oibgTuuz4XV1EvPrNX/P4jLsfCHhoojSE0O9ZG2e/28gsFyT6jV0gYF1mH1pNAshE=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Mon, 1 Feb
 2021 17:36:19 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3784.019; Mon, 1 Feb 2021
 17:36:19 +0000
Date: Mon, 1 Feb 2021 12:36:14 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 02/14] cxl/mem: Map memory device registers
Message-ID: <20210201173614.GE197521@fedora>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-3-ben.widawsky@intel.com>
Content-Disposition: inline
In-Reply-To: <20210130002438.1872527-3-ben.widawsky@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: BL0PR0102CA0001.prod.exchangelabs.com
 (2603:10b6:207:18::14) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (209.6.208.110) by BL0PR0102CA0001.prod.exchangelabs.com (2603:10b6:207:18::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 17:36:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6f40526-38d7-49f8-3191-08d8c6d7e23b
X-MS-TrafficTypeDiagnostic: BY5PR10MB3970:
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB397008B0FCAC3D593DE8F9FC89B69@BY5PR10MB3970.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kfOK7/X9d//BynkmMUFGvHboO4WPDmrX4rXz507EEcJYJfp1iOAfRM6pl1LOI5RFO5ghzsWOx/rggN737FQkeBVBpaDHJkL/fSPIHwb1X53ar+7bnm6QUW1I8eWWvAGxotiZMzzoxcCfzvznSaUday1y3RhmjH+B7XvzBIaGGM2sOt9oxSNpWt+tyF94XgU0vTogbRiCRGxDiBNUdKsU1hXVd2I8VlzABZUV6VWfZpviLPISACIoh3Fd7/UaAZGG+HOlEh8YGZd3owncE/BDafoCc3mEDYnbp5P58sjsetQLqY95ry8nY6bjxYsBymzeiNH2aFIZi+9FSfzLwaDlT5U2srgEXUIP0wN8WjMHUvJK1z4Y99DBlLOg/vnSeHdX7KCaw4NLqegzQpgpySXin98PuTtjujzHgPEJGwC7wv9mQTII7ij7bDwdItGNiI8SCCQLsshxRK8Q3IlZjhWfHpSpysIhiGmnzg8JeW3b5y0SGgfK6pb48RmthtB3RwbuP3gipa+IbZyvgzNbhc0BZQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(136003)(366004)(346002)(7416002)(6496006)(52116002)(26005)(16526019)(8676002)(4326008)(956004)(66476007)(66946007)(33716001)(86362001)(186003)(66556008)(5660300002)(4744005)(2906002)(1076003)(316002)(54906003)(8936002)(6916009)(9686003)(55016002)(9576002)(33656002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?/ki80tYhsMJDc09MczflTZDnQZA8IOA6CfxGH/NCSFxzuNxQgEIt/Zj/FO2P?=
 =?us-ascii?Q?NbEyEHFHivLO7DSEopAI8gMbrknW4Iyt4SpySWDsyBiXC9HcYPU9g5LF+P6T?=
 =?us-ascii?Q?neL6jqCxdA2PR/1Vk3DGaOtturapTcd+ZaoRxhFjwhNyw3YEZUp8pAUhi4nY?=
 =?us-ascii?Q?QqAqATP3ZurPUSWFFRiNlFNC6r270/9ZytVPs7dfoNstkQJu30EPdgHdB3cL?=
 =?us-ascii?Q?sS/3+87z57xWip2BdsmR0VOSnQCYSr+doaVYrVE01HUIxuSEXxyR0kagqdYD?=
 =?us-ascii?Q?PLPfg9T2CTKPXZAi6b3LgcPbjZkgEmSVlC1o6uvunXrBnbCDKpP65r6ZOZmE?=
 =?us-ascii?Q?cksYJzPHIdelNeHcPJFIz7orKkfjLyCHypDAHVe5mlNzX2VN1aFkZKcIQTMf?=
 =?us-ascii?Q?YcQjgUvQX0TUDrRcoDwyYCpz0sDwliqGrn38OYTYT8K1/jD7gKkM9pMTH9oz?=
 =?us-ascii?Q?itVAuxTQnrEfh/fqeP3qn+9rv0zM8Ymu91jFQrE4mOmRVG9G+PDtM/u/7xHZ?=
 =?us-ascii?Q?riiVIdl6zYOcnTopvJnq5lap76qL6SqxxxgxOhtPGhwTqx5GY7QVMYc6Sl4C?=
 =?us-ascii?Q?tAqiojGfzU7ZzTsENVGYxgkP1BbPhQOcC5S5fdQHH8uK5O7qq0fhFERTj0WI?=
 =?us-ascii?Q?HehMiF1EGX4fo37pby6uWXaPcXeWJnXR5mVikIa4hEsCdXBxI8OFK8iVDzGT?=
 =?us-ascii?Q?ub9pfFnNukfj/rsfCte50jLE/2gRDGXKpIvesS+VEF2jJqoyv1BXBwkLf7sz?=
 =?us-ascii?Q?GOtnPfJIxlMTZi9p3Hcis6ajKi8BrNJB7ljDZcPM5t1jty5VyY08n5WoRb0E?=
 =?us-ascii?Q?FOizB6fEETfAyojjhuc9y/x32cNh2YmKDnTxoTroX/XaUXqQP/h3aTGCn6jR?=
 =?us-ascii?Q?NqxPgWLH3LQeoBFy1tBZmVJ27vHZUiiVGDowzlWY6dvGt7FyInut1sVz7dBS?=
 =?us-ascii?Q?iePGT72bfAQS8/2yF6rayBgntThvWDWHUOtSUt7IWo3nQbNA5kuw1mEvnjB8?=
 =?us-ascii?Q?r9V4JQIGZwj4qR5hyyf6mjDKygcnSBje8072miogOwdDgpyZUAHDfwHkQkVS?=
 =?us-ascii?Q?uezvLOQw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f40526-38d7-49f8-3191-08d8c6d7e23b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 17:36:19.0392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FYNQJrA/Iu4LiFobE++5A5sqDWPRK6U05Q7aJfdZDwdMJ7ilgzVOnClRVBoh+u0GlrLxrg+s7HBuJDQ1SGNDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010089
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010089
Message-ID-Hash: VXAQJQOFCGGYSW2OO4A25DQU74P3NHWI
X-Message-ID-Hash: VXAQJQOFCGGYSW2OO4A25DQU74P3NHWI
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VXAQJQOFCGGYSW2OO4A25DQU74P3NHWI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


>  
> -	return 0;
> +	rc = -ENXIO;
> +	for (i = regloc; i < regloc + 0x24; i += 8) {

This 0x24, 8, and
> +		u32 reg_lo, reg_hi;
> +		u8 reg_type;
> +
> +		/* "register low and high" contain other bits */
> +		pci_read_config_dword(pdev, i, &reg_lo);
> +		pci_read_config_dword(pdev, i + 4, &reg_hi);

4

scream of #define's or sizeof()?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
