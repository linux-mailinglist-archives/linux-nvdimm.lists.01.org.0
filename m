Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7BD170F3F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Feb 2020 04:58:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D5A2C10FC361F;
	Wed, 26 Feb 2020 19:59:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D251810FC361E
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 19:59:13 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R3sa3E037818
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 22:58:21 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ydcp97pgk-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 22:58:20 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Thu, 27 Feb 2020 03:58:18 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 27 Feb 2020 03:58:11 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01R3wALj52625594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2020 03:58:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 077E311C04C;
	Thu, 27 Feb 2020 03:58:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FA8611C04A;
	Thu, 27 Feb 2020 03:58:09 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 27 Feb 2020 03:58:09 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id E04FFA01C0;
	Thu, 27 Feb 2020 14:58:04 +1100 (AEDT)
Subject: Re: [PATCH v3 13/27] powerpc/powernv/pmem: Read the capability
 registers & wait for device ready
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Andrew Donnellan <ajd@linux.ibm.com>
Date: Thu, 27 Feb 2020 14:58:08 +1100
In-Reply-To: <c6ce554a-62b4-2675-9ec3-1ded8eaacfc4@linux.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
	 <20200221032720.33893-14-alastair@au1.ibm.com>
	 <c6ce554a-62b4-2675-9ec3-1ded8eaacfc4@linux.ibm.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022703-0008-0000-0000-00000356CCA2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022703-0009-0000-0000-00004A77ED75
Message-Id: <e411d83af90e776a817f7638871f2257cacffcd0.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_09:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270026
Message-ID-Hash: EIJMGYUB26CPAD4NAR47CBFZFYUCJLRH
X-Message-ID-Hash: EIJMGYUB26CPAD4NAR47CBFZFYUCJLRH
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxp
 pc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EIJMGYUB26CPAD4NAR47CBFZFYUCJLRH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2020-02-27 at 14:54 +1100, Andrew Donnellan wrote:
> On 21/2/20 2:27 pm, Alastair D'Silva wrote:
> > +/**
> > + * read_device_metadata() - Retrieve config information from the
> > AFU and save it for future use
> > + * @ocxlpmem: the device metadata
> > + * Return: 0 on success, negative on failure
> > + */
> > +static int read_device_metadata(struct ocxlpmem *ocxlpmem)
> > +{
> > +	u64 val;
> > +	int rc;
> > +
> > +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> > GLOBAL_MMIO_CCAP0,
> > +				     OCXL_LITTLE_ENDIAN, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	ocxlpmem->scm_revision = val & 0xFFFF;
> > +	ocxlpmem->read_latency = (val >> 32) & 0xFF;
> 
> This field is 16 bits in the spec, so the mask should be 0xFFFF I
> think?
> 

You're right, I'll fix it.

> Maybe we should generalise the EXTRACT_BITS macro we use in ocxl :)
> 
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
