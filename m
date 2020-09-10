Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E3326435C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 10 Sep 2020 12:11:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DF877141F92F6;
	Thu, 10 Sep 2020 03:11:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DBBEF141F92F3
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 03:11:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h4so6445509ioe.5
        for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 03:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oq85Kv8Q2AnOzhchKRfF2cZCLjCk+7ncSapWENTEmk0=;
        b=NpOvnUxQq6zIh7M0z4jf/7u5uRWZt/oSXLnIqUkyv7UHc7QlSUjFlxN8w01avNNj5R
         GIm+2WkUVIuiSioAVODbjW358fbxikoLVuYG4exvQcak7FjX/IiYRTX2PzzNjc1PoJFu
         DWSfs6JHmRc2Fx5/G78235gadr2zBFYDEN1v+xGV8GrXaDQz8ZvlkBF/g2ayWbki0KPT
         UdJIeElMyVOnUo3VuKz0UrZvS7qPqc2RKC3bpuoCD/bYQR81k8PL1p1o8VuZrhgjA0mY
         MtYtT/CLOcJb6YQ7fiCkCbegRa2yQUPI4mkjZ52U8tPadGGyP0T2+W8VV4KaZiJBn7fI
         xh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oq85Kv8Q2AnOzhchKRfF2cZCLjCk+7ncSapWENTEmk0=;
        b=p5boN3sWJgLYOByHENsoTBUHBZJ04TobQo1pRdmWjCWISBEermkUF2lt+4vOP+E3ej
         mDIwuHk3wuMI5UzFZGf6S9jd72u0JDOLR9rWPdqqiai4fCqLQUjL0JwRgBq3xHCwfIsJ
         rIFynDhRy8EcUxrjpxy4rUPA9dD+jPOeE2kgaMW5ww0fTb9vFVznGrmlhgicQDAKUQFD
         TCi+Ol7IxJX7qybMq4AGLf/3bjnnz2t/2HnNcakwOIekQ3o+B/kVQZDAfFn8+ia9EMw3
         zhmtFSv5z8GoMqx2Q7bm8SRqMs8M7yVnM26yZXYzzKbJRI/1oDvc/3hjmztF8k+btO3X
         iyPg==
X-Gm-Message-State: AOAM533p+40GRiwoxsyXQ9rjNa+z71uVC4z2lTWEhTleuFjZeQBCWltn
	0PWeD9ACb8aLZ3xGrenEDZLrwJBMFXXRWzuNPX4=
X-Google-Smtp-Source: ABdhPJzKGRYgqpr+9cz3Q74NoY3jG8toy/e9Rt6AOpX9QHNPs+I2y7L9ikBZUu1GNvFqq1njb4EKG9NdktrkvXJEm78=
X-Received: by 2002:a6b:fb0c:: with SMTP id h12mr6197002iog.98.1599732666180;
 Thu, 10 Sep 2020 03:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200910091340.8654-1-david@redhat.com> <20200910091340.8654-6-david@redhat.com>
In-Reply-To: <20200910091340.8654-6-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 10 Sep 2020 12:10:54 +0200
Message-ID: <CAM9Jb+jQP+n-bCxYHTwOFQm-+D3VZj+MhqmUMnu9xVoxs2a4VA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] virtio-mem: try to merge system ram resources
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: B6EPAEQK6VH3GHDM3VPMZP6BO2TDBLLP
X-Message-ID-Hash: B6EPAEQK6VH3GHDM3VPMZP6BO2TDBLLP
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Linux MM <linux-mm@kvack.org>, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Baoquan He <bhe@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B6EPAEQK6VH3GHDM3VPMZP6BO2TDBLLP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
