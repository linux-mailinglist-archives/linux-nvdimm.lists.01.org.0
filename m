Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B57B181C18
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Mar 2020 16:12:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E129010FC36F2;
	Wed, 11 Mar 2020 08:13:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com; envelope-from=miklos@szeredi.hu; receiver=<UNKNOWN> 
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7D7B310FC3520
	for <linux-nvdimm@lists.01.org>; Wed, 11 Mar 2020 08:13:18 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h8so2269859iob.2
        for <linux-nvdimm@lists.01.org>; Wed, 11 Mar 2020 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDINA0vZuHEOMHgRG8O8q8Cv6r3DuQRO69eZhFF5eEI=;
        b=LPUXGEF5amYOBlrop1rcjSx8ZchMVTTL0Q8j/pP8BHayJceQuBOOq8WUjqMDAPx895
         9IIyKqEalpT/MkO9z+NdQ49IQUNX1zj6RNQIdOLxH8Ewy+cMoKO32n73pUaLUprt9QaW
         PJp5aNh7zDbiZn+7g0tDB0pJIQuBIRNfXjjoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDINA0vZuHEOMHgRG8O8q8Cv6r3DuQRO69eZhFF5eEI=;
        b=DstOZmCWo6fPZqlYQP7lw0HoiLz5TidgRuHKMQmaziy2bj0wBkEkVIJPlmy2JjL3y6
         o3bqRXKtMpottVVMEnM6RoLO5wRM2fXWz6t+BSQ1/Zty3z7zhEaGGcROnKKSDHNa5L+o
         w+UAe0i9o41Uqr7HLcnkZd4G8tDiG8IXE3Vpxn8S3YnOiUkZphw/Fjx/idAQHs1c9Fj/
         Y7aixfySoyLpvvYn/6SyqYhlUlzFshJ0EJrGEh0GqiD1ONEN1vQ+YeDDuhWWC1rSke0A
         lerWXEHfbMrS5w3AiDH21OYCEgInDqQMiCl3qF8eX2F3r0alxFHbqAbm7VPiliuMeILZ
         hmQw==
X-Gm-Message-State: ANhLgQ1DDq0aWuLSw8/4mThJfHMGEQKMZ3qZRc21qcAtS1UXVt6GkBRH
	XUBjAFrYxw6O7+K0M6CwiEbnuAaGXU5yIJpiXWq+CVrR
X-Google-Smtp-Source: ADFU+vvcCJuciXit7oxjlwuLQPMyjyQkvi+E6T6WbAs28DGpKmuWEM2zqBlhtPKMYLB1eY3XtFE56zv57fsgFipCP3s=
X-Received: by 2002:a6b:9386:: with SMTP id v128mr3374290iod.15.1583939546534;
 Wed, 11 Mar 2020 08:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-13-vgoyal@redhat.com>
 <CAJfpeguY8gDYVp_q3-W6JNA24zCry+SfWmEW2zuHLQLhmyUB3Q@mail.gmail.com>
 <20200310203321.GF38440@redhat.com> <CAOQ4uxh2WdLdbcMp+qvQCX2hiBx+hLO1z5wkZtc-7GCuDdsthw@mail.gmail.com>
 <CAJfpeguwqEsPLtph73AG7bhm1Dp4ahyJtyW=Ud7L-OFwyEmwWg@mail.gmail.com> <20200311144124.GB83257@redhat.com>
In-Reply-To: <20200311144124.GB83257@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 Mar 2020 16:12:15 +0100
Message-ID: <CAJfpegvTo=FX5y+8R3hdkv6mOTAUQgg9qmzvL5oStddFW0OBgg@mail.gmail.com>
Subject: Re: [PATCH 12/20] fuse: Introduce setupmapping/removemapping commands
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: JVRDTF2KT7PYQ6RCSUW5ZMKD4RMHYYSM
X-Message-ID-Hash: JVRDTF2KT7PYQ6RCSUW5ZMKD4RMHYYSM
X-MailFrom: miklos@szeredi.hu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peng Tao <tao.peng@linux.alibaba.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JVRDTF2KT7PYQ6RCSUW5ZMKD4RMHYYSM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 11, 2020 at 3:41 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Mar 11, 2020 at 03:19:18PM +0100, Miklos Szeredi wrote:
> > On Wed, Mar 11, 2020 at 8:03 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Tue, Mar 10, 2020 at 10:34 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Tue, Mar 10, 2020 at 08:49:49PM +0100, Miklos Szeredi wrote:
> > > > > On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > >
> > > > > > Introduce two new fuse commands to setup/remove memory mappings. This
> > > > > > will be used to setup/tear down file mapping in dax window.
> > > > > >
> > > > > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > > > > Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> > > > > > ---
> > > > > >  include/uapi/linux/fuse.h | 37 +++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 37 insertions(+)
> > > > > >
> > > > > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > > > > index 5b85819e045f..62633555d547 100644
> > > > > > --- a/include/uapi/linux/fuse.h
> > > > > > +++ b/include/uapi/linux/fuse.h
> > > > > > @@ -894,4 +894,41 @@ struct fuse_copy_file_range_in {
> > > > > >         uint64_t        flags;
> > > > > >  };
> > > > > >
> > > > > > +#define FUSE_SETUPMAPPING_ENTRIES 8
> > > > > > +#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
> > > > > > +struct fuse_setupmapping_in {
> > > > > > +       /* An already open handle */
> > > > > > +       uint64_t        fh;
> > > > > > +       /* Offset into the file to start the mapping */
> > > > > > +       uint64_t        foffset;
> > > > > > +       /* Length of mapping required */
> > > > > > +       uint64_t        len;
> > > > > > +       /* Flags, FUSE_SETUPMAPPING_FLAG_* */
> > > > > > +       uint64_t        flags;
> > > > > > +       /* Offset in Memory Window */
> > > > > > +       uint64_t        moffset;
> > > > > > +};
> > > > > > +
> > > > > > +struct fuse_setupmapping_out {
> > > > > > +       /* Offsets into the cache of mappings */
> > > > > > +       uint64_t        coffset[FUSE_SETUPMAPPING_ENTRIES];
> > > > > > +        /* Lengths of each mapping */
> > > > > > +        uint64_t       len[FUSE_SETUPMAPPING_ENTRIES];
> > > > > > +};
> > > > >
> > > > > fuse_setupmapping_out together with FUSE_SETUPMAPPING_ENTRIES seem to be unused.
> > > >
> > > > This looks like leftover from the old code. I will get rid of it. Thanks.
> > > >
> > >
> > > Hmm. I wonder if we should keep some out args for future extensions.
> > > Maybe return the mapped size even though it is all or nothing at this
> > > point?
> > >
> > > I have interest in a similar FUSE mapping functionality that was prototyped
> > > by Miklos and published here:
> > > https://lore.kernel.org/linux-fsdevel/CAJfpegtjEoE7H8tayLaQHG9fRSBiVuaspnmPr2oQiOZXVB1+7g@mail.gmail.com/
> > >
> > > In this prototype, a FUSE_MAP command is used by the server to map a
> > > range of file to the kernel for io. The command in args are quite similar to
> > > those in fuse_setupmapping_in, but since the server is on the same host,
> > > the mapping response is {mapfd, offset, size}.
> >
> > Right.  So the difference is in which entity allocates the mapping.
> > IOW whether the {fd, offset, size} is input or output in the protocol.
> >
> > I don't remember the reasons for going with the mapping being
> > allocated by the client, not the other way round.   Vivek?
>
> I think one of the main reasons is memory reclaim. Once all ranges in
> a cache range are allocated, we need to free a memory range which can be
> reused. And client has all the logic to free up that range so that it can
> be remapped and reused for a different file/offset. Server will not know
> any of this. So I will think that for virtiofs, server might not be
> able to decide where to map a section of file and it has to be told
> explicitly by the client.

Okay.

> >
> > If the allocation were to be by the server, we could share the request
> > type and possibly some code between the two, although the I/O
> > mechanism would still be different.
> >
>
> So input parameters of both FUSE_SETUPMAPPING and FUSE_MAP seem
> similar (except the moffset field).  Given output of FUSE_MAP reqeust
> is very different, I would think it will be easier to have it as a
> separate command.
>
> Or can it be some sort of optional output args which can differentiate
> between two types of requests.
>
> /me personally finds it simpler to have separate command instead of
> overloading FUSE_SETUPMAPPING. But its your call. :-)

I too prefer a separate request type.

Thanks,
Miklos
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
