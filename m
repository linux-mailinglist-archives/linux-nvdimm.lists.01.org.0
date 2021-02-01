Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9D030ADF5
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 18:35:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2BE5B100EB83C;
	Mon,  1 Feb 2021 09:35:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C9E4E100EB839
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 09:35:40 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111HUBe9047767;
	Mon, 1 Feb 2021 17:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=jjhTUc1QY7sbZCJuQzUSYGQ8PrbdueXgDm36VNoOVm8=;
 b=E+F8i43jil2B/L1JunRRDcBt2qUCWqUMfbaq/I8jO8b1bhoRvgtXm3eCCU/EpDcAFJ3L
 E4lf0fpzZ2TyRlbuSfGGc2kpTGWcMX24FOj8tY4VieMUtl/pOEmso04Dvol3IFdWInUt
 TMClES3PhW2AsGeUMuJxHv7KFhg+ZQ1Q1bce2Ef+ofdyhfE2tTI8gstx+VKtQR8PYnXi
 XiTeQ7PYdVoT/4hGyGRpo6geVgdbVyVJLid6i3WCt0DW+7Jskh9dIAkfkHFItKVpCaqb
 0qhSBWv4QcmVEomOjrY1sOYgfe4BDPay8WjQoRByPogme5cpbrUD/1Yuxphnh2FyuzT6 xQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 36cxvqxjv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 17:34:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111HUAxB087510;
	Mon, 1 Feb 2021 17:34:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by userp3020.oracle.com with ESMTP id 36dh7q2b37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 17:34:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn2+gW0HXjUbiiE/fLRa3KrSVX2F+2j9wQ5sCfus0mLsU/L4dIR2TqKVy/t0tXO00mf+Hcnoz436Fk5jrX/P6/PSs2qbp5gqSRIw3xvNPQl6VQ0sB3HakHuzkwtd1ZJSNS9lPNOGs/ud8YTHVGOB7tKcTi7Qf2LIIdMdkG3NF+Xotd8N9PNRIfepkt/pVccdR9lZdmD8BW9DmvX9Zoyzjz2scyeXrlR7iNLOXzHLIkSpSe98cVO85BKe1Zm+3jBE6tK8WsoSrwKkxDsSdxCfHVuTK2sW6cUBohw1UiRp9bYG1h7hNZGlOyBhAR+bSmCY5l0EW+yl0FZJfa24n765ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjhTUc1QY7sbZCJuQzUSYGQ8PrbdueXgDm36VNoOVm8=;
 b=CEBdI127RXsFs/QCJzXIoo1dPqabeiVZzVXoi93dngUdkpJ5V+plR3fV60IRv3hbL0V9V98nkCTRSvc3U9y6tOmN8R/SXAfgzJ5KIicjtKFDqwaPPIsjrHuhdUdLdaNRBqNZz0hD1TlrKCKsbyWrGJTQf/GUJVnVTcbGI0bviLUzEeIc36atWaENYfF9CwnKu1yM5fuIJORpEwaCwCeLi0SjnspDNvKtqL1JgasKSLXsi2tYlebWs2ZCJi6ChZ7PInnRuVjI4y8mlGrgql+Eqrc+ohBl1Yqqxk0nkCw7q4HCTXz9WzMLD8KC53lQxDcFuk6mDXInEIdXapfxMNjpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjhTUc1QY7sbZCJuQzUSYGQ8PrbdueXgDm36VNoOVm8=;
 b=Q2x/ys/qtgplmNwXEXJy6SlEXfQfxV4aX3TH7oOXwl/nlQjCHtywFRVDes0G2qmVdtaODCCitW/8HMFvSZdFmqhUEcYb8CgumhZs2o4gUTfl9UQeLfdJs5y67kaPEKWUu81d07/ScxERCBV8XeyIZkqvAR8KBiVMbWhBQoal8SQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB2598.namprd10.prod.outlook.com (2603:10b6:a02:b1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Mon, 1 Feb
 2021 17:34:16 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3784.019; Mon, 1 Feb 2021
 17:34:16 +0000
Date: Mon, 1 Feb 2021 12:34:11 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 01/14] cxl/mem: Introduce a driver for CXL-2.0-Type-3
 endpoints
Message-ID: <20210201173411.GD197521@fedora>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-2-ben.widawsky@intel.com>
Content-Disposition: inline
In-Reply-To: <20210130002438.1872527-2-ben.widawsky@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: MN2PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:208:120::25) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (209.6.208.110) by MN2PR10CA0012.namprd10.prod.outlook.com (2603:10b6:208:120::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 17:34:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56a96f0f-690c-4b51-f86d-08d8c6d7993e
X-MS-TrafficTypeDiagnostic: BYAPR10MB2598:
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB2598076CA35405A4D402BF8B89B69@BYAPR10MB2598.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	slIYEtAfHKKtXLpHrqraHjkSBz3vwN7GsIsxrZEGKX/zt6UP8+W3qrXiVei3bVqlp2M3b26I4+1L8/0CBX0qtdTSZF1fWGHpJ8/IaEC+i4w+q/DoP78cOD2RqMd8AxZ5dGAWTy8DIujv65rSsop0E6lMV8MR2C++eF1KFZhCZH/nqKnpAZ0HGw2UT+6mrWEKFzd7Tl1W3qN0iuDW7MFGHXsZM/zfh5YAT3Pw+mMJArpum8OSsNtg/uoqpQ5gra0c8RZta+MtYMeHsrT3zvNFjCUC30tOfHwzeSDDVg6/xnZMepwl1FurIMK7jx32G+oPhZzqtkPuDqPaRPMS3eoh6yUBOUbnTev80L1RtA7xiIdGVbwC9ohzfXXXutVUoSorBGtKpoPRm00vZ7TkYFvWHIVrL3DierRlszBG7R/RPnSakYP8e9RkaGA94T+XxOthpwGwfM9HLUARY/kzJqpP+lJfn9tPzQNbUe02asmT4YlrQ4JLQ4BDdQj3DPSHh45mpadnaw9j77lnA5JBYmmgcQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(16526019)(66556008)(33656002)(4744005)(5660300002)(66946007)(1076003)(6666004)(316002)(26005)(6496006)(186003)(52116002)(66476007)(54906003)(86362001)(956004)(9576002)(8936002)(6916009)(9686003)(4326008)(7416002)(8676002)(33716001)(478600001)(55016002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?noTrfY5Xd5t8n3G6pM4AZCiHwoyKTvEnjaDbr5TVXME8Wc2NSJQQeYOJA0+V?=
 =?us-ascii?Q?nQk+PiMoA9EsdCj+U/WGCZsu2e8myqFOZj8IqrZpYVS7SbxrKMAzcQ44W1Dn?=
 =?us-ascii?Q?GUskVtRKvtOK8gusdp0reSYgSWamvwSwcFZbGQwA8gs1Q+ntQslaxTyWCTSB?=
 =?us-ascii?Q?Bi697keq9XFcNLVlgc0E2DbGLq+ZnainlqUIM9QzoA8Q7onMlxHWc08KVgEa?=
 =?us-ascii?Q?OZUll8xVznjLXoLbtLxKwmQj4XZ3fHaDs7yrDvpWODZh6VVbawYxhXpx7PDy?=
 =?us-ascii?Q?d3I6c0Ixc3xZW1PBsz/EJK3JZMQ7AF47RgEKny08vklF4hcomPJ5eV00pxMI?=
 =?us-ascii?Q?zWi3ZB+ofDjHrmTz+Bbrzg4r2lSyw+w2ZHwpgwhD+yRvVVR5iu/eDsop628q?=
 =?us-ascii?Q?bE/Kl39AwsG6IwHLcMV9SSXreMYZtcPhMj7bhrxX1khHx0PIHQQoU1Wg/NJf?=
 =?us-ascii?Q?QY1AtpoF1D8sieNENSmFM540U1PVyoXZoQX7EQ/8vd8VqFaW1JfTGVF6l/OC?=
 =?us-ascii?Q?und6konl9o8VuQA0yw9mG4XGTVPdNVVAzb/iH3JOnT0GHyNmdDDw/LWI0BJ1?=
 =?us-ascii?Q?jMI34hnNF1TRqKeJ5AMdJnQkSXnIMJuY528VXKgB4Q+F/YRgGWUqomgflJMR?=
 =?us-ascii?Q?0OxQXAy6YAsqjR6cTyzoP+q6mKDClTh6TCJquDSA1Lk8Pyp75MBeR+zv9/PR?=
 =?us-ascii?Q?x+NDTRGU3HpvlQ2q5ShKgUs9Sxljj5rGiY2Ikv1WW8+NA8Xdo8mMnwuvF1i9?=
 =?us-ascii?Q?x0+yUGV20DF18oCTPA5akqQmjcT0OdpgGq+/VAG6sMBFz59gIS6s5RwbbsTl?=
 =?us-ascii?Q?gkhOwwSOPjHF3H906pqB/X2DSJ+IxXRlTpUfKIrGnB7oQXGpkfWrWrosDAzA?=
 =?us-ascii?Q?Sk5VvR23Pxwg3k+7jT8hAEbfFng7m62Num1vO78WgldaG1o1BPWg4/2rp7WT?=
 =?us-ascii?Q?fnLluF7wHyn+6IEAuKUgDHsCAjyA8qZN+1YkOdG/B3qAei/FWIcDwsLplwCU?=
 =?us-ascii?Q?LcOTOYDffo5b6caOmolzYUxPLLNN1NpXrFoqbK4R91ChT1Mw9DOSopdUAlRD?=
 =?us-ascii?Q?X00akjjA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a96f0f-690c-4b51-f86d-08d8c6d7993e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 17:34:16.6313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VNz447Ijffr3wcbdLOiTiJem9bhOQctld6AtYK4hNfzCwoxKimWoasNqFP+9pQNuwadI+yJ59rPqYrpJvyWCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2598
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010089
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010089
Message-ID-Hash: ZDRHRA5GHNPFVGO5RZSLWT2Y2SS2CSSN
X-Message-ID-Hash: ZDRHRA5GHNPFVGO5RZSLWT2Y2SS2CSSN
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZDRHRA5GHNPFVGO5RZSLWT2Y2SS2CSSN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> +cxl_mem-y := mem.o
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> new file mode 100644
> index 000000000000..f4ee9a507ac9
> --- /dev/null
> +++ b/drivers/cxl/mem.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */

Can those two comments have the same type? As in either
stay with // or do /*.

Also the year is incorrect.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
