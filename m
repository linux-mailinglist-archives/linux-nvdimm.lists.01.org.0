Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 053F6170694
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Feb 2020 18:50:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BE16F10FC361A;
	Wed, 26 Feb 2020 09:50:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3015D10FC3587
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 09:50:56 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id z9so246719oth.5
        for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 09:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N2xgeoOIlnHtA+LAnhlcA+wDvVvlFpD7TPrmkdwAVUA=;
        b=oYHUecFZafU/4PaUw48FVfCsr4kr/X+X2x3aPUHy+GQg6mqfdMnMhZTZU36+0lpYUM
         0amLSgezEUDAoYx4aWB3N4wd7HCN3KIJ+K9bhMx0s1xfIK5OpGbsmfgpKdlybiCl/0NE
         C5i5+Mu3kFjW6JPkIPs55J+sfEosC2XilzwJwWaC7J1YdEEce/t3sG0J8nc4u6uwzCqa
         RdByzTla1b3us7KGrcX52yCNcuWBNlWWJwJDZVR+ojmZfXh8SL9vkkQ55ZaJ7y11XIQI
         s7s8rQWyosAA63vAuIDqFxeEmUQ3lNWizAW7oYG/b99cZt41P/pEdbFzfMgCAei8JDzi
         Dx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2xgeoOIlnHtA+LAnhlcA+wDvVvlFpD7TPrmkdwAVUA=;
        b=W22r0Pg6Yq5VQocaX1ACLxwyNM/aBbgep3TfURW2xfFsHFcEjqDSwPw9jbwNSCjr5x
         uCoQf7px6u/YDyLxZNP1nmd8fqq2NYzb9GB+9NZPMkiqUrK7WymogqZupDvrUbG9wkyD
         YSVdVn5InneH5j5nbG3i8YsOq8n+qIegNUk3JuFuvEeqUXczMQ/PTEaWVB10ecCdjaQz
         dwFIRY6/JP5VCfImaajH+BPmXHLAjtqsstveIDvYNFG2a/t+1NxbD3bGJ/MTsquHmxWv
         hu1M61F/s4HXjeqwxCVMaLVP2Of7nzPKpW4Yw5d7FlarwTub/kMU0f7Sbziem+3BvWZg
         6QYw==
X-Gm-Message-State: APjAAAWwnbEzpV/1vpeYEkyT1pluZ/O0GSsfkrOOkLapxNf+ygGQOIBy
	WZPKcdM/xxq175EqQ27AehngD6Kcv73NZdtnsc1Oew==
X-Google-Smtp-Source: APXvYqyWuRqzU9Q88C55i+k9XHWv+bCfOqhqNkM5AwW/LL+msx16ZpnDrqhMdxwiiQhhRIg4xvhguTeyog5NAh8Kxfw=
X-Received: by 2002:a05:6830:134c:: with SMTP id r12mr4029057otq.126.1582739403834;
 Wed, 26 Feb 2020 09:50:03 -0800 (PST)
MIME-Version: 1.0
References: <158042414995.3946705.2742716492944802875.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158042415512.3946705.18330231517256727320.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49o8tulai8.fsf@segfault.boston.devel.redhat.com> <CAPcyv4izzfzrb2r7Mc7FfryGnBcn1bOUA8a6_L9t2fKR4caoXw@mail.gmail.com>
In-Reply-To: <CAPcyv4izzfzrb2r7Mc7FfryGnBcn1bOUA8a6_L9t2fKR4caoXw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 26 Feb 2020 09:49:52 -0800
Message-ID: <CAPcyv4hdDvj+1Wa5y7w-p+8bwT-n+4h9oBXynk=tt55Hx8mGeg@mail.gmail.com>
Subject: Re: [ndctl PATCH 1/2] ndctl/region: Support ndctl_region_{get, set}_align()
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: JJMZHTLVXSCRIFHMXOYHSA3VRL4UPU2O
X-Message-ID-Hash: JJMZHTLVXSCRIFHMXOYHSA3VRL4UPU2O
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JJMZHTLVXSCRIFHMXOYHSA3VRL4UPU2O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 25, 2020 at 3:23 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Feb 19, 2020 at 10:04 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >
> > Dan Williams <dan.j.williams@intel.com> writes:
> >
> > >
> > > +NDCTL_EXPORT unsigned long ndctl_region_get_align(struct ndctl_region *region)
> > > +{
> > > +     return region->align;
> > > +}
> > > +
> > > +NDCTL_EXPORT int ndctl_region_set_align(struct ndctl_region *region,
> > > +             unsigned long align)
> > > +{
> > > +     struct ndctl_ctx *ctx = ndctl_region_get_ctx(region);
> > > +     char *path = region->region_buf;
> > > +     int len = region->buf_len, rc;
> > > +     char buf[SYSFS_ATTR_SIZE];
> > > +
> > > +     if (snprintf(path, len, "%s/align", region->region_path) >= len) {
> > > +             err(ctx, "%s: buffer too small!\n",
> > > +                             ndctl_region_get_devname(region));
> > > +             return -ENXIO;
> > > +     }
> > > +
> > > +     sprintf(buf, "%#lx\n", align);
> > > +     rc = sysfs_write_attr(ctx, path, buf);
> > > +     if (rc < 0)
> > > +             return rc;
> > > +
> > > +     region->align = align;
> > > +     return 0;
> > > +}
> > > +
> >
> > Missing doctext.  Specifically, there should be a big, fat warning
> > against changing the region alignment.
>
> I don't mind adding one, but is this the right place to document an
> API warning? If the audience is future ndctl developers that should be
> warned to keep the status quo of not plumbing this capability into
> "create-namespace" that's one message. If it's to stop other libndctl
> application developers, they'll likely never see this source file.
>
> As it stands there is

Whoops, meant to delete this before sending...
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
