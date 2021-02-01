Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E5C30AF45
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 19:30:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DC5D2100EB324;
	Mon,  1 Feb 2021 10:30:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 25F06100EB854
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 10:30:16 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111IEtx3038745;
	Mon, 1 Feb 2021 18:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=dYYW4yh171kaE3DYSZB5UtmcosbsZqW/sZaXQDCbnOI=;
 b=Obc4ossviKaSLBhkY+SnvWNTRysvtzjqbY/N9xg/bz0gxEAhzSijJA43Hf66zJo+1IBd
 HXqclL8AcXseEbfFjCXIUX6XVdS0dAv0aek5qKwXSpTMEVaZTpGeYDLOc4X2o7Oz6deS
 +osh5ZX8dyRYhC4OnZ2jRG5PVTMKmAZW3RNYAiNU8OS7h+htgtk0KE9amFoKi3YTAkFJ
 mYcZKdI1G2SnCLGteS5olnlcWZcDVhgA3fIy3UIGhvX2ww+zW0YDOF/X/2ecBOMX1Khz
 JRDp2XuqvkKaWyxHFA3pQ0OH+1FHWMc48qpITIipMCN8oJiP72o3gkNyRjoJ0uqOMEdS XQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2120.oracle.com with ESMTP id 36cydkprqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 18:28:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111IGAM3074412;
	Mon, 1 Feb 2021 18:28:55 GMT
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2051.outbound.protection.outlook.com [104.47.45.51])
	by userp3020.oracle.com with ESMTP id 36dh7q508k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 18:28:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFMLGdGTEAN7ijBs5CXwoEsoGKuxtRzD9vABkbhmyvEHDSEHNasZXWqd+k+NPSHB0Gitq5FLbDjqt4t1PDiEFk+SFjiig4PBuLE+v+XoHl3BRaqjDGrjZ3QBkPPNK2uw1WK1slzjKIJqzLIiUDUTpglW0rXQKPC48k2atRswOZbDoXCjDKHIkFpep+U4+KcQwjEvXQca2X14HQG5v++fjbNMC3G9wIL8g+JSOolnoZJV29J0jqCDRvnE/NWI9svg1aAQN2fcf6Cjk++4nT3X4JHe5wqF0i7Fsh289+mikyG4WGOGkKUx0nKYBeccu98wMa5XHVzse2pSc3U4F5hxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYYW4yh171kaE3DYSZB5UtmcosbsZqW/sZaXQDCbnOI=;
 b=dzt1V7EZROMYBv8QOp2XUraLDRgRcTC4O4fvGWBGGMUm2Bdd6aN+dxYN8aIZuNqYsOs8Y8y5IymO+1GxH7sb1bvhDi8BhB2XR9PblEI9RJTcct4cEYOv8ljVAx1IvI9hWLQkzpl6KGCdf+P7wCRzEj3bDqW0xMJrnjXv4OUF5YWsmnK60O3FQL2JdHcqjmmHT3oO1v1/1bSQLk5uCrUvZIFSMBsceb/3CWFiHv1P+39x31kY2a/eXfhjDsooyLM3GhkEEkDTcZTHPKR5NJkFhLYGFi7NmFIB3+2OfK6fsDgxnfl1r/1FxOWQmLGsHU7nreUdMok34XMM3Qbl4dx8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYYW4yh171kaE3DYSZB5UtmcosbsZqW/sZaXQDCbnOI=;
 b=gQbwf0AF3n99ADLZnQLUrFuAe8Nr0oO+madH83iGq0nbQUaYvGp61brv+Wh6k2u3ic0dIzzAohsYC9nVl5XRPZUve+IFLMZANem6arUQ5EQf3MyOhP12mGhxR4l7+q0YEfNE2emMjQFICuvAyslc+kFIf+BFVfjEn8VMRJJQNQQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4369.namprd10.prod.outlook.com (2603:10b6:a03:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 1 Feb
 2021 18:28:53 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3784.019; Mon, 1 Feb 2021
 18:28:53 +0000
Date: Mon, 1 Feb 2021 13:28:48 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 13/14] cxl/mem: Add limited Get Log command (0401h)
Message-ID: <20210201182848.GL197521@fedora>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-14-ben.widawsky@intel.com>
Content-Disposition: inline
In-Reply-To: <20210130002438.1872527-14-ben.widawsky@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: BL0PR0102CA0053.prod.exchangelabs.com
 (2603:10b6:208:25::30) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (209.6.208.110) by BL0PR0102CA0053.prod.exchangelabs.com (2603:10b6:208:25::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 18:28:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0eda9bb8-5afa-4530-5af4-08d8c6df3a64
X-MS-TrafficTypeDiagnostic: BY5PR10MB4369:
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB4369E4D6F6699CBD52E2552E89B69@BY5PR10MB4369.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Inv6ued8EeV51r467fcibDbPpWbkdX6Euf4lZy/S0bxsf3j7d6Kr6ojkFNv7Yh5wOz2MGQobzH0uNU2URDQzCegneFU8u5tcE9mcAwPjMzkszmfvYWlTSXdJyhcWpuU4kqu3AQBRjvbOWe/f12Rn0Fl5jHzxqqpyU838Zp/1ZbEVImK88xpLaJF74uBGmU9ddaoHmmq4Akm1WJpfIsfoHipHFx+CvC0O82iLC2mD6NwzhEUkrXgEf7xhCJBTwAzFwPfG4VKUfFvxIdeCjdYZuojvlavaIgz6phRK86n4aTmxhuyRxFc1+UFt4pCUsyh9z1AzWZkXTCeIsbWIaY31KEJem+lqhTEvbnwyeCbZxxVN2j6VkjTN598U+KopRpttMeEdzZ10FdXpUNc7fERNd7ly+UoYqii15lTgXJ+DDVt+2rXbNhQVgXKLzd9wi96nSlV6OgyaYrh0RbkQLOkUecVg1m8tFdFYfo4SXni9F/pNh9yW6c9vHIfbea6/F+zVnPaZsA1IXHVXbI3pWevBkg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(39860400002)(376002)(366004)(6916009)(1076003)(5660300002)(956004)(7416002)(55016002)(86362001)(4326008)(26005)(33716001)(478600001)(9576002)(9686003)(6496006)(33656002)(6666004)(52116002)(186003)(8676002)(16526019)(54906003)(66946007)(83380400001)(66556008)(8936002)(66476007)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?6mRzTBZNapB3b6vKOBjg5QZNGbZ96TXOAfAqwJhGeyhi9d6sDDWwtWETgxew?=
 =?us-ascii?Q?XLsTJwkJPUT7j63synMYxvHUopXGP6c1D0AJwH37VEdWgS0843MX2pdujN8/?=
 =?us-ascii?Q?Sxy/i5jplfIlp4LTHbLW5lEZzcG2ugPM5M8HEVSxfPOU24aUZIZC1DvER//+?=
 =?us-ascii?Q?+2ynT+dGThE66XcJHnRRF6eQ0pjdEm7iovsHrmMJr63DSBbf16pBbygZR7Lr?=
 =?us-ascii?Q?C/rkfu/tRw1EJfHoe0hyKirYd8c8ALyLoVOzx6lwJeV17VGUtDCLCyJxTi0k?=
 =?us-ascii?Q?7GhLBuUlBDRa2Y1ROAqc8TdYuQZvYEBy5o1KfIpX+IVAkizlNODbbjQAHWKW?=
 =?us-ascii?Q?qukRMwOkbVV0urT+QIE1qnixmt6263yWcCSOtXAlLAz/sshp/jvwx1cU5c+p?=
 =?us-ascii?Q?AtqZD7zoTCPTALDEd/N60+h3YSo5gQrC+68FKQwrTepYSHnHnkeCLB4Iq82K?=
 =?us-ascii?Q?WA6lx3n6RGQWThcqYcnWQDgTGY1v4q0hEx/cuJuKbvc774zGF48N/1B5y0+U?=
 =?us-ascii?Q?yGnzKLKI9B8EzctykWYxjpM330YAMvuf74nsNQNJwhaPUzNbiRwF9D4hOC4J?=
 =?us-ascii?Q?BgNeRH+R/3lqG3fEWEBDqSnW8xu2anqia2C1wd/m+eKDUEjVF4+0x3yUfS28?=
 =?us-ascii?Q?/tCWdYFr59RrDfDQwVlf2Usv7QJ/I22yp39tw0QQurWpEyvrlNHg7oO6JTp7?=
 =?us-ascii?Q?BzfY6SXf51aoTrwvBVJ8Jx/4+5/VLT+6mkqPDAqXhegtF454h51M7eK0QKvl?=
 =?us-ascii?Q?dDoUyPtHkYuVyQkpSM5zg53nuftOP2UEkw4yh+lun7CQVwd5PkWYFE7pkxQt?=
 =?us-ascii?Q?WEe845GsJVdNJaNmWs+v7jev8Hu5pVH8vesYmWoGsnvxGS53G04MUyTd3tYj?=
 =?us-ascii?Q?hkC6djklEzZaWkpBQdveIiqLgir8RWz0SJpJcTGB6Bmtb/MAvgfoEhMf0tmR?=
 =?us-ascii?Q?VCvJRfQTalRGmqWExQ3YQzf6zXKIPzN8L6UFmopt30m80eR9C6UN5Oovj2Nd?=
 =?us-ascii?Q?d+sZYYrmoq+bV9gq1aCBhBHxqoxDFKGi82KknV5LQiEIWX648lS6d9o1XxmI?=
 =?us-ascii?Q?UmgazJ2L?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eda9bb8-5afa-4530-5af4-08d8c6df3a64
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 18:28:53.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCfNYwUnxYzYNdQHkBdsGWqRJPxUsYttGt+xFM/BpyJzryPj+WLrkznwSgseuj1XmPn6DpFzo8fDL/9IvNEkCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4369
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010095
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010095
Message-ID-Hash: GWRZAY326EXUE4NSN6NI6UDYLTS244PT
X-Message-ID-Hash: GWRZAY326EXUE4NSN6NI6UDYLTS244PT
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GWRZAY326EXUE4NSN6NI6UDYLTS244PT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 29, 2021 at 04:24:37PM -0800, Ben Widawsky wrote:
> The Get Log command returns the actual log entries that are advertised
> via the Get Supported Logs command (0400h). CXL device logs are selected
> by UUID which is part of the CXL spec. Because the driver tries to
> sanitize what is sent to hardware, there becomes a need to restrict the
> types of logs which can be accessed by userspace. For example, the
> vendor specific log might only be consumable by proprietary, or offline
> applications, and therefore a good candidate for userspace.
> 
> The current driver infrastructure does allow basic validation for all
> commands, but doesn't inspect any of the payload data. Along with Get
> Log support comes new infrastructure to add a hook for payload
> validation. This infrastructure is used to filter out the CEL UUID,
> which the userspace driver doesn't have business knowing, and taints on
> invalid UUIDs being sent to hardware.

Perhaps a better option is to reject invalid UUIDs?

And if you really really want to use invalid UUIDs then:

1) Make that code wrapped in CONFIG_CXL_DEBUG_THIS_IS_GOING_TO..?

2) Wrap it with lockdown code so that you can't do this at all
   when in LOCKDOWN_INTEGRITY or such?

> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.c            | 42 +++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/cxl_mem.h |  1 +
>  2 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index b8ca6dff37b5..086268f1dd6c 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -119,6 +119,8 @@ static const uuid_t log_uuid[] = {
>  				 0x07, 0x19, 0x40, 0x3d, 0x86)
>  };
>  
> +static int validate_log_uuid(void __user *payload, size_t size);
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
> @@ -132,6 +134,10 @@ static const uuid_t log_uuid[] = {
>   *  * %CXL_CMD_INTERNAL_FLAG_PSEUDO: This is a pseudo command which doesn't have
>   *    a direct mapping to hardware. They are implicitly always enabled.
>   *
> + * @validate_payload: A function called after the command is validated but
> + * before it's sent to the hardware. The primary purpose is to validate, or
> + * fixup the actual payload.
> + *
>   * The cxl_mem_command is the driver's internal representation of commands that
>   * are supported by the driver. Some of these commands may not be supported by
>   * the hardware. The driver will use @info to validate the fields passed in by
> @@ -147,9 +153,11 @@ struct cxl_mem_command {
>  #define CXL_CMD_INTERNAL_FLAG_HIDDEN BIT(0)
>  #define CXL_CMD_INTERNAL_FLAG_MANDATORY BIT(1)
>  #define CXL_CMD_INTERNAL_FLAG_PSEUDO BIT(2)
> +
> +	int (*validate_payload)(void __user *payload, size_t size);
>  };
>  
> -#define CXL_CMD(_id, _flags, sin, sout, f)                                     \
> +#define CXL_CMD_VALIDATE(_id, _flags, sin, sout, f, v)                         \
>  	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
>  	.info =	{                                                              \
>  			.id = CXL_MEM_COMMAND_ID_##_id,                        \
> @@ -159,8 +167,12 @@ struct cxl_mem_command {
>  		},                                                             \
>  	.flags = CXL_CMD_INTERNAL_FLAG_##f,                                    \
>  	.opcode = CXL_MBOX_OP_##_id,                                           \
> +	.validate_payload = v,                                                 \
>  	}
>  
> +#define CXL_CMD(_id, _flags, sin, sout, f)                                     \
> +	CXL_CMD_VALIDATE(_id, _flags, sin, sout, f, NULL)
> +
>  /*
>   * This table defines the supported mailbox commands for the driver. This table
>   * is made up of a UAPI structure. Non-negative values as parameters in the
> @@ -176,6 +188,8 @@ static struct cxl_mem_command mem_commands[] = {
>  	CXL_CMD(GET_PARTITION_INFO, NONE, 0, 0x20, NONE),
>  	CXL_CMD(GET_LSA, NONE, 0x8, ~0, MANDATORY),
>  	CXL_CMD(GET_HEALTH_INFO, NONE, 0, 0x12, MANDATORY),
> +	CXL_CMD_VALIDATE(GET_LOG, MUTEX, 0x18, ~0, MANDATORY,
> +			 validate_log_uuid),
>  };
>  
>  /*
> @@ -563,6 +577,13 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
>  			kvzalloc(cxlm->mbox.payload_size, GFP_KERNEL);
>  
>  	if (cmd->info.size_in) {
> +		if (cmd->validate_payload) {
> +			rc = cmd->validate_payload(u64_to_user_ptr(in_payload),
> +						   cmd->info.size_in);
> +			if (rc)
> +				goto out;
> +		}
> +
>  		mbox_cmd.payload_in = kvzalloc(cmd->info.size_in, GFP_KERNEL);
>  		if (!mbox_cmd.payload_in) {
>  			rc = -ENOMEM;
> @@ -1205,6 +1226,25 @@ struct cxl_mbox_get_log {
>  	__le32 length;
>  } __packed;
>  
> +static int validate_log_uuid(void __user *input, size_t size)
> +{
> +	struct cxl_mbox_get_log __user *get_log = input;
> +	uuid_t payload_uuid;
> +
> +	if (copy_from_user(&payload_uuid, &get_log->uuid, sizeof(uuid_t)))
> +		return -EFAULT;
> +
> +	/* All unspec'd logs shall taint */
> +	if (uuid_equal(&payload_uuid, &log_uuid[CEL_UUID]))
> +		return 0;
> +	if (uuid_equal(&payload_uuid, &log_uuid[DEBUG_UUID]))
> +		return 0;
> +
> +	add_taint(TAINT_RAW_PASSTHROUGH, LOCKDEP_STILL_OK);
> +
> +	return 0;
> +}
> +
>  static int cxl_xfer_log(struct cxl_mem *cxlm, uuid_t *uuid, u32 size, u8 *out)
>  {
>  	u32 remaining = size;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 766c231d6150..7cdc7f7ce7ec 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -39,6 +39,7 @@ extern "C" {
>  	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
>  	___C(GET_LSA, "Get Label Storage Area"),                          \
>  	___C(GET_HEALTH_INFO, "Get Health Info"),                         \
> +	___C(GET_LOG, "Get Log"),                                         \
>  	___C(MAX, "Last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> -- 
> 2.30.0
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
