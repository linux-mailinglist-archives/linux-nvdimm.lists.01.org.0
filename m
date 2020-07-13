Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7764E21D7C2
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 16:03:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6D3AC117E125B;
	Mon, 13 Jul 2020 07:03:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.96.170.134; helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN> 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D79F3117A72E9
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 07:03:41 -0700 (PDT)
Received: from 89-64-85-181.dynamic.chello.pl (89.64.85.181) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id c54b7b5dd9a458f8; Mon, 13 Jul 2020 16:03:38 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and callback for firmware activation
Date: Mon, 13 Jul 2020 16:03:36 +0200
Message-ID: <9508531.urFA0jK61m@kreacher>
In-Reply-To: <CAPcyv4iiYMXO1fH0yQ2eBzpOWqPag0W=ebJwV6spGpNJQ9hnrg@mail.gmail.com>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com> <23449996.3uVv1d17cZ@kreacher> <CAPcyv4iiYMXO1fH0yQ2eBzpOWqPag0W=ebJwV6spGpNJQ9hnrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: 62WRZYNR2V2QVA4KAVZMSDNUXGT5HELM
X-Message-ID-Hash: 62WRZYNR2V2QVA4KAVZMSDNUXGT5HELM
X-MailFrom: rjw@rjwysocki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/62WRZYNR2V2QVA4KAVZMSDNUXGT5HELM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

On Thursday, July 9, 2020 9:04:30 PM CEST Dan Williams wrote:
> On Thu, Jul 9, 2020 at 7:57 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Tuesday, July 7, 2020 3:59:32 AM CEST Dan Williams wrote:
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
> > > outside of user process direction. RDMA drivers also typically assume
> > > the system they are operating in will never be hibernated. A solution
> > > for RDMA collisions with firmware activation is outside the scope of
> > > this change and may need to rely on being able to survive the platform
> > > imposed memory controller quiesce period.
> >
> > Thanks for following my suggestion to use the hibernation infrastructure
> > rather than the suspend one, but I think it would be better to go a bit
> > further with that.
> >
> > Namely, after thinking about this a bit more I have come to the conclusion
> > that what is needed is an ability to execute a function, inside of the
> > kernel, in a "quiet" environment in which memory updates are unlikely.
> >
> > While the hibernation infrastructure as is can be used for that, kind of, IMO
> > it would be cleaner to introduce a helper for that, like in the (untested)
> > patch below, so if the "quiet execution environment" is needed, whoever
> > needs it may simply pass a function to hibernate_quiet_exec() and provide
> > whatever user-space I/F is suitable on top of that.
> >
> > Please let me know what you think.
> 
> This looks good to me in concept.
> 
> Would you expect that I trigger this from libnvdimm sysfs, or any
> future users of this functionality to trigger it through their own
> subsystem specific mechanisms?

Yes, I would.

> I have a place for it in libvdimm and could specify the activation
> method directly as "suspend" vs "live" activation.

Sounds good to me.

Cheers!


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
