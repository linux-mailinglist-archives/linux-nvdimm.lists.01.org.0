Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE71B30B3E9
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 01:14:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CD487100EA92F;
	Mon,  1 Feb 2021 16:14:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 32491100EA922
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 16:14:35 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g10so2702612eds.2
        for <linux-nvdimm@lists.01.org>; Mon, 01 Feb 2021 16:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFucjoYJAjrzKJvfbUSDRADl/xduzdtfqGtMS5D6hPY=;
        b=V6v5HElpTGs/PZ0hdhIcdtSp2EM0VozT5sHt9rLv77z3b28pRg+Qbs8IyZCLk6ECOf
         T2rc3N59flLmzclde2mw4fIu7s+KK3p+SooKJi5A/NHgOpMRwRQUF5/uDSs+UGbcippf
         LcTMMrZHOFNuPBuGj4O+Kgzmkrdlu9Vp5Sd1Y/GYt0l0j+cnQ0jmx5kHYMFZigrv2CJj
         i8fYM3neYCcC41JrRupSAzKkUUgJbt7+35wu/9UT0i5uhmcTs/3peaXxQ8JhocLuJWSt
         +LGTicj+zZbNiMkHgBYLsXU+6xsXwNJw2KXgeqW2k/VDMP+7XoAUM6mO6sqs9dxFf7Et
         0bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFucjoYJAjrzKJvfbUSDRADl/xduzdtfqGtMS5D6hPY=;
        b=SOwHXGfzmIFEDk+7lIwJydsksBM13oySTdarxMrxlD/2fVX/K++a1krK09xVTRpNLj
         ju7zbgWNbQYGoH5ovE20imyRS//VCqFoV4Se14mpnwTZxuhRRDkSzADw1ZiH32nspUK7
         bNDrdgGcUfZt7rrskKMmdZtcNkGPHKgVP8m6WbrQRFAJHQhdc07ieveaLvFOLVEYxu9H
         wvO1uLjPoxMJkQkRhfJnBPWfiRi2mjeX8gCmX4APu6JmDNXhSDqv7iLvAAiE3i6OAZ2O
         2QekJAuCySt5BKibE0OddOAlaJYW54hXDEvl8netXgmM9e8jaKfK2vFq1dHje0dKQfeB
         4aGQ==
X-Gm-Message-State: AOAM533ZFkizYjZh5kNInVQpqAiVMK06du8xycUjjxvWTfIM0/btwzWf
	LgwJJ04rhhBm18yrZo71l9g6lIm02QUA4d1xA2BHUQ==
X-Google-Smtp-Source: ABdhPJzY0Txqg5GMACYMa4RF+9K+oxBRl0P8SMWmJ+8Vr0cxUEfBHYyg/cmBiIqbSiNtU/5HFoYqNytdsJOffxgTEsI=
X-Received: by 2002:a50:f19a:: with SMTP id x26mr12208716edl.354.1612224873669;
 Mon, 01 Feb 2021 16:14:33 -0800 (PST)
MIME-Version: 1.0
References: <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
 <20210201215857.ud5cpg7hbxj2j5bx@intel.com> <b46ed01-3f1-6643-d371-7764c3bde4f8@google.com>
 <20210201222859.lzw3gvxuqebukvr6@intel.com> <20210201223314.qh24uxd7ajdppgfl@intel.com>
 <f86149f8-3aea-9d8c-caa9-62771bf22cb5@google.com> <20210201225052.vrrvuxrsgmddjzbb@intel.com>
 <79b98f60-151b-6c80-65c3-91a37699d121@google.com> <20210201231718.2hwaqgn2f7kc7usw@intel.com>
 <a789317e-2ac2-10a1-dedd-1851972e3d6b@google.com> <20210202001120.vr6mos7ylnbqytxh@intel.com>
In-Reply-To: <20210202001120.vr6mos7ylnbqytxh@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 1 Feb 2021 16:14:31 -0800
Message-ID: <CAPcyv4jRVDdZyqH_eL4jjRvbCOEpO_UMUZdXbtevsY6PpcRq4Q@mail.gmail.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
To: Ben Widawsky <ben.widawsky@intel.com>
Message-ID-Hash: 7KX4YFORGPZWLMCABT3ERAQTEHKDXGXH
X-Message-ID-Hash: 7KX4YFORGPZWLMCABT3ERAQTEHKDXGXH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Rientjes <rientjes@google.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7KX4YFORGPZWLMCABT3ERAQTEHKDXGXH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 1, 2021 at 4:11 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-02-01 15:58:09, David Rientjes wrote:
> > On Mon, 1 Feb 2021, Ben Widawsky wrote:
> >
> > > > I haven't seen the update to 8.2.8.4.5 to know yet :)
> > > >
> > > > You make a good point of at least being able to interact with the driver.
> > > > I think you could argue that if the driver binds, then the payload size is
> > > > accepted, in which case it would be strange to get an EINVAL when using
> > > > the ioctl with anything >1MB.
> > > >
> > > > Concern was that if we mask off the reserved bits from the command
> > > > register that we could be masking part of the payload size that is being
> > > > passed if the accepted max is >1MB.  Idea was to avoid any possibility of
> > > > this inconsistency.  If this is being checked for ioctl, seems like it's
> > > > checking reserved bits.
> > > >
> > > > But maybe I should just wait for the spec update.
> > >
> > > Well, I wouldn't hold your breath (it would be an errata in this case anyway).
> > > My preference would be to just allow allow mailbox payload size to be 2^31 and
> > > not deal with this.
> > >
> > > My question was how strongly do you feel it's an error that should prevent
> > > binding.
> > >
> >
> > I don't have an objection to binding, but doesn't this require that the
> > check in cxl_validate_cmd_from_user() guarantees send_cmd->size_in cannot
> > be greater than 1MB?
>
> You're correct. I'd need to add:
> cxlm->mbox.payload_size =
>     min_t(size_t, 1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE), 1<<20)

nit, use the existing SZ_1M define.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
