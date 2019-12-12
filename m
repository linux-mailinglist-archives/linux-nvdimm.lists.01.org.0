Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD3711D76B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 20:48:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E4A9810113675;
	Thu, 12 Dec 2019 11:51:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DA04210113674
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 11:51:46 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id g18so3172472otj.13
        for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 11:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCyIPGmm9pZuYaQMe79zFMPFkP+ZmU5MS9AqbrmOwNc=;
        b=LmjiQ6Y3tpZugdSlcd+rg78aUn32879Bmxoumcf4KtU4qEAgEeHxpK3vJ4j9jpWpMh
         JsLVy7vBtDiZk4VOuSzIhNw+9K06juyjGnCjyhs7/uXCpyz631P3upDuCVpFgK2V30sp
         tKtBuYVRFL4i3YF+l2aDofmf2mK6zJHfA5320/V6GNaGIvm/PqzywZrsKsZc4jlmITKC
         7R5mNM5l6eYcYrg3mHWmSmY8L6/+uimFf0EZYK1MJD9sBfvRH/BwyszifUjKV+QQWPGm
         dk679DjdoxZI1D9tifTljqmV8jAY5/R1qgvveZ7l9+q7CPsdFBPIhM0T45oNcJhJWRfd
         bG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCyIPGmm9pZuYaQMe79zFMPFkP+ZmU5MS9AqbrmOwNc=;
        b=PAt5dlO7HtRLEUlMpwYuwtaJZA94IZbky8J0CZau8S7YoU6u+674YDSFLOJUU7k2y7
         Gj0SMxYfDc+BcLjWIiQqs6IAII4XCwzYQMOO0X5/WUqdgesL2jLoAO6m4RAfDKZ4Y8uj
         fU1VKxhfxtoJzOyfFyABsW1VnIqVBUmE5AuceQ5Tf7GtmM/XDOZPJFxRPzf8r8x4oFN3
         IdQRi4s1d1rURMzl8EE+8zC0hRUVyFNjoFEMeZ0KUG4DXnc3rNn+Xrx/UMw5ixS91an/
         6HA/CaEO+oDB2tfo5KjmHxlegzYZmfPJi/vfGR9LqoOfe53Yr6VfrAZjQo06dYyGCVEl
         SiAg==
X-Gm-Message-State: APjAAAVRq0wV/HIde+Cmn2ONMqYG+qkWSd7srjVnMCPnZgNIoomVFynE
	wh940mQW8ZXKJNLup9QjgIw/dPVKkl85M6h/3mZFT1MNakg=
X-Google-Smtp-Source: APXvYqzSgglPxYBD4ccergwRG+u4Anxgb6meYuHJx5pCaklA2pqhIlpF+AZ2F0oXzqKQ2x/j6OoRxHdmvgE++DyDBmA=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr10276651otk.363.1576180103398;
 Thu, 12 Dec 2019 11:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20191211213207.215936-1-brho@google.com> <20191211213207.215936-3-brho@google.com>
 <20191212173413.GC3163@linux.intel.com> <CAPcyv4hkz8XCETELBaUOjHQf3=VyVB=KWeRVEPYejvdsg3_MWA@mail.gmail.com>
 <b50720a2-5358-19ea-a45e-a0c0628c68b0@google.com>
In-Reply-To: <b50720a2-5358-19ea-a45e-a0c0628c68b0@google.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Dec 2019 11:48:12 -0800
Message-ID: <CAPcyv4h19dKGpz0XzEHz0nOddnRAefE=rOuhGTHEL6FPhqk8GQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
To: Barret Rhoden <brho@google.com>
Message-ID-Hash: 35BQ5MOMVFDK65HHRP27KV6VN4FO62IC
X-Message-ID-Hash: 35BQ5MOMVFDK65HHRP27KV6VN4FO62IC
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Sean Christopherson <sean.j.christopherson@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zeng, Jason" <jason.zeng@intel.com>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/35BQ5MOMVFDK65HHRP27KV6VN4FO62IC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 12, 2019 at 11:16 AM Barret Rhoden <brho@google.com> wrote:
>
> On 12/12/19 12:37 PM, Dan Williams wrote:
> > Yeah, since device-dax is the only path to support longterm page
> > pinning for vfio device assignment, testing with device-dax + 1GB
> > pages would be a useful sanity check.
>
> What are the issues with fs-dax and page pinning?  Is that limitation
> something that is permanent and unfixable (by me or anyone)?

It's a surprisingly painful point of contention...

File backed DAX pages cannot be truncated while the page is pinned
because the pin may indicate that DMA is ongoing to the file block /
DAX page. When that pin is from RDMA or VFIO that creates a situation
where filesystem operations are blocked indefinitely. More details
here: 94db151dc892 "vfio: disable filesystem-dax page pinning".

Currently, to prevent the deadlock, RDMA, VFIO, and IO_URING memory
registration is blocked if the mapping is filesystem-dax backed (see
the FOLL_LONGTERM flag to get_user_pages).

One of the proposals to break the impasse was to allow the filesystem
to forcibly revoke the mapping. I.e. to use the IOMMU to forcibly kick
the RDMA device out of its registration. That was rejected by RDMA
folks because RDMA applications are not prepared for this revocation
to happen and the application that performed the registration may not
be the application that uses the registration. There was an attempt to
use a file lease to indicate the presence of a file /
memory-registration that is blocking file-system operations, but that
was still less palatable to filesystem folks than just keeping the
status quo of blocking longterm pinning.

That said, the VFIO use case seems a different situation than RDMA.
There's often a 1:1 relationship between the application performing
the memory registration and the application consuming it, the VMM, and
there is always an IOMMU present that could revoke access and kill the
guest is the mapping got truncated. It seems in theory that VFIO could
tolerate a "revoke pin on truncate" mechanism where RDMA could not.

> I'd like to put a lot more in a DAX/pmem region than just a guest's
> memory, and having a mountable filesystem would be extremely convenient.

Why would page pinning be involved in allowing the guest to mount a
filesystem on guest-pmem? That already works today, it's just the
device-passthrough that causes guest memory to be pinned indefinitely.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
