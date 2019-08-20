Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F421C95456
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Aug 2019 04:24:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BBC1E2020D33E;
	Mon, 19 Aug 2019 19:26:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id ECF542020D32A
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 19:26:12 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c34so3622848otb.7
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 19:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yBHOOAIpl+BVp9v5InU9pcm2gaJbl2xEJrSQBhETvYs=;
 b=CJP7CTbTPhZR+phUQnNkcTI/KNVWXl0SEGDWRt6JUQ8QXyB0Ee6aK8B6XXfkWH2D2X
 FIJQnLB5WFJV/CEJA4E/Iu2JcnEey/xpN9i0OeyUTPYwhZxbAzvnq886azOWzP46T02n
 J0qfxbD6Inesz2YwKORlypUR85mXvGdZkPZcPl3EgMqeUoUQnZFm2pg5O2htZW/EMhMb
 OVWEuyEOYV90TI4cJ+wa2Dqu+Bf0RQBah7CyzDuL9yw3lUe7T3OCIgBtrdE7pwdiXtCZ
 H2FU67p4R9TZSCDOstBQu9JQ34ERrQYLwlBW2NRSBK/zEmI9YmMsyTlL87m83uQrBx2t
 brrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yBHOOAIpl+BVp9v5InU9pcm2gaJbl2xEJrSQBhETvYs=;
 b=kxitX25xWEgyRk23Yf0slOD6zX7bfeTG+pQXQlHFWVelzq8DdbB2dOfyBDmwOzrmx6
 sm1jbur6LV8R6vR0Nwn1x5khypDguU6qy3WMtfgyFhxk4FawRAujcwGwpg8Q3Hlwu3Tf
 fe/DoUTJqTxp88cT/r8ID8VvFRFolNXhQ7y/vmSggc4bU9GRDqxqFRJBhDrqod7eswiX
 InQx3v9qHu4KeMZQ8CMoOA5z+wC4v8+H3WXIiWRylCkWgglGBLHFiQjbL0S3YSm27QG1
 a4kGsc0mWig9vfzf1RR5DzxezeSuswS3Wls4O+o/QM5JWQtHo3TSetz/0hHlCutAq/rl
 GL6A==
X-Gm-Message-State: APjAAAUt0dmahi5PW8LO0YrCOqusDgtUmvNeAkleDP0IMsV3qmS3w5lR
 83Fxzln1Cb6Pphee7ttVtYnapTQdVxlKQ4E5FdOnNg==
X-Google-Smtp-Source: APXvYqyNozQmsW6VwbwYlZxgLUM3eNQ/tnZ1XVJVsGuQWe47WPqdIvt2eUClmdyGd3c5FW1ejTh7V/zH1JQI72JUIu0=
X-Received: by 2002:a05:6830:458:: with SMTP id
 d24mr19989967otc.126.1566267889874; 
 Mon, 19 Aug 2019 19:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190818090557.17853-1-hch@lst.de>
 <20190818090557.17853-5-hch@lst.de>
In-Reply-To: <20190818090557.17853-5-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 19 Aug 2019 19:24:39 -0700
Message-ID: <CAPcyv4iy=RGu87Px_6Pr3f8yx5tH1hm58M85n74zYbbUTA299Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] memremap: provide a not device managed memremap_pages
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bharata B Rao <bharata@linux.ibm.com>, Linux MM <linux-mm@kvack.org>,
 Jason Gunthorpe <jgg@mellanox.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Sun, Aug 18, 2019 at 2:12 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The kvmppc ultravisor code wants a device private memory pool that is
> system wide and not attached to a device.  Instead of faking up one
> provide a low-level memremap_pages for it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
