Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3E830E23D
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Feb 2021 19:16:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 763E4100EAAEA;
	Wed,  3 Feb 2021 10:16:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BD8DB100EAAE7
	for <linux-nvdimm@lists.01.org>; Wed,  3 Feb 2021 10:16:14 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113IALCl121866;
	Wed, 3 Feb 2021 18:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=g1beYCRtHQ+7eyet6gw/AH4AqA2dBKOVEjc/R55Ly5I=;
 b=eV9ZKkhP/yV/MF/dRqr508suYDMFQEQeyM4zcBcl/rp/tjVgIogrzsPHeCH2nnbGiiiC
 ZYqSzgx0fnm7lKMO9HdEvE26xlbCYB2CsSq6DRdFjLHi7H/ad6VssIoTwQSf5kc75wZM
 TxvMc4IeUfpZSBVEvp5nQboNs4JQ/Rs2O15OezVTFYXIlnFnAAN0QInOockx5qTrRmmR
 jYU87xLHZyFpJL4o+dGBj80EL84eDbw87C05JyTzeOt2Pk0KV2Dpt8LtAWx5LJrBw9bn
 5QIKZB4+v9bCCCDnZguXSSdbTxUPBuMxFHp4K9k5Qtdcl76BDTXOuGsXUmT4R7StPdpE GA==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 36cxvr47na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Feb 2021 18:15:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113IF2nG143446;
	Wed, 3 Feb 2021 18:15:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
	by aserp3020.oracle.com with ESMTP id 36dhc1gwu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Feb 2021 18:15:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8LcgC33KTF6m3RCogoNKlJOiUcYZiDzudHIIUMFQM/IyFXJ1X7mw1samfpymXJKaXve3Bt7YnyWOy0NL/GDG6eXaZjWxsQguYRvb7hN45TaKSWh4YmVtyBmW4/0vAHarn0nbaTzA4ckLwv+57VR7uAJm3WGFWIGFFaqAqxyaON1gpK7hSPk6qB884OGA4sn4Ay6z5RO9TM8u1nPYUY2h4ox7cqk7vOzjABti51vabYUFOmMSo3RBoXy7vecVOFS2/P+yh0NYsYLu/UC7ee3Es6RTpfZjSxZFhMVT7zAIwws5/FDnprXlsbUtJI/0DppDNb6bu5G5WQ8QEIIu8SttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1beYCRtHQ+7eyet6gw/AH4AqA2dBKOVEjc/R55Ly5I=;
 b=FpUcoM4lcKJH7dlAAjTEMflsMwDE6c+/jgfUu8x27bRrN+VWRbcmD4shFBJp6mMvwOkmjU3eNSrIDEKOQlDHY56uThL5zoWDYlDxRQczrlAWA95nLz++jgilxJARGr1e6x9TvCAlgRVipGFdz6etxZe6QomV1SFzaVhDEu9FR7PfpUUnpz9uilJDeG6+8+ArcV6rjyh5OF8kMGAQetI391gTvDWk1VKv36rlZp9oH+tzGmU3Cw/4nJfrj1aTIA7sbB38uMfqJ2ygsSysVu13ao9TndOxNQKBfikKMpqmJSzDlsYLFWMbG7SzuuknxIPCMwi9HCm3CH9xkux4zqy74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1beYCRtHQ+7eyet6gw/AH4AqA2dBKOVEjc/R55Ly5I=;
 b=Nc56UhndAdCMa48kPj6ijlkdJFGud5Pd636oGV/TexDVdXXSD1NwpbjL975DpyAz1aFxW5M+8llgmyoV4toICpV9WMzv9I+aBNxA01Ak/jew4R2RoYcyS1ofus8SJhYX4zl4dZY7gK6WcYq2IlK9G2Osdis30TezVnbARbVsKK4=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB3445.namprd10.prod.outlook.com (2603:10b6:a03:81::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Wed, 3 Feb
 2021 18:14:59 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3825.019; Wed, 3 Feb 2021
 18:14:59 +0000
Date: Wed, 3 Feb 2021 13:14:50 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 13/14] cxl/mem: Add limited Get Log command (0401h)
Message-ID: <YBroGrVd76p+BF0v@Konrads-MacBook-Pro.local>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-14-ben.widawsky@intel.com>
 <20210201182848.GL197521@fedora>
 <20210202235103.v36v3znh5tsi4g5x@intel.com>
 <CAPcyv4i3MMY=WExfvcPFYiJkHoM_UeZ63ORZqi0Vbm76JapS8A@mail.gmail.com>
 <20210203171610.2y2x4krijol5dvkk@intel.com>
Content-Disposition: inline
In-Reply-To: <20210203171610.2y2x4krijol5dvkk@intel.com>
X-Originating-IP: [138.3.200.57]
X-ClientProxiedBy: CH2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:610:20::22) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (138.3.200.57) by CH2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:610:20::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 18:14:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6a8d3d7-aee9-48ce-6df2-08d8c86f9e11
X-MS-TrafficTypeDiagnostic: BYAPR10MB3445:
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB344535FA43FBD61E277C2C9489B49@BYAPR10MB3445.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6QNx7EYGPFre2pyyIitD1VXx/8C4Ooc7rgqKUrno/+nbpgi4WzRGpsyPQdrtRM4R3a3UbcXBjAHxkbHXkjzb98r6cqaSvf/RkQ0G4pgvKcNWFkv7yUD1i6ZZYC5t7eAR4vBz2Yy0UsQryWdFraHJeZeg9oMsG08b36dG2/ecN23PrrYp1MXvfl00/PDxXBpcxcW3S61amJWKWUXqtO48XTCDYdfl+bDPyxF+Z1z4wFWrrdbLy6Ix0SWrJvVTWmXTpGulf2Y5anhEFoZiLT/hlyuCzBIWI5dGyNbCOq8o8eEz/LxUYsX2+QFWrs8xAgiDpFG1t7DYMjDz7dOTtPIzi9QlSnQk2Xi9E3/ui63fsIYcFIEMJWWzSp5hwT3FxJPE7OJMRgMEugfQEeHHd2x/Le61cLlt3MslI0W6UljkSMf1p/MMndqmHZ/IGvEKghJ4qLcRYPQrw4uPB8G/+Y0XdPIzUNdMn36EV47N7c/Oazp1WpKq403P6daNQC4wHpgn8MGSp7W1x+awf9ErziK9yiaistMHYdKuLjXDrNte79Ooh+Lp6JUOmdYoSP8oyLFa
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(366004)(396003)(6666004)(54906003)(55016002)(956004)(316002)(7696005)(52116002)(6506007)(7416002)(26005)(86362001)(66946007)(66476007)(8936002)(8676002)(186003)(16526019)(5660300002)(6916009)(2906002)(66556008)(83380400001)(4326008)(53546011)(9686003)(478600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?LbNa5+82uIdTO2xZJcLFbYGxcGebDkNJlRXe3Og7AIPFRKL9EaCNOXBiahRN?=
 =?us-ascii?Q?BcPenfV6al/j+GVjFuB7ldjZDCBjJPF9+ZvyJ4XeU/P2vQBAVDRo7pXvI6Z3?=
 =?us-ascii?Q?g3UVl6t1Yn/GvCZoi08i8ydN6M8Phe2xzVAu/Gq1YHnzlTGlBTe8Nzl6xPOG?=
 =?us-ascii?Q?nL78JlaZnfSki7Xv6kyjK/6+TH6paymTmyAfCavcpC2t/w4HTeft18kDPfv1?=
 =?us-ascii?Q?KTJaV4B4SCTWfLhsc2TnMIny6ZJeXaya/I1x2yDZh/N1SzAR1RC+GycI820M?=
 =?us-ascii?Q?T39xcYXwtUpgZIW6yH335HcTg1bXZ6k5RJ7H+yahO2XJMq2tviNH8UUMSjl1?=
 =?us-ascii?Q?KZfdDXp+wKmX5HJR9LY0QZ6ae550yklvFrykPIo80tIqA+DgxURNmCwVNZhV?=
 =?us-ascii?Q?lJQZYqySSXDco5YKFM75xFBYPRbngKe8SmSzI0Shu/WbkmmnF1r1jLO9qlkk?=
 =?us-ascii?Q?DcwOkDOKom3tjmBHy49MTirb54LoXSk/gFjpdHPEYnkEUXe12JXPsOw1F07A?=
 =?us-ascii?Q?Ksvu0Rj0D7YZA2vtk+7Txk19I1VukwFWU33IH81SG93Sj0iRjvTuN63FJvTG?=
 =?us-ascii?Q?K8rUnrbhtciqTBxq/K1dTFDUVFFlM6HXblAQGM4ayMNJQzu3WC4JHq6M828m?=
 =?us-ascii?Q?pO2X1BWjrHTyvVMzc4JUIxhGebmHbbZIMzLhqg23B470WdQ3chgVh0FH5/QN?=
 =?us-ascii?Q?BDYRsa3oX2jxqiD2FpIqzmcPXCsUxr6DW5jILfIsSSvTuWavv33X+yvnCIE+?=
 =?us-ascii?Q?jQFqqigSTIUmp6Yq5Qts5/LHe9ARhAxLM+qZDdQvR9hGEvni3EmPrG36ygiZ?=
 =?us-ascii?Q?Z1y1d6Xv0bWB+tfd4xuRkjOafHncqXg9HL8UBoaUhnh+XotHPCVFgS0HtJo+?=
 =?us-ascii?Q?HjxM8B5Z1vV8NrFF7GFaaaS0150JUJbDE7Lg+eRbcXTyvUJRAy9J6vaAv/2w?=
 =?us-ascii?Q?u2YvSJtT6HEr/k7+MCg0fu/Si0I7WHwLsJlB/a8wA3kKHds1rGfEFKXFbPt9?=
 =?us-ascii?Q?MByT7JinJ3aTPiYdOw5kBJKs+L2N6f8yr36fLIhApYf4H48nPoS5m1M+pX0A?=
 =?us-ascii?Q?XKPIeSli?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a8d3d7-aee9-48ce-6df2-08d8c86f9e11
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 18:14:59.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTlK/NzN127osddV6eaOvBemrej7AiBA8zzaWPxBQuvQkOSnGhuzOyFMEHeZ8egotfRJsdcl1h4rFjAT35t/bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3445
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030108
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030107
Message-ID-Hash: 6YPC5U5B254MST2A75WJSLHQ7ZRXMR3X
X-Message-ID-Hash: 6YPC5U5B254MST2A75WJSLHQ7ZRXMR3X
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6YPC5U5B254MST2A75WJSLHQ7ZRXMR3X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 03, 2021 at 09:16:10AM -0800, Ben Widawsky wrote:
> On 21-02-02 15:57:03, Dan Williams wrote:
> > On Tue, Feb 2, 2021 at 3:51 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 21-02-01 13:28:48, Konrad Rzeszutek Wilk wrote:
> > > > On Fri, Jan 29, 2021 at 04:24:37PM -0800, Ben Widawsky wrote:
> > > > > The Get Log command returns the actual log entries that are advertised
> > > > > via the Get Supported Logs command (0400h). CXL device logs are selected
> > > > > by UUID which is part of the CXL spec. Because the driver tries to
> > > > > sanitize what is sent to hardware, there becomes a need to restrict the
> > > > > types of logs which can be accessed by userspace. For example, the
> > > > > vendor specific log might only be consumable by proprietary, or offline
> > > > > applications, and therefore a good candidate for userspace.
> > > > >
> > > > > The current driver infrastructure does allow basic validation for all
> > > > > commands, but doesn't inspect any of the payload data. Along with Get
> > > > > Log support comes new infrastructure to add a hook for payload
> > > > > validation. This infrastructure is used to filter out the CEL UUID,
> > > > > which the userspace driver doesn't have business knowing, and taints on
> > > > > invalid UUIDs being sent to hardware.
> > > >
> > > > Perhaps a better option is to reject invalid UUIDs?
> > > >
> > > > And if you really really want to use invalid UUIDs then:
> > > >
> > > > 1) Make that code wrapped in CONFIG_CXL_DEBUG_THIS_IS_GOING_TO..?
> > > >
> > > > 2) Wrap it with lockdown code so that you can't do this at all
> > > >    when in LOCKDOWN_INTEGRITY or such?
> > > >
> > >
> > > The commit message needs update btw as CEL is allowed in the latest rev of the
> > > patches.
> > >
> > > We could potentially combine this with the now added (in a branch) CONFIG_RAW
> > > config option. Indeed I think that makes sense. Dan, thoughts?
> > 
> > Yeah, unknown UUIDs blocking is the same risk as raw commands as a
> > vendor can trigger any behavior they want. A "CONFIG_RAW depends on
> > !CONFIG_INTEGRITY" policy sounds reasonable as well.
> 
> What about LOCKDOWN_NONE though? I think we need something runtime for this.
> 
> Can we summarize the CONFIG options here?
> 
> CXL_MEM_INSECURE_DEBUG // no change
> CXL_MEM_RAW_COMMANDS // if !security_locked_down(LOCKDOWN_NONE)
> 
> bool cxl_unsafe()

Would it be better if this inverted? Aka cxl_safe()..
?
> {
> #ifndef CXL_MEM_RAW_COMMANDS
> 	return false;
> #else
> 	return !security_locked_down(LOCKDOWN_NONE);

:thumbsup:

(Naturally this would inverted if this was cxl_safe()).


> #endif
> }
> 
> ---
> 
> Did I get that right?

:nods:
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
