Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3247100F81
	for <lists+linux-nvdimm@lfdr.de>; Tue, 19 Nov 2019 00:48:15 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E599B100DC431;
	Mon, 18 Nov 2019 15:49:08 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ajd@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 72A67100DC42F
	for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 15:49:06 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAINlAYr053173
	for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 18:48:10 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2way30dk3j-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 18:48:10 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <ajd@linux.ibm.com>;
	Mon, 18 Nov 2019 23:48:07 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 18 Nov 2019 23:48:01 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAINm0M748168994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2019 23:48:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A123A4051;
	Mon, 18 Nov 2019 23:48:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24301A4053;
	Mon, 18 Nov 2019 23:48:00 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 18 Nov 2019 23:48:00 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id ADE67A012A;
	Tue, 19 Nov 2019 10:47:55 +1100 (AEDT)
Subject: Re: [PATCH 08/10] nvdimm: Add driver for OpenCAPI Storage Class
 Memory
To: Dan Williams <dan.j.williams@intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>
References: <20191025044721.16617-1-alastair@au1.ibm.com>
 <20191025044721.16617-9-alastair@au1.ibm.com>
 <8232c1a6-d52a-6c32-6178-de082174a92a@linux.ibm.com>
 <CAPcyv4g9b6PyREurH9NcQf4BO2YcRGJPBZDqGKy-Vz91mBKjew@mail.gmail.com>
From: Andrew Donnellan <ajd@linux.ibm.com>
Date: Tue, 19 Nov 2019 10:47:56 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4g9b6PyREurH9NcQf4BO2YcRGJPBZDqGKy-Vz91mBKjew@mail.gmail.com>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 19111823-0020-0000-0000-00000389E694
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111823-0021-0000-0000-000021E00FC5
Message-Id: <02374c9a-39fb-5693-3d9c-aa7e7674a6c1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_08:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=903 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180204
Message-ID-Hash: 7HB5HIIWNOEMKM7BPVU6DL4SYMEN556B
X-Message-ID-Hash: 7HB5HIIWNOEMKM7BPVU6DL4SYMEN556B
X-MailFrom: ajd@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Wei Yang <richard.weiyang@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Qian Cai <cai@lca.pw>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Hari Bathini <hbathini@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Linux MM <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxpp
 c-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7HB5HIIWNOEMKM7BPVU6DL4SYMEN556B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 15/11/19 3:35 am, Dan Williams wrote:
>> Have you discussed with the directory owner if it's ok to split the
>> driver over several files?
> 
> My thought is to establish drivers/opencapi/ and move this and the
> existing drivers/misc/ocxl/ bits there.

Is there any other justification for this we can think of apart from not 
wanting to put this driver in the nvdimm directory? OpenCAPI drivers 
aren't really a category of driver unto themselves.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
