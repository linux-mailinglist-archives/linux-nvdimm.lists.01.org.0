Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FB3170F31
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Feb 2020 04:54:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8445A10FC361E;
	Wed, 26 Feb 2020 19:55:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=ajd@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0C16110FC361A
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 19:55:27 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R3s2Zw125116
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 22:54:35 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ydxrdcfbp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 22:54:34 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <ajd@linux.ibm.com>;
	Thu, 27 Feb 2020 03:54:32 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 27 Feb 2020 03:54:25 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01R3sO8034144468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2020 03:54:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B61F9A4053;
	Thu, 27 Feb 2020 03:54:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E07DA4051;
	Thu, 27 Feb 2020 03:54:24 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 27 Feb 2020 03:54:24 +0000 (GMT)
Received: from [9.81.219.21] (unknown [9.81.219.21])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 776C1A01C0;
	Thu, 27 Feb 2020 14:54:18 +1100 (AEDT)
Subject: Re: [PATCH v3 13/27] powerpc/powernv/pmem: Read the capability
 registers & wait for device ready
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-14-alastair@au1.ibm.com>
From: Andrew Donnellan <ajd@linux.ibm.com>
Date: Thu, 27 Feb 2020 14:54:21 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-14-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20022703-0012-0000-0000-0000038AA543
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022703-0013-0000-0000-000021C74D18
Message-Id: <c6ce554a-62b4-2675-9ec3-1ded8eaacfc4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_09:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270026
Message-ID-Hash: CYYNOOTTG2OUZZEKG4ISBGS5SC7EV26E
X-Message-ID-Hash: CYYNOOTTG2OUZZEKG4ISBGS5SC7EV26E
X-MailFrom: ajd@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc
 -dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CYYNOOTTG2OUZZEKG4ISBGS5SC7EV26E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 21/2/20 2:27 pm, Alastair D'Silva wrote:
> +/**
> + * read_device_metadata() - Retrieve config information from the AFU and save it for future use
> + * @ocxlpmem: the device metadata
> + * Return: 0 on success, negative on failure
> + */
> +static int read_device_metadata(struct ocxlpmem *ocxlpmem)
> +{
> +	u64 val;
> +	int rc;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_CCAP0,
> +				     OCXL_LITTLE_ENDIAN, &val);
> +	if (rc)
> +		return rc;
> +
> +	ocxlpmem->scm_revision = val & 0xFFFF;
> +	ocxlpmem->read_latency = (val >> 32) & 0xFF;

This field is 16 bits in the spec, so the mask should be 0xFFFF I think?

Maybe we should generalise the EXTRACT_BITS macro we use in ocxl :)

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
