Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B3B19DE23
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 20:42:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7918610FC6507;
	Fri,  3 Apr 2020 11:42:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9866A10FC42E3
	for <linux-nvdimm@lists.01.org>; Fri,  3 Apr 2020 11:42:50 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id v1so10432880edq.8
        for <linux-nvdimm@lists.01.org>; Fri, 03 Apr 2020 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYC45MLhB3vURRUt6enJUIk+QpW2NBAyxpSkjB8Uw5s=;
        b=rb3tyTzJJx7pw7mLbJi7Ts+pr2xrCZ2nUBV7tb7EWmOvjI4OVJf9kjPllcsJBKLGKE
         uIeCTHQkPvdE0crP/dZwIqMJ2R6iQVX4QjCHXslaf6kxjtlOx9pohxvF5xtqOPRvhMu5
         V/SsohtWmFiBvKvgUar8bCbHdTYpzfnj51dHLX3kIXXcHaTcn7RmY3G/tgsT+U0dkUa6
         F3UrEb9qYOQTCRtwqHX5gjNM0a2wCg4JnnVbwdLQzyhl1YeMSUJFBJ7KRP2XSZfNSiJa
         4E/eOZxHlpiZoXnJsrG4rljP591GhT+Fve0/vT2OQg0/y1yM3cn+IjrqVnvOCpAPv0T1
         sGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYC45MLhB3vURRUt6enJUIk+QpW2NBAyxpSkjB8Uw5s=;
        b=AoOVLP0JEYQz/aMY1NGskFY9DvVIgOl+HNd/MikAjZ0WgFnAZqGKytitLZMXq8DyMw
         GWv45PThqRvItndprDq/EY2+mKeyM+MZrXX88C4lg98T0GWnWQwCmlFAiQGwAbu7W44H
         6jsvL/IEHVvjkp6fcei7vmY3wmVm8ByHYMAbU5gRz5X4xnJzRRfbVBZip6GekkaV1C0P
         Gum/tlE4tXQMUcCflPVu69S2qG9eIf5vWc7bVwW6xFRPIwqfidwbn0Pr5trXnqpmoWse
         5DbwLT90cwB3SmfcUVGqbQ7RS+O4GJnTuFgrMUCd3rgJjwVYdzeJ3Ctud6I9OKJdRTRs
         o/hA==
X-Gm-Message-State: AGi0PuakV3icw2Ke3cMeNit0b9r+9sL1wGsyWUb75ZQxAkGZrMtRdE1E
	RtYwFQHwynfOFJbdA2538+lDlGISgNoN96usAvpcsg==
X-Google-Smtp-Source: APiQypJRKgJkQBQCJPc4a3V6spAdkP6MXH9paG7MS1tkUcN3pt1TECdP1FAk+erCjjOeNeSxl9lDpjZ+soSZ+wxRXZk=
X-Received: by 2002:a17:906:1e8a:: with SMTP id e10mr10077338ejj.56.1585939318934;
 Fri, 03 Apr 2020 11:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200331143229.306718-1-vaibhav@linux.ibm.com> <20200331143229.306718-5-vaibhav@linux.ibm.com>
In-Reply-To: <20200331143229.306718-5-vaibhav@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 3 Apr 2020 11:41:47 -0700
Message-ID: <CAPcyv4gnrp1NCAvbsa=DN+VrWFPcGm6WNO8-CahaJDPHpEafSg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] powerpc/papr_scm: Implement support for DSM_PAPR_SCM_HEALTH
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID-Hash: 2W6VFDL4G5O6WWLEOAUFWMSJFZMXV7DK
X-Message-ID-Hash: 2W6VFDL4G5O6WWLEOAUFWMSJFZMXV7DK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <ellerman@au1.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2W6VFDL4G5O6WWLEOAUFWMSJFZMXV7DK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 31, 2020 at 7:33 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> This patch implements support for papr_scm command
> 'DSM_PAPR_SCM_HEALTH' that returns a newly introduced 'struct
> nd_papr_scm_dimm_health_stat' instance containing dimm health
> information back to user space in response to ND_CMD_CALL. This
> functionality is implemented in newly introduced papr_scm_get_health()
> that queries the scm-dimm health information and then copies these bitmaps
> to the package payload whose layout is defined by 'struct
> papr_scm_ndctl_health'.
>
> The patch also introduces a new member a new member 'struct
> papr_scm_priv.health' thats an instance of 'struct
> nd_papr_scm_dimm_health_stat' to cache the health information of a
> scm-dimm. As a result functions drc_pmem_query_health() and
> papr_flags_show() are updated to populate and use this new struct
> instead of two be64 integers that we earlier used.

Link to HCALL specification?

>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
>
> v4..v5: None
>
> v3..v4: Call the DSM_PAPR_SCM_HEALTH service function from
>         papr_scm_service_dsm() instead of papr_scm_ndctl(). [Aneesh]
>
> v2..v3: Updated struct nd_papr_scm_dimm_health_stat_v1 to use '__xx'
>         types as its exported to the userspace [Aneesh]
>         Changed the constants DSM_PAPR_SCM_DIMM_XX indicating dimm
>         health from enum to #defines [Aneesh]
>
> v1..v2: New patch in the series
> ---
>  arch/powerpc/include/uapi/asm/papr_scm_dsm.h |  40 +++++++
>  arch/powerpc/platforms/pseries/papr_scm.c    | 109 ++++++++++++++++---
>  2 files changed, 132 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/include/uapi/asm/papr_scm_dsm.h b/arch/powerpc/include/uapi/asm/papr_scm_dsm.h
> index c039a49b41b4..8265125304ca 100644
> --- a/arch/powerpc/include/uapi/asm/papr_scm_dsm.h
> +++ b/arch/powerpc/include/uapi/asm/papr_scm_dsm.h
> @@ -132,6 +132,7 @@ struct nd_papr_scm_cmd_pkg {
>   */
>  enum dsm_papr_scm {
>         DSM_PAPR_SCM_MIN =  0x10000,
> +       DSM_PAPR_SCM_HEALTH,
>         DSM_PAPR_SCM_MAX,
>  };
>
> @@ -158,4 +159,43 @@ static void *papr_scm_pcmd_to_payload(struct nd_papr_scm_cmd_pkg *pcmd)
>         else
>                 return (void *)((__u8 *) pcmd + pcmd->payload_offset);
>  }
> +
> +/* Various scm-dimm health indicators */
> +#define DSM_PAPR_SCM_DIMM_HEALTHY       0
> +#define DSM_PAPR_SCM_DIMM_UNHEALTHY     1
> +#define DSM_PAPR_SCM_DIMM_CRITICAL      2
> +#define DSM_PAPR_SCM_DIMM_FATAL         3
> +
> +/*
> + * Struct exchanged between kernel & ndctl in for PAPR_DSM_PAPR_SMART_HEALTH
> + * Various bitflags indicate the health status of the dimm.
> + *
> + * dimm_unarmed                : Dimm not armed. So contents wont persist.
> + * dimm_bad_shutdown   : Previous shutdown did not persist contents.
> + * dimm_bad_restore    : Contents from previous shutdown werent restored.
> + * dimm_scrubbed       : Contents of the dimm have been scrubbed.
> + * dimm_locked         : Contents of the dimm cant be modified until CEC reboot
> + * dimm_encrypted      : Contents of dimm are encrypted.
> + * dimm_health         : Dimm health indicator.
> + */
> +struct nd_papr_scm_dimm_health_stat_v1 {
> +       __u8 dimm_unarmed;
> +       __u8 dimm_bad_shutdown;
> +       __u8 dimm_bad_restore;
> +       __u8 dimm_scrubbed;
> +       __u8 dimm_locked;
> +       __u8 dimm_encrypted;
> +       __u16 dimm_health;
> +};

Does the structure pack the same across different compilers and configurations?

> +
> +/*
> + * Typedef the current struct for dimm_health so that any application
> + * or kernel recompiled after introducing a new version automatically
> + * supports the new version.
> + */
> +#define nd_papr_scm_dimm_health_stat nd_papr_scm_dimm_health_stat_v1
> +
> +/* Current version number for the dimm health struct */
> +#define ND_PAPR_SCM_DIMM_HEALTH_VERSION 1
> +
>  #endif /* _UAPI_ASM_POWERPC_PAPR_SCM_DSM_H_ */
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index e8ce96d2249e..ce94762954e0 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -47,8 +47,7 @@ struct papr_scm_priv {
>         struct mutex dimm_mutex;
>
>         /* Health information for the dimm */
> -       __be64 health_bitmap;
> -       __be64 health_bitmap_valid;
> +       struct nd_papr_scm_dimm_health_stat health;
>  };
>
>  static int drc_pmem_bind(struct papr_scm_priv *p)
> @@ -158,6 +157,7 @@ static int drc_pmem_query_health(struct papr_scm_priv *p)
>  {
>         unsigned long ret[PLPAR_HCALL_BUFSIZE];
>         int64_t rc;
> +       __be64 health;
>
>         rc = plpar_hcall(H_SCM_HEALTH, ret, p->drc_index);
>         if (rc != H_SUCCESS) {
> @@ -172,13 +172,41 @@ static int drc_pmem_query_health(struct papr_scm_priv *p)
>                 return rc;
>
>         /* Store the retrieved health information in dimm platform data */
> -       p->health_bitmap = ret[0];
> -       p->health_bitmap_valid = ret[1];
> +       health = ret[0] & ret[1];
>
>         dev_dbg(&p->pdev->dev,
>                 "Queried dimm health info. Bitmap:0x%016llx Mask:0x%016llx\n",
> -               be64_to_cpu(p->health_bitmap),
> -               be64_to_cpu(p->health_bitmap_valid));
> +               be64_to_cpu(ret[0]),
> +               be64_to_cpu(ret[1]));
> +
> +       memset(&p->health, 0, sizeof(p->health));
> +
> +       /* Check for various masks in bitmap and set the buffer */
> +       if (health & PAPR_SCM_DIMM_UNARMED_MASK)
> +               p->health.dimm_unarmed = true;
> +
> +       if (health & PAPR_SCM_DIMM_BAD_SHUTDOWN_MASK)
> +               p->health.dimm_bad_shutdown = true;
> +
> +       if (health & PAPR_SCM_DIMM_BAD_RESTORE_MASK)
> +               p->health.dimm_bad_restore = true;
> +
> +       if (health & PAPR_SCM_DIMM_ENCRYPTED)
> +               p->health.dimm_encrypted = true;
> +
> +       if (health & PAPR_SCM_DIMM_SCRUBBED_AND_LOCKED) {
> +               p->health.dimm_locked = true;
> +               p->health.dimm_scrubbed = true;
> +       }

I don't think bool is suitable for ioctl ABI. For example the true
value may be positive, or negative depending on the arch. This should
be using explicit integer values.

I assume the reason you are translating this rather than transmitting
that raw 64-bit health value is for future compatibility if the HCALL
format changes / is extended?

> +
> +       if (health & PAPR_SCM_DIMM_HEALTH_UNHEALTHY)
> +               p->health.dimm_health = DSM_PAPR_SCM_DIMM_UNHEALTHY;
> +
> +       if (health & PAPR_SCM_DIMM_HEALTH_CRITICAL)
> +               p->health.dimm_health = DSM_PAPR_SCM_DIMM_CRITICAL;
> +
> +       if (health & PAPR_SCM_DIMM_HEALTH_FATAL)
> +               p->health.dimm_health = DSM_PAPR_SCM_DIMM_FATAL;

>
>         mutex_unlock(&p->dimm_mutex);
>         return 0;
> @@ -331,6 +359,51 @@ static int is_cmd_valid(struct nvdimm *nvdimm, unsigned int cmd, void *buf,
>         return 0;
>  }
>
> +/* Fetch the DIMM health info and populate it in provided package. */
> +static int papr_scm_get_health(struct papr_scm_priv *p,
> +                              struct nd_papr_scm_cmd_pkg *pkg)
> +{
> +       int rc;
> +       size_t copysize = sizeof(p->health);
> +
> +       rc = drc_pmem_query_health(p);
> +       if (rc)
> +               goto out;
> +       /*
> +        * If the requested payload version is greater than one we know
> +        * about, return the payload version we know about and let
> +        * caller/userspace handle.
> +        */
> +       if (pkg->payload_version > ND_PAPR_SCM_DIMM_HEALTH_VERSION)
> +               pkg->payload_version = ND_PAPR_SCM_DIMM_HEALTH_VERSION;
> +
> +       if (pkg->hdr.nd_size_out < copysize) {
> +               dev_dbg(&p->pdev->dev, "%s Payload not large enough\n",
> +                       __func__);
> +               dev_dbg(&p->pdev->dev, "%s Expected %lu, available %u\n",
> +                       __func__, copysize, pkg->hdr.nd_size_out);
> +               rc = -ENOSPC;
> +               goto out;
> +       }
> +
> +       dev_dbg(&p->pdev->dev, "%s Copying payload size=%lu version=0x%x\n",
> +               __func__, copysize, pkg->payload_version);
> +
> +       /* Copy a subset of health struct based on copysize */
> +       memcpy(papr_scm_pcmd_to_payload(pkg), &p->health, copysize);
> +       pkg->hdr.nd_fw_size = copysize;
> +
> +out:
> +       /*
> +        * Put the error in out package and return success from function
> +        * so that errors if any are propogated back to userspace.
> +        */
> +       pkg->cmd_status = rc;
> +       dev_dbg(&p->pdev->dev, "%s completion code = %d\n", __func__, rc);
> +
> +       return 0;
> +}
> +
>  static int papr_scm_service_dsm(struct papr_scm_priv *p,
>                                 struct nd_papr_scm_cmd_pkg *call_pkg)
>  {
> @@ -345,6 +418,9 @@ static int papr_scm_service_dsm(struct papr_scm_priv *p,
>
>         /* Depending on the DSM command call appropriate service routine */
>         switch (call_pkg->hdr.nd_command) {
> +       case DSM_PAPR_SCM_HEALTH:
> +               return papr_scm_get_health(p, call_pkg);
> +
>         default:
>                 pr_debug("Unsupported DSM command 0x%llx\n",
>                          call_pkg->hdr.nd_command);
> @@ -431,7 +507,6 @@ static ssize_t papr_flags_show(struct device *dev,
>  {
>         struct nvdimm *dimm = to_nvdimm(dev);
>         struct papr_scm_priv *p = nvdimm_provider_data(dimm);
> -       __be64 health;
>         int rc;
>
>         rc = drc_pmem_query_health(p);
> @@ -443,26 +518,26 @@ static ssize_t papr_flags_show(struct device *dev,
>         if (rc)
>                 return rc;
>
> -       health = p->health_bitmap & p->health_bitmap_valid;
> -
> -       /* Check for various masks in bitmap and set the buffer */
> -       if (health & PAPR_SCM_DIMM_UNARMED_MASK)
> +       if (p->health.dimm_unarmed)
>                 rc += sprintf(buf, "not_armed ");
>
> -       if (health & PAPR_SCM_DIMM_BAD_SHUTDOWN_MASK)
> +       if (p->health.dimm_bad_shutdown)
>                 rc += sprintf(buf + rc, "save_fail ");

Per my patch1 comment is this "save_fail" or "flush_fail"?

>
> -       if (health & PAPR_SCM_DIMM_BAD_RESTORE_MASK)
> +       if (p->health.dimm_bad_restore)
>                 rc += sprintf(buf + rc, "restore_fail ");
>
> -       if (health & PAPR_SCM_DIMM_ENCRYPTED)
> +       if (p->health.dimm_encrypted)
>                 rc += sprintf(buf + rc, "encrypted ");
>
> -       if (health & PAPR_SCM_DIMM_SMART_EVENT_MASK)
> +       if (p->health.dimm_health)
>                 rc += sprintf(buf + rc, "smart_notify ");
>
> -       if (health & PAPR_SCM_DIMM_SCRUBBED_AND_LOCKED)
> -               rc += sprintf(buf + rc, "scrubbed locked ");
> +       if (p->health.dimm_scrubbed)
> +               rc += sprintf(buf + rc, "scrubbed ");
> +
> +       if (p->health.dimm_locked)
> +               rc += sprintf(buf + rc, "locked ");
>
>         if (rc > 0)
>                 rc += sprintf(buf + rc, "\n");
> --
> 2.25.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
