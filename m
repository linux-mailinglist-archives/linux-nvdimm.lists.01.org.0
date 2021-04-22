Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297263687AD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Apr 2021 22:07:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5DA2E100EAB7F;
	Thu, 22 Apr 2021 13:07:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EB537100EC1D5
	for <linux-nvdimm@lists.01.org>; Thu, 22 Apr 2021 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619122072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+hZdBQQle+5F2SpSAhi/uqo7A+r/YVViB1bDRhu/Gc=;
	b=GoPTCebweoAUXd5uoZ9fdB3/1nqBDwnnAw7cAuF0KtituTijHHDDj22qN8dj83ReG+I7u9
	+HP3Pm3yMB8fCBhLV7xPMliljjgrH5Ju8F4fAuqgAZbtgru5yG9zaQRqQWgceyxpTMy21l
	lzxzTlMPtFqmRoJuvddyJRuPeX7MlGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-TEk5jmxrPV2ZVunGxe5gUw-1; Thu, 22 Apr 2021 16:07:48 -0400
X-MC-Unique: TEk5jmxrPV2ZVunGxe5gUw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ABAD107ACF3;
	Thu, 22 Apr 2021 20:07:47 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-206.rdu2.redhat.com [10.10.116.206])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 70E8563BA7;
	Thu, 22 Apr 2021 20:07:43 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id EEFEB220BCF; Thu, 22 Apr 2021 16:07:42 -0400 (EDT)
Date: Thu, 22 Apr 2021 16:07:42 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to
 put_unlocked_entry()
Message-ID: <20210422200742.GG1627633@redhat.com>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-3-vgoyal@redhat.com>
 <20210420093420.2eed3939@bahia.lan>
 <20210420140033.GA1529659@redhat.com>
 <CAPcyv4g2raipYhivwbiSvsHmSdgLO8wphh5dhY3hpjwko9G4Hw@mail.gmail.com>
 <20210422062458.GA4176641@infradead.org>
 <CAPcyv4h42yPKmWByBVkjgL_0LjBg3ZNYKLBJKgjixsdTzOpaiA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4h42yPKmWByBVkjgL_0LjBg3ZNYKLBJKgjixsdTzOpaiA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: Z6FTWYU2VZM3AZNBAKOV5F52A4BCP4SC
X-Message-ID-Hash: Z6FTWYU2VZM3AZNBAKOV5F52A4BCP4SC
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, Greg Kurz <groug@kaod.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Miklos Szeredi <miklos@szeredi.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtio-fs-list <virtio-fs@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z6FTWYU2VZM3AZNBAKOV5F52A4BCP4SC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 22, 2021 at 01:01:15PM -0700, Dan Williams wrote:
> On Wed, Apr 21, 2021 at 11:25 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Wed, Apr 21, 2021 at 12:09:54PM -0700, Dan Williams wrote:
> > > Can you get in the habit of not replying inline with new patches like
> > > this? Collect the review feedback, take a pause, and resend the full
> > > series so tooling like b4 and patchwork can track when a new posting
> > > supersedes a previous one. As is, this inline style inflicts manual
> > > effort on the maintainer.
> >
> > Honestly I don't mind it at all.  If you shiny new tooling can't handle
> > it maybe you should fix your shiny new tooling instead of changing
> > everyones workflow?
> 
> I think asking a submitter to resend a series is par for the course,
> especially for poor saps like me burdened by corporate email systems.
> Vivek, if this is too onerous a request just give me a heads up and
> I'll manually pull out the patch content from your replies.

I am fine with posting new version. Initially I thought that there
were only 1-2 minor cleanup comments so I posted inline, thinking
it might preferred method instead of posting full patch series again.

But then more comments came along. So posting another version makes
more sense now.

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
