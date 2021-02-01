Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA5330AE86
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 18:55:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C633100EB851;
	Mon,  1 Feb 2021 09:55:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 81045100EB84E
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 09:55:08 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111HiuUi172911;
	Mon, 1 Feb 2021 17:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=9ZhqBFEYj28K2RCEdNejgQxM5txF0dzruvQl4lOSyXE=;
 b=oBN2rYh7Ulr7h2BZ8CM9tns72zu6VfUArR58zUt4EKv13lgbE/1F1MbTeohX2Mjc+2ux
 Z2nKADhs1rxJ7EMDYUokq9Z97oMeqTnItA8few9bXl8LioFcbqzVsU5iETWr7I3eSQTf
 Cf/nUCjCuCeJbSNbo8HZNEiCQY1uS8YOY0wNEZqjIcIgAS9QdLKL0++KQtS39/nO8ysR
 mqIJsTyqafZrEC9JkSUfVBykfccaetRHnBZgGS1v3vvG/Prwg22MYhr3eK2cKtGzOdAB
 ggSq49N/sl6AiFO942SxkhzoEye/Dv8R27T59VgxNjzhQfJWZdfjhuDRd15d+Y7YxVQV Qg==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 36cydkpkpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 17:54:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111HjRmB137683;
	Mon, 1 Feb 2021 17:54:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by aserp3030.oracle.com with ESMTP id 36dh1mqy50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 17:54:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhUwUERVGpHNdRxTRmSsQEFUSIh7TQrQeVCY8ViNFsmigI/Ev6k2hzsekh9up616mMlnA3jg7h9ZXHED67udS80C2pqH3K0qlJCnQQhjxYbvhx7NpFGASb/zM/Ge42CkG1mzZo+yIwZEDPue4ARCrq4c5v2KFWiFUNEsKcj8Ep08349j1zFNY5if1jvXvw/FlJp4lDpCTmV5glvubsK95jwZm2wgrQxiZO84uajxGLLQeCtXRvuXlzS+F+FTOMxkKqKvS6CqjwlvYe3FpfNTIHEs/qc/BpO+1q31SElxuzULvTfnP7RhOKbN0QvIUyjcmcN2JbIF4UpHRdthuoOdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZhqBFEYj28K2RCEdNejgQxM5txF0dzruvQl4lOSyXE=;
 b=jl8duvifD8ADLxsNDU9ZjgIzkpQLBrOw8Ecp2gyABZrLJForcKkLt/P8Yh8CWNBKzoVbhc3JflvEYQKmQv5hgJIaL+NKUTs7q4mZGCny+wduwDqajx8jlUfzOjvrqeO3JExRe+tqMecxql46I8zGaxzVysWf5PI4z3bzKRbKomz8JMQGu2KNVVodb0ZCoRLQ+/KmYioUdj/io9YE7y/4sT4ZmtrcisZWmgiHOlW0iYI63Gb5yEOPdXKuKheIPCpmGLtmLV0x0mlJHEnTmOYzilIufzvTvd06Ie7agUYKSHO5PibdSSWCc8rQM19G04/p2MAEsFN9QdAVi9a4qwGg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZhqBFEYj28K2RCEdNejgQxM5txF0dzruvQl4lOSyXE=;
 b=ah1PoJLDaQbn+ULBI/RIB2ogfZevs4CDoMeJgWuVfcGUERhPZbF6BEhvjovx06U2icW8ZfCAoYB6E4XwClG2e1tz1sWNjzJh7dTvn+MACBBA+k/0sQUFrbm9aZBGEk0jalWsrKLIje9Bk0MfBI1oRCZ6Sxv5DfDohKBvDQJSDUU=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB3093.namprd10.prod.outlook.com (2603:10b6:a03:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 1 Feb
 2021 17:54:05 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3784.019; Mon, 1 Feb 2021
 17:54:05 +0000
Date: Mon, 1 Feb 2021 12:54:00 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 04/14] cxl/mem: Implement polled mode mailbox
Message-ID: <20210201175400.GG197521@fedora>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-5-ben.widawsky@intel.com>
Content-Disposition: inline
In-Reply-To: <20210130002438.1872527-5-ben.widawsky@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: MN2PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:208:160::24) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (209.6.208.110) by MN2PR13CA0011.namprd13.prod.outlook.com (2603:10b6:208:160::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.13 via Frontend Transport; Mon, 1 Feb 2021 17:54:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87bac691-3f09-492e-317f-08d8c6da5df0
X-MS-TrafficTypeDiagnostic: BYAPR10MB3093:
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB3093241707DFE5776F8E665989B69@BYAPR10MB3093.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1W2nHDrkxD490Hzn9IMI96Qwi0PezJptzZi41KMjmVZdgw4ncpDfvuIEIYzIu2IWa1tcnYdCd+dJToVySk/WLwypk/VbhOC1XfimVMdnYF2EeCCBa9CpfGt93y3lqOjaxcIl0CiRPuH/jsxtVuNVd3tq6sT9JvNqMjtsW34DtulgMnFe95M6ZAcEDH56cLNdNbFmgR3rJ+VMo171MawwGB6wOt93OovpeK4rguA1SYPCjGd/LK4UtOqaLvpvceZImBYErfWC4ljSo9czD95X0f/izBQVEoWKRq07zpKQ/z/1fAV9XBpXjikfwVvuKLFs+9ljkBoFIYM5dkL+8o9UyWRgYIsTRl7vGpeOItZhbJ2BlyOkrVss4ln7NgNEw3RNfM/hOMzrIcxYrqBuNdYT1L+N2fX+CFP7uBKqmc4FDfZvalb6VqqIJmu9Kus36RXztIxdgXcWljXAAdLHY1pak9K3SlwYO+aol8d+ue3s4G0FdLyxGu/xNolJK37Bq2z5pCNs/arHPmFEhValeZkNbBivxORkpO7BVCnAwJvUJgmcDmXFzadUnQsmoaJTRSyd
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(376002)(396003)(346002)(66476007)(66946007)(66556008)(8676002)(52116002)(33716001)(4326008)(6916009)(5660300002)(7416002)(2906002)(30864003)(55016002)(6496006)(1076003)(8936002)(33656002)(15650500001)(83380400001)(478600001)(26005)(86362001)(16526019)(186003)(316002)(54906003)(9576002)(956004)(9686003)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?nbacR0mUUeP/xDV9+8nZcLVW4NkxVlARdDfmvYXDgw3sB4ZP4A9I/FKmJNMH?=
 =?us-ascii?Q?XWsqGg5VXol72kFupnum7KvNwnU3tYz0T9yoBhhQ4cwzVhl6XsDMwRWVG1+/?=
 =?us-ascii?Q?dFpRXTp8Ml2T/hF/+gCUrFNPPjQlgvP6HpG6pEY9l9QyX7qaftZYyu0Q6LWn?=
 =?us-ascii?Q?6CMRkS92nrxSYAmJJFk+0s+CT8NNomeFnt1R0wmbECnQP39zqQtPp6ePBOvZ?=
 =?us-ascii?Q?XEVd/DhlVU1IydHRxSk9VX7dEdo/ZIXfu8ots/pf3jhNWLUmAqul+pL72o7N?=
 =?us-ascii?Q?v4FzyewCT37OVaeu3WtfGYs/4M1RNsyoTlku+3dLIuCA6nDoOuCB94P5k3Rr?=
 =?us-ascii?Q?C4zZg2MJUWSMrdjmdEH6s/MT2Wd7zG1/b34PCh3VXJ/zBVzoOSur1VViptxN?=
 =?us-ascii?Q?H+WLOYny4WPY/QIoE7wwEMepI9velgCCIaocyHx5ZUQWO6TW5bG2dQwddxZN?=
 =?us-ascii?Q?Y4krmkwq62dnNbLJfiy9KvmMv5K52BFfNHp8X9+NvfHWbMM6hyDaiYn74Jj/?=
 =?us-ascii?Q?gIRRCTcfiJ9F4Int+V4Mnl4xqac67rIiWmzAEMdC8DjZ0vty3kCE9EAUElgJ?=
 =?us-ascii?Q?C6BaQpESAM/km8XA2VCsRUymK5j6c9fg0BQqkTFt82wPRCvYHtqV7qli4+8j?=
 =?us-ascii?Q?ZuR0UXoUhdp8gExNSzcAeOeeVmk7N83aDOpGNyXTDg/t4RICp5iDGBMUus22?=
 =?us-ascii?Q?TA/4ERWOFtCjHiyxB7eaQ+AUkbd/PUnNJsicN47HAaVB2SLFYBZ+VL5JzXCG?=
 =?us-ascii?Q?Qbp3EyEznLS7kqCyalH31GNUXguEcQ6BaABOKy2fZM33CczJQACbtOyFWQkB?=
 =?us-ascii?Q?/CDSTLj8PBefVFtmO5DihNGJaNkZvHT0NOq+DNbXko4J4WrpSNMsOzHqQ6tr?=
 =?us-ascii?Q?L6iidNHW9tak28Otb4lQUrpperA0SmYXBq/pvsOe5nPWLoH7qUJbzdKM3iH9?=
 =?us-ascii?Q?WZZZMe3C7++BayyGb1yicP8ahOtXRKLHqguxuJ8bqonGeGWI25hAQAQJvLD5?=
 =?us-ascii?Q?OsY6mJ72sH3MQ51fkq+we5KRx1z7k9KBQjfXg+mVuF1jKPJHX+LOu9VMNtLN?=
 =?us-ascii?Q?KjkKTOtG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bac691-3f09-492e-317f-08d8c6da5df0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 17:54:05.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNjp31MvRk2g0yYq+LLMW1Ac5i2+1umBmNWKmKxFAw3v+cj2T9T/oP5ccQTw7pDxBb/Ejy4E7tFb/T/E+uvMpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3093
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010091
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010091
Message-ID-Hash: PXKBQKAUJY4GOJOK3VPWOM4T22HNX3NI
X-Message-ID-Hash: PXKBQKAUJY4GOJOK3VPWOM4T22HNX3NI
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PXKBQKAUJY4GOJOK3VPWOM4T22HNX3NI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> +#define cxl_doorbell_busy(cxlm)                                                \
> +	(cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET) &                    \
> +	 CXLDEV_MB_CTRL_DOORBELL)
> +
> +#define CXL_MAILBOX_TIMEOUT_US 2000

You been using the spec for the values. Is that number also from it ?

> +
> +enum opcode {
> +	CXL_MBOX_OP_IDENTIFY		= 0x4000,
> +	CXL_MBOX_OP_MAX			= 0x10000
> +};
> +
> +/**
> + * struct mbox_cmd - A command to be submitted to hardware.
> + * @opcode: (input) The command set and command submitted to hardware.
> + * @payload_in: (input) Pointer to the input payload.
> + * @payload_out: (output) Pointer to the output payload. Must be allocated by
> + *		 the caller.
> + * @size_in: (input) Number of bytes to load from @payload.
> + * @size_out: (output) Number of bytes loaded into @payload.
> + * @return_code: (output) Error code returned from hardware.
> + *
> + * This is the primary mechanism used to send commands to the hardware.
> + * All the fields except @payload_* correspond exactly to the fields described in
> + * Command Register section of the CXL 2.0 spec (8.2.8.4.5). @payload_in and
> + * @payload_out are written to, and read from the Command Payload Registers
> + * defined in (8.2.8.4.8).
> + */
> +struct mbox_cmd {
> +	u16 opcode;
> +	void *payload_in;
> +	void *payload_out;

On a 32-bit OS (not that we use those that more, but lets assume
someone really wants to), the void is 4-bytes, while on 64-bit it is
8-bytes.

`pahole` is your friend as I think there is a gap between opcode and
payload_in in the structure.

> +	size_t size_in;
> +	size_t size_out;

And those can also change depending on 32-bit/64-bit.

> +	u16 return_code;
> +#define CXL_MBOX_SUCCESS 0
> +};

Do you want to use __packed to match with the spec?

Ah, reading later you don't care about it.

In that case may I recommend you move 'return_code' (or perhaps just
call it rc?) to be right after opcode? Less of gaps in that structure.

> +
> +static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> +{
> +	const int timeout = msecs_to_jiffies(CXL_MAILBOX_TIMEOUT_US);
> +	const unsigned long start = jiffies;
> +	unsigned long end = start;
> +
> +	while (cxl_doorbell_busy(cxlm)) {
> +		end = jiffies;
> +
> +		if (time_after(end, start + timeout)) {
> +			/* Check again in case preempted before timeout test */
> +			if (!cxl_doorbell_busy(cxlm))
> +				break;
> +			return -ETIMEDOUT;
> +		}
> +		cpu_relax();
> +	}

Hm, that is not very scheduler friendly. I mean we are sitting here for
2000us (2 ms) - that is quite the amount of time spinning.

Should this perhaps be put in a workqueue?
> +
> +	dev_dbg(&cxlm->pdev->dev, "Doorbell wait took %dms",
> +		jiffies_to_msecs(end) - jiffies_to_msecs(start));
> +	return 0;
> +}
> +
> +static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> +				 struct mbox_cmd *mbox_cmd)
> +{
> +	dev_warn(&cxlm->pdev->dev, "Mailbox command timed out\n");
> +	dev_info(&cxlm->pdev->dev,
> +		 "\topcode: 0x%04x\n"
> +		 "\tpayload size: %zub\n",
> +		 mbox_cmd->opcode, mbox_cmd->size_in);
> +
> +	if (IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {
> +		print_hex_dump_debug("Payload ", DUMP_PREFIX_OFFSET, 16, 1,
> +				     mbox_cmd->payload_in, mbox_cmd->size_in,
> +				     true);
> +	}
> +
> +	/* Here's a good place to figure out if a device reset is needed */
> +}
> +
> +/**
> + * cxl_mem_mbox_send_cmd() - Send a mailbox command to a memory device.
> + * @cxlm: The CXL memory device to communicate with.
> + * @mbox_cmd: Command to send to the memory device.
> + *
> + * Context: Any context. Expects mbox_lock to be held.
> + * Return: -ETIMEDOUT if timeout occurred waiting for completion. 0 on success.
> + *         Caller should check the return code in @mbox_cmd to make sure it
> + *         succeeded.
> + *
> + * This is a generic form of the CXL mailbox send command, thus the only I/O
> + * operations used are cxl_read_mbox_reg(). Memory devices, and perhaps other
> + * types of CXL devices may have further information available upon error
> + * conditions.
> + *
> + * The CXL spec allows for up to two mailboxes. The intention is for the primary
> + * mailbox to be OS controlled and the secondary mailbox to be used by system
> + * firmware. This allows the OS and firmware to communicate with the device and
> + * not need to coordinate with each other. The driver only uses the primary
> + * mailbox.
> + */
> +static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> +				 struct mbox_cmd *mbox_cmd)
> +{
> +	void __iomem *payload = cxlm->mbox.regs + CXLDEV_MB_PAYLOAD_OFFSET;
> +	u64 cmd_reg, status_reg;
> +	size_t out_len;
> +	int rc;
> +
> +	lockdep_assert_held(&cxlm->mbox.mutex);
> +
> +	/*
> +	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
> +	 *   1. Caller reads MB Control Register to verify doorbell is clear
> +	 *   2. Caller writes Command Register
> +	 *   3. Caller writes Command Payload Registers if input payload is non-empty
> +	 *   4. Caller writes MB Control Register to set doorbell
> +	 *   5. Caller either polls for doorbell to be clear or waits for interrupt if configured
> +	 *   6. Caller reads MB Status Register to fetch Return code
> +	 *   7. If command successful, Caller reads Command Register to get Payload Length
> +	 *   8. If output payload is non-empty, host reads Command Payload Registers
> +	 *
> +	 *   Hardware is free to do whatever it wants before the doorbell is
> +	 *   rung, and isn't allowed to change anything after it clears the
> +	 *   doorbell. As such, steps 2 and 3 can happen in any order, and steps
> +	 *   6, 7, 8 can also happen in any order (though some orders might not
> +	 *   make sense).
> +	 */
> +
> +	/* #1 */
> +	if (cxl_doorbell_busy(cxlm)) {
> +		dev_err_ratelimited(&cxlm->pdev->dev,
> +				    "Mailbox re-busy after acquiring\n");
> +		return -EBUSY;
> +	}
> +
> +	cmd_reg = CXL_SET_FIELD(mbox_cmd->opcode, CXLDEV_MB_CMD_COMMAND_OPCODE);
> +	if (mbox_cmd->size_in) {
> +		if (WARN_ON(!mbox_cmd->payload_in))
> +			return -EINVAL;
> +
> +		cmd_reg |= CXL_SET_FIELD(mbox_cmd->size_in,
> +					 CXLDEV_MB_CMD_PAYLOAD_LENGTH);
> +		memcpy_toio(payload, mbox_cmd->payload_in, mbox_cmd->size_in);
> +	}
> +
> +	/* #2, #3 */
> +	cxl_write_mbox_reg64(cxlm, CXLDEV_MB_CMD_OFFSET, cmd_reg);
> +
> +	/* #4 */
> +	dev_dbg(&cxlm->pdev->dev, "Sending command\n");
> +	cxl_write_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET,
> +			     CXLDEV_MB_CTRL_DOORBELL);
> +
> +	/* #5 */
> +	rc = cxl_mem_wait_for_doorbell(cxlm);
> +	if (rc == -ETIMEDOUT) {
> +		cxl_mem_mbox_timeout(cxlm, mbox_cmd);
> +		return rc;
> +	}
> +
> +	/* #6 */
> +	status_reg = cxl_read_mbox_reg64(cxlm, CXLDEV_MB_STATUS_OFFSET);
> +	mbox_cmd->return_code =
> +		CXL_GET_FIELD(status_reg, CXLDEV_MB_STATUS_RET_CODE);
> +
> +	if (mbox_cmd->return_code != 0) {
> +		dev_dbg(&cxlm->pdev->dev, "Mailbox operation had an error\n");
> +		return 0;
> +	}
> +
> +	/* #7 */
> +	cmd_reg = cxl_read_mbox_reg64(cxlm, CXLDEV_MB_CMD_OFFSET);
> +	out_len = CXL_GET_FIELD(cmd_reg, CXLDEV_MB_CMD_PAYLOAD_LENGTH);
> +
> +	/* #8 */
> +	if (out_len && mbox_cmd->payload_out)
> +		memcpy_fromio(mbox_cmd->payload_out, payload, out_len);
> +
> +	mbox_cmd->size_out = out_len;
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_mem_mbox_get() - Acquire exclusive access to the mailbox.
> + * @cxlm: The memory device to gain access to.
> + *
> + * Context: Any context. Takes the mbox_lock.
> + * Return: 0 if exclusive access was acquired.
> + */
> +static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
> +{
> +	struct device *dev = &cxlm->pdev->dev;
> +	int rc = -EBUSY;
> +	u64 md_status;
> +
> +	mutex_lock_io(&cxlm->mbox.mutex);
> +
> +	/*
> +	 * XXX: There is some amount of ambiguity in the 2.0 version of the spec
> +	 * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
> +	 * bit is to allow firmware running on the device to notify the driver
> +	 * that it's ready to receive commands. It is unclear if the bit needs
> +	 * to be read for each transaction mailbox, ie. the firmware can switch
> +	 * it on and off as needed. Second, there is no defined timeout for
> +	 * mailbox ready, like there is for the doorbell interface.
> +	 *
> +	 * Assumptions:
> +	 * 1. The firmware might toggle the Mailbox Interface Ready bit, check
> +	 *    it for every command.
> +	 *
> +	 * 2. If the doorbell is clear, the firmware should have first set the
> +	 *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
> +	 *    to be ready is sufficient.
> +	 */
> +	rc = cxl_mem_wait_for_doorbell(cxlm);
> +	if (rc) {
> +		dev_warn(dev, "Mailbox interface not ready\n");
> +		goto out;
> +	}
> +
> +	md_status = cxl_read_mem_reg64(cxlm, CXLMDEV_STATUS_OFFSET);
> +	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
> +		dev_err(dev,
> +			"mbox: reported doorbell ready, but not mbox ready\n");

You can make that oneline.
> +		goto out;
> +	}
> +
> +	/*
> +	 * Hardware shouldn't allow a ready status but also have failure bits
> +	 * set. Spit out an error, this should be a bug report
> +	 */
> +	rc = -EFAULT;

Should these include more details? As in a dump of other registers to
help in the field to debug why the device is busted?

> +	if (md_status & CXLMDEV_DEV_FATAL) {
> +		dev_err(dev, "mbox: reported ready, but fatal\n");
> +		goto out;
> +	}
> +	if (md_status & CXLMDEV_FW_HALT) {
> +		dev_err(dev, "mbox: reported ready, but halted\n");
> +		goto out;
> +	}
> +	if (CXLMDEV_RESET_NEEDED(md_status)) {
> +		dev_err(dev, "mbox: reported ready, but reset needed\n");
> +		goto out;
> +	}
> +
> +	/* with lock held */
> +	return 0;
> +
> +out:
> +	mutex_unlock(&cxlm->mbox.mutex);
> +	return rc;
> +}
> +
> +/**
> + * cxl_mem_mbox_put() - Release exclusive access to the mailbox.
> + * @cxlm: The CXL memory device to communicate with.
> + *
> + * Context: Any context. Expects mbox_lock to be held.
> + */
> +static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
> +{
> +	mutex_unlock(&cxlm->mbox.mutex);
> +}
> +
>  /**
>   * cxl_mem_setup_regs() - Setup necessary MMIO.
>   * @cxlm: The CXL memory device to communicate with.
> @@ -142,6 +406,8 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
>  		return NULL;
>  	}
>  
> +	mutex_init(&cxlm->mbox.mutex);
> +
>  	regs = pcim_iomap_table(pdev)[bar];
>  	cxlm->pdev = pdev;
>  	cxlm->regs = regs + offset;
> @@ -174,6 +440,76 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  	return 0;
>  }
>  
> +/**
> + * cxl_mem_identify() - Send the IDENTIFY command to the device.
> + * @cxlm: The device to identify.
> + *
> + * Return: 0 if identify was executed successfully.
> + *
> + * This will dispatch the identify command to the device and on success populate
> + * structures to be exported to sysfs.
> + */
> +static int cxl_mem_identify(struct cxl_mem *cxlm)
> +{
> +	struct cxl_mbox_identify {
> +		char fw_revision[0x10];
> +		__le64 total_capacity;
> +		__le64 volatile_capacity;
> +		__le64 persistent_capacity;
> +		__le64 partition_align;
> +		__le16 info_event_log_size;
> +		__le16 warning_event_log_size;
> +		__le16 failure_event_log_size;
> +		__le16 fatal_event_log_size;
> +		__le32 lsa_size;
> +		u8 poison_list_max_mer[3];
> +		__le16 inject_poison_limit;
> +		u8 poison_caps;
> +		u8 qos_telemetry_caps;
> +	} __packed id;
> +	struct mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	/* Retrieve initial device memory map */
> +	rc = cxl_mem_mbox_get(cxlm);
> +	if (rc)
> +		return rc;
> +
> +	mbox_cmd = (struct mbox_cmd){
> +		.opcode = CXL_MBOX_OP_IDENTIFY,
> +		.payload_out = &id,
> +		.size_in = 0,
> +	};
> +	rc = cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
> +	cxl_mem_mbox_put(cxlm);
> +	if (rc)
> +		return rc;
> +
> +	/* TODO: Handle retry or reset responses from firmware. */
> +	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS) {
> +		dev_err(&cxlm->pdev->dev, "Mailbox command failed (%d)\n",
> +			mbox_cmd.return_code);
> +		return -ENXIO;
> +	}
> +
> +	if (mbox_cmd.size_out != sizeof(id))
> +		return -ENXIO;
> +
> +	/*
> +	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.

??? Not sure I understand.

> +	 * For now, only the capacity is exported in sysfs
> +	 */
> +	cxlm->ram.range.start = 0;
> +	cxlm->ram.range.end = le64_to_cpu(id.volatile_capacity) - 1;
> +
> +	cxlm->pmem.range.start = 0;
> +	cxlm->pmem.range.end = le64_to_cpu(id.persistent_capacity) - 1;
> +
> +	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> +
> +	return rc;
> +}
> +
>  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -219,7 +555,11 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	return cxl_mem_setup_mailbox(cxlm);
> +	rc = cxl_mem_setup_mailbox(cxlm);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_mem_identify(cxlm);
>  }
>  
>  static const struct pci_device_id cxl_mem_pci_tbl[] = {
> -- 
> 2.30.0
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
