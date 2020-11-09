Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B232AC22D
	for <lists+linux-nvdimm@lfdr.de>; Mon,  9 Nov 2020 18:26:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6F7B716593960;
	Mon,  9 Nov 2020 09:26:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CD83616649EFB
	for <linux-nvdimm@lists.01.org>; Mon,  9 Nov 2020 09:26:32 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o20so9634542eds.3
        for <linux-nvdimm@lists.01.org>; Mon, 09 Nov 2020 09:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJc7DxZxtIuzdI/2gpdlhjHr5AKQak7pICrpafaazgc=;
        b=pTxaQZQnDKvPEbiCmPRd9EW9mdYmiurVniIl8T2fXNF+JNApwcfoGGcvMh/jDusIvP
         dqgChHcijPnZM19ZNe4Hx0zJj6pAY7a+4WqsdWYgM/WdQD63jPge/acFmwGopnMHWRfW
         Jaq3NLVVfhndbooxaamr7SIrhFbIwoPsMIB26z9aC6IAJh6AxNoZTsms0BeD8niqsiVI
         XPFHC3FMjhMw+/BXgSfqK6vDSvxL46I7W5nxgx2kp7jYRSWT5GYUv7Z8niS+pFX/3XIA
         F6w/xBPIiRxe/iNDjfgZzB0qUFg5smAGnSv+BRli9ZONE3MpZ3y99vp39/leHnQuvCao
         pOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJc7DxZxtIuzdI/2gpdlhjHr5AKQak7pICrpafaazgc=;
        b=OzlzfGi8QwSMbACCWlxQFBDSZCdUU34ZHQE800754TDxd89Xyy2hJsXdS/t/Ou81wL
         TNzWbQFY1uGtF4HQeRpRiA+ChgPSmZA8uJ9D/y517NDjDUS1jA4sSixV32lg8THEO4Vc
         cDeo9g8DBD2xdqPQLb5avVO6AYhQZVd6d1IgENYLidXuygJI0AmJFeBkW+8wnEJZgFmA
         l5wtom0/ax7K8FXsTh7Drb9N63NdY8J65R4fmUgvk5QBT6N0+OwFnVI1WXmLafZnaYy1
         mqk/nDz4QJdwLSl8NLHKmHS8Xe8GE8smq/Ue2Bc+zdWWJdgX9nfgfhVjO1YfI86xApzt
         G8Hg==
X-Gm-Message-State: AOAM532URJimV7G59kD4eDEEyXqPyDeRtKNqhBvF00eJndhClA7Wt5hl
	SyVIhQG4NB5ssAfeLcc6SJrGq/Mv6JMvYus1EKrnbQ==
X-Google-Smtp-Source: ABdhPJyXZiUe7xKcYYQoUUxc+Neqs9b3cRZ/OgSCMXPCfT5lCZ0GwwWmg+WliDyLWn+FjR1evh2tnHedP8j5BQG23N8=
X-Received: by 2002:aa7:cc84:: with SMTP id p4mr16049370edt.97.1604942790913;
 Mon, 09 Nov 2020 09:26:30 -0800 (PST)
MIME-Version: 1.0
References: <1687234809.1086398.1604889506963.JavaMail.zimbra@redhat.com>
 <4ed7ea52-20be-68fe-f920-238ba358395c@redhat.com> <20201109141216.GD244516@ziepe.ca>
In-Reply-To: <20201109141216.GD244516@ziepe.ca>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 9 Nov 2020 09:26:19 -0800
Message-ID: <CAPcyv4gJG_-gGwzaenQdnVq13JUWLjEnsTV+e4swuVtpGVpC8g@mail.gmail.com>
Subject: Re: regression from 5.10.0-rc3: BUG: Bad page state in process
 kworker/41:0 pfn:891066 during fio on devdax
To: Jason Gunthorpe <jgg@ziepe.ca>
Message-ID-Hash: O7LVJOMRPLF3VYMHORVWFULTLUHTYK3O
X-Message-ID-Hash: O7LVJOMRPLF3VYMHORVWFULTLUHTYK3O
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Yi Zhang <yi.zhang@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O7LVJOMRPLF3VYMHORVWFULTLUHTYK3O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 9, 2020 at 6:12 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> Wow, this is surprising
>
> This has been widely backported already, Dan please check??
>
> I thought pgprot_decrypted was a NOP on most x86 platforms -
> sme_me_mask == 0:
>
> #define __sme_set(x)            ((x) | sme_me_mask)
> #define __sme_clr(x)            ((x) & ~sme_me_mask)
>
> ??
>
> Confused how this can be causing DAX issues

Does that correctly preserve the "soft" pte bits? Especially
PTE_DEVMAP that DAX uses?

I'll check...
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
