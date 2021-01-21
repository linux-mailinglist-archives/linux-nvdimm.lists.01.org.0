Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBC82FF264
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Jan 2021 18:50:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4C93A100EB820;
	Thu, 21 Jan 2021 09:50:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DECAE100EBB6C
	for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 09:50:16 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ox12so3886696ejb.2
        for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 09:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OqDGr5OXXLDXoZ+kvErdRqn2LWaoGkSZKNVGtOHo0BI=;
        b=eVFeNLK0LrN/WxB0D4SEhXIkmQeMvag+qoGefW6ONj0khNhIHCAYmWw9sI6fc2p/Tf
         iNvWC56d2SekCqH8W6lVW6vuLj7fDrh9atefJI9fHFKN2HbcrU+BybCJPwFsyDFpRFNK
         aCVFjPZzn5Am8jeJnz5DbslQlxvVq2s9ENXpN8U2sPN5shejLfm8wz/+ocREFbtvzFy1
         c+nYHU62Xh+DGpT9kdA3H7YH5d1SS4wIR6W3QDVZ9tK9wT6uvi7iMi4JW1x2KQTscaAC
         6hIH7fPbeJwm/QeZw+nqKA6JnkG1MevMAYjn83JoB8kq1Y5klO9TM5ajhVa7bqHtLcO1
         yNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqDGr5OXXLDXoZ+kvErdRqn2LWaoGkSZKNVGtOHo0BI=;
        b=B9bi1OI5amscrKCdz9FNujLTfsyBNPIg1sUbUWTCr+FGq8/MWzmuFPx2CADkGfyNYY
         S3GLtSBO2U6PxsiRosFl9LtTc+SHmL7QmwXTjlis31HfPzBedrd943aOIemhbU5pFdpk
         eX2U6LxJnQQu/izOMqGQxsUCOrodZi7Ieo8voTZav/PnSjiKOHo0xupxfa97oWmKccBh
         46GZbAyOC6GlG4munA6sAiMZwWmDWUJU+RszqwrW/SkTUyGsvR82GP33e1HiVP+SaAkg
         xilqSPKlv0p1A8fVrelA72yWszXa1L2I6/RN7N+5fUAhBC5QxnY9KibFsehndy54NaqN
         kdMw==
X-Gm-Message-State: AOAM5310JUninuKJJwvCejVoFJNtOK4CuKCZdNmArxCAz9ZjomD1r1yh
	eVsFLHQJ4NRaxpD8qHW6LZf/HPiFhQ9RoaS4otIqZA==
X-Google-Smtp-Source: ABdhPJxojGLRdzZFKIOXzAri6ROiq62XZBU5dIKiIeyLRrawBjmoEiHQe3KMqw+7otHRhV8gUwsjuOh2i5mxmcctbnU=
X-Received: by 2002:a17:906:ce49:: with SMTP id se9mr413181ejb.341.1611251415063;
 Thu, 21 Jan 2021 09:50:15 -0800 (PST)
MIME-Version: 1.0
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YAk3lVeFqnv5vzA2@kroah.com>
In-Reply-To: <YAk3lVeFqnv5vzA2@kroah.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 21 Jan 2021 09:50:09 -0800
Message-ID: <CAPcyv4hEpdh_aGcs_73w5KmYWdvR29KB2M2-NNXsaXwxf35Hwg@mail.gmail.com>
Subject: Re: [PATCH 1/3] cdev: Finish the cdev api with queued mode support
To: Greg KH <gregkh@linuxfoundation.org>
Message-ID-Hash: HWZKEXTYSKEVNFB2PCQDHKRID6UAWFHD
X-Message-ID-Hash: HWZKEXTYSKEVNFB2PCQDHKRID6UAWFHD
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Logan Gunthorpe <logang@deltatee.com>, Hans Verkuil <hans.verkuil@cisco.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HWZKEXTYSKEVNFB2PCQDHKRID6UAWFHD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 21, 2021 at 12:13 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 20, 2021 at 11:38:57AM -0800, Dan Williams wrote:
> > -void cdev_del(struct cdev *p)
> > +void cdev_del(struct cdev *cdev)
> >  {
> > -     cdev_unmap(p->dev, p->count);
> > -     kobject_put(&p->kobj);
> > +     cdev_unmap(cdev->dev, cdev->count);
> > +     kobject_put(&cdev->kobj);
>
> After Christoph's patch series, the kobject in struct cdev does nothing,
> so I will be removing it.  So I don't think this patch set is going to
> do what you want :(

The proposal in this series has nothing to do with kobject lifetime.
Please take another look at the file_operations shutdown coordination
problem and the fact that it's not just cdev that has a use case to
manage file_operations this way. I believe Christoph's only objection,
correct me if I'm wrong, is that this proposal invents a new third way
to do this relative to procfs and debugfs. Perhaps there's a way to
generalize this for all three, and I'm going to put some thought
there, but at this point I think I'm failing to describe the problem
clearly.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
