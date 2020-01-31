Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AA914F539
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 Feb 2020 00:33:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E3C6610FC317D;
	Fri, 31 Jan 2020 15:36:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3757F10FC317C
	for <linux-nvdimm@lists.01.org>; Fri, 31 Jan 2020 15:36:29 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id z2so8987183oih.6
        for <linux-nvdimm@lists.01.org>; Fri, 31 Jan 2020 15:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ydfkVJuqKAtevzcvIME46rBnvAQYleKPMllA+9UzFE=;
        b=FHAhj4MP1/gFGX4HW68DKPiDucCPPrD3rMy9BYTrk1H/AtQOJ/7gM/tS8X0NSw6wEr
         e2KirqhzSKbJeZ56YsS3/7caTCK9GOVqmFzK3GT87Ktg1rnB1pfapgJKIl/HoKpNlsIR
         8dVR/Mlp9qWACIk+ryaX2CGr6ER1dEdbv2LjPaXJON6n0l/O39nqIQsmDKxXyNNMrGFG
         1a+TyAkz+b6nA0O0L/7o0lPFPQS+/y8F/7SMxPZF0CNX5qAs8MVkDCTyiGvcEoCPpiI1
         nprTxMvyI9D+6XSRzlL2rU7kRoJZlfd7p3iWTaIwErGUTQg/VQthkEiICyHUwj6TkD6M
         /sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ydfkVJuqKAtevzcvIME46rBnvAQYleKPMllA+9UzFE=;
        b=UQy5wqARnE450ftBye+1IiyM/chtBG77fopxyyy16IOlittvptyn2qF+ZfPfli5qAk
         aY1dUGpuireUUIoNcK1bMGwzakRBtUgZZ+G+33vWujsaTGOkUebTaREIpgJAxXP4xONU
         9BRXkY6h43AXLCx4/WtLazEaOKHKf73O/A1gaaAKVrOaV6D7C1aCYcS4Z97cMRAXCSRP
         yOAmL4jPGIzwlaj7S5cEpWQnR4pCrY0/Z5E5ksYmYYYom7KqR9kMP0CarqfhZ0dEk/4u
         aIsbov2WlsVNsbdf/MpKMepPHBHTnUG7HTfwx4JlLdBrxu+swcwqIodv7E2E6xmtdkb1
         P9gQ==
X-Gm-Message-State: APjAAAUUNMZHKscG+ms6cVVn4hgCxNoz3yOrkVRdsacvKMzwtZlZl5fc
	MGrC0QNwnaFWVbSeFkrXXGv8BfmWiqOKgeVbkdjsZw==
X-Google-Smtp-Source: APXvYqz9K7lgqMfgRXSTy8NOKtGIWHlcsUFKNsj7f9DJgo13R2LslS1EIQSRKxw34FIdqXMACR+483UsoTsSgKyl9oY=
X-Received: by 2002:aca:4c9:: with SMTP id 192mr8268319oie.105.1580513590820;
 Fri, 31 Jan 2020 15:33:10 -0800 (PST)
MIME-Version: 1.0
References: <20200131224756.29821-1-vishal.l.verma@intel.com>
In-Reply-To: <20200131224756.29821-1-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 31 Jan 2020 15:33:00 -0800
Message-ID: <CAPcyv4iP0oe=UJweX=GTBD0a7VO=pfNNdsLzDkhQeOcihFHzPQ@mail.gmail.com>
Subject: Re: [ndctl PATCH] ndctl: add util/filter.{c,h} to ndctl_SOURCES in Makefile.am
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: JMM4C7AJYM3C2JAT3LMFCGRGAMEX7VS4
X-Message-ID-Hash: JMM4C7AJYM3C2JAT3LMFCGRGAMEX7VS4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JMM4C7AJYM3C2JAT3LMFCGRGAMEX7VS4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 31, 2020 at 2:48 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> ndctl/Makefile.am neglected to explicitly add util/filter.{c,h} to
> ndctl_SOURCES. In the past, this has been a cause for distro build
> failures.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  ndctl/Makefile.am | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/ndctl/Makefile.am b/ndctl/Makefile.am
> index 264c4ed..49c6c4a 100644
> --- a/ndctl/Makefile.am
> +++ b/ndctl/Makefile.am
> @@ -18,7 +18,9 @@ ndctl_SOURCES = ndctl.c \
>                 check.c \
>                 region.c \
>                 dimm.c \
> -                ../util/log.c \
> +               ../util/log.c \
> +               ../util/filter.c \
> +               ../util/filter.h \

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Not sure why 'make distcheck' did not hit this previously.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
