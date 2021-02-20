Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B91320251
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Feb 2021 01:55:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 24E78100EBBD1;
	Fri, 19 Feb 2021 16:55:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 97221100EC1F2
	for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 16:55:54 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K0ngC0174660;
	Sat, 20 Feb 2021 00:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=RYl3Y3X/AkFzOkcEi2tJufGb8xFZ+DOgq9HkaHQEUlI=;
 b=OTdjfP0TuC3/li58Ae7/oj27jQg14F6qG/g/LMrDj1pETqDQ/7J/6USYrMevcP1CYjvi
 A1uAw2g7PCFhKzLvEgkDKZeNd0dEd27pAj1R/DsBIooCxCaY7KfiEY0ZWeB1FpKXsGZq
 sRyncJQ3UMAyJJJRk832Ls1+zF+xn3cenuIyw0XmTyz27J6HTBYlUxDiLBde1wKlzNBx
 dhldId1c1ISRYgQ3HFCIzPYYHqg22o9qaELgDR8obwUHsPn15twvRc5t6yRpOrwu3aF1
 /tDt8M5WmnfyGc5MIcxoJPNQpUaLNqikkD467ZrQDvXFFZzqHtkCu5Vppc3X6B4XsxSz rQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 36p66rb5m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Feb 2021 00:54:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K0noZl079971;
	Sat, 20 Feb 2021 00:54:52 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2055.outbound.protection.outlook.com [104.47.46.55])
	by userp3020.oracle.com with ESMTP id 36prhwa7rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Feb 2021 00:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdJGhe/R7k9Bt39ZfVTD6tFxOKtb3y5oicPbQsjs+37dMH41bDNmVj4n8EXLU5JCAK4Ipkt2aDhqf2vimDZyBQw9pNFatv4+dGed7qD5B/gqxUaTvGuFKKfUXH79arCXF2MBK7oCXLDwRfvwfxP42h4tHXGyA5WFS2JdjRvDx4BqvuzWHt41jtssAKYgde1jHSSwkOQS/E1J8ULJzvPlR1LU4LpsRPTfBARpA2A3yZHHubd7/TP+H9sZeHxMU5I4VnRtuSfw/QwKdydzJcSAjwvXSqfvQGBZGZOOHSIyvgXp9dB+P0fPlg5O4Ea/urhg3OfZDeCrzO1kQ+CdkLnm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYl3Y3X/AkFzOkcEi2tJufGb8xFZ+DOgq9HkaHQEUlI=;
 b=DF0mamQhFt5ZnTFcPW32PbbHj37gQbO05XTCpaWhVsAwJs/rPRn11qNGKiskP18E5YLhYODp3FwyRmV8DoMowUmPobW+I/SYi643dxpZun+4gCjVVVhtVCOPTgZ2xm2EtoL7nKPoE3+tNzaqFxYysnj11dAkupUfJUgUNde8Bh7WYYLF56FKpdhP4j17Oe+tSnZdS4LTemSpaB45f6eSXKRn4M8oc/+tQpI78HaqvxKwHRHS18AF3hEFzwj8LB9mHlRuRKMfSgMW9f4mVVdklBIEiXeTAxseY58BYSKVgYfqulGSqMZ2XMH2qwlXLCzcSfeHCcbHO4OXOGKuiRABBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYl3Y3X/AkFzOkcEi2tJufGb8xFZ+DOgq9HkaHQEUlI=;
 b=vAIXRhMGGEAuVaX7/j/TVWJEn3UaDVZBsvRYEQ4ME2QI0ts0JLXG/H+rsLh59VSvS12ZZM+bqJU45EZpc7xqIvi/E2qVj4nsd2U2uaSmI4ALQ2xvlqFCKeThXflGos5BLrynkQfPpz9hF4hn5sNWMHEhoS87BKKzasdGBVtL6/0=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB2551.namprd10.prod.outlook.com (2603:10b6:a02:b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Sat, 20 Feb
 2021 00:54:49 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3846.039; Sat, 20 Feb 2021
 00:54:49 +0000
Date: Fri, 19 Feb 2021 19:54:44 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v5 1/9] cxl/mem: Introduce a driver for CXL-2.0-Type-3
 endpoints
Message-ID: <YDBd1J98VJM0dLvE@Konrads-MacBook-Pro.local>
References: <20210217040958.1354670-1-ben.widawsky@intel.com>
 <20210217040958.1354670-2-ben.widawsky@intel.com>
Content-Disposition: inline
In-Reply-To: <20210217040958.1354670-2-ben.widawsky@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: SN4PR0501CA0034.namprd05.prod.outlook.com
 (2603:10b6:803:40::47) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (209.6.208.110) by SN4PR0501CA0034.namprd05.prod.outlook.com (2603:10b6:803:40::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.11 via Frontend Transport; Sat, 20 Feb 2021 00:54:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65c47051-b1c3-4260-64a6-08d8d53a1fdc
X-MS-TrafficTypeDiagnostic: BYAPR10MB2551:
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB2551DDB86FC97148F322186089839@BYAPR10MB2551.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LYGRuwEWMWFelWojFbjLkQdlMgsm7yW20GMsCm70uwAtVzSciFM5Arzio9wcm+yotO2PBi6mCqX/T4K4AcnyXcqH/5WUyeDuEE2muqeRVXGhKwXnIyD8E7ThpSYAigqOorVJJ5lPBHeFsJQb5gl/SNPU54XGb9QD2oNOVOiJzylr8iR7PD5hXZilbkSKCoa2drWZ/Ssevb4U+zbFicVdLsFo+8YI2eFtPiGBKfbJIfQdXAFIk0QvTHe9G2ylxfaRMj4REpVxPIqQA1UdXKgebLK0pANRLlQu7q/umAKaAGGmoJ3Wmc8JeMQ/ZOEEt7MgTQCSpDhDpyzqyQDbXwhCsUNTge503wPqoz3lPM7uJKcHPPtqzpoM1rp7re66HyxDPyX1oqWv2wmd1uCNuCUDjZjprWJT41Z7HizaHj4BP0mcBI/aLw+gyFx2YawJ1wBmeilrQ+p8bhBcSPjVNEqsyWEcSJwA0l4ZpW7aOguyxaMWYGzfdvsBPsMDZDNb1fLsdaFVPz38erwU42LPAoeg41jYII0rGSaV4eCAKW8Ae/24srCl6oGU2GKhIvYcN57XUrucGaklIBaYjingFbOHbbhS/l9hiYHxBDe3pf1FG+g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(396003)(376002)(136003)(6506007)(26005)(5660300002)(4326008)(956004)(66946007)(16526019)(83380400001)(52116002)(7416002)(186003)(2906002)(8676002)(66476007)(8936002)(478600001)(316002)(7696005)(966005)(86362001)(66556008)(54906003)(9686003)(6916009)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?v1khhlDI+IQUVEaM598yURUL+0Gm6EU3rcoOMjQfRciaSNI1OZJjbnGCwmSc?=
 =?us-ascii?Q?eVKWz6FgJDvzBxIFqui8evKNTY7uBinenwECmTRtopdKgU9zkQbFI3u12jSC?=
 =?us-ascii?Q?EByQ3l4cdU+IsM+d96dGVAz3xO3v3IM6Ycox/6iJ9PJgL66TvIp46t9saRd1?=
 =?us-ascii?Q?M0/kVkkXWXamRhDRf7nHm/qIMaPpXaE7RFiyw9LxSClsSx1Rg+EkPWH6h2sm?=
 =?us-ascii?Q?dCIn5o6I9TLy7731bWGUKHe63DcdOtUz/IrTFf8ORELJ58Eiy8tVCa9nwY6A?=
 =?us-ascii?Q?ru9G2I/iKHo9HNR1R/zPHyRxbt1IIJG75nkVrY8TQFaGcbMRG0AJImiZpyBb?=
 =?us-ascii?Q?Dgbthx2ea8wM3zqM/j2hGwIf1xR5Q/oyRHmuPlPzmqca1Oa4Ae17Mc3c7ARO?=
 =?us-ascii?Q?wcJAma3Nuhlag4EqcU3OnRvnofi7E4OlUF4F1kUPehM3rKZCnnQO2+ww8wqb?=
 =?us-ascii?Q?J2cppZHMgXbwhOCpBwJEVQHWtCfxj5lH6JbWEVz5VAXEnkGyRe7sIVzGr7Pk?=
 =?us-ascii?Q?KAJCvWjU9sI1BJ/buXVGvwZpT9bi/qiB+QnzBrEhDpEqem8ZrjMBG6gbUcjL?=
 =?us-ascii?Q?AcNvH9kzurafvEqxmnp9hXEuAZjBqnf9547rd1BsimLINCEfm28SRmXHgYOe?=
 =?us-ascii?Q?bSSC1MLD8pw8OickSMk8oFdDy7W+6sAcih/gPMwyv/PFbVGi6XNd0Quzh+5W?=
 =?us-ascii?Q?N9uLVkLq0WQUbsrN0Z1mF9k5B0wrDucWi+YCtx8bBxmYnccgeTPn1wCy+uZ5?=
 =?us-ascii?Q?/nLHWL+Gk2DP++hGXHVU/OA6LhneXxUslrcTA/8F37HZjd72AbpZZO+ivJLY?=
 =?us-ascii?Q?SPkOd8J0lztehn6efxZ5eBMhRfUjwPhYTVOMeugvjR3Xvs2P8VxjRsrVd1X6?=
 =?us-ascii?Q?NQu1jDwz2ub9tjMg1jbWRZRmt4L7yc+pOndsIZgxr+28NZH2I76nHqVk/+BK?=
 =?us-ascii?Q?dGLKvUZbcEbwIQxagHHSNxK8LD2h1LonkkPNKMsinZsB7FyfEQJMq58Y9qhs?=
 =?us-ascii?Q?euLamJiWbgGc+oJ5I+w1ABdwzHNY9CkSbPfB65048hil/6iLdkbEeiYmj95a?=
 =?us-ascii?Q?XYwFmrs/TsEKrQ//qnfIE9tqoOjAMPXI7y7966ZT8AfM6+z0s1CSYgOIHcXk?=
 =?us-ascii?Q?4KKd92NFJiD/mz6GzyEf/oQK7TUZcvH1GbA7+zJZwezUj/WYZZGzL29ZbL4r?=
 =?us-ascii?Q?RlimhMLVrLhcgc4YAEiq6cOhfrZ/voFuMDgYMz6JZkvO7NWoEz4IGN6n8nn4?=
 =?us-ascii?Q?VOcKFh0YzsEjZLsTOu3P1ZRrCDdGTlFdeR0fI8RvwVfyGudY8VYy+Uea0iY+?=
 =?us-ascii?Q?V6awvuBmwZYDxL7PwRWGTJbb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c47051-b1c3-4260-64a6-08d8d53a1fdc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2021 00:54:49.3771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPlCvED8JPGtSZXpQlMyEPzdhxr9z1MGHMtGu2hE+j7fWmGmaZTR5U47nhGCMNMwQs5lMvRXzo5c17vWp0wOWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2551
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102200002
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102200002
Message-ID-Hash: VBKG2BAQYFIYZG4HKBVSU6R3MPMIIJW3
X-Message-ID-Hash: VBKG2BAQYFIYZG4HKBVSU6R3MPMIIJW3
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, Jonathan Corbet <corbet@lwn.net>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VBKG2BAQYFIYZG4HKBVSU6R3MPMIIJW3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 16, 2021 at 08:09:50PM -0800, Ben Widawsky wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> The CXL.mem protocol allows a device to act as a provider of "System
> RAM" and/or "Persistent Memory" that is fully coherent as if the memory
> was attached to the typical CPU memory controller.
> 
> With the CXL-2.0 specification a PCI endpoint can implement a "Type-3"
> device interface and give the operating system control over "Host
> Managed Device Memory". See section 2.3 Type 3 CXL Device.
> 
> The memory range exported by the device may optionally be described by
> the platform firmware memory map, or by infrastructure like LIBNVDIMM to
> provision persistent memory capacity from one, or more, CXL.mem devices.
> 
> A pre-requisite for Linux-managed memory-capacity provisioning is this
> cxl_mem driver that can speak the mailbox protocol defined in section
> 8.2.8.4 Mailbox Registers.
> 
> For now just land the initial driver boiler-plate and Documentation/
> infrastructure.
> 
> Link: https://www.computeexpresslink.org/download-the-specification
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Acked-by: David Rientjes <rientjes@google.com> (v1)
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Albeit you may want to modify 2020 to 2021 in the Copyright sections.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
