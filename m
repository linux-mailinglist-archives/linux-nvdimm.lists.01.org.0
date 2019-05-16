Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E001FCD9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 02:22:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B2DC4212794B6;
	Wed, 15 May 2019 17:22:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 69F3D21945DE0
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 17:22:03 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z65so1165959oia.11
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 17:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bobcIcGI2hoSe5dAxap34CNUn9LKnTkS03oUmV7h0q4=;
 b=j9nGNhyMsOaTVud6KO3dskijFfmT2ZQWGqLP7vYr40RYrbZpP2ISfBY4/jbvgTXbHD
 PBNLGCVvSGEIW+pkvZWIknWRx7irtf13DgdR99Ie6/6xDxy1VgUpVBlwuK3ybEJWLqgW
 utTN/SrtWzEr/dIFr8r1RtV1Jsh3YspspkZIMQzCSJBi0BrKaoBFZs55FZ0kUQ+CSg3y
 cLNlzpERm8qRNJFebCDsd3GPaloqk3nhEzbkU4ir0yewDOVvjZvhY9NZ9QQfKgfHgQw3
 Jf1vLci6RuObHmAw9PyVKzRBRDvCgYO0flvWfgK5uIBS1CIRxOGoy2HsIk/r+YmH4QgG
 GIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bobcIcGI2hoSe5dAxap34CNUn9LKnTkS03oUmV7h0q4=;
 b=i0byD7A7vGVnUr48pvM6IQxVkACiNOr/iqlMz2rwVPAKLyyK1uDVj7P+7J9zwIEA5o
 47Pitx1rG/1EajneCfwLATsV8yd/5KDydaKVpwlLWBTKaSXsWVmpOcjDXwDN31IllZw+
 6qgdNbFConuRpeMx5M9PoNtfN3dFRJdx1xH+jqbe7D+9sblXwNjXSjGBWzYIBV9CAQyu
 B9Dp+I1iWPvaO5TKv1gmbuxCP8UJS0AHwlWQs7OL0ReQeYCg6EVMHnF7uJ0TPVVkcbLT
 DfGKA2oyjhL5iJE79O5qayerqT3/sKFmxVg4LV9lq82b1/fI8WQ6RaQZBt6ZlmndhWSq
 Fwaw==
X-Gm-Message-State: APjAAAVZiGXjEcI2ayhERmzP8cb7/oPdANuPJv+R36Y1rb8tAeUAwITz
 RnCazqTJ+kFOn23PnemWvso3dcNXfQ8FgUE9qME7cw==
X-Google-Smtp-Source: APXvYqzDrmQi77dAWBNc07ndDu3T5pa6iN0pcVHtAZNxLtfjwvQPS0Zb7sMkMpyK1B3ioBtGGZnPjQ/C8y0NssMQmSA=
X-Received: by 2002:aca:b641:: with SMTP id g62mr5885998oif.149.1557966122846; 
 Wed, 15 May 2019 17:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190515192715.18000-1-vgoyal@redhat.com>
 <20190515192715.18000-13-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-13-vgoyal@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 15 May 2019 17:21:51 -0700
Message-ID: <CAPcyv4i_-ri=w0jYJ4WjK4QD9E8pMzkGQNdMbt9H_nawDqYD3A@mail.gmail.com>
Subject: Re: [PATCH v2 12/30] dax: remove block device dependencies
To: Vivek Goyal <vgoyal@redhat.com>
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
Cc: KVM list <kvm@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Miklos Szeredi <miklos@szeredi.hu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Steven Whitehouse <swhiteho@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 15, 2019 at 12:28 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> From: Stefan Hajnoczi <stefanha@redhat.com>
>
> Although struct dax_device itself is not tied to a block device, some
> DAX code assumes there is a block device.  Make block devices optional
> by allowing bdev to be NULL in commonly used DAX APIs.
>
> When there is no block device:
>  * Skip the partition offset calculation in bdev_dax_pgoff()
>  * Skip the blkdev_issue_zeroout() optimization
>
> Note that more block device assumptions remain but I haven't reach those
> code paths yet.
>

Is there a generic object that non-block-based filesystems reference
for physical storage as a bdev stand-in? I assume "sector_t" is still
the common type for addressing filesystem capacity?

It just seems to me that we should stop pretending that the
filesystem-dax facility requires block devices and try to move this
functionality to generically use a dax device across all interfaces.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
