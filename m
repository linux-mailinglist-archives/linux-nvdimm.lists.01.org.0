Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D8A21A3F2
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jul 2020 17:44:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 875A01142B382;
	Thu,  9 Jul 2020 08:44:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.66; helo=mail-ot1-f66.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DC0E611427DBD
	for <linux-nvdimm@lists.01.org>; Thu,  9 Jul 2020 08:44:04 -0700 (PDT)
Received: by mail-ot1-f66.google.com with SMTP id 18so2008187otv.6
        for <linux-nvdimm@lists.01.org>; Thu, 09 Jul 2020 08:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Sym5KQVj8VqaMlSDW0Jc0j+Tk3pFvysmGFqfcg2Rvs=;
        b=jPFL2QYDFVcrl+V4/qMWpnyOK4N4sFEOeimNtu7WPR7tulkxk2+7buU7tuipDRU73m
         Qo2oagmWyvtFnEaSF7Z+kmRYrND7MPTC3L7F6ftJmRcbTTOxkQAfqqJ7Cl/Wz1A1fu5t
         N9+U1hn1hAWZOfbRcqyr8G9/Z4UsAeXI8hZDcKU7sfcCDtOCKDtdI2KmsiaPjhKiKQPb
         Xs03wND5a7Slpq8vmr8Bpkm+anHOpAfveI1oOgNCbE/zpLG9sb0SGnIoWsQ1G6WkgV1T
         9g+AmSmvaCYM6yd758GezISAVRz8AmZ4tQ+UmCS8V5VxmZ5wHa/E5QR0ikACrUQKSkbg
         MECQ==
X-Gm-Message-State: AOAM5318jL2Z2bDRN14AVcANHUsGocR/Cr+0sxtWe2ChYAIE6ttAncV6
	vuqbFIqLU8nrWFDQ91JG3ouIyxzbq46LHRJ7kX8=
X-Google-Smtp-Source: ABdhPJyl5cUpGVf4J6oVAx/ugmkS7qnUi0jZS8XkXNGXgHJrgdpNOsltf7QnMuVARuoppuhb/s8y3Fa214SXcCONguY=
X-Received: by 2002:a9d:1c82:: with SMTP id l2mr36010851ota.167.1594309443612;
 Thu, 09 Jul 2020 08:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200709150051.GA17342@infradead.org> <20200709153854.GY23821@mellanox.com>
In-Reply-To: <20200709153854.GY23821@mellanox.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 9 Jul 2020 17:43:52 +0200
Message-ID: <CAJZ5v0hW79nEe1P5YqNx0o0jHAMuPw-i02GY3TCvG_uFu48ETg@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and
 callback for firmware activation
To: Jason Gunthorpe <jgg@mellanox.com>
Message-ID-Hash: CIXWEUBXFZZE5YXOPDUV5PAHEPHK3YUC
X-Message-ID-Hash: CIXWEUBXFZZE5YXOPDUV5PAHEPHK3YUC
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@infradead.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Doug Ledford <dledford@redhat.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CIXWEUBXFZZE5YXOPDUV5PAHEPHK3YUC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 9, 2020 at 5:39 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
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
>
> The consequences of doing freeze are pretty serious, but it should
> still stop DMA.

Yes, it should.  The "freeze" callbacks are expected to prevent any
DMA transfers from being carried out after they have been executed.

Thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
