Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CA421049
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 23:51:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 680BA2125582E;
	Thu, 16 May 2019 14:51:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 86D6921250464
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 14:51:53 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c3so4911585otr.3
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 14:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q9BJIUmtXvGA8NYL+nEThmnX3fsQkDEf9gjJHVtWFbw=;
 b=JK0kNXwowOzM74+Om7kEhXLK+rOIMCMEPEAa6Fk0D93qKu8M2dq0YJm2ZfDxgTeCiU
 ZnpolSVQFmjdgAGuHgNPUQKcuPGJMBEDpFs5OvgWHO2/r1lUKUoq+r79dmC3nusASLwW
 b7J6BtVgy9HYQwcAKkLHQsoshwVUNWjVqol42iFhSJKjgsIi6Dc+SwbzWrocF4PuQV9M
 IYPIajeB7RxjAFAl9a4GWlG5H5AeA23IEp+6x25xZR+whf8n/MJa5cQu6cdcsWrU1TDn
 /Arr+Bi1p3leIaZVgocYnoMbwVUjOA/IIrN5CFkLQKwwu660ooYhVCJaHs5KP3OXWCL+
 YIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q9BJIUmtXvGA8NYL+nEThmnX3fsQkDEf9gjJHVtWFbw=;
 b=hrGBdA7Qq4sINUwNHkx/Wy/xa2x9JUfaP8CCIunG+qmNFpX8C8LbUJj0WYzFabcQLH
 CAOT44h7NZHtdpL5Dy45NGyEYMhadC8tx7t7N9vHcuYZaYHdLY8uge1PsPqPuS+yxQLL
 QnrCSVFmN8nU6GXKqrfg8gOa1PkF9iwaq6FzX6p5MXO6yH8WXkikG7HQxkjn5PGRGftc
 wW1sx+nYVwoueGbmpF3ES9Ir4NSJos8JwWMwesnRp1apuQqRyHB4YYjEstTBuu7h649z
 N4DnZxU3dX+jYaWXgu6OME5caL43CNpiU81nq2hzzzCpd7psH/O256N9YzxV/eHYlGht
 WRew==
X-Gm-Message-State: APjAAAVPH0YMypgcCDRzyW87r5MXqj/4T01llNvRHsP1KdemtA6lxrzF
 DfIrk0K5SYQ3fx7991mPfhdt+DiwgDgBF6MDGBWJtA==
X-Google-Smtp-Source: APXvYqzibKwOyLJegIvrnmsMGvcFID1N0Mw2/FEB7rFcTHdA1PYSfF3HR1ZbWMzElybqvVBCcqSrRsrG3NhAGtjgYjo=
X-Received: by 2002:a9d:2f0:: with SMTP id 103mr30133978otl.126.1558043512432; 
 Thu, 16 May 2019 14:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
 <059859ca-3cc8-e3ff-f797-1b386931c41e@deltatee.com>
 <17ada515-f488-d153-90ef-7a5cc5fefb0f@deltatee.com>
 <8a7cfa6b-6312-e8e5-9314-954496d2f6ce@oracle.com>
 <CAPcyv4i28tQMVrscQo31cfu1ZcMAb74iMkKYhu9iO_BjJvp+9A@mail.gmail.com>
 <6bd8319d-3b73-bb1e-5f41-94c580ba271b@oracle.com>
 <d699e312-0e88-30c7-8e50-ff624418d486@oracle.com>
In-Reply-To: <d699e312-0e88-30c7-8e50-ff624418d486@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 16 May 2019 14:51:40 -0700
Message-ID: <CAPcyv4hujnGHtTwE78gvmEoY3Y6nLsd1AhJfeKMwHrxLvStf9w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm/devm_memremap_pages: Fix page release race
To: Jane Chu <jane.chu@oracle.com>
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 16, 2019 at 9:45 AM Jane Chu <jane.chu@oracle.com> wrote:
>
> Hi,
>
> I'm able to reproduce the panic below by running two sets of ndctl
> commands that actually serve legitimate purpose in parallel (unlike
> the brute force experiment earlier), each set in a indefinite loop.
> This time it takes about an hour to panic.  But I gather the cause
> is probably the same: I've overlapped ndctl commands on the same
> region.
>
> Could we add a check in nd_ioctl(), such that if there is
> an ongoing ndctl command on a region, subsequent ndctl request
> will fail immediately with something to the effect of EAGAIN?
> The rationale being that kernel should protect itself against
> user mistakes.

We do already have locking in the driver to prevent configuration
collisions. The problem looks to be broken assumptions about running
the device unregistration path in a separate thread outside the lock.
I suspect it may be incorrect assumptions about the userspace
visibility of the device relative to teardown actions. To be clear
this isn't the nd_ioctl() path this is the sysfs path.


> Also, sensing the subject fix is for a different problem, and has been
> verified, I'm happy to see it in upstream, so we have a better
> code base to digger deeper in terms of how the destructive ndctl
> commands interacts to typical mission critical applications, include
> but not limited to rdma.

Right, the crash signature you are seeing looks unrelated to the issue
being address in these patches which is device-teardown racing active
page pins. I'll start the investigation on the crash signature, but
again I don't think it reads on this fix series.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
