Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708B219099A
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 10:36:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C889B10FC38AA;
	Tue, 24 Mar 2020 02:37:34 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sachinp@linux.vnet.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C45B410FC3630
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 02:37:32 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02O9YL4O006094
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 05:36:41 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2yxw7d41dt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 05:36:41 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <sachinp@linux.vnet.ibm.com>;
	Tue, 24 Mar 2020 09:36:38 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 24 Mar 2020 09:36:34 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02O9aYB232964816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2020 09:36:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D19842042;
	Tue, 24 Mar 2020 09:36:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18C7442041;
	Tue, 24 Mar 2020 09:36:33 +0000 (GMT)
Received: from [9.199.50.248] (unknown [9.199.50.248])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2020 09:36:32 +0000 (GMT)
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [5.6.0-rc7] Kernel crash while running ndctl tests
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <87a746cdva.fsf@linux.ibm.com>
Date: Tue, 24 Mar 2020 15:06:31 +0530
References: <CF20E440-4DCB-4EFD-88B6-0AB98DC7FBD4@linux.vnet.ibm.com>
 <87a746cdva.fsf@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-TM-AS-GCONF: 00
x-cbid: 20032409-0008-0000-0000-00000362E88A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032409-0009-0000-0000-00004A845422
Message-Id: <33E32320-C371-4A41-A3E1-4B9D2DDAFBFC@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_02:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=912
 mlxscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240048
Message-ID-Hash: PXQY5K4WLOBT7K2LD47SPFLJZSGRJDH7
X-Message-ID-Hash: PXQY5K4WLOBT7K2LD47SPFLJZSGRJDH7
X-MailFrom: sachinp@linux.vnet.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Baoquan He <bhe@redhat.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PXQY5K4WLOBT7K2LD47SPFLJZSGRJDH7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On 24-Mar-2020, at 2:45 PM, Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> wrote:
> 
> Sachin Sant <sachinp@linux.vnet.ibm.com> writes:
> 
>> While running ndctl[1] tests against 5.6.0-rc7 following crash is encountered.
>> 
>> Bisect leads me to  commit d41e2f3bd546 
>> mm/hotplug: fix hot remove failure in SPARSEMEM|!VMEMMAP case
>> 
>> Reverting this commit helps and the tests complete without any crash.
> 
> 
> Can you try this change?
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index aadb7298dcef..3012d1f3771a 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -781,6 +781,8 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> 			ms->usage = NULL;
> 		}
> 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> +		/* Mark the section invalid */
> +		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
> 	}
> 
> 	if (section_is_early && memmap)
> 

This patch works for me. The test ran successfully without any crash/failure.

Thanks
-Sachin

> a pfn_valid check involves pnf_section_valid() check if section is
> having MEM_MAP. In this case we did end up  setting the ms->uage = NULL.
> So when we do that tupdate the section to not have MEM_MAP.
> 
> -aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
