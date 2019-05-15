Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E23BE1FCC1
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 01:25:32 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CEEFF212733F5;
	Wed, 15 May 2019 16:25:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D0CDD21268F9D
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 16:25:29 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 66so1730516otq.0
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 16:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=klWe1X2kwGWTqHnD0kZUJYyAWHWMIBILlhfu7UeUVVU=;
 b=TtbGAGWdg/sFEvxvKLNEZ3rTz7M7jfaRfe9gkKZaWkcRY6wmWibUhniy4j6lMmowes
 k4ZkROyySNl28Ly0EaCwYr/DoQLXncEJMz04K6R1TSilBAWE5LGJc8AsxZS1firED+jR
 BGlWjEZACXditdDy5plTGSvMT+HiPDAmujo8v6hFs0xeAFhq+qeHMCfFJGGYgYIYdys+
 KIVydwcyDbANs8aIX5IB35f+4IB3uZkBBggGc1aP2h+WC9lrQPgXB2T0LN9LXo4EGDI6
 2il7zKY5TwInDXv+g52o6VMtQVQNFZ/ggEmKBDPef5GIGedriiglj5vbuzLNqEdHC7+0
 IcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=klWe1X2kwGWTqHnD0kZUJYyAWHWMIBILlhfu7UeUVVU=;
 b=Zvg7cj1yA2QZUynKT1VXZAsrTvw9zoas2t83qACPfd6q1aTOTIjDcofoJV+4f0Emwc
 B6428CZg6ey/zjI8YwSKXF5W3U7j8AsZB928kXnrbhT8fMVPdA7gOax/pqGuKd94PdcR
 bdPrCptii0c2cfO8NUWv0tUldqAxTG8K0TN3mmf2VkmokiMcsm/mfjT46IhUCeFQwibY
 W7YXBsndq/njo6+lwCFtaBV71BryBdmFhQieXa9tNPo6PaoxE1Uw3p4iXOIVzE72ncfH
 XnXynekHBefpZXm3U3nYfe25iosrkWXzeqc2jjVj1J+A1QXvevKCeTusGhc2Za0GlUzL
 5bBw==
X-Gm-Message-State: APjAAAVgqViOZgOGAkBffeEk1KmOD2vzJOysnp8ajJvSZndj6nuSG+4d
 a1WZOWnFKjHQ8LK1L+xVraFgmcZyVhV7/0HEsLp2iw==
X-Google-Smtp-Source: APXvYqyM5sfKqWWuJ6NZ12KG98/fUsZHMvQd7yZZtlA/U/scHiv81oFh4P8+Ypn6b9fGKLScDh5q4DWj5y6qwTHenr4=
X-Received: by 2002:a9d:12f2:: with SMTP id
 g105mr11455354otg.116.1557962728184; 
 Wed, 15 May 2019 16:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190514150735.39625-1-cai@lca.pw>
In-Reply-To: <20190514150735.39625-1-cai@lca.pw>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 15 May 2019 16:25:16 -0700
Message-ID: <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
Subject: Re: [RESEND PATCH] nvdimm: fix some compilation warnings
To: Qian Cai <cai@lca.pw>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 14, 2019 at 8:08 AM Qian Cai <cai@lca.pw> wrote:
>
> Several places (dimm_devs.c, core.c etc) include label.h but only
> label.c uses NSINDEX_SIGNATURE, so move its definition to label.c
> instead.
> In file included from drivers/nvdimm/dimm_devs.c:23:
> drivers/nvdimm/label.h:41:19: warning: 'NSINDEX_SIGNATURE' defined but
> not used [-Wunused-const-variable=]
>
> The commit d9b83c756953 ("libnvdimm, btt: rework error clearing") left
> an unused variable.
> drivers/nvdimm/btt.c: In function 'btt_read_pg':
> drivers/nvdimm/btt.c:1272:8: warning: variable 'rc' set but not used
> [-Wunused-but-set-variable]
>
> Last, some places abuse "/**" which is only reserved for the kernel-doc.
> drivers/nvdimm/bus.c:648: warning: cannot understand function prototype:
> 'struct attribute_group nd_device_attribute_group = '
> drivers/nvdimm/bus.c:677: warning: cannot understand function prototype:
> 'struct attribute_group nd_numa_attribute_group = '

Can you include the compiler where these errors start appearing, since
I don't see these warnings with gcc-8.3.1

>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/nvdimm/btt.c   | 6 ++----
>  drivers/nvdimm/bus.c   | 4 ++--
>  drivers/nvdimm/label.c | 2 ++
>  drivers/nvdimm/label.h | 2 --
>  4 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index 4671776f5623..9f02a99cfac0 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -1269,11 +1269,9 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
>
>                 ret = btt_data_read(arena, page, off, postmap, cur_len);
>                 if (ret) {
> -                       int rc;
> -
>                         /* Media error - set the e_flag */
> -                       rc = btt_map_write(arena, premap, postmap, 0, 1,
> -                               NVDIMM_IO_ATOMIC);
> +                       btt_map_write(arena, premap, postmap, 0, 1,
> +                                     NVDIMM_IO_ATOMIC);
>                         goto out_rtt;

This doesn't look correct to me, shouldn't we at least be logging that
the bad-block failed to be persistently tracked?

>                 }
>
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index 7ff684159f29..2eb6a6cfe9e4 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -642,7 +642,7 @@ static struct attribute *nd_device_attributes[] = {
>         NULL,
>  };
>
> -/**
> +/*
>   * nd_device_attribute_group - generic attributes for all devices on an nd bus
>   */
>  struct attribute_group nd_device_attribute_group = {
> @@ -671,7 +671,7 @@ static umode_t nd_numa_attr_visible(struct kobject *kobj, struct attribute *a,
>         return a->mode;
>  }
>
> -/**
> +/*
>   * nd_numa_attribute_group - NUMA attributes for all devices on an nd bus
>   */

Lets just fix this to be a valid kernel-doc format for a struct.

@@ -672,7 +672,7 @@ static umode_t nd_numa_attr_visible(struct kobject
*kobj, struct attribute *a,
 }

 /**
- * nd_numa_attribute_group - NUMA attributes for all devices on an nd bus
+ * struct nd_numa_attribute_group - NUMA attributes for all devices
on an nd bus
  */
 struct attribute_group nd_numa_attribute_group = {
        .attrs = nd_numa_attributes,

>  struct attribute_group nd_numa_attribute_group = {
> diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
> index f3d753d3169c..02a51b7775e1 100644
> --- a/drivers/nvdimm/label.c
> +++ b/drivers/nvdimm/label.c
> @@ -25,6 +25,8 @@ static guid_t nvdimm_btt2_guid;
>  static guid_t nvdimm_pfn_guid;
>  static guid_t nvdimm_dax_guid;
>
> +static const char NSINDEX_SIGNATURE[] = "NAMESPACE_INDEX\0";
> +

Looks good to me.

>  static u32 best_seq(u32 a, u32 b)
>  {
>         a &= NSINDEX_SEQ_MASK;
> diff --git a/drivers/nvdimm/label.h b/drivers/nvdimm/label.h
> index e9a2ad3c2150..4bb7add39580 100644
> --- a/drivers/nvdimm/label.h
> +++ b/drivers/nvdimm/label.h
> @@ -38,8 +38,6 @@ enum {
>         ND_NSINDEX_INIT = 0x1,
>  };
>
> -static const char NSINDEX_SIGNATURE[] = "NAMESPACE_INDEX\0";
> -
>  /**
>   * struct nd_namespace_index - label set superblock
>   * @sig: NAMESPACE_INDEX\0
> --
> 2.20.1 (Apple Git-117)
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
