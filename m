Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC06F13EE76
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jan 2020 19:10:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F20F21007B8C0;
	Thu, 16 Jan 2020 10:13:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D5918100866F8
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jan 2020 10:13:16 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id z9so18095454oth.5
        for <linux-nvdimm@lists.01.org>; Thu, 16 Jan 2020 10:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FzuZRenN/3UczXLj3+thO7tKTqsTx9weWp2ttaG3+Ko=;
        b=zawuOQt5P47InN/xf28+hOOPRs0JqfEPg7d21bnyv89wscVYKmezFAfp43eeV4aj1z
         amFHw66rURc66/hjqx+kl6xxu+bxKSxkeEHWHRlL7UAodZS4USBNj/I1Y1mC8w76qAPe
         oJPFMagtBnvN/9TXG8ZOcyPhNz9NfaMSlmontOpFUyjwa9D5ipU4d2BAQTFZtbYH0LO8
         AsAKOyhzVopHd0EMrUJCO/LYIHUuDEZldvlymyKTVB297Erz7EZ9RyUbVBQeAe7/Ja4V
         HC9yWT8qYYbgQJarOSQ/z9QpA6XabIQSANO7+YXGXik4Wuxi4b0InRmGg+tFAxyTAk/5
         dK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FzuZRenN/3UczXLj3+thO7tKTqsTx9weWp2ttaG3+Ko=;
        b=ofER4TU9bXZJB7niIxBBRDt9Snd5BNh3PHFaksPwo+L8kznZVIYVidHEjknw03DH+z
         g3FGtaNVguFgQg/VVbx5dWRK9ILXyCqmvPVdXJULsZ+uecidBh05bH51pjXad0Fghc0s
         hazcoFnLadNGafjJ2drLnXi4009wtQc2rLRKZAhlWb+0Dwps6pnmIDCsHwJykmz+8wUG
         tz2RcE2uNF+AA0T6K4egReH1Ga4hDnO6Qggp9UK/6dgs/7MOzyHmzyO1xkaehyNSZmmu
         Ui4gK0jCa+sqT7JgjisK+I+31lzuE66/AOO3fL4ZTFfciLyAaXRQMYnCS8d59ovtNVhd
         krog==
X-Gm-Message-State: APjAAAWPrKJO3KHEJtfim4/tY+wh0PCrB1htFVWkfMawlmYJlBAhKtFp
	xLlFhJlcwOO4pfVd8f7I5mh6qyjq5XW5rYcayxdYSw==
X-Google-Smtp-Source: APXvYqxAe2+rFr7S0FrSp08rIPwAe1Wau7z51hUUxL0cS3xj2Ecu8Rh56J0DxcLVUk1gryZFW39U+zJXoh6ArDNKXCE=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr3043119oto.207.1579198197588;
 Thu, 16 Jan 2020 10:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20200107180101.GC15920@redhat.com> <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com> <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200109112447.GG27035@quack2.suse.cz> <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com> <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com> <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
 <20200115195617.GA4133@redhat.com> <CAPcyv4iEoN9SnBveG7-Mhvd+wQApi1XKVnuYpyYxDybrFv_YYw@mail.gmail.com>
 <x49wo9smnqc.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49wo9smnqc.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 16 Jan 2020 10:09:46 -0800
Message-ID: <CAPcyv4hCR9NV+2MF0iAJ5rHS2uiOgTnu=+yQRfpieDJQpQz22w@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: DRGBUUPGBDYQRTVDH4A6AADYKXZ4CYEJ
X-Message-ID-Hash: DRGBUUPGBDYQRTVDH4A6AADYKXZ4CYEJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DRGBUUPGBDYQRTVDH4A6AADYKXZ4CYEJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 15, 2020 at 1:08 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Hi, Dan,
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > I'm going to take a look at how hard it would be to develop a kpartx
> > fallback in udev. If that can live across the driver transition then
> > maybe this can be a non-event for end users that already have that
> > udev update deployed.
>
> I just wanted to remind you that label-less dimms still exist, and are
> still being shipped.  For those devices, the only way to subdivide the
> storage is via partitioning.

True, but if kpartx + udev can make this transparent then I don't
think users lose any functionality. They just gain a device-mapper
dependency.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
