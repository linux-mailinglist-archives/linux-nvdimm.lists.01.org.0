Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0B0F33D6
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 16:54:38 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 33C3C100EA622;
	Thu,  7 Nov 2019 07:57:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AA370100EEB95
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 07:56:58 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id s71so2347215oih.11
        for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 07:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPq+F/KamrVXfihqwUZMUCO0VVedjSCc+SSESxNX1u4=;
        b=x20PRaoN7m1lY7MFBGr/daPa3Ev+PNMy3XZT4W2JTZHT44ynBkiI3a89OARLW92EGU
         qN7SlyhS8fJVOuwjoza0d85uQqoIwFm9osNlo7pxwCkeam/F2RLRvk6D+7oSbL6LWxy6
         kPLskVeWc6k0thVYlmYl6GDICmGeFKc0yqSG4GdSS3WOKtp5q+Ayp4xv4rd/y6H9AKj4
         wsoFEo9eR3S20Pr0/cWvkrvOlgW8Lh5gzFdat324joSNNNq/KC4gLmJiLUw8Dhee5d99
         6aJOkTiTZARiHuyV5cDzA5B82tnGQ+5aEF95bT+XExSShYx+ZdbmFxw/CMApGJuYgR8w
         cfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPq+F/KamrVXfihqwUZMUCO0VVedjSCc+SSESxNX1u4=;
        b=kakF7rjzE7q6Zv2lGpiSjezmWQMuCV/9u4D2kGx8NWS0RxB0AegFb4fy9vkhYGatj1
         boqmgLPnMvXLbQqFz2bI+ddmiWKHQRB/CV5/87CNkP3/wZVz1RoJnu37avY9jF/o5ZNu
         ZkPdo9ehKL537wstmLeSmnOfTymcge4YBVQ06HNtbuDG50sPZtx8WndvzWCcRIue9P+w
         5Yriy1+r0JK1XUi/GqkBnob55/V066HeC0P10Dw64IeFHJlpJepIXLKsiJ54jZp676S8
         KZksVja2Ge9w0+axEQW/sXLyB4oYo6wh4CNkyxlhvhD4Z5T9rF5DDR1ioeBNCB9wcxSX
         Vb/w==
X-Gm-Message-State: APjAAAUA+aVXQkKWzRZIefNhOIkRj5SeBNGmoE706zAVe8bLkBQTiIlZ
	x7xI+r6EoHJJ+yLCdPqUJ9geGWnA/QrPrCS7I1+u+N4V28Q=
X-Google-Smtp-Source: APXvYqyUQE1kx3x0EqpQDW2FFdAHAFjIJ2Kr3Cs+x9YArHPHm7gQ6G/U7B7BhSxoha0DrC1qMlYeHUbEnPPgXE9ebtI=
X-Received: by 2002:aca:1910:: with SMTP id l16mr3867404oii.73.1573142071963;
 Thu, 07 Nov 2019 07:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20191107152952.GA2053@swarm07>
In-Reply-To: <20191107152952.GA2053@swarm07>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 7 Nov 2019 07:54:21 -0800
Message-ID: <CAPcyv4j-rSy-T5Qv6GbcDcmUerhQQYsMKbUY7EaGHz-GecKDtQ@mail.gmail.com>
Subject: Re: [QUESTION] Error on initializing dax by using different struct
 page size
To: Won-Kyo Choe <wkyo.choe@gmail.com>
Message-ID-Hash: 77GZODXGIF6TN5MWEXRLWKCF5KCE2SAT
X-Message-ID-Hash: 77GZODXGIF6TN5MWEXRLWKCF5KCE2SAT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/77GZODXGIF6TN5MWEXRLWKCF5KCE2SAT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 7, 2019 at 7:30 AM Won-Kyo Choe <wkyo.choe@gmail.com> wrote:
>
> Hi, there. I'm using Opatne DC memory to use it a volatile memory. Recently,
> I found that if sizeof(struct page) is above 64 bytes (e.g. 128 byes),
> `device_dax` cannot be initialized when system boots. I am aware that
> for some reason there is a function, `__mm_zero_struct_page`, which limits
> the size of struct page when it exceeds 80 bytes. However, due to the
> research purpose, I do not use that constraint and I'm quite certain
> that using different page size is usable in main memory. So, I'm
> wondering why this is not possible in persistent memory and which
> patches are related to this problem.
>
> I will attach the system log for clarification. The test is run in
> linux-5.3.9 and linuxt-5.3-rc5

How did you manage to build the kernel with a 128byte struct page
size? This build assert in drivers/nvdimm/pfn_devs.c

                BUILD_BUG_ON(sizeof(struct page) > MAX_STRUCT_PAGE_SIZE);

...will start to trigger in v5.4 to explicitly prevent this going
forward. See commit e96f0bf2ec92 "libnvdimm/pfn_dev: Add a build check
to make sure we notice when struct page size change" for more details.

In general 64-bytes per page is already expensive 128 bytes is a
gigantic struct page.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
