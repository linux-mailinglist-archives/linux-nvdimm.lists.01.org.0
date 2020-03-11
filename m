Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC581181166
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Mar 2020 08:04:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 91CF810FC36E7;
	Wed, 11 Mar 2020 00:04:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d43; helo=mail-io1-xd43.google.com; envelope-from=amir73il@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DF27A10FC36E5
	for <linux-nvdimm@lists.01.org>; Wed, 11 Mar 2020 00:04:46 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m25so810233ioo.8
        for <linux-nvdimm@lists.01.org>; Wed, 11 Mar 2020 00:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hb6iJ/Efn6V2wxOcA+ehqPLCrGm2i7aFEcinNiAwTg=;
        b=rd8rhWCgH//f6swHt00TfU44oSyrPrCf9zNhKCp43xO5/c/lia8gyyB94BWGxKw6yV
         QOm0DqL9P4U5T2uB6Inj7XI/UlbsEfDNG3do1rbezI/44mNdmxVEQCDVkll8kGrYaAts
         AnQLHHVMbGjbmGMLgv1f/s/a2ayaX6Up7a8Mk/4/8kxlP++P1jSBtRfGYdv1fszrCbxB
         J4YKst/ZXrjqvQcelfdiL548nQVPzdxVY02bdopH9Vz+v97xEl+GHknDNi4r2tcrPYJy
         YXna9QlT8wDB2bvqb0c0qdd8LBkPPhhTwJblfNdloF3Yaj4tR2lznGCBm/Z0Trm4sqID
         A62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hb6iJ/Efn6V2wxOcA+ehqPLCrGm2i7aFEcinNiAwTg=;
        b=Xb04yKSBt4RYwNgHY1gdkplm3qMH9SIpw9s1KXX2b2LBB6HjoUudltvdJrpe/qdZ3F
         zmdKI9jQK7Yyez/rDS/8ECcCga5jSsN31gP+RzvOp5lo/XZSA4IUnWFH4B5sHVz6ml/r
         B5V/YUal9nfPyOQXAso8nzGuPNyaT73/He1jM1T1Hw8AfvevymsbNOoOhd/ZkJpxqmaF
         odEUQlorcHxTxVs+AJomJdfa/gbunQOVpdBP1vSqIl7bk1jrVFicZzy4AbYQjWDX9MgX
         A7aQyElosXgKLiund5dcYSLCtuE+ZNt42RRLAr10l/TtXN7OtWAX/bhSLpniWaxFpC3B
         cC7g==
X-Gm-Message-State: ANhLgQ08gep9lhBiec2CZt6K+DNR+A2QR++a0S5TZirz+i8uG7m8A4ZX
	0ZXiIRfuEJ4IJ/xZkTj44L7pVlhuMgnPidtpQvE=
X-Google-Smtp-Source: ADFU+vsVx9UgJ7cAQ6SG+cvSpbW4652fcOa7BWrz3sf2jEUSFhkJmAIC862rB5+gVmJyC7VWx0RpfWNz15LQu2ii7R0=
X-Received: by 2002:a6b:f718:: with SMTP id k24mr1627720iog.186.1583910234416;
 Wed, 11 Mar 2020 00:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-13-vgoyal@redhat.com>
 <CAJfpeguY8gDYVp_q3-W6JNA24zCry+SfWmEW2zuHLQLhmyUB3Q@mail.gmail.com> <20200310203321.GF38440@redhat.com>
In-Reply-To: <20200310203321.GF38440@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 11 Mar 2020 09:03:42 +0200
Message-ID: <CAOQ4uxh2WdLdbcMp+qvQCX2hiBx+hLO1z5wkZtc-7GCuDdsthw@mail.gmail.com>
Subject: Re: [PATCH 12/20] fuse: Introduce setupmapping/removemapping commands
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: HHANEB3YLZY26O7JV66AMOPV24IVG3LC
X-Message-ID-Hash: HHANEB3YLZY26O7JV66AMOPV24IVG3LC
X-MailFrom: amir73il@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peng Tao <tao.peng@linux.alibaba.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HHANEB3YLZY26O7JV66AMOPV24IVG3LC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 10, 2020 at 10:34 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Mar 10, 2020 at 08:49:49PM +0100, Miklos Szeredi wrote:
> > On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > Introduce two new fuse commands to setup/remove memory mappings. This
> > > will be used to setup/tear down file mapping in dax window.
> > >
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> > > ---
> > >  include/uapi/linux/fuse.h | 37 +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > index 5b85819e045f..62633555d547 100644
> > > --- a/include/uapi/linux/fuse.h
> > > +++ b/include/uapi/linux/fuse.h
> > > @@ -894,4 +894,41 @@ struct fuse_copy_file_range_in {
> > >         uint64_t        flags;
> > >  };
> > >
> > > +#define FUSE_SETUPMAPPING_ENTRIES 8
> > > +#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
> > > +struct fuse_setupmapping_in {
> > > +       /* An already open handle */
> > > +       uint64_t        fh;
> > > +       /* Offset into the file to start the mapping */
> > > +       uint64_t        foffset;
> > > +       /* Length of mapping required */
> > > +       uint64_t        len;
> > > +       /* Flags, FUSE_SETUPMAPPING_FLAG_* */
> > > +       uint64_t        flags;
> > > +       /* Offset in Memory Window */
> > > +       uint64_t        moffset;
> > > +};
> > > +
> > > +struct fuse_setupmapping_out {
> > > +       /* Offsets into the cache of mappings */
> > > +       uint64_t        coffset[FUSE_SETUPMAPPING_ENTRIES];
> > > +        /* Lengths of each mapping */
> > > +        uint64_t       len[FUSE_SETUPMAPPING_ENTRIES];
> > > +};
> >
> > fuse_setupmapping_out together with FUSE_SETUPMAPPING_ENTRIES seem to be unused.
>
> This looks like leftover from the old code. I will get rid of it. Thanks.
>

Hmm. I wonder if we should keep some out args for future extensions.
Maybe return the mapped size even though it is all or nothing at this
point?

I have interest in a similar FUSE mapping functionality that was prototyped
by Miklos and published here:
https://lore.kernel.org/linux-fsdevel/CAJfpegtjEoE7H8tayLaQHG9fRSBiVuaspnmPr2oQiOZXVB1+7g@mail.gmail.com/

In this prototype, a FUSE_MAP command is used by the server to map a
range of file to the kernel for io. The command in args are quite similar to
those in fuse_setupmapping_in, but since the server is on the same host,
the mapping response is {mapfd, offset, size}.

I wonder, if we decide to go forward with this prototype (and I may well decide
to drive this forward), should the new command be overloading
FUSE_SETUPMAPPING, by using new flags or should it be a new
command? In either case, I think it would be best to try and make a decision
now in order to avoid ambiguity with protocol command/flag names later on.

If we decide that those are completely different beasts and it is agreed that
the future command will be named, for example, FUSE_SETUPIOMAP
with different arguments and that this naming will not create confusion and
ambiguity with FUSE_SETUPMAPPING, then there is no actionable item at
this time.

But it is possible that there is something to gain from using the same
command(?) and same book keeping mechanism for both types of
mappings. Even server on same host could decide that it wants
to map some file regions via mmap and some via iomap.
In that case, perhaps we should make the FUSE_SETUPMAPPING
response args expressive enough to be able to express an iomap
mapping in the future and perhaps dax code should explicitly request
for FUSE_SETUPMAPPING_FLAG_DAX mapping type?

Thoughts?

Amir.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
