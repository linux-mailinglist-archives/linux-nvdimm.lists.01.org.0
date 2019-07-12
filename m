Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B3967108
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Jul 2019 16:11:04 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B9297212B9A73;
	Fri, 12 Jul 2019 07:13:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=mst@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 80632212B7DB9
 for <linux-nvdimm@lists.01.org>; Fri, 12 Jul 2019 07:13:27 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0979930821C2;
 Fri, 12 Jul 2019 14:11:00 +0000 (UTC)
Received: from redhat.com (ovpn-116-209.ams2.redhat.com [10.36.116.209])
 by smtp.corp.redhat.com (Postfix) with SMTP id 7C6D31001B11;
 Fri, 12 Jul 2019 14:10:52 +0000 (UTC)
Date: Fri, 12 Jul 2019 10:10:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH v3] virtio_pmem: fix sparse warning
Message-ID: <20190712101021-mutt-send-email-mst@kernel.org>
References: <20190712051610.15478-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190712051610.15478-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 12 Jul 2019 14:11:00 +0000 (UTC)
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
Cc: linux-nvdimm@lists.01.org, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 yuval.shaia@oracle.com, virtualization@lists.linux-foundation.org,
 lcapitulino@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jul 12, 2019 at 10:46:10AM +0530, Pankaj Gupta wrote:
> This patch fixes below sparse warning related to __virtio
> type in virtio pmem driver. This is reported by Intel test
> bot on linux-next tree.
> 
> nd_virtio.c:56:28: warning: incorrect type in assignment
>                                 (different base types)
> nd_virtio.c:56:28:    expected unsigned int [unsigned] [usertype] type
> nd_virtio.c:56:28:    got restricted __virtio32
> nd_virtio.c:93:59: warning: incorrect type in argument 2
>                                 (different base types)
> nd_virtio.c:93:59:    expected restricted __virtio32 [usertype] val
> nd_virtio.c:93:59:    got unsigned int [unsigned] [usertype] ret
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Pls merge - I assume nvdimm tree?

> ---
> This fixes a warning, so submitting it as a separate
> patch on top of virtio pmem series.
> 
> v2-> v3
>  Use __le for req/resp fields - Michael
> 
>  drivers/nvdimm/nd_virtio.c       | 4 ++--
>  include/uapi/linux/virtio_pmem.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index 8645275c08c2..10351d5b49fa 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -53,7 +53,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>  	init_waitqueue_head(&req_data->host_acked);
>  	init_waitqueue_head(&req_data->wq_buf);
>  	INIT_LIST_HEAD(&req_data->list);
> -	req_data->req.type = cpu_to_virtio32(vdev, VIRTIO_PMEM_REQ_TYPE_FLUSH);
> +	req_data->req.type = cpu_to_le32(VIRTIO_PMEM_REQ_TYPE_FLUSH);
>  	sg_init_one(&sg, &req_data->req, sizeof(req_data->req));
>  	sgs[0] = &sg;
>  	sg_init_one(&ret, &req_data->resp.ret, sizeof(req_data->resp));
> @@ -90,7 +90,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>  	} else {
>  		/* A host repsonse results in "host_ack" getting called */
>  		wait_event(req_data->host_acked, req_data->done);
> -		err = virtio32_to_cpu(vdev, req_data->resp.ret);
> +		err = le32_to_cpu(req_data->resp.ret);
>  	}
>  
>  	kfree(req_data);
> diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
> index efcd72f2d20d..9a63ed6d062f 100644
> --- a/include/uapi/linux/virtio_pmem.h
> +++ b/include/uapi/linux/virtio_pmem.h
> @@ -23,12 +23,12 @@ struct virtio_pmem_config {
>  
>  struct virtio_pmem_resp {
>  	/* Host return status corresponding to flush request */
> -	__u32 ret;
> +	__le32 ret;
>  };
>  
>  struct virtio_pmem_req {
>  	/* command type */
> -	__u32 type;
> +	__le32 type;
>  };
>  
>  #endif
> -- 
> 2.14.5
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
