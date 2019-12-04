Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D040911208C
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Dec 2019 01:10:39 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 173A310113693;
	Tue,  3 Dec 2019 16:14:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9D7AF10113691
	for <linux-nvdimm@lists.01.org>; Tue,  3 Dec 2019 16:13:58 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id d17so4760322otc.0
        for <linux-nvdimm@lists.01.org>; Tue, 03 Dec 2019 16:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bP/Z58Vpywuyv/5D0jzMkQmzI1y6rfhslg4IeZkkfuo=;
        b=n+endFykFTnqubh50VPrXWkbnh1C17bRb+kJ9KNBP/OIi7x5Gt2jj1jE4QZA7KJurY
         AmrrjwyLa9EL2YmIn51znrTe82kgYxVYb4tLoDdwL2i+vPlgbkpVcj6m7pMlSdjd9sS2
         r9MtD6OKyJPruXqeyonngHAeBsm12j1uI3P8b3sknK6mPanlO+r4UIVQ1V03cycZtXhz
         6S2haS740B2yykeUeD2AmsBNf9OQYJjoQ0R/vwHSG3uAXmE6/A06XwFO6stEeNKU2v3l
         cu9GPX1+3bpbLQBsXGff+J5r4P4AFK8ST082lrYg48CPCG2n/qjxNBaFyeCcsyLSWGFE
         S4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bP/Z58Vpywuyv/5D0jzMkQmzI1y6rfhslg4IeZkkfuo=;
        b=CAJn+pK/3QaZpekaf4FD7yCn5+0vVJ6+qJODz1VrUEZOpG6K+FOgKDjyelrE9Fhiwn
         Qq/lb/8QcU0YfvDihooyn4oJGrpPaHtckAhj1VRPI1N3O3ct9E73b30iULHBdVL5OiVo
         XQ9Bsh5hwxPG3MMguYscrngmetgH7/NkKx5bKER8BNi3WZPY2aj8Jwrw180A3IDcU/QR
         5ub6EygIaODPZVPTF8LN+VHgxrpUeh5AoUUgoG4/QTM2NDfcSh6l8sf9tthnqZMz4Aai
         O7zg6hLQz8X2lJdysqM0BkE4LTotuGExtcrfEUL0n4hdlFGknKuHTXJ3ZNmcmIu9CMlZ
         Twjw==
X-Gm-Message-State: APjAAAX9hQIf0VvGwD76D/2LBTXj/5uyPdpTpAi2twbq6p7Gtx10iviS
	3ucUu6dBx1JqjosJelN+Yyk9PRyKQf2ZDkiDo/dBtA==
X-Google-Smtp-Source: APXvYqxo0TCLXhSv/bqImk1LBzsS+WuhFsZnPo87Ddb1FLy6KXZX2IyaJ7m+s1dMLiBho5Jej4+R6eEkMFQ/ORNprE4=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr511782otq.126.1575418234712;
 Tue, 03 Dec 2019 16:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20191203034655.51561-1-alastair@au1.ibm.com> <20191203034655.51561-3-alastair@au1.ibm.com>
In-Reply-To: <20191203034655.51561-3-alastair@au1.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 3 Dec 2019 16:10:23 -0800
Message-ID: <CAPcyv4hhK1dyqqe=CwnGfd=hRdUJn0pL6scCUgCz2R+bijZvYg@mail.gmail.com>
Subject: Re: [PATCH v2 02/27] nvdimm: remove prototypes for nonexistent functions
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Message-ID-Hash: 2CJRLLGIVHUOMG3MNEJCGLLMM255UWIT
X-Message-ID-Hash: 2CJRLLGIVHUOMG3MNEJCGLLMM255UWIT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: alastair@d-silva.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Linux Kernel Mailing List <li
 nux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2CJRLLGIVHUOMG3MNEJCGLLMM255UWIT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 2, 2019 at 7:48 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> From: Alastair D'Silva <alastair@d-silva.org>
>
> These functions don't exist, so remove the prototypes for them.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---

This was already merged as commit:

    cda93d6965a1 libnvdimm: Remove prototypes for nonexistent functions

You should have received a notification from the patchwork bot that it
was already accepted.

What baseline did you use for this submission?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
