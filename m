Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B648369B63
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Apr 2021 22:39:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB443100EAB00;
	Fri, 23 Apr 2021 13:39:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5B426100EAAFF
	for <linux-nvdimm@lists.01.org>; Fri, 23 Apr 2021 13:39:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y3so22519755eds.5
        for <linux-nvdimm@lists.01.org>; Fri, 23 Apr 2021 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfQYJoLyB6h5ZbM4eg6Kr44fOO/ylFVrCnfKWSRlupI=;
        b=XIrgS7eZvzhqFQGzaCw99zsTJou6Zmn6+qlQS+jLXwjE4/FMmqnjZuwoAcS2cOq9MJ
         YwLvedQjp6Xc7eib13/t2RHH1CRhgf4pLfr2ZnEmQ2s94gOCMX2a7ccCO4BrwX8ELRNz
         pratDifm/U3Qz0LPqF5zfi5UiRmLchv91hKIKYZ7Tcw1b1ngICuDWkuFMKnVbs+PI+lF
         Qx6B6YkP9fV1dUeP+TLUmymxhUAQdBr8fal4P+zCvMljDKJ2AR6ye99CxLvf1/n4xrTq
         ImhgPSL3EFPtqiQITgBoMcFVvYbf3yVITE8jWKMGK2GZw/bT+aB9l6F5n9ZAlNFWYzuE
         W3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfQYJoLyB6h5ZbM4eg6Kr44fOO/ylFVrCnfKWSRlupI=;
        b=g0mEs11ESU16QhIVazXOZHwKeUXCmF2w5ozOVlViJVNgnTa5vjuXwPOzGzLfTwyeL5
         76QUmqnpdh60qMlN+Cq/t4gGouN+NAZAXlhHaiNlZMcoNhQyVI06nFXMTJFye93oF0LY
         bsE7FaYkoOCG/UEQX9OyaslmlTy+LOLjY8FLZi9ke5a5deyYjYn8n/CE4tYrrLLQ8KiK
         jidqOBmupNQrQ630GFEC1eM05C4xKLEX72bjGH1nd5ZeNC8h4roVwaL+Sg2JyB0FDRh0
         If7FvcuEngldnqEwN8SCfUAz7LdxwOjk0dU4bytZstNwu/Sp+Zycw+wctb7w56uxowYb
         DChQ==
X-Gm-Message-State: AOAM533hqk0MHgS5EukJcDHY6UqybcD4+QVWQk2UUAkvpnhiPGA/ehK+
	e8ga86FZdC6xAcAtnLLgIllzHZjdJjlcCtTdBoafpw==
X-Google-Smtp-Source: ABdhPJyNoSkdooYSFcOxpyxKQDuiru1CJwem5bBb2pWMDB82inZWG0N72kKzPu9nUXH1iLB8MmvByOyiMsdyQh3mpBM=
X-Received: by 2002:a05:6402:3514:: with SMTP id b20mr6565480edd.348.1619210337492;
 Fri, 23 Apr 2021 13:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210423130723.1673919-1-vgoyal@redhat.com>
In-Reply-To: <20210423130723.1673919-1-vgoyal@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 23 Apr 2021 13:38:51 -0700
Message-ID: <CAPcyv4hz=nHYQ89-m-7yVJWpEP4gZBYTY6E4POAms9mYDb_N+g@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] dax: Fix missed wakeup in put_unlocked_entry()
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: Y6UPXUTYMSISAVTXGNGA7HTLPKIKXYPX
X-Message-ID-Hash: Y6UPXUTYMSISAVTXGNGA7HTLPKIKXYPX
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtio-fs-list <virtio-fs@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, Sergio Lopez <slp@redhat.com>, Greg Kurz <groug@kaod.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y6UPXUTYMSISAVTXGNGA7HTLPKIKXYPX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 23, 2021 at 6:07 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Hi,
>
> This is V4 of the patches. Posted V3 here.
>
> https://lore.kernel.org/linux-fsdevel/20210419213636.1514816-1-vgoyal@redhat.com/
>
> Changes since V3 are.
>
> - Renamed "enum dax_entry_wake_mode" to "enum dax_wake_mode" (Matthew Wilcox)
> - Changed description of WAKE_NEXT and WAKE_ALL (Jan Kara)
> - Got rid of a comment (Greg Kurz)

Looks good Vivek, thanks for the resend.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
