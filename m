Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DE7320263
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Feb 2021 02:13:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C5124100EBB8D;
	Fri, 19 Feb 2021 17:13:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AB0D6100EBB63
	for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 17:13:14 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K1AjRd079688;
	Sat, 20 Feb 2021 01:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=GaDJJKzvesN9Zae4k8UHjdwZxCQvjZIBCeFPEg488VU=;
 b=V7F76FuRyYPtK0j9yaTxr5EWmca6RQiz6tnFDPT1ML1swwW9AXzhmdkWD9Wmc+yjxtYD
 haFhrCvcIXy2AC2onNrVntyUd37BvrRA2ELKpQuFlVaJg2MM9ahrYMcbomS0MzxwynqV
 LK4QZmZl1Bgb0O5Gte+2PGAo4ZWXHgnjpKAEZOPYygyUatMhd9RyTad1TSNZV0VZo6nW
 eb0+6K4WTcj6DweRhbSPXZU9Wkz4RTdl12ZI5GqY70WRR0WP39jN8hKUb4Q1ApJHYkVx
 9jtOUqBIO+OCg+QKrR5RxnkYhfpIQB8UY5RcYFMN+DtEe7B2YUMktZ5A4TD3zrj14x1U Lw==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2120.oracle.com with ESMTP id 36pd9ajpas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Feb 2021 01:12:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K1AFSd119695;
	Sat, 20 Feb 2021 01:12:15 GMT
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
	by userp3030.oracle.com with ESMTP id 36tqhrsdt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Feb 2021 01:12:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX7EJPlmBr1CLSBqfhyL/6aM1/UUq2E/OkZ+HUyFJzrRqfwHVVtR5p15K+Bctj+uO1dNFUHUmF0CGewdfluQs/GC5ec7RSqnqEPKWUi9IEWINEVL/pf8r5VS9kuqMcpDsJmADyXYSYX7GrSYLwwrnazFOM7p+UCSDL74kv4RWM0uN0DRDFrtbKhA0H12z6g331dvS7PsVqmo2Voue/5JEwlX1iuqn7XTnL7FZt9c2Sk3kiG039+OW3U+2gOmJ2BHdvAYa0hURRuEpRFp2Mb2LJY8LR2CW8Q1CCoTP9KfIecs3sgT+JzIECDCa38+PbR8ULxXv8YofT7rCCGN1OnR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaDJJKzvesN9Zae4k8UHjdwZxCQvjZIBCeFPEg488VU=;
 b=DPOLbsr7KBSxoHbDEg7ah/0/MES3rddWiI2XAo/oq0gImfEsEZx3fpGQtEndHzt0gbuTZgQW85WQS0KTrDBQ4UhDSif/E0Cg5tmyb9WTLF6BNYumiry041e4Dv4RHhBp3LG3mUiP776SuXfncVEYAfZwM+pFfwXObRqLVZGyveRZxuzyyWtgGKWvxpINtXTXX8B/TxHuIMF67aymc6UmVknbhyo1w5UdYwQEerGgY5NBiyKksis4ENWLk6PbzYGbL9yBvN3UNFLpoHNSlWGLvrJWRbQjwmGqJN9cuCWABNh7xsZyME43qPOTGQFhHawR2Jimt05M1+xUNmveZTrNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaDJJKzvesN9Zae4k8UHjdwZxCQvjZIBCeFPEg488VU=;
 b=jrOBGDyT2Uk3/mcnByXmv80kKyCzRO6NEOTCD1CFq2UD2TJxbhi/x6ABFjsN16cOAxUxZ9cUeWsFrTdYFRaUTcUDZ0psHlms7ofhu5BHv0VBO7+Wimfhqqyas1MXjDIXhdzfhuExwvH4GgE+c/NkN+zKe7kSaIZsgmNpW6IYCs0=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB3687.namprd10.prod.outlook.com (2603:10b6:a03:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Sat, 20 Feb
 2021 01:12:13 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3846.039; Sat, 20 Feb 2021
 01:12:12 +0000
Date: Fri, 19 Feb 2021 20:12:07 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v5 7/9] cxl/mem: Add set of informational commands
Message-ID: <YDBh5+NfeN+rI1VA@Konrads-MacBook-Pro.local>
References: <20210217040958.1354670-1-ben.widawsky@intel.com>
 <20210217040958.1354670-8-ben.widawsky@intel.com>
Content-Disposition: inline
In-Reply-To: <20210217040958.1354670-8-ben.widawsky@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: SN7PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:806:f2::16) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (209.6.208.110) by SN7PR04CA0011.namprd04.prod.outlook.com (2603:10b6:806:f2::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Sat, 20 Feb 2021 01:12:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed1b8b82-d009-42f1-f03b-08d8d53c8dca
X-MS-TrafficTypeDiagnostic: BYAPR10MB3687:
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB3687D71BA804161E97267A9A89839@BYAPR10MB3687.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:281;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1gCDsORCne9zfZgS4on8TWtYsbndy6iB6hZmE1er4906BF7XX6YzAk9Pa1vFCExmgw0Wg0jEGDgCqaUVBUnSpvO878t6hC6noPn+YaXnV6XIDZrOLml33FcV04ixjVolw4jzm24yEyvwERtowuG+DKCO1/yLv/S65tPV5eF/dKG68F9oSVJybX8r1+pHwGHRwU6crF+9Bfkr1wiYsMoDvQqXv1xcOEiqhnlBerde/7QEhB6bIlFewtVpK8+/nMwodLd64PRtGgs8nWBkrxfn0uKWom0jCSwNbHe8gX8bnoPaQKGA92zf8scJOXBr8XZU2h/chrT2BafDAOdIPe16+jN6p7snMQWujq2SnJREIURvyFfF3voKpz475azBWk28KjZ5VCB9y1nCKL+2/UISMptgAPySr68PxUeUZasgtnwtHo5VBpwXzIYzTqbe4LhkdRzzlAzIeKxVbZ6fiSAylPx1bY4jWLn0Tr+bvxV1MSPQBe+oPr++wKfjF8S8/o8cKVCQvfaUrEzhIQfw13rzrg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(366004)(376002)(346002)(54906003)(66946007)(478600001)(5660300002)(66476007)(55016002)(4326008)(66556008)(7416002)(956004)(86362001)(7696005)(6506007)(26005)(2906002)(9686003)(316002)(8676002)(186003)(6666004)(16526019)(52116002)(6916009)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?/MJVIfpZabD1Eq5rIF6PXMUnM/+MNueyWFvx0BN7y5uWBdo0wv01Y2BF26kK?=
 =?us-ascii?Q?pUhEGw6QMG0JOhi7r18IpaQeH7U1QtppUKId6Uq6E6bcpVAjNaDy1DGcVbLf?=
 =?us-ascii?Q?yutfLMOMmgVslD3oxYmvqLeswUHtWD/3SDLYZKFguxmpxpSsY7O2sGKz3Swz?=
 =?us-ascii?Q?FWK6qtKw6fB+UHprug8SvNK0jxSWidCvJ1j4N0lhiF5qa0HQOqcqIDyqLw8F?=
 =?us-ascii?Q?l+pUSqJIkI3zAeH19c+ZfBN9AdjudbJadk4wPPMjKM3thLVdH5AUjoau0PGg?=
 =?us-ascii?Q?usu2P1K2k70Ggn6fNLCk2K3U9hHDMb6b/N3QH+8/h7tAzL01chKVZtGa81nd?=
 =?us-ascii?Q?MYRxg2gmRXaSPRj03qY4VNFoL5WDFzGa/TNxuRPxpgXNPNdQaRZlLe5OlFq0?=
 =?us-ascii?Q?pJcgsX111Gwjyb4/OABToZ7l9n8JQbMrFV0qSErxaoCRzlCX1nCsuaEMe5KD?=
 =?us-ascii?Q?qeHpkrLAF+bv+1VXGnaKQjCPmyflVO8JfctA0SbZ0XB36Ju/XpbIf1k5ido2?=
 =?us-ascii?Q?Akg1NBWmi2y+SF7zYXeDG1rNPsYu2gS0yI7r//OmuBMzGAvTIupF16WSglz1?=
 =?us-ascii?Q?x6ycIaZ8r1MZrFeGY3DnwA7wET6tF5qb8Ow3RMF8ThymihdWYBVfArzFinuy?=
 =?us-ascii?Q?kth2h20Fv9ttsHuggxsf1lxxk9al+t4IrGkv999ZFWPjXVir5puHoxsexFsh?=
 =?us-ascii?Q?y2tPEQXkB6/Ca5WRJ9fgg+XtumWK8ugbEaZlrFWmoPyTLcDMHMeAZDAxZ2zb?=
 =?us-ascii?Q?aZU5lnYFhLQaxbhEDJoVhgD0CCCvFL4HN4IbWMCd7PRCADx6eWPCzFGkM++T?=
 =?us-ascii?Q?8TH1ZonIu7CV2Pp5l2BMHFA0QaLpbQauJcMYmsQ6juqdsLuuZVDpmjGj1ayB?=
 =?us-ascii?Q?XDq7qKN3ZJAPT5eop/SiQfgfkOYU6beXcSXdwfJhKcOKhOOrmdK7dDHHQCnT?=
 =?us-ascii?Q?7mwCALvFk1JA+hQC9ufuLfCY9h3Srz9IXDM35PiQlhsU/jITevFDiZWOXGFu?=
 =?us-ascii?Q?PEMGHyU4Y0bOBFDmIA779JAwuCwpTYv5P3utUVafsgSU4IPw0oF9VFdaxZKg?=
 =?us-ascii?Q?e7ba8dnh+1M3rMFLbXHFmf2kbe9Gugjp3Jyv4xGbY2l/982NpP+YE6CxPW4K?=
 =?us-ascii?Q?nhpuyUtHab4ZBAepwi+hTKT5oc4NSxzaBO09NMu3MVU/XhjNuyf2qLKQZ0Hy?=
 =?us-ascii?Q?0N5lJ9Mhqq5N01SGPU/ElpwAUEYxhBCmO+RV4JxlKCnEEGKgpNHxl4e/vBBq?=
 =?us-ascii?Q?aRdoPuCTbNk3RJlTXDymzrm+4EuMJ7TyLFD5HEf+lQLMx6TW1EnWs18SocVn?=
 =?us-ascii?Q?5GWBNROuHUtGgN7p4EfAG/9l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1b8b82-d009-42f1-f03b-08d8d53c8dca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2021 01:12:12.8365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OMb/mwQYyf3LcCtUyWyzx27/92v1R2TIchaLYZO05MGyOcAdJPwBijdV+p79UazJFxfODFndCye8KPb5m5evQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3687
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102200005
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102200005
Message-ID-Hash: N6P6H7H7CTE74EL4PXMKOMEVK3QB3EGJ
X-Message-ID-Hash: N6P6H7H7CTE74EL4PXMKOMEVK3QB3EGJ
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/N6P6H7H7CTE74EL4PXMKOMEVK3QB3EGJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 16, 2021 at 08:09:56PM -0800, Ben Widawsky wrote:
> Add initial set of formal commands beyond basic identify and command
> enumeration.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> (v2)
> ---
>  drivers/cxl/mem.c            | 9 +++++++++
>  include/uapi/linux/cxl_mem.h | 5 +++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index e31b3045e231..6d7d3870b5da 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -45,12 +45,16 @@
>  enum opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> +	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>  	CXL_MBOX_OP_GET_LOG		= 0x0401,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
> +	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> +	CXL_MBOX_OP_GET_LSA		= 0x4102,
>  	CXL_MBOX_OP_SET_LSA		= 0x4103,
> +	CXL_MBOX_OP_GET_HEALTH_INFO	= 0x4200,
>  	CXL_MBOX_OP_SET_SHUTDOWN_STATE	= 0x4204,
>  	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
> @@ -171,6 +175,11 @@ static struct cxl_mem_command mem_commands[] = {
>  	CXL_CMD(RAW, ~0, ~0, 0),
>  #endif
>  	CXL_CMD(GET_SUPPORTED_LOGS, 0, ~0, CXL_CMD_FLAG_FORCE_ENABLE),
> +	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
> +	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
> +	CXL_CMD(GET_LSA, 0x8, ~0, 0),
> +	CXL_CMD(GET_HEALTH_INFO, 0, 0x12, 0),
> +	CXL_CMD(GET_LOG, 0x18, ~0, CXL_CMD_FLAG_FORCE_ENABLE),
>  };
>  
>  /*
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 59227f82a4c1..3155382dfc9b 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -24,6 +24,11 @@
>  	___C(IDENTIFY, "Identify Command"),                               \
>  	___C(RAW, "Raw device command"),                                  \
>  	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
> +	___C(GET_FW_INFO, "Get FW Info"),                                 \
> +	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
> +	___C(GET_LSA, "Get Label Storage Area"),                          \
> +	___C(GET_HEALTH_INFO, "Get Health Info"),                         \
> +	___C(GET_LOG, "Get Log"),                                         \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> -- 
> 2.30.1
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
