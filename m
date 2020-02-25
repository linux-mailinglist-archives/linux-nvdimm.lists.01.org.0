Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F5D16EB5D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Feb 2020 17:25:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BA7B210FC35B7;
	Tue, 25 Feb 2020 08:26:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9686110FC35B6
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 08:26:31 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id v19so13096521oic.12
        for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 08:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/nrgd+DmYss2FNuLAttFYL2SOqESywg1hoJMWAiVICM=;
        b=cM2jY4/n6yTtkLoDOjp7XmVmrwodNUZjZTm3opcbsTYmFOHy0+cOUdixDj7xRQ6XGN
         u479OoBu+oEcAM0fars/ZrpifR2Ps9jAp1Q/baFf1HFTIbOShSSkkkRsmD217ZhF5y8q
         ePlyBaYRL8TolI8ZY5xsSteT9Vb0XYKeP8+aFCXNyO0TsZTPfORhJIZiOPrFINHbhkV1
         BaHNEsQaHeFrCvBcUyqxtELZ7GVoEXDBSC4wtzI7j0XN3Pa1MNDh2wWtrsnlIDVIJYrd
         zO45FAsr5hzEHCuZTMwakHVKsaufo6r5WMuQnWUgeeohNlZqZs8QfJ/cKdaOl4jw7eYd
         HbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/nrgd+DmYss2FNuLAttFYL2SOqESywg1hoJMWAiVICM=;
        b=AdTIGidmMOh82ZtK8PY7XSFlDxSTF5m8G5dZZRO5wU69pdRQMqGda+sDFUXEsiywrO
         5ilDUvW414Bl8CXMVdSXeT0sez9rc3H0skwqEwY9Dgx8KfDG9Ha0f0dX5onzoLu01bSb
         6HYS3jRzm7Ash4b3fY4uBxc4XCNTINCdnHmqeCqu44KYL66WV5BdkIQY24ZHwnwo0mOz
         1DFHIvReJ7imuUR9k21MurijlfUkLBv7R97BKePH8TU1mNXxliH9XyChMoF341N12OuU
         5iauLhGiOgbLxnexFWzIz5vqIaMM3ytKO6mkGwTShzP0XsTdnmlJh1/tJ7RoeNLFfpZm
         2xBw==
X-Gm-Message-State: APjAAAVP9kfKDAGk7DxGxqNPmrgRUWIIoo3auQdy4AwApjdjyzWYoEhB
	W0g2HvqBLvtM7b0+aohnIWbU76/UlyjsODhR/rxOjg==
X-Google-Smtp-Source: APXvYqwLLT7Um51UThPxPcgUpcMj1PQj6U1ajqUVQfBpeWnm2/39kvXIqmKi0usr7PgoBGmvxBU4ew4AvOYH0bhHHFE=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr4090014oia.73.1582647938250;
 Tue, 25 Feb 2020 08:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20200218214841.10076-3-vgoyal@redhat.com> <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
 <20200220215707.GC10816@redhat.com> <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
 <20200221201759.GF25974@redhat.com> <20200223230330.GE10737@dread.disaster.area>
 <20200224201346.GC14651@redhat.com> <CAPcyv4gGrimesjZ=OKRaYTDd5dUVz+U9aPeBMh_H3_YCz4FOEQ@mail.gmail.com>
 <20200224211553.GD14651@redhat.com> <CAPcyv4gX8p0YuMg3=r9DtPAO3Lz-96nuNyXbK1X5-cyVzNrDTA@mail.gmail.com>
 <20200225133653.GA7488@redhat.com>
In-Reply-To: <20200225133653.GA7488@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 25 Feb 2020 08:25:27 -0800
Message-ID: <CAPcyv4h2fdo=-jqLPTqnuxYVMbBgODWPqafH35yBMBaPa5Rxcw@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: V5X3D5YYA33XQ5U5TVQBPBZMQHJEPCSX
X-Message-ID-Hash: V5X3D5YYA33XQ5U5TVQBPBZMQHJEPCSX
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Chinner <david@fromorbit.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@infradead.org>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V5X3D5YYA33XQ5U5TVQBPBZMQHJEPCSX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 25, 2020 at 5:37 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Feb 24, 2020 at 01:32:58PM -0800, Dan Williams wrote:
>
> [..]
> > > > > Ok, how about if I add one more patch to the series which will check
> > > > > if unwritten portion of the page has known poison. If it has, then
> > > > > -EIO is returned.
> > > > >
> > > > >
> > > > > Subject: pmem: zero page range return error if poisoned memory in unwritten area
> > > > >
> > > > > Filesystems call into pmem_dax_zero_page_range() to zero partial page upon
> > > > > truncate. If partial page is being zeroed, then at the end of operation
> > > > > file systems expect that there is no poison in the whole page (atleast
> > > > > known poison).
> > > > >
> > > > > So make sure part of the partial page which is not being written, does not
> > > > > have poison. If it does, return error. If there is poison in area of page
> > > > > being written, it will be cleared.
> > > >
> > > > No, I don't like that the zero operation is special cased compared to
> > > > the write case. I'd say let's make them identical for now. I.e. fail
> > > > the I/O at dax_direct_access() time.
> > >
> > > So basically __dax_zero_page_range() will only write zeros (and not
> > > try to clear any poison). Right?
> >
> > Yes, the zero operation would have already failed at the
> > dax_direct_access() step if there was present poison.
> >
> > > > I think the error clearing
> > > > interface should be an explicit / separate op rather than a
> > > > side-effect. What about an explicit interface for initializing newly
> > > > allocated blocks, and the only reliable way to destroy poison through
> > > > the filesystem is to free the block?
> > >
> > > Effectively pmem_make_request() is already that interface filesystems
> > > use to initialize blocks and clear poison. So we don't really have to
> > > introduce a new interface?
> >
> > pmem_make_request() is shared with the I/O path and is too low in the
> > stack to understand intent. DAX intercepts the I/O path closer to the
> > filesystem and can understand zeroing vs writing today. I'm proposing
> > we go a step further and make DAX understand free-to-allocated-block
> > initialization instead of just zeroing. Inject the error clearing into
> > that initialization interface.
> >
> > > Or you are suggesting separate dax_zero_page_range() interface which will
> > > always call into firmware to clear poison. And that will make sure latent
> > > poison is cleared as well and filesystem should use that for block
> > > initialization instead?
> >
> > Yes, except latent poison would not be cleared until the zeroing is
> > implemented with movdir64b instead of callouts to firmware. It's
> > otherwise too slow to call out to firmware unconditionally.
> >
> > > I do like the idea of not having to differentiate
> > > between known poison and latent poison. Once a block has been initialized
> > > all poison should be cleared (known/latent). I am worried though that
> > > on large devices this might slowdown filesystem initialization a lot
> > > if they are zeroing large range of blocks.
> > >
> > > If yes, this sounds like two different patch series. First patch series
> > > takes care of removing blkdev_issue_zeroout() from
> > > __dax_zero_page_range() and couple of iomap related cleans christoph
> > > wanted.
> > >
> > > And second patch series for adding new dax operation to zero a range
> > > and always call info firmware to clear poison and modify filesystems
> > > accordingly.
> >
> > Yes, but they may need to be merged together. I don't want to regress
> > the ability of a block-aligned hole-punch to clear errors.
>
> Hi Dan,
>
> IIUC, block aligned hole punch don't go through __dax_zero_page_range()
> path. Instead they call blkdev_issue_zeroout() at later point of time.
>
> Only partial block zeroing path is taking __dax_zero_page_range(). So
> even if we remove poison clearing code from __dax_zero_page_range(),
> there should not be a regression w.r.t full block zeroing. Only possible
> regression will be if somebody was doing partial block zeroing on sector
> boundary, then poison will not be cleared.
>
> We now seem to be discussing too many issues w.r.t poison clearing
> and dax. Atleast 3 issues are mentioned in this thread.
>
> A. Get rid of dependency on block device in dax zeroing path.
>    (__dax_zero_page_range)
>
> B. Provide a way to clear latent poison. And possibly use movdir64b to
>    do that and make filesystems use that interface for initialization
>    of blocks.
>
> C. Dax zero operation is clearing known poison while copy_from_iter() is
>    not. I guess this ship has already sailed. If we change it now,
>    somebody will complain of some regression.
>
> For issue A, there are two possible ways to deal with it.
>
> 1. Implement a dax method to zero page. And this method will also clear
>    known poison. This is what my patch series is doing.
>
> 2. Just get rid of blkdev_issue_zeroout() from __dax_zero_page_range()
>    so that no poison will be cleared in __dax_zero_page_range() path. This
>    path is currently used in partial page zeroing path and full filesystem
>    block zeroing happens with blkdev_issue_zeroout(). There is a small
>    chance of regression here in case of sector aligned partial block
>    zeroing.
>
> My patch series takes care of issue A without any regressions. In fact it
> improves current interface. For example, currently "truncate -s 512
> foo.txt" will succeed even if first sector in the block is poisoned. My
> patch series fixes it. Current implementation will return error on if any
> non sector aligned truncate is done and any of the sector is poisoned. My
> implementation will not return error if poisoned can be cleared as part
> of zeroing. It will return only if poison is present in non-zeoring part.

That asymmetry makes the implementation too much of a special case. If
the dax mapping path forces error boundaries on PAGE_SIZE blocks then
so should zeroing.

>
> Why don't we solve one issue A now and deal with issue B and C later in
> a sepaprate patch series. This patch series gets rid of dependency on
> block device in dax path and also makes current zeroing interface better.

I'm ok with replacing blkdev_issue_zeroout() with a dax operation
callback that deals with page aligned entries. That change at least
makes the error boundary symmetric across copy_from_iter() and the
zeroing path.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
