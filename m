Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7F2105F6D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 22 Nov 2019 06:17:46 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 167D5100DC2D4;
	Thu, 21 Nov 2019 21:18:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 40D27100DC2D3
	for <linux-nvdimm@lists.01.org>; Thu, 21 Nov 2019 21:18:11 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id n16so5474911oig.2
        for <linux-nvdimm@lists.01.org>; Thu, 21 Nov 2019 21:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=keeodVCAfBP266uKFs6gORVjfgMY0eZ+dSw8j1koUJM=;
        b=BIOGnljlLRD9J80W8RY8QHF75L0lSFekBNWZN8hg6Rk7ljv9ZJisk86mocS5aiKe4M
         BRZGCQpb/a/2HBXTpqGHIr6gl5Yi174AJyQgmbRrjnEf1eD4TmgrawnUt12HU3lJfSnM
         jsv9KaL9by0JkoV7d5CABQDDWhnr3Yv4lsOpRt/wfUrMC3daEO/UP2vIWl/f6F9SjRg6
         vV8w8h+6ne19HZGi9F8YO59Tk42WwohDyYShHdM82hUpHeHhD6F2MdT47XhV3HW4jl3e
         zBa9aicw9PLNxx2NdjnxS7BRDDf9mRGgi26FURoNfyPLFC4eL9NDJ4NpFIDQcLSbfchm
         nJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keeodVCAfBP266uKFs6gORVjfgMY0eZ+dSw8j1koUJM=;
        b=kPWjjU30qjLh3GenWPYm8nzBTxIU4+omuZqQ9E9q5f1NIRRiBe35dkvKoQXli57jEE
         dZB252TrYWdM4DOxZazf8hAXU4tVuKPA12yBazs0bnAlxS5DftFURDZ2ne3N8Adb8/ZM
         jjxQhp4g0dArb4sbr24OaMytFDoIq8XjMbA2GYZACq4d56ZxaH4jzssfNv77ysEtfo9+
         v6DG3SPdhmDC6zFdXiXNqXwGGeQnbS2bx+/AP8YQ6BJBsa+aCFEhjG84CWO60GMdgaCW
         I/0zFCEGyDZLHXL+8R3BJKWZYVbUTI2lhzy/xPRWlg8xTxVNnbtlkJwUf8sttTS9Ty9c
         prgg==
X-Gm-Message-State: APjAAAW4kJ6fsuCDLer2MFHj173JXnHSc/srp3bmwecA2IiVF7bF7xnO
	EBgDxTrRaq9/J2vN5gVBkrtt2X5QsYexuEReIJDQ1w==
X-Google-Smtp-Source: APXvYqyeVnRwhSQg9omPamcyvVHAk303c8e0hbTEeNPBnyGzGAg4XQG9mA2ytTDgrGbVNkDXXZO49Ddks50Gg2ZmNG8=
X-Received: by 2002:aca:ead7:: with SMTP id i206mr11122498oih.0.1574399860567;
 Thu, 21 Nov 2019 21:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
 <CAPcyv4hJ6gHX=NYz-CoXFSrN93HUT+Xh+DP+QAjzqgGmmghmGA@mail.gmail.com>
 <1617854972.35808055.1574323227395.JavaMail.zimbra@redhat.com>
 <CAPcyv4haUOM92uzCBfVyrANxnNHKucivq053MFBmGOL3vqMgwQ@mail.gmail.com> <560894997.35969622.1574397521533.JavaMail.zimbra@redhat.com>
In-Reply-To: <560894997.35969622.1574397521533.JavaMail.zimbra@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 21 Nov 2019 21:17:29 -0800
Message-ID: <CAPcyv4gsQXY5C5URF2vrTaD-0Q_CJ+ib3GVb1VFZAO+1Gdau2w@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID-Hash: GAHQWH6X7ETBURCL7MAMI4QS4D7RY5EO
X-Message-ID-Hash: GAHQWH6X7ETBURCL7MAMI4QS4D7RY5EO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GAHQWH6X7ETBURCL7MAMI4QS4D7RY5EO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 21, 2019 at 8:38 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>
> > > > > >
> > > > > > >  Remove logic to create child bio in the async flush function which
> > > > > > >  causes child bio to get executed after parent bio
> > > > > > >  'pmem_make_request'
> > > > > > >  completes. This resulted in wrong ordering of REQ_PREFLUSH with
> > > > > > >  the
> > > > > > >  data write request.
> > > > > > >
> > > > > > >  Instead we are performing flush from the parent bio to maintain
> > > > > > >  the
> > > > > > >  correct order. Also, returning from function 'pmem_make_request'
> > > > > > >  if
> > > > > > >  REQ_PREFLUSH returns an error.
> > > > > > >
> > > > > > > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > > > > > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > > > >
> > > > > > There's a slight change in behavior for the error path in the
> > > > > > virtio_pmem driver.  Previously, all errors from virtio_pmem_flush
> > > > > > were
> > > > > > converted to -EIO.  Now, they are reported as-is.  I think this is
> > > > > > actually an improvement.
> > > > > >
> > > > > > I'll also note that the current behavior can result in data
> > > > > > corruption,
> > > > > > so this should be tagged for stable.
> > > > >
> > > > > I added that and was about to push this out, but what about the fact
> > > > > that now the guest will synchronously wait for flushing to occur. The
> > > > > goal of the child bio was to allow that to be an I/O wait with
> > > > > overlapping I/O, or at least not blocking the submission thread. Does
> > > > > the block layer synchronously wait for PREFLUSH requests? If not I
> > > > > think a synchronous wait is going to be a significant performance
> > > > > regression. Are there any numbers to accompany this change?
> > > >
> > > > Why not just swap the parent child relationship in the PREFLUSH case?
> > >
> > > I we are already inside parent bio "make_request" function and we create
> > > child
> > > bio. How we exactly will swap the parent/child relationship for PREFLUSH
> > > case?
> > >
> > > Child bio is queued after parent bio completes.
> >
> > Sorry, I didn't quite mean with bio_split, but issuing another request
> > in front of the real bio. See md_flush_request() for inspiration.
>
> o.k. Thank you. Will try to post patch today to be considered for 5.4.
>

I think it is too late for v5.4-final, but we can get it in the
-stable queue. Let's take the time to do it right and get some testing
on it.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
