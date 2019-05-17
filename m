Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1B421C78
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 19:29:04 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7CB1021275462;
	Fri, 17 May 2019 10:29:02 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 11DA62125330A
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 10:29:00 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id m204so5768405oib.0
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DZg+iPjy57Sau/2Fv2Pd7vOTOxQm9eqfYjNJZeyrWIs=;
 b=dJsV4x6IxLCgdPBEdcoEAdj7Zz5cN+2SMQigBpwwLCEnytqZSwk8zS1uvReMjOe4cj
 Q24WakyMkK56lXo3uuygO/fpLNaDFdlHZ4HKZ89RdkRYdy7710qGfvhjYW0h2qLXROj5
 Udi0Ja8h/Gn5ceLVB/Dd8MsMGQWpESB4ureyJ+HPhXQP+qv0PLzcH82NXB6OZOpHv/ol
 jiw0rT7qOiQrtpVx/2IyOEEJ4tL4ltdsslvJg/tILl3oaaWcaKU303I9MpGYmzHslK2g
 CI3AyFD5/HFMxWLbDcHtj5KFQRpwpFleoORC+4GRdyjxHEFM2eK+lztKXJz8ctBDuLma
 Vs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DZg+iPjy57Sau/2Fv2Pd7vOTOxQm9eqfYjNJZeyrWIs=;
 b=UxdxeHxgp1Mo0Lk5TAJ3pmDuwnjyH3ff/undV7ceIs3ZIBZ/r9VgVFVBWvF82PIv82
 4FfReX3sP8+b1izlWB0sltgjAa0JzUF2NvJ7Nhzuwg2aKKS50ALxMJx7QbF28Nccf+uN
 FmyAxoXxVgVLcsvKTSnFtV34gLscxw/WqzU3cGEQI4GVsGnNTs0Oc8QVS2uXU3yU2f78
 Z9hI+MPHUGGYLzhoCYuMXd15MQUI5KzajWD7GFCXR9WH3fno54+a/nhtjsm2M1ea0/nG
 nvn3Fyh8b2meEfJnanoatZnknYk/az+6sNkjcu6lHeE4S/rTWIpbE/dA4nbjKy+AsKLh
 y16A==
X-Gm-Message-State: APjAAAXfRw5CTb2q2CMLKy8q482s8okyfe7R75Kei6SDwgj4Cw+b5DRS
 dmOVXdafejTft0vaJLhk2UUIxgAPHpIqs37DICmUuw==
X-Google-Smtp-Source: APXvYqyypz+lE+RFowzVzsoRyDPIn100uvW4JTOwzRg1F63adltFZC2q4xwOBjZ3OZAsNEKxmDVZopC2u4kD8gMpRhg=
X-Received: by 2002:aca:4208:: with SMTP id p8mr16013695oia.105.1558114139313; 
 Fri, 17 May 2019 10:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <155805321833.867447.3864104616303535270.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190517084739.GB20550@quack2.suse.cz>
 <CAPcyv4iZZCgcC657ZOysBP9=1ejp3jfFj=VETVBPrgmfg7xUEw@mail.gmail.com>
 <201905170855.8E2E1AC616@keescook>
In-Reply-To: <201905170855.8E2E1AC616@keescook>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 17 May 2019 10:28:48 -0700
Message-ID: <CAPcyv4g9HpMaifC+Qe2RVbgL_qq9vQvjwr-Jw813xhxcviehYQ@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead
To: Kees Cook <keescook@chromium.org>
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
Cc: Jeff Smits <jeff.smits@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 17, 2019 at 8:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 17, 2019 at 08:08:27AM -0700, Dan Williams wrote:
> > As far as I can see it's mostly check_heap_object() that is the
> > problem, so I'm open to finding a way to just bypass that sub-routine.
> > However, as far as I can see none of the other block / filesystem user
> > copy implementations submit to the hardened checks, like
> > bio_copy_from_iter(), and iov_iter_copy_from_user_atomic() . So,
> > either those need to grow additional checks, or the hardened copy
> > implementation is targeting single object copy use cases, not
> > necessarily block-I/O. Yes, Kees, please advise.
>
> The intention is mainly for copies that haven't had explicit bounds
> checking already performed on them, yes. Is there something getting
> checked out of the slab, or is it literally just the overhead of doing
> the "is this slab?" check that you're seeing?

It's literally the overhead of "is this slab?" since it needs to go
retrieve the struct page and read that potentially cold cacheline. In
the case where that page is on memory media that is higher latency
than DRAM we get the ~37% performance loss that Jeff measured.

The path is via the filesystem ->write_iter() file operation. In the
DAX case the filesystem traps that path early, before submitting block
I/O, and routes it to the dax_iomap_actor() routine. That routine
validates that the logical file offset is within bounds of the file,
then it does a sector-to-pfn translation which validates that the
physical mapping is within bounds of the block device.

It seems dax_iomap_actor() is not a path where we'd be worried about
needing hardened user copy checks.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
