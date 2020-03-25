Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC2E1925C1
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Mar 2020 11:36:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E931710FC36E2;
	Wed, 25 Mar 2020 03:37:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 326B310FC36C4
	for <linux-nvdimm@lists.01.org>; Wed, 25 Mar 2020 03:37:35 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PAUK8v127788;
	Wed, 25 Mar 2020 10:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=dMcGhyuBIpMkIVciHn7P0KLhi6muieWQFAZAm0xpZM0=;
 b=XMEATyznVn1SJE+yJwdesCzWq6veWdcDxKm5rB//TsEiA4JKRsmVUMNvFx9uFKw68ejZ
 oPYtiGaOj8z/MCv/1GyAryBo1t1dzV3/vljcH2Fpv9/U2mtf80YrEnI25Fbe1w5nX4La
 RDNVMRRUnswjTDPpBbnjkw49DHi/9vzsXvzh0EsYjkBh+gN3ITQqRfdJBNKY8mdtxeT9
 O0gziAZY2UuPOgwN0xD1n8WjceVpEBLcNZDDWhnMiwoEnZXBLZe7GFbF7gGGhTii17ud
 eYlhfXV7o0TGDZsS1sPWwEgiK4va+UDjRiZq0cVY8+xWcwO4ylqJtTNka/sneDLE5UZm Ww==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 3005kv80k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2020 10:35:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PAQZkc054609;
	Wed, 25 Mar 2020 10:35:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 3003q01df5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2020 10:35:36 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02PAZZ1p020169;
	Wed, 25 Mar 2020 10:35:35 GMT
Received: from [10.175.203.78] (/10.175.203.78)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 25 Mar 2020 03:35:35 -0700
Subject: Re: [PATCH 11/12] device-dax: Add dis-contiguous resource support
From: Joao Martins <joao.m.martins@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
 <9a6ff83f-095c-0689-d6d1-693a6e9c07e6@oracle.com>
Message-ID: <c673cba2-8749-d63e-f0b2-592ed753481d@oracle.com>
Date: Wed, 25 Mar 2020 10:35:31 +0000
MIME-Version: 1.0
In-Reply-To: <9a6ff83f-095c-0689-d6d1-693a6e9c07e6@oracle.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=5
 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=5 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250090
Message-ID-Hash: XJN7I3OI3HFERTI3SFGUQZSOM7CW4USZ
X-Message-ID-Hash: XJN7I3OI3HFERTI3SFGUQZSOM7CW4USZ
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, dave.hansen@linux.intel.com, hch@lst.de, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XJN7I3OI3HFERTI3SFGUQZSOM7CW4USZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/24/20 4:12 PM, Joao Martins wrote:
> On 3/23/20 11:55 PM, Dan Williams wrote:
>>  static ssize_t dev_dax_resize(struct dax_region *dax_region,
>>  		struct dev_dax *dev_dax, resource_size_t size)
>>  {
>>  	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
>> -	resource_size_t dev_size = range_len(&dev_dax->range);
>> +	resource_size_t dev_size = dev_dax_size(dev_dax);
>>  	struct resource *region_res = &dax_region->res;
>>  	struct device *dev = &dev_dax->dev;
>> -	const char *name = dev_name(dev);
>>  	struct resource *res, *first;
>> +	resource_size_t alloc = 0;
>> +	int rc;
>>  
>>  	if (dev->driver)
>>  		return -EBUSY;
>> @@ -684,38 +766,47 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
>>  	 * allocating a new resource.
>>  	 */
>>  	first = region_res->child;
>> -	if (!first)
>> -		return __alloc_dev_dax_range(dev_dax, dax_region->res.start,
>> -				to_alloc);
> 
> You probably want to retain the condition above?
> 
> Otherwise it removes the ability to create new devices or resizing it , once we
> have zero-ed the last one.
> 

A quick unit test that I had stashed here to help explain what I mean:

	cd /sys/bus/dax/devices
	# dax0.0 is the only dax device in the corresponding dax_region
	echo dax0.0 > dax0.0/driver/unbind
	echo 0 > dax0.0/size
	# Shouldn't fail but returns -ENOSPC despite having
	# the full region available
	cat $(readlink -f dax0.0/../dax_region/available_size) > dax0.0/size

>> -	for (res = first; to_alloc && res; res = res->sibling) {
>> +retry:
>> +	rc = -ENOSPC;
>> +	for (res = first; res; res = res->sibling) {
>>  		struct resource *next = res->sibling;
>> -		resource_size_t free;
>>  
>>  		/* space at the beginning of the region */
>> -		free = 0;
>> -		if (res == first && res->start > dax_region->res.start)
>> -			free = res->start - dax_region->res.start;
>> -		if (free >= to_alloc && dev_size == 0)
>> -			return __alloc_dev_dax_range(dev_dax,
>> -					dax_region->res.start, to_alloc);
>> -
>> -		free = 0;
>> +		if (res == first && res->start > dax_region->res.start) {
>> +			alloc = min(res->start - dax_region->res.start,
>> +					to_alloc);
>> +			rc = __alloc_dev_dax_range(dev_dax,
>> +					dax_region->res.start, alloc);
>> +			break;
>> +		}
>> +
>> +		alloc = 0;
>>  		/* space between allocations */
>>  		if (next && next->start > res->end + 1)
>> -			free = next->start - res->end + 1;
>> +			alloc = min(next->start - (res->end + 1), to_alloc);
>>  
>>  		/* space at the end of the region */
>> -		if (free < to_alloc && !next && res->end < region_res->end)
>> -			free = region_res->end - res->end;
>> -
>> -		if (free >= to_alloc && strcmp(name, res->name) == 0)
>> -			return __adjust_dev_dax_range(dev_dax, res,
>> -					resource_size(res) + to_alloc);
>> -		else if (free >= to_alloc && dev_size == 0)
>> -			return __alloc_dev_dax_range(dev_dax, res->end + 1,
>> -					to_alloc);
>> +		if (!alloc && !next && res->end < region_res->end)
>> +			alloc = min(region_res->end - res->end, to_alloc);
>> +
>> +		if (!alloc)
>> +			continue;
>> +
>> +		if (adjust_ok(dev_dax, res)) {
>> +			rc = __adjust_dev_dax_range(dev_dax, res,
>> +					resource_size(res) + alloc);
>> +			break;
>> +		}
>> +		rc = __alloc_dev_dax_range(dev_dax, res->end + 1,
>> +				alloc);
> 
> I am wondering if we should switch to:
> 
> 	if (adjust_ok(...))
> 		rc = __adjust_dev_dax_range(...);
> 	else
> 		rc = __alloc_dev_dax_range(...);
> 
> And then a debug print at the end depicting whether and how did we grabbed
> space? Something like:
> 
> 	dev_dbg(&dev_dax->dev, "%s(%d) %d", action, location, rc);
> 
> Assuming we set @location to its values when we allocate space at the end,
> beginning or middle; and @action to whether we adjusted up/down or allocated new
> range.
> 
> Essentially, something similar to namespaces scan_allocate() just to help
> troubleshoot?
> 
> Regards,
>  Joao
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
