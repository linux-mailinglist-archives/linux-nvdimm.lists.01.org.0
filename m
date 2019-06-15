Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6A246D73
	for <lists+linux-nvdimm@lfdr.de>; Sat, 15 Jun 2019 03:15:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2A1222129F05C;
	Fri, 14 Jun 2019 18:14:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5F6992129EBB3
 for <linux-nvdimm@lists.01.org>; Fri, 14 Jun 2019 18:14:56 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w79so3260981oif.10
 for <linux-nvdimm@lists.01.org>; Fri, 14 Jun 2019 18:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YXA5bt0DRqq3Y8upnzIrF6REEJIQ3rcT1NgkB5rI0Pk=;
 b=tJmg62m5f5wzjStc/29QDsRE/q4PtUR7a07UcT9A+LpofKKbxhtlmCVhtiJ8URAGLA
 9oK9DJH98vQawRs0h37hjqVTMVMJWvmn1NENWEvQcKiDXa/4ypd31CJaKcQrvB78GOhr
 Qbbk6j3mpA6d1cD9ylhgqzPJxlzijRmQqwiLfaMhhoWCiFA/gFjJw+5MiA0tc2pV/9+G
 Sl4Xc+lFQQumGmBwoeyeK0hlQsDN5BV8kkty0G0+AiFUxphY9dfVKR5wzwo5PVFTO/Jr
 4+9iaNMvBJSAm3MKHtVibI6ZPeuLK1e7+r9sLGzVfNA1FoAErnV7xkbqVG7OP5TKANBO
 dkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YXA5bt0DRqq3Y8upnzIrF6REEJIQ3rcT1NgkB5rI0Pk=;
 b=s+Lz0zMjfLZMLKHbcBEME+TWhiFK30oZgX5mnplFOpDoEiRtaRESJsUt83Tx45cY7g
 BylHOOxCGsnAtnNOb7pT+u+HPv6tcpvsNhRoh/q4pZr4n2ENXjgP4fxJbTRoGPuwhJFe
 3zCHcrMskRTsaGcjDt7b1q2M0l08+KQVwo5Y2Q1aISbq8OO6+zJFINteGfsRW2puDq/L
 arv0kM/F0GwWHDQQQb53bDsBsnMCgg7pt2G1JbgiTUaq/nfOtEUMdUAQI+Uege/Y+WNi
 7qAl3TA5xTz4iE8X2KUc2J1T+vXQU7WY5+uU7B+Oqc6Wu9gt0Z4kKgNL91D11+pxGSqK
 1SLg==
X-Gm-Message-State: APjAAAUyNd8SAoq9dnnpjTxkpdEX36oN3qD+PtXkTUq4LI8AFI2k/N2m
 gWzwzoHOGAtruj8cGC3XJeqZpY6NTzunpO35/tRbP0ucl2M=
X-Google-Smtp-Source: APXvYqxqBHyqynWE7/sHeR/K8H8EClnUTPV3/T7OxCVIwp/PZVwUGw1nUJBb42vXH0k1fSGr8eACLhIRKFpd++U1+Gw=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr3500913oih.73.1560561295806; 
 Fri, 14 Jun 2019 18:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de>
 <CAPcyv4jBdwYaiVwkhy6kP78OBAs+vJme1UTm47dX4Eq_5=JgSg@mail.gmail.com>
 <20190614061333.GC7246@lst.de>
In-Reply-To: <20190614061333.GC7246@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 14 Jun 2019 18:14:45 -0700
Message-ID: <CAPcyv4jmk6OBpXkuwjMn0Ovtv__2LBNMyEOWx9j5LWvWnr8f_A@mail.gmail.com>
Subject: Re: dev_pagemap related cleanups
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, nouveau@lists.freedesktop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 linux-pci@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 13, 2019 at 11:14 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jun 13, 2019 at 11:27:39AM -0700, Dan Williams wrote:
> > It also turns out the nvdimm unit tests crash with this signature on
> > that branch where base v5.2-rc3 passes:
>
> How do you run that test?

This is the unit test suite that gets kicked off by running "make
check" from the ndctl source repository. In this case it requires the
nfit_test set of modules to create a fake nvdimm environment.

The setup instructions are in the README, but feel free to send me
branches and I can kick off a test. One of these we'll get around to
making it automated for patch submissions to the linux-nvdimm mailing
list.

https://github.com/pmem/ndctl/blob/master/README.md
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
