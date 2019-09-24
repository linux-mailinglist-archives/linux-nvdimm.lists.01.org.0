Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D90FBC73B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Sep 2019 13:53:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3F3CB202F73B0;
	Tue, 24 Sep 2019 04:55:22 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C97F5202F73A3
 for <linux-nvdimm@lists.01.org>; Tue, 24 Sep 2019 04:55:21 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 53B17308FEC1;
 Tue, 24 Sep 2019 11:52:58 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B5F65B69A;
 Tue, 24 Sep 2019 11:52:58 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 273544E58A;
 Tue, 24 Sep 2019 11:52:58 +0000 (UTC)
Date: Tue, 24 Sep 2019 07:52:58 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <35214623.2704138.1569325978098.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190924114327.14700-1-aneesh.kumar@linux.ibm.com>
References: <20190924114327.14700-1-aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] libnvdimm/region: Update is_nvdimm_sync check to handle
 volatile regions
MIME-Version: 1.0
X-Originating-IP: [10.67.116.165, 10.4.195.2]
Thread-Topic: libnvdimm/region: Update is_nvdimm_sync check to handle volatile
 regions
Thread-Index: fmLatXN7Ahr5iO2kk51AwlLt6dYpZw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 24 Sep 2019 11:52:58 +0000 (UTC)
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
Cc: linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


> 
> We should consider volatile regions synchronous so that we are resilient to
> OS crashes. This is needed when we have hypervisor like KVM exporting a
> ramdisk
> as pmem dimms.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/nvdimm/region_devs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index ab91890f2486..ef423ba1a711 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1168,6 +1168,9 @@ EXPORT_SYMBOL_GPL(nvdimm_has_cache);
>  
>  bool is_nvdimm_sync(struct nd_region *nd_region)
>  {
> +	if (is_nd_volatile(&nd_region->dev))
> +		return true;
> +
>  	return is_nd_pmem(&nd_region->dev) &&
>  		!test_bit(ND_REGION_ASYNC, &nd_region->flags);
>  }
> --
> 2.21.0

Reviewed-by: Pankaj Gupta <pagupta@redhat.com>

> 
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
