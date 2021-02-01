Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0F230AE31
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 18:42:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EF9F0100EB847;
	Mon,  1 Feb 2021 09:42:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F01A8100EB842
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 09:42:46 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111Hcpaw150316;
	Mon, 1 Feb 2021 17:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=nTzfnpjcpEC8jvnyUaRXJVP36TdG6TKgOwzjqSQv3+c=;
 b=ZO2dEsemSFiDEkqUav+sUz3CK7YfxJzV//RE+ihGgjV5wZfsWM+xPDWzn8BjJ9ZXXjWj
 qtbMnXcI5YG1HRDpR32vtUbUSGWvQ/ZqP+mGkl/4Ir3TBPUDnDmiuklcw4gOycp0ReB4
 ua4JSeY8pHoDeiEZEIp9psSLeE4nC+XW4KhxRjwUD0X2dXnb+Y4tQKydJ5IYTU0npYqZ
 W/DCySR87iDrX1WT3eOV24tLciioCtUj6p5v0ISg9YTAkK+OryJDEBDeBsn3+X4G0Wmr
 tLvSHV7q7RNTnstTjoGC+Lhy25I+EiPet1kZiBEIXgHKdtU037cEwnHkKpH1UjDBvNpr 9Q==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2120.oracle.com with ESMTP id 36cydkphy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 17:41:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111He8Yp122430;
	Mon, 1 Feb 2021 17:41:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by userp3020.oracle.com with ESMTP id 36dh7q2pam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 17:41:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWYnynhwaa7dJLwL0t/I4LkuE7xISfGWTP5xLXjE9HQ0lODaWSmJXWyU+ClYllrx3PXmmW17XuElLtZMlyViutIIa95Zf9M4P4l+nVjkIQEDqgq8ZCRz8mfJcrCzumIHARNGOyNPhXzEfSjPimLZ9geqdYU/SxhdE/mMQ84pF8iGKpCfEuZ+VG3MDWMQFwJEnAkbB7PVspVGFUDoQahfUnpyL1TiyTiZtG9w+NOKIf9bu9OKFYM8aaQjqY/9LgjCHTu1gyhRC1JbtTKLt+DRX1p4QBOMiP6RO4D5RK0cbEUepNsUKIyJZaeBcDp07rKTzSjxRTBz81ks9zQRlqL05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTzfnpjcpEC8jvnyUaRXJVP36TdG6TKgOwzjqSQv3+c=;
 b=gUo67vTU5NyhfCPO95xhcQPnXk1Oi26UfFqP68LpHJsmSV9az7/PRN7+VdwR61342AE3Htfl4UOHKLv+PXg6S50shwLNzcaNaFsHwvDrErQlZs4oVJE/J8jn7sT3BqiqP5g1FS/m9Jubwti6OgEUqsAvk6DHihD46Yd64QTHfMkRI6qRYzySAmtj0omUNaThtzK+Un/SgizaJcU2got6XYwhsqTvjLMHZoSEpCS2NBO9j/oo33WT0sH3VsJUTSvPo+Dt+7zWnYEZVcXXgYlbo2Eu2Vs+t4F8Eyqm/YvyuHd/EBeCJl5IfW4qVnHtDs/1Byu4TklxPM0kJRJ3Db4wJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTzfnpjcpEC8jvnyUaRXJVP36TdG6TKgOwzjqSQv3+c=;
 b=vjCsG0D1woPNa/bA83B/MQaNj6e59JRmQCzVK6EqasUSK8HdUrBQhlMigaQDyRxEk8Vq7AQ9tsHIZCGbq9mcAQQzMtdfYi3toBoUp6ccyKLCa6V6OY/mfuDaLQDplg31BA0RMRHk/9ORl+pokrkBIyKDP/FBo/CYBJ8mZUoDtow=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Mon, 1 Feb
 2021 17:41:41 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3784.019; Mon, 1 Feb 2021
 17:41:41 +0000
Date: Mon, 1 Feb 2021 12:41:36 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
Message-ID: <20210201174136.GF197521@fedora>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
Content-Disposition: inline
In-Reply-To: <20210130002438.1872527-4-ben.widawsky@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: BL1PR13CA0384.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::29) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (209.6.208.110) by BL1PR13CA0384.namprd13.prod.outlook.com (2603:10b6:208:2c0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.16 via Frontend Transport; Mon, 1 Feb 2021 17:41:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53a4d189-bb3e-439f-b687-08d8c6d8a27b
X-MS-TrafficTypeDiagnostic: BY5PR10MB3970:
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB39700E1DEFE3A453B3201A3F89B69@BY5PR10MB3970.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	R/Z42tb5JaLSsY4CSdff4Fd015kgtcAgoG34AfaUdLum5jbJD1GGjUnt59RjCRvCOiBbUWFRWAhFFwFIzccG7MZEDp49iGQyqDfpDp7JbkW7do3TyfawGyk/fxB6nBzzieBvQkBhOgEE883Cgq9/V1Kg1G+e5RRIKGu+nurbQgf91KUD6X78cOXgOjXBKjbtA3NMLAuKTieg/+ixV50htvizWV8mU0n9P9BF8St+T/ysoJgeBKVTsbrJopY+0v+7PgfWuUE8JzKDT3gT9UIYCf10MQ38sst2TgKMnzxS253jDCrALgvEfLZxD2c5ZVElCMudPBl8hF9waA1yjQpM7EmddTjcmormCtYUeMzJuTo/KZDNgkjP8sM7zqr+lIq8T46ObQQda4dYoIbreFt4VbgPNXJ0CEqmmnrgXJyZ673WztqOWh9EQO0naV11CKnn4jDpiEp/1WHwGrYKOLCAM/uJEkkb2uL9Z9PliMJ8tiaCbQUeA8f7sIj8YmcKGGesk/OAYCwzkVyhMDx1RX25aQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(54906003)(1076003)(316002)(5660300002)(2906002)(83380400001)(55016002)(9686003)(9576002)(33656002)(478600001)(8936002)(6916009)(16526019)(8676002)(4326008)(6666004)(7416002)(6496006)(52116002)(26005)(186003)(33716001)(86362001)(66556008)(956004)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?21S+bKm4nQzgZ2+rhszmxYC8DaGuaQ3ULPPQIL3Ryzn2xr6mIj3Sz5MO0m0R?=
 =?us-ascii?Q?gpNHXFhWptMGTLWOR3gDPUR+KJFOmUR2gn62SUKJJiRscXspjy0oiYZrGWYZ?=
 =?us-ascii?Q?JW0qzMrkBzn3I/AQMIK3Gc3GGRV9a0Jd5kq9rirUvqDAcY0oAEMS5fg78pzu?=
 =?us-ascii?Q?RiQD/vwBI52uqtQylvfGhIw5q5b9ByAHZU/JK2COBE3b5vKAc6Ul9J+jTu50?=
 =?us-ascii?Q?VnvP/kuatBi8zmYtg2DAmcrmm/96SSEaTnq4Q4Bik5XxDITnbGxaLShHkx+g?=
 =?us-ascii?Q?MoWenY/xlStbDBIIqJs9BU6wbpe6HuhjCSrgQxGpHzuxtVBYRFTTuzKtolou?=
 =?us-ascii?Q?URjltDhsWD4xaUBypgbwWOzLHQBzf6V6ntWniJwi6TWV0si1zdlCKOQogoxO?=
 =?us-ascii?Q?gERfnjHJuCHtEYaRPTsJAe1JDXV6CHjGizQRbtnYi1eQkn13lMC3d7A29/aN?=
 =?us-ascii?Q?ordq53VawIhPqMrbY/Ct24zjJ/tpIGr5jA2/lJ/VCoXYwvMwAGtoDAEv+yvt?=
 =?us-ascii?Q?IHWTdnwFgqs9MRbE4zutrtn9M9EbQx9Wf9XrSy2BoiNeqojKLHonpPck9f8f?=
 =?us-ascii?Q?PuHTbmUSzAFPQQGHN/9nRTgKO4Ix2zViw6Z+NKXKcpBF4F6+88e6cR9rqt05?=
 =?us-ascii?Q?1rpm6MP3SE1MGG9i16uDD7+pRhqNeTSHHuYkPLpxByicxBQRpXE78RVrUbbY?=
 =?us-ascii?Q?UOr3cbaf8B5PsLiIPVBtKBPoprrWhB+vjT9/FLEUOpMBILbftAXPwSIC0qk1?=
 =?us-ascii?Q?jerzpFiuGlsCqcxLffEITQpSK2V72baVet1O2l1GsfTmD38XpXYD+Zy2ZwA6?=
 =?us-ascii?Q?Yxd2wrHlSkq9vqXu7m+99JTIVPXyogiFFz83XiG9LbcBwJYYoMfDvGdp6TcP?=
 =?us-ascii?Q?JehS+Z3JdCMOM7Y920LEgL9j3sMLn4fliK8WktH4eWNhTnMJwsNK72Ma+FaX?=
 =?us-ascii?Q?EzMLM6oArbhvnp+F+yno4gT6fzdw6y1+1y2rnA6rUqRCPMY11bzSLEcSvfMu?=
 =?us-ascii?Q?E0iuPHngH/ivKknPFiOgqkuh8Z6B8Q1KWha10+8te5/NmFPJj46hD19igKUz?=
 =?us-ascii?Q?zviKexDW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a4d189-bb3e-439f-b687-08d8c6d8a27b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 17:41:41.6106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IazPV+J2lMMJwaK7E53S4fnlOdvsqPVnCPvazqkrL3eCygIduk1fP2jCLK/23kmhKnhgkgoxWVMPnh+NaVq0Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010090
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010090
Message-ID-Hash: J25F2GQRR3NNC7NMAB2ROYW2EF6INFQO
X-Message-ID-Hash: J25F2GQRR3NNC7NMAB2ROYW2EF6INFQO
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J25F2GQRR3NNC7NMAB2ROYW2EF6INFQO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> +static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> +{
> +	struct device *dev = &cxlm->pdev->dev;
> +	int cap, cap_count;
> +	u64 cap_array;
> +
> +	cap_array = readq(cxlm->regs + CXLDEV_CAP_ARRAY_OFFSET);
> +	if (CXL_GET_FIELD(cap_array, CXLDEV_CAP_ARRAY_ID) != CXLDEV_CAP_ARRAY_CAP_ID)
> +		return -ENODEV;
> +
> +	cap_count = CXL_GET_FIELD(cap_array, CXLDEV_CAP_ARRAY_COUNT);
> +
> +	for (cap = 1; cap <= cap_count; cap++) {
> +		void __iomem *register_block;
> +		u32 offset;
> +		u16 cap_id;
> +
> +		cap_id = readl(cxlm->regs + cap * 0x10) & 0xffff;
> +		offset = readl(cxlm->regs + cap * 0x10 + 0x4);
> +		register_block = cxlm->regs + offset;
> +
> +		switch (cap_id) {
> +		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
> +			dev_dbg(dev, "found Status capability (0x%x)\n",
> +				offset);

That 80 character limit is no longer a requirement. Can you just make
this one line? And perhaps change 'found' to 'Found' ?

> +			cxlm->status.regs = register_block;
> +			break;
> +		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
> +			dev_dbg(dev, "found Mailbox capability (0x%x)\n",
> +				offset);
> +			cxlm->mbox.regs = register_block;
> +			break;
> +		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
> +			dev_dbg(dev,
> +				"found Secondary Mailbox capability (0x%x)\n",
> +				offset);
> +			break;
> +		case CXLDEV_CAP_CAP_ID_MEMDEV:
> +			dev_dbg(dev, "found Memory Device capability (0x%x)\n",
> +				offset);
> +			cxlm->mem.regs = register_block;
> +			break;
> +		default:
> +			dev_warn(dev, "Unknown cap ID: %d (0x%x)\n", cap_id,
> +				 offset);
> +			break;
> +		}
> +	}
> +
> +	if (!cxlm->status.regs || !cxlm->mbox.regs || !cxlm->mem.regs) {
> +		dev_err(dev, "registers not found: %s%s%s\n",
> +			!cxlm->status.regs ? "status " : "",
> +			!cxlm->mbox.regs ? "mbox " : "",
> +			!cxlm->mem.regs ? "mem" : "");
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> +{
> +	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> +
> +	cxlm->mbox.payload_size =
> +		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> +

I think the static analyzers are not going to be happy that you are not
checking the value of `cap` before using it.

Perhaps you should check that first before doing the manipulations?

> +	/* 8.2.8.4.3 */
> +	if (cxlm->mbox.payload_size < 256) {

#define for 256?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
