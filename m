Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7247126D7A1
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Sep 2020 11:29:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8FD93142AE4C6;
	Thu, 17 Sep 2020 02:29:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8956D142AE4C5
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 02:29:10 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g4so1847872edk.0
        for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HK3YG5YSCVv0t3rk3zTg7zbgjnHmoPLE+KOPPbS1kBc=;
        b=GMEcJ9NNvgVXbDeeYZnABJMhaaupOEmt0Tl1975sHUWj04vWozuE2cTNBtOfEbzuIk
         dMoIeOEyby6OTfp4LIQ+j49fwiioYgP6YJrqQDL63ryMYihp69q7RKdqPa8hUKi/N/uS
         YuLvB9WhBr7uPZCp8AQ5wK9BQA+YX4qyQx4zWGmJbVqxPG0O3twYR/ijbmcP7q+Qs94g
         z9n58lpgF2Ot030MHKXYzAaAz/1v6iBnSAvP+yuyGD5H0aeRJsibPrVfOSurupBndPU7
         8oJYLEMpRBEBE2Y7msVyzjxW+mcTH2fejmT0NrwDXcuRzzzlfJ1Y96q/jNz2+Drlt+Su
         NqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HK3YG5YSCVv0t3rk3zTg7zbgjnHmoPLE+KOPPbS1kBc=;
        b=OyUUEYQco9AlvJRBCCLWxIqQ2fpcoCBYbgK3+RxU/x6zcJ5LOX5oYmF27h4AZPGKDJ
         183YtALUCBFygFnwooPe6lQ+VCZ2DpvK6YPesM6tcDKIYOZcXZqxOkrSgQLhm5T8MoM+
         CuahjZe5yr9sgYJQUHAy6eIW9tGHbvZBoLKfjSs3sGBNu4jkWNYnpbBObW6UWQSBp+Sl
         F/I5vpAmVjadd3P8BXtWUmcuVg0qAh+Eiw76wb1caD9rldoshOthkdW1gZFdeJ3vEaHp
         HS/YKxnUWg6/XNL3Mlh7al91PoXPnzbVGWjHQz1OibtAJZzjGMA5Jt5lxQW3f2bNH1vr
         6DCQ==
X-Gm-Message-State: AOAM5336mQbeqcv06uMN/euEpbDnZONoRg0yXSEy479Ha+zuVyYpAGOu
	1GPgFrMg5D6yG1ODjuhL4VCD3zibD/5c2/GjXKFPRA==
X-Google-Smtp-Source: ABdhPJyFtQLzHUX2Y9EcTt7lK2203uddUXgbaIWtUe6GVn11GZsuKuVEhcPHpdV/ZaR9BCquqVfutlx7SPgli1+LdQk=
X-Received: by 2002:aa7:c148:: with SMTP id r8mr32835886edp.210.1600334948236;
 Thu, 17 Sep 2020 02:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200916151445.450-1-jack@suse.cz>
In-Reply-To: <20200916151445.450-1-jack@suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 17 Sep 2020 02:28:57 -0700
Message-ID: <CAPcyv4gfMY=k+SDsKWPPasZs9X=7schOgc=3VZSDj0kAbZcTTA@mail.gmail.com>
Subject: Re: [PATCH] dm: Call proper helper to determine dax support
To: Jan Kara <jack@suse.cz>
Message-ID-Hash: CWKG2KTLK2IXL54ESEHRMZ3P7CLHGCQR
X-Message-ID-Hash: CWKG2KTLK2IXL54ESEHRMZ3P7CLHGCQR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Adrian Huang <adrianhuang0701@gmail.com>, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CWKG2KTLK2IXL54ESEHRMZ3P7CLHGCQR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 16, 2020 at 8:15 AM Jan Kara <jack@suse.cz> wrote:
>
> DM was calling generic_fsdax_supported() to determine whether a device
> referenced in the DM table supports DAX. However this is a helper for "leaf" device drivers so that
> they don't have to duplicate common generic checks. High level code
> should call dax_supported() helper which that calls into appropriate
> helper for the particular device. This problem manifested itself as
> kernel messages:
>
> dm-3: error: dax access failed (-95)
>
> when lvm2-testsuite run in cases where a DM device was stacked on top of
> another DM device.
>
> Fixes: 7bf7eac8d648 ("dax: Arrange for dax_supported check to span multiple devices")
> Tested-by: Adrian Huang <ahuang12@lenovo.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  drivers/dax/super.c   |  4 ++++
>  drivers/md/dm-table.c |  3 +--
>  include/linux/dax.h   | 11 +++++++++--
>  3 files changed, 14 insertions(+), 4 deletions(-)
>
> This patch should go in together with Adrian's
> https://lore.kernel.org/linux-nvdimm/20200916133923.31-1-adrianhuang0701@gmail.com
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index e5767c83ea23..b6284c5cae0a 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -325,11 +325,15 @@ EXPORT_SYMBOL_GPL(dax_direct_access);
>  bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
>                 int blocksize, sector_t start, sector_t len)
>  {
> +       if (!dax_dev)
> +               return false;
> +

Hi Jan, Thanks for this.

>         if (!dax_alive(dax_dev))
>                 return false;

One small fixup to quiet lockdep because dax_supported() calls
dax_alive() it expects that dax_read_lock() is held. So I'm testing
with this incremental change:

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index bed1ff0744ec..229f461e7def 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -860,9 +860,14 @@ EXPORT_SYMBOL_GPL(dm_table_set_type);
 int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
                        sector_t start, sector_t len, void *data)
 {
-       int blocksize = *(int *) data;
+       int blocksize = *(int *) data, id;
+       bool rc;

-       return dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
+       id = dax_read_lock();
+       rc = dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
+       dax_read_unlock(id);
+
+       return rc;
 }
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
