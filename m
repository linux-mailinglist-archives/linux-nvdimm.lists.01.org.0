Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE8135F170
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Apr 2021 12:23:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 07F42100F2263;
	Wed, 14 Apr 2021 03:23:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.166.41; helo=mail-io1-f41.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EBDEB100EB338
	for <linux-nvdimm@lists.01.org>; Wed, 14 Apr 2021 03:23:29 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id s16so14869239iog.9
        for <linux-nvdimm@lists.01.org>; Wed, 14 Apr 2021 03:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMW3nxFYepxawXrZMQ8uUIchkTpkmGCIJAQvAUQJRIc=;
        b=LLMYh428GZ0EIgOPj5nDcC+0Qqgx/RfRxB262hGCKJBBzpvqKIgClNR/njPDsbfPbG
         D9oiosHDaNPp31RwVQgCl5NDcFilU2pk86n/5iivZ9IpeazN79brsvGJPEQYfut+F58a
         sZweohge02krtmNxZXojH44wOj/ZBaQqVpz+JH22tO9obGpviyw1WRbPt+haSbkio6Ln
         v5qu9SaAPOjdusFIGpYE05kL4tYAWLk86cT0VvsiczDP4tdHYwBIifoeHAU2SeLvalwm
         FVtVnPgljiTanJJaq6UT6m2C5K9nPaIezBIsXAxdXQayza4GR6iRumqaDBugGJgX+SmE
         bTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMW3nxFYepxawXrZMQ8uUIchkTpkmGCIJAQvAUQJRIc=;
        b=EZHsgFaGtok86pTfrQcvdlcD87sX/lasl8KzOeIwVTngQGmX20z8Es+jZfCgXx2/wr
         gdfPu/lQcijggZ+8Cg4WBLP13tEAz6+2hn9Y+ux43azimsCZ+5EZPtlP6V6HZtYdND4e
         1ZgjFb3W3dHLOSOJ6ef4EZTWu5/G4DwKRJhiDdkzayM+qdW+8Bh3QXkJTHvd/qm6PaGr
         ZtKRsF0Oz1JDT2g4br5Spjru5tlB/DOQasLdipfBUaxdNPGNH6YJFvGI+HinjnghMLbc
         GhBl/d5c1rt/lMARR5a5TLaQMdVVt3YbVzx6Qr290MYOVwj07mVMdE8ZnB8G7zM1kkvh
         LNVw==
X-Gm-Message-State: AOAM530HBlqMxCebuUUZVsshex1mIC1DOgs8s9XwDfeGzud8S2ye2jgl
	b8QleZv9xMRgPpT1Dg24A+Y3OzxSUEs+72WbYE84ha359d3Oaw==
X-Google-Smtp-Source: ABdhPJzW6Rb5wJUdIoaDtNtPNuFP2E5Y6Rh3/+XepOW+b1LXqd+0RvVJZWfQcs810cb016EIeOM/moQMud9BKOCRxuo=
X-Received: by 2002:a6b:7d4c:: with SMTP id d12mr29946517ioq.162.1618395749113;
 Wed, 14 Apr 2021 03:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210408104622.943843-1-vaibhav@linux.ibm.com>
 <CAM9Jb+j6oVumXQ+zmYbQSvQ3UzLKT3V8XLq1SotVcwVuUwP09A@mail.gmail.com> <87r1jejkx1.fsf@vajain21.in.ibm.com>
In-Reply-To: <87r1jejkx1.fsf@vajain21.in.ibm.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 14 Apr 2021 12:22:18 +0200
Message-ID: <CAM9Jb+je_aEyd_c4zhP+r3ubSxfpcmjdfdez4yvUWYAESh8S4w@mail.gmail.com>
Subject: Re: [PATCH v3] libnvdimm/region: Update nvdimm_has_flush() to handle
 explicit 'flush' callbacks
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID-Hash: Z3GT3JDHGLU4K3IPTGKYTLPAKS6XHCLS
X-Message-ID-Hash: Z3GT3JDHGLU4K3IPTGKYTLPAKS6XHCLS
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org, Shivaprasad G Bhat <sbhat@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z3GT3JDHGLU4K3IPTGKYTLPAKS6XHCLS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> >> In case a platform doesn't provide explicit flush-hints but provides an
> >> explicit flush callback, then nvdimm_has_flush() still returns '0'
> >> indicating that writes do not require flushing. This happens on PPC64
> >> with patch at [1] applied, where 'deep_flush' of a region was denied
> >> even though an explicit flush function was provided.
> >>
> >> Similar problem is also seen with virtio-pmem where the 'deep_flush'
> >> sysfs attribute is not visible as in absence of any registered nvdimm,
> >> 'nd_region->ndr_mappings == 0'.
> >
> > In case of async flush callback, do we still need "deep_flush" ?
>
> 'deep_flush' in libnvdimm (specifically 'deep_flush_store()')
> anyways resorts to calling 'async_flush' callback if its defined. Which
> makes sense to me since in absence of eADR, 'echo 1 > deep_flush' would
> ensure that writes to pmem are now durable even if there is a sudden
> power loss before cpu caches are flushed.
>
> On non-nfit architectures the 'async_flush' callback should provide such
> a guarantee, which can be triggered by user-space writing to the
> 'deep_flush' sysfs attr.
>
> In absence of 'deep_flush' sysfs attr not sure how else can user-space
> forcibly trigger async_flush callback for dev-dax char devices.

O.k. that means for filesystem DAX deep_flush is alternative to
fsync/msync call.

I still have to dig deeper to understand more about "QUEUE_FLAG_FUA" flag &
why I was seeing REQ_FUA with virtio-pmem when doing fsync if its not enabled
in function "blk_queue_write_cache". But this is for my understanding.

Overall patch looks good to me and it looks to solve (not tested
though) the warning for
virtio-pmem as well.

Reviewed-by: Pankaj Gupta <pankaj.gupta@ionos.com>



Thanks,
Pankaj
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
