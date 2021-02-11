Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 687CA318461
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 05:41:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 74290100EAB43;
	Wed, 10 Feb 2021 20:41:08 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 96BE8100F227A
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 20:41:05 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p20so7988855ejb.6
        for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 20:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sl6/My6OzOs0T7wZB4oePD5pENhmSvczhT0K8Arc7LI=;
        b=WkyTT/tlVuOu/QtJMR4TMPtKI3ZroEdf6vo0pV6EA6pmvld9AUZh5AcBIdoQsmyy5W
         ujhDIglIq4no4S4FnPjAJEON+41CXF/kZhVZc/Of6nBcJmH2ckxq7jFNww9nR/DwT+h/
         8UqUiI1xPm3fisBJZevopAV8RlTeHFLm996qBPYad35tPwuvIkQ2wNljHBO7QuzsU8pl
         m6UjMx88Bp2ax8h59hFBDU+mEcT6OxV4L26reH2yIq5jyt3ZKaGUX00yc6uufxWXKc/K
         6TpW44YRo7+SiphYrSoLs6Eu0cjTNKyi8E8jF9IRE0pU/01y+thIBuSGcpnf168C/Bou
         mgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sl6/My6OzOs0T7wZB4oePD5pENhmSvczhT0K8Arc7LI=;
        b=L/YY8YirOxW7qvgFpBysVexYlwTrIjwcDaTuAyQHq25b7ypU5uG2Av1sNnbiWGMSB8
         SJi7/dSc3KLxWn6Y5oJAjFHQ94rZ749lOxT5YchH5pAUkBwVxYwhRRNVL16bnwCT30Jk
         JdasDTh3ZAtrfi2KvLzLoO0opytlwOiz3rt/ShYKL/zpEUWxrb8C4mIeFgtEWhQKBjTl
         M0clNlGmp5d8PG8OLogLJ8KhP8O+hHheFlR/RuFVqPz/jNXygfpUdM5/g8ixJl0jiky+
         F25FPczILZbzjrdLzmuOEqYTTYb15Z9qZRckWwuNbIopAiRl8aC/1SoxskTrk7vsLFE4
         k6IA==
X-Gm-Message-State: AOAM533sVB840Fri1dC8FuUJAm12DESx2vHsRQ3nRWLBgUpv7N86Dhbx
	6ruFnafklZTVVZp3q23aqXNv96/QjqicbNbZLpUkPg==
X-Google-Smtp-Source: ABdhPJyqM5HE0PbHSNMhdSZjzjNWswbaPuS/dDwtU5r1wQLbe3Pkm5vgDMrXrmlgqG9PntEEBlBF3kFxRImOkT4QFcE=
X-Received: by 2002:a17:906:78a:: with SMTP id l10mr6139548ejc.264.1613018462922;
 Wed, 10 Feb 2021 20:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-5-ben.widawsky@intel.com> <20210210184540.00007536@Huawei.com>
In-Reply-To: <20210210184540.00007536@Huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 10 Feb 2021 20:40:52 -0800
Message-ID: <CAPcyv4hRUB3jxdCV06y0kYMbKbGroEW6F9yOQ4KB_z6YgWBZ4Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] cxl/mem: Add basic IOCTL interface
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID-Hash: KWRUE427PPNECM5TEAWB33ZG75YJH3OZ
X-Message-ID-Hash: KWRUE427PPNECM5TEAWB33ZG75YJH3OZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, "Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, David Rientjes" <rientjes@google.com>, "Jon Masters <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap" <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, kernel test robot <lkp@intel.com>, Dan Williams <dan.j.willams@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KWRUE427PPNECM5TEAWB33ZG75YJH3OZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 10, 2021 at 10:47 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
[..]
> > +#define CXL_CMDS                                                          \
> > +     ___C(INVALID, "Invalid Command"),                                 \
> > +     ___C(IDENTIFY, "Identify Command"),                               \
> > +     ___C(MAX, "Last command")
> > +
> > +#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> > +enum { CXL_CMDS };
> > +
> > +#undef ___C
> > +#define ___C(a, b) { b }
> > +static const struct {
> > +     const char *name;
> > +} cxl_command_names[] = { CXL_CMDS };
> > +#undef ___C
>
> Unless there are going to be a lot of these, I'd just write them out long hand
> as much more readable than the macro magic.

This macro magic isn't new to Linux it was introduced with ftrace:

See "cpp tricks and treats": https://lwn.net/Articles/383362/

>
> enum {
>         CXL_MEM_COMMAND_ID_INVALID,
>         CXL_MEM_COMMAND_ID_IDENTIFY,
>         CXL_MEM_COMMAND_ID_MAX
> };
>
> static const struct {
>         const char *name;
> } cxl_command_names[] = {
>         [CXL_MEM_COMMAND_ID_INVALID] = { "Invalid Command" },
>         [CXL_MEM_COMMAND_ID_IDENTIFY] = { "Identify Comamnd" },
>         /* I hope you never need the Last command to exist in here as that sounds like a bug */
> };
>
> That's assuming I actually figured the macro fun out correctly.
> To my mind it's worth doing this stuff for 'lots' no so much for 3.

The list will continue to expand, and it eliminates the "did you
remember to update cxl_command_names" review burden permanently.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
