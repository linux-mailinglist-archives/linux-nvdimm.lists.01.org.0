Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0D530AEE1
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 19:16:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 35DF7100EB321;
	Mon,  1 Feb 2021 10:16:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9B8F9100EB320
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 10:16:39 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111IEqwc038712;
	Mon, 1 Feb 2021 18:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=MG4waTquuOehwQx0RcY5Y62eKpnv9PHRlDo23BKrfhQ=;
 b=F3OcC0Srtlp7YWZfW59vkO27H6uYOEECyL+1FZK0Y1JrjQlkvHHPe/2Wgnm1gJnWxrgF
 1icBk4k/U3dIp/1jYhTl/CZ3Qvx+dv07/C2Pu4YrCc4YlpAn6ScMTV2isgtgl8I1Gl1/
 3ycAU/naf9kHs7tLoEMcra+frWI5QOo3YRY1AvbQJlReu3d8R8vQ3A8qP6Lm/zntoTEo
 h+0Gz5OqF3DXHvCtpmX9ZutWqYD6VrvX407JHBRba/rYaobv8roNRchvSgmov2HbCbCU
 nXNWKlCDJ+WMWJjuXI6LzfY7YBA1kqTEUwnor+KxKy/elUjOBdF1iyRqoM+ICLJyJr23 DA==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 36cydkppuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 18:15:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111IFPfQ057422;
	Mon, 1 Feb 2021 18:15:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by aserp3030.oracle.com with ESMTP id 36dh1mryq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 18:15:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNMzckgDXxp6lhW04dUswzHo23o8RwVM0LlqFNXW9OjBr7l0XM3GN4brWfSlp9MZerpWcqEfroCysddicQoFNDfiBrz0vreHlyoPGE4u4WfcNF3t9UqhpDLGsrUezK/Um7KbJSlccBJQgOFQf+UZOOw4eK2N0zMdAbOktXBzjPPZQGFUy81jf79yvRq6miM3iOipihNfXrnDqjm/bV4l4BjWLh40U1GHvFu09Hg5V4fTKKN+G58H47hbz+NQ1gNmLeQNVMrjfwLQzPR1f9/dADc6YB5gkpwuc1R9Bnhi1a/lxvtkwqmOiUVldwyTBLGWocU0gsIjDlrsA/ef3movhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG4waTquuOehwQx0RcY5Y62eKpnv9PHRlDo23BKrfhQ=;
 b=Z64PG1NPEcpog643wuwPv7eaYE8rXcL+jebBy5croRoPT9/gnTvDx3HtAydSD4qNczZFgtz/fNe4z9Bs3lBFIM1tbJhfsAMXOpJDNfZC1HQugYH8wCv4pULXM685CHtM1NHeBzfn8x3/Bi+0/S3y3ZiQ8JDpJofzw2hQ3nRDX9AVWoKHJzhsvrkdw9ahONf4gzbZB7zv7tkjWKSnojsVJMFrIYNe4WGqawxh/IAOlgPnwe8Txwc3qMnvkjbXUi6Vtt1k1qz3U1TGw+PmLW/GXpY6uErKwPIMCl72C8QrOxFnFO6987onhMuPVDKfGFPXQK7Z/O/bPmCnU7VI5cVyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG4waTquuOehwQx0RcY5Y62eKpnv9PHRlDo23BKrfhQ=;
 b=Lj2ml9YDZ9ONCUAMx7+Q2RKvuDJX7B5jQxdc6dYiWHzTB5Y6uoJ/GU1pe6Yqb6bUTW8n5OqgkEmrOrspGLCmt93MjXWuwBX5oxOHHttNFpYZ2Qi9WXDiAusKuphoCcjEWXVWqxqHc6+HmXJytSGxPuoXd/74ar1SKEOSd2FoOPE=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4065.namprd10.prod.outlook.com (2603:10b6:a03:1f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Mon, 1 Feb
 2021 18:15:40 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3784.019; Mon, 1 Feb 2021
 18:15:40 +0000
Date: Mon, 1 Feb 2021 13:15:35 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 07/14] cxl/mem: Add send command
Message-ID: <20210201181535.GI197521@fedora>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-8-ben.widawsky@intel.com>
Content-Disposition: inline
In-Reply-To: <20210130002438.1872527-8-ben.widawsky@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: MN2PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:23a::10) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (209.6.208.110) by MN2PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:23a::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 18:15:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc9a162e-e52e-4d7b-a00f-08d8c6dd61bf
X-MS-TrafficTypeDiagnostic: BY5PR10MB4065:
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB4065995108859DB41FEB6AE889B69@BY5PR10MB4065.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1KebF0y4zdX1jucQw7tZaYmEdIE5LAApu6FHbie8+DP7D6irBimJGubb4IiDbZ9s51fLD6JlXaqPpfaj0L1uoKktJ89UQ/hasZ3jQ1DSl3SKoWMctrfKVC85YxE6FJ8hXHntxEbTu4h9t3TUdxiQ0ir0dDBbYmHSl+AlJzk9O4qj9r+Y4NmTsfkS5wm9uSYdciOAHsI3iWzde8y2lY7uTYNOincsgYKL2zEndIoVFT+yWHhO+nDRcq7U3bBqP5JMAgiO/OrwjEeVWfdYJOynWG5rUWXtW+0RANOl172Y5a8FrKtvWYos8V4hPcYPZ+JUHymFNpUlrBDYbQobHulvniZ+E5kIcfCqbgnK0ziklCSMoCqTPaqr71YZQG8zw64TWfOVf8R3pT+5kQ6Dvkzy1iLFVmezyAp/7OWzeMqjYcuse1uMeRuHwhZZjWMPXpUdECjHWQ5p6xybtcFVzrMXP+XyX+xwpOCMnykf91HC9fOenlVSI2CDD+LerV4D5RLuLlH2xAbar4tM/bs3t9dZ1g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6496006)(6916009)(9576002)(83380400001)(498600001)(26005)(52116002)(5660300002)(86362001)(186003)(16526019)(54906003)(2906002)(7416002)(8676002)(33656002)(4326008)(9686003)(1076003)(55016002)(66556008)(33716001)(66946007)(66476007)(956004)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?2xh9coI+KHxAnn+pRk/qQj6PEEqxuAyDfn3mF7lPct34YknYqTagsXElvd2w?=
 =?us-ascii?Q?ZpHU6ywAtFazRMaMIhi45yrBuTteoq/iq5ZcKuuDWGLGHrzjFsOKwGqgkF14?=
 =?us-ascii?Q?D1TxdnOxqSzCKStC3Br6M7t3hBWoma4g2GCopZQ7gCIOYCe3ff41R02uHSRL?=
 =?us-ascii?Q?g+2ToSQJqIIkEwdJpCv8UhZRk0zWPjOtBVxF8V/BRYeTDSWGfaSaiumur7eL?=
 =?us-ascii?Q?RzBYw+WeGhoYPHCCLMEtu+G/ZAnQFq6YXKBq890wF0VIezvojeu7KZWttfij?=
 =?us-ascii?Q?SNGQ1KMqfDz/2WYxAUw0GDsD+2u02705cIZGND8A++TQegPbNwQP4AXKN6iV?=
 =?us-ascii?Q?eOhN4DbSvaK3JrYm3cUvyqXihX8OaEu5JWq+cvOZfR19nJlKeFE285ihB+cf?=
 =?us-ascii?Q?A/ne5eTPgnvTDAnB8vqlG8/bwN9z1g6+hPzgJqdjOWaCJhixw+JBF0Zfs3da?=
 =?us-ascii?Q?wt/X+6unML+P2OEsCYBDkorHXNnrN0DhwcC5EMO7QE0sYSUPWtX/VyJlq7zy?=
 =?us-ascii?Q?Y68jWJm34IwzUG+DIOREFhn5X5oJNoYRsYwejA9zXQVCvzxUf2LoSb8hvjcx?=
 =?us-ascii?Q?s42cdUxCy/pxQN+GvP2FW/mCYGE5gU7UadJrc9+oxrD8IVP/PEJmzKN1gHMG?=
 =?us-ascii?Q?FqgqTfO1Oz+40b1DT3Mqr20JYgREP0A+Yabs1timzSItiMWS3DSlSNEM2nhy?=
 =?us-ascii?Q?uS8W5FN7ScuFK7Ng9AaFkV6n4uzK1ZyngbVnXlSpS34fFdrrHZFC4tGepZiG?=
 =?us-ascii?Q?eFhP1kc3G0jcTDX4xEScFTYuFAqgl5NVaXfqOYSaxW8dgTNU1Eu2U3lcAA7E?=
 =?us-ascii?Q?nFPnKfxjXAzsUZi5XNQJ+g2mB/a7uAWytAJiJBuvyJ6bKYzIn65y8+agOvyg?=
 =?us-ascii?Q?6N33QjFPTN7vCvW8e+a03WhbJNQZAOQqqBjtard4pCvTTqdzDBZUaxtt024d?=
 =?us-ascii?Q?HMsE262k2M4GRVP/tc2fq1AwxKrYiCwaX6YFxvqwObf0QbvDBtwu/5lZV6kz?=
 =?us-ascii?Q?3F1dx2lrEUL8mZi+9SpeEv/Dk4AF5FKNWs6JSwfNk6Jd8cXLdg4qtYEehHs5?=
 =?us-ascii?Q?AMZKxGQC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9a162e-e52e-4d7b-a00f-08d8c6dd61bf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 18:15:40.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dexFrS9etjktJYIE4QRxTvUsfHeOyyfCzC6NxsM6Zk72ASHhyHnRkRiCaD5c57m5I0yWYMH4SztEFQKJFIcdiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4065
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010095
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010095
Message-ID-Hash: F5KXWMQOMADRXFCR3LDLQNAUSYZ2QIBT
X-Message-ID-Hash: F5KXWMQOMADRXFCR3LDLQNAUSYZ2QIBT
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F5KXWMQOMADRXFCR3LDLQNAUSYZ2QIBT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> +/**
> + * struct cxl_send_command - Send a command to a memory device.
> + * @id: The command to send to the memory device. This must be one of the
> + *	commands returned by the query command.
> + * @flags: Flags for the command (input).
> + * @rsvd: Must be zero.
> + * @retval: Return value from the memory device (output).
> + * @size_in: Size of the payload to provide to the device (input).
> + * @size_out: Size of the payload received from the device (input/output). This
> + *	      field is filled in by userspace to let the driver know how much
> + *	      space was allocated for output. It is populated by the driver to
> + *	      let userspace know how large the output payload actually was.
> + * @in_payload: Pointer to memory for payload input (little endian order).
> + * @out_payload: Pointer to memory for payload output (little endian order).
> + *
> + * Mechanism for userspace to send a command to the hardware for processing. The
> + * driver will do basic validation on the command sizes. In some cases even the
> + * payload may be introspected. Userspace is required to allocate large
> + * enough buffers for size_out which can be variable length in certain
> + * situations.
> + */
I think (and this would help if you ran `pahole` on this structure) has
some gaps in it:

> +struct cxl_send_command {
> +	__u32 id;
> +	__u32 flags;
> +	__u32 rsvd;
> +	__u32 retval;
> +
> +	struct {
> +		__s32 size_in;

Here..Maybe just add:

__u32 rsv_2;
> +		__u64 in_payload;
> +	};
> +
> +	struct {
> +		__s32 size_out;

And here. Maybe just add:
__u32 rsv_2;
> +		__u64 out_payload;
> +	};
> +};

Perhaps to prepare for the future where this may need to be expanded, you
could add a size at the start of the structure, and
maybe what version of structure it is?

Maybe for all the new structs you are adding?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
