Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B07020E8E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 20:23:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D41572125ADF0;
	Thu, 16 May 2019 11:23:02 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A93E62125ADC4
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 11:23:01 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id y10so3254013oia.8
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b4xg0I4nHSIZDLwgdApekV9qe+c7BH2Awe3q1fKa6Io=;
 b=yuAHpEc/2FUp4yfXksMyV9luWP6huU5wiNXGn+NIlDFS9bbErRHNSxKlKkYr1GjFOo
 VQ/bYwSavyf7szedZRsCbovVVYpDm/cygkUfWHeQp7fuDa34VJ6SkAQHC1FVUgQiuUNm
 tqLbLsHyz7tHWMHdVPJIwK3cYNK21Yknj1tAUuhOgfD8JJmxEk7WU2ytUOSFd8txASrU
 4+4i06pABRZtWMLf1jaCA6NFasC4kCCUtKyaTopkzsSCcMfDFk0X5iXm43N9EJ/TriM5
 Rsv7MO7RVg+tG5j+WcR8IXZworhpQ5BKKBk9E93QtYjt1oauxG6cUk1KOgqWhCTLpLl1
 jEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b4xg0I4nHSIZDLwgdApekV9qe+c7BH2Awe3q1fKa6Io=;
 b=tsS9JE9qU1QzGtKENuB8niLYvU9O6tdZynxmocSzfca7BBSwrS2HFGtlkMTTfxQn21
 nZQYyRDF0KVosoWPdFWQq3ExM8Vwp3G+z221sbAiyquYf7za1k/GiK9t1BUfxmLYTqE9
 kBW/CC4B+78c3U2f0RokfjKGpCi3Su35AiEFB0yGpjcsNhZj7UV7I1qPfSzfgmPMm3Tm
 ScKEVEIndOVr3rCiUqsRBKhR6CcmIryiiyBlLMFpsrFFi5rADjxkiGJPOyLsnJEh+Snz
 iQ3Z0dqkBV3xRooLE+y1iQbIQD4woxtns0yNBVgJI4Uk9ovUGkaUw5jVePLJFBHNQBEb
 g6XA==
X-Gm-Message-State: APjAAAURE0SvKI0G4tZIcaodP4BBA+eb6ySDFG1HwbF1J8ctMFUP30W2
 BozKq6QTrOb8D0co+8e3d2lGf5CFqIyboibs8aW1jw==
X-Google-Smtp-Source: APXvYqwg9rOSNakUV6ntAHuPcrnmGPMNTHp9x75smlsew5RpVuQ939PYfxxwI+yczWaxBwHwk8lhj1yhUXwii4EAqnQ=
X-Received: by 2002:aca:4208:: with SMTP id p8mr12157546oia.105.1558030980537; 
 Thu, 16 May 2019 11:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190516055422.16939-1-vaibhav@linux.ibm.com>
In-Reply-To: <20190516055422.16939-1-vaibhav@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 16 May 2019 11:22:49 -0700
Message-ID: <CAPcyv4j6Jhpqg9SqAAmz2A6PDry7UUtnniNVoc_qG=WXwuVOWA@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix last_page check in __bdev_dax_supported()
To: Vaibhav Jain <vaibhav@linux.ibm.com>
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
Cc: Mike Snitzer <snitzer@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chandan Rajendra <chandan@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 15, 2019 at 10:55 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Presently __bdev_dax_supported() checks if first sector of last
> page ( last_page ) on the block device is aligned to page
> boundary. However the code to compute 'last_page' assumes that there
> are 8 sectors/page assuming a 4K page-size.
>
> This assumption breaks on architectures which use a different page
> size specifically PPC64 where page-size == 64K. Hence a warning is
> seen while trying to mount a xfs/ext4 file-system with dax enabled:
>
> $ sudo mount -o dax /dev/pmem0 /mnt/pmem
> XFS (pmem0): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
> XFS (pmem0): DAX unsupported by block device. Turning off DAX.
>
> The patch fixes this issue by updating calculation of 'last_var' to
> take into account number-of-sectors/page instead of assuming it to be
> '8'.

Yes, I noticed this too and fixed it up in a wider change that also
allows device-mapper to validate each component device. Does this
patch work for you?

https://lore.kernel.org/lkml/155789172402.748145.11853718580748830476.stgit@dwillia2-desk3.amr.corp.intel.com/
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
