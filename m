Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9666413F2E8
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jan 2020 19:39:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1929F10096CAC;
	Thu, 16 Jan 2020 10:42:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2A28710096CA7
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jan 2020 10:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1579199953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m9QaZpo4ehb9dzb9uGDth8ZZA66JROBihleoP8BqvZ0=;
	b=aBGYIdVkRtFwKGt5UjY4isvPaKX1Q2LCfIlD2Nvw1gcpmqs0MMHrnINFXVFdQi1z3O5Poc
	uVxrDZzhy9eQ+vMbIBRumYLjWz0ztW2BnX2iAwM0wmfX5Xw7zW5op/cISksGxNhLzsenfW
	pl0DPvxuS0YBpJyJm7+Da3z3vLPV0PU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-1KLdtB6dNpy1BWHwcYn6Kw-1; Thu, 16 Jan 2020 13:39:08 -0500
X-MC-Unique: 1KLdtB6dNpy1BWHwcYn6Kw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 422A7800D4C;
	Thu, 16 Jan 2020 18:39:06 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5CE9480617;
	Thu, 16 Jan 2020 18:39:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id D15EA220A24; Thu, 16 Jan 2020 13:39:00 -0500 (EST)
Date: Thu, 16 Jan 2020 13:39:00 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200116183900.GC25291@redhat.com>
References: <20200109112447.GG27035@quack2.suse.cz>
 <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com>
 <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com>
 <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
 <20200115195617.GA4133@redhat.com>
 <CAPcyv4iEoN9SnBveG7-Mhvd+wQApi1XKVnuYpyYxDybrFv_YYw@mail.gmail.com>
 <x49wo9smnqc.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4hCR9NV+2MF0iAJ5rHS2uiOgTnu=+yQRfpieDJQpQz22w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4hCR9NV+2MF0iAJ5rHS2uiOgTnu=+yQRfpieDJQpQz22w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: IFK6M667IOJ6MNDPHKDMY74NSCPQSMXQ
X-Message-ID-Hash: IFK6M667IOJ6MNDPHKDMY74NSCPQSMXQ
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IFK6M667IOJ6MNDPHKDMY74NSCPQSMXQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 16, 2020 at 10:09:46AM -0800, Dan Williams wrote:
> On Wed, Jan 15, 2020 at 1:08 PM Jeff Moyer <jmoyer@redhat.com> wrote:
> >
> > Hi, Dan,
> >
> > Dan Williams <dan.j.williams@intel.com> writes:
> >
> > > I'm going to take a look at how hard it would be to develop a kpartx
> > > fallback in udev. If that can live across the driver transition then
> > > maybe this can be a non-event for end users that already have that
> > > udev update deployed.
> >
> > I just wanted to remind you that label-less dimms still exist, and are
> > still being shipped.  For those devices, the only way to subdivide the
> > storage is via partitioning.
> 
> True, but if kpartx + udev can make this transparent then I don't
> think users lose any functionality. They just gain a device-mapper
> dependency.

So udev rules will trigger when a /dev/pmemX device shows up and run
kpartx which in turn will create dm-linear devices and device nodes
will show up in /dev/mapper/pmemXpY.

IOW, /dev/pmemXpY device nodes will be gone. So if any of the scripts or
systemd unit files are depenent on /dev/pmemXpY, these will still be
broken out of the box and will have to be modified to use device nodes
in /dev/mapper/ directory instead. Do I understand it right, Or I missed
the idea completely.

Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
