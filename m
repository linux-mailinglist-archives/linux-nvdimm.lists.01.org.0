Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A0B13CB72
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Jan 2020 18:56:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 259DC10097DD0;
	Wed, 15 Jan 2020 09:59:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0554310097DCD
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 09:59:23 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00FHqSAm064942
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 12:56:05 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xh8d52bgw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 12:56:04 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
	Wed, 15 Jan 2020 17:56:02 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 15 Jan 2020 17:56:00 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00FHtxmH54919206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2020 17:55:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9119852051;
	Wed, 15 Jan 2020 17:55:59 +0000 (GMT)
Received: from [9.85.72.166] (unknown [9.85.72.166])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C644352052;
	Wed, 15 Jan 2020 17:55:58 +0000 (GMT)
Subject: Re: [RFC PATCH] libnvdimm: Update the meaning for persistence_domain
 values
To: Jeff Moyer <jmoyer@redhat.com>
References: <20200108064905.170394-1-aneesh.kumar@linux.ibm.com>
 <x49o8v4oe0t.fsf@segfault.boston.devel.redhat.com>
 <a87b5da8-54d1-3c1a-f068-4d2f389576c9@linux.ibm.com>
 <x49k15soc5v.fsf@segfault.boston.devel.redhat.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 15 Jan 2020 23:25:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <x49k15soc5v.fsf@segfault.boston.devel.redhat.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20011517-0028-0000-0000-000003D15D69
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011517-0029-0000-0000-000024958310
Message-Id: <3184f0f6-1dc7-28b8-0b29-b2b9afa490d3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_02:2020-01-15,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001150137
Message-ID-Hash: IKKGOM2QGH6BJ34IFMPSL33O7VJFGQSC
X-Message-ID-Hash: IKKGOM2QGH6BJ34IFMPSL33O7VJFGQSC
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IKKGOM2QGH6BJ34IFMPSL33O7VJFGQSC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 1/15/20 11:05 PM, Jeff Moyer wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 

>>>> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
>>>> index f2a33f2e3ba8..9126737377e1 100644
>>>> --- a/include/linux/libnvdimm.h
>>>> +++ b/include/linux/libnvdimm.h
>>>> @@ -52,9 +52,9 @@ enum {
>>>>    	 */
>>>>    	ND_REGION_PERSIST_CACHE = 1,
>>>>    	/*
>>>> -	 * Platform provides mechanisms to automatically flush outstanding
>>>> -	 * write data from memory controler to pmem on system power loss.
>>>> -	 * (ADR)
>>>> +	 * Platform provides instructions to flush data such that on completion
>>>> +	 * of the instructions, data flushed is guaranteed to be on pmem even
>>>> +	 * in case of a system power loss.
>>>
>>> I find the prior description easier to understand.
>>
>> I was trying to avoid the term 'automatically, 'memory controler' and
>> ADR. Can I update the above as
> 
> I can understand avoiding the very x86-specific "ADR," but is memory
> controller not accurate for your platform?
> 
>> /*
>>   * Platform provides mechanisms to flush outstanding write data
>>   * to pmem on system power loss.
>>   */
> 
> That's way too broad.  :) The comments are describing the persistence
> domain.  i.e. if you get data to $HERE, it is guaranteed to make it out
> to stable media.

With technologies like OpenCAPI, we possibly may not want to call them 
"memory controller"? In a way platform mechanism will flush them such 
that on power failure, it is guaranteed to be on the pmem media. But 
should we call these boundary "memory_controller"? May be we can 
consider "memory controller" an overloaded term there. Considering we 
are  calling this as memory_controller for application to parse via 
sysfs, may be the documentation can also carry the same term.

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
