Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F912217CFE
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 04:20:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C330F110B96A4;
	Tue,  7 Jul 2020 19:20:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.6.59; helo=eur04-db3-obe.outbound.protection.outlook.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60059.outbound.protection.outlook.com [40.107.6.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C4355110B96A3
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 19:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNaSRtwXz1ZMLKUafvsJ0kItmonn/pN6p8VfFC+kDTc=;
 b=KOkAXUoKBM/TZX8l27jabXRSAa8KKv9LZQ+XHo+iQXdeR3HDW3zLPQ+2T9Wo0Pj7/0p+Gs7A7N4Vvlsloh8JEqImNE1YwieOPanq6sAzXc7d93vmlMNV3CZGS/NFukMXXCJmodwTdW/CvapObsxLmE9bchY8HsLX8ekW6qLqJWQ=
Received: from DB6PR0501CA0016.eurprd05.prod.outlook.com (2603:10a6:4:8f::26)
 by VE1PR08MB4799.eurprd08.prod.outlook.com (2603:10a6:802:ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Wed, 8 Jul
 2020 02:20:26 +0000
Received: from DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:8f:cafe::72) by DB6PR0501CA0016.outlook.office365.com
 (2603:10a6:4:8f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Wed, 8 Jul 2020 02:20:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.01.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;lists.01.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT023.mail.protection.outlook.com (10.152.20.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Wed, 8 Jul 2020 02:20:26 +0000
Received: ("Tessian outbound e44de778b77e:v62"); Wed, 08 Jul 2020 02:20:25 +0000
X-CR-MTA-TID: 64aa7808
Received: from e1e3968f74fc.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3260E18E-0ACF-4871-87BB-CC22D4CBE4B4.1;
	Wed, 08 Jul 2020 02:20:20 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e1e3968f74fc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 08 Jul 2020 02:20:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlfRN2jqiTGixdwdtZLObFYaZUK4OLzJ+mBl3ygCUaUoSZer/j+ZzQEZsxJD3igBlj4L6/zsZ4W9uM/2SyO+kj/TixMqp8LAhIbqm5d4cq24LgdPsa6S3hvqOoEYa5b8Aq+rzthdVHLFkCXK/XxPQMofKdg8aLsO+rux4ngDMLHi42QFsz0wJgz+ooMqvGxD/a3PvyZ1+puPkuErKtaBQ/Kxiz18nbDX9ExQsPuezIfvjf9ezbS41qgIPkHK/7iDTCHFaZQ2El5g0dXWtnJnTuaJH5vLkxtLgKCMf7ogp6rZ+pF56zQKZAgOFB5F0TSnAmmYOf/vXXH25gkiQFJ0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNaSRtwXz1ZMLKUafvsJ0kItmonn/pN6p8VfFC+kDTc=;
 b=SIy51Z0zs/df1iIjlspK1BdCzNvttA3Y1YprGahLbwRuP5l4sPtdadOTooUQimgebo1phTySeaCgbb8neafCDbAW9vY6xsvmdWVDpRC2we5jlYEuCZZaUFLx3gmf5DUCx2vEmfFkxv0FAvYyhnZ68boWAcPYI/CjpDDJK0P7TITwHojNrN5EXjVY8LBqgE7b6jjrNHnrh7eLnAH7CviY1Aus4y9MTVtpuhH3q8Gcuv4kMWrdxdfxf05GQp9riNS6lkOCVCLuMdGC/Kv8y0dMLZeuIfWKkl9NOA1aUJYWb7BG10It28WAjHoxOdPVX2OUIRTfUoqoE/4BwwAamcp86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNaSRtwXz1ZMLKUafvsJ0kItmonn/pN6p8VfFC+kDTc=;
 b=KOkAXUoKBM/TZX8l27jabXRSAa8KKv9LZQ+XHo+iQXdeR3HDW3zLPQ+2T9Wo0Pj7/0p+Gs7A7N4Vvlsloh8JEqImNE1YwieOPanq6sAzXc7d93vmlMNV3CZGS/NFukMXXCJmodwTdW/CvapObsxLmE9bchY8HsLX8ekW6qLqJWQ=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB4689.eurprd08.prod.outlook.com (2603:10a6:20b:c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Wed, 8 Jul
 2020 02:20:18 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 02:20:18 +0000
From: Justin He <Justin.He@arm.com>
To: Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>
Subject: RE: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Thread-Topic: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Thread-Index: AQHWVCPSGGxRNvjq20KjOcC2mjPWIqj8ApMAgADwVZA=
Date: Wed, 8 Jul 2020 02:20:17 +0000
Message-ID: 
 <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz>
In-Reply-To: <20200707115454.GN5913@dhcp22.suse.cz>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 22d41742-0986-422f-8b83-3acf44cdcbab.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2fb85b39-c655-496d-3977-08d822e579e1
x-ms-traffictypediagnostic: AM6PR08MB4689:|VE1PR08MB4799:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: 
	<VE1PR08MB4799D3C366D8B1439C294E71F7670@VE1PR08MB4799.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 iqokAUQL/G50BtDL2TuIGlrJOGKByIF5jzP6/fG59bN9ap4qwtLiTF9QLhexXvGftYT55H0jadEQrsOY4UUGxcMA1K2tLIGhMgFLvhm8STAIgB8lHdYjdVTKn24rFcxFyn4mV9QSX0wxlxyGgb8Uy7ezDH9dA+ULcgfOUQBOedv+LgtAWbnAyl1dSMnoTejIlROE7aFyqkQ9bQJJPN/fQiAGB666LYOkXz38XC57pErrUWZWId8DQFEPgMcDIAj3WI84B0asOWb37qev8lEceRKQMBHfOUYgGaMD9WE3AR8p+O+aYJtti5b4i/eLwS32LJZy/rr7BnhCRbdr4iuL6Q==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39850400004)(346002)(136003)(366004)(2906002)(52536014)(86362001)(5660300002)(76116006)(66476007)(66946007)(66446008)(66556008)(110136005)(64756008)(8676002)(6506007)(8936002)(53546011)(7696005)(54906003)(4326008)(316002)(33656002)(71200400001)(478600001)(55016002)(26005)(9686003)(7416002)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 zeR7jallz/SMaiTB4kHQ4s+nP0QXiKeVwrEscnB6Tbnd/Tp+3tc5/wG8lO+Yw0p80HYaEBkHhHnRaXll5rnNTi3j4cscNAUaLdDK88xwWFiHogPxCC04IeBA3CUQlfk/WcKwQc26kMHMHsHcy4vgW+LUaqFyRvqrnUEy490ady+7+UPjIyzkawbkL4aplrDBBUHSMKw054P/2yD51YX+LZO15PvM2FvUTAJzZJcW6uzdwEg8ClOQw8RNDmaoraO1exGorszFPisJFjYeZvYvWPDMX9gnXyxWlqibm5U4K9mSfpop3DD+ztnEDT9qcvvktQlDi/k4vgtxSmLq+2S31IXeQf78wB/BJ7n002Njqwvwcm/RXnZWbeCjQi7un8tPmOP6jfytKgjlFuD6KBV+rdTvJ+FJtotn6AoqMZ6ydS2TwfwCDnKPZGy6dUjFA2rcmO056RZuTFvMKCkzqDnYJFWVB0DtNHDaZZOn7AVxub0=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4689
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(396003)(346002)(376002)(136003)(46966005)(55016002)(86362001)(52536014)(2906002)(8676002)(9686003)(6506007)(47076004)(33656002)(5660300002)(82740400003)(81166007)(316002)(54906003)(82310400002)(110136005)(336012)(478600001)(83380400001)(356005)(4326008)(8936002)(7696005)(186003)(70586007)(26005)(70206006)(53546011);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	270ccc62-11ed-468f-0502-08d822e5752f
X-Forefront-PRVS: 04583CED1A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OIFpA7vzJk4VGPGsuFqiwOaiDDZNkUzCdy46Fs4F77psUQI8Yr09nHw1+Sl0LT6Ph3SyL3CSRo0BIobpljvGgBcu0mGIwGvwoYY6vLZXIJCcOmFogmkD3UNPXLUXTA8eCqvf6//cKzfRTzfj3vHJWXZKk/RFnKEhIZOGoH8k5Jkbji7jZtztpxF9xwfAIKNL3UJoJZaCg5YhmWmniqE1WHvb03454lGJYIcL4O66ZuaqZtWfNVU4fRDPDsYZzLSfWSD0J2B0sF0+YFklfuBYeiuIru3njCKd9ZuJfIA+sIlTnf4yRKAFtY4ILKIYMjwxYXtbOdldJtWP1g7is4182Gs/exoHnKGCsdYKrYKtQXwKFbXTcbZU5HUnrz5kqO1X0D6Z1qx3cPlnd6FWQ+ie2Q==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 02:20:26.0523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb85b39-c655-496d-3977-08d822e579e1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4799
Message-ID-Hash: YSZL5ESFJDDL3ORGI3H3OXMWKUQDGTPX
X-Message-ID-Hash: YSZL5ESFJDDL3ORGI3H3OXMWKUQDGTPX
X-MailFrom: Justin.He@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VWMN2YGO3CN233XDYRHUYTGYDFQUWHJQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

Hi Michal and David

> -----Original Message-----
> From: Michal Hocko <mhocko@kernel.org>
> Sent: Tuesday, July 7, 2020 7:55 PM
> To: Justin He <Justin.He@arm.com>
> Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon
> <will@kernel.org>; Dan Williams <dan.j.williams@intel.com>; Vishal Verma
> <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>; Andrew
> Morton <akpm@linux-foundation.org>; Mike Rapoport <rppt@linux.ibm.com>;
> Baoquan He <bhe@redhat.com>; Chuhong Yuan <hslester96@gmail.com>; linux-
> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> mm@kvack.org; linux-nvdimm@lists.01.org; Kaly Xin <Kaly.Xin@arm.com>
> Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid
> as EXPORT_SYMBOL_GPL
> 
> On Tue 07-07-20 13:59:15, Jia He wrote:
> > This exports memory_add_physaddr_to_nid() for module driver to use.
> >
> > memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> > NUMA_NO_NID is detected.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  arch/arm64/mm/numa.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > index aafcee3e3f7e..7eeb31740248 100644
> > --- a/arch/arm64/mm/numa.c
> > +++ b/arch/arm64/mm/numa.c
> > @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> >
> >  /*
> >   * We hope that we will be hotplugging memory on nodes we already know
> about,
> > - * such that acpi_get_node() succeeds and we never fall back to this...
> > + * such that acpi_get_node() succeeds. But when SRAT is not present,
> the node
> > + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback
> option.
> >   */
> >  int memory_add_physaddr_to_nid(u64 addr)
> >  {
> > -	pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n",
> addr);
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> 
> Does it make sense to export a noop function? Wouldn't make more sense
> to simply make it static inline somewhere in a header? I haven't checked
> whether there is an easy way to do that sanely bu this just hit my eyes.

Okay, I can make a change in memory_hotplug.h, sth like:
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -149,13 +149,13 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
              struct mhp_params *params);
 #endif /* ARCH_HAS_ADD_PAGES */
 
-#ifdef CONFIG_NUMA
-extern int memory_add_physaddr_to_nid(u64 start);
-#else
+#if !defined(CONFIG_NUMA) || !defined(memory_add_physaddr_to_nid)
 static inline int memory_add_physaddr_to_nid(u64 start)
 {
        return 0;
 }
+#else
+extern int memory_add_physaddr_to_nid(u64 start);
 #endif

And then check the memory_add_physaddr_to_nid() helper on all arches,
if it is noop(return 0), I can simply remove it.
if it is not noop, after the helper, 
#define memory_add_physaddr_to_nid

What do you think of this proposal?

--
Cheers,
Justin (Jia He)

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
