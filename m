Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7350930B577
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 03:50:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7F4F9100EA937;
	Mon,  1 Feb 2021 18:50:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 955F2100EA935
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 18:50:42 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1122hcYt174064;
	Tue, 2 Feb 2021 02:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=yd3mYrRFNOCGtysxD/WTTDlFEyjgkWwzlPpu1kV4ves=;
 b=BUi629LH6QEBrSdiChrBL+4YCu4Zg4VwufndAGuOZ49R20JTIa3B54MPc0tu8+Xg/arT
 2r8Zn9/8bKhPQgU+CGZ+3KWvpHdBKLtwquhEeLQ+yvT/hVRvJXsQl5Hsu5BDv6GgC6fb
 sRWIzoJwNer2Se/pOsPOpYxsOvgpxfllpillLz2pQkFZMWrtJsFDKnhom33IA7YuG/YZ
 cyLUTnONE3qWVuPYqNMxLLHzGh3QvYlZd267DeXIfbAGRne/0veqY1a6c2TlWmqCflps
 dDhuBmDhO0A8pGTkvYmED7iu3K4eBGO7xICkoseAeET58XWwTiHnyclzK12w/w9GAn38 gQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 36cvyarp0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Feb 2021 02:49:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1122kAf1167714;
	Tue, 2 Feb 2021 02:49:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
	by userp3020.oracle.com with ESMTP id 36dh7qqpr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Feb 2021 02:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InmEED6mZjNb86JD/YrKdD3Wu0n7R+tv5rM/eGUCdNNkvWe4wIc3E1yLzL1isMa3tQZgKlbWWhCBO3HOCrhbSko8V3EKKMEBuRiqIG3LAc8/vs7dFZTQZDqPZDJVQTTZj9is+j+hy3qxBedleSbb3yF3CPBlUt5mLYYKmritPKuYh1YQOp6u5vEqKGbKlx6agxk1+fVt6ZUvdxZzb8T2eW28ecCRaQOBMMxgjf42xSOZyI42NYkWhcinr73cWlu0emxOiZnKFcdqcL8bb48rPeEOf/hekPNjMKY9hdc+Rk4DjosLPYOKgyE5BbZ8vtyNjD2xqqhBngidbox2w/jpmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yd3mYrRFNOCGtysxD/WTTDlFEyjgkWwzlPpu1kV4ves=;
 b=lK3GWFqq1UzPAzuPAVqnEEqwDlqpbmUJFv4OFSlGbDffbLnmj3MrtFH/gFaj3a2iZQgVRhw8UY8mHb+S8qfOUVNvQaBX5mDp1VZTcKMlCtmuTaQakiSfyPCd9nPfM5ndwz0N4qd0jYZrZ4M/YCiKQoLHPSEusVs/6InfKTE7OFg6yfs/46QyNtVvb1e3jA0OpHYaQf5xShJtk4t/7DXiTiPmBe6VhhR/RE/JU98tuOtH7kexNF7rrMFlW5uDiWloUFX/9RnROWRXK6aZmzwg10zAKwU7JOMNRk8kqCorh2C2xAsWwiXLw1IIRX3r/TsrBeGwmMMbm5CnLc9Ub+2E9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yd3mYrRFNOCGtysxD/WTTDlFEyjgkWwzlPpu1kV4ves=;
 b=hO2U8mwWfxz/ZmZ/OMzgJ7IdqptL/i5GQVVN0PTSqMWX+f7vPmEW4qRQnDO7d6ghWt0xgkkIbhU6y2bhl/mgb8nEtidZbj1VgddR3EIUZmpN7uhOIMYWQrD20ywaD0ZqG4XvAT0HaxY0rLykU9U/2O1bAZIs90vjrArxsz7W9Ic=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB3590.namprd10.prod.outlook.com (2603:10b6:a03:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 02:49:12 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3784.019; Tue, 2 Feb 2021
 02:49:12 +0000
Date: Mon, 1 Feb 2021 21:49:02 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 08/14] taint: add taint for direct hardware access
Message-ID: <YBi9nkiu3DvMZhrs@Konrads-MacBook-Pro.local>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-9-ben.widawsky@intel.com>
 <20210201181845.GJ197521@fedora>
 <20210201183455.3dndfwyswwvs2dlm@intel.com>
 <CAPcyv4iBbA+PCnTg-hFALuDJNqcJrwwXN_gMEe6z9LZvSfC5hw@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAPcyv4iBbA+PCnTg-hFALuDJNqcJrwwXN_gMEe6z9LZvSfC5hw@mail.gmail.com>
X-Originating-IP: [138.3.200.7]
X-ClientProxiedBy: CH2PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:610:4c::40) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (138.3.200.7) by CH2PR10CA0030.namprd10.prod.outlook.com (2603:10b6:610:4c::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 02:49:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33830b42-6c08-4c37-a485-08d8c7251eed
X-MS-TrafficTypeDiagnostic: BYAPR10MB3590:
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB35903CC2DC84B123D66FBBA089B59@BYAPR10MB3590.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1+of07iCReb3ca20U6qstk99VN92on16oPxpQcnYK9cTFphyqXbsDO1RLWWWYt/o05eXsxpJrB+W4Rf80eBIpSjLXcrVg0iTlGiKjcTWlD9ZnTlso4EI4CKTkPFkihBeHINArh4aS2KX/i5FayLi0fy+OH4peSJH4QQQp2ldnlJ+cviNTwSd1cRVs9KE0oGCPNyn9SaAdkKD6noDLncXIvGsR1Czz/mXU00/ka63hAZg1MPi60OIjvzQUczvpzp1kWn0u3sqtdQxVRvUnQSuRm/bfXLdftZ/H0/JtWUkGE2oqnq0pdmy/LCz2vnlh3AHGEx2eAyzggtSy+xZALqV7VGPZrjz2WbytGqS2kHx8gpTc4qvhoQwzypRh+7PUH7Zqb32K4YYiw6i8JacfeAsGODW7eGZLfW6rL4p+KmGA75Wh16lbas34PnxOfIDa1TVK9eKt/CoG7GysFxnC/vWMsZrVqXQnflAwePKXviRRavR3Lby7I6y4qYC8zSgqPVplwjoimmb+Sjhk1ZiggUUIA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(366004)(39860400002)(478600001)(6666004)(316002)(6916009)(8676002)(83380400001)(54906003)(7416002)(86362001)(66476007)(53546011)(956004)(66556008)(4326008)(66946007)(16526019)(6506007)(2906002)(5660300002)(55016002)(52116002)(7696005)(9686003)(186003)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?Ub5nvcR+oYpv+m5Z32MgUp3ZVuMeT+c6Wv3hd2AybroJ+MT7JEhbtITWsnAh?=
 =?us-ascii?Q?Tres+1uueVOcTj3/lk1IwG+gbHFrsYbw5pdrH2lasILjjImWhLD8sX6W26sL?=
 =?us-ascii?Q?1SMcgZgGxW6HoiJVUzxa1um+esCupHE0v50veDJ9JlApQi04oDtQjIF6++if?=
 =?us-ascii?Q?OM665zmCreIujNba2d9vW4y1l7iwEhP+xSM42FlOhI+ryqn9LqAu2GJvts7P?=
 =?us-ascii?Q?8XLe7Pi3XWOMheluvp/pq/Boc+4SNo9DM/djNBmKML5aCj5yXcHHaCkHA/Dn?=
 =?us-ascii?Q?eWfGnLo+vNmWcvXegnqz6eVj7GIDcF98fQm5hGB4uPTNP9s/UjRsw9vUnHGX?=
 =?us-ascii?Q?etPqiR2Q/tR8iwu2pZ2SH7qCqPm4j6XmCTK0nChLhbH1BTzcN1rt5FzQu1a1?=
 =?us-ascii?Q?bBw670Bd+wX7tn+OTfRM5sboCQiMfWY/hQjRxDw2lkzzggAtcFkW8azyk3NC?=
 =?us-ascii?Q?0dFBRGmSsubFAn/AhcwUNtffHfpj69WdDiKfHha1uEN3CPIKq7jQHaUmLNkO?=
 =?us-ascii?Q?Ls49F9NWh3/SuS1OCzuS82vMu3j+HWg5BMlSB5lCCLHBOaNUiEiNkp7NWi+J?=
 =?us-ascii?Q?14m84pCyCMNisH2ijJoltwSKqNjC4LVdVRO/iMSDJhXh1TLPxVVPBveGcH4B?=
 =?us-ascii?Q?wKmcsfiQdwUNkso+QZiO/9X6OxvxNNLs+iGGILD4svr/13967fXLxnVcrxOy?=
 =?us-ascii?Q?TkpwRWPSiXnlJkl7DUfQKZIxn8wVc4Jg1PlqjF9MzYUal2dQsW2moraehxUm?=
 =?us-ascii?Q?jfqRgcvEgvbiSVWUQuUu7YCBfJyobQ9Q9L+Zw5/tCzZKZv/A9W/gOsy6N4sU?=
 =?us-ascii?Q?FFNxBZ4LNVNpZYbLz8mkzoeFbPpTMUehLcc27u9ZdveUHmBzTfJIsbhNA40l?=
 =?us-ascii?Q?OlyXTSL2xc0tRVHBe3Ce3xByx141Z4TOZnI+IF/iTSxUm7oqG9F/BMbda+Ne?=
 =?us-ascii?Q?sEEx6/Og0RwNXcwDYJD2wyU3ptzonQOSq88/YBVeDJbfHsFz2SnLv9/s3rm0?=
 =?us-ascii?Q?0eh4xR5d4nW/gC9AnInxefS9HVV0s1x2/eTl4d/E8B1t1C0ChxmKr9zI99O2?=
 =?us-ascii?Q?iqYsgvjn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33830b42-6c08-4c37-a485-08d8c7251eed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 02:49:12.1482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIAZNqJETkKVx00YJNCIpn3BlUP2ko0AsvzFPzI29/gqXfIn481G0NyKCr0AMQRhxU4uKp0Z9KC6ieXqZ1IvjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3590
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020019
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020019
Message-ID-Hash: BOVH4LO3QYHW4EMS6J4IBAUFZ4OYAN7C
X-Message-ID-Hash: BOVH4LO3QYHW4EMS6J4IBAUFZ4OYAN7C
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BOVH4LO3QYHW4EMS6J4IBAUFZ4OYAN7C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 01, 2021 at 11:01:11AM -0800, Dan Williams wrote:
> On Mon, Feb 1, 2021 at 10:35 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 21-02-01 13:18:45, Konrad Rzeszutek Wilk wrote:
> > > On Fri, Jan 29, 2021 at 04:24:32PM -0800, Ben Widawsky wrote:
> > > > For drivers that moderate access to the underlying hardware it is
> > > > sometimes desirable to allow userspace to bypass restrictions. Once
> > > > userspace has done this, the driver can no longer guarantee the sanctity
> > > > of either the OS or the hardware. When in this state, it is helpful for
> > > > kernel developers to be made aware (via this taint flag) of this fact
> > > > for subsequent bug reports.
> > > >
> > > > Example usage:
> > > > - Hardware xyzzy accepts 2 commands, waldo and fred.
> > > > - The xyzzy driver provides an interface for using waldo, but not fred.
> > > > - quux is convinced they really need the fred command.
> > > > - xyzzy driver allows quux to frob hardware to initiate fred.
> > >
> > > Would it not be easier to _not_ frob the hardware for fred-operation?
> > > Aka not implement it or just disallow in the first place?
> >
> > Yeah. So the idea is you either are in a transient phase of the command and some
> > future kernel will have real support for fred - or a vendor is being short
> > sighted and not adding support for fred.
> >
> > >
> > >
> > > >   - kernel gets tainted.
> > > > - turns out fred command is borked, and scribbles over memory.
> > > > - developers laugh while closing quux's subsequent bug report.
> > >
> > > Yeah good luck with that theory in-the-field. The customer won't
> > > care about this and will demand a solution for doing fred-operation.
> > >
> > > Just easier to not do fred-operation in the first place,no?
> >
> > The short answer is, in an ideal world you are correct. See nvdimm as an example
> > of the real world.
> >
> > The longer answer. Unless we want to wait until we have all the hardware we're
> > ever going to see, it's impossible to have a fully baked, and validated
> > interface. The RAW interface is my admission that I make no guarantees about
> > being able to provide the perfect interface and giving the power back to the
> > hardware vendors and their driver writers.
> >
> > As an example, suppose a vendor shipped a device with their special vendor
> > opcode. They can enable their customers to use that opcode on any driver
> > version. That seems pretty powerful and worthwhile to me.
> >
> 
> Powerful, frightening, and questionably worthwhile when there are
> already examples of commands that need extra coordination for whatever
> reason. However, I still think the decision tilts towards allowing
> this given ongoing spec work.
> 
> NVDIMM ended up allowing unfettered vendor passthrough given the lack
> of an organizing body to unify vendors. CXL on the other hand appears
> to have more gravity to keep vendors honest. A WARN splat with a
> taint, and a debugfs knob for the truly problematic commands seems
> sufficient protection of system integrity while still following the
> Linux ethos of giving system owners enough rope to make their own
> decisions.
> 
> > Or a more realistic example, we ship a driver that adds a command which is
> > totally broken. Customers can utilize the RAW interface until it gets fixed in a
> > subsequent release which might be quite a ways out.
> >
> > I'll say the RAW interface isn't an encouraged usage, but it's one that I expect
> > to be needed, and if it's not we can always try to kill it later. If nobody is
> > actually using it, nobody will complain, right :D
> 
> It might be worthwhile to make RAW support a compile time decision so
> that Linux distros can only ship support for the commands the CXL
> driver-dev community has blessed, but I'll leave it to a distro
> developer to second that approach.

Couple of thoughts here:

 - As distro developer (well, actually middle manager of distro
   developers) this approach of raw interface is a headache.

   Customers will pick it and use it since it is there and the poor
   support folks will have to go through layers of different devices to
   say (for example) to finally find out that some OEM firmware opcode
   X is a debug facility for inserting corrupted data, while for another vendor
   the same X opcode makes it go super-fast.

   Not that anybody would do that, right? Ha!

 - I will imagine that some of the more vocal folks in the community
   will make it difficult to integrate these patches with these two
   (especially this taint one). This will make the acceptance of these
   patches more difficult than it should be. If you really want them,
   perhaps make them part of another patchset, or a follow up ones.

 - I still don't get why as a brand new community hacks are coming up
   (even when the hardware is not yet there) instead of pushing back at
   the vendors to have a clean up interface. I get in say two or three
   years these things .. but from the start? I get your point about
   flexibility, but it seems to me that the right way is not give open
   RAW interface (big barndoor) but rather maintain the driver and grow
   it (properly constructed doors) as more functionality comes about
   and then adding it in the driver.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
