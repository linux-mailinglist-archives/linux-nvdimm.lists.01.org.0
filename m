Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C600170FF6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Feb 2020 06:09:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 71D2610FC3622;
	Wed, 26 Feb 2020 21:10:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=ajd@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 005C210FC3597
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 21:10:03 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R54QZl144129
	for <linux-nvdimm@lists.01.org>; Thu, 27 Feb 2020 00:09:11 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ydcnh65v0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 27 Feb 2020 00:09:11 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <ajd@linux.ibm.com>;
	Thu, 27 Feb 2020 05:09:09 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 27 Feb 2020 05:09:01 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01R591Io53542972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2020 05:09:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAA95A404D;
	Thu, 27 Feb 2020 05:09:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 417E3A4040;
	Thu, 27 Feb 2020 05:09:00 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 27 Feb 2020 05:09:00 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2E3BFA01C0;
	Thu, 27 Feb 2020 16:08:55 +1100 (AEDT)
Subject: Re: [PATCH v3 12/27] powerpc/powernv/pmem: Add register addresses &
 status values to the header
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-13-alastair@au1.ibm.com>
From: Andrew Donnellan <ajd@linux.ibm.com>
Date: Thu, 27 Feb 2020 16:08:58 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-13-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20022705-0028-0000-0000-000003DE5EF4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022705-0029-0000-0000-000024A37CF0
Message-Id: <e335ed2d-7381-e95c-a6b5-0efe60746cf4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_09:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270037
Message-ID-Hash: WNKRQXG4VJEA3MEVJM5SMQHR726ELL5G
X-Message-ID-Hash: WNKRQXG4VJEA3MEVJM5SMQHR726ELL5G
X-MailFrom: ajd@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc
 -dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WNKRQXG4VJEA3MEVJM5SMQHR726ELL5G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 21/2/20 2:27 pm, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> These values have been taken from the device specifications.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

I've compared these values against the internal version of the device 
specifications that I have access to, and they appear to match.

A few minor comments below, otherwise:

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

> +#define GLOBAL_MMIO_HCI_ACRW				BIT_ULL(0)
> +#define GLOBAL_MMIO_HCI_NSCRW				BIT_ULL(1)
> +#define GLOBAL_MMIO_HCI_AFU_RESET			BIT_ULL(2)
> +#define GLOBAL_MMIO_HCI_FW_DEBUG			BIT_ULL(3)
> +#define GLOBAL_MMIO_HCI_CONTROLLER_DUMP			BIT_ULL(4)
> +#define GLOBAL_MMIO_HCI_CONTROLLER_DUMP_COLLECTED	BIT_ULL(5)
> +#define GLOBAL_MMIO_HCI_REQ_HEALTH_PERF			BIT_ULL(6)

The labelling of some of these bits deviates from the standard 
abbreviations in the spec, which is fine I guess as these names are more 
descriptive, but maybe add a brief comment with the original abbreviation?

> +
> +#define ADMIN_COMMAND_HEARTBEAT		0x00u
> +#define ADMIN_COMMAND_SHUTDOWN		0x01u
> +#define ADMIN_COMMAND_FW_UPDATE		0x02u
> +#define ADMIN_COMMAND_FW_DEBUG		0x03u
> +#define ADMIN_COMMAND_ERRLOG		0x04u
> +#define ADMIN_COMMAND_SMART		0x05u
> +#define ADMIN_COMMAND_CONTROLLER_STATS	0x06u
> +#define ADMIN_COMMAND_CONTROLLER_DUMP	0x07u
> +#define ADMIN_COMMAND_CMD_CAPS		0x08u
> +#define ADMIN_COMMAND_MAX		0x08u
> +
> +#define STATUS_SUCCESS		0x00
> +#define STATUS_MEM_UNAVAILABLE	0x20

There's also a "blocked on account of background task" code, 0x21.

> +#define STATUS_BAD_OPCODE	0x50
> +#define STATUS_BAD_REQUEST_PARM	0x51
> +#define STATUS_BAD_DATA_PARM	0x52
> +#define STATUS_DEBUG_BLOCKED	0x70
> +#define STATUS_FAIL		0xFF
> +
> +#define STATUS_FW_UPDATE_BLOCKED 0x21
> +#define STATUS_FW_ARG_INVALID	0x51
> +#define STATUS_FW_INVALID	0x52

These status codes seem, from the specification, to correspond to the 
generic error codes above, so perhaps they're not needed.


-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
