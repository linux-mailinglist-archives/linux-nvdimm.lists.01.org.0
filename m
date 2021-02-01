Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C02730B06E
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 20:36:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9E792100F226B;
	Mon,  1 Feb 2021 11:36:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 024B4100EC1E7
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 11:36:18 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111JY8fQ106645;
	Mon, 1 Feb 2021 19:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=xpckslHfF/5+84u/642qnys+bM9cicwqO3479q1W6iA=;
 b=MR42M1al7qUM2hRojSbMP5t4jMK8GbP/XIIUYuywaxwkL1FNdJrDU6ckyiHojycpcsoZ
 DtIl4QOANif8Z/IyztKbzRyKpXaMUYRUmGTxg8XDSU/DCEIvYra1WuGMJ3eA6el8DmBu
 3IcHIOnMT7Fjw81IY7x60yRXdEW0aKNeaJwMwi4PAHaQIy1ianTvCxfuItjYQuUhRgBS
 LiD6R/cTXQO4WC9BHnCuX/+xHIfVVzThuN6qAis2Pbr0jqxhS7K8tkWIOb2K51tiBBKb
 ar2n9lemBwf1ClsyZzHut/gbIvXCrnJIfK0tT7LnUA3hSsLr0QsNeV0XzDFK6hNTyH6Q jw==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 36cxvqy5jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 19:35:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111JYs0a131794;
	Mon, 1 Feb 2021 19:35:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by aserp3020.oracle.com with ESMTP id 36dhbx3w16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 19:35:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAOYSmMv9Vv1VnjHodm/RhbKJSPjSqXlhlKih0Rif5M9a8iYUoYXY5OtE30qAEDvlwdxNN5zmtgjULdczSNs0nfQB3igt6E858hmbf8d2MzyZbDo+eUPNIVhk639mRr+1PYMCcdWjglabjZDVRiY3hnqJHylpKxze0m/ik7e40fcJylECEbm7/uCSQJkRtDDQaWw3kIAYQNDW0i2W7wWf/l5PN5Jpje3n8onmf9aIXjCdrc9OewfRKwxPyxs3Uqft+3anSd/fF//rXkvFOnI93H0Aohw48L9Pb4prHGZ7FYgBoQf6clZolU9vF+7442LAFsVXTsqjNiAXU/3+Sysog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpckslHfF/5+84u/642qnys+bM9cicwqO3479q1W6iA=;
 b=C6ZrTdKI+uEW30mfe2SPSsGsQXSb0eSg4L8CmMsSNN0EShk0rPE3YWnsX5aJVY0eTRgaZWuzR0rbrgUIwIA6XA+ug0O9qzXN1nXBxwGcUGaaIFyruZHzQLPkVyWK0v4Ss9f6BI+l2RgZ0o3ShYmfO0F6NloitCDg/idm7jJMIdRF5XPY0CHt3ZVHVwbYgCO8rbNrfNNAR3WiMQb1AZBk2mb3CUHdv3FBwWKvng4D8NnuLPl5nlY/rW028G6h0AyIR6ds45h+6BCtQsM/zWmJzWKkfyxuSHU/P4aS6KV9Kc5aMIoxIjFgm1fp5ngUomw2BxgTk7TvIXdKJysrHuP98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpckslHfF/5+84u/642qnys+bM9cicwqO3479q1W6iA=;
 b=qtr0pJjwiYyK2CwX5/B8VUlfwwM9IgYP0ipKCwIbMm7v/MDxNrdACsydQVmZuPHwBYzuZJaTHmRjYOUc6IKjkQO2BkJ0enwJ00S6qLUscVciirAJ9oWAxAINkseSfGhgIwTZmcw9r9twYsbx12hFDJGOiHgCBJTUp5gOChu72H8=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB3874.namprd10.prod.outlook.com (2603:10b6:a03:1fc::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Mon, 1 Feb
 2021 19:34:58 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3784.019; Mon, 1 Feb 2021
 19:34:58 +0000
Date: Mon, 1 Feb 2021 14:34:53 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 09/14] cxl/mem: Add a "RAW" send command
Message-ID: <20210201193453.GA308086@fedora>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-10-ben.widawsky@intel.com>
 <20210201182400.GK197521@fedora>
 <20210201192708.5cvyecbcdrwx77de@intel.com>
Content-Disposition: inline
In-Reply-To: <20210201192708.5cvyecbcdrwx77de@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: BL1PR13CA0386.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::31) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (209.6.208.110) by BL1PR13CA0386.namprd13.prod.outlook.com (2603:10b6:208:2c0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Mon, 1 Feb 2021 19:34:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aa613e5-46ab-4bb4-feac-08d8c6e875e5
X-MS-TrafficTypeDiagnostic: BY5PR10MB3874:
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB387442511B45F4C6FBB273B189B69@BY5PR10MB3874.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DdCKADQcLUM6lI1X9SLVI14uEln5pJ7nMk5gzUV/aCp058/oUXzCYEBQpdTyZkzptyGfO2767ciiDNqXdPzqvhU/NVaJXsEvdxzo7rIjV6ZsN8+aZMn54rraaPaC1Zujl8mebz93xplQPVbhIv7oiUZTFhBPG+EysCuep7EozPdqg0WkF2wkUnzLBo9A4ZoDADNxMXN6Bs3E0ls36qlg7da1sVVYCRuwjy+ueo2lKQoPl1m4hIq316tJnEdyllbfXTbKIGoxTf+knxqb37aNHcJwCCI8asp0t0FW1gIfnjDP8LU8amyCh23WDF5iB1tbkc/HoGhXiqbxAjOK1QWiQh0XoWNYncbMFvhytWsOp/H7LmZ7VT/UW4qf20xGZ64aA9fpUN32qInZEail35YlvU0DyBDvLgnTE/py+uaZRJ4CTbz11S3hOpOGzowxLG18iT/gKJH8nMk3BNm8CJBATQ/23h2cPUK5iPazbAYI84PJdVZukH5HYU2gnIoNioPqO8I9LdRliCJIYPffKAtpNA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(136003)(366004)(6916009)(9576002)(6496006)(9686003)(54906003)(33656002)(8936002)(55016002)(7416002)(1076003)(478600001)(8676002)(6666004)(956004)(66556008)(66946007)(66476007)(186003)(52116002)(316002)(26005)(16526019)(2906002)(53546011)(4326008)(86362001)(33716001)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?vSRmHiQN9lYwYXoZIwXeIDC7fbKunc6Cgw9tlpnRmb408QLTgLMyhUkgzqV0?=
 =?us-ascii?Q?f0FA0xaGa2sMIFXt2yKx7OmInu6SbW4Ns27JBSam9Ufp0jhGcsC2KTcL6BEw?=
 =?us-ascii?Q?en9uj298b99//gq6PUCF7GXjNAihrnp/IvVrd9B3hVIACjeC0332P3gduW9g?=
 =?us-ascii?Q?2LLz8tGqK1gnDpHr8oeQF+nZufPr4ZdQlkSQGtULKzEzwyN00knPwPSIq9Tu?=
 =?us-ascii?Q?Y5kKnjEdhqcTBem/6Lr1iTfqUsjn8Q4McIzND8n4iXZvYcK6/B87B4iNxXA0?=
 =?us-ascii?Q?Cfhn1NDhrDfJVCqUQ9pAQTrr4Ce9ir4Njsz8fhegW+Q20Xqn8GEVQg4c+/ml?=
 =?us-ascii?Q?wzA1T3XGeUVz+U8DZTuqMVhum7AIglhmZu3RjHjBESjulykVCtn2Y/ae7IzD?=
 =?us-ascii?Q?W0Hcj0SHKx1Z7odzS7I8WcGYJ/P3rlN5BtbHbpvo3M17ITxu5QEtmc6G3xR7?=
 =?us-ascii?Q?B2CD6cQY73mec87xckRWkSofnWFl8XLwQeSVB4rD2RDNW/3Woz0r8LHdqSPv?=
 =?us-ascii?Q?HyvMvsXrZahBouB9bvYN8uCkqVkW4f40EadGwSNcXOGmn+a4E5oQc5lk4CSp?=
 =?us-ascii?Q?g65o410gdhwBi3ul452ofOzx5SWkq50w5ax56EZ+6siE6Mrt/sp/1RBbEutf?=
 =?us-ascii?Q?HnouFbuoyWH3HHNYD7OhihkmVLP/uDxlntSNw3Trss7QCsBCxXd/IfC6ADJm?=
 =?us-ascii?Q?jWIqSLPqWu6ogsD613WXtHozj6dUnwLCakppeUQAG1na7WMyv0ErGpKspdgI?=
 =?us-ascii?Q?Rrl0j6fQ1EezJmUxhvvDA8ZkPhU+B0yuHDayxNkdiPU14IPJtpOT+SBBcCd8?=
 =?us-ascii?Q?YjqjE9xbpbLjc9xNog8mAE4ZGxZwNZMuinqqdllJh7Y55BOc7Agf6Ev/54yT?=
 =?us-ascii?Q?UZKiYw35NfVsOnJFi8ZciQNlsGsiswPerVbmkYcng+ondOKZIiu55ANoNF/r?=
 =?us-ascii?Q?v6IIJDvenvR6g4T2bIkylb71ymM2IlvsWAXmsfZ5bXqqESOusRUVUE9xvA/m?=
 =?us-ascii?Q?gwbGWE/uyWLM3GRBzLCqSfATVr61EjYfn39TraQYQcLthLdtJWy91y1w+6J2?=
 =?us-ascii?Q?HyVcaPvj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa613e5-46ab-4bb4-feac-08d8c6e875e5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 19:34:58.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZsRb4NMKR6FUT4wyaBZeH3uv2YBt7kbqRTC5etjxVK65cwfLzBJOFsVmYYWutMwF6jhrI2QBD3GwPDzT85i6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3874
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010103
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010103
Message-ID-Hash: KDXB5Z4AC4DCWN6ITKISLGPAMTQJBBSD
X-Message-ID-Hash: KDXB5Z4AC4DCWN6ITKISLGPAMTQJBBSD
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KDXB5Z4AC4DCWN6ITKISLGPAMTQJBBSD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 01, 2021 at 11:27:08AM -0800, Ben Widawsky wrote:
> On 21-02-01 13:24:00, Konrad Rzeszutek Wilk wrote:
> > On Fri, Jan 29, 2021 at 04:24:33PM -0800, Ben Widawsky wrote:
> > > The CXL memory device send interface will have a number of supported
> > > commands. The raw command is not such a command. Raw commands allow
> > > userspace to send a specified opcode to the underlying hardware and
> > > bypass all driver checks on the command. This is useful for a couple of
> > > usecases, mainly:
> > > 1. Undocumented vendor specific hardware commands
> > > 2. Prototyping new hardware commands not yet supported by the driver
> > 
> > This sounds like a recipe for ..
> > 
> > In case you really really want this may I recommend you do two things:
> > 
> > - Wrap this whole thing with #ifdef
> >   CONFIG_CXL_DEBUG_THIS_WILL_DESTROY_YOUR_LIFE
> > 
> >  (or something equivalant to make it clear this should never be
> >   enabled in production kernels).
> > 
> >  - Add a nice big fat printk in dmesg telling the user that they
> >    are creating a unstable parallel universe that will lead to their
> >    blood pressure going sky-high, or perhaps something more professional
> >    sounding.
> > 
> > - Rethink this. Do you really really want to encourage vendors
> >   to use this raw API instead of them using the proper APIs?
> 
> Again, the ideal is proper APIs. Barring that they get a WARN, and a taint if
> they use the raw commands.

Linux upstream is all about proper APIs. Just don't do this.
> 
> > 
> > > 
> > > While this all sounds very powerful it comes with a couple of caveats:
> > > 1. Bug reports using raw commands will not get the same level of
> > >    attention as bug reports using supported commands (via taint).
> > > 2. Supported commands will be rejected by the RAW command.
> > > 
> > > With this comes new debugfs knob to allow full access to your toes with
> > > your weapon of choice.
> > 
> > Problem is that debugfs is no longer "debug" but is enabled in
> > production kernel.
> 
> I don't see this as my problem. Again, they've been WARNed and tainted. If they

Right not your problem, nice.

But it is going to be the problem of vendor kernel engineers who don't have this luxury.

> want to do this, that's their business. They will be asked to reproduce without
> RAW if they file a bug report.


This is not how customers see the world. "If it is there, then it is
there to used right? Why else would someone give me the keys to this?"

Just kill this. Or better yet, make it a seperate set of patches for
folks developing code but not have it as part of this patchset.



> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
