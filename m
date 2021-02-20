Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA30A32025C
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Feb 2021 02:05:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E6EBC100EBBD1;
	Fri, 19 Feb 2021 17:05:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8A546100ED4AC
	for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 17:05:28 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K0wtLj088659;
	Sat, 20 Feb 2021 01:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=WPh8U55VRzuyuKjpN3r2kBaBs1JhKzVPGWvbNqpZXHY=;
 b=cR85gibEMzV5Bq94JmXMp2TLQZFo8fn7arE6Os6bd9ktAD6Q0DnYjOy0CL93/x7AxAK+
 oHMww743vhFuQi/49LaKl5YwAVlE3UX67H7PV9gZFehv2FQ5oWGw3fTNtsufAWa2Aa8Q
 fxSvbF5dQsIdk/vuOryN2xfHz/OrKY7eUnZPAe+GSVzvD8NV3RTCTFHg/v2dXhZQ3Uht
 NL7MpwOdkH0zhd3MwrmzjTQSJEa7dOcC/c1x6vyGwdQJd2/Q/BTnL7E+ly8JNR78O6Vb
 Z/o1lSqbJgX/OxPexOM7RtgmxEA9rXGQ8F7S3skazqAUJ9VefrwTxxAjTqL85jo/6tvu 2Q==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2130.oracle.com with ESMTP id 36tqxb80wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Feb 2021 01:04:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K0uVx1126418;
	Sat, 20 Feb 2021 01:04:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by aserp3030.oracle.com with ESMTP id 36prbss8xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Feb 2021 01:04:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJ3mMZcDZBpU/iDLqJlyVx1PeVikNEmJfTaUb+0Rh6FLSDFgYlUEzAJnPRIE+GtHLZtZ1H3dLEcIJuIxt0pO11Y/3I7gbRSAIPlf562KSzvKOpEIRIzqsBZ81rRz280SwREJXPYmONVKq/HuSXuqvLugs1EHrs8d1rRzAHzqQMNXzwUp/rpNPnF7X43bYVnZD1Yft75O7NkCAfYBDsE7qlN65XyqpKl2cw1cha4/Od/dL9Qsiqy6DvHg7lgNYzy1wfemauukztax4eV25IpZQtiZi8WhaemRnGimYnMbT7bv2HakJAsNGxXFnNU7IIm0+WPEraDMfAS4soymCwUkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPh8U55VRzuyuKjpN3r2kBaBs1JhKzVPGWvbNqpZXHY=;
 b=iHLljFFYk4kT5AtqJXw/XM4rk3/qoFrSoSmKogSB8CVrmukDMmDCyLZ3oGIebfm+NYnUQskc6eRloQnMVHEKFwGRe+trhdELiNGddJTudPOGNbc60cTQr4JTQE1s8sdCtN44l2gIpTL3B0To1uQybCtMhm3kHTel6Gd9s39PwZl0EkFszIx8WISRz+ef8dreEtpHNUs/FMnNLEbaygPN5zwiBMhiKYR87N7Bv23O3PaqOUXixmkZAVWEyjlPgo0rS5GIKrkt6MBvPHwU7vld3PMoO2cpHETRCfCktftY0ad5+jgqQXaexki0nYJ0NB1ghD4obIaxAzcbDCpvXmW5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPh8U55VRzuyuKjpN3r2kBaBs1JhKzVPGWvbNqpZXHY=;
 b=QLVd0D/wPWwru7QTA8f0mAyNTOk4un/v3l5kaXnQGbks03CilwrB8PLnY8XRXjA0K9jYfK3sFRl/SMS0MFEtkCSHqGR4pma25hGhvoKWJmuQUT/+Uk8LdR4auVcudOaygyd9RvGeLGuO0Uu001ANW+1sqdOf7b/jQDNLRVhVr0c=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB2614.namprd10.prod.outlook.com (2603:10b6:a02:b0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Sat, 20 Feb
 2021 01:04:03 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3846.039; Sat, 20 Feb 2021
 01:04:03 +0000
Date: Fri, 19 Feb 2021 20:03:57 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v5 5/9] cxl/mem: Add a "RAW" send command
Message-ID: <YDBf/QD8LMFi6JbH@Konrads-MacBook-Pro.local>
References: <20210217040958.1354670-1-ben.widawsky@intel.com>
 <20210217040958.1354670-6-ben.widawsky@intel.com>
Content-Disposition: inline
In-Reply-To: <20210217040958.1354670-6-ben.widawsky@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: SN4PR0201CA0061.namprd02.prod.outlook.com
 (2603:10b6:803:20::23) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (209.6.208.110) by SN4PR0201CA0061.namprd02.prod.outlook.com (2603:10b6:803:20::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Sat, 20 Feb 2021 01:04:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c7aa21b-271e-4ef8-90b1-08d8d53b6a06
X-MS-TrafficTypeDiagnostic: BYAPR10MB2614:
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB2614D12070AC530E789E85C989839@BYAPR10MB2614.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z4Trj5944CtcMqVAMAKpvxiwMhE4obulm4RHF2qKdk6KSWp9FeVzIF+BQR23nto/g85GU0vKwe1zjYJNpkLzki1lwopVasIWwLRI2nZllRU/4IWHqsFWmww8Byzd1HUG9fAo5tNRk5SW6ueMHy/a59+DR/wcfGDxjxaRvfZojqUyMueKdg6+PIb5AAGSNxYF7Jf/oYouDGftdLfLiBG9ajRPFPvlBXRPogvPCAq/bHxPIrrrd5pUdnHoHQ0xV2NqoFIAzTfBuz/2owwiwlS5eVL2FF5/9blh79C1HZ/Zt5S+AZ77EyDapoXXXBmr+mLJOVUuiYSdcJ8VU45eiZjKdtg2B3wLBzRVnwL7az/dj2MnhyLOPA6guAQAfIY3YIg0WPUsRJXAeojvRJn0svRakdfrMXtLCEkSPTdrxmbg/3ZUC/9u+dZsnwIjbHpoQXV8FLy7P2p6y9cIuLSXR6mcx15Y2n4xWaPcJEgCSbno5hmfx7jv3ThH6Du6rM9zLnMESLKJneUrc5CXw19VEfQSug==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(376002)(346002)(366004)(6666004)(8936002)(186003)(16526019)(6506007)(83380400001)(52116002)(7696005)(26005)(7416002)(8676002)(6916009)(54906003)(86362001)(66476007)(66946007)(316002)(4326008)(55016002)(9686003)(956004)(478600001)(2906002)(5660300002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?zF8fLcBnSJWCnJTnGcMSbR3JxfRoEIfbfVY8AYCPnX7mCiVXK5NP1BnYK0Y3?=
 =?us-ascii?Q?YSD8L75koEwW8iPwO7Xqac58zXsx7M1eH/bOaHopCYxxx7wgO3qlp7g/g7yj?=
 =?us-ascii?Q?35Q01bYXhcHspzoeIBor7uBP7BZW5KAqTJwZLL8By+IS9zRKECDf2Vojix26?=
 =?us-ascii?Q?+IprJUCm30f1VbV7As5Uz8mhMgJxvX+s+SaAeSqGQ7scTCZwrERKLL8unQHW?=
 =?us-ascii?Q?ppFgdJ8gSdTzV6VT7NncpnhGH0nDvExfWIKGkMnH1r8Nz9pG79h1Hwbmdngy?=
 =?us-ascii?Q?ON9BmstowmN6tKt7C/WGuO8YjZIG30Z1MC1MExK1pZTvEFa6awZ8lj7SO3gp?=
 =?us-ascii?Q?nKbFWqwIlU90nKQQJrvrjb/AchHdsBuBNfprbFWvw68EcfFGqvcGah5720I+?=
 =?us-ascii?Q?pyErSmiRNXcwX1PK+mYVQbvguQVNOm4vASapCBJocHRlh3G4qNHTH1yfcXat?=
 =?us-ascii?Q?4aZK2pxhma9qTLw2SsR9pfJNnpZY1WUrW+XdFmYulDAmR/bZbwQGBCE4Mn8n?=
 =?us-ascii?Q?JlK29pcGzd3n1KO/wXwyDiZtwDKF8KcKb9lQq78UP3XgET/T+u3p8Nh/EW6i?=
 =?us-ascii?Q?12GOSE6tMfYZKhIvN0NzZGlA3m/b5t1z5m36XpiFNTfzJUr/6gVwZpHaZRSR?=
 =?us-ascii?Q?zqB9wtjsULaWkyl7AkaLXbkwe7gQtuch36/7E7vfP65w2O4g/vENQD9thgOl?=
 =?us-ascii?Q?9ahj5WEAr7tLIgt2XBHGTsKx5LM44/qj5r5ALiAIoICFRBag0TfQWmgVo0gh?=
 =?us-ascii?Q?0PmFARM5pZG9vMPcwRbYvaPXC2sWvvNKyZuiqWiC5WaHz1gq/6QqCOztUR2n?=
 =?us-ascii?Q?5rd9Oi9EDDM5VaBqli3rO4RG0k9YduX+6vO2A0MJCye4DkkIhAPDQVpmZU2B?=
 =?us-ascii?Q?t5UgSCihblxEzh98tTNHdmjlzhVAM6/xNPxAU9D/pJWaCT6mJNQFIeCIW5Xf?=
 =?us-ascii?Q?cWVrOzmTL92PAiZY21MeWt2CpinObwQ2oisNDigE18l1TUprZRBlkzptfrGa?=
 =?us-ascii?Q?0x6xn1k/wrCGnjaBg/Z+hrouI+6OHFEiQ7tRTKzTYVt80gMDGLUSp1wQboFG?=
 =?us-ascii?Q?MwLQC8weJL2xZ22fVYFZXzw+LDM/9HQ4xr3mZZsli5Kig4Xdv0zrYXLKjQfA?=
 =?us-ascii?Q?fojYn1GU6nDkvsYqS4EXmj+wXJ3H9i+w+SdH33y4l07MO0eASSK7LIDONgdR?=
 =?us-ascii?Q?IJAz1mCNCKGa6IJH1G3oaYRd5RJHSW5d3AfS5tB3WJvK+mSMIjTRj4OEgzPO?=
 =?us-ascii?Q?DYvLmg/7xlX5cPorAcPAJRWEjo3on0zdwFzN/9HQkwcg9qW42Ncc2UBHSNb5?=
 =?us-ascii?Q?ms7yY7snhbngG+eLTQLKdqyy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7aa21b-271e-4ef8-90b1-08d8d53b6a06
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2021 01:04:03.2986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdpvoM8L5Zvyw28JGtKaPqVwrA4OwNccI9WWfZe16fVoF1WQqjkX/vkdIUHAdEgPhTJ8M0TF7WxctKLM+mj/BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2614
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102200003
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102200003
Message-ID-Hash: D7QNRK7Q3PICATDKH543K7AJ5V26WSJF
X-Message-ID-Hash: D7QNRK7Q3PICATDKH543K7AJ5V26WSJF
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, Ariel Sibley <Ariel.Sibley@microchip.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D7QNRK7Q3PICATDKH543K7AJ5V26WSJF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 16, 2021 at 08:09:54PM -0800, Ben Widawsky wrote:
> The CXL memory device send interface will have a number of supported
> commands. The raw command is not such a command. Raw commands allow
> userspace to send a specified opcode to the underlying hardware and
> bypass all driver checks on the command. The primary use for this
> command is to [begrudgingly] allow undocumented vendor specific hardware
> commands.
> 
> While not the main motivation, it also allows prototyping new hardware
> commands without a driver patch and rebuild.
> 
> While this all sounds very powerful it comes with a couple of caveats:
> 1. Bug reports using raw commands will not get the same level of
>    attention as bug reports using supported commands (via taint).
> 2. Supported commands will be rejected by the RAW command.
> 
> With this comes new debugfs knob to allow full access to your toes with
> your weapon of choice.
> 
> Cc: Ariel Sibley <Ariel.Sibley@microchip.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com> (v2)
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
