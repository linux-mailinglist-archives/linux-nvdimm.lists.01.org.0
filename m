Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501AD37630E
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 May 2021 11:47:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 50866100EBB6C;
	Fri,  7 May 2021 02:47:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.41; helo=mail-ot1-f41.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 32E0A100ED4A2
	for <linux-nvdimm@lists.01.org>; Fri,  7 May 2021 02:47:38 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so3435738oto.0
        for <linux-nvdimm@lists.01.org>; Fri, 07 May 2021 02:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1GNd+SmdPBX9J4x9GZDpwE064W8fyTQnbLI8+k9NPaw=;
        b=Fak8EABE4v10DYXFVDsGu8CizX/5B2B423YtZxSl9Q0rvjT/4MLQTPmSXMAVO+xDHS
         2LMq5qWlpNruVp2eJeANz+XrgRwsohSL+P4LxiOC+DaSjop3D1EzWZwrGuBj5Y7h1/5V
         KaTryxx55shz4ZozFQbPW2b54bmgoCk4kKpnfCj0GcaS76XH+kav3PDALzVsh9pUZtzB
         fK66Dvf7fpTv8zFcV4ZIRe/sauBTjdndrGIeLuOZ42FqNsgC8+EYbKtWVg2soodpumgV
         n+A20wZcE6MZIvkF2payYAVQmJfGh00RvlatM/ktgyHEnjq3XrDp32BjfJ1c6B5PDwD0
         zLVQ==
X-Gm-Message-State: AOAM532nIicPpJDFgI8kr+cpiVeurN2do9Tkc1i06Fh2G5iDUEZleNBt
	pzZkS8gdz1Oej8L05UHTJv2chS5K4k5UeOkhTPc=
X-Google-Smtp-Source: ABdhPJxia7qiNpcUZJ4NPD59W/7j1FY+QnvdCAIFCJB7zbze5eLWgq15ivGB6y3WHkXf1FvKyr4kdw2aEYZX9EYZKkQ=
X-Received: by 2002:a9d:5a7:: with SMTP id 36mr7513627otd.321.1620380857294;
 Fri, 07 May 2021 02:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <162037273007.1195827.10907249070709169329.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162037273007.1195827.10907249070709169329.stgit@dwillia2-desk3.amr.corp.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 May 2021 11:47:25 +0200
Message-ID: <CAJZ5v0gBCxFQ1pC1PTRximwzGXOSQDCzOfjX497aqBq5GQ48tA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NFIT: Fix support for variable 'SPA' structure size
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: OONS6RA35QUKLUPPUMUXKH2I52OKUQZD
X-Message-ID-Hash: OONS6RA35QUKLUPPUMUXKH2I52OKUQZD
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Rafael Wysocki <rafael.j.wysocki@intel.com>, Bob Moore <robert.moore@intel.com>, Erik Kaneda <erik.kaneda@intel.com>, Yi Zhang <yi.zhang@redhat.com>, nvdimm@lists.linux.dev, linux-nvdimm <linux-nvdimm@lists.01.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OONS6RA35QUKLUPPUMUXKH2I52OKUQZD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

On Fri, May 7, 2021 at 9:33 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> ACPI 6.4 introduced the "SpaLocationCookie" to the NFIT "System Physical
> Address (SPA) Range Structure". The presence of that new field is
> indicated by the ACPI_NFIT_LOCATION_COOKIE_VALID flag. Pre-ACPI-6.4
> firmware implementations omit the flag and maintain the original size of
> the structure.
>
> Update the implementation to check that flag to determine the size
> rather than the ACPI 6.4 compliant definition of 'struct
> acpi_nfit_system_address' from the Linux ACPICA definitions.
>
> Update the test infrastructure for the new expectations as well, i.e.
> continue to emulate the ACPI 6.3 definition of that structure.
>
> Without this fix the kernel fails to validate 'SPA' structures and this
> leads to a crash in nfit_get_smbios_id() since that routine assumes that
> SPAs are valid if it finds valid SMBIOS tables.
>
>     BUG: unable to handle page fault for address: ffffffffffffffa8
>     [..]
>     Call Trace:
>      skx_get_nvdimm_info+0x56/0x130 [skx_edac]
>      skx_get_dimm_config+0x1f5/0x213 [skx_edac]
>      skx_register_mci+0x132/0x1c0 [skx_edac]
>
> Cc: Bob Moore <robert.moore@intel.com>
> Cc: Erik Kaneda <erik.kaneda@intel.com>
> Fixes: cf16b05c607b ("ACPICA: ACPI 6.4: NFIT: add Location Cookie field")

Do you want me to apply this (as the commit being fixed went in
through the ACPI tree)?

If you'd rather take care of it yourself:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>
> Rafael, I can take this through nvdimm.git after -rc1, but if you are
> sending any fixes to Linus based on your merge baseline between now and
> Monday, please pick up this one.
>
>  drivers/acpi/nfit/core.c         |   15 ++++++++++----
>  tools/testing/nvdimm/test/nfit.c |   42 +++++++++++++++++++++++---------------
>  2 files changed, 36 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 958aaac869e8..23d9a09d7060 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -686,6 +686,13 @@ int nfit_spa_type(struct acpi_nfit_system_address *spa)
>         return -1;
>  }
>
> +static size_t sizeof_spa(struct acpi_nfit_system_address *spa)
> +{
> +       if (spa->flags & ACPI_NFIT_LOCATION_COOKIE_VALID)
> +               return sizeof(*spa);
> +       return sizeof(*spa) - 8;
> +}
> +
>  static bool add_spa(struct acpi_nfit_desc *acpi_desc,
>                 struct nfit_table_prev *prev,
>                 struct acpi_nfit_system_address *spa)
> @@ -693,22 +700,22 @@ static bool add_spa(struct acpi_nfit_desc *acpi_desc,
>         struct device *dev = acpi_desc->dev;
>         struct nfit_spa *nfit_spa;
>
> -       if (spa->header.length != sizeof(*spa))
> +       if (spa->header.length != sizeof_spa(spa))
>                 return false;
>
>         list_for_each_entry(nfit_spa, &prev->spas, list) {
> -               if (memcmp(nfit_spa->spa, spa, sizeof(*spa)) == 0) {
> +               if (memcmp(nfit_spa->spa, spa, sizeof_spa(spa)) == 0) {
>                         list_move_tail(&nfit_spa->list, &acpi_desc->spas);
>                         return true;
>                 }
>         }
>
> -       nfit_spa = devm_kzalloc(dev, sizeof(*nfit_spa) + sizeof(*spa),
> +       nfit_spa = devm_kzalloc(dev, sizeof(*nfit_spa) + sizeof_spa(spa),
>                         GFP_KERNEL);
>         if (!nfit_spa)
>                 return false;
>         INIT_LIST_HEAD(&nfit_spa->list);
> -       memcpy(nfit_spa->spa, spa, sizeof(*spa));
> +       memcpy(nfit_spa->spa, spa, sizeof_spa(spa));
>         list_add_tail(&nfit_spa->list, &acpi_desc->spas);
>         dev_dbg(dev, "spa index: %d type: %s\n",
>                         spa->range_index,
> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index 9b185bf82da8..54f367cbadae 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -1871,9 +1871,16 @@ static void smart_init(struct nfit_test *t)
>         }
>  }
>
> +static size_t sizeof_spa(struct acpi_nfit_system_address *spa)
> +{
> +       /* until spa location cookie support is added... */
> +       return sizeof(*spa) - 8;
> +}
> +
>  static int nfit_test0_alloc(struct nfit_test *t)
>  {
> -       size_t nfit_size = sizeof(struct acpi_nfit_system_address) * NUM_SPA
> +       struct acpi_nfit_system_address *spa = NULL;
> +       size_t nfit_size = sizeof_spa(spa) * NUM_SPA
>                         + sizeof(struct acpi_nfit_memory_map) * NUM_MEM
>                         + sizeof(struct acpi_nfit_control_region) * NUM_DCR
>                         + offsetof(struct acpi_nfit_control_region,
> @@ -1937,7 +1944,8 @@ static int nfit_test0_alloc(struct nfit_test *t)
>
>  static int nfit_test1_alloc(struct nfit_test *t)
>  {
> -       size_t nfit_size = sizeof(struct acpi_nfit_system_address) * 2
> +       struct acpi_nfit_system_address *spa = NULL;
> +       size_t nfit_size = sizeof_spa(spa) * 2
>                 + sizeof(struct acpi_nfit_memory_map) * 2
>                 + offsetof(struct acpi_nfit_control_region, window_size) * 2;
>         int i;
> @@ -2000,7 +2008,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>          */
>         spa = nfit_buf;
>         spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> -       spa->header.length = sizeof(*spa);
> +       spa->header.length = sizeof_spa(spa);
>         memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_PM), 16);
>         spa->range_index = 0+1;
>         spa->address = t->spa_set_dma[0];
> @@ -2014,7 +2022,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>          */
>         spa = nfit_buf + offset;
>         spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> -       spa->header.length = sizeof(*spa);
> +       spa->header.length = sizeof_spa(spa);
>         memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_PM), 16);
>         spa->range_index = 1+1;
>         spa->address = t->spa_set_dma[1];
> @@ -2024,7 +2032,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>         /* spa2 (dcr0) dimm0 */
>         spa = nfit_buf + offset;
>         spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> -       spa->header.length = sizeof(*spa);
> +       spa->header.length = sizeof_spa(spa);
>         memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_DCR), 16);
>         spa->range_index = 2+1;
>         spa->address = t->dcr_dma[0];
> @@ -2034,7 +2042,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>         /* spa3 (dcr1) dimm1 */
>         spa = nfit_buf + offset;
>         spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> -       spa->header.length = sizeof(*spa);
> +       spa->header.length = sizeof_spa(spa);
>         memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_DCR), 16);
>         spa->range_index = 3+1;
>         spa->address = t->dcr_dma[1];
> @@ -2044,7 +2052,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>         /* spa4 (dcr2) dimm2 */
>         spa = nfit_buf + offset;
>         spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> -       spa->header.length = sizeof(*spa);
> +       spa->header.length = sizeof_spa(spa);
>         memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_DCR), 16);
>         spa->range_index = 4+1;
>         spa->address = t->dcr_dma[2];
> @@ -2054,7 +2062,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>         /* spa5 (dcr3) dimm3 */
>         spa = nfit_buf + offset;
>         spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> -       spa->header.length = sizeof(*spa);
> +       spa->header.length = sizeof_spa(spa);
>         memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_DCR), 16);
>         spa->range_index = 5+1;
>         spa->address = t->dcr_dma[3];
> @@ -2064,7 +2072,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>         /* spa6 (bdw for dcr0) dimm0 */
>         spa = nfit_buf + offset;
>         spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> -       spa->header.length = sizeof(*spa);
> +       spa->header.length = sizeof_spa(spa);
>         memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_BDW), 16);
>         spa->range_index = 6+1;
>         spa->address = t->dimm_dma[0];
> @@ -2074,7 +2082,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>         /* spa7 (bdw for dcr1) dimm1 */
>         spa = nfit_buf + offset;
>         spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> -       spa->header.length = sizeof(*spa);
> +       spa->header.length = sizeof_spa(spa);
>         memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_BDW), 16);
>         spa->range_index = 7+1;
>         spa->address = t->dimm_dma[1];
> @@ -2084,7 +2092,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>         /* spa8 (bdw for dcr2) dimm2 */
>         spa = nfit_buf + offset;
>         spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> -       spa->header.length = sizeof(*spa);
> +       spa->header.length = sizeof_spa(spa);
>         memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_BDW), 16);
>         spa->range_index = 8+1;
>         spa->address = t->dimm_dma[2];
> @@ -2094,7 +2102,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>         /* spa9 (bdw for dcr3) dimm3 */
>         spa = nfit_buf + offset;
>         spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> -       spa->header.length = sizeof(*spa);
> +       spa->header.length = sizeof_spa(spa);
>         memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_BDW), 16);
>         spa->range_index = 9+1;
>         spa->address = t->dimm_dma[3];
> @@ -2581,7 +2589,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>                 /* spa10 (dcr4) dimm4 */
>                 spa = nfit_buf + offset;
>                 spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> -               spa->header.length = sizeof(*spa);
> +               spa->header.length = sizeof_spa(spa);
>                 memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_DCR), 16);
>                 spa->range_index = 10+1;
>                 spa->address = t->dcr_dma[4];
> @@ -2595,7 +2603,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>                  */
>                 spa = nfit_buf + offset;
>                 spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> -               spa->header.length = sizeof(*spa);
> +               spa->header.length = sizeof_spa(spa);
>                 memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_PM), 16);
>                 spa->range_index = 11+1;
>                 spa->address = t->spa_set_dma[2];
> @@ -2605,7 +2613,7 @@ static void nfit_test0_setup(struct nfit_test *t)
>                 /* spa12 (bdw for dcr4) dimm4 */
>                 spa = nfit_buf + offset;
>                 spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> -               spa->header.length = sizeof(*spa);
> +               spa->header.length = sizeof_spa(spa);
>                 memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_BDW), 16);
>                 spa->range_index = 12+1;
>                 spa->address = t->dimm_dma[4];
> @@ -2739,7 +2747,7 @@ static void nfit_test1_setup(struct nfit_test *t)
>         /* spa0 (flat range with no bdw aliasing) */
>         spa = nfit_buf + offset;
>         spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> -       spa->header.length = sizeof(*spa);
> +       spa->header.length = sizeof_spa(spa);
>         memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_PM), 16);
>         spa->range_index = 0+1;
>         spa->address = t->spa_set_dma[0];
> @@ -2749,7 +2757,7 @@ static void nfit_test1_setup(struct nfit_test *t)
>         /* virtual cd region */
>         spa = nfit_buf + offset;
>         spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
> -       spa->header.length = sizeof(*spa);
> +       spa->header.length = sizeof_spa(spa);
>         memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_VCD), 16);
>         spa->range_index = 0;
>         spa->address = t->spa_set_dma[1];
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
