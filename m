Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 128201CF91
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 21:04:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B8FC21275451;
	Tue, 14 May 2019 12:04:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D87C12121797E
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 12:04:51 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r136so12973931oie.7
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 12:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3MJ8G8iFv7+woc8MxzlUA/t0B24IADDceJ2Iwj8h/Xc=;
 b=KHiq4DTxHeWZ7ZhUHDu3H0zQSi38koEkJT4e3DrcIHpodiGs1HmKFmBuIkUh6+Jaa6
 Y/6A3+PwUYWdyOE3xHPlQjkdirSldkEQvcF+hSK5PhGF+ve9zGZzPoeGLFq3W6qtz6NA
 kemlQvGyqbc8CBla4gR77VFkJN2TIyWfePCyJM6m/C4rSu7hdxOK6qSS5wXzCwiLJPjR
 EFV9Qt/uXDgOed+YJWpYGiaa+/VXmapf3qo/gqjYzLasnINwuvH9MOZ9oX19+TJjCCEw
 7PVMvruc5jDesaE1Kc1h+pAZwRVdmIsHKWevuatJQOKhRbc7N2LS+/XL5FBeHjMz/aOi
 iGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3MJ8G8iFv7+woc8MxzlUA/t0B24IADDceJ2Iwj8h/Xc=;
 b=uN1hjs26IKTRLKfN/LO9rnHZEZ7U3jT999vPEz5Sqti7o53cN0ptvhYH6t6RwLareX
 0RyxCQkjdnV3CL298sr5JVqpBj9bHM8UHk05/BE3cEiA/WAHlj0kTMez6PNgjTsi0ba9
 7ViNQn/Dd3fhC4zFQqmvIABrd5PS+Ljg+bxhqcOsiIRsEHxNMtFbDNRtOjzTxBE4Nl3Y
 bJ77eYr8EdBlHuXKQVvR0lRrD0v311N28r4JUpm1J+AlhPgJedMEz10tump1/uUR67LW
 8JEPPbmkVNiV+QECJSnggyX6sio2uujzxjGm4/gBIZMhrJhLoWtbSEddRxxZh7v56Ya4
 sz1A==
X-Gm-Message-State: APjAAAVQHe6SMgfvPteElvGErGT5a4TSmRZO+2NV3D1ykgMCQcuQHNuE
 LsSi6fB5Kf+wKjVPmfQxJXoWdFWh7DvV5z0wLs/SQA==
X-Google-Smtp-Source: APXvYqx10sN10v6S3En1NMksHnyYHTQr2N9LW12pza7Vp5Lf8RW1bTEysUgnoVyxZuM89zNVotYaW0eHbtxS8r7LtXQ=
X-Received: by 2002:aca:ab07:: with SMTP id u7mr73100oie.73.1557860689951;
 Tue, 14 May 2019 12:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
 <059859ca-3cc8-e3ff-f797-1b386931c41e@deltatee.com>
 <17ada515-f488-d153-90ef-7a5cc5fefb0f@deltatee.com>
 <8a7cfa6b-6312-e8e5-9314-954496d2f6ce@oracle.com>
In-Reply-To: <8a7cfa6b-6312-e8e5-9314-954496d2f6ce@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 14 May 2019 12:04:38 -0700
Message-ID: <CAPcyv4i28tQMVrscQo31cfu1ZcMAb74iMkKYhu9iO_BjJvp+9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm/devm_memremap_pages: Fix page release race
To: Jane Chu <jane.chu@oracle.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 14, 2019 at 11:53 AM Jane Chu <jane.chu@oracle.com> wrote:
>
> On 5/13/2019 12:22 PM, Logan Gunthorpe wrote:
>
> On 2019-05-08 11:05 a.m., Logan Gunthorpe wrote:
>
> On 2019-05-07 5:55 p.m., Dan Williams wrote:
>
> Changes since v1 [1]:
> - Fix a NULL-pointer deref crash in pci_p2pdma_release() (Logan)
>
> - Refresh the p2pdma patch headers to match the format of other p2pdma
>    patches (Bjorn)
>
> - Collect Ira's reviewed-by
>
> [1]: https://lore.kernel.org/lkml/155387324370.2443841.574715745262628837.stgit@dwillia2-desk3.amr.corp.intel.com/
>
> This series looks good to me:
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>
> However, I haven't tested it yet but I intend to later this week.
>
> I've tested libnvdimm-pending which includes this series on my setup and
> everything works great.
>
> Just wondering in a difference scenario where pmem pages are exported to
> a KVM guest, and then by mistake the user issues "ndctl destroy-namespace -f",
> will the kernel wait indefinitely until the user figures out to kill the guest
> and release the pmem pages?

It depends on whether the pages are pinned. Typically DAX memory
mappings assigned to a guest are not pinned in the host and can be
invalidated at any time. The pinning only occurs with VFIO and
device-assignment which isn't the common case, especially since that
configuration is blocked by fsdax. However, with devdax, yes you can
arrange for the system to go into an indefinite wait.

This somewhat ties back to the get_user_pages() vs DAX debate. The
indefinite stall issue with device-assignment could be addressed with
a requirement to hold a lease and expect that a lease revocation event
may escalate to SIGKILL in response to 'ndctl destroy-namespace'. The
expectation with device-dax is that it is already a raw interface with
pointy edges and caveats, but I would not be opposed to introducing a
lease semantic.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
