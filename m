Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F10915A4FA
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 21:14:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65512212ABA25;
	Fri, 28 Jun 2019 12:14:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D111121295C88
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 12:14:55 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id s20so7068321otp.4
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3EPvpztsPK7520nxsbDhjXQoNlIusJTLU8rYF+ocke4=;
 b=jX7l/aScOnNag6NN8PLCh3f8Z8jWQa8rXqdmRFTm19zC5cGsMg4bGsXFEunae/2WjS
 ovvvaTeYJH2utyMhChKwGiGq8ZBoeIIKayiImspczzJ8SDCf8XDDL3viRbXyjtD1lYaK
 kzh/gY0uzN3viGFbDD3U65We27uV73cZy9DpexfMTRSqDZy8x6zljmPhhW1gZcx2hqFe
 GQ/mPFT2QGn+yrEJgjwPpeYXNTM2MxsKsrWYit2Wtxn/cph7hWSIQxFHWHLu8ToPNVuS
 0Ys9z5mBN7oGuoBHQrTDBIA0uIvuwg0tIL5G5RHXTDvUcDFV767ifaCgmnx0wSkTm7cV
 iWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3EPvpztsPK7520nxsbDhjXQoNlIusJTLU8rYF+ocke4=;
 b=LaWN1SSdj5a/Gg73VebWh+gj9xSvZhv33g76iF4zT9rCNPGZVvCG5faGCDUmPe1I8N
 fVrni/RokBn19LUuNWgdcwK4gOEL62kWdoID80QrjTyDe2rtJ/+5ecP2lCJe/2s2FKYC
 H+LCJ7wK32TybVYbvUBGeYtU/sB/Y8Li40J0EHVyt9zAj/KM1+curCj59U6RsKFNe0hA
 XgR0DDpgBNJc8kT2hHvrj2MIS1YdrWVLdCm5xt0LVa08+DAAPB8vEBtWuwV7hiclwp3o
 sNHY5dtb+6VK8Ed/3lPTM2IqH029VVGlYZXxcRNtzvUAqpEHiRRQw5S37fyOoW/Nwper
 BeAQ==
X-Gm-Message-State: APjAAAUMVC00xbLJgXW4b5WE82m9oX/5/xwLQBwiQ9iRILFst9B6xMsY
 JA6uWRWtyfHHnlywayiFen6eiXVmc3Ebebx8kRL95A==
X-Google-Smtp-Source: APXvYqwk0yjTvQhVqTpz4jl7ioGiwvBTeiygz26S4gTf6ee6guEN0yjq3zRwNg6EKq8iXaiv+Kpq8rgpgiSlzbcUkgY=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr8541745otn.71.1561749295055; 
 Fri, 28 Jun 2019 12:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190626122724.13313-17-hch@lst.de>
 <20190628153827.GA5373@mellanox.com>
 <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
 <20190628170219.GA3608@mellanox.com>
 <CAPcyv4ja9DVL2zuxuSup8x3VOT_dKAOS8uBQweE9R81vnYRNWg@mail.gmail.com>
 <CAPcyv4iWTe=vOXUqkr_CguFrFRqgA7hJSt4J0B3RpuP-Okz0Vw@mail.gmail.com>
 <20190628182922.GA15242@mellanox.com>
 <CAPcyv4g+zk9pnLcj6Xvwh-svKM+w4hxfYGikcmuoBAFGCr-HAw@mail.gmail.com>
 <20190628185152.GA9117@lst.de>
 <CAPcyv4i+b6bKhSF2+z7Wcw4OUAvb1=m289u9QF8zPwLk402JVg@mail.gmail.com>
 <20190628190207.GA9317@lst.de>
In-Reply-To: <20190628190207.GA9317@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 28 Jun 2019 12:14:44 -0700
Message-ID: <CAPcyv4h90DAVHbZ4bgvJwpfB8wr2K28oEes6HcdQOpf02+NL=g@mail.gmail.com>
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

On Fri, Jun 28, 2019 at 12:02 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 28, 2019 at 11:59:19AM -0700, Dan Williams wrote:
> > It's a bug that the call to put_devmap_managed_page() was gated by
> > MEMORY_DEVICE_PUBLIC in release_pages(). That path is also applicable
> > to MEMORY_DEVICE_FSDAX because it needs to trigger the ->page_free()
> > callback to wake up wait_on_var() via fsdax_pagefree().
> >
> > So I guess you could argue that the MEMORY_DEVICE_PUBLIC removal patch
> > left the original bug in place. In that sense we're no worse off, but
> > since we know about the bug, the fix and the patches have not been
> > applied yet, why not fix it now?
>
> The fix it now would simply be to apply Ira original patch now, but
> given that we are at -rc6 is this really a good time?  And if we don't
> apply it now based on the quilt based -mm worflow it just seems a lot
> easier to apply it after my series.  Unless we want to include it in
> the series, in which case I can do a quick rebase, we'd just need to
> make sure Andrew pulls it from -mm.

I believe -mm auto drops patches when they appear in the -next
baseline. So it should "just work" to pull it into the series and send
it along for -next inclusion.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
