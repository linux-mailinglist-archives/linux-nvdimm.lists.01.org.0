Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4034EA4AD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Oct 2019 21:26:02 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2F28C100EA551;
	Wed, 30 Oct 2019 13:26:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 69BF4100EA54F
	for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 13:26:32 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id y194so3185107oie.4
        for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 13:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DB0Esgn2u6S/gYy4ztTMEgAHIadfdnSppVecXQR/BmQ=;
        b=YljXv7Q1wxqnCkVDdMgZtofx2rSTMM1fz2RXU61tBTgnlP0XWpsjt2e7fOAXcaulgw
         zP1YXn3xn0NIogw5hHNK/JbZWlmG/cB8fKERqX+qByERFbGGXqazPfY1UsGLe6FhzMr5
         meg8weMmaWBQE6H8xDtwkQLPnHopTbzo+VKpyITAF1/FRiX8D5as90CncBFlzGxtE7Xx
         6lWql9xMWWreZiUhbqTxlvLrJOCpCG9BTIBbzIBVOYt0wSCOvxlR/M5RFH5gpKakutd2
         SEjKKcyvzAVAIPpGbUQK8yrvAd9WidP8NL4G1Tf0MV8TQ64vDliHg22CQl+RvphcQRDA
         PVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DB0Esgn2u6S/gYy4ztTMEgAHIadfdnSppVecXQR/BmQ=;
        b=sWi9D0Q4jk8nq+X21Dl2CRfLS7WrMyGCKGiIBR5SxVsTkRvI2DfK2G3R7M0sKlTOJ3
         B1bRF1iE645GDp5EaIHgc+nJI0YQ2fRZ2vJAAaC/Byryg0wkXs88HB6Vnz85pE3b13B6
         7Ai6u0wm8ayPuAPFLxHBqXSngdeogsRUNw29luWHkchn5+P9876For5FoIqDiYsF+jnJ
         PfgJHSdQfm4fJw0bnOZJk1Uy1tTvi9tG9llRBclPRvPjTZkPV7TCE70QTa2Nzs6wyJht
         uwm+2Pps5ZoRgtQh66T8DMBYk41oqw90WHsvoeHFD2i6kT+gDVjvX8RwxWAVxqBHfPFL
         TXzw==
X-Gm-Message-State: APjAAAWrj6E6FjTOv7cflWXmIMcXHZD2++PvtmN3z5h+xq/seVLs6BPQ
	M7MdcLCmwxAztHXtNnXjbP/ebTvn4975UURkC6/KXg==
X-Google-Smtp-Source: APXvYqxjoPtFXRn8Md6QTlvFeMTbTacSemsUejC32ZRefBEyCk6rhqYcrCf8nNLaTgsDOrV06arS1pSWZ+A1j8byPas=
X-Received: by 2002:aca:ad52:: with SMTP id w79mr915721oie.149.1572467158050;
 Wed, 30 Oct 2019 13:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <1572462939-18201-1-git-send-email-cai@lca.pw>
In-Reply-To: <1572462939-18201-1-git-send-email-cai@lca.pw>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 30 Oct 2019 13:25:47 -0700
Message-ID: <CAPcyv4jvoo2Ez5hMivt+-B3-9giX3v6VZ0xZWLBQzL=7spVnrg@mail.gmail.com>
Subject: Re: [PATCH] nvdimm/btt: fix variable 'rc' set but not used
To: Qian Cai <cai@lca.pw>
Message-ID-Hash: WDCD5RYF3GHENQCFRB3FFNC3HJBMU3ZS
X-Message-ID-Hash: WDCD5RYF3GHENQCFRB3FFNC3HJBMU3ZS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WDCD5RYF3GHENQCFRB3FFNC3HJBMU3ZS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 30, 2019 at 12:16 PM Qian Cai <cai@lca.pw> wrote:
>
> drivers/nvdimm/btt.c: In function 'btt_read_pg':
> drivers/nvdimm/btt.c:1264:8: warning: variable 'rc' set but not used
> [-Wunused-but-set-variable]
>     int rc;
>         ^~
>
> Add a ratelimited message in case a storm of errors is encountered.
>
> Fixes: d9b83c756953 ("libnvdimm, btt: rework error clearing")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/nvdimm/btt.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index 3e9f45aec8d1..59852f7e2d60 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -1266,6 +1266,11 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
>                         /* Media error - set the e_flag */
>                         rc = btt_map_write(arena, premap, postmap, 0, 1,
>                                 NVDIMM_IO_ATOMIC);
> +
> +                       if (rc)
> +                               dev_warn_ratelimited(to_dev(arena),
> +                                       "Error persistently tracking bad blocks\n");

If the driver is going to warn about bad blocks it should at least
include the block address that is returning an error.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
