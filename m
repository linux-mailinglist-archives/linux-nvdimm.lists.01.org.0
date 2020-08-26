Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34906253896
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Aug 2020 21:53:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 807ED123B96A7;
	Wed, 26 Aug 2020 12:53:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 55AF8123B96A5
	for <linux-nvdimm@lists.01.org>; Wed, 26 Aug 2020 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1598471601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GTZBfQJrZmGoOihET1Kwf2wGDuCL4pavAJzlhd2obj8=;
	b=Fd75T1FCRJYv7NasWwkOFUNhoXBot2Vfy0viot5CJZQbfLNWpiC17ydU1DtoMvjL8EWUZV
	1IVtyCLCk0Glzj9Qur3bz4DFeA8sYz7TfCgm87kcOtDAAjfmBmX8chpHNvdy07vjFz1pwC
	bD6i2IblAx3oPE2vWE0Lqwgrj/VUiQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-F0p-GF9QNC20GO3wYDSSDA-1; Wed, 26 Aug 2020 15:53:19 -0400
X-MC-Unique: F0p-GF9QNC20GO3wYDSSDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2139E1074646;
	Wed, 26 Aug 2020 19:53:18 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-36.rdu2.redhat.com [10.10.115.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53B8719C58;
	Wed, 26 Aug 2020 19:53:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id A14A6223C69; Wed, 26 Aug 2020 15:53:11 -0400 (EDT)
Date: Wed, 26 Aug 2020 15:53:11 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v3 11/18] fuse: implement FUSE_INIT map_alignment field
Message-ID: <20200826195311.GB1043442@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
 <20200819221956.845195-12-vgoyal@redhat.com>
 <CAJfpegsgHE0MkZLFgE4yrZXO5ThDxCj85-PjizrXPRC2CceT1g@mail.gmail.com>
 <20200826155142.GA1043442@redhat.com>
 <20200826173408.GA11480@stefanha-x1.localdomain>
 <20200826191711.GF3932@work-vm>
 <CAJfpegvqZUXsvbWg8K-xosNR+RVwRm2KH+S9mKs6n6Sv65s+Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJfpegvqZUXsvbWg8K-xosNR+RVwRm2KH+S9mKs6n6Sv65s+Qg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: ELI2KXEG5UJIMWHYTXRQVKWX6C7CXJ2Q
X-Message-ID-Hash: ELI2KXEG5UJIMWHYTXRQVKWX6C7CXJ2Q
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs-list <virtio-fs@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ELI2KXEG5UJIMWHYTXRQVKWX6C7CXJ2Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 26, 2020 at 09:26:29PM +0200, Miklos Szeredi wrote:
> On Wed, Aug 26, 2020 at 9:17 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> 
> > Agreed, because there's not much that the server can do about it if the
> > client would like a smaller granularity - the servers granularity might
> > be dictated by it's mmap/pagesize/filesystem.  If the client wants a
> > larger granularity that's it's choice when it sends the setupmapping
> > calls.
> 
> What bothers me is that the server now comes with the built in 2MiB
> granularity (obviously much larger than actually needed).
> 
> What if at some point we'd want to reduce that somewhat in the client?
>   Yeah, we can't.   Maybe this is not a kernel problem after all, the
> proper thing would be to fix the server to actually send something
> meaningful.

Hi Miklos,

Current implementation of virtiofsd reports this map alignment as
PAGE_SIZE.

        /* This constraint comes from mmap(2) and munmap(2) */
        outarg.map_alignment = ffsl(sysconf(_SC_PAGE_SIZE)) - 1;

Which should be 4K on x86. 

And that means if client wants it can drop to dax mapping size as
small as 4K and still meeting alignment constratints. Just that by
default we have chosen 2MB as of now fearing there might be too
many small mmap() calls on host and we will hit various limits.

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
