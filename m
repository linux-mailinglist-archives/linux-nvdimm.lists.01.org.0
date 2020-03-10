Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E734D180939
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Mar 2020 21:33:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 69B7D10FC3633;
	Tue, 10 Mar 2020 13:34:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A135C10FC3632
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 13:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583872413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuAk3iiyWjaaAHQcjrLbiVUBF9ti+LNH3LoLdVoeonk=;
	b=h3z7i+m0E/Furw3ibgCuVIR88drjU+5nNtAn0QTgWrGYJldCD5ddW+EyeNB1WEpoDTCm9w
	vfP7HVDLaUMtgSAcYwIl9Y6ppv4UOPNfUkhkgXa12YTAKtXfALH8K8ANZghG2ScbE/tUPs
	O60WghebvjfPkU6AHm3JICEsqpGUFf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-KXglNHPLN0iwC4j7ViQC-w-1; Tue, 10 Mar 2020 16:33:31 -0400
X-MC-Unique: KXglNHPLN0iwC4j7ViQC-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41916184C80F;
	Tue, 10 Mar 2020 20:33:30 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A76C5D9CA;
	Tue, 10 Mar 2020 20:33:22 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 0E4F122021D; Tue, 10 Mar 2020 16:33:22 -0400 (EDT)
Date: Tue, 10 Mar 2020 16:33:21 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 12/20] fuse: Introduce setupmapping/removemapping commands
Message-ID: <20200310203321.GF38440@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-13-vgoyal@redhat.com>
 <CAJfpeguY8gDYVp_q3-W6JNA24zCry+SfWmEW2zuHLQLhmyUB3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJfpeguY8gDYVp_q3-W6JNA24zCry+SfWmEW2zuHLQLhmyUB3Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: RFFZ6PGBH4DML26MSEOQMAONLFQM2UMO
X-Message-ID-Hash: RFFZ6PGBH4DML26MSEOQMAONLFQM2UMO
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peng Tao <tao.peng@linux.alibaba.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RFFZ6PGBH4DML26MSEOQMAONLFQM2UMO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 10, 2020 at 08:49:49PM +0100, Miklos Szeredi wrote:
> On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Introduce two new fuse commands to setup/remove memory mappings. This
> > will be used to setup/tear down file mapping in dax window.
> >
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> > ---
> >  include/uapi/linux/fuse.h | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 5b85819e045f..62633555d547 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -894,4 +894,41 @@ struct fuse_copy_file_range_in {
> >         uint64_t        flags;
> >  };
> >
> > +#define FUSE_SETUPMAPPING_ENTRIES 8
> > +#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
> > +struct fuse_setupmapping_in {
> > +       /* An already open handle */
> > +       uint64_t        fh;
> > +       /* Offset into the file to start the mapping */
> > +       uint64_t        foffset;
> > +       /* Length of mapping required */
> > +       uint64_t        len;
> > +       /* Flags, FUSE_SETUPMAPPING_FLAG_* */
> > +       uint64_t        flags;
> > +       /* Offset in Memory Window */
> > +       uint64_t        moffset;
> > +};
> > +
> > +struct fuse_setupmapping_out {
> > +       /* Offsets into the cache of mappings */
> > +       uint64_t        coffset[FUSE_SETUPMAPPING_ENTRIES];
> > +        /* Lengths of each mapping */
> > +        uint64_t       len[FUSE_SETUPMAPPING_ENTRIES];
> > +};
> 
> fuse_setupmapping_out together with FUSE_SETUPMAPPING_ENTRIES seem to be unused.

This looks like leftover from the old code. I will get rid of it. Thanks.

Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
