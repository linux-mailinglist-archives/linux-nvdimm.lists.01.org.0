Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D60F0D46
	for <lists+linux-nvdimm@lfdr.de>; Wed,  6 Nov 2019 04:47:02 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 72BDE100DC3C8;
	Tue,  5 Nov 2019 19:49:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ajd@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B6162100DC3C6
	for <linux-nvdimm@lists.01.org>; Tue,  5 Nov 2019 19:49:35 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA63kbjR017725
	for <linux-nvdimm@lists.01.org>; Tue, 5 Nov 2019 22:46:56 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2w3n352a2b-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 05 Nov 2019 22:46:56 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <ajd@linux.ibm.com>;
	Wed, 6 Nov 2019 03:46:53 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 6 Nov 2019 03:46:45 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA63kiwk46727510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2019 03:46:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63DEE42041;
	Wed,  6 Nov 2019 03:46:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C2B142049;
	Wed,  6 Nov 2019 03:46:44 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed,  6 Nov 2019 03:46:44 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6FF61A00F1;
	Wed,  6 Nov 2019 14:46:39 +1100 (AEDT)
Subject: Re: [PATCH 10/10] ocxl: Conditionally bind SCM devices to the generic
 OCXL driver
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20191025044721.16617-1-alastair@au1.ibm.com>
 <20191025044721.16617-11-alastair@au1.ibm.com>
From: Andrew Donnellan <ajd@linux.ibm.com>
Date: Wed, 6 Nov 2019 14:46:40 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025044721.16617-11-alastair@au1.ibm.com>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 19110603-0008-0000-0000-0000032B1484
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110603-0009-0000-0000-00004A4A7093
Message-Id: <e1a28cc0-2a48-3149-ee77-0c4bc2727aa7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911060038
Message-ID-Hash: OYQQGARG337NZ37RTE34U5Y4FITPX3IG
X-Message-ID-Hash: OYQQGARG337NZ37RTE34U5Y4FITPX3IG
X-MailFrom: ajd@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Hari Bathini <hbathini@linux.ibm.com>, Allison Randal <allison@lohutok.net>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hock
 o <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OYQQGARG337NZ37RTE34U5Y4FITPX3IG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 25/10/19 3:47 pm, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This patch allows the user to bind OpenCAPI SCM devices to the generic OCXL
> driver.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Agree that this needs more explanation - both in the commit and the 
Kconfig help.

> diff --git a/drivers/misc/ocxl/pci.c b/drivers/misc/ocxl/pci.c
> index cb920aa88d3a..7137055c1883 100644
> --- a/drivers/misc/ocxl/pci.c
> +++ b/drivers/misc/ocxl/pci.c
> @@ -10,6 +10,9 @@
>    */
>   static const struct pci_device_id ocxl_pci_tbl[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x062B), },
> +#ifdef CONFIG_OCXL_SCM_GENERIC
> +	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0625), },
> +#endif
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(pci, ocxl_pci_tbl);
> 

If there's no way to use the ID table from ocxl-scm directly, there 
should at least be a comment both here and in the ocxl-scm device ID 
table mentioning that you need to keep these in sync.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
