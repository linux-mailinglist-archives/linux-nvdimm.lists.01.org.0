Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1615E30AEF9
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 19:20:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BB68E100EB324;
	Mon,  1 Feb 2021 10:20:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CDADD100EB325
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 10:20:20 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111IESci139830;
	Mon, 1 Feb 2021 18:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=laeAtUecp3TIKpKhO/1Rnd7cQcHwnEo4AXdo+IXkIXs=;
 b=nW/kPVt8FqBDyn4pUJ+TXuIXtW0atdkwUXpp0Mwh1oh0pujoRdpZzIpAIbcDQZJLzPVP
 W744lzFHxtuSqxsLW+kQgTi8hIh45oS3PeGzN+EOYiAFfC5rUNJZyfOhI4M21srkP5on
 vRPWDFs1fO3O41w8jKXpEXccUHqmBMMVmjgvrui3Q941miERKBYuui+rNnDKfgVZx8TY
 2u9XNlT67tfepainB/1/8SBsvdTGeuUZiq83wEceNRMMNOmAkf5ck0z5SsaBvRhBwzap
 y1Do+8SsXCshgQhMz4jmZQyfZabqwGNCc+wBACxxpsicZePFio2a6e6zJUhmkbGCBoVh Wg==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 36cxvqxseu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 18:18:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111IFRKV057559;
	Mon, 1 Feb 2021 18:18:52 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2055.outbound.protection.outlook.com [104.47.46.55])
	by aserp3030.oracle.com with ESMTP id 36dh1ms450-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 18:18:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je9q5Qvvt9rDw0CQ961EcImWruWeVFfx2t3ZPL9Q/D1TwxZr5jqAfUaEpavLaRKD1dNNG6rKmO43cX8a3fFRhPeaZzfNOLVgF7xNBAV9yGWFaWWF54pamxCaq4O2qNpT8aFxt+AEDo5Ta8vud6ZvatGYdxeaaK925fG1sqRZ32WPBK0KqO7t8weWFV86k2a/mTPigtEQ2a9bMtGcmDTiFmO6GXwIqj6gCkjK1qv8jGMf02/YRXrjLpF3XiTtzXJO4VifnSHRGyTHnnZb3IpjDFs+q/tIAD1yf/SqpbCW7Klu6J79c3PpIHY3E1G0YctZLFcPewMtqVgd6PR8zJxaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laeAtUecp3TIKpKhO/1Rnd7cQcHwnEo4AXdo+IXkIXs=;
 b=J0qlFkvdOiPi+kDC5EtCzhgoweffblxsbULlH8DsKBFZYYCcPEF5F9bS29prQTr9TzbJ99YP8RrxZIS436f2bfev7VejeWMyCHqy60pj21AP6udonDT+hsNClcUbr95JFcTu/khdJG2vM10zLalv8XL8miboPKy25rwoXPZ6xcQe/5FAtQtp4oZnhL7uaZxsi2NIj0e1czdLr1BIaN5xQXB1DtmdRlFRBgzpEawiKMYqN0YYu7KMxsZ9YMGR5IJSQ3XFtrzFgdnRmtrfIwt5j5BI48Op6OTHss8vYOoxeUgUz2CFzg9I8gDbVPiaJKloLSCk8ZyaC3wjxKlamOduxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laeAtUecp3TIKpKhO/1Rnd7cQcHwnEo4AXdo+IXkIXs=;
 b=j5gZNJk2MNh0rsoRxfeRn1DJR0/xRbz9/MshbBzQAJw1T/1t4UswBFnBtZb0r/wzOv1Mt6JVu2xRMqQQ1Dd9r+2qLuTvARcgZzjaqnx46czAkpf1caohxfZCJY1yW0P+Z2mkgGYCaP7tObSS+BTNyIgL3R2zM2qFUNAvjxzRbPc=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.25; Mon, 1 Feb
 2021 18:18:50 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3784.019; Mon, 1 Feb 2021
 18:18:50 +0000
Date: Mon, 1 Feb 2021 13:18:45 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 08/14] taint: add taint for direct hardware access
Message-ID: <20210201181845.GJ197521@fedora>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-9-ben.widawsky@intel.com>
Content-Disposition: inline
In-Reply-To: <20210130002438.1872527-9-ben.widawsky@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: MN2PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:208:23e::9) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (209.6.208.110) by MN2PR14CA0004.namprd14.prod.outlook.com (2603:10b6:208:23e::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 18:18:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98a708ff-7bd1-4674-a84c-08d8c6ddd2d4
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB26639C450004DE90F39F068C89B69@BYAPR10MB2663.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZLuBjSotqmSvUCvhvCj4thzhgV8C2co1iX1KL3DHY/nXpqmiMURV+BrP2zghIZp1Y0fzB6Hr+3C4fPOIQYWfDon1I+u20UUXdvo557dvWYvL/eh+Q2Qmfl5/sWpkzKpv7wVZYYJp9YM5V9ZzmSQezZ2PKpmDNBDEbew7lrb42vnPKdGEFf9JKIGq0Dx3Fb71Zpos1iHYmrYxAKx3CfzAZ+XwNLlPM9ftZg+mb/Cz4fWvTmncWJvaFgGOS14q+ikYPHKhYuBFOScWwZEmAhpLCmsmpiJP7MFMlJXIMI4RpxmXfiK31+bgIYOmYjd+ln24UE9ZWMMNaisbxzrIdsDupxW3sjwOn+4G60TJ8W0sJQoTu41GLsNISGcgKmnQM6saIpNHftuPkhLJV/I4Vmh6rZ18uRyw3XCSvR/W4FNgVKy5yxeduzNN7eg71oBUzgeoD9VKlW3G4WUwea6LUE4uCzYpQ1J2KGlSH5Vetrsu9IVkJjfsWqJj/s4aA328PdJEp4okGVqCTaJpHncleQjt4g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(366004)(39860400002)(478600001)(26005)(83380400001)(6496006)(4326008)(9576002)(316002)(66946007)(5660300002)(2906002)(66556008)(54906003)(66476007)(956004)(33656002)(186003)(9686003)(52116002)(16526019)(55016002)(1076003)(86362001)(7416002)(33716001)(8936002)(6916009)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?SWHmi8qChy6WQUszWVRdSEpJrj0NAn1ft+20AnirfM4HIKevbLZCtEPQHYQA?=
 =?us-ascii?Q?U0hwhqOUNZAgpWngO+qV2aRNphtMsR3lmZv4rM2elgc9Y4M1qwuBxTs4VWr1?=
 =?us-ascii?Q?gYXs1EvbCfAfxpFOeToer97jRjBQHxqfaZ+4JH/+A2h67/DaCxwvUSpluJS8?=
 =?us-ascii?Q?oATmTUf02Ns+xuIWKkKdcH0RDoTFzdzjt5pRAYqmkSLhXZfOWNLjFZa2UmFi?=
 =?us-ascii?Q?1pY+PJIxkmJVm7T7qQkGotr6UUJVBHegwb3my2GxC7NUUI7AYdebPXffaIPb?=
 =?us-ascii?Q?8i0Ae7EUC/bC673pyjrGUDtkuToFL5hUU4BoCsGYgFLE/KPvYIIJeB0gXfxX?=
 =?us-ascii?Q?/VJzPdai/WGcz94PlanSYX3ApJRh5UvijpqoBI6GPRroACiTwe2OFoNqGa8i?=
 =?us-ascii?Q?aYQoQnKt9EEnolapo5LChwmADAgnutvi27friqDOFZeOHc9qBBUbP7FlQQz6?=
 =?us-ascii?Q?R+sj8qqZEmPRDS/jMR3Yso8b3xMBYzVD1dRB2evKALBwJirEwhCp/p74DCU0?=
 =?us-ascii?Q?gi7Pl8ZZTuTC93u4dujwMYiHOLha6Z8Papm8l7Xi3PmBR2OCp7CFSVRWBo4b?=
 =?us-ascii?Q?2OFS2Ch3pUF5ZLmlPr7x/JtFsySXvUGyGwfVsKdnawpAx8wJKDuyc8fJ/Jph?=
 =?us-ascii?Q?55nMqx4UcwQ3FaiWnT9EzmKFaVNXcfVtvj0YoqxOpLJblLgzTqqpyLIlrZ0d?=
 =?us-ascii?Q?QYwRTJH+PX+EJnOFqaQ6Eq5RU+QB84xnSoNuvtt5rz7IzlYpxXQ3g9ZjmpsH?=
 =?us-ascii?Q?hN2KzlANDYieLOkTmR63IZJ3SkQQ1U17FVyujUVXMahCbh2+sOiPieqhVAwD?=
 =?us-ascii?Q?cmNYkHZ5LgrwivdzI+ay2l3gtdN+WdLKfBTi29UAy0X0lOb68E1PtM9CG1CN?=
 =?us-ascii?Q?m3MvlJVCc3X/QB0Z+2KKiFRvgaB8ZSSA6ez41dKY7vhkV3id7qPlvQ+3M7jb?=
 =?us-ascii?Q?VhZ354CPO6ZYpl71Dr7Bl437VVKSIT0QENKE4PLSUUoU14Af3l+U/surm7hU?=
 =?us-ascii?Q?5jGiDOLEbcady5zD+7qvq58Ru13CaejsEziXXgN/CDwzLteeVPGuAUJEIvDn?=
 =?us-ascii?Q?RNPbXr/w?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a708ff-7bd1-4674-a84c-08d8c6ddd2d4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 18:18:50.1698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRIcKceMbTWksFfPgSQS1+uBSv8t/s8tgqoMSE35hIZgoNmicn9A7eFkDeunLAz6Fwpf/uJwDXKRIy+CDQmBNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2663
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=862 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010095
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010095
Message-ID-Hash: ZBHGF76SEVG3IRJLAWEARXAGX545334J
X-Message-ID-Hash: ZBHGF76SEVG3IRJLAWEARXAGX545334J
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZBHGF76SEVG3IRJLAWEARXAGX545334J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 29, 2021 at 04:24:32PM -0800, Ben Widawsky wrote:
> For drivers that moderate access to the underlying hardware it is
> sometimes desirable to allow userspace to bypass restrictions. Once
> userspace has done this, the driver can no longer guarantee the sanctity
> of either the OS or the hardware. When in this state, it is helpful for
> kernel developers to be made aware (via this taint flag) of this fact
> for subsequent bug reports.
> 
> Example usage:
> - Hardware xyzzy accepts 2 commands, waldo and fred.
> - The xyzzy driver provides an interface for using waldo, but not fred.
> - quux is convinced they really need the fred command.
> - xyzzy driver allows quux to frob hardware to initiate fred.

Would it not be easier to _not_ frob the hardware for fred-operation?
Aka not implement it or just disallow in the first place?


>   - kernel gets tainted.
> - turns out fred command is borked, and scribbles over memory.
> - developers laugh while closing quux's subsequent bug report.

Yeah good luck with that theory in-the-field. The customer won't
care about this and will demand a solution for doing fred-operation.

Just easier to not do fred-operation in the first place,no?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
