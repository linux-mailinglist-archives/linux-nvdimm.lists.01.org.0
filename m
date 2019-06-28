Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABE85A4A9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 20:59:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6BE4B212AB4FA;
	Fri, 28 Jun 2019 11:59:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E6B6D21959CB2
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 11:59:30 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id d17so7020967oth.5
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xZKi8dPs5bce5TA+lDYDR67LZgo76bXK/epIzKFvivc=;
 b=w73nxePK59nSfEruxrF1M0kHpQTfXV+T0BR3rvgPNUWzxDsJQPeaM7uFD7eKRrxE9Y
 9ImwGmBtt6yXJ6nlctHx0FbYi1ua/8g/5ZblEqYZrPEU8IkQx9AAwyacMH73KkUPSZW4
 2CnxLw8FBn5LZR6QuLzXXkPegk+n9WnVTkvOy7EQwUeDTJ/KqrjyTyioxg0mlKF5l5Fl
 pBgbtoepm7/tvV+XTP8uNL6F6V5682w/nGp9yu+fmrqAAOl3CXi6A8E63DaUmygnIHBK
 Lo3TxfO9CsdVEHmVkApvqnki+XHSFnPPV047Ep963nO0SUi6VwELdrivAHXWP8JUXEYH
 XM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xZKi8dPs5bce5TA+lDYDR67LZgo76bXK/epIzKFvivc=;
 b=P0q78zukuyyFPUYCet0Xs5yXy+LNywmfzs+yryX2iV8h+KZkb/daMHQ4s1NksBK62R
 wqNLP8tofAcybVGgcbu8LL5jHGefIM5CeVgG7luFZ0KBMa8QQMJJ64lj9dZ/9y6IOy6n
 Hng5Fx0TTRgwl/7VVFoBa/yFT9SGmzCpK6Lh2evXskOoWoVaTdBkKrQLfjx/A2HU+mU/
 biP8grkShq6rqQyDQGYP074tZ0SXCUVuDJz4le2OhSXEMVXn0DSxYwrG90UTq/qz3fhA
 XIpnOnc6P4RNO2153y+IIGUfXVb6e1a6c0b6doUczlKLf9wj3+nxDpTO60HnZ9mzkiZ5
 pgxQ==
X-Gm-Message-State: APjAAAXC/jDcWKkz0K9mcMrvvTNdUBGhvH79GNe43/jFzdf+Msv0ldtj
 3Mj4Qn1erKJEuu8ornJHikcqVAlbWNqmzWctOu4N8Q==
X-Google-Smtp-Source: APXvYqxUAlE0PhQVf+kI2qGh3xwcV/BdcPGn6HCqEnYJmqo0MIx4gI+EfnCAuColBmsblnHh366HyPqaX1Z8NdWYLok=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr8858325otn.247.1561748370285; 
 Fri, 28 Jun 2019 11:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-17-hch@lst.de>
 <20190628153827.GA5373@mellanox.com>
 <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
 <20190628170219.GA3608@mellanox.com>
 <CAPcyv4ja9DVL2zuxuSup8x3VOT_dKAOS8uBQweE9R81vnYRNWg@mail.gmail.com>
 <CAPcyv4iWTe=vOXUqkr_CguFrFRqgA7hJSt4J0B3RpuP-Okz0Vw@mail.gmail.com>
 <20190628182922.GA15242@mellanox.com>
 <CAPcyv4g+zk9pnLcj6Xvwh-svKM+w4hxfYGikcmuoBAFGCr-HAw@mail.gmail.com>
 <20190628185152.GA9117@lst.de>
In-Reply-To: <20190628185152.GA9117@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 28 Jun 2019 11:59:19 -0700
Message-ID: <CAPcyv4i+b6bKhSF2+z7Wcw4OUAvb1=m289u9QF8zPwLk402JVg@mail.gmail.com>
Subject: Re: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
To: Christoph Hellwig <hch@lst.de>
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 28, 2019 at 11:52 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 28, 2019 at 11:44:35AM -0700, Dan Williams wrote:
> > There is a problem with the series in CH's tree. It removes the
> > ->page_free() callback from the release_pages() path because it goes
> > too far and removes the put_devmap_managed_page() call.
>
> release_pages only called put_devmap_managed_page for device public
> pages.  So I can't see how that is in any way a problem.

It's a bug that the call to put_devmap_managed_page() was gated by
MEMORY_DEVICE_PUBLIC in release_pages(). That path is also applicable
to MEMORY_DEVICE_FSDAX because it needs to trigger the ->page_free()
callback to wake up wait_on_var() via fsdax_pagefree().

So I guess you could argue that the MEMORY_DEVICE_PUBLIC removal patch
left the original bug in place. In that sense we're no worse off, but
since we know about the bug, the fix and the patches have not been
applied yet, why not fix it now?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
