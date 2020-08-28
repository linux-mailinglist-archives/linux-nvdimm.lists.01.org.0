Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8627B255CB7
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Aug 2020 16:39:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 99DC3126E40A1;
	Fri, 28 Aug 2020 07:39:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4C829128DF647
	for <linux-nvdimm@lists.01.org>; Fri, 28 Aug 2020 07:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1598625558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xXdUNx6QngQBU5zDo1lz76/LssJKQsScUXNWpp00Eho=;
	b=c/N+dOXanFHcfaUNPhbdMtX2/SqpRULmFZciwNMVkmwjrHuUQmzy8tYQ3dWIwK7Kf2cCKS
	d/yrqvKsJjyfaLmw0LoCGBmu5RvPxrMIsh9eYjEfg58B68uKCIR8ShP3GubPHQcPsUHu7d
	aI8hU8XqX7RsvrPkn6AhyXIxiZT22pM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-M3x4kwkqNj6QiCGto2MI8A-1; Fri, 28 Aug 2020 10:39:14 -0400
X-MC-Unique: M3x4kwkqNj6QiCGto2MI8A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EA17100746C;
	Fri, 28 Aug 2020 14:39:13 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-215.rdu2.redhat.com [10.10.116.215])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 946967D4ED;
	Fri, 28 Aug 2020 14:39:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 0C65B220C5B; Fri, 28 Aug 2020 10:39:02 -0400 (EDT)
Date: Fri, 28 Aug 2020 10:39:01 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v3 00/18] virtiofs: Add DAX support
Message-ID: <20200828143901.GB1115001@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
 <CAJfpegv5ro-nJTsbx7DMu6=CDXnQ=dzXBRYEKxKc6Bx+Bxmobw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJfpegv5ro-nJTsbx7DMu6=CDXnQ=dzXBRYEKxKc6Bx+Bxmobw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: DM35DHLM7XIXYLYR6MNEJYBYIPWK353H
X-Message-ID-Hash: DM35DHLM7XIXYLYR6MNEJYBYIPWK353H
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs-list <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DM35DHLM7XIXYLYR6MNEJYBYIPWK353H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Aug 28, 2020 at 04:26:55PM +0200, Miklos Szeredi wrote:
> On Thu, Aug 20, 2020 at 12:21 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Hi All,
> >
> > This is V3 of patches. I had posted version v2 version here.
> 
> Pushed to:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#dax
> 
> Fixed a couple of minor issues, and added two patches:
> 
> 1. move dax specific code from fuse core to a separate source file
> 
> 2. move dax specific data, as well as allowing dax to be configured out
> 
> I think it would be cleaner to fold these back into the original
> series, but for now I'm just asking for comments and testing.

Thanks Miklos. I will have a look and test.

Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
