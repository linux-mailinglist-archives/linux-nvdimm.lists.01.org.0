Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADF019BB9B
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 Apr 2020 08:21:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E93F410FC5F73;
	Wed,  1 Apr 2020 23:22:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=ajd@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B4B8E10FC5F72
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 23:22:39 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03269JwU119581
	for <linux-nvdimm@lists.01.org>; Thu, 2 Apr 2020 02:21:48 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 3058y8a511-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 02 Apr 2020 02:21:48 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <ajd@linux.ibm.com>;
	Thu, 2 Apr 2020 07:21:31 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 2 Apr 2020 07:21:23 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0326LbiA43254262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2020 06:21:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D87214C050;
	Thu,  2 Apr 2020 06:21:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 314D74C046;
	Thu,  2 Apr 2020 06:21:37 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2020 06:21:37 +0000 (GMT)
Received: from [9.102.43.12] (unknown [9.102.43.12])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 67DCAA0130;
	Thu,  2 Apr 2020 17:21:30 +1100 (AEDT)
Subject: Re: [PATCH v4 06/25] ocxl: Tally up the LPC memory on a link & allow
 it to be mapped
To: Dan Williams <dan.j.williams@intel.com>,
        "Alastair D'Silva" <alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
 <20200327071202.2159885-7-alastair@d-silva.org>
 <CAPcyv4jyFQa5BDPCSQ6kmFY8CvWgbydePcn8B4M_Zyc1c7MGpg@mail.gmail.com>
From: Andrew Donnellan <ajd@linux.ibm.com>
Date: Thu, 2 Apr 2020 17:21:34 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jyFQa5BDPCSQ6kmFY8CvWgbydePcn8B4M_Zyc1c7MGpg@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20040206-4275-0000-0000-000003B8050E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040206-4276-0000-0000-000038CD59BE
Message-Id: <0e188ea7-1845-c9ca-a18f-4f331f31b07c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_04:2020-03-31,2020-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020050
Message-ID-Hash: JDX5ODARDFVLKTEEHOVD6BJEMPHZB2D4
X-Message-ID-Hash: JDX5ODARDFVLKTEEHOVD6BJEMPHZB2D4
X-MailFrom: ajd@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Linux Kernel Mailing List <linux-kerne
 l@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JDX5ODARDFVLKTEEHOVD6BJEMPHZB2D4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 1/4/20 7:48 pm, Dan Williams wrote:
> On Sun, Mar 29, 2020 at 10:53 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>>
>> OpenCAPI LPC memory is allocated per link, but each link supports
>> multiple AFUs, and each AFU can have LPC memory assigned to it.
> 
> Is there an OpenCAPI primer to decode these objects and their
> associations that I can reference?

There isn't presently a primer that I think addresses these questions 
nicely (to my knowledge - Fred might have something he can link to?) - 
there are the specs published by the OpenCAPI Consortium at 
https://opencapi.org but they're really for hardware implementers.

We should probably expand what's currently documented in 
Documentation/userspace-api/accelerators/ocxl.rst generally, and this 
series should probably update that to include details on LPC.

To explain the specific objects here:

- A "link" is a point-to-point link between the host CPU, and a single 
OpenCAPI card. (We don't currently support cards making use of multiple 
links for increased bandwidth, though that is supported from a hardware 
point of view.)

- On POWER9, each link appears as a separate PCI domain, with a single 
bus, and the card appears as a single device.

- A device can have up to 8 functions, per PCI.

- An Attached Functional Unit (AFU) is the abstraction for a particular 
application function. Each PCI function defines the number of AFUs it 
has through a set of OpenCAPI-specific DVSECs, max 64 per function. The 
ocxl driver handles AFU discovery.

- On the host side, LPC memory is mapped by setting a single BAR for the 
whole link, but on the device side, LPC memory is requested on a per-AFU 
basis, through an AFU descriptor that is exposed through the 
aforementioned DVSECs. Hence the need to loop through the AFUs and get 
the total required LPC memory to work out the correct BAR value.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
