Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A409101171
	for <lists+linux-nvdimm@lfdr.de>; Tue, 19 Nov 2019 03:48:46 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 19648100EE8CF;
	Mon, 18 Nov 2019 18:49:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42938100EE8CE
	for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 18:49:37 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJ2lLaY123730
	for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 21:48:42 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2waygkt314-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 21:48:42 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Tue, 19 Nov 2019 02:48:39 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 19 Nov 2019 02:48:31 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAJ2mUkX393582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2019 02:48:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C46E1A405C;
	Tue, 19 Nov 2019 02:48:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D8F3A4054;
	Tue, 19 Nov 2019 02:48:30 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 19 Nov 2019 02:48:30 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id D0373A012A;
	Tue, 19 Nov 2019 13:48:25 +1100 (AEDT)
Subject: Re: [PATCH 08/10] nvdimm: Add driver for OpenCAPI Storage Class
 Memory
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Andrew Donnellan <ajd@linux.ibm.com>,
        Dan Williams
	 <dan.j.williams@intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>
Date: Tue, 19 Nov 2019 13:48:26 +1100
In-Reply-To: <02374c9a-39fb-5693-3d9c-aa7e7674a6c1@linux.ibm.com>
References: <20191025044721.16617-1-alastair@au1.ibm.com>
	 <20191025044721.16617-9-alastair@au1.ibm.com>
	 <8232c1a6-d52a-6c32-6178-de082174a92a@linux.ibm.com>
	 <CAPcyv4g9b6PyREurH9NcQf4BO2YcRGJPBZDqGKy-Vz91mBKjew@mail.gmail.com>
	 <02374c9a-39fb-5693-3d9c-aa7e7674a6c1@linux.ibm.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19111902-0020-0000-0000-0000038A0D94
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111902-0021-0000-0000-000021E0371A
Message-Id: <7fd5a4571062a06da8f09f18300794b48ead5dc1.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_08:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxlogscore=896 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911190024
Message-ID-Hash: BCGHNO7E5PK67BI7X6DJPMPCW7S6IBO6
X-Message-ID-Hash: BCGHNO7E5PK67BI7X6DJPMPCW7S6IBO6
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Wei Yang <richard.weiyang@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Qian Cai <cai@lca.pw>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Hari Bathini <hbathini@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Linux MM <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BCGHNO7E5PK67BI7X6DJPMPCW7S6IBO6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2019-11-19 at 10:47 +1100, Andrew Donnellan wrote:
> On 15/11/19 3:35 am, Dan Williams wrote:
> > > Have you discussed with the directory owner if it's ok to split
> > > the
> > > driver over several files?
> > 
> > My thought is to establish drivers/opencapi/ and move this and the
> > existing drivers/misc/ocxl/ bits there.
> 
> Is there any other justification for this we can think of apart from
> not 
> wanting to put this driver in the nvdimm directory? OpenCAPI drivers 
> aren't really a category of driver unto themselves.
> 

There is a precedent for bus-based dirs, eg. drivers/(ide|w1|spi) all
contain drivers for both controllers & connected devices.

Fred, how do you feel about moving the generic OpenCAPI driver out of
drivers/misc?

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
