Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34D51F0077
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jun 2020 21:40:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 57DD41009F03B;
	Fri,  5 Jun 2020 12:35:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1043; helo=mail-pj1-x1043.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8A7CC1009F039
	for <linux-nvdimm@lists.01.org>; Fri,  5 Jun 2020 12:35:36 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m2so3264511pjv.2
        for <linux-nvdimm@lists.01.org>; Fri, 05 Jun 2020 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XD9SvQZCXqBYsn01rJ4+6okeD2WJfdjImO5gHn5OfAs=;
        b=bnJxDETTne1L69aD8HMa3+kqe0sCzIsfxsY/YGV+blK3BmwxALlVA3u7SAzSgUmOnl
         Z6vkaXeq1Oll41yzGDjLdhJrjYykohJ9ZMVm+8VJp0451xMrw2obIW8B2NJ81JC9UN43
         eOpQFIYIHQF3Yq7Eh2EfJZjwrtAN20rvfknSbj69OMBiMyO+vYv5t8et8k/frbSnKym1
         jsPzZ9m2bhn9aBApE58LENVDX+Zwt3H5Z87CV5kPJZs6oqAPNJTx8XZoa//yWYIIyKpC
         rbIlTj4JXsNRWc7BjOhLFA3/i09wwxHjH/kdv+KAdrs6i6oon9gYXXYxgg1T1BsmFC6B
         5UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XD9SvQZCXqBYsn01rJ4+6okeD2WJfdjImO5gHn5OfAs=;
        b=JIwqjywtqDOZCTUqFCGkMnxgfBhGu01xrTH4iBhKKL3lgDgM+dY5O8WbolytY73VzV
         JbsxcU84yn8Ja7bnAzIL9yn0HCPe46BzuJU3tTkjr78LSrdV0YEba0QwGT39+7sJfMju
         cDdK37++qBoCFN+REdScx253pxgfAoKBTuXrWfG+CkAqVQwdsrhuAr37m2e2RD43AoWB
         ++vKfoE+tjQJASYJdt1OFA5yN7u7ZNhxI04lESG9OvyIMfDI8qjuhcXD0AVSjRSytM/z
         FlrDkQBUDXMjpqeWlNn4p+Skqolrnkgkow1PllETKjuGulOexPcWCcCdeO+4ENdFE9BH
         +8PQ==
X-Gm-Message-State: AOAM532q1bFOUEhOQv9BeAvayQsdky28lfX2kwDh4wQ8/YOp3WmLBCDH
	hMDVhQU0DBsuZ9v9XRGpBOxMo0+UPOWdM+6jxiw=
X-Google-Smtp-Source: ABdhPJzxhdZq+OzZcXHaxB72UvfeXpj8EszRzS+I9vY2btE/7JjVwZ1hJGP0sRNO0nUDIIdnYcwulI8NIwFOPnICVV8=
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr4668507pjd.181.1591386048635;
 Fri, 05 Jun 2020 12:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2643462.teTRrieJB7@kreacher>
In-Reply-To: <2643462.teTRrieJB7@kreacher>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Jun 2020 22:40:36 +0300
Message-ID: <CAHp75Ve8A373Cbw6RiKTtkhj9jsxZ9dBY8ELtntk0B=yXxOCUg@mail.gmail.com>
Subject: Re: [RFT][PATCH] ACPI: OSL: Use rwlock instead of RCU for memory management
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Message-ID-Hash: GQBCEP3PYHG6TPVFOIQOBGVX3DT6LPJR
X-Message-ID-Hash: GQBCEP3PYHG6TPVFOIQOBGVX3DT6LPJR
X-MailFrom: andy.shevchenko@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Erik Kaneda <erik.kaneda@intel.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GQBCEP3PYHG6TPVFOIQOBGVX3DT6LPJR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 5, 2020 at 5:11 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

...

> +       if (!refcount) {
> +               write_lock_irq(&acpi_ioremaps_list_lock);
> +
> +               list_del(&map->list);
> +
> +               write_unlock_irq(&acpi_ioremaps_list_lock);
> +       }
>         return refcount;

It seems we can decrease indentation level at the same time:

  if (refcount)
    return refcount;

 ...
 return 0;

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
