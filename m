Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C0E320273
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Feb 2021 02:23:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D4083100EBB8D;
	Fri, 19 Feb 2021 17:23:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EEADE100EC1E3
	for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 17:23:24 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K1JuFP097572;
	Sat, 20 Feb 2021 01:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=ls/MCjuSTzygFrGKFThhaEIVYwsrJ6fDKKIQWaCRKow=;
 b=qFH7+Q8PVqGsC+OMcjAHNQ8MQPPYOu4GUZPlyycADyP6s05YRSqjQVwjVNDmBSvd5nEu
 n3KWcSOH+OfJLXMB415pi9JLWcneZfz8VpokxFQrIhHw9Pb22PtffCpgt7irs8kS2+ya
 Elmra1Sw2LRu1AL7zPhplFmaSf1sSyoNTwJ61D09dZ49x3W1l7JUaTlAtoZDF5fZtqsU
 dHwl7zhANQo9n2oBplQ5bXO5wPU7a0HS0A8SqxMjpHf2ZzNARMH4Tgh1D+4dg0i2V/4T
 SBS3Lvp0BdKswbPXfZ8P+sXLX/Y2LLQzRM7eOusyCmYz2mljTkpj37zsFNckS7e4RNuB ng==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 36pd9ajpn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Feb 2021 01:22:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K1KVGl011059;
	Sat, 20 Feb 2021 01:22:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by aserp3030.oracle.com with ESMTP id 36trf98927-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Feb 2021 01:22:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFc0mVGPGTQo7CfwtBxdnr7EAA2KTZGLZs7v0i5KL4GBYRgCVvbRQe6bTTZergeH+dLDNZoV/ju4QMn/nGVFVaNF1ZKqOLYr005F9mNa731gQvFzu95QQiPmz0w3/rUUqs0WJSSWEe4zbpLG8iHXEUQadvLlxUf6tBSgIl6WFwMsKr/n3gpauPHAS8tK+ZdSEi90GE+u816iEvnq7RvqkKnhpnVB6crajmIeeLO5Hvuuo04xXvuXtIra+HEKIjqCqbLI9Mt1dYciwYNWb0lYwvfEYTsO7ZuTL5hxrXvXzEnM6Xi2niH6oavvNReqKASbIDWmql0ruh5yoUuS3ctB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls/MCjuSTzygFrGKFThhaEIVYwsrJ6fDKKIQWaCRKow=;
 b=jJGySas15iXoaUE95OQhHBDhTOPJMYFOGSjTZn27VuuY4s7iJ1AOC2jKwEUoapsOY9/Tckm+mcwYprwQ2sQqL4cCNBC9vNEm3RnqcKEQivO5TrT/Qe5IpmoBHqsmEtGjQzXRKdEAs3OskGo3ZITSgNaVnYv/W5KBbneVMRekanr/A7zeGxkQjCUBR1rFAYhMyJ2DLkZ/x9/ukYpfgGzsbgP7dGeLSjttrFDuIfcdk/rO6j3eW+Njmphvh0NPwDWuLNZ9D5+Yljzvft9Duzb3ac04gaGcmaT16ihbCce3eScUzwyMHty0JfxTCFzcY1WIbEah57/CiZl54SbFO8fA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls/MCjuSTzygFrGKFThhaEIVYwsrJ6fDKKIQWaCRKow=;
 b=ONRQt7CizbnZUZRf20gKDwUNCO3G3DOU4jLqAOwtKZF64Oo5LjQ7v9nHqv50x8Ojk1mS1Jpm+S7y3GttLYoJy7UtMpF1lopLkKs3Mn2SxiHywu0RA/+0MduScK+i8o8yZP2uYrLS7H/kaebh7rAjP/+MSGoCET0H+g+EBhOe6to=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB3400.namprd10.prod.outlook.com (2603:10b6:a03:14e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Sat, 20 Feb
 2021 01:22:06 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3846.039; Sat, 20 Feb 2021
 01:22:06 +0000
Date: Fri, 19 Feb 2021 20:22:00 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v5 4/9] cxl/mem: Add basic IOCTL interface
Message-ID: <YDBkOB3K8UqVakFf@Konrads-MacBook-Pro.local>
References: <20210217040958.1354670-1-ben.widawsky@intel.com>
 <20210217040958.1354670-5-ben.widawsky@intel.com>
Content-Disposition: inline
In-Reply-To: <20210217040958.1354670-5-ben.widawsky@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (209.6.208.110) by BYAPR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:40::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Sat, 20 Feb 2021 01:22:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7929d7d-6f61-47e4-4852-08d8d53def74
X-MS-TrafficTypeDiagnostic: BYAPR10MB3400:
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB340031E19E1A121A8DC822F189839@BYAPR10MB3400.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	H/F7Ep3DCSJChawm0Gy8lQ/jIdAF1MBDnDuy0bMgGDS0S1PVSgVSGSKW2J2yrPxWTZvaLTxzll+vMz6ydZ8MOiU2bRDQF6p1ix6bKPktBH52kqJ63KOoB/dXADsdKUU9Ei+h5cx1YWwI9efo+tSicE83vXLnWPnrRvkOWAKgipS0/S4xtQCrN7q65CB2lbMohCkAGETfHXMoNTqUDRFxMSg0E49IWtITfPjeTm5sqn0Ou+BqotSRWaPRPQvUwgHn/N6XZZSRT+2WLpqGWBrN+IRGGnqAXqCerRgF0mcvWNqMNfGvas27FTueNBqAugghUMMrKDzFEfFsqip/xRmgMgQBOzpXtm0Rl3ZrkcadkLKl7EXOGy9qIueuLdpc1nDixwrtEL5vpU2TUh/bwCTrT3xCI+7hvee9wvIpojXclSy9xiNyovhv31JyNQV2ju3dY0qTjE+qxcCD2dHxqMYDZfgJv9LHmBg9p8y4J4buuC/JGtxX1ndFiCydiv/AWCHamgbOAxV9a1DMY/zaBFQahw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(376002)(39860400002)(136003)(66946007)(6916009)(54906003)(26005)(2906002)(66476007)(5660300002)(316002)(7696005)(7416002)(4326008)(52116002)(66556008)(8936002)(8676002)(186003)(86362001)(478600001)(55016002)(6506007)(956004)(16526019)(83380400001)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?wsp90nxIxm5PTpRN7nZgOx8L7e24A2TLfd23r/b63zhNyjmf7lkb/okng1Et?=
 =?us-ascii?Q?JSfOj27V8VaNL/CAuEKeV77Yx9D0+YtHx1/ZzJ0eHwMES9MfnoLh9fKwnOIl?=
 =?us-ascii?Q?L6o71R+KnNyHM7leaSuEYio9l4MdVwI5XrpCfVg2nKD72arC51AyZEw4KgFN?=
 =?us-ascii?Q?6LVqoGRV9DqNmv1fzs6SrubF8JhBOUGyuQm8g96ilNq2ss980bu53pSwByE4?=
 =?us-ascii?Q?H6s2kUtqnk6cz+9tSuWOzgnIzpYsPFbbHlzeTrapEQyVz23oIYuA4tcu6pWh?=
 =?us-ascii?Q?A9OF6eLFDI6d67KFOAC31U90hhFRyvxiggcjsii71iSbNe+xVZMd5l6YU8TS?=
 =?us-ascii?Q?Z+g19GNp7VEU+2bKOf5q8Code2dI9NNq5pziitscnZiBEzynyP3kd6uDNIxT?=
 =?us-ascii?Q?Ru1O+FdyE4nqnarpU1c10S2rDR15koF6s4mJcmKUontbCAhb16ck/VvnacUG?=
 =?us-ascii?Q?5Lz95jwyFmki8vkuSBs8noVi3pV/L1x2pwl8yPaZh+WAdYG++bq4Za/oKjrq?=
 =?us-ascii?Q?6TbbF8xOkD/9AJRkR70JrlldZlyP0iiaNwKoxd9TxpY62+cWTJqY03BeRanQ?=
 =?us-ascii?Q?tdZXmEed+m01BRKjxsQ4G88rRdHnkLXFBMWYS8s3MGGjTAiBDhW7phZx4nsf?=
 =?us-ascii?Q?7CXq1FCTmE6CZkra9d2ZeTY3HjP/4htFhD+87XlFHLAfNlX8pxogRhOVcXEm?=
 =?us-ascii?Q?TclnwlCxpdMSutLyoLDXBU0GBYbX07adtJntX3STPxQd5KIIvP5p1lHU+k0y?=
 =?us-ascii?Q?90XOnp6t9tmof6WcKuBeQ/P+V0/bToCSHm+hXfyCLVfYA0z1hHGCEv1ZlDCl?=
 =?us-ascii?Q?dJxz0h/vJx1oaaXe8b49oEME0E3bz3TJybcEuE0Am1/HfGlhyE6Z8wkcfN8Z?=
 =?us-ascii?Q?x1TSWZoO5FI68FW6Tf1WmCcZLP6RoVVYM8oMi5s4rXASoW0ttX8vv1eqK3DK?=
 =?us-ascii?Q?DDfiLy1z+Xh8cRHiLyuYQBC+FAwln+TiiieeT7KZ1bF6W9o4gp2KAf8+xmPx?=
 =?us-ascii?Q?zQeF59jDpQd6eV3wOmj4p1SAtJTgBUaT2k3WLPPTE2TTYSA9oUWJErPKIAuj?=
 =?us-ascii?Q?jFRSKMvtwBpNGIvoXQKwHGJoTtZAFRP2N/7LsAL/+RsoU4upy9829GjEQu7f?=
 =?us-ascii?Q?EYzlDKlFa0Dx9fo70RJUi7MT9rKNU1hFX4Q9DN0zR+FfdhqoN2fGQbbctijT?=
 =?us-ascii?Q?4Q3or+YC5o8uyj840qtpmH5yrp8tQlSm2bdz4wFtTmBXa7KjHyyTnVLmeoBi?=
 =?us-ascii?Q?mvBCjhquNa0bMnGd+VBav0mPRljDOwx/jit5kNAh26gxm20MtrfFx2vmXPkx?=
 =?us-ascii?Q?v/pJ+MF+Y5hkQODMtvaS324K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7929d7d-6f61-47e4-4852-08d8d53def74
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2021 01:22:06.1540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2/VHeJpRs6HUDoE7PRjNdLdkJLtGOIGHH4kz1zpSr0xGmVu8fNsCAuBLg797bJrPfMdoZmlSwp/0YfkK7Yjxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3400
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 mlxlogscore=986 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102200007
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102200007
Message-ID-Hash: MUIYSMO5YAIFXSSJXBZP5BIDNCWNRJHD
X-Message-ID-Hash: MUIYSMO5YAIFXSSJXBZP5BIDNCWNRJHD
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, kernel test robot <lkp@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MUIYSMO5YAIFXSSJXBZP5BIDNCWNRJHD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

..snip..
> +static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
> +					const struct cxl_mem_command *cmd,
> +					u64 in_payload, u64 out_payload,
> +					s32 *size_out, u32 *retval)
> +{
> +	struct device *dev = &cxlm->pdev->dev;
> +	struct mbox_cmd mbox_cmd = {
> +		.opcode = cmd->opcode,
> +		.size_in = cmd->info.size_in,
> +		.size_out = cmd->info.size_out,
> +	};
> +	int rc;
> +
> +	if (cmd->info.size_out) {
> +		mbox_cmd.payload_out = kvzalloc(cmd->info.size_out, GFP_KERNEL);
> +		if (!mbox_cmd.payload_out)
> +			return -ENOMEM;
> +	}
> +
> +	if (cmd->info.size_in) {
> +		mbox_cmd.payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
> +						   cmd->info.size_in);
> +		if (IS_ERR(mbox_cmd.payload_in))
> +			return PTR_ERR(mbox_cmd.payload_in);

Not that this should happen, but what if info.size_out was set? Should
you also free mbox_cmd.payload_out?

> +	}
> +
> +	rc = cxl_mem_mbox_get(cxlm);
> +	if (rc)
> +		goto out;
> +
> +	dev_dbg(dev,
> +		"Submitting %s command for user\n"
> +		"\topcode: %x\n"
> +		"\tsize: %ub\n",
> +		cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
> +		cmd->info.size_in);
> +
> +	rc = __cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
> +	cxl_mem_mbox_put(cxlm);
> +	if (rc)
> +		goto out;
> +
> +	/*
> +	 * @size_out contains the max size that's allowed to be written back out
> +	 * to userspace. While the payload may have written more output than
> +	 * this it will have to be ignored.
> +	 */
> +	if (mbox_cmd.size_out) {
> +		dev_WARN_ONCE(dev, mbox_cmd.size_out > *size_out,
> +			      "Invalid return size\n");
> +		if (copy_to_user(u64_to_user_ptr(out_payload),
> +				 mbox_cmd.payload_out, mbox_cmd.size_out)) {
> +			rc = -EFAULT;
> +			goto out;
> +		}
> +	}
> +
> +	*size_out = mbox_cmd.size_out;
> +	*retval = mbox_cmd.return_code;
> +
> +out:
> +	kvfree(mbox_cmd.payload_in);
> +	kvfree(mbox_cmd.payload_out);
> +	return rc;
> +}

..snip..

> +static int cxl_query_cmd(struct cxl_memdev *cxlmd,
> +			 struct cxl_mem_query_commands __user *q)
> +{
> +	struct device *dev = &cxlmd->dev;
> +	struct cxl_mem_command *cmd;
> +	u32 n_commands;
> +	int j = 0;

How come it is 'j' instead of the usual 'i'?
> +
> +	dev_dbg(dev, "Query IOCTL\n");
> +
> +	if (get_user(n_commands, &q->n_commands))
> +		return -EFAULT;
> +
> +	/* returns the total number if 0 elements are requested. */
> +	if (n_commands == 0)
> +		return put_user(cxl_cmd_count, &q->n_commands);
> +
> +	/*
> +	 * otherwise, return max(n_commands, total commands) cxl_command_info
> +	 * structures.
> +	 */
> +	cxl_for_each_cmd(cmd) {
> +		const struct cxl_command_info *info = &cmd->info;
> +
> +		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> +			return -EFAULT;
> +
> +		if (j == n_commands)
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
