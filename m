Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1942F10F67A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Dec 2019 05:57:45 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D164710113673;
	Mon,  2 Dec 2019 21:01:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C97C910113671
	for <linux-nvdimm@lists.01.org>; Mon,  2 Dec 2019 21:01:03 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB34q2C3139854
	for <linux-nvdimm@lists.01.org>; Mon, 2 Dec 2019 23:57:40 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6snstyk-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 02 Dec 2019 23:57:40 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Tue, 3 Dec 2019 04:57:37 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 3 Dec 2019 04:57:30 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB34vTUx48955466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2019 04:57:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AA85A404D;
	Tue,  3 Dec 2019 04:57:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD2D9A4040;
	Tue,  3 Dec 2019 04:57:28 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2019 04:57:28 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 40E50A01B6;
	Tue,  3 Dec 2019 15:57:26 +1100 (AEDT)
Subject: Re: [PATCH v2 26/27] powerpc: Enable OpenCAPI Storage Class Memory
 driver on bare metal
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Andrew Donnellan <ajd@linux.ibm.com>
Date: Tue, 03 Dec 2019 15:57:27 +1100
In-Reply-To: <a993926f-72c0-af1c-220c-38dd90377ef0@linux.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
	 <20191203034655.51561-27-alastair@au1.ibm.com>
	 <a993926f-72c0-af1c-220c-38dd90377ef0@linux.ibm.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19120304-0028-0000-0000-000003C3D5B3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120304-0029-0000-0000-00002486ED8B
Message-Id: <2734b940e2eb68e500a03bc5d90689e5948259c2.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=821 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030043
Message-ID-Hash: MYAAR3HSIXK2OSFPXAUIWAILTD3XWZP4
X-Message-ID-Hash: MYAAR3HSIXK2OSFPXAUIWAILTD3XWZP4
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
  linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MYAAR3HSIXK2OSFPXAUIWAILTD3XWZP4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2019-12-03 at 15:54 +1100, Andrew Donnellan wrote:
> On 3/12/19 2:46 pm, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > Enable OpenCAPI Storage Class Memory driver on bare metal
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> 
> I'd suggest a summary line more like
> 
> powerpc/configs: Enable OpenCAPI SCM driver in powernv_defconfig
> 
> and a commit message to match.
> 

OK.

> 
> > ---
> >   arch/powerpc/configs/powernv_defconfig | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/powerpc/configs/powernv_defconfig
> > b/arch/powerpc/configs/powernv_defconfig
> > index 6658cceb928c..a8f46aece8a4 100644
> > --- a/arch/powerpc/configs/powernv_defconfig
> > +++ b/arch/powerpc/configs/powernv_defconfig
> > @@ -352,3 +352,7 @@ CONFIG_KVM_BOOK3S_64=m
> >   CONFIG_KVM_BOOK3S_64_HV=m
> >   CONFIG_VHOST_NET=m
> >   CONFIG_PRINTK_TIME=y
> > +CONFIG_OCXL_SCM=m
> > +CONFIG_DEV_DAX=m
> > +CONFIG_DEV_DAX_PMEM=m
> > +CONFIG_FS_DAX=m
> > 
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
