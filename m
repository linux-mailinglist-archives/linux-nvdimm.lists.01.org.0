Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB449562A
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Aug 2019 06:38:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 62C9E21962301;
	Mon, 19 Aug 2019 21:40:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7693D2020D31E
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 21:40:01 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id b25so3115861oib.4
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 21:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pTsJc2XB2ULhT5btNfz5YqFDZzAMX4YrlKJzpdakKHA=;
 b=haCfRM1mdP3nfX7azXTUWTkX4VYJbjwY4jc+E3ak3zb/Q1+VOGqLgRgEbsy3pyWICB
 zvAYiCgBRK+8dAkVv4krDHbFmnRdtaPjhz4cpLHCAE65/wVsfPUFMFMcixGZheTPXPms
 aafV2W8tyjSi4gBburO/Opb1eLDzEo0j/90LUSBXS17sLm1C/53R+92S1YUt8vUBzN+/
 U4+YUiQZEu4DVvSOKNCDAYmdydy1ywzQLQF1LZnqZ2ysxAuQMGigKwXhAw4JExvC1809
 LC3e0idPYuahq4WIZQeLES2Pzu3+u4NlHkHZDkmoTlbB8qQQWmc7sgdaCXV41prJKu5+
 po5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pTsJc2XB2ULhT5btNfz5YqFDZzAMX4YrlKJzpdakKHA=;
 b=iIo8tzP+tFv8EKA90Zv1780YYH6iAA0d/+PV6jubptJF9hjQteyHdF9QdL/KJ6rfe3
 RLg0s8KkxE+opI1QWMFTu2xFVWVRnxy3g3AL9/qEhA4fA6fG//nYT3BInbY+fGa2Uykh
 3eS3fXCn2oog47pgwRH1r7KRwzz6wmeHPmMopOSptt4JFHznep7RwZPgvaxQlQiMUKs/
 vlpnHo4bfVqaHpNGm4tgCBrHLDHTPomC3MzUhK95nWt6reylsPqJR7mMpQax0b8F0cuL
 NP5hZpjx0Q4+3G4mjIzAMpqEWj8zFnmTlMmAruEjJxYCt5JvJk9JF8Bvixx8v3e4Z0CI
 +P4A==
X-Gm-Message-State: APjAAAW8kIklUKeC0cgWs6c/dDWxdDNVhxVSmDvkrbp24pEdTuaNIRYF
 5ueFSor1nkFQCOAYZ9rwzOCIO818SjFIFArcpLaOfw==
X-Google-Smtp-Source: APXvYqwNAdmv8U/MMocqDHerUy4sI8jbpH839Mf4eiVmaYDc08GdXYIAOnJ1qD656K+Q7iTrImqncBEbLElGaGG5fV0=
X-Received: by 2002:a05:6808:914:: with SMTP id
 w20mr15019903oih.73.1566275919132; 
 Mon, 19 Aug 2019 21:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190818090557.17853-1-hch@lst.de>
 <20190818090557.17853-2-hch@lst.de>
 <CAPcyv4iaNtmvU5e8_8SV9XsmVCfnv8e7_YfMi46LfOF4W155zg@mail.gmail.com>
 <20190820022619.GA23225@lst.de>
In-Reply-To: <20190820022619.GA23225@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 19 Aug 2019 21:38:25 -0700
Message-ID: <CAPcyv4hUC5ReY9v=Lt0M=jPtg3V05suOgt4fVdT4niO_k4hN8Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] resource: add a not device managed
 request_free_mem_region variant
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

On Mon, Aug 19, 2019 at 7:26 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Aug 19, 2019 at 06:28:30PM -0700, Dan Williams wrote:
> >
> > Previously we would loudly crash if someone passed NULL to
> > devm_request_free_mem_region(), but now it will silently work and the
> > result will leak. Perhaps this wants a:
>
> We'd still instantly crash due to the dev_name dereference, right?

Whoops, yes.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
