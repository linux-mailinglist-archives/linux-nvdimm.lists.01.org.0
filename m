Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C2A95447
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Aug 2019 04:22:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 86B5F21962301;
	Mon, 19 Aug 2019 19:24:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5A3892020D32A
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 19:24:15 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g17so3629301otl.2
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 19:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dGaKAdU7Kzz4IRqMPbeMcHc/uvSVrliEnlndetCK0L4=;
 b=zKdVom0NZGDuaHrgxklgUVhp5ExnznDDaFFfOxYdgCUPF9H/QOmK2okCnSBv7TG1iD
 8VgVkvB+roi1O3wId/DNGT8ohuOBrvtAfFus1UIgy09kWcIHqe6sdGmcCfrddDiGjVfQ
 Afc6z9YQXk8loHn3UQOdSWjNKRrrWri2tNd/Ct3340IOvPhfEVjetCZPcUMPwssOPcPh
 gcT9UtKBwAP+mwb+m6SX2ozuyxus2NlfyohT9yJ4NcRTRyeoKama6VEntAVh0vYxR8l2
 sRgjoQgP2IKMeZVgEwTLIZ62YZ8rqzp3S2/EPPh3bvEnEXheYWNfsqDls665h3cp2/Xk
 liEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dGaKAdU7Kzz4IRqMPbeMcHc/uvSVrliEnlndetCK0L4=;
 b=FfhaVndsqpwj3AOfQKEXHxip1E/4YMkcnyvl8sOJIUtK3NtRINqPoS18mQui9KsBnb
 glJPnbqjPIXXNyNr32Bex9w6LzTESO8FaTOJNzgZtmfWjtEY9jUi+ji5F5J7ozIdifiw
 A4JpOvCmbwvaUiByiW82OFA01KUKQWa9dv9Xjyr66TzeElOaSeoEnFZVNVSWwijgQTiw
 NNgF3/gfbQjxkotXM3O7lJR7yeOI0j+klryjqj9X30e6QnIWG/tHE4Wb39ZzrC0SgAOa
 eO0mYeV4I09YYaf2Df6UoXvoJJrugQdsEBfyTQwhoIGOQGtjPCVR83FJxIAz+lh2R1Jj
 +Iig==
X-Gm-Message-State: APjAAAX7AbGEno8rSKxr1Cfc2Bw2X5DTY6i1cK4P3GTSgUZtIXn9gGB7
 VRu5sRICDD9D0RIG3ObHr1hb/8sVGLxgPQlnV0Jf8g==
X-Google-Smtp-Source: APXvYqxMJSoi3xcOuG4kdSjiGcLdWTp8DOPjIJI3WHkmC8gPmnKQsuPiwRsZyF/AEjqfvhoUMKVUtbKpNU6WT1lmw68=
X-Received: by 2002:a05:6830:458:: with SMTP id
 d24mr19986229otc.126.1566267772164; 
 Mon, 19 Aug 2019 19:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190818090557.17853-1-hch@lst.de>
 <20190818090557.17853-4-hch@lst.de>
In-Reply-To: <20190818090557.17853-4-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 19 Aug 2019 19:22:41 -0700
Message-ID: <CAPcyv4h9Bp=D4oHEb-v9U7-aZE3VazmsTK3Ou3iC3s3FTYc4Dg@mail.gmail.com>
Subject: Re: [PATCH 3/4] memremap: don't use a separate devm action for
 devmap_managed_enable_get
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
> Just clean up for early failures and then piggy back on
> devm_memremap_pages_release.  This helps with a pending not device
> managed version of devm_memremap_pages.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
