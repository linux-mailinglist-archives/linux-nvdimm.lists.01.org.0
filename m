Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 305C02650CE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 10 Sep 2020 22:29:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F3B5714263EA1;
	Thu, 10 Sep 2020 13:29:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=jpittman@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6340A13FCC906
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1599769758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IX9w0ZSjp7THQg9dmlFf36s3FmxJM6HIjwaAJlUDQm4=;
	b=JtxFbB/ns1X4M98Jzdsa3CtIhVB3B1AXscRkM8yZRDsgC2XlivnwiLbo3Q029psLrDZ6aK
	0KqlBnwqjHKFbstQ4oNYo6SIbeOH0ML1uHR7yVSQsMXVOTfdhzki8Ofq/oKrMqASxE4kJo
	dlSJHkU9CQPxXO5o77FVLYcJlOQFAr0=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-rbri9uTbO2-d7Hp5R7g9ug-1; Thu, 10 Sep 2020 16:29:16 -0400
X-MC-Unique: rbri9uTbO2-d7Hp5R7g9ug-1
Received: by mail-ot1-f70.google.com with SMTP id z5so1753986oti.21
        for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 13:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IX9w0ZSjp7THQg9dmlFf36s3FmxJM6HIjwaAJlUDQm4=;
        b=IZb7bIJ7gr4olWTaT1NZKBNcmIq3YTGpSIL7tz1Y45XQReRu2V/ylCgsvJO3Ie4A51
         IesPLmLASOijXg8fXQUyZzcSAkCHNeDx4WzNLOqJ+WmsnplhwziBNi2zI4ybEyPICWeX
         /suSGFuuIaDCZ52NIhhsUsmkxp8lZbHvM5JhBeFBMMmO2oHiIlObYhNUY+1aAjHjKqaJ
         RU/vg+tvr9rjBunCUsNeShkZa2bF6PolcFGjmb/2rj2A9k6DRDWNCD77TuCDP8oTJx3Q
         nirAXuwHepIaAXTk0vufcP0C9I1gg6gkwpMQ+KyM0xcjgcVRv/yA+sh5nqpwCrPmjdXD
         fq4A==
X-Gm-Message-State: AOAM531mwyq+/+5mqKhc5kAL437Uyc3mjxOzWC64sRIijHoupW9p1znV
	S1FiCcnYfBm7JfQa/fDV2zQ5xgkoo0+neo8HoXK4a3YLIzZ0qwj6a5TU19cVsrBx9eF/+4/wbbl
	uXrwQ1e7v+EmnTEJ+BmcnhoilCJD6ihzCECOC
X-Received: by 2002:aca:f0d:: with SMTP id 13mr1138358oip.124.1599769755489;
        Thu, 10 Sep 2020 13:29:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjagZZP1DlG8twkBZt8brPitsRQEPgllvGSumjuHvcGgaTG91J1VqlKvZW8YrM3QuHJBH7viGKbpl/JTn/L68=
X-Received: by 2002:aca:f0d:: with SMTP id 13mr1138331oip.124.1599769754904;
 Thu, 10 Sep 2020 13:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200903115549.17845-1-colyli@suse.de> <20200903160608.GU878166@iweiny-DESK2.sc.intel.com>
 <c202e410-99af-3f15-0f76-def5fba7a83a@suse.de>
In-Reply-To: <c202e410-99af-3f15-0f76-def5fba7a83a@suse.de>
From: John Pittman <jpittman@redhat.com>
Date: Thu, 10 Sep 2020 16:29:04 -0400
Message-ID: <CA+RJvhxBHriCuJhm-D8NvJRe3h2MLM+ZMFgjeJjrRPerMRLvdg@mail.gmail.com>
Subject: Re: [PATCH] dax: fix for do not print error message for
 non-persistent memory block device
To: Coly Li <colyli@suse.de>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpittman@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Message-ID-Hash: SMQW2LY3QHPXOAW76RKNSCGG3QJFO7HT
X-Message-ID-Hash: SMQW2LY3QHPXOAW76RKNSCGG3QJFO7HT
X-MailFrom: jpittman@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, dm-devel@redhat.com, Adrian Huang <ahuang12@lenovo.com>, Jan Kara <jack@suse.com>, Mike Snitzer <snitzer@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SMQW2LY3QHPXOAW76RKNSCGG3QJFO7HT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

But it should be moved prior to the two bdev_dax_pgoff() checks right?
 Else a misaligned partition on a dax unsupported block device can
print the below messages.

kernel: sda1: error: unaligned partition for dax
kernel: sda2: error: unaligned partition for dax
kernel: sda3: error: unaligned partition for dax

Reviewed-by: John Pittman <jpittman@redhat.com>

On Thu, Sep 3, 2020 at 12:12 PM Coly Li <colyli@suse.de> wrote:
>
> On 2020/9/4 00:06, Ira Weiny wrote:
> > On Thu, Sep 03, 2020 at 07:55:49PM +0800, Coly Li wrote:
> >> When calling __generic_fsdax_supported(), a dax-unsupported device may
> >> not have dax_dev as NULL, e.g. the dax related code block is not enabled
> >> by Kconfig.
> >>
> >> Therefore in __generic_fsdax_supported(), to check whether a device
> >> supports DAX or not, the following order should be performed,
> >> - If dax_dev pointer is NULL, it means the device driver explicitly
> >>   announce it doesn't support DAX. Then it is OK to directly return
> >>   false from __generic_fsdax_supported().
> >> - If dax_dev pointer is NOT NULL, it might be because the driver doesn't
> >>   support DAX and not explicitly initialize related data structure. Then
> >>   bdev_dax_supported() should be called for further check.
> >>
> >> IMHO if device driver desn't explicitly set its dax_dev pointer to NULL,
> >> this is not a bug. Calling bdev_dax_supported() makes sure they can be
> >> recognized as dax-unsupported eventually.
> >>
> >> This patch does the following change for the above purpose,
> >>     -       if (!dax_dev && !bdev_dax_supported(bdev, blocksize)) {
> >>     +       if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {
> >>
> >>
> >> Fixes: c2affe920b0e ("dax: do not print error message for non-persistent memory block device")
> >> Signed-off-by: Coly Li <colyli@suse.de>
> >
> > I hate to do this because I realize this is a bug which people really need
> > fixed.
> >
> > However, shouldn't we also check (!dax_dev || !bdev_dax_supported()) as the
> > _first_ check in __generic_fsdax_supported()?
> >
> > It seems like the other pr_info's could also be called when DAX is not
> > supported and we probably don't want them to be?
> >
> > Perhaps that should be a follow on patch though.  So...
>
> I am not author of c2affe920b0e, but I guess it was because
> bdev_dax_supported() needed blocksize, so blocksize should pass previous
> checks firstly to make sure bdev_dax_supported() has a correct blocksize
> to check.
>
> >
> > As a direct fix to c2affe920b0e
> >
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>
> Thanks.
>
> Coly Li
>
>
> >
> >> Cc: Adrian Huang <ahuang12@lenovo.com>
> >> Cc: Ira Weiny <ira.weiny@intel.com>
> >> Cc: Jan Kara <jack@suse.com>
> >> Cc: Mike Snitzer <snitzer@redhat.com>
> >> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> >> Cc: Vishal Verma <vishal.l.verma@intel.com>
> >> ---
> >>  drivers/dax/super.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> >> index 32642634c1bb..e5767c83ea23 100644
> >> --- a/drivers/dax/super.c
> >> +++ b/drivers/dax/super.c
> >> @@ -100,7 +100,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
> >>              return false;
> >>      }
> >>
> >> -    if (!dax_dev && !bdev_dax_supported(bdev, blocksize)) {
> >> +    if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {
> >>              pr_debug("%s: error: dax unsupported by block device\n",
> >>                              bdevname(bdev, buf));
> >>              return false;
> >> --
> >> 2.26.2
> >>
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
