Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ADA84419
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Aug 2019 08:00:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 336022130309B;
	Tue,  6 Aug 2019 23:02:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 28315212B7DBA
 for <linux-nvdimm@lists.01.org>; Tue,  6 Aug 2019 23:02:49 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x775v3Ws048073; Wed, 7 Aug 2019 02:00:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u7nnxx8ad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Aug 2019 02:00:17 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7760GeK055838;
 Wed, 7 Aug 2019 02:00:16 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u7nnxx89f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Aug 2019 02:00:16 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x775xwE4012821;
 Wed, 7 Aug 2019 06:00:15 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma02dal.us.ibm.com with ESMTP id 2u51w644xv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Aug 2019 06:00:15 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7760EO132964974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Aug 2019 06:00:14 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 870E52805A;
 Wed,  7 Aug 2019 06:00:14 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C07C28059;
 Wed,  7 Aug 2019 06:00:11 +0000 (GMT)
Received: from [9.199.35.167] (unknown [9.199.35.167])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  7 Aug 2019 06:00:11 +0000 (GMT)
Subject: Re: [PATCH] nvdimm/of_pmem: Provide a unique name for bus provider
To: Dan Williams <dan.j.williams@intel.com>
References: <20190807040029.11344-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4haXOjn7K-HgPV_WLqbfqRQbbiq=LvLt5Ue=OPAaBWN6A@mail.gmail.com>
 <c99ecdad-e9de-cd76-1601-841de35602a0@linux.ibm.com>
 <CAPcyv4ia5F73Qd0FyOWkHAUGoXrPFFQwA-R3DNXb0mGyOS5fgQ@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <9c397eca-9152-9da7-fcde-8aa424c8fede@linux.ibm.com>
Date: Wed, 7 Aug 2019 11:30:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ia5F73Qd0FyOWkHAUGoXrPFFQwA-R3DNXb0mGyOS5fgQ@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-07_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070064
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 8/7/19 10:22 AM, Dan Williams wrote:
> On Tue, Aug 6, 2019 at 9:17 PM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> On 8/7/19 9:43 AM, Dan Williams wrote:
>>> On Tue, Aug 6, 2019 at 9:00 PM Aneesh Kumar K.V
>>> <aneesh.kumar@linux.ibm.com> wrote:
>>>>
>>>> ndctl utility requires the ndbus to have unique names. If not while
>>>> enumerating the bus in userspace it drops bus with similar names.
>>>> This results in us not listing devices beneath the bus.
>>>
>>> It does?
>>>
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> ---
>>>>    drivers/nvdimm/of_pmem.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
>>>> index a0c8dcfa0bf9..97187d6c0bdb 100644
>>>> --- a/drivers/nvdimm/of_pmem.c
>>>> +++ b/drivers/nvdimm/of_pmem.c
>>>> @@ -42,7 +42,7 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>>>>                   return -ENOMEM;
>>>>
>>>>           priv->bus_desc.attr_groups = bus_attr_groups;
>>>> -       priv->bus_desc.provider_name = "of_pmem";
>>>> +       priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
>>>
>>> This looks ok to me to address support for older ndctl binaries, but
>>> I'd like to also fix the ndctl bug that makes non-unique provider
>>> names fail.
>>>
>>
>> 0462269ab121d323a016874ebdd42217f2911ee7 (ndctl: provide a method to
>> invalidate the bus list)
>>
>> This hunk does the filtering.
>>
>> @@ -928,6 +929,14 @@ static int add_bus(void *parent, int id, const char
>> *ctl_base)
>>                  goto err_read;
>>          bus->buf_len = strlen(bus->bus_path) + 50;
>>
>> +       ndctl_bus_foreach(ctx, bus_dup)
>> +               if (strcmp(ndctl_bus_get_provider(bus_dup),
>> +                                       ndctl_bus_get_provider(bus)) == 0) {
>> +                       free_bus(bus, NULL);
>> +                       free(path);
>> +                       return 1;
>> +               }
>> +
> 
> Yup, that's broken, does this incremental fix work?
> 
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index 4d9cc7e29c6b..6596f94edef8 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -889,7 +889,9 @@ static void *add_bus(void *parent, int id, const
> char *ctl_base)
> 
>          ndctl_bus_foreach(ctx, bus_dup)
>                  if (strcmp(ndctl_bus_get_provider(bus_dup),
> -                                       ndctl_bus_get_provider(bus)) == 0) {
> +                                       ndctl_bus_get_provider(bus)) == 0
> +                               && strcmp(ndctl_bus_get_devname(bus_dup),
> +                                       ndctl_bus_get_devname(bus)) == 0) {
>                          free_bus(bus, NULL);
>                          free(path);
>                          return bus_dup;
> 

That worked.

-aneesh
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
