Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD149FEC5
	for <lists+linux-nvdimm@lfdr.de>; Wed, 28 Aug 2019 11:44:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0868720218C57;
	Wed, 28 Aug 2019 02:46:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D758920214B3F
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 02:46:03 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7S9hQFp004179
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 05:43:59 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2unpue1213-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 05:43:59 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 28 Aug 2019 10:43:57 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 28 Aug 2019 10:43:54 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7S9hrCG48562386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Aug 2019 09:43:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EF49A4059;
 Wed, 28 Aug 2019 09:43:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8655DA4040;
 Wed, 28 Aug 2019 09:43:52 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.124.35.79])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 28 Aug 2019 09:43:52 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: "Verma\, Vishal L" <vishal.l.verma@intel.com>, "Williams\,
 Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH] ndctl: Use the same align value as original namespace on
 reconfigure
In-Reply-To: <a6f0635109d75489144bd1b5985e8da44110b01b.camel@intel.com>
References: <20190807044416.30799-1-aneesh.kumar@linux.ibm.com>
 <a6f0635109d75489144bd1b5985e8da44110b01b.camel@intel.com>
Date: Wed, 28 Aug 2019 15:13:50 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19082809-0028-0000-0000-00000394D439
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082809-0029-0000-0000-000024570FFA
Message-Id: <87o909oca1.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-28_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280102
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

"Verma, Vishal L" <vishal.l.verma@intel.com> writes:

> On Wed, 2019-08-07 at 10:14 +0530, Aneesh Kumar K.V wrote:
>> When using reconfigure command to add a `name` to the namespace we end
>> up updating the align attribute. Avoid this by using the value from
>> the original namespace. Do this only if we are keeping the namespace mode
>> same.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  ndctl/namespace.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>
> Hi Aneesh,
>
> A few comments below:
>
>> 
>> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
>> index 1f212a2b3a9b..24e51bb35ae1 100644
>> --- a/ndctl/namespace.c
>> +++ b/ndctl/namespace.c
>> @@ -596,6 +596,22 @@ static int validate_namespace_options(struct ndctl_region *region,
>>  			return -ENXIO;
>>  		}
>>  	} else {
>> +
>> +		/*
>> +		 * If we are tryint to reconfigure with the same namespace mode
>
>                              ^trying
>
>> +		 * Use the align details from the origin namespace. Otherwise
>
> s/origin/original/
>
>> +		 * pick the align details from seed namespace
>> +		 */
>> +		if (ndns && p->mode == ndctl_namespace_get_mode(ndns)) {
>
> Do we need to depend on the mode here?
>
> I'm thinking it should be sufficient to do:
>   1. Check We're in 'reconfigure'
>   2. Check param.align was not supplied
>   3. Get alignment from the pfn/dax personality, and just use that.
>
> Does this make sense (Maybe I'm missing something).

We want to use the align value from the seed when we are trying
to reconfigure a namespace with a different mode. ie, if we are moving a
fsdax namespace with align value 64K to a devdax, IMHO we should pick 16M
as alignment for devdax.

>
>> +			struct ndctl_pfn *ns_pfn = ndctl_namespace_get_pfn(ndns);
>> +			struct ndctl_dax *ns_dax = ndctl_namespace_get_dax(ndns);
>> +			if (ns_pfn)
>> +				p->align = ndctl_pfn_get_align(ns_pfn);
>> +			else if (ns_dax)
>> +				p->align = ndctl_dax_get_align(ns_dax);
>> +			else
>> +				p->align = sysconf(_SC_PAGE_SIZE);
>
> Do we need the page size fallback here - there are other checks after
> this point that also do a similar fallback, do they not catch the
> default case?


I did that to simplify the code with that `else if`  

>
>> +		} else
>>  		/*
>>  		 * Use the seed namespace alignment as the default if we need
>>  		 * one. If we don't then use PAGE_SIZE so the size_align

-aneesh

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
