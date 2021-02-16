Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB7A31D3C5
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 02:28:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65940100F2250;
	Tue, 16 Feb 2021 17:28:08 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::233; helo=mail-lj1-x233.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3A9F7100F224F
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 17:28:06 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u4so14201568ljh.6
        for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 17:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gPv9nnPUm1TtsaIpcziIZ0EFUe5FQcNRA0/EfWprXeY=;
        b=mGOK/Lh9DqKxJSxcLC/cxXGfRCykdF3sEex6bNjqzqqz2wEXNZBz8qBIw/o/GsUdUy
         JqGdAlqK7l8xfqw4n9s7IjyviTTAuGHuBaeb6qCFKidDFjkZ//uchfJYsIGgwHVtr+F5
         5gjY6KulqlRxhZvyySFR+JV5+adv/UPppeptMXju3SPBlKXcZzZ+unOTCVTGvnv+c2ot
         fXRavbbrvHNb7PTxme8yT8CBwFzOcc+7stZvccs1xfXnQKM4yLPDDsEnnEnMxfaI+3Bw
         8uMjxu3dSsu34XskLTm16uo962LYhNuoS6DU4FGoagVodC6dCGiyzDAgW8vA2UrBWvkE
         o/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPv9nnPUm1TtsaIpcziIZ0EFUe5FQcNRA0/EfWprXeY=;
        b=Je4sE5Hu1mdsb5j1c652ADi2p3CAu1vXeTPMcH8wZ/WJmNJgyPkIcP6iK1PDegnFcK
         mLRrn+2056PEIX+aycbf6qIOrchOBo1BTj5yZsg08vWjtTdiw0MRAahEnSCjRogcVt3H
         rk0ujC/95RI9PJDW5KoQoEMW0zWOml4WZLhrs6mc20mQH2JHYbCPXC/QpIJoALJIQjkJ
         kl+df8ZMi8aa5MRy76y3ilhG2H/AsDBVBqZJn6M2Chf+KKehxEXPdeCmpkrpO1O/czxP
         9BRkIxu2EX0QCQ32mVXKmyU5KIpLbpwphl8gbisbXno6IIbOpbDoibJXPmcSLOgr3/sn
         fXxw==
X-Gm-Message-State: AOAM533OSw7KtgS6nQMUsuGbsxE/qBzGxmc0AJxtOHZXygr5eCZ6YdTF
	uXKWwA1pjf+qiCTcDfD4FdLV8+PCEIVSDVQ8NKXtw/dAbK3zTw==
X-Google-Smtp-Source: ABdhPJyjE1eb1Bs0azjhOXFMczp7BzdIXSTzhGuiY/xcrO0h9FgGKkON6FHrIIfzEIYcpgRYGzsqpuUaoa9cw1ekQ9c=
X-Received: by 2002:a17:906:5655:: with SMTP id v21mr4481219ejr.264.1613515145917;
 Tue, 16 Feb 2021 14:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20210126021331.1059933-1-ruansy.fnst@cn.fujitsu.com> <b685493f-98f5-9717-f88a-308e96440dcd@oracle.com>
In-Reply-To: <b685493f-98f5-9717-f88a-308e96440dcd@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 16 Feb 2021 14:38:55 -0800
Message-ID: <CAPcyv4gdeg+RfATJx8Ls4E=FE913JuxftdO1vhsoWJh+_bpe1w@mail.gmail.com>
Subject: Re: [PATCH] dax: fix default return code of range_parse()
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: LGOQR6WODUOTC7RYFDKZ4FTAEBQGBAPQ
X-Message-ID-Hash: LGOQR6WODUOTC7RYFDKZ4FTAEBQGBAPQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Zhang Qilong <zhangqilong3@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LGOQR6WODUOTC7RYFDKZ4FTAEBQGBAPQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 10, 2021 at 10:19 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 1/26/21 2:13 AM, Shiyang Ruan wrote:
> > The return value of range_parse() indicates the size when it is
> > positive.  The error code should be negative.
> >
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
>
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>
> Although, FWIW, there was another patch exactly like this a couple
> months ago, albeit it didn't get pulled for some reason:
>
> https://lore.kernel.org/linux-nvdimm/20201026110425.136629-1-zhangqilong3@huawei.com/

Apologies for missing these... applied now.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
