Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D49DE13F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Oct 2019 01:35:15 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 859C110079B1F;
	Sun, 20 Oct 2019 16:37:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.66; helo=mail-ot1-f66.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B2D2910079B1E
	for <linux-nvdimm@lists.01.org>; Sun, 20 Oct 2019 16:36:57 -0700 (PDT)
Received: by mail-ot1-f66.google.com with SMTP id y39so9455376ota.7
        for <linux-nvdimm@lists.01.org>; Sun, 20 Oct 2019 16:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1/IHN/ve/UVAvkgwgytXM/n+jeqbbwYBnVAoJItoZs=;
        b=NxMHEiBUnP6JvbQs9PPJcAtI/X0mTOhayJ1n+3A9kIoqIGUYB48oC0H8h3wNf4TTws
         +C8Ap4fC3lJVUVkwKS9xK9Ovt05bYZ5vnuOCnlrxXf7njz2PquNmWUYhZZL66VwwP2fk
         dMCdm6StDWRSypXelWp7QuIHA4IcgR8d2cxl/EpregWD7j83TyJ6+KW08o4EkOAUlAnp
         Sh/pJ6RUDiSXBjqDrUBJH0blGHrUUmDn3zf1yQoE86d7opdeD6WR5kQ9GH2Jn6oph/E3
         4U1m590WheYUlHkuG8PFcXrEPwl8MKXEgnx/VaSviPwX6qqMK8jqLClC2/PBB1AIYS1A
         IHtw==
X-Gm-Message-State: APjAAAWEwdBMxuxv+Y3EoXofTknanp0+zfz9WE31FxcF8mItyo3WQ2Ws
	/Y/3rQ7mG3PocqcKu8XlaWW3+eL8oaIf2g+ODuA=
X-Google-Smtp-Source: APXvYqyuOzu9MZlBlyPAZ1+sMzYtlHZqQtbfvDQ/pZzcle5REH+v+AVjOknrXhmJX1pYgksatO3r38jMIOd9qPCFG+k=
X-Received: by 2002:a9d:664:: with SMTP id 91mr9655425otn.189.1571614507410;
 Sun, 20 Oct 2019 16:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191018123534.GA6549@mwanda>
In-Reply-To: <20191018123534.GA6549@mwanda>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2019 01:34:56 +0200
Message-ID: <CAJZ5v0jeoJrrn56VqRSoY-Mc9rp04tWYbTCsQugZV=vXQk0nNg@mail.gmail.com>
Subject: Re: [PATCH] acpi/nfit: unlock on error in scrub_show()
To: Dan Carpenter <dan.carpenter@oracle.com>, Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: XCH6R7B5K2ULRTPMNMDFEH4HYCGHH35L
X-Message-ID-Hash: XCH6R7B5K2ULRTPMNMDFEH4HYCGHH35L
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XCH6R7B5K2ULRTPMNMDFEH4HYCGHH35L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 18, 2019 at 2:38 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> We change the locking in this function and forgot to update this error
> path so we are accidentally still holding the "dev->lockdep_mutex".
>
> Fixes: 87a30e1f05d7 ("driver-core, libnvdimm: Let device subsystems add local lockdep coverage")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/acpi/nfit/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 1413324982f0..14e68f202f81 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1322,7 +1322,7 @@ static ssize_t scrub_show(struct device *dev,
>         nfit_device_lock(dev);
>         nd_desc = dev_get_drvdata(dev);
>         if (!nd_desc) {
> -               device_unlock(dev);
> +               nfit_device_unlock(dev);
>                 return rc;
>         }
>         acpi_desc = to_acpi_desc(nd_desc);
> --

Applying as a fix for 5.4, thanks!

@Dan W: Please let me know if you'd rather take it yourself.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
