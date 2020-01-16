Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E634013F942
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jan 2020 20:24:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D49781007B8C3;
	Thu, 16 Jan 2020 11:27:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 23F9510096C97
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jan 2020 11:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1579202644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8HBHJP/uq6LLcUiW9DMmgfjF72wvEE4C0oRW83XDZw=;
	b=VcEOirFKhZ/qGMHCRLahr+bltd2l1gTxwfk5EDwDmKEoDSyWqgJEWy7o1n6L7SEvhvykxz
	hE6uzNQaU+jZx3E9qOdEBE1+E1NV4ECevJvap0VSJnxtEuADcPMLB5NyAcL/q8EG4JOPuC
	FWwffG4wDRPc+hjx2L9hdGdZ7pPsrdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-Wpe1cMcoOoGBY_oRiv4oYg-1; Thu, 16 Jan 2020 14:24:00 -0500
X-MC-Unique: Wpe1cMcoOoGBY_oRiv4oYg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 119012F2E;
	Thu, 16 Jan 2020 19:23:59 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3BC035D9C9;
	Thu, 16 Jan 2020 19:23:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id C1B6B220A24; Thu, 16 Jan 2020 14:23:53 -0500 (EST)
Date: Thu, 16 Jan 2020 14:23:53 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200116192353.GD25291@redhat.com>
References: <20200114203138.GA3145@redhat.com>
 <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com>
 <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
 <20200115195617.GA4133@redhat.com>
 <CAPcyv4iEoN9SnBveG7-Mhvd+wQApi1XKVnuYpyYxDybrFv_YYw@mail.gmail.com>
 <x49wo9smnqc.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4hCR9NV+2MF0iAJ5rHS2uiOgTnu=+yQRfpieDJQpQz22w@mail.gmail.com>
 <20200116183900.GC25291@redhat.com>
 <CAPcyv4irezimk8m4hysrd0rst_f0Rr+iiNxeFesqbxQnWYA2Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4irezimk8m4hysrd0rst_f0Rr+iiNxeFesqbxQnWYA2Xw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: 2GEZWGNA6YRXCSPCALAU2CFV2HZGBF4Z
X-Message-ID-Hash: 2GEZWGNA6YRXCSPCALAU2CFV2HZGBF4Z
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2GEZWGNA6YRXCSPCALAU2CFV2HZGBF4Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 16, 2020 at 11:09:00AM -0800, Dan Williams wrote:

[..]
> > > True, but if kpartx + udev can make this transparent then I don't
> > > think users lose any functionality. They just gain a device-mapper
> > > dependency.
> >
> > So udev rules will trigger when a /dev/pmemX device shows up and run
> > kpartx which in turn will create dm-linear devices and device nodes
> > will show up in /dev/mapper/pmemXpY.
> >
> > IOW, /dev/pmemXpY device nodes will be gone. So if any of the scripts or
> > systemd unit files are depenent on /dev/pmemXpY, these will still be
> > broken out of the box and will have to be modified to use device nodes
> > in /dev/mapper/ directory instead. Do I understand it right, Or I missed
> > the idea completely.
> 
> No, I'd write the udev rule to create links from /dev/pmemXpY to the
> /dev/mapper device, and that rule would be gated by a new pmem device
> attribute to trigger when kpartx needs to run vs the kernel native
> partitions.

Got it. This sounds much better.

Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
