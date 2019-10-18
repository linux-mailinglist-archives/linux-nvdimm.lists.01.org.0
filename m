Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430B6DC2B9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 12:26:19 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 271E310FC6313;
	Fri, 18 Oct 2019 03:28:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A362010FC6311
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 03:28:21 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9IAMara170383;
	Fri, 18 Oct 2019 06:26:11 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2vq0h9b43m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2019 06:26:09 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9IAP8U2015673;
	Fri, 18 Oct 2019 10:25:22 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by ppma04dal.us.ibm.com with ESMTP id 2vq0br644j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2019 10:25:22 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9IAPLXt58327496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2019 10:25:21 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A4716E04E;
	Fri, 18 Oct 2019 10:25:21 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A7B16E052;
	Fri, 18 Oct 2019 10:25:19 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.33.73])
	by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2019 10:25:18 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: "Verma\, Vishal L" <vishal.l.verma@intel.com>,
        "Williams\,
	Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH] ndctl: Use the same align value as original namespace on reconfigure
In-Reply-To: <87o909oca1.fsf@linux.ibm.com>
References: <20190807044416.30799-1-aneesh.kumar@linux.ibm.com> <a6f0635109d75489144bd1b5985e8da44110b01b.camel@intel.com> <87o909oca1.fsf@linux.ibm.com>
Date: Fri, 18 Oct 2019 15:55:16 +0530
Message-ID: <87d0eufj03.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910180101
Message-ID-Hash: MCMOWNE4ZUKP5E3MLPUYQ67KMC2YVA66
X-Message-ID-Hash: MCMOWNE4ZUKP5E3MLPUYQ67KMC2YVA66
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MCMOWNE4ZUKP5E3MLPUYQ67KMC2YVA66/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> writes:

> "Verma, Vishal L" <vishal.l.verma@intel.com> writes:
>
>> On Wed, 2019-08-07 at 10:14 +0530, Aneesh Kumar K.V wrote:
>>> When using reconfigure command to add a `name` to the namespace we end
>>> up updating the align attribute. Avoid this by using the value from
>>> the original namespace. Do this only if we are keeping the namespace mode
>>> same.
>>> 
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>>  ndctl/namespace.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>
>> Hi Aneesh,
>>
>> A few comments below:
>>
>>> 
>>> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
>>> index 1f212a2b3a9b..24e51bb35ae1 100644
>>> --- a/ndctl/namespace.c
>>> +++ b/ndctl/namespace.c
>>> @@ -596,6 +596,22 @@ static int validate_namespace_options(struct ndctl_region *region,
>>>  			return -ENXIO;
>>>  		}
>>>  	} else {
>>> +
>>> +		/*
>>> +		 * If we are tryint to reconfigure with the same namespace mode
>>
>>                              ^trying
>>
>>> +		 * Use the align details from the origin namespace. Otherwise
>>
>> s/origin/original/
>>
>>> +		 * pick the align details from seed namespace
>>> +		 */
>>> +		if (ndns && p->mode == ndctl_namespace_get_mode(ndns)) {
>>
>> Do we need to depend on the mode here?
>>
>> I'm thinking it should be sufficient to do:
>>   1. Check We're in 'reconfigure'
>>   2. Check param.align was not supplied
>>   3. Get alignment from the pfn/dax personality, and just use that.
>>
>> Does this make sense (Maybe I'm missing something).
>
> We want to use the align value from the seed when we are trying
> to reconfigure a namespace with a different mode. ie, if we are moving a
> fsdax namespace with align value 64K to a devdax, IMHO we should pick 16M
> as alignment for devdax.
>
>>
>>> +			struct ndctl_pfn *ns_pfn = ndctl_namespace_get_pfn(ndns);
>>> +			struct ndctl_dax *ns_dax = ndctl_namespace_get_dax(ndns);
>>> +			if (ns_pfn)
>>> +				p->align = ndctl_pfn_get_align(ns_pfn);
>>> +			else if (ns_dax)
>>> +				p->align = ndctl_dax_get_align(ns_dax);
>>> +			else
>>> +				p->align = sysconf(_SC_PAGE_SIZE);
>>
>> Do we need the page size fallback here - there are other checks after
>> this point that also do a similar fallback, do they not catch the
>> default case?
>
>
> I did that to simplify the code with that `else if`  
>
>>
>>> +		} else
>>>  		/*
>>>  		 * Use the seed namespace alignment as the default if we need
>>>  		 * one. If we don't then use PAGE_SIZE so the size_align

Any update on this.?

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
