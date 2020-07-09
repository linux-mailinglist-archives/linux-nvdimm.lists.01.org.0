Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3689421A46D
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jul 2020 18:10:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 99A6411427DBD;
	Thu,  9 Jul 2020 09:10:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E8D3911427DBD
	for <linux-nvdimm@lists.01.org>; Thu,  9 Jul 2020 09:10:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g20so2285375edm.4
        for <linux-nvdimm@lists.01.org>; Thu, 09 Jul 2020 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXGyI1jQM4MyDlznYgbObqnrQ6fGYg1DRfNByglLv1o=;
        b=UjOsw/EYQjZBeUPhxTDnLwz5hcjG7XJKZAgCs2jnN8hFjADCB++r0ATOAqmENgW/VP
         hikL0VJL7vWu6z3P4UkTBqdu2KGKyfsHsPW/Bi3c+q1lNKQwFaQ3jtXQyW/uMEGDpkA/
         TqqxyTc44LHLjuIv9MUJBAD9nKjyvaMtoS5ILB0gpHpaESvb3166bLYfXcKF04TJDOs0
         pa1AMO6kHH27YF7o2AKynrWSx+i1ba/Z1ZCBZyA3sL/VFV7J9RZ/YtnFWWUqfQN8T7G1
         xdoFwAAA2eCajSA9FJRXSZ84ILtv1QbBjC3Pfdo/yF5RcJ+LZqB+kCzPE+zAD4yYJPWE
         AlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXGyI1jQM4MyDlznYgbObqnrQ6fGYg1DRfNByglLv1o=;
        b=rsFxCy8qArVezxhBaf95PEoOBRmGpABTibeU/5bdoAH4JfzWV8UCxxB2fyz1HeGtl+
         0MKDgiaIgX3hnDLE/AYlHuEDyWUAkOH+k8sVgGsjpWvWmo/svyEczMbxwJBdN+zWSl0c
         DZIhBGG4gZ/aY+g5eTTtw88pydzg1hWlX4YivAsgefjDqIazcRs86UxQyZxz/eUT/gcj
         Wgi3AID3F6I1R6zVTawlCKFDagIVQha3G+HtPgYJm6YUe1ts/tjiiuSoNBmzfDHHxPpX
         bDxbQdv/udGQPSf2B5uXwmnpUy9wtzgWxXD5FGVppoVPt5UapWorZQMeZzeTSvZkZlzr
         TTOw==
X-Gm-Message-State: AOAM53081nWxM/03H0kMIjHQV7xCOcvxSPcwOebqhNsnfqGMSMc1M52d
	al88rpZFS3z4PP/oIJB8hgd0JLSCm2rNyar40DM7IA==
X-Google-Smtp-Source: ABdhPJys2PRuEgVWwVNfqL6iwk8phAva/9+kvQrbBEC8AGznqa+13FP1lQM5gT85aLrNX8emw/o4sdAG8MvO8CX0Aoc=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr75626053edo.102.1594311017269;
 Thu, 09 Jul 2020 09:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200709150051.GA17342@infradead.org> <20200709153854.GY23821@mellanox.com>
In-Reply-To: <20200709153854.GY23821@mellanox.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 9 Jul 2020 09:10:06 -0700
Message-ID: <CAPcyv4hSPWEUih=we5QM_rdk7fLemi8phyk8_0tOd8ieL_=vPg@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and
 callback for firmware activation
To: Jason Gunthorpe <jgg@mellanox.com>
Message-ID-Hash: IT5LFWEOF7JCCH5ID76F5MKIGZRL36S7
X-Message-ID-Hash: IT5LFWEOF7JCCH5ID76F5MKIGZRL36S7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Doug Ledford <dledford@redhat.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IT5LFWEOF7JCCH5ID76F5MKIGZRL36S7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 9, 2020 at 8:39 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Thu, Jul 09, 2020 at 04:00:51PM +0100, Christoph Hellwig wrote:
> > On Mon, Jul 06, 2020 at 06:59:32PM -0700, Dan Williams wrote:
> > > The runtime firmware activation capability of Intel NVDIMM devices
> > > requires memory transactions to be disabled for 100s of microseconds.
> > > This timeout is large enough to cause in-flight DMA to fail and other
> > > application detectable timeouts. Arrange for firmware activation to be
> > > executed while the system is "quiesced", all processes and device-DMA
> > > frozen.
> > >
> > > It is already required that invoking device ->freeze() callbacks is
> > > sufficient to cease DMA. A device that continues memory writes outside
> > > of user-direction violates expectations of the PM core to be to
> > > establish a coherent hibernation image.
> > >
> > > That said, RDMA devices are an example of a device that access memory
> > > outside of user process direction.
>
> Are you saying freeze doesn't work for some RDMA drivers? That would
> be a driver bug, I think.

Right, it's more my hunch than a known bug at this point, but in my
experience with testing server class hardware when I've reported a
power management bugs I've sometimes got the incredulous response "who
suspends / hibernates servers!?". I can drop that comment.

Are there protocol timeouts that might need to be adjusted for a 100s
of microseconds blip in memory controller response?

> The consequences of doing freeze are pretty serious, but it should
> still stop DMA.

Ok, and there is still the option to race the quiesce if the effects
of the freeze are worse than a potential timeout from the quiesce.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
