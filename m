Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82391181AFE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Mar 2020 15:19:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E750610FC36ED;
	Wed, 11 Mar 2020 07:20:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::144; helo=mail-il1-x144.google.com; envelope-from=miklos@szeredi.hu; receiver=<UNKNOWN> 
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B20F10FC36EC
	for <linux-nvdimm@lists.01.org>; Wed, 11 Mar 2020 07:20:21 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id a14so2142936ilk.6
        for <linux-nvdimm@lists.01.org>; Wed, 11 Mar 2020 07:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69ujJbtlPdE8oHv4nVIHA9iuyZRWDdoY3VvgQ+IBL2s=;
        b=cGM2MeQBmZSBuReLBU5d5sTRAoFDL2XQyMomBEOKrqeyIMkpsthwL9Qv2AhBzaksHC
         FZlfcVPmnf9pOrb3hqBmXEtqtUjv86fzG9yFxvtSAhUSNpTVjDmB73wbXrbIMMTcJZ9W
         zNerL5x3klshUWu2R6Mt6dC6OSXgWwOaqpPMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69ujJbtlPdE8oHv4nVIHA9iuyZRWDdoY3VvgQ+IBL2s=;
        b=oileJeQ4wI2x/P7OLnqwBrtGGy+flETOirYSuBUWMxBAcxK5CfXJar9APzOKTY3tU9
         EWUEXKsdjDegZjMurQJej35B3Zg84rZlP+AQ882hBoP1KQ0rownSEP+pCBOuawthhzzt
         KOeguDctMrPC+YaqIRQxadC+csXRevoi8Ej/4hLvNG8RY3auQg1DiGR+7oorFsW2sJph
         jMZxi4tYJP7ZsCYcTFRTf4ppDzaD4PSkHxQsdcd9oVqghF0sNvqLv3+0rf+XvUO7JvxT
         7WkUfWISTJtKieq9k12Ip7BeJeqzf/aXP8qrEf9L+iIbuN7avCIBNx/kBSdw72h9Fmp1
         HRtQ==
X-Gm-Message-State: ANhLgQ1Ug4k5N352fSIz1EYK6QpV8F3NqF5fEjolYBWXImX4G5wCZlgT
	cKyB1TEpAbB6WyjCdhGk3NcP3sqduVU/KCPnpvlQCg==
X-Google-Smtp-Source: ADFU+vvoUOuyvMliGwkz0P8h8ggIixG2ZD2Fxb/0cgUuBOmTlGIQvpOe4dIt1GjgKNufXq4bt8ec4c0D2ckAdFT+N1E=
X-Received: by 2002:a92:d745:: with SMTP id e5mr3226635ilq.285.1583936369678;
 Wed, 11 Mar 2020 07:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-13-vgoyal@redhat.com>
 <CAJfpeguY8gDYVp_q3-W6JNA24zCry+SfWmEW2zuHLQLhmyUB3Q@mail.gmail.com>
 <20200310203321.GF38440@redhat.com> <CAOQ4uxh2WdLdbcMp+qvQCX2hiBx+hLO1z5wkZtc-7GCuDdsthw@mail.gmail.com>
In-Reply-To: <CAOQ4uxh2WdLdbcMp+qvQCX2hiBx+hLO1z5wkZtc-7GCuDdsthw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 Mar 2020 15:19:18 +0100
Message-ID: <CAJfpeguwqEsPLtph73AG7bhm1Dp4ahyJtyW=Ud7L-OFwyEmwWg@mail.gmail.com>
Subject: Re: [PATCH 12/20] fuse: Introduce setupmapping/removemapping commands
To: Amir Goldstein <amir73il@gmail.com>
Message-ID-Hash: G5WCLX5PJLKC3KIG5HCWAURYKSHYNZ55
X-Message-ID-Hash: G5WCLX5PJLKC3KIG5HCWAURYKSHYNZ55
X-MailFrom: miklos@szeredi.hu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peng Tao <tao.peng@linux.alibaba.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G5WCLX5PJLKC3KIG5HCWAURYKSHYNZ55/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 11, 2020 at 8:03 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Mar 10, 2020 at 10:34 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Mar 10, 2020 at 08:49:49PM +0100, Miklos Szeredi wrote:
> > > On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > Introduce two new fuse commands to setup/remove memory mappings. This
> > > > will be used to setup/tear down file mapping in dax window.
> > > >
> > > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > > Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> > > > ---
> > > >  include/uapi/linux/fuse.h | 37 +++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 37 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > > index 5b85819e045f..62633555d547 100644
> > > > --- a/include/uapi/linux/fuse.h
> > > > +++ b/include/uapi/linux/fuse.h
> > > > @@ -894,4 +894,41 @@ struct fuse_copy_file_range_in {
> > > >         uint64_t        flags;
> > > >  };
> > > >
> > > > +#define FUSE_SETUPMAPPING_ENTRIES 8
> > > > +#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
> > > > +struct fuse_setupmapping_in {
> > > > +       /* An already open handle */
> > > > +       uint64_t        fh;
> > > > +       /* Offset into the file to start the mapping */
> > > > +       uint64_t        foffset;
> > > > +       /* Length of mapping required */
> > > > +       uint64_t        len;
> > > > +       /* Flags, FUSE_SETUPMAPPING_FLAG_* */
> > > > +       uint64_t        flags;
> > > > +       /* Offset in Memory Window */
> > > > +       uint64_t        moffset;
> > > > +};
> > > > +
> > > > +struct fuse_setupmapping_out {
> > > > +       /* Offsets into the cache of mappings */
> > > > +       uint64_t        coffset[FUSE_SETUPMAPPING_ENTRIES];
> > > > +        /* Lengths of each mapping */
> > > > +        uint64_t       len[FUSE_SETUPMAPPING_ENTRIES];
> > > > +};
> > >
> > > fuse_setupmapping_out together with FUSE_SETUPMAPPING_ENTRIES seem to be unused.
> >
> > This looks like leftover from the old code. I will get rid of it. Thanks.
> >
>
> Hmm. I wonder if we should keep some out args for future extensions.
> Maybe return the mapped size even though it is all or nothing at this
> point?
>
> I have interest in a similar FUSE mapping functionality that was prototyped
> by Miklos and published here:
> https://lore.kernel.org/linux-fsdevel/CAJfpegtjEoE7H8tayLaQHG9fRSBiVuaspnmPr2oQiOZXVB1+7g@mail.gmail.com/
>
> In this prototype, a FUSE_MAP command is used by the server to map a
> range of file to the kernel for io. The command in args are quite similar to
> those in fuse_setupmapping_in, but since the server is on the same host,
> the mapping response is {mapfd, offset, size}.

Right.  So the difference is in which entity allocates the mapping.
IOW whether the {fd, offset, size} is input or output in the protocol.

I don't remember the reasons for going with the mapping being
allocated by the client, not the other way round.   Vivek?

If the allocation were to be by the server, we could share the request
type and possibly some code between the two, although the I/O
mechanism would still be different.

Thanks,
Miklos
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
