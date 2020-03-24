Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1753C1915B9
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 17:12:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 89E0B10FC36C9;
	Tue, 24 Mar 2020 09:13:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 49DB710FC317A
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 09:13:29 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OG9JZO066496;
	Tue, 24 Mar 2020 16:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=j2oyooX0rAq76SY5WS1UWzfXaOSBSc7XLdbFb+EV+As=;
 b=D35IUL8cJIekvD/+YVC2smWxK7eGoPcY1Lih0c+aRi1v/zUPOETfSVsBrLrGqRwNTqm7
 T00wHpKBMIF3NOaxB04lNrFFTGl3aVQDihBf5gDbwQmWJga/qju1JMCtIIQgHMT3PaZu
 c+McHlDKNDl37wHhCvLVKTV4xSd779hq8zMKkHi4eX4ydnqphicynXiaJO2xKoEYdm9c
 z/LCJSpV56Yi73WeqOeMyySlrYjP51VDyVfElwB9iqEH3X3zAuQClODGQt0XmoDkX2Ml
 FxfpkMCZO5nV4tEndI7KkvD6dCyfEsUuR9A2CmhQBdEBri6w+rd68y8F3Z1l3RT8u3/8 tA==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 2ywavm58vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2020 16:12:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OGBonB079385;
	Tue, 24 Mar 2020 16:12:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3030.oracle.com with ESMTP id 2yxw92wr2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2020 16:12:31 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02OGCPoj014077;
	Tue, 24 Mar 2020 16:12:25 GMT
Received: from [10.175.222.8] (/10.175.222.8)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 24 Mar 2020 09:12:24 -0700
Subject: Re: [PATCH 11/12] device-dax: Add dis-contiguous resource support
To: Dan Williams <dan.j.williams@intel.com>
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <9a6ff83f-095c-0689-d6d1-693a6e9c07e6@oracle.com>
Date: Tue, 24 Mar 2020 16:12:21 +0000
MIME-Version: 1.0
In-Reply-To: <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=5
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003240087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 phishscore=0 suspectscore=5 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003240086
Message-ID-Hash: DAU4CJPGE5DO6TPJVVN4XROR5VSNGRXD
X-Message-ID-Hash: DAU4CJPGE5DO6TPJVVN4XROR5VSNGRXD
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, dave.hansen@linux.intel.com, hch@lst.de, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DAU4CJPGE5DO6TPJVVN4XROR5VSNGRXD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/23/20 11:55 PM, Dan Williams wrote:
>  static ssize_t dev_dax_resize(struct dax_region *dax_region,
>  		struct dev_dax *dev_dax, resource_size_t size)
>  {
>  	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
> -	resource_size_t dev_size = range_len(&dev_dax->range);
> +	resource_size_t dev_size = dev_dax_size(dev_dax);
>  	struct resource *region_res = &dax_region->res;
>  	struct device *dev = &dev_dax->dev;
> -	const char *name = dev_name(dev);
>  	struct resource *res, *first;
> +	resource_size_t alloc = 0;
> +	int rc;
>  
>  	if (dev->driver)
>  		return -EBUSY;
> @@ -684,38 +766,47 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
>  	 * allocating a new resource.
>  	 */
>  	first = region_res->child;
> -	if (!first)
> -		return __alloc_dev_dax_range(dev_dax, dax_region->res.start,
> -				to_alloc);

You probably want to retain the condition above?

Otherwise it removes the ability to create new devices or resizing it , once we
have zero-ed the last one.

> -	for (res = first; to_alloc && res; res = res->sibling) {
> +retry:
> +	rc = -ENOSPC;
> +	for (res = first; res; res = res->sibling) {
>  		struct resource *next = res->sibling;
> -		resource_size_t free;
>  
>  		/* space at the beginning of the region */
> -		free = 0;
> -		if (res == first && res->start > dax_region->res.start)
> -			free = res->start - dax_region->res.start;
> -		if (free >= to_alloc && dev_size == 0)
> -			return __alloc_dev_dax_range(dev_dax,
> -					dax_region->res.start, to_alloc);
> -
> -		free = 0;
> +		if (res == first && res->start > dax_region->res.start) {
> +			alloc = min(res->start - dax_region->res.start,
> +					to_alloc);
> +			rc = __alloc_dev_dax_range(dev_dax,
> +					dax_region->res.start, alloc);
> +			break;
> +		}
> +
> +		alloc = 0;
>  		/* space between allocations */
>  		if (next && next->start > res->end + 1)
> -			free = next->start - res->end + 1;
> +			alloc = min(next->start - (res->end + 1), to_alloc);
>  
>  		/* space at the end of the region */
> -		if (free < to_alloc && !next && res->end < region_res->end)
> -			free = region_res->end - res->end;
> -
> -		if (free >= to_alloc && strcmp(name, res->name) == 0)
> -			return __adjust_dev_dax_range(dev_dax, res,
> -					resource_size(res) + to_alloc);
> -		else if (free >= to_alloc && dev_size == 0)
> -			return __alloc_dev_dax_range(dev_dax, res->end + 1,
> -					to_alloc);
> +		if (!alloc && !next && res->end < region_res->end)
> +			alloc = min(region_res->end - res->end, to_alloc);
> +
> +		if (!alloc)
> +			continue;
> +
> +		if (adjust_ok(dev_dax, res)) {
> +			rc = __adjust_dev_dax_range(dev_dax, res,
> +					resource_size(res) + alloc);
> +			break;
> +		}
> +		rc = __alloc_dev_dax_range(dev_dax, res->end + 1,
> +				alloc);

I am wondering if we should switch to:

	if (adjust_ok(...))
		rc = __adjust_dev_dax_range(...);
	else
		rc = __alloc_dev_dax_range(...);

And then a debug print at the end depicting whether and how did we grabbed
space? Something like:

	dev_dbg(&dev_dax->dev, "%s(%d) %d", action, location, rc);

Assuming we set @location to its values when we allocate space at the end,
beginning or middle; and @action to whether we adjusted up/down or allocated new
range.

Essentially, something similar to namespaces scan_allocate() just to help
troubleshoot?

Regards,
 Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
