Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D9130AF2A
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 19:26:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 792C7100EB324;
	Mon,  1 Feb 2021 10:26:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 86963100EBB8F
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 10:26:23 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111IEFD8139697;
	Mon, 1 Feb 2021 18:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=l60f08n2UUQ9F7F3myeI2FXfLaXXPiQ5alJJSKZvH80=;
 b=LBCr0/3WVhQl444e1NQPWB3C0vU5e53WYhZXU+RZn4XLfkaVJFz3cjWm8jzWvGvRIhT5
 75nvBupyd0qJmU3vLmnrrwFKr22kPkua9pK1b4NGc3XX26rKzkL3TI42x/8E6M4QF/7P
 ZkavPwbTu3rAxLJnADX9DH2y2Q6HuL+oZEscgHb8fHF+LSO1NzUuT2DiQyatfch6XW0I
 MBHD6IGZJ4cMl2u9SouVDi6oxCPm9cB4Lzq9hQEZ+u+UnZdOxvU30DGNLPvUJadTea24
 vaPEobGG2a/rNZ1CAaqV8POXTxAqQeHxOjjb65T3UbFCT75wyBgd5NVPuI1S3TU3L/MP bQ==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 36cxvqxt7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 18:24:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111IFRRP057545;
	Mon, 1 Feb 2021 18:24:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by aserp3030.oracle.com with ESMTP id 36dh1msbuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 18:24:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWkqEZtd3OIeluG+4X4rhE54rgfIb06tXmSzdTThvnJBGeq2AHfFYbf6RJyy6yD8K+e2DHcDIVytPTPQZYcLHDO4/IpFlYSwYl30a/bQma/Li4m8QrYqFQUwWLry62OE7wcdgHOZgedG+8z7zV6QcjpeZcCy5IQyL8rSSeSIoJsX6G8/pHN1SMYRHqHQYwMrvNVd8ZY/FMo/R9A9OBg09C/2TyhrKbEHWlbs5fi/49XrP1rH0SXFqjxQTDrV+D3I8Y4DPnPI2C5jumD71KRqSTP1rrzRcN3jPmosIBLdCiW2Un6aQPQA+NFT72QDIotYjRtS4NjBPVAwyTptIWb9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l60f08n2UUQ9F7F3myeI2FXfLaXXPiQ5alJJSKZvH80=;
 b=F9ON7cEsf1087McSMSkMUR3qbCpU4fvsmHLCunfgRoHHW+TJoSuERM1ACi6Yuhy/BUvRQJICLxhpzBODY5Wk+imuMPHSVfSQ1M9be/pxnkFMUwaF8awLuWCh/SXU5fOGvcaNB1sriksSxZX2ZGThlKaek+sDqn319oYI1cOB8uOoHSb6JeweLVuJveU7SUJJX2KaLRlOfqzs0ipmXaYqodPho9l5oc8xbClTD5/SyM1w4jyqUuW6+0unh0AY1V/pSiLQIG13mVc8n/qrhoik+bFtOb7+0xf7Q7qIh0prhTmuCzqRmk8OPt1/Ifl9pbpvmIS0d/Nrp455O9BLsvlUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l60f08n2UUQ9F7F3myeI2FXfLaXXPiQ5alJJSKZvH80=;
 b=SPA0d3qXkIMDwOb3ocqYLU6EFcdhPUUld6p87yD1GvhXJtlxb5GkhXtefCCikPa3voceSIEXTkvfH4zraQk5HqaOGJ2LjWMX01hmWM9fuL8p3HS/8rCtsoc/xyB+lox91pNwk2TfxWVs+dQA1WCN5XP4aoUJbxLAuaQ5NPpXEjs=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB3592.namprd10.prod.outlook.com (2603:10b6:a03:11f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 1 Feb
 2021 18:24:05 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3784.019; Mon, 1 Feb 2021
 18:24:05 +0000
Date: Mon, 1 Feb 2021 13:24:00 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 09/14] cxl/mem: Add a "RAW" send command
Message-ID: <20210201182400.GK197521@fedora>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-10-ben.widawsky@intel.com>
Content-Disposition: inline
In-Reply-To: <20210130002438.1872527-10-ben.widawsky@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: MN2PR22CA0010.namprd22.prod.outlook.com
 (2603:10b6:208:238::15) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (209.6.208.110) by MN2PR22CA0010.namprd22.prod.outlook.com (2603:10b6:208:238::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Mon, 1 Feb 2021 18:24:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d461fed-002c-49e3-9ac4-08d8c6de8e80
X-MS-TrafficTypeDiagnostic: BYAPR10MB3592:
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB35929DAA0162FB50D3D0B66589B69@BYAPR10MB3592.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:517;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8fYLKQYRUI1hSIiCIiAi9zeWolG5+hrEaxbHatdmIhbu/FLOP/KgePAgoeBtdlyZZXxoJTWQFvNfvpEexpqacdnz/PKbT3dmTfT5bzOvaUXLvmhKJdtPHNv9hjsIectS5pTmlVMMhJOeKdmhVGTJgzCtUChDV99m3xzlguPJe1fLSWbhD0ku+rqIWQmxuIvVW9Jn2G3mJBvvw5mxAYKY+FjeL1IhmWzmSOCfzWaggdTAc8NO4Wf6UvOJSl2TiLmzow59xpc3s2XfJw+MpOlhO96F75rNlQtab1QOI0OrSQUbkMcbjg5JD0KaNn0LaifnVQSAjqPZP/HQ0oiZDZjgYVXxjyZ+cASg0IRatAdRnYmAWB9P50MQ3mD606f5G1mbKByFP7MkTX3ndYchhNoItn8am0fyYs/6G0qslLtLe9ltKZC9xmQh/FCAT0AGxRkBCN98/zB9FQH+YGddJR/kAL50zXoeFKfe38g0WzrRjYan2/IBSBwf6MLCw+Q0QKaMA3Ngoz1uy3Fq5I+ApvXTuw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(346002)(376002)(366004)(186003)(16526019)(52116002)(956004)(6496006)(7416002)(54906003)(4326008)(33716001)(316002)(86362001)(8936002)(66946007)(66556008)(55016002)(66476007)(6916009)(5660300002)(9686003)(9576002)(83380400001)(1076003)(478600001)(2906002)(26005)(8676002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?knjkINRLpew+T2+ghIBAvf0NYHVEWFS/xsS/K2MaUxyHLYkAlHqQy1mU5ITo?=
 =?us-ascii?Q?rf3RS/aQYn9GJRA4+H6LQbuu9SQRQNASVFue9S6N/Unyq4KO1YLhAqPZzj4Y?=
 =?us-ascii?Q?htDLMXKhTcklg0bpGmgO8svp72YWiQ36HLW4L8QJPQm/G5piYG8Plwkn7J5v?=
 =?us-ascii?Q?rTAuo10ADs/nXuNnYbWVC5nV5MIUgBUnjPzNJwGfef/py9q1fr1Fmg6rnhH5?=
 =?us-ascii?Q?mE2yxy/kzDHCxOG1rjoHTZpt4VhOHCxsS8QUuM6iQLFcAzjW2RTLm6ZcxyN0?=
 =?us-ascii?Q?7ANhc4zaXE7cc/SuTLzXLALRpn1EMdSnyoJQjbXdgtD3W/60qqLd4ys6bAe5?=
 =?us-ascii?Q?mSMGTRLE8x7csKe41kt4DEeZM9AubqEqC+d8ydZ0R3Rnh20TgOVemSgH9KY1?=
 =?us-ascii?Q?dXQpAW4ptxCGdxkjHSmTfoD56zKj5equI0WrkIea24ZIipnI9fGAN4D1RTTU?=
 =?us-ascii?Q?E8BsIuaWxvbmjWzoOOrLcIwzxqqy1Xio6UgjwJK+tCZAuI74aY2jFJ/whLrO?=
 =?us-ascii?Q?8ZzlYNgwdhrivtBtX9kQsb2n0S0s+CzFM0TcXXx0jxjqX/MNOG8cM0O1CCyB?=
 =?us-ascii?Q?sLYONj93/XBxsx5cuIPQXTQA9rF8e1DPu+K+/bfgUsiT7NsFJ4JPk2KFWQXh?=
 =?us-ascii?Q?r3Fz7pxqmAHZ/mBPR/IvVsMbKmDl+ZR4kEfeX+LTRV9KekugFgGR4QibLPfi?=
 =?us-ascii?Q?DdcNB31ZZAqhhz5tuNoi1TwMbUJT8jzxGUf8abFhS7G8Hr43UUUEaLFRd3O8?=
 =?us-ascii?Q?0b+NiE5A7ey7DDGElFoZ795vDSgge3HTN4EJnn2UC5txsDHQnlayUwh1agdE?=
 =?us-ascii?Q?5NRFZ9GzE2Ojm3Z97b5+oxSmwAXNaiK7V2fbMEClJTkOl1SG7C6lRJp9ZFhK?=
 =?us-ascii?Q?F7WwCDF6aeqoFzcycJzHCDWVr+OaDzbF9ixH935RbfJIAwBZPEUUf36cb0q/?=
 =?us-ascii?Q?g0p4Lz4i0i8ZZX5+eWw8vRqcQT+2c0LGP4BGoqNnMBakugg6q20AAe1Goce3?=
 =?us-ascii?Q?Y8oTnyhlCw0KsDCM5v3Lfin9+7IQpBHvDqymVBrQ70NaHPx1s3rPM7ckERbd?=
 =?us-ascii?Q?u29oMIme?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d461fed-002c-49e3-9ac4-08d8c6de8e80
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 18:24:05.0306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcK29ybDpcmjYVgqwbtQzSnSoxajqTbxpYMTfCZHDg92TTRoXk68DT7E+Ou+CmU2yIgyuj6n4brpx49YiBmmoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3592
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010095
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010095
Message-ID-Hash: JS5PRISA75CSP4J5ZPVJ2RAEM25EKV2Z
X-Message-ID-Hash: JS5PRISA75CSP4J5ZPVJ2RAEM25EKV2Z
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JS5PRISA75CSP4J5ZPVJ2RAEM25EKV2Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 29, 2021 at 04:24:33PM -0800, Ben Widawsky wrote:
> The CXL memory device send interface will have a number of supported
> commands. The raw command is not such a command. Raw commands allow
> userspace to send a specified opcode to the underlying hardware and
> bypass all driver checks on the command. This is useful for a couple of
> usecases, mainly:
> 1. Undocumented vendor specific hardware commands
> 2. Prototyping new hardware commands not yet supported by the driver

This sounds like a recipe for ..

In case you really really want this may I recommend you do two things:

- Wrap this whole thing with #ifdef
  CONFIG_CXL_DEBUG_THIS_WILL_DESTROY_YOUR_LIFE

 (or something equivalant to make it clear this should never be
  enabled in production kernels).

 - Add a nice big fat printk in dmesg telling the user that they
   are creating a unstable parallel universe that will lead to their
   blood pressure going sky-high, or perhaps something more professional
   sounding.

- Rethink this. Do you really really want to encourage vendors
  to use this raw API instead of them using the proper APIs?

> 
> While this all sounds very powerful it comes with a couple of caveats:
> 1. Bug reports using raw commands will not get the same level of
>    attention as bug reports using supported commands (via taint).
> 2. Supported commands will be rejected by the RAW command.
> 
> With this comes new debugfs knob to allow full access to your toes with
> your weapon of choice.

Problem is that debugfs is no longer "debug" but is enabled in
production kernel.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
