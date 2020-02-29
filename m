Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AE1174481
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 03:37:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB4061007B1C3;
	Fri, 28 Feb 2020 18:38:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 58EDA1007B1C3
	for <linux-nvdimm@lists.01.org>; Fri, 28 Feb 2020 18:38:15 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id g96so4452045otb.13
        for <linux-nvdimm@lists.01.org>; Fri, 28 Feb 2020 18:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITMvxEpF3U14e+p5rYvz2uAWn2wYdTAj3ePDO83aSxA=;
        b=COXUz8wrKXgMXMUxmrS8VUhJezNMzBmQjpV5dwDh/i+YkUM806HuZekPkwS5o4M7fm
         uvQJqIwlEsKumXOHWa8o+BCjvrMM4LilTFplxGZpw58qfkgfPk3fViwRfo2CBQmnEuO8
         9vQmrx2R8/pLCQ0re6/vCPewSDRITFJEo+aeLzLuH8ZZWHmUvScaB61P75PoDvYOqc7u
         Awx3BYeUSvP/ToW0pBKvwN9C9W7qWKMBwkLQ7bQ+Dw94q8dRRdIFfO47fSm9R5mizW5R
         kKJVU6xpnF/NQ2bPNzS/vCmQAMc7MQpkaQAfPqihJuT1Y9GcudGbDT7gISWdb1i8u+T9
         iygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITMvxEpF3U14e+p5rYvz2uAWn2wYdTAj3ePDO83aSxA=;
        b=HFLTQ6q3YZIiMdtomKg3Vp3XxNzBvSJx6P9OonCIW1RiM5HuFVbxy9tDYhresqPGCh
         Z1zazvrUvFqNp7sidNedeH6hcuUHbRpbY8xWw8D6RH7v6UmiWndgwW5hP81g0Y7wqg+j
         lknr+UNqX55NMcyrAnpyriEdBYcpfkQp43yHB01zJw3/DPrWBETllubXP9KNpOvJS/8h
         Ar3YoShMg11KqlasZYvufpWMjxI7bzytTHY1X1gAL6V1MCl8sE6QYB0wi59rJpuZggGz
         thUWph3LLueSJw6VUGz14Jv2Ca50XHwJsxw47X2WyI6yCSnFTBwYBPEoC58izkWRpjS1
         24ww==
X-Gm-Message-State: APjAAAX5MLBrA/ucPtuIQ2n334INTljnmJ6AIcvIZsmpLD2Km1HKcVx6
	NH/3eEFlvuP6Do9GuIkn1oHyXAKXg8m9/+Fo83ZdTA==
X-Google-Smtp-Source: APXvYqyB6AhqVgT1u2YbER/cAyCne1ILQtW1fjnZWNmWga05aw8cTU/5CT3D3ukg3CNy+1E3LbRq2ASMNkjj0A4l+jY=
X-Received: by 2002:a9d:5d09:: with SMTP id b9mr5495369oti.207.1582943842190;
 Fri, 28 Feb 2020 18:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20200122155304.120733-1-vaibhav@linux.ibm.com>
 <x49r1yrboh2.fsf@segfault.boston.devel.redhat.com> <CAPcyv4gn1M87AnuzOEorihG1nmCiHDKL0Z4HfLbNbkeOcO3GPw@mail.gmail.com>
In-Reply-To: <CAPcyv4gn1M87AnuzOEorihG1nmCiHDKL0Z4HfLbNbkeOcO3GPw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 28 Feb 2020 18:37:11 -0800
Message-ID: <CAPcyv4hE_FG0YZXJVA1G=CBq8b9e0K54jxk5Sq5UKU-dnWT2Kg@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/bus: return the outvar 'cmd_rc' error code in __nd_ioctl()
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: 5OQVOQNEPFJIQT64MBJ27BNW73LQSIRV
X-Message-ID-Hash: 5OQVOQNEPFJIQT64MBJ27BNW73LQSIRV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5OQVOQNEPFJIQT64MBJ27BNW73LQSIRV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 18, 2020 at 1:03 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Feb 18, 2020 at 1:00 PM Jeff Moyer <jmoyer@redhat.com> wrote:
> >
> > Vaibhav Jain <vaibhav@linux.ibm.com> writes:
> >
> > > Presently the error code returned via out variable 'cmd_rc' from the
> > > nvdimm-bus controller function is ignored when called from
> > > __nd_ioctl() and never communicated back to user-space code that called
> > > an ioctl on dimm/bus.
> > >
> > > This minor patch updates __nd_ioctl() to propagate the value of out
> > > variable 'cmd_rc' back to user-space in case it reports an error.
> > >
> > > Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > > ---
> > >  drivers/nvdimm/bus.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> > > index a8b515968569..5b687a27fdf2 100644
> > > --- a/drivers/nvdimm/bus.c
> > > +++ b/drivers/nvdimm/bus.c
> > > @@ -1153,6 +1153,11 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
> > >       if (rc < 0)
> > >               goto out_unlock;
> > >
> > > +     if (cmd_rc < 0) {
> > > +             rc = cmd_rc;
> > > +             goto out_unlock;
> > > +     }
> > > +
> > >       if (!nvdimm && cmd == ND_CMD_CLEAR_ERROR && cmd_rc >= 0) {
> > >               struct nd_cmd_clear_error *clear_err = buf;
> >
> > Looks good to me.
> >
> > Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
>
> Applied.

Unapplied. This breaks the NVDIMM unit test, and now that I look
closer you are likely overlooking the fact that cmd_rc is a
translation of the firmware status, while the ioctl rc is whether the
command was successfully submitted. If you want the equivalent of
cmd_rc in userspace you need to translate the firmware status. See
ndctl_cmd_submit_xlat() in libndctl as an example of how the
equivalent of cmd_rc is generated from the firmware status.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
