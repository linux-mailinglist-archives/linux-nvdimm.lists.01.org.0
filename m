Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9A230AEC2
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 19:12:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8605D100EB85C;
	Mon,  1 Feb 2021 10:12:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F2855100EB859
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 10:12:16 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111I8u0A016359;
	Mon, 1 Feb 2021 18:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=uSVcrlnONru43eGF2SVKza1Yq3jkr3APJXB3ZceR/xs=;
 b=YtDyp7zVHxsXh3U/vcxBZHAHXlnTh5owKBBwh1XsJ1UQ/c+SN7g9iefc57amClxRXieW
 W0SPTzvQRYnwoQB7eanTLwm7xOjpCAq9A1grMuxmelcqpmnp1084stTTgefjxGJJ5/Xg
 VRwfqBNJoAqr777f6POVNT1Dn10gDBpc/48BRcxA1Ej/rBbTzPMfeo/YCaHsgAk2a2jF
 31olUn30f5PjddgbJrinr2pjQLkHNgrSfy3j3e28BoCcntoyQY2UJCWxPw7XCag+1gpK
 tp2jqP+zs/fHPKSufFBt9Jse4aaPHJmb0kbmHqAIWjdDQW50gYW0WexnC9ldKA1jzQXd ZQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2120.oracle.com with ESMTP id 36cydkpp37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 18:10:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111I689r035305;
	Mon, 1 Feb 2021 18:08:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
	by userp3020.oracle.com with ESMTP id 36dh7q42dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Feb 2021 18:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inykYB6Xc9+GVkIz6r5m0AiPNnUQgNxCntflzQadvumWnbenkbknu8YcvBrrqA5h1M77RswcqxXc9DZGTemOIjCNl9ISp5/vK3n2k8IZOeZAZ0I9leIwRAenWwbSf2rCN4Xg1R3Wl3K9UeBWlTsrGmDtBAhAbQOyfO4fceZq8SLhtrolQRed96oo8kZZFj17kqMo48GHKmzsCpWKanWFaR56zwAMHLnUk2hvB5MptdbPQ2pJlstl6EzBPphYWNwtIyhWEj92U+5EpHCZ5YMPr9iKc3eNJlbSnGhUHgW/eAIKoknc/UEhfP+hHODdRUw1j0g2aXjMj6jpFWQo9KUPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSVcrlnONru43eGF2SVKza1Yq3jkr3APJXB3ZceR/xs=;
 b=lY2tsHsCK6R8iOfbdIAtE2pEuLLUpkEL8HzwWWQZ3BhaiEN3q9UA8udW2povfvSeZ2vOwgzHgLZai4zJplUdojxP6uXDHNNYpwpauB5DhEJTjs69nAFabPLK51CnWHO6k1NW1X2Y4HoyD+PG3G19Zmell6B5QuFeCeyV4wzCs0VAPDC82fpkPJ9P7IO4pMm8ViWg+0x9TAXoTiuk6ubkowg9775OS2P3PoazniWy6MdMHpyRUqBvQyLPIkLdHnfy2WQ3gTJn9hZEsiBsi0vr9keSL2kh70dOE+mUwEg6TXQAuMezxp7k2xf9H/Cl4+85dIP7e7lmHFZkh/+t6Go3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSVcrlnONru43eGF2SVKza1Yq3jkr3APJXB3ZceR/xs=;
 b=VV9L4c9dl6wOfsWx5cyC5xKuFDNW43FKKSrSwPt4k+J67FFTOyc3YJOSz1BTO5Z7ENSyfP0E07/37IMWyzOjx/bNzDw+jxcnjxhBuTnuZd+tLoyaNPXUMUb9jl/3WzQGKYvn61Ud4nU+ljlWm1E+BGSoQ3DFwqK15kM4m8fu2QI=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4065.namprd10.prod.outlook.com (2603:10b6:a03:1f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Mon, 1 Feb
 2021 18:08:54 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3784.019; Mon, 1 Feb 2021
 18:08:54 +0000
Date: Mon, 1 Feb 2021 13:08:49 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
Message-ID: <20210201180849.GH197521@fedora>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
 <20210201174136.GF197521@fedora>
 <20210201175041.qs56jk5tdbgn2zia@intel.com>
Content-Disposition: inline
In-Reply-To: <20210201175041.qs56jk5tdbgn2zia@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: BLAPR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:208:32e::27) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (209.6.208.110) by BLAPR03CA0142.namprd03.prod.outlook.com (2603:10b6:208:32e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 18:08:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0f83a44-2a89-47e6-2e31-08d8c6dc6fbd
X-MS-TrafficTypeDiagnostic: BY5PR10MB4065:
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB4065514211173C674699F33D89B69@BY5PR10MB4065.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:226;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	i50V+nq6f0Ni2pwtijrSjRoihSoVacMbjVsSB2eSJzYk2X9tr28wU3WMEwdPdt/mSWkXar+YJJsIlUf3FRV1/aAEB/FUTVSDZAWsgq+STd0ZeJgS7PVrxZpKDBnBUdd0GBM1RH8KXUroW0LRYdZ5sdAoKqbC5k0AXV6uiW8hmUB0W+SbiU2HyWvxljVuddCaWi2dFZY1y4h3dNmTEcxcplwQIGJb1IM2dHi+bZSqQZlpVegakswamRSO+aqPnJbnq1fQCRmxjIr1fO6GtTA7LuhilFF5vi11FG5OnV8RQ1urzbVuXQeOaEwwbP/QFFcWnG5CP0kFe0BaF+LWyrm9ZeWPu1w3Xq2A1xUcZHQvnzhQTBDECCJd5mGxMGk5SJ+ZsBtW5VN/+h2OmVVdzRbYLgAJFORYzAxAcuplKvQJyNMr9s2bq9glx+qZ6dGDP/oLlPy/KNMJXxa0cgbHDqz+jwLcIFjrwkget3a2ssZhHMYHwURHICttBtkFJ7Os7w+iRKrl8DIxbf/ChGvu0QvZdIYzRq6uC8c24jNUzG93Ksy16ifhtfTZ1gMT05u2qZMWX1S9/3r0cqZ30bvu4yTBrxGj5WfaysE23ybIIJnvHCk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(376002)(396003)(366004)(6496006)(6916009)(9576002)(83380400001)(26005)(52116002)(966005)(5660300002)(53546011)(86362001)(186003)(316002)(16526019)(54906003)(478600001)(2906002)(7416002)(8676002)(33656002)(4326008)(9686003)(1076003)(55016002)(66556008)(33716001)(66946007)(66476007)(956004)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?Ecg4u1dpIlr8EIo774trpOESjkqaloaHPt4GOSRa4mL1FEFCxGYZ23582+Zv?=
 =?us-ascii?Q?EHSoLph0A6QFrsgd8exnnoriEchwuPhC9MxTRa/PXrygqFtdwERFjkUgUEdy?=
 =?us-ascii?Q?/AkG+CF5kTPxZQnCo6rktw1Us6HYUU+aIBAS4tzYv/TF5CU0kjBoJ0cQ/5bs?=
 =?us-ascii?Q?atwzpWNxXGB0wI5qigzuGdZldSL7p3f+eDO/NmdGTPtfShtxQ/d/LeapEgKg?=
 =?us-ascii?Q?duXS1RSqMNOSojTcO+1lNWjpvtEqbOVxqjuzLgHdKD8cmf5b6r3RNY5Q2Szi?=
 =?us-ascii?Q?VEjlDC6w7omIAd54+3BcCFZuTRiGLExNX0ZpLOaUZlV/bp6RJUAVkPPR1h8o?=
 =?us-ascii?Q?hx+Lw0AxSrnYSzBaS14Y2dEXgB5xeTyoqyBY9yZl77k4fBjc4LB0tcaVPAqA?=
 =?us-ascii?Q?5u0ceIOQDVieQcOGLeyedZi5MtY7xaMeES37Vwf+ojL4h1ewE0mL6oUGGOeq?=
 =?us-ascii?Q?GBeQXvkT6NXbn/KQc8l3VRjGdVOqObCMbR98qwgDHCXnaJK5qIzV4KLdxb3S?=
 =?us-ascii?Q?P181GJpMVcupzDsuTOEsj7daF0427LFGWosC6XwrYYjorlFCVkrcGeMQ4xth?=
 =?us-ascii?Q?9QzLVKFjylGVRJXc2gAmJufjhBsgUhbqksZLF2FQLETp8KXzHeWGLIAcWY11?=
 =?us-ascii?Q?9DuAUR3CTAAr0BQ3KfsSV/WFwhlrTUSwGWS2Yks9M/3Dk8tBow/sduijTgXc?=
 =?us-ascii?Q?RN3MCcgamCo4RMHchV0OB80JZfxOwhaL43ET1Q0QMaJ3Zxy7GeyHtcaW8wBY?=
 =?us-ascii?Q?8I22n0OOGGBALEPyjML3oHITV6Oo6tAAqVAn7f7t6lQbfDKUbOUiEkDQgslg?=
 =?us-ascii?Q?wt2kbmwogGf9TWQWk8bAimvEtQUm/KQdNVacvfbDtb2sw0QYM3JDDr+HghKT?=
 =?us-ascii?Q?bzxxQfIBdnklVgmXVZh1liRVZcJ1NtzdyI9mhPTmYfls0nBjHo/qJgClKv50?=
 =?us-ascii?Q?FDtzi88J0IB1a/z5jW52PyRUpsUobPLN++Y5vR+fC3nK77IEKRWkqn1TQMV8?=
 =?us-ascii?Q?supIketUfXDdz096OfTr7Yea8OAIEbtJ8QFwT+cy8GJMfIOVn4t2cEMlZRtF?=
 =?us-ascii?Q?Y+iyeQDp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f83a44-2a89-47e6-2e31-08d8c6dc6fbd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 18:08:54.5627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZ+yB5X0c0ZLIgH5BFddGm7U4vWECQSa8SPIh24RDw8N9YAPb+E1XeKNadrxAKyCzJwvs+OF0oe9KK5Y+l0dmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4065
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010094
Message-ID-Hash: YILUPZ7GTP32PAD3J5AV2T4JJSLZIMGD
X-Message-ID-Hash: YILUPZ7GTP32PAD3J5AV2T4JJSLZIMGD
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YILUPZ7GTP32PAD3J5AV2T4JJSLZIMGD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 01, 2021 at 09:50:41AM -0800, Ben Widawsky wrote:
> On 21-02-01 12:41:36, Konrad Rzeszutek Wilk wrote:
> > > +static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> > > +{
> > > +	struct device *dev = &cxlm->pdev->dev;
> > > +	int cap, cap_count;
> > > +	u64 cap_array;
> > > +
> > > +	cap_array = readq(cxlm->regs + CXLDEV_CAP_ARRAY_OFFSET);
> > > +	if (CXL_GET_FIELD(cap_array, CXLDEV_CAP_ARRAY_ID) != CXLDEV_CAP_ARRAY_CAP_ID)
> > > +		return -ENODEV;
> > > +
> > > +	cap_count = CXL_GET_FIELD(cap_array, CXLDEV_CAP_ARRAY_COUNT);
> > > +
> > > +	for (cap = 1; cap <= cap_count; cap++) {
> > > +		void __iomem *register_block;
> > > +		u32 offset;
> > > +		u16 cap_id;
> > > +
> > > +		cap_id = readl(cxlm->regs + cap * 0x10) & 0xffff;
> > > +		offset = readl(cxlm->regs + cap * 0x10 + 0x4);
> > > +		register_block = cxlm->regs + offset;
> > > +
> > > +		switch (cap_id) {
> > > +		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
> > > +			dev_dbg(dev, "found Status capability (0x%x)\n",
> > > +				offset);
> > 
> > That 80 character limit is no longer a requirement. Can you just make
> > this one line? And perhaps change 'found' to 'Found' ?
> > 
> 
> Funny that.
> https://lore.kernel.org/linux-cxl/20201111073449.GA16235@infradead.org/

 "If there is a good reason to go against the
style (a line which becomes far less readable if split to fit within the
80-column limit, for example), just do it.
"

I would say that having an offset on its own line is kind of silly.

> 
> > > +			cxlm->status.regs = register_block;
> > > +			break;
> > > +		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
> > > +			dev_dbg(dev, "found Mailbox capability (0x%x)\n",
> > > +				offset);
> > > +			cxlm->mbox.regs = register_block;
> > > +			break;
> > > +		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
> > > +			dev_dbg(dev,
> > > +				"found Secondary Mailbox capability (0x%x)\n",
> > > +				offset);
> > > +			break;
> > > +		case CXLDEV_CAP_CAP_ID_MEMDEV:
> > > +			dev_dbg(dev, "found Memory Device capability (0x%x)\n",
> > > +				offset);
> > > +			cxlm->mem.regs = register_block;
> > > +			break;
> > > +		default:
> > > +			dev_warn(dev, "Unknown cap ID: %d (0x%x)\n", cap_id,
> > > +				 offset);
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	if (!cxlm->status.regs || !cxlm->mbox.regs || !cxlm->mem.regs) {
> > > +		dev_err(dev, "registers not found: %s%s%s\n",
> > > +			!cxlm->status.regs ? "status " : "",
> > > +			!cxlm->mbox.regs ? "mbox " : "",
> > > +			!cxlm->mem.regs ? "mem" : "");
> > > +		return -ENXIO;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > > +{
> > > +	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > > +
> > > +	cxlm->mbox.payload_size =
> > > +		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> > > +
> > 
> > I think the static analyzers are not going to be happy that you are not
> > checking the value of `cap` before using it.
> > 
> > Perhaps you should check that first before doing the manipulations?
> > 
> 
> I'm not following the request. CXL_GET_FIELD is just doing the shift and mask on
> cap.
> 
> Can you explain what you're hoping to see?

My thoughts were that if cxl_read_mbox_reg32 gave you -1 (would be wacky
but we live in the world of having a healthy vision of devices not
always giving right values).

Then your payload_size bit shifting will get bent out of shape as you
are effectively casting cap to unsigned, which means it will end up
being 0xfffffffffffffffff.. and your bit shifting end up with a bunch
of zeros at the end.
> 
> > > +	/* 8.2.8.4.3 */
> > > +	if (cxlm->mbox.payload_size < 256) {

If this ends up being casted back to signed, this conditional will
catch it (-4096 < 256, true).

But if it does not (so 0xffffffff<256, false), then this wacky
number will pass this check and you may reference a payload_size that is
larger than the reality and copy the wrong set of values (buffer
overflow).

So what I was thinking is that you want to check `cap` to make sure it
is not negative nor to large?

> > 
> > #define for 256?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
