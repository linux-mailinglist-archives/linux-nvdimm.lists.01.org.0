Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16ABA78B3
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Sep 2019 04:21:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0670020216B84;
	Tue,  3 Sep 2019 19:22:10 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5EE5320215F6B
 for <linux-nvdimm@lists.01.org>; Tue,  3 Sep 2019 19:22:08 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id v12so14583772oic.12
 for <linux-nvdimm@lists.01.org>; Tue, 03 Sep 2019 19:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w2624jAZz55IIaXPqI/LtDESgbui6+6sOKGlAVtaJ5c=;
 b=xaVGtW2e7g9t2NxcJatQIsz2sGVJp8bNBbJ+TnkhJclCYj32u6D8bW8QbzmRuIq8hx
 ypINBoemi5fRE3YEIDK69jEFg2KhAs94ZMxI3K8ySpRH7U04rNQ5cWDU/rZnTmocRHmv
 tRuZxTJzAjaiDQ4kiiihYtZ2Fi5NUuhHRGNJmJgPlVMLh+ho8jx+YXRvB49sdK5i6Dsp
 aSlcZqen1I1pvsk7ZS9+GzflZifMIz78CIdh8Afc5kDg759/lP+ZxT2JjmmnaX4KkF4i
 zGLkpPS1SVw1ZTKIKwaq2cJYSv33b2LKpOFHATTizfUR2qRd3wrVI0wk2GyeYNdStnVi
 1Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w2624jAZz55IIaXPqI/LtDESgbui6+6sOKGlAVtaJ5c=;
 b=VG3RNT7PdojXiupOPwrzflCy9B7HtqfcC99v+8PLW/wxIqZO5NEkQdxyalbC/3QkNz
 NsTuUKCRhn4dPm8tRWRx1+5ED251zEH0jpj74eijlfpZGuhh+LVFSb9ZtGXUQL65JWcD
 d0pRtE28GdYRdGun3GchImnSdax1TcRWXPnlhibQz3N3od4VVZ37R3HsNq0iu5gooqUK
 puIODICziwctxvO2PnEtFjt6+x9G0ZwH4ia5yRo6BCJyTrDaTuON59CzHlTWXS/Vu0se
 2S8Ok/6U8WRBSJ4U5zaVNJ+rjwZQLzwIgMK1L2cA66NGtYOSPQZyxk19DoACbmlVj1eS
 lH1w==
X-Gm-Message-State: APjAAAWpFCFwWMFRKiR4Dr1JGDNIaR4FnnTIwAyDDNU1h7Pdobo1NvLm
 7GmZrRspm4Y/kEiLo1cG2EPjhvrgXB5br1aHgVMmHler5Rw=
X-Google-Smtp-Source: APXvYqyn/8+Gw35YZEIsWKOpUcrzPR7cibbC4ocKVbvzPXvO6coKbDVyPy8uZTMSOos6hx/6mW0dJY4vRgQRlP7VY2k=
X-Received: by 2002:aca:d707:: with SMTP id o7mr1797324oig.105.1567563658477; 
 Tue, 03 Sep 2019 19:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190904010819.11012-1-vishal.l.verma@intel.com>
 <20190904010819.11012-2-vishal.l.verma@intel.com>
In-Reply-To: <20190904010819.11012-2-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 3 Sep 2019 19:20:47 -0700
Message-ID: <CAPcyv4ipdLhKSUVZ-U3ZFpcuw=tJJTq1ZW5x6vJ-bJNReyjJbQ@mail.gmail.com>
Subject: Re: [ndctl PATCH 2/2] libdaxctl: fix device reconfiguration with
 builtin drivers
To: Vishal Verma <vishal.l.verma@intel.com>
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
Cc: Brice Goglin <Brice.Goglin@inria.fr>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Sep 3, 2019 at 6:08 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> When the driver of a given reconfiguration mode is builtin, libdaxctl
> isn't able to build a module lookup list using kmod. However, it doesn't
> need to fail in this case, as it is acceptable for a driver to be
> builtin.
>
> Use the kmod 'initstate' to determine whether the target driver may be
> builtin, and ensure it is available by probing it via a named lookup.
> If it is available, skip the modalias based list walk, and bind to it
> directly.
>
> Link: https://github.com/pmem/ndctl/issues/108
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
> Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  daxctl/lib/libdaxctl.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
> index d9f2c33..7a65bed 100644
> --- a/daxctl/lib/libdaxctl.c
> +++ b/daxctl/lib/libdaxctl.c
> @@ -868,6 +868,37 @@ DAXCTL_EXPORT int daxctl_dev_is_enabled(struct daxctl_dev *dev)
>         return is_enabled(path);
>  }
>
> +static int try_kmod_builtin(struct daxctl_dev *dev, const char *mod_name)
> +{
> +       const char *devname = daxctl_dev_get_devname(dev);
> +       struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
> +       struct kmod_module *kmod;
> +       int rc = -ENXIO;
> +
> +       rc = kmod_module_new_from_name(ctx->kmod_ctx, mod_name, &kmod);
> +       if (rc < 0) {
> +               err(ctx, "%s: failed getting module for: %s: %s\n",
> +                       devname, mod_name, strerror(-rc));
> +               return rc;
> +       }
> +
> +       if (kmod_module_get_initstate(kmod) != KMOD_MODULE_BUILTIN)
> +               return -ENXIO;
> +
> +       dbg(ctx, "%s inserting module: %s\n", devname,
> +               kmod_module_get_name(kmod));
> +       rc = kmod_module_probe_insert_module(kmod,
> +                       KMOD_PROBE_APPLY_BLACKLIST,
> +                       NULL, NULL, NULL, NULL);
> +       if (rc < 0) {
> +               err(ctx, "%s: insert failure: %d\n", devname, rc);
> +               return rc;
> +       }
> +       dev->module = kmod;
> +
> +       return 0;
> +}
> +
>  static int daxctl_insert_kmod_for_mode(struct daxctl_dev *dev,
>                 const char *mod_name)
>  {
> @@ -877,6 +908,8 @@ static int daxctl_insert_kmod_for_mode(struct daxctl_dev *dev,
>         int rc = -ENXIO;
>
>         if (dev->kmod_list == NULL) {

Hmm, why wait until now to check if this list is NULL. How about fall
back to kmod_module_new_from_name() at to_module_list() time? That
would seem to simplify this follow up routine to not need to worry
about working around a NULL list.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
