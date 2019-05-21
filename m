Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0563825120
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 May 2019 15:51:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 144E42127545A;
	Tue, 21 May 2019 06:51:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.160.193; helo=mail-qt1-f193.google.com;
 envelope-from=mst@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5015F212657BD
 for <linux-nvdimm@lists.01.org>; Tue, 21 May 2019 06:51:39 -0700 (PDT)
Received: by mail-qt1-f193.google.com with SMTP id t1so20487049qtc.12
 for <linux-nvdimm@lists.01.org>; Tue, 21 May 2019 06:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TK1+q9ordzXuZZneT1jdBLnWaxfhFR3So8YN5DgmZPE=;
 b=qRTmjLKRcMgpS23sZc001JzBuvCIYmKFThoUTaRyBXH1a+7YfX8i7UwkeksdUt7n9r
 d3mzCbnx6AkmnjuKvTcEAUcE5VeFpcxK4FzGtfJy08rU2/mUXJcUTowvMAMXk0E2IRKy
 cQ4wkBaSUcGJIMo3TgFpLcANxGQjp2cJcnmbi57vNK8DLyBVbfUvbFFqeh6rXOTO4quz
 GDvmPVkTSCsIFEJbEgBS6M/0tgIK5jWm1Ggp3TMevd3tE+KycmG0EfpxvIsXbbbLmDuG
 b65qqf48Ko5nSDWPhI+Cok5n4YCE+TMoV4CXIpahOaVA0JinxqQO0Jathb8daYdyOOG+
 3fYg==
X-Gm-Message-State: APjAAAWYJijc9fdjPgAkZfrlWyb4qrPw20WDYQnV89r6vuiIdYpz0gX6
 0uux8JRe2nMRkKucst8FSQEUmQ==
X-Google-Smtp-Source: APXvYqyh4Hn5uFOLIUZJ6Or+HOPTIpSiSFn1uSWJgwWbt4T3Cy3pGgBfYiLTVuICBM9UJLxQWjWXvw==
X-Received: by 2002:ac8:5218:: with SMTP id r24mr28772252qtn.177.1558446698964; 
 Tue, 21 May 2019 06:51:38 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
 [173.76.105.71])
 by smtp.gmail.com with ESMTPSA id q27sm13106373qtf.27.2019.05.21.06.51.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 21 May 2019 06:51:37 -0700 (PDT)
Date: Tue, 21 May 2019 09:51:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH v10 2/7] virtio-pmem: Add virtio pmem driver
Message-ID: <20190521094543-mutt-send-email-mst@kernel.org>
References: <20190521133713.31653-1-pagupta@redhat.com>
 <20190521133713.31653-3-pagupta@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190521133713.31653-3-pagupta@redhat.com>
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
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, david@redhat.com,
 jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
 adilger.kernel@dilger.ca, zwisler@kernel.org, aarcange@redhat.com,
 jstaron@google.com, linux-nvdimm@lists.01.org, willy@infradead.org,
 hch@infradead.org, linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org,
 lenb@kernel.org, kilobyte@angband.pl, rdunlap@infradead.org, riel@surriel.com,
 yuval.shaia@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
 lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com, tytso@mit.edu,
 xiaoguangrong.eric@gmail.com, snitzer@redhat.com, darrick.wong@oracle.com,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, imammedo@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 21, 2019 at 07:07:08PM +0530, Pankaj Gupta wrote:
> diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
> new file mode 100644
> index 000000000000..7a3e2fe52415
> --- /dev/null
> +++ b/include/uapi/linux/virtio_pmem.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/*
> + * Definitions for virtio-pmem devices.
> + *
> + * Copyright (C) 2019 Red Hat, Inc.
> + *
> + * Author(s): Pankaj Gupta <pagupta@redhat.com>
> + */
> +
> +#ifndef _UAPI_LINUX_VIRTIO_PMEM_H
> +#define _UAPI_LINUX_VIRTIO_PMEM_H
> +
> +#include <linux/types.h>
> +#include <linux/virtio_types.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_config.h>
> +
> +struct virtio_pmem_config {
> +	__le64 start;
> +	__le64 size;
> +};
> +

config generally should be __u64.
Are you sure sparse does not complain?


> +#define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
> +
> +struct virtio_pmem_resp {
> +	/* Host return status corresponding to flush request */
> +	__virtio32 ret;
> +};
> +
> +struct virtio_pmem_req {
> +	/* command type */
> +	__virtio32 type;
> +};
> +
> +#endif
> -- 
> 2.20.1

Sorry why are these __virtio32 not __le32?

-- 
MST
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
