Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6B31945CD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Mar 2020 18:50:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 41BB410FC3613;
	Thu, 26 Mar 2020 10:50:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BCD641003E9BA
	for <linux-nvdimm@lists.01.org>; Thu, 26 Mar 2020 10:50:47 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QHdKkx155426;
	Thu, 26 Mar 2020 17:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=NIZW38xc1a9emc98A+UgNIFb7CEm8U2COB7N0dvh7ac=;
 b=uV8KdiC0cjjtqrWPw4P53PNifWFsuSpfuczj6AkcVlAMJk+UYwymDLYOfsPWMvmnLFTl
 KjDnQD86SFKXy7yeW3uHG7nd6dte4LLxqRjile67ObY+rEdLNsR3xb5ej+gBb1fcP6Ty
 ek2F5mxFE3Mq1lRIzdkFISHNxd81iQO6p/MRSw9Y8OEDBYfhsiHw7KiEee3ciLvAbRSP
 infaURBS/Gcs5CNafS86oInVd0tcClsoFT6Lr81jEkgwX/es/p1SSI2EyzimS56X5DBd
 2l3HfAPbc9kPaNPHi1HjlCDiw5fGk8J04HFUq93J3uit35yj3HFhlP+OMCdZX3UN9n7U 7Q==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2120.oracle.com with ESMTP id 2ywavmhaa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2020 17:49:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QHnp5U133263;
	Thu, 26 Mar 2020 17:49:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 3003gmagg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2020 17:49:51 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02QHnkKn006952;
	Thu, 26 Mar 2020 17:49:47 GMT
Received: from [10.175.195.110] (/10.175.195.110)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 26 Mar 2020 10:49:46 -0700
Subject: Re: [PATCH 11/12] device-dax: Add dis-contiguous resource support
To: Dan Williams <dan.j.williams@intel.com>
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
 <9a6ff83f-095c-0689-d6d1-693a6e9c07e6@oracle.com>
 <c673cba2-8749-d63e-f0b2-592ed753481d@oracle.com>
 <CAPcyv4gBQOh9sba+Zbpo6yw3sh9JCKC7Cd10qdNc7d1TvTFfYQ@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <636c5e3c-e37e-8ebb-178c-2d79016ddadb@oracle.com>
Date: Thu, 26 Mar 2020 17:49:42 +0000
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gBQOh9sba+Zbpo6yw3sh9JCKC7Cd10qdNc7d1TvTFfYQ@mail.gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=2 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260133
Message-ID-Hash: 3L54IU4335UANGCJET7IRJRSVQ4CTAXS
X-Message-ID-Hash: 3L54IU4335UANGCJET7IRJRSVQ4CTAXS
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@linux.intel.com>, Christoph Hellwig <hch@lst.de>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3L54IU4335UANGCJET7IRJRSVQ4CTAXS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/25/20 5:48 PM, Dan Williams wrote:
> On Wed, Mar 25, 2020 at 3:35 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>> On 3/24/20 4:12 PM, Joao Martins wrote:
>>> On 3/23/20 11:55 PM, Dan Williams wrote:
>>>>  static ssize_t dev_dax_resize(struct dax_region *dax_region,
>>>>              struct dev_dax *dev_dax, resource_size_t size)
>>>>  {
>>>>      resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
>>>> -    resource_size_t dev_size = range_len(&dev_dax->range);
>>>> +    resource_size_t dev_size = dev_dax_size(dev_dax);
>>>>      struct resource *region_res = &dax_region->res;
>>>>      struct device *dev = &dev_dax->dev;
>>>> -    const char *name = dev_name(dev);
>>>>      struct resource *res, *first;
>>>> +    resource_size_t alloc = 0;
>>>> +    int rc;
>>>>
>>>>      if (dev->driver)
>>>>              return -EBUSY;
>>>> @@ -684,38 +766,47 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
>>>>       * allocating a new resource.
>>>>       */
>>>>      first = region_res->child;
>>>> -    if (!first)
>>>> -            return __alloc_dev_dax_range(dev_dax, dax_region->res.start,
>>>> -                            to_alloc);
>>>
>>> You probably want to retain the condition above?
>>>
>>> Otherwise it removes the ability to create new devices or resizing it , once we
>>> have zero-ed the last one.
>>>
>>
>> A quick unit test that I had stashed here to help explain what I mean:
>>
>>         cd /sys/bus/dax/devices
>>         # dax0.0 is the only dax device in the corresponding dax_region
>>         echo dax0.0 > dax0.0/driver/unbind
>>         echo 0 > dax0.0/size
>>         # Shouldn't fail but returns -ENOSPC despite having
>>         # the full region available
>>         cat $(readlink -f dax0.0/../dax_region/available_size) > dax0.0/size
> 
> Thanks! Will incorporate that test before resending the series.
> 
I'll also add some of these tests (in ndctl.git:tests/daxctl-{devices.sh) as
part of my daxctl counterpart series (except using daxctl equivalent of the above).

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
