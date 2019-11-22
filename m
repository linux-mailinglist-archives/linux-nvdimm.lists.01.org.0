Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1E7107583
	for <lists+linux-nvdimm@lfdr.de>; Fri, 22 Nov 2019 17:13:21 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CE13C10113301;
	Fri, 22 Nov 2019 08:13:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 10D4D10113300
	for <linux-nvdimm@lists.01.org>; Fri, 22 Nov 2019 08:13:43 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id w11so6659634ote.1
        for <linux-nvdimm@lists.01.org>; Fri, 22 Nov 2019 08:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGAkIY/malVfTkqNJbPQAJQlDy7Ez63qwq+JecsGmso=;
        b=u8FT0UY5EsTVWPrYHEXwEq/awgVnTMghppZ1AeqecEiteiyKKqKKc5MoolkdXaws2t
         SmJr8j/kAOZH32nqX4kc97Hc+b2Xi0RZ+UwTC3UmkWsDiNSRL0IUXu1iPz472CIrBxyA
         2asrCnwmK9ReGLWKVOTiYpdemWfkj60RYDmHcr5xwGgq//CV13eZreLbWWIn7aFiFVsp
         AdFUs+Gcc30RSVGqYr8nEmr1skeEL7/65+4VpXgVfjWZDfA6hZXhhcWBXvn8yYPXs7V2
         hSuoxj+uV9FUfKLmbTfISVzWcEclMbxPDvr3QJRJTVjI6insjBR9IqjtpDDorDVF/j0H
         /AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGAkIY/malVfTkqNJbPQAJQlDy7Ez63qwq+JecsGmso=;
        b=nxfzQj6Cot4hm25wF+euMgBs4Obaykoitg8Pr1l0Y2J2xZGeQC2uFcvMcsbi1Ibg7l
         7JgjA2DfnXfIBtTITA+PyTh3VzkKoTCaIKzta+sINZe4ryRnNHz17XLWAcBRNg+RBDNw
         wy+LRiDcmbUjbjP1A0cwsRc/KbD7p2OCTjwPbpkj0OdhDb/PC+01aQrpl7EP7lklJBAe
         ryiyGalvLIfuoYDMme0SI4Aqes8r1GSnIERu8Ag2zSJTVArHiBuAyeNPDRtfyzUG2zgf
         BA1XtRIMXkQhKcK5Ib9zzVvGzTiGGoD5s2mmy6GqaeuxxQvfohkWWxS0s48bQY6wL1S/
         nCJQ==
X-Gm-Message-State: APjAAAUUtYlGguY2nWzz3t6Kg7XZiAyWL0iffFKG3it+btK/1RPoDUko
	0dD28XPlFHe9gPQGyVUmc//Lxx23Z5s5adhTdp9rLQ==
X-Google-Smtp-Source: APXvYqxvAz/mVNKR9y0aIXP20GgQ5CMbb7RZ/EpsgTrCK2HXJUipf6SbaAdIrz0b9RTHNlsVyHExbcwWaUgQ7UotvQM=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr11028481otb.126.1574439196834;
 Fri, 22 Nov 2019 08:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com> <x49h82vevw1.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49h82vevw1.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 22 Nov 2019 08:13:05 -0800
Message-ID: <CAPcyv4idC=LgkwP+A1GKJ1CWkzUZ_RVBDCVfA3yAL9TNw1zZmw@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: O7ROCN3J6OXSUEO4BGWEBRFC4PJPTCLP
X-Message-ID-Hash: O7ROCN3J6OXSUEO4BGWEBRFC4PJPTCLP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O7ROCN3J6OXSUEO4BGWEBRFC4PJPTCLP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 22, 2019 at 8:09 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Wed, Nov 20, 2019 at 9:26 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >>
> >> Pankaj Gupta <pagupta@redhat.com> writes:
> >>
> >> >  Remove logic to create child bio in the async flush function which
> >> >  causes child bio to get executed after parent bio 'pmem_make_request'
> >> >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
> >> >  data write request.
> >> >
> >> >  Instead we are performing flush from the parent bio to maintain the
> >> >  correct order. Also, returning from function 'pmem_make_request' if
> >> >  REQ_PREFLUSH returns an error.
> >> >
> >> > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> >> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> >>
> >> There's a slight change in behavior for the error path in the
> >> virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
> >> converted to -EIO.  Now, they are reported as-is.  I think this is
> >> actually an improvement.
> >>
> >> I'll also note that the current behavior can result in data corruption,
> >> so this should be tagged for stable.
> >
> > I added that and was about to push this out, but what about the fact
> > that now the guest will synchronously wait for flushing to occur. The
> > goal of the child bio was to allow that to be an I/O wait with
> > overlapping I/O, or at least not blocking the submission thread. Does
> > the block layer synchronously wait for PREFLUSH requests?
>
> You *have* to wait for the preflush to complete before issuing the data
> write.  See the "Explicit cache flushes" section in
> Documentation/block/writeback_cache_control.rst.

I'm not debating the ordering, or that the current implementation is
obviously broken. I'm questioning whether the bio tagged with PREFLUSH
is a barrier for future I/Os. My reading is that it is only a gate for
past writes, and it can be queued. I.e. along the lines of
md_flush_request().
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
