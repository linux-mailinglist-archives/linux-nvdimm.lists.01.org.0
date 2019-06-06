Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9AF37A66
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Jun 2019 19:00:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1801C2128DD4E;
	Thu,  6 Jun 2019 10:00:18 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 11906212741F2
 for <linux-nvdimm@lists.01.org>; Thu,  6 Jun 2019 10:00:15 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 107so2618834otj.8
 for <linux-nvdimm@lists.01.org>; Thu, 06 Jun 2019 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fOF2v+nii6PCUScBH269ysq3FqQJUmeziCAupnZ/plI=;
 b=zgBUrZQERHJ0MwQl+9FEdnHVVraNTSvb2k3lMY3iiqKucZlLjPHCM+OenSOkFF6kkp
 +Fynlc0xZFRq73pL+3H0h/6jhWSwK7czgWoshBCvVHwBeUP+IyLezPCip4VFFUEkoshx
 gGnARnf9HYWaR0ClnvSV2bMFgQqTYbplAcjUdD0XmsffXdyvMFdqpXAqbFntO2CO7Ffh
 8kSk2jVsx5dmUtYboJmE/WXMUZ3AMpp/RZJgcWzJ1UBuWadIPMyBblU8rqvcbKn507qT
 8xubU38/uqOIKN2p1NZglv7xwG7hS0Ak/fTxhdCArMXR+Sp4OZroxY+xjmhPrJkBsEpn
 y7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fOF2v+nii6PCUScBH269ysq3FqQJUmeziCAupnZ/plI=;
 b=AooQNjbJeiiW0vMXEQL7ug15vFh6jlRU383k6LMZin2TfGNr35mq/GfJ/0pSv2V0jI
 DcrjX/4sVV90M2iD0PKSUph0zOGLSRCWJtCgNGHjA5f0ObR2uCJTstS5K/GOBQxYZZIk
 AprKtGSfuGPwp8sTBSq2USHHHkCWktIkPUDpaVOJJgbNHwdtoh3DqvqrbMFYSuVhUf0z
 s3N18Dv09d664DN48O6dm7iHUrP5rKt3R+Md5fKmUEPZoJv/qBVf+ozG46ljN3F6F7aC
 eihqiCLy/tXXGGSuAMyOZCGlZi2h2CbJZIGXqSBy21nmNkswmrHEKbZ32xgKtMI538tM
 LWJQ==
X-Gm-Message-State: APjAAAUKw7/tFKcZNo3a3QPGwd15g3jiLRij1OYpJncMDkPceuGojxVi
 ACYWpkiy/OUg6DOXa3DzJTaIdFrnjBQitG0ry1AP6g==
X-Google-Smtp-Source: APXvYqw9oulwXBGmnjNFJzOiIPlf4TLGSj5wNxUI+ZF1trLskZ3MD0rzqMuYZS1eaSFxY4PMZFWyS6MR986IxHSbL5w=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr10998391otn.71.1559840413685; 
 Thu, 06 Jun 2019 10:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190606091028.31715-1-jack@suse.cz>
In-Reply-To: <20190606091028.31715-1-jack@suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 6 Jun 2019 10:00:01 -0700
Message-ID: <CAPcyv4jxBoDUyuEFjY=1TcN_8ufjM8tqF1Yj0AN=xHfQ0NpdDQ@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix xarray entry association for mixed mappings
To: Jan Kara <jack@suse.cz>
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
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Goldwyn Rodrigues <rgoldwyn@suse.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 6, 2019 at 2:10 AM Jan Kara <jack@suse.cz> wrote:
>
> When inserting entry into xarray, we store mapping and index in
> corresponding struct pages for memory error handling. When it happened
> that one process was mapping file at PMD granularity while another
> process at PTE granularity, we could wrongly deassociate PMD range and
> then reassociate PTE range leaving the rest of struct pages in PMD range
> without mapping information which could later cause missed notifications
> about memory errors. Fix the problem by calling the association /
> deassociation code if and only if we are really going to update the
> xarray (deassociating and associating zero or empty entries is just
> no-op so there's no reason to complicate the code with trying to avoid
> the calls for these cases).

Looks good to me, I assume this also needs:

Cc: <stable@vger.kernel.org>
Fixes: d2c997c0f145 ("fs, dax: use page->mapping to warn if truncate
collides with a busy page")

>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/dax.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index f74386293632..9fd908f3df32 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -728,12 +728,11 @@ static void *dax_insert_entry(struct xa_state *xas,
>
>         xas_reset(xas);
>         xas_lock_irq(xas);
> -       if (dax_entry_size(entry) != dax_entry_size(new_entry)) {
> +       if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> +               void *old;
> +
>                 dax_disassociate_entry(entry, mapping, false);
>                 dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
> -       }
> -
> -       if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
>                 /*
>                  * Only swap our new entry into the page cache if the current
>                  * entry is a zero page or an empty entry.  If a normal PTE or
> @@ -742,7 +741,7 @@ static void *dax_insert_entry(struct xa_state *xas,
>                  * existing entry is a PMD, we will just leave the PMD in the
>                  * tree and dirty it if necessary.
>                  */
> -               void *old = dax_lock_entry(xas, new_entry);
> +               old = dax_lock_entry(xas, new_entry);
>                 WARN_ON_ONCE(old != xa_mk_value(xa_to_value(entry) |
>                                         DAX_LOCKED));
>                 entry = new_entry;
> --
> 2.16.4
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
