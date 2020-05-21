Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED86D1DD5EC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 May 2020 20:25:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D0B16116A73C2;
	Thu, 21 May 2020 11:22:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DF235116A73C1
	for <linux-nvdimm@lists.01.org>; Thu, 21 May 2020 11:22:03 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id d7so10008682eja.7
        for <linux-nvdimm@lists.01.org>; Thu, 21 May 2020 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YwUYwg+CLQOgC6tWQ0nf/KCJOGdB6U85I5T9cvPK9sc=;
        b=KS7JORp9DsKgUIvt5JXEaFpnA11L91iMMWFsivWQnjXs3K1pX1XkkkoKs2Ud3X+GWs
         HRKQZbYChh6MzqqUWneAs66Oe2BCjpo+ECtM2elPUEBt6p955NID7UDIWb7PJvI+c+4k
         Imd3VJf3HZjeTBNrg1JXcprt5byU76MyZqHusW79jjpqZGaxiVbjmweh5scDEpMrR/Q4
         dnhfnsZBR1lBiCLn8kxhUOlCqQM8R++HF9ZMx3V4Oqj7lu0pPutC1ssaYeAkR5nAwFLx
         QA7+hiZsy5QngbnCkD+f/qnaGNj+eQC+mtQ2sED1IztOBrcgZH26gUlGCHCPIPZG297+
         ADeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwUYwg+CLQOgC6tWQ0nf/KCJOGdB6U85I5T9cvPK9sc=;
        b=IHaF2PAvkubViSUfwzMvd9IbJhtfR8HGP/hsds3rIz4+Z/sO60BjEh/vsotpJ4ShUR
         0RNLje0gprt4R6JZ2nPXd9PXP49G5GOGKMM1Rks0AX8zGl4ZsB7KVLGg7n21QgOqzY8Z
         /ufBy87d/HFAHAMJ86eETy7To9QhZgyyZIHOVgCaP+GBaRCjEShPbVB/UN0oAdP8JpFO
         ahK5Z3bJ+a+zIO6Z+l4cN8RIP95ouKWgQP2DnvbF2L3YvF7zfHXbAT3QpCzT3sbrULGW
         T5vcfd2gIZkR9NIao+dpsuRAb8N6KFfivPUJRqjgaM5R3a77FOOQB9lNIxg8OdL/fzGO
         9iGA==
X-Gm-Message-State: AOAM5311YsKtYrx8+vckEZZ88pts9F6DETGGsPsBmpLTHKTB3Qbalhpf
	ucy5le+G5r/LmszjIdAh4oZj7Jk7Ks0YE5q22210jQ==
X-Google-Smtp-Source: ABdhPJy8pJpubVqu/7XqcrqgOQT1+M8QWKSTsrYdU6wHo4zCGAafptdzIZSEaehQat2AwvL6U/rw26oPq/LZ2HL1wEQ=
X-Received: by 2002:a17:906:fb0e:: with SMTP id lz14mr4644363ejb.237.1590085534177;
 Thu, 21 May 2020 11:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200513034705.172983-1-aneesh.kumar@linux.ibm.com>
 <20200513034705.172983-3-aneesh.kumar@linux.ibm.com> <CAPcyv4iAdrdMiSzVr1UL9Naya+Rq70WVuKqCCNFHe1C4n+E6Tw@mail.gmail.com>
 <87v9kspk3x.fsf@linux.ibm.com> <CAPcyv4g+oE305Q5bYWkNBKFifB9c0TZo6+hqFQnqiFqU5QFrhQ@mail.gmail.com>
 <87d070f2vs.fsf@linux.ibm.com> <CAPcyv4jZhYXEmYGzqGPjPtq9ZWJNtQyszN0V0Xcv0qtByK_KCw@mail.gmail.com>
 <x49o8qh9wu5.fsf@segfault.boston.devel.redhat.com> <ba91c061-41ef-5c54-8e9b-7b22e44577cd@linux.ibm.com>
In-Reply-To: <ba91c061-41ef-5c54-8e9b-7b22e44577cd@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 21 May 2020 11:25:22 -0700
Message-ID: <CAPcyv4iG9GC42s5DaWWegH=Mi7XHgJoUghgOM9qMRrCg4wuMig@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: XMUHN7WMGOZ2LD5R4REMPQRSAR3O4QF6
X-Message-ID-Hash: XMUHN7WMGOZ2LD5R4REMPQRSAR3O4QF6
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, alistair@popple.id.au, Mikulas Patocka <mpatocka@redhat.com>, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XMUHN7WMGOZ2LD5R4REMPQRSAR3O4QF6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 21, 2020 at 10:03 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 5/21/20 8:08 PM, Jeff Moyer wrote:
> > Dan Williams <dan.j.williams@intel.com> writes:
> >
> >>> But I agree with your concern that if we have older kernel/applications
> >>> that continue to use `dcbf` on future hardware we will end up
> >>> having issues w.r.t powerfail consistency. The plan is what you outlined
> >>> above as tighter ecosystem control. Considering we don't have a pmem
> >>> device generally available, we get both kernel and userspace upgraded
> >>> to use these new instructions before such a device is made available.
> >
> > I thought power already supported NVDIMM-N, no?  So are you saying that
> > those devices will continue to work with the existing flushing and
> > fencing mechanisms?
> >
>
> yes. these devices can continue to use 'dcbf + hwsync' as long as we are
> running them on P9.
>
>
> >> Ok, I think a compile time kernel option with a runtime override
> >> satisfies my concern. Does that work for you?
> >
> > The compile time option only helps when running newer kernels.  I'm not
> > sure how you would even begin to audit userspace applications (keep in
> > mind, not every application is open source, and not every application
> > uses pmdk).  I also question the merits of forcing the administrator to
> > make the determination of whether all applications on the system will
> > work properly.  Really, you have to rely on the vendor to tell you the
> > platform is supported, and at that point, why put further hurdles in the
> > way?
> >
> > The decision to require different instructions on ppc is unfortunate,
> > but one I'm sure we have no control over.  I don't see any merit in the
> > kernel disallowing MAP_SYNC access on these platforms.  Ideally, we'd
> > have some way of ensuring older kernels don't work with these new
> > platforms, but I don't think that's possible.
> >
>
>
> I am currently looking at the possibility of firmware present these
> devices with different device-tree compat values. So that older
> /existing kernel won't initialize the device on newer systems. Is that a
> good compromise? We still can end up with older userspace and newer
> kernel. One of the option suggested by Jan Kara is to use a prctl flag
> to control that? (intead of kernel parameter option I posted before)
>
>
> > Moving on to the patch itself--Aneesh, have you audited other persistent
> > memory users in the kernel?  For example, drivers/md/dm-writecache.c does
> > this:
> >
> > static void writecache_commit_flushed(struct dm_writecache *wc, bool wait_for_ios)
> > {
> >       if (WC_MODE_PMEM(wc))
> >               wmb(); <==========
> >          else
> >                  ssd_commit_flushed(wc, wait_for_ios);
> > }
> >
> > I believe you'll need to make modifications there.
> >
>
> Correct. Thanks for catching that.
>
>
> I don't understand dm much, wondering how this will work with
> non-synchronous DAX device?

That's a good point. DM-writecache needs to be cognizant of things
like virtio-pmem that violate the rule that persisent memory writes
can be flushed by CPU functions rather than calling back into the
driver. It seems we need to always make the flush case a dax_operation
callback to account for this.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
