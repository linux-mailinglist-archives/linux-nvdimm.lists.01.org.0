Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA781633C5
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 22:03:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 62B3F10FC3404;
	Tue, 18 Feb 2020 13:04:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B97E210FC33EF
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 13:04:31 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id z2so21580497oih.6
        for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 13:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXoVPk6FZ9mk8ebm0RTbrhUVeu0ldQNyqrF7B4ZlAJA=;
        b=Gb5Z8PlHDjWJMmQNVcBojkdyBKcBiB1NeC31O40/pM1cl9s1q8B+ntc7IhLswUS0Jo
         vYF04tfHWKIhvJwr03VbGY8lJWHQj4gva5st2VuIw6OFpKKX0trwouVM1zqgbFNM4yZa
         Gwce0z7qDnGpCCNQAZTGu7HXG0iSPFIQc7dHW1IrXSH9qFWXDv7RccypWNewbkeDVJUK
         rc8xZ1QGrEOCLriBmAky7ZLnsvbkqAGuVXHt+ehHwrUPneT0VtiF5tgZTQ/tRqRMwl9x
         tEMy8pfgautLuC6+qpeGmin6UphGY/cLFt0whtSZPfZyGxsx9xf0Kkf5HkLU2T+9Z3Ec
         9kgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXoVPk6FZ9mk8ebm0RTbrhUVeu0ldQNyqrF7B4ZlAJA=;
        b=O+VQnb7+rePSQ5CrvbKAReNiiC9otU+9AyGTZrQhXbI63IosGqn85E5USQj6C9F7M9
         pc5ljWvJ0Ucf1gIFpq7Mq3UwBcOXrrkiIawxBrB0QLs8qMimIlulcIHzcg3kXNQLUvYv
         Egm3nu7Iyp+ZgCl2novpKqDapcAzzvVqynybwhh9JjOTUjFmH2sOV6JRm+nrPgSLRfdf
         WBQT7/wLYuNhjYPF1rPfcbD+tHpMXYzhNy2MwR8Fo1m2MXRPSr/HVfyqS0LFLkxD/3AL
         K9vCuM+7bgbkwXgmedLziILRqC87m227jaP7lT5GmFkqx8Qt0KDZ7wwHvIsLmNTcdiRt
         NA5w==
X-Gm-Message-State: APjAAAVY+pwiHdM5W/5upg5GLnOVbMtPT1XnYFm2ICUeLV5f8bcSa18V
	ZtRy8YDuwWOhKkCXxJGaPjkEX6liheJ2bA5kW0fCJg==
X-Google-Smtp-Source: APXvYqwJcarT38gaI5tYPX5esX/lkmHsUI9w2SbFK2zhB8wSEZI/8fsDx34f/gONLYMRT9XzKxZ1sSVhKi4qcNrIkX8=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr2442260oia.73.1582059818155;
 Tue, 18 Feb 2020 13:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20200122155304.120733-1-vaibhav@linux.ibm.com> <x49r1yrboh2.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49r1yrboh2.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 18 Feb 2020 13:03:26 -0800
Message-ID: <CAPcyv4gn1M87AnuzOEorihG1nmCiHDKL0Z4HfLbNbkeOcO3GPw@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/bus: return the outvar 'cmd_rc' error code in __nd_ioctl()
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: QQ7TLG2MEI2MOV3ZH4CF4HML25EEKDA5
X-Message-ID-Hash: QQ7TLG2MEI2MOV3ZH4CF4HML25EEKDA5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QQ7TLG2MEI2MOV3ZH4CF4HML25EEKDA5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 18, 2020 at 1:00 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>
> > Presently the error code returned via out variable 'cmd_rc' from the
> > nvdimm-bus controller function is ignored when called from
> > __nd_ioctl() and never communicated back to user-space code that called
> > an ioctl on dimm/bus.
> >
> > This minor patch updates __nd_ioctl() to propagate the value of out
> > variable 'cmd_rc' back to user-space in case it reports an error.
> >
> > Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > ---
> >  drivers/nvdimm/bus.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> > index a8b515968569..5b687a27fdf2 100644
> > --- a/drivers/nvdimm/bus.c
> > +++ b/drivers/nvdimm/bus.c
> > @@ -1153,6 +1153,11 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
> >       if (rc < 0)
> >               goto out_unlock;
> >
> > +     if (cmd_rc < 0) {
> > +             rc = cmd_rc;
> > +             goto out_unlock;
> > +     }
> > +
> >       if (!nvdimm && cmd == ND_CMD_CLEAR_ERROR && cmd_rc >= 0) {
> >               struct nd_cmd_clear_error *clear_err = buf;
>
> Looks good to me.
>
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

Applied.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
