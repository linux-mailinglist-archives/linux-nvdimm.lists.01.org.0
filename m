Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE13191660
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 17:28:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AB98810FC36CC;
	Tue, 24 Mar 2020 09:28:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5DDCF10FC36C9
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 09:28:49 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OGDKIV071454;
	Tue, 24 Mar 2020 16:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=O2BVh03YvNi1joghI7zvQ/8mPcvJPWxXuGFSrPPipr8=;
 b=yh3DLpJ+6PiKNrEk1LyNDTZnktsvzbFnXxipD84INpShisnxCxmQabtyHAM4eCukdxu0
 1LC2REVBAQ7cLdLRNDDc8h7f0OvJhcaImHXrEJg/Zj2F9Kcg4yALJ0r1hibEZKt4yTxn
 Xsrxc+3ZN1Fbm0GqOJpa1zsHwVUCABU9D+hdbjZpCkthBTQ/W7wLRx7KzM2F0WDLH1dl
 FnolCG0fyNS1iLcNpMt3YRjAAmqByP0m1eU6usX2iTVq+BIcP9gPuA6yVPMltZ7al72X
 jmU7I5kIKMjsBaEG69zizjS0LaiEfm+MlShtyK/c8kY2nHxNx2dNajTU1aKsm2T4hh60 pQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2120.oracle.com with ESMTP id 2ywavm5bqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2020 16:27:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OGJnkO185961;
	Tue, 24 Mar 2020 16:27:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 2yxw6n1tbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2020 16:27:49 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02OGRmWk001475;
	Tue, 24 Mar 2020 16:27:48 GMT
Received: from [10.175.222.8] (/10.175.222.8)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 24 Mar 2020 09:27:48 -0700
Subject: Re: [PATCH 12/12] device-dax: Introduce 'mapping' devices
To: Dan Williams <dan.j.williams@intel.com>
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500774067.2088294.1260962550701501447.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <27ba42ac-ec08-fd9c-dee2-53414eb0bc58@oracle.com>
Date: Tue, 24 Mar 2020 16:27:44 +0000
MIME-Version: 1.0
In-Reply-To: <158500774067.2088294.1260962550701501447.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=5 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003240087
Message-ID-Hash: G5UMADPHGJJKOL2RX5MORWA4IMWK2VOO
X-Message-ID-Hash: G5UMADPHGJJKOL2RX5MORWA4IMWK2VOO
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, dave.hansen@linux.intel.com, hch@lst.de, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G5UMADPHGJJKOL2RX5MORWA4IMWK2VOO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/23/20 11:55 PM, Dan Williams wrote:
> In support of interrogating the physical address layout of a device with
> dis-contiguous ranges, introduce a sysfs directory with 'start', 'end',
> and 'page_offset' attributes. The alternative is trying to parse
> /proc/iomem, and that file will not reflect the extent layout until the
> device is enabled.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dax/bus.c         |  190 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dax/dax-private.h |   14 +++
>  2 files changed, 202 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 07aeb8fa9ee8..645449a079bd 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -558,6 +558,167 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
>  }
>  EXPORT_SYMBOL_GPL(alloc_dax_region);
>  
> +static void dax_mapping_release(struct device *dev)
> +{
> +	struct dax_mapping *mapping = to_dax_mapping(dev);
> +	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> +
> +	ida_free(&dev_dax->ida, mapping->id);
> +	kfree(mapping);
> +}
> +
> +static void unregister_dax_mapping(void *data)
> +{
> +	struct device *dev = data;
> +	struct dax_mapping *mapping = to_dax_mapping(dev);
> +	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> +	struct dax_region *dax_region = dev_dax->region;
> +
> +	dev_dbg(dev, "%s\n", __func__);
> +
> +	device_lock_assert(dax_region->dev);
> +
> +	dev_dax->ranges[mapping->range_id].mapping = NULL;
> +	mapping->range_id = -1;
> +
> +	device_del(dev);
> +	put_device(dev);
> +}
> +
> +static struct dev_dax_range *get_dax_range(struct device *dev)
> +{
> +	struct dax_mapping *mapping = to_dax_mapping(dev);
> +	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> +	struct dax_region *dax_region = dev_dax->region;
> +
> +	device_lock(dax_region->dev);
> +	if (mapping->range_id < 1) {
            ^^^^^^^^^^^^^^^^^^^^^ perhaps "mapping->range_id < 0" ?

AFAICT, invalid/disabled ranges have id to -1.

Otherwise we can't use mapping0 entry fields.

 Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
