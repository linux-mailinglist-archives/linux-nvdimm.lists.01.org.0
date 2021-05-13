Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E5D37F4CD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 May 2021 11:26:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 31C27100EAB5F;
	Thu, 13 May 2021 02:26:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B839C100EAB5D
	for <linux-nvdimm@lists.01.org>; Thu, 13 May 2021 02:26:45 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14D9Hhpx010144;
	Thu, 13 May 2021 05:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=9uI9KP37g3URiGw0Ef0US/cyQWCmrg98bIpn0BCa6Xg=;
 b=Ofe1ObUMNeadXwcGvuvF2fQ00uUtl8gblGKFjLGHdGQyW3u2ligbAm2fbEMObYexJ8c/
 //2DqlOmPgtUf6x9X6tOruR9NruWi4RPVJzf2m0d4Q1knoxuPeB4mlvXWIaig6Lkz3Gd
 UM1n1fBVQ58f8FHylrjuJ7Ij5qAq/yF62VVLpQ1ff8d2YHndTraJ0UvMOex4zJWBX1z8
 kIedcwcCNBKxD8nb9XpL7thRlDl2EFZTwDfQWSwZUh9Ypd+qMGow59GJu335iPQsuE1C
 MS0xbAzzXwVLhL6ge4eQ/8OFkgUWStgCHzZsWVkKtsBRcM0u4uPDodjWcqp88K3fCEb4 Wg==
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0b-001b2d01.pphosted.com with ESMTP id 38h1bvg5c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 May 2021 05:26:40 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14D9DBTS010432;
	Thu, 13 May 2021 09:26:38 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma06ams.nl.ibm.com with ESMTP id 38dhwhan4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 May 2021 09:26:38 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14D9Qa4J22544652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 May 2021 09:26:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4866142041;
	Thu, 13 May 2021 09:26:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53BDE42045;
	Thu, 13 May 2021 09:26:33 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.77.192.67])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Thu, 13 May 2021 09:26:33 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 13 May 2021 14:56:32 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] powerpc/papr_scm: Make 'perf_stats' invisible if
 perf-stats unavailable
In-Reply-To: <CAPcyv4g7E39Hqe+fuv-J3gX1kiNVuenUfV4td_k9QtCNMV=C1w@mail.gmail.com>
References: <20210507113948.38950-1-vaibhav@linux.ibm.com>
 <CAPcyv4g7E39Hqe+fuv-J3gX1kiNVuenUfV4td_k9QtCNMV=C1w@mail.gmail.com>
Date: Thu, 13 May 2021 14:56:32 +0530
Message-ID: <87h7j7ass7.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i_Qh95vWL87N-zsL5WeL5RIVA6k1DDof
X-Proofpoint-ORIG-GUID: i_Qh95vWL87N-zsL5WeL5RIVA6k1DDof
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_04:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130070
Message-ID-Hash: CQYDAE6IW5FBCTMHL2OSAAGTF44PLFHQ
X-Message-ID-Hash: CQYDAE6IW5FBCTMHL2OSAAGTF44PLFHQ
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CQYDAE6IW5FBCTMHL2OSAAGTF44PLFHQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks for looking into this patch Dan,

Dan Williams <dan.j.williams@intel.com> writes:

> On Fri, May 7, 2021 at 4:40 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>>
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
>
> Since this has been the exposed ABI since v5.9 perhaps a note /
> analysis is needed here that the disappearance of this file will not
> break any existing scripts/tools.
>
Yes, I have added a note in patch description and also updated
Documentation/ABI/testing/sysfs-bus-papr-pmem with a note on when this
sysfs attr would be available. Thanks for this suggestion.

>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>> Changelog:
>>
>> v2:
>> * Removed a redundant dev_info() from pap_scm_nvdimm_init() [ Aneesh ]
>> * Marked papr_nd_attribute_visible() as static which also fixed the
>>   build warning reported by kernel build robot
>> ---
>>  arch/powerpc/platforms/pseries/papr_scm.c | 35 ++++++++++++++++-------
>>  1 file changed, 24 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>> index e2b69cc3beaf..11e7b90a3360 100644
>> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>> @@ -907,6 +907,20 @@ static ssize_t flags_show(struct device *dev,
>>  }
>>  DEVICE_ATTR_RO(flags);
>>
>> +static umode_t papr_nd_attribute_visible(struct kobject *kobj,
>> +                                        struct attribute *attr, int n)
>> +{
>> +       struct device *dev = container_of(kobj, typeof(*dev), kobj);
>
> This can use the kobj_to_dev() helper.
>
Fixed in v3
>> +       struct nvdimm *nvdimm = to_nvdimm(dev);
>> +       struct papr_scm_priv *p = nvdimm_provider_data(nvdimm);
>> +
>> +       /* For if perf-stats not available remove perf_stats sysfs */
>> +       if (attr == &dev_attr_perf_stats.attr && p->stat_buffer_len == 0)
>> +               return 0;
>> +
>> +       return attr->mode;
>> +}
>> +
>>  /* papr_scm specific dimm attributes */
>>  static struct attribute *papr_nd_attributes[] = {
>>         &dev_attr_flags.attr,
>> @@ -916,6 +930,7 @@ static struct attribute *papr_nd_attributes[] = {
>>
>>  static struct attribute_group papr_nd_attribute_group = {
>>         .name = "papr",
>> +       .is_visible = papr_nd_attribute_visible,
>>         .attrs = papr_nd_attributes,
>>  };
>>
>> @@ -931,7 +946,6 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>>         struct nd_region_desc ndr_desc;
>>         unsigned long dimm_flags;
>>         int target_nid, online_nid;
>> -       ssize_t stat_size;
>>
>>         p->bus_desc.ndctl = papr_scm_ndctl;
>>         p->bus_desc.module = THIS_MODULE;
>> @@ -1016,16 +1030,6 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>>         list_add_tail(&p->region_list, &papr_nd_regions);
>>         mutex_unlock(&papr_ndr_lock);
>>
>> -       /* Try retriving the stat buffer and see if its supported */
>> -       stat_size = drc_pmem_query_stats(p, NULL, 0);
>> -       if (stat_size > 0) {
>> -               p->stat_buffer_len = stat_size;
>> -               dev_dbg(&p->pdev->dev, "Max perf-stat size %lu-bytes\n",
>> -                       p->stat_buffer_len);
>> -       } else {
>> -               dev_info(&p->pdev->dev, "Dimm performance stats unavailable\n");
>> -       }
>> -
>>         return 0;
>>
>>  err:   nvdimm_bus_unregister(p->bus);
>> @@ -1102,6 +1106,7 @@ static int papr_scm_probe(struct platform_device *pdev)
>>         u64 blocks, block_size;
>>         struct papr_scm_priv *p;
>>         const char *uuid_str;
>> +       ssize_t stat_size;
>>         u64 uuid[2];
>>         int rc;
>>
>> @@ -1179,6 +1184,14 @@ static int papr_scm_probe(struct platform_device *pdev)
>>         p->res.name  = pdev->name;
>>         p->res.flags = IORESOURCE_MEM;
>>
>> +       /* Try retriving the stat buffer and see if its supported */
>
> s/retriving/retrieving/
>
Fixed in v3.
>> +       stat_size = drc_pmem_query_stats(p, NULL, 0);
>> +       if (stat_size > 0) {
>> +               p->stat_buffer_len = stat_size;
>> +               dev_dbg(&p->pdev->dev, "Max perf-stat size %lu-bytes\n",
>> +                       p->stat_buffer_len);
>> +       }
>> +
>>         rc = papr_scm_nvdimm_init(p);
>>         if (rc)
>>                 goto err2;
>> --
>> 2.31.1
>>
>
> After the minor fixups above you can add:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks

>
> ...I assume this will go through the PPC tree.
Yes

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
