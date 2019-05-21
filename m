Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C0B2557F
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 May 2019 18:24:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8869F2127545D;
	Tue, 21 May 2019 09:24:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EF0A2212108FE
 for <linux-nvdimm@lists.01.org>; Tue, 21 May 2019 09:24:40 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4368830833AF;
 Tue, 21 May 2019 16:24:29 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1465F4387;
 Tue, 21 May 2019 16:24:24 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id C3F6A5B423;
 Tue, 21 May 2019 16:24:14 +0000 (UTC)
Date: Tue, 21 May 2019 12:24:14 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <176786650.30122184.1558455854322.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190521094543-mutt-send-email-mst@kernel.org>
References: <20190521133713.31653-1-pagupta@redhat.com>
 <20190521133713.31653-3-pagupta@redhat.com>
 <20190521094543-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v10 2/7] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
X-Originating-IP: [10.67.116.105, 10.4.195.14]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: 3AiQ7PJb9jLe5p+DRlEZBNdQ18HFYA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 21 May 2019 16:24:39 +0000 (UTC)
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
Cc: rdunlap@infradead.org, jack@suse.cz, kvm@vger.kernel.org, david@redhat.com,
 jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
 adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org,
 aarcange@redhat.com, jstaron@google.com, linux-nvdimm@lists.01.org,
 willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org,
 linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl,
 riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com,
 imammedo@redhat.com, lcapitulino@redhat.com, kwolf@redhat.com,
 nilal@redhat.com, tytso@mit.edu,
 xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, snitzer@redhat.com,
 cohuck@redhat.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, pbonzini@redhat.com,
 darrick wong <darrick.wong@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


> > diff --git a/include/uapi/linux/virtio_pmem.h
> > b/include/uapi/linux/virtio_pmem.h
> > new file mode 100644
> > index 000000000000..7a3e2fe52415
> > --- /dev/null
> > +++ b/include/uapi/linux/virtio_pmem.h
> > @@ -0,0 +1,35 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> > +/*
> > + * Definitions for virtio-pmem devices.
> > + *
> > + * Copyright (C) 2019 Red Hat, Inc.
> > + *
> > + * Author(s): Pankaj Gupta <pagupta@redhat.com>
> > + */
> > +
> > +#ifndef _UAPI_LINUX_VIRTIO_PMEM_H
> > +#define _UAPI_LINUX_VIRTIO_PMEM_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/virtio_types.h>
> > +#include <linux/virtio_ids.h>
> > +#include <linux/virtio_config.h>
> > +
> > +struct virtio_pmem_config {
> > +	__le64 start;
> > +	__le64 size;
> > +};
> > +
> 
> config generally should be __u64.
> Are you sure sparse does not complain?

I used this because VIRTIO 1.1 spec says: 
"The device configuration space uses the little-endian format for multi-byte fields. "

and __le64 looks ok to me. Also, its used in other driver config as welle.g virtio-vsock

> 
> 
> > +#define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
> > +
> > +struct virtio_pmem_resp {
> > +	/* Host return status corresponding to flush request */
> > +	__virtio32 ret;
> > +};
> > +
> > +struct virtio_pmem_req {
> > +	/* command type */
> > +	__virtio32 type;
> > +};
> > +
> > +#endif
> > --
> > 2.20.1
> 
> Sorry why are these __virtio32 not __le32?

I used __virtio32 for data fields for guest and host supporting different endianess.
 
Thanks,
Pankaj
> 
> --
> MST
> 
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
