Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199FE30B055
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 20:28:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CAFB3100F2253;
	Mon,  1 Feb 2021 11:28:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C0EF3100EB35B
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 11:28:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id d2so20259921edz.3
        for <linux-nvdimm@lists.01.org>; Mon, 01 Feb 2021 11:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLqxV+e3ECywMj4yOHP40Y4Hye+dMCfOcqwKr29p2HI=;
        b=gC8WmSv1q6Yk3dQzfAizBHBhsDyBkl3I86OkYsS07KVtHXkQP2m91HlV4JOms2F6MI
         r9/R5IHyw3IG3LwBkBulLu6tGegKM+gQTKDv8Vmk766t1nRsQXHVdNSa7YkDzddPzvXI
         6Epdxf+ldGwIklqkIwPGxFGOOxC4dMDXuPbwFTwGhibJvapGUbTfybyMzHwbmB21AlTh
         DkoDM7dgtGaLpJv0mKiMFgPXpm/l+mPjIGTgsNMnIn9Fn78I145SviGYk+UKp8QIWWkH
         G08Yh7I/K3XuXvvLogy8QbWTCt7GTap+eLFYXx1pGK2DY2XRai3Npq3UAcefJb350qgK
         QqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLqxV+e3ECywMj4yOHP40Y4Hye+dMCfOcqwKr29p2HI=;
        b=An1Mr7Ki6phCE6EwnsvPdkwcMlP3Y9lIITd21RCG3RllFYKaDwwIYgX9F4XaH5u8cn
         3QdqruylFKkbEDMTdbyAHt6+h3+WNhWwoO3z1rkQxluwPxg/Jz1HcudpkAWOa+o2Q4BK
         jumnJ/iNLilmrV6gGnF5U/kpuZ5KIsPPXPhH2UxTeTN0aup21QCqguCJeCnpNTu8iP33
         EetjoDjQpKOGBc9htGfAgagVGArFC0oI8sgjbAzAfB3nBBEVAQ+CLJmOQpen55zbgp15
         a20Gv68tkPM1IekKwocc5Vh8Km8EvcST9VscbDxHD52iJ+gb4dKi8yT8WoA7E3oX06qM
         PjGw==
X-Gm-Message-State: AOAM532m8ex8OPsg4W9ycyFceD3zs1YSumEZwkfPMxyQsDRV2kpTxSyF
	095ZrLD3YOjI7m+Cbj7bjceUeHmqR/lYIK5q6lAiYA==
X-Google-Smtp-Source: ABdhPJzqLgJ2T42h4GAbSJ3xUPExC3VrSce0vPY0QWB7x4LFsv+5sU4KX832Fu9b8o0hyYK3y/2yei12LT0f+nV3KDk=
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr20322754edd.52.1612207684089;
 Mon, 01 Feb 2021 11:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-5-ben.widawsky@intel.com> <20210201175400.GG197521@fedora>
 <20210201191316.e3kkkwqbx5fujp6y@intel.com>
In-Reply-To: <20210201191316.e3kkkwqbx5fujp6y@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 1 Feb 2021 11:28:01 -0800
Message-ID: <CAPcyv4hP6AOV1OQKbohCqczM1RUPQHQ07+7MuNJ1_p6+opLSQQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] cxl/mem: Implement polled mode mailbox
To: Ben Widawsky <ben.widawsky@intel.com>
Message-ID-Hash: J5UZMY443OIOYFVKLLBUEU527YFSXQKG
X-Message-ID-Hash: J5UZMY443OIOYFVKLLBUEU527YFSXQKG
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J5UZMY443OIOYFVKLLBUEU527YFSXQKG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 1, 2021 at 11:13 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-02-01 12:54:00, Konrad Rzeszutek Wilk wrote:
> > > +#define cxl_doorbell_busy(cxlm)                                                \
> > > +   (cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET) &                    \
> > > +    CXLDEV_MB_CTRL_DOORBELL)
> > > +
> > > +#define CXL_MAILBOX_TIMEOUT_US 2000
> >
> > You been using the spec for the values. Is that number also from it ?
> >
>
> Yes it is. I'll add a comment with the spec reference.
>
> > > +
> > > +enum opcode {
> > > +   CXL_MBOX_OP_IDENTIFY            = 0x4000,
> > > +   CXL_MBOX_OP_MAX                 = 0x10000
> > > +};
> > > +
> > > +/**
> > > + * struct mbox_cmd - A command to be submitted to hardware.
> > > + * @opcode: (input) The command set and command submitted to hardware.
> > > + * @payload_in: (input) Pointer to the input payload.
> > > + * @payload_out: (output) Pointer to the output payload. Must be allocated by
> > > + *          the caller.
> > > + * @size_in: (input) Number of bytes to load from @payload.
> > > + * @size_out: (output) Number of bytes loaded into @payload.
> > > + * @return_code: (output) Error code returned from hardware.
> > > + *
> > > + * This is the primary mechanism used to send commands to the hardware.
> > > + * All the fields except @payload_* correspond exactly to the fields described in
> > > + * Command Register section of the CXL 2.0 spec (8.2.8.4.5). @payload_in and
> > > + * @payload_out are written to, and read from the Command Payload Registers
> > > + * defined in (8.2.8.4.8).
> > > + */
> > > +struct mbox_cmd {
> > > +   u16 opcode;
> > > +   void *payload_in;
> > > +   void *payload_out;
> >
> > On a 32-bit OS (not that we use those that more, but lets assume
> > someone really wants to), the void is 4-bytes, while on 64-bit it is
> > 8-bytes.
> >
> > `pahole` is your friend as I think there is a gap between opcode and
> > payload_in in the structure.
> >
> > > +   size_t size_in;
> > > +   size_t size_out;
> >
> > And those can also change depending on 32-bit/64-bit.
> >
> > > +   u16 return_code;
> > > +#define CXL_MBOX_SUCCESS 0
> > > +};
> >
> > Do you want to use __packed to match with the spec?
> >
> > Ah, reading later you don't care about it.
> >
> > In that case may I recommend you move 'return_code' (or perhaps just
> > call it rc?) to be right after opcode? Less of gaps in that structure.
> >
>
> I guess I hadn't realized we're supposed to try to fully pack structs by
> default.

This is just the internal parsed context of a command, I can't imagine
packing is relevant here. pahole optimization feels premature as well.

>
> > > +
> > > +static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> > > +{
> > > +   const int timeout = msecs_to_jiffies(CXL_MAILBOX_TIMEOUT_US);
> > > +   const unsigned long start = jiffies;
> > > +   unsigned long end = start;
> > > +
> > > +   while (cxl_doorbell_busy(cxlm)) {
> > > +           end = jiffies;
> > > +
> > > +           if (time_after(end, start + timeout)) {
> > > +                   /* Check again in case preempted before timeout test */
> > > +                   if (!cxl_doorbell_busy(cxlm))
> > > +                           break;
> > > +                   return -ETIMEDOUT;
> > > +           }
> > > +           cpu_relax();
> > > +   }
> >
> > Hm, that is not very scheduler friendly. I mean we are sitting here for
> > 2000us (2 ms) - that is quite the amount of time spinning.
> >
> > Should this perhaps be put in a workqueue?
>
> So let me first point you to the friendlier version which was shot down:
> https://lore.kernel.org/linux-cxl/20201111054356.793390-8-ben.widawsky@intel.com/
>
> I'm not opposed to this being moved to a workqueue at some point, but I think
> that's unnecessary complexity currently. The reality is that it's expected that
> commands will finish way sooner than this or be implemented as background
> commands. I've heard a person who makes a lot of the spec decisions say, "if
> it's 2 seconds, nobody will use these things".

That said, asynchronous probe needs to be enabled for the next driver update.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
