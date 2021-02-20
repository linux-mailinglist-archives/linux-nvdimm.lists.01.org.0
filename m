Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7BC320678
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Feb 2021 18:48:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E96AA100EC1EB;
	Sat, 20 Feb 2021 09:48:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 68911100ED499
	for <linux-nvdimm@lists.01.org>; Sat, 20 Feb 2021 09:48:33 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id n13so21844179ejx.12
        for <linux-nvdimm@lists.01.org>; Sat, 20 Feb 2021 09:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=niF1k3dVyqWcVFhX7Jys8F/FWOuqyr/3JpoSyGWUad4=;
        b=SJiJGOm92EOLuEmD8ZxINHCPgWL9FHxOSQ3VIYWX9zoyH2E9wOjXIS9rFt4qflATpv
         hSN/bjk3gMWmOoic96yidZvVl7/B4XMCsqfh0PkuMvTvPzxsbnnAAzqFwvJBX/EHx6Jq
         lEXEZ04J4mAMFF3qpTPsBe+t1d1hZCpoZ1tHexVfyV6BEj3IJZ6FxOnS5w7SFjV4xaQB
         bzdJovpxJgMpQMBdOPWU4kOe8uTftngZHfL80X3V4NBKw6dQvwl3+V0eAaAFtkaj7Nyw
         q6pWkVkKDyqb9Tw8d5bxJN+VZ9kPSu7gfMjLM+uXAWL9W050qu1qq3zAwkiaymsFO0Qm
         BLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=niF1k3dVyqWcVFhX7Jys8F/FWOuqyr/3JpoSyGWUad4=;
        b=ncJ/r6P23HM4UaFjYxiYBDGdRKQwtzBm28yjEXVCSA7RRgnzkIbRWw9MiJVgNH5y7L
         rHYs7jYSg9pm4aCvKPzHI4g89KdJqDB8vl0RrMVYFS1j57BPB8Kj+IxAYT/qcTT32/Oq
         JwH2NSmrqrhGRs/4EUAvTY0cZ6QukdA4slg8vIs4bdXhu6ia+JcSuttjjjNSGSjiijYO
         z9aCiu5M463lpkFqAa+pSzVboMmXBZKwq3tShSahWGstKMcRFiJ6NVJYP9ydgF7Hf7pV
         beZ0nCGqCMChxQg9rab7NL3wJLxgh4hJlVZkTTlenZ8elU+eXK8Geow+XatXh4II9z9U
         XwJg==
X-Gm-Message-State: AOAM533Rx63LtuRnL/WFBnBpJFfZblhZAQkKs+dgDZLZC+zkZpOJl0Rr
	ftQsSuCN4xWZfrAYqeFI+lbX873gtUQJm3xYI30FTg==
X-Google-Smtp-Source: ABdhPJzMFtM3V/tSlVTUOFi/gy4tLf3ErLDeRmJYFtXE81s7f90uq338SYuA8goZna9AO+QqkY89+APsjw6TJdTe694=
X-Received: by 2002:a17:907:373:: with SMTP id rs19mr1248541ejb.341.1613843310167;
 Sat, 20 Feb 2021 09:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20210217040958.1354670-1-ben.widawsky@intel.com>
 <20210217040958.1354670-5-ben.widawsky@intel.com> <YDBkOB3K8UqVakFf@Konrads-MacBook-Pro.local>
 <20210220163344.csczmkyxkpu4fxah@intel.com>
In-Reply-To: <20210220163344.csczmkyxkpu4fxah@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 20 Feb 2021 09:48:22 -0800
Message-ID: <CAPcyv4jWnW_i=jaGP_nXRuGgwmngObw_V8AOPY3k_YMHkL-8Eg@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] cxl/mem: Add basic IOCTL interface
To: Ben Widawsky <ben.widawsky@intel.com>
Message-ID-Hash: 22EK4QSGTAENGO2TTL3P3A7UI3UKSUGA
X-Message-ID-Hash: 22EK4QSGTAENGO2TTL3P3A7UI3UKSUGA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, kernel test robot <lkp@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/22EK4QSGTAENGO2TTL3P3A7UI3UKSUGA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Feb 20, 2021 at 8:33 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-02-19 20:22:00, Konrad Rzeszutek Wilk wrote:
> > ..snip..
> > > +static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
> > > +                                   const struct cxl_mem_command *cmd,
> > > +                                   u64 in_payload, u64 out_payload,
> > > +                                   s32 *size_out, u32 *retval)
> > > +{
> > > +   struct device *dev = &cxlm->pdev->dev;
> > > +   struct mbox_cmd mbox_cmd = {
> > > +           .opcode = cmd->opcode,
> > > +           .size_in = cmd->info.size_in,
> > > +           .size_out = cmd->info.size_out,
> > > +   };
> > > +   int rc;
> > > +
> > > +   if (cmd->info.size_out) {
> > > +           mbox_cmd.payload_out = kvzalloc(cmd->info.size_out, GFP_KERNEL);
> > > +           if (!mbox_cmd.payload_out)
> > > +                   return -ENOMEM;
> > > +   }
> > > +
> > > +   if (cmd->info.size_in) {
> > > +           mbox_cmd.payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
> > > +                                              cmd->info.size_in);
> > > +           if (IS_ERR(mbox_cmd.payload_in))
> > > +                   return PTR_ERR(mbox_cmd.payload_in);
> >
> > Not that this should happen, but what if info.size_out was set? Should
> > you also free mbox_cmd.payload_out?
> >
>
> Thanks Konrad.
>
> Dan, do you want me to send a fixup patch? This bug was introduced from v4->v5.

Yes, please, incremental to libnvdimm-for-next which I'm planning to
send to Linus on Tuesday.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
