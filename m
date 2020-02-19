Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62946164E0B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Feb 2020 19:53:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65EE110FC3411;
	Wed, 19 Feb 2020 10:54:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4854910FC33FB
	for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 10:54:45 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id r16so1194391otd.2
        for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 10:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMAEOoQDEud1/N+mVX9JKr43sDKXhH7PI9SP85PXHYI=;
        b=CraKv/8pddJ7qXlH5G5V2FWE5i0YeSaS0PKgQminGbqUc6Ib68a0IVwVvHQwp9pA59
         99fNuWCFYOmzO+jsivbwg8dfHKhp/Mgmps8iu9qoxjabEUZYNJwccUXMCUEEsMYvhVRH
         wA0qDTA+xgcZk/WEBU9cG9PajwyCz7N/AGg/+cUnUbSQpUU2Y52ArWQ1Bpap2ze17+u6
         7ozFEJ0wJ2wAmqqIU0y9KozVMjB2jud3PfEo8bvoNQv0XBc1PaX/SjnCu6bgmDR9NggI
         taDTY9Av4jrfgDcRuc/wuAddbCjmyYi9D2H8HKxc/XYD7mB7elCr8zhCTfuTEOUlpTDE
         krRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMAEOoQDEud1/N+mVX9JKr43sDKXhH7PI9SP85PXHYI=;
        b=YJ6yjeBRwmQNfahT9Z6I5sdic9Aaq3WCwVqy/ao13fLZvIk0QiOjMwx13dgPWrg9wO
         4PXJfF9EYkI0YtUyuZRom4OUP2T1EVRWpPzo6dWviB8OioZvuPC6tywSUHHOg6+uo9Ef
         CTJL4ccZ04yL0Far6ykn2rK8RxMNMddF9QgZr61QlsXZ9VSKe5gICxikMdRNIaUYoGcd
         GY5HM60zWPFsLxJxyWXsV6p+ORjAR8PEYuCAX/SIANl2nktWjnoVpEDso9GjgxexbtK4
         2b/UbdjxdNbfoijBoau3+7AMulPyHJDlyRGV1IFgRnkG1J8aecSqv02+9VX8XWrOv63s
         kNRg==
X-Gm-Message-State: APjAAAUg32/g4omNI11chbP/Hu9UmU/rfL/O/WTj2kTAeRMz+aLzABEi
	EE7vyoEwtsfms6yBNh2WKUMrE4U4h+dED3JRFVNYqg==
X-Google-Smtp-Source: APXvYqzCqiCF4XcVlTI7woPyQ1NtLEUAFdFJGa0mplyhzzAZ5+6rBqZBOOX458VBxlCvEi4KwcVh91cqjiXzeo7bo8E=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr19713783otm.247.1582138431820;
 Wed, 19 Feb 2020 10:53:51 -0800 (PST)
MIME-Version: 1.0
References: <157481532698.2805671.8095763752180655226.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49sgj6law0.fsf@segfault.boston.devel.redhat.com> <CAPcyv4ibE3ssieq=A5diqwRyiT6e3X=kcpQ3aA0vYneBpuSCAA@mail.gmail.com>
 <x49k14ila4r.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49k14ila4r.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 19 Feb 2020 10:53:41 -0800
Message-ID: <CAPcyv4hHU+RC6TZW94UrjFJZ1fsOU8Nug0GP+Mb5mBGW8qk+UQ@mail.gmail.com>
Subject: Re: [ndctl PATCH] ndctl/list: Drop named list objects from verbose listing
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: OMR5Z6VXQWKVHIXFD4A7HRQCIFAGJMOG
X-Message-ID-Hash: OMR5Z6VXQWKVHIXFD4A7HRQCIFAGJMOG
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OMR5Z6VXQWKVHIXFD4A7HRQCIFAGJMOG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 19, 2020 at 10:12 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Wed, Feb 19, 2020 at 9:56 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >>
> >> Dan Williams <dan.j.williams@intel.com> writes:
> >>
> >> > The only expected difference between "ndctl list -R" and "ndctl list
> >> > -Rv" is some additional output fields. Instead it currently results in
> >> > the region array being contained in a named "regions" list object.
> >> >
> >> > # ndctl list -R -r 0
> >> > [
> >> >   {
> >> >     "dev":"region0",
> >> >     "size":4294967296,
> >> >     "available_size":0,
> >> >     "max_available_extent":0,
> >> >     "type":"pmem",
> >> >     "persistence_domain":"unknown"
> >> >   }
> >> > ]
> >> >
> >> > # ndctl list -Rv -r 0
> >> > {
> >> >   "regions":[
> >> >     {
> >> >       "dev":"region0",
> >> >       "size":4294967296,
> >> >       "available_size":0,
> >> >       "max_available_extent":0,
> >> >       "type":"pmem",
> >> >       "numa_node":0,
> >> >       "target_node":2,
> >> >       "persistence_domain":"unknown",
> >> >       "namespaces":[
> >> >         {
> >> >           "dev":"namespace0.0",
> >> >           "mode":"fsdax",
> >> >           "map":"mem",
> >> >           "size":4294967296,
> >> >           "sector_size":512,
> >> >           "blockdev":"pmem0",
> >> >           "numa_node":0,
> >> >           "target_node":2
> >> >         }
> >> >       ]
> >> >     }
> >> >   ]
> >> > }
> >> >
> >> > Drop the named list, by not including namespaces in the listing. Extra
> >> > objects only appear at the -vv level. "ndctl list -v" and "ndctl list
> >> > -Nv" are synonyms and behave as expected.
> >> >
> >> > # ndctl list -Rv -r 0
> >> > [
> >> >   {
> >> >     "dev":"region0",
> >> >     "size":4294967296,
> >> >     "available_size":0,
> >> >     "max_available_extent":0,
> >> >     "type":"pmem",
> >> >     "numa_node":0,
> >> >     "target_node":2,
> >> >     "persistence_domain":"unknown"
> >> >   }
> >> > ]
> >> >
> >>
> >> Will this break existing code that parses the javascript output?
> >
> > Always a potential for that. That said, I'd rather attempt to make it
> > symmetric and replace it if someone screams, rather than let this
> > quirk persist because it makes it impossible to ingest region data
> > with the same script across -R and -Rv.
>
> Yeah, I see where you're coming from.  However, script authors will
> still have to deal with older versions of ndctl in the wild (for many
> years).  If the decision was up to me, I'd live with the wart in favor
> of not breaking scripts when ndctl gets updated.  Users hate that.

Let's do a compromise, because users also hate nonsensical legacy that
they can't avoid. How about an environment variable,
"NDCTL_LIST_LINT", that users can set to opt into the latest /
cleanest output format with the understanding that the clean up may
regress scripts that were dependent on the old bugs.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
