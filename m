Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E461938043
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Jun 2019 00:06:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 20E9721290D40;
	Thu,  6 Jun 2019 15:06:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3F12B21157FC2
 for <linux-nvdimm@lists.01.org>; Thu,  6 Jun 2019 15:06:39 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n2so20846otl.12
 for <linux-nvdimm@lists.01.org>; Thu, 06 Jun 2019 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EIr4OnOI1xF9wai5ier5nmSpwnMBcVJFFbPwhyrlfw8=;
 b=W6owKkiaiucLtIk2d/rhThge65YAuZhOXdGbJAq1YJnZeuj3agBqhdzoWw4pAHpEGG
 yCCRRgubBcq/P+3tO+QxBLrGvQWm34ZFjVhCGGnC25tsI1wz0ookadExgISatwc+xFwx
 9F3A1KcbDxhZpKNcMECopMoti2uf29JMv8oNXtACIP4ZdnAKSAeFcKK0Z75QstHVe1Kk
 FSNS/e4ugOpcEKATo1xHjQe71a839vKxrezJgS4nSTbtKrDnRK96iahNefKSCqeqIl7K
 GpNADCiQeyijYdm/jA366lM8s7uLcFJlrvqzsE5Q567T+TEojZQ525tKJu3IpPIztD1S
 rFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EIr4OnOI1xF9wai5ier5nmSpwnMBcVJFFbPwhyrlfw8=;
 b=id/2Hsfpy+t5ENe0w/3gf0mHi0B/kKxm+kVW6RglKgCb93OYdBIZ+kiLgwWjuhSG1G
 M2wpqolu45K2EkjglhJbMHcer6wXofKbdFRVoy7ZS5ZxjvFtV2kt9hVGNO+CjYzEfBLD
 47uFbQMKGFBlYfbVcTaEx375Ei2K57LQ0xlA5qBuLHLxmbzALy6Lb7GSdmREVlmwMmGs
 KZDdKmYDMs5519fOhMJDcu4MUKEJlWAnAYPA54Qm7GitFWk3Dsk2p5APOY2d9ZpaV1yX
 f2n0nDWv9bxxPCgC5gUwo3xHOf9yUOnGmnaPgyoLOsnXjTRHtGB0g1mANCQuqqfdhm6D
 VFxw==
X-Gm-Message-State: APjAAAXkZl7bL7p3gOaQZ2SM96NV+BMiZx7xI3WdXOyP4As+6Fl5q5dB
 JAYifkEyCYEqgoWJDavPvzwGTsPF9XmUMLkxPxXe/w==
X-Google-Smtp-Source: APXvYqycw+T+CReJfdLZE2qHIqv0pPOCCdRZcOCC2XXW8oc8RYjE0NVBkRV9yjOJGx4MnVYldEDTHY2D/nu9EblRWvQ=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr12110810otn.71.1559858798146; 
 Thu, 06 Jun 2019 15:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977193862.2443951.10284714500308539570.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190606144643.4f3363db9499ebbf8f76e62e@linux-foundation.org>
In-Reply-To: <20190606144643.4f3363db9499ebbf8f76e62e@linux-foundation.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 6 Jun 2019 15:06:26 -0700
Message-ID: <CAPcyv4hHs75hYs+Ye+NHHiU31C6CnBqCFdo=2c5seN7kvxKOrw@mail.gmail.com>
Subject: Re: [PATCH v9 11/12] libnvdimm/pfn: Fix fsdax-mode namespace
 info-block zero-fields
To: Andrew Morton <akpm@linux-foundation.org>
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
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
 Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 6, 2019 at 2:46 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 05 Jun 2019 14:58:58 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
>
> > At namespace creation time there is the potential for the "expected to
> > be zero" fields of a 'pfn' info-block to be filled with indeterminate
> > data. While the kernel buffer is zeroed on allocation it is immediately
> > overwritten by nd_pfn_validate() filling it with the current contents of
> > the on-media info-block location. For fields like, 'flags' and the
> > 'padding' it potentially means that future implementations can not rely
> > on those fields being zero.
> >
> > In preparation to stop using the 'start_pad' and 'end_trunc' fields for
> > section alignment, arrange for fields that are not explicitly
> > initialized to be guaranteed zero. Bump the minor version to indicate it
> > is safe to assume the 'padding' and 'flags' are zero. Otherwise, this
> > corruption is expected to benign since all other critical fields are
> > explicitly initialized.
> >
> > Fixes: 32ab0a3f5170 ("libnvdimm, pmem: 'struct page' for pmem")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> The cc:stable in [11/12] seems odd.  Is this independent of the other
> patches?  If so, shouldn't it be a standalone thing which can be
> prioritized?
>

The cc: stable is about spreading this new policy to as many kernels
as possible not fixing an issue in those kernels. It's not until patch
12 "libnvdimm/pfn: Stop padding pmem namespaces to section alignment"
as all previous kernel do initialize all fields.

I'd be ok to drop that cc: stable, my concern is distros that somehow
pickup and backport patch 12 and miss patch 11.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
