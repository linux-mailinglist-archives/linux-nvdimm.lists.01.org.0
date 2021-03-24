Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0398346FEA
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Mar 2021 04:09:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E8C23100EB33A;
	Tue, 23 Mar 2021 20:09:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.11.71.1; helo=ozlabs.org; envelope-from=dgibson@ozlabs.org; receiver=<UNKNOWN> 
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5BA70100EB33A
	for <linux-nvdimm@lists.01.org>; Tue, 23 Mar 2021 20:09:43 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4F4tWT1F9mz9sWf; Wed, 24 Mar 2021 14:09:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1616555381;
	bh=VpEzj9rOBlbpm8ECwAx8a75XorGR0+faxne+7Vj1nxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i29CT5EAcXkU+BGsd9+Tc/+NVepUZvfABCO3QC7ziPRHBpJmffWDZPcFIbcmKGoL+
	 IsPcJhhLP4yBKed3T4iai5dGyA1nkA/BqtP/y2vXndHgbhMNvueFvinAJIWUKLkN1G
	 /q5MnoRHgvqRl7ig9mRmVnLs/7vbxvMtekR/uehU=
Date: Wed, 24 Mar 2021 14:09:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] spapr: nvdimm: Enable sync-dax device property
 for nvdimm
Message-ID: <YFqtZv6Bt/oiAF6C@yekko.fritz.box>
References: <161650723087.2959.8703728357980727008.stgit@6532096d84d3>
 <161650726635.2959.677683611241665210.stgit@6532096d84d3>
MIME-Version: 1.0
In-Reply-To: <161650726635.2959.677683611241665210.stgit@6532096d84d3>
Message-ID-Hash: ZO437NNQBKVIBS3XFXYR5FRMBHYXTHPI
X-Message-ID-Hash: ZO437NNQBKVIBS3XFXYR5FRMBHYXTHPI
X-MailFrom: dgibson@ozlabs.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: sbhat@linux.vnet.ibm.com, groug@kaod.org, qemu-ppc@nongnu.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, qemu-devel@nongnu.org, aneesh.kumar@linux.ibm.com, linux-nvdimm@lists.01.org, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZO437NNQBKVIBS3XFXYR5FRMBHYXTHPI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============6349414831572935187=="


--===============6349414831572935187==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QQAdSkgBj1kGtrk3"
Content-Disposition: inline


--QQAdSkgBj1kGtrk3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 23, 2021 at 09:47:55AM -0400, Shivaprasad G Bhat wrote:
> The patch adds the 'sync-dax' property to the nvdimm device.
>=20
> When the sync-dax is 'off', the device tree property
> "hcall-flush-required" is added to the nvdimm node which makes the
> guest to issue H_SCM_FLUSH hcalls to request for flushes explicitly.
> This would be the default behaviour without sync-dax property set
> for the nvdimm device.
>=20
> The sync-dax=3D"on" would mean the guest need not make flush requests
> to the qemu. On previous machine versions the sync-dax is set to be
> "on" by default using the hw_compat magic.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  hw/core/machine.c       |    1 +
>  hw/mem/nvdimm.c         |    1 +
>  hw/ppc/spapr_nvdimm.c   |   17 +++++++++++++++++
>  include/hw/mem/nvdimm.h |   10 ++++++++++
>  include/hw/ppc/spapr.h  |    1 +
>  5 files changed, 30 insertions(+)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 257a664ea2..f843643574 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,6 +41,7 @@ GlobalProperty hw_compat_5_2[] =3D {
>      { "PIIX4_PM", "smm-compat", "on"},
>      { "virtio-blk-device", "report-discard-granularity", "off" },
>      { "virtio-net-pci", "vectors", "3"},
> +    { "nvdimm", "sync-dax", "on" },
>  };
>  const size_t hw_compat_5_2_len =3D G_N_ELEMENTS(hw_compat_5_2);
> =20
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 7397b67156..8f0e29b191 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -229,6 +229,7 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvd=
imm, const void *buf,
> =20
>  static Property nvdimm_properties[] =3D {
>      DEFINE_PROP_BOOL(NVDIMM_UNARMED_PROP, NVDIMMDevice, unarmed, false),
> +    DEFINE_PROP_BOOL(NVDIMM_SYNC_DAX_PROP, NVDIMMDevice, sync_dax, false=
),

I'm a bit uncomfortable adding this base NVDIMM property without at
least some logic about how it's handled on non-PAPR platforms.

>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> index 883317c1ed..dd1c90251b 100644
> --- a/hw/ppc/spapr_nvdimm.c
> +++ b/hw/ppc/spapr_nvdimm.c
> @@ -125,6 +125,9 @@ static int spapr_dt_nvdimm(SpaprMachineState *spapr, =
void *fdt,
>      uint64_t lsize =3D nvdimm->label_size;
>      uint64_t size =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_SI=
ZE_PROP,
>                                              NULL);
> +    bool sync_dax =3D object_property_get_bool(OBJECT(nvdimm),
> +                                             NVDIMM_SYNC_DAX_PROP,
> +                                             &error_abort);
> =20
>      drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
>      g_assert(drc);
> @@ -159,6 +162,11 @@ static int spapr_dt_nvdimm(SpaprMachineState *spapr,=
 void *fdt,
>                               "operating-system")));
>      _FDT(fdt_setprop(fdt, child_offset, "ibm,cache-flush-required", NULL=
, 0));
> =20
> +    if (!sync_dax) {
> +        _FDT(fdt_setprop(fdt, child_offset, "ibm,hcall-flush-required",
> +                         NULL, 0));
> +    }
> +
>      return child_offset;
>  }
> =20
> @@ -567,10 +575,12 @@ static target_ulong h_scm_flush(PowerPCCPU *cpu, Sp=
aprMachineState *spapr,
>                                        target_ulong opcode, target_ulong =
*args)
>  {
>      int ret;
> +    bool sync_dax;
>      uint32_t drc_index =3D args[0];
>      uint64_t continue_token =3D args[1];
>      SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
>      PCDIMMDevice *dimm;
> +    NVDIMMDevice *nvdimm;
>      HostMemoryBackend *backend =3D NULL;
>      SpaprNVDIMMDeviceFlushState *state;
>      ThreadPool *pool =3D aio_get_thread_pool(qemu_get_aio_context());
> @@ -580,6 +590,13 @@ static target_ulong h_scm_flush(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
>          return H_PARAMETER;
>      }
> =20
> +    nvdimm =3D NVDIMM(drc->dev);
> +    sync_dax =3D object_property_get_bool(OBJECT(nvdimm), NVDIMM_SYNC_DA=
X_PROP,
> +                                        &error_abort);
> +    if (sync_dax) {
> +        return H_UNSUPPORTED;

Do you want to return UNSUPPORTED here, or just H_SUCCESS, since the
flush should be a no-op in this case.

> +    }
> +
>      if (continue_token !=3D 0) {
>          ret =3D spapr_nvdimm_get_flush_status(continue_token);
>          if (H_IS_LONG_BUSY(ret)) {
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index bcf62f825c..f82979cf2f 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -51,6 +51,7 @@ OBJECT_DECLARE_TYPE(NVDIMMDevice, NVDIMMClass, NVDIMM)
>  #define NVDIMM_LABEL_SIZE_PROP "label-size"
>  #define NVDIMM_UUID_PROP       "uuid"
>  #define NVDIMM_UNARMED_PROP    "unarmed"
> +#define NVDIMM_SYNC_DAX_PROP   "sync-dax"
> =20
>  struct NVDIMMDevice {
>      /* private */
> @@ -85,6 +86,15 @@ struct NVDIMMDevice {
>       */
>      bool unarmed;
> =20
> +    /*
> +     * On PPC64,
> +     * The 'off' value results in the hcall-flush-required property set
> +     * in the device tree for pseries machines. When 'off', the guest
> +     * initiates explicit flush requests to the backend device ensuring
> +     * write persistence.
> +     */
> +    bool sync_dax;
> +
>      /*
>       * The PPC64 - spapr requires each nvdimm device have a uuid.
>       */
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 7c27fb3e2d..51c35488a4 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -333,6 +333,7 @@ struct SpaprMachineState {
>  #define H_P7              -60
>  #define H_P8              -61
>  #define H_P9              -62
> +#define H_UNSUPPORTED     -67
>  #define H_OVERLAP         -68
>  #define H_UNSUPPORTED_FLAG -256
>  #define H_MULTI_THREADS_ACTIVE -9005
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QQAdSkgBj1kGtrk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmBarWUACgkQbDjKyiDZ
s5JklBAAjkXmV4PWsruusz8tubkLrm+nIr6wGV7mcqSJ4z8PxQf6xcP8uO4HCG/3
6wV0wdEP0sgofMCwLlpXQ+IrF8kjuO8rZwSIjzIT/uiTt8FGYwB4CVFRzOqzYCLH
KwR4FsBEcji2hYiCQc31cKndeH85ioAPXwH4FKi5sWMFAv4h90T0Rx67D3cMCX25
0BUmZWq0wjE037NRsh3NmmfU4FDNd4c0ZqJWsYLGW5nZN1Gm96GRSIFOTJVrBMtf
WvV/60eOdLNYVu0z5hnoUHOzkZ4J1/vWeCFwnzzKkz56bHv/3rLsLDkPGcGGGP4G
ayF4AwJrxjV3pkXBMC8AlSpJbu96WWmm9iqfRB6KT08jaHzoVyd69NbZ09X5Ibto
uVh4Hz2u6+xCTkJIbVPUGGTqY1P0vAcG3t7vPxDwj6EUfAgcz9pPaB+yqdTmu9sO
TM+/rCfmIDHyY/pAVPSy3CD1crdwyK9ZP1OsHYMa5rGgcbRlr62N1oOJLlilu6rO
2jVoyb7NsME2pHrCwQQv7HrOkobPgol9SjIx7fbeDeqwdP/6qHr6XKZNoN+eEiOt
ENIPdE+A7OIwIVXl966OlnonA05VxSht8MGCPt38r+ulCXOulPPQEqqM1cy5SJ44
hTZ9OwPgK2EiOGvXAv1iPGTRARchqFPn+65fmBqXr2W4N+eqQ+w=
=2pOw
-----END PGP SIGNATURE-----

--QQAdSkgBj1kGtrk3--

--===============6349414831572935187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============6349414831572935187==--
