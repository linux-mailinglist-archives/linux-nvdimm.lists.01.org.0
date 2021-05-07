Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D6376492
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 May 2021 13:40:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C8ADE100EAB6B;
	Fri,  7 May 2021 04:40:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1A1E6100EBB78
	for <linux-nvdimm@lists.01.org>; Fri,  7 May 2021 04:40:27 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 147BYNeJ068051;
	Fri, 7 May 2021 07:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=PtwQDcFQrAR9ORlRZ8P8EWSi1K14i40ORCzOajR6KB0=;
 b=ifrq7IhQjgZX37UX3yUx5ejqIcaYCB6R5iGOcYLajPQapjKt01AssznvKN/U1Yjbhx/L
 2hPsLQKa2AKPRgfGiS4ih3TK/GIN+jCHssY8qq4gtV7CVvD/L0DTqkCbcWTmT9+yEw2G
 JDN0je0F9k9AYAfTSs1gGVqx+MigFxCzXlaFX9z+GnWT0HPy6CkZl+bcvLIgCgpx4vPN
 VZ2/rMGWv0wml06KduBTKbvDxsU4sM4Px6BTF+BLMPCEd5MaEOa8Q2uYbu4zDxQUg8+C
 QZAxwRAdOXnf6+Ip3rg8e2P86FqYN8YYfCwTwOHigIDLA3EXXXk/5vkUg0V87wPkBH60 mA==
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0a-001b2d01.pphosted.com with ESMTP id 38d4pcr8fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 May 2021 07:40:23 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 147BWOUP031108;
	Fri, 7 May 2021 11:40:22 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma01fra.de.ibm.com with ESMTP id 38csqgr4ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 May 2021 11:40:22 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 147Bdre025035132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 May 2021 11:39:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC17452059;
	Fri,  7 May 2021 11:40:19 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.85.69.191])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id C06DD52054;
	Fri,  7 May 2021 11:40:17 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Fri, 07 May 2021 17:10:16 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH] powerpc/papr_scm: Make 'perf_stats' invisible if
 perf-stats unavailable
In-Reply-To: <8735v078v7.fsf@linux.ibm.com>
References: <20210505191708.51939-1-vaibhav@linux.ibm.com>
 <8735v078v7.fsf@linux.ibm.com>
Date: Fri, 07 May 2021 17:10:16 +0530
Message-ID: <87fsyyu5zz.fsf@vajain21.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vj0Qn2Zti5J-WUpx-72ijWzc8pz_LZzb
X-Proofpoint-ORIG-GUID: Vj0Qn2Zti5J-WUpx-72ijWzc8pz_LZzb
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-07_04:2021-05-06,2021-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105070079
Message-ID-Hash: 7APOJSGJZWRO235UN6LWAPDMOA4LILUL
X-Message-ID-Hash: 7APOJSGJZWRO235UN6LWAPDMOA4LILUL
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7APOJSGJZWRO235UN6LWAPDMOA4LILUL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>
>> In case performance stats for an nvdimm are not available, reading the
>> 'perf_stats' sysfs file returns an -ENOENT error. A better approach is
>> to make the 'perf_stats' file entirely invisible to indicate that
>> performance stats for an nvdimm are unavailable.
>>
>> So this patch updates 'papr_nd_attribute_group' to add a 'is_visible'
>> callback implemented as newly introduced 'papr_nd_attribute_visible()'
>> that returns an appropriate mode in case performance stats aren't
>> supported in a given nvdimm.
>>
>> Also the initialization of 'papr_scm_priv.stat_buffer_len' is moved
>> from papr_scm_nvdimm_init() to papr_scm_probe() so that it value is
>> available when 'papr_nd_attribute_visible()' is called during nvdimm
>> initialization.
>>
>> Fixes: 2d02bf835e57('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/papr_scm.c | 37 ++++++++++++++++-------
>>  1 file changed, 26 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>> index 12f1513f0fca..90f0af8fefe8 100644
>> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>> @@ -907,6 +907,20 @@ static ssize_t flags_show(struct device *dev,
>>  }
>>  DEVICE_ATTR_RO(flags);
>>  
>> +umode_t papr_nd_attribute_visible(struct kobject *kobj, struct attribute *attr,
>> +				  int n)
>> +{
>> +	struct device *dev = container_of(kobj, typeof(*dev), kobj);
>> +	struct nvdimm *nvdimm = to_nvdimm(dev);
>> +	struct papr_scm_priv *p = nvdimm_provider_data(nvdimm);
>> +
>> +	/* For if perf-stats not available remove perf_stats sysfs */
>> +	if (attr == &dev_attr_perf_stats.attr && p->stat_buffer_len == 0)
>> +		return 0;
>> +
>> +	return attr->mode;
>> +}
>> +
>>  /* papr_scm specific dimm attributes */
>>  static struct attribute *papr_nd_attributes[] = {
>>  	&dev_attr_flags.attr,
>> @@ -916,6 +930,7 @@ static struct attribute *papr_nd_attributes[] = {
>>  
>>  static struct attribute_group papr_nd_attribute_group = {
>>  	.name = "papr",
>> +	.is_visible = papr_nd_attribute_visible,
>>  	.attrs = papr_nd_attributes,
>>  };
>>  
>> @@ -931,7 +946,6 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>>  	struct nd_region_desc ndr_desc;
>>  	unsigned long dimm_flags;
>>  	int target_nid, online_nid;
>> -	ssize_t stat_size;
>>  
>>  	p->bus_desc.ndctl = papr_scm_ndctl;
>>  	p->bus_desc.module = THIS_MODULE;
>> @@ -1016,16 +1030,6 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>>  	list_add_tail(&p->region_list, &papr_nd_regions);
>>  	mutex_unlock(&papr_ndr_lock);
>>  
>> -	/* Try retriving the stat buffer and see if its supported */
>> -	stat_size = drc_pmem_query_stats(p, NULL, 0);
>> -	if (stat_size > 0) {
>> -		p->stat_buffer_len = stat_size;
>> -		dev_dbg(&p->pdev->dev, "Max perf-stat size %lu-bytes\n",
>> -			p->stat_buffer_len);
>> -	} else {
>> -		dev_info(&p->pdev->dev, "Dimm performance stats unavailable\n");
>> -	}
>> -
>>  	return 0;
>>  
>>  err:	nvdimm_bus_unregister(p->bus);
>> @@ -1102,6 +1106,7 @@ static int papr_scm_probe(struct platform_device *pdev)
>>  	u64 blocks, block_size;
>>  	struct papr_scm_priv *p;
>>  	const char *uuid_str;
>> +	ssize_t stat_size;
>>  	u64 uuid[2];
>>  	int rc;
>>  
>> @@ -1179,6 +1184,16 @@ static int papr_scm_probe(struct platform_device *pdev)
>>  	p->res.name  = pdev->name;
>>  	p->res.flags = IORESOURCE_MEM;
>>  
>> +	/* Try retriving the stat buffer and see if its supported */
>> +	stat_size = drc_pmem_query_stats(p, NULL, 0);
>> +	if (stat_size > 0) {
>> +		p->stat_buffer_len = stat_size;
>> +		dev_dbg(&p->pdev->dev, "Max perf-stat size %lu-bytes\n",
>> +			p->stat_buffer_len);
>> +	} else {
>> +		dev_info(&p->pdev->dev, "Dimm performance stats unavailable\n");
>> +	}
>
> With this patch https://lore.kernel.org/linuxppc-dev/20210505191606.51666-1-vaibhav@linux.ibm.com
> We are adding details of whyy performance stat query hcall failed. Do we
> need to print again here?  Are we being more verbose here?
>
Yes agree this looks more verbose with the other patch you mentioned. I
have sent out a v2 of this patch with this dev_info removed.


> -aneesh
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
