Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99310375088
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 10:06:07 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DA412100EBBDD;
	Thu,  6 May 2021 01:06:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CFBCE100EC1CC
	for <linux-nvdimm@lists.01.org>; Thu,  6 May 2021 01:06:03 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14683olx094677;
	Thu, 6 May 2021 04:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=3RhGqUPDNAVBVUyGya4SEMYVyr4ykJfJiWGaJQtOOoc=;
 b=NKnGPb4vUYVRMKKCKE274baOYqIuh8fGlINHbkgl8kQPqcQ7+P8ohU0jE2Mx44ViJV/y
 eYvzJRTwBbRKAgUj6x/qOOv/lVcWbSSkiTI4ZRQdXEYpFCD/HAoyS4bLFrVZCYEPuyzh
 y0UYO/3o8yWTij4hbAC23Ij8f7jyJ1416kS2xZsdO+ylqbl8tCbgVHn75ARVWUzkdP0g
 +8GLNwKYRb6pWqw4EbX/7ZELFN6vAj8Gvhf33R6jOWb/50PfVYfJ3Zqao2HoFLg9Nmx2
 Crurxlc6YGlPdSkeTln3+Wk8GfDyKloffFqRgPOxGdXhjdlVulV6rdRXpJgaJiIH59uJ MA==
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0b-001b2d01.pphosted.com with ESMTP id 38cc07s2hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 May 2021 04:05:44 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1467vkZG005741;
	Thu, 6 May 2021 08:05:43 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by ppma03wdc.us.ibm.com with ESMTP id 38bedra7v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 May 2021 08:05:43 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14685gBD37093794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 May 2021 08:05:42 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 638807805E;
	Thu,  6 May 2021 08:05:42 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF9F878066;
	Thu,  6 May 2021 08:05:38 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.102.1.95])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Thu,  6 May 2021 08:05:38 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v1 04/11] mm/memremap: add ZONE_DEVICE support for
 compound pages
In-Reply-To: <CAPcyv4jG8+S6xJyp=1S2=dpit0Hs2+HgGwpWeRROCRuJnQYAxQ@mail.gmail.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-5-joao.m.martins@oracle.com>
 <CAPcyv4gs_rHL7FPqyQEb3yT4jrv8Wo_xA2ojKsppoBfmDocq8A@mail.gmail.com>
 <cd1c9849-8660-dbdc-718a-aa4ba5d48c01@oracle.com>
 <CAPcyv4jG8+S6xJyp=1S2=dpit0Hs2+HgGwpWeRROCRuJnQYAxQ@mail.gmail.com>
Date: Thu, 06 May 2021 13:35:35 +0530
Message-ID: <87zgx85ltc.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D3F_Csp_rXbtTtpaqzXHFd37LY4TOwM9
X-Proofpoint-ORIG-GUID: D3F_Csp_rXbtTtpaqzXHFd37LY4TOwM9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_06:2021-05-05,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1011 mlxlogscore=999
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105060055
Message-ID-Hash: JBWVTZSYSPSKCX2JMKWJT2EOMPEC7KIK
X-Message-ID-Hash: JBWVTZSYSPSKCX2JMKWJT2EOMPEC7KIK
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JBWVTZSYSPSKCX2JMKWJT2EOMPEC7KIK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



IIUC this series is about devdax namespace with aligh of 1G or 2M where we can
save the vmmemap space by not allocating memory for tail struct pages? 

Dan Williams <dan.j.williams@intel.com> writes:

> > enum:
>> >
>> > enum devmap_geometry {
>> >     DEVMAP_PTE,
>> >     DEVMAP_PMD,
>> >     DEVMAP_PUD,
>> > }
>> >
>> I suppose a converter between devmap_geometry and page_size would be needed too? And maybe
>> the whole dax/nvdimm align values change meanwhile (as a followup improvement)?
>
> I think it is ok for dax/nvdimm to continue to maintain their align
> value because it should be ok to have 4MB align if the device really
> wanted. However, when it goes to map that alignment with
> memremap_pages() it can pick a mode. For example, it's already the
> case that dax->align == 1GB is mapped with DEVMAP_PTE today, so
> they're already separate concepts that can stay separate.

devdax namespace with align of 1G implies we expect to map them with 1G
pte entries? I didn't follow when you say we map them today with
DEVMAP_PTE entries.


-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
