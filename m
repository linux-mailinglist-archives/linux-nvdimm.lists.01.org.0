Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E516020BCF1
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jun 2020 00:53:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0E98B11022290;
	Fri, 26 Jun 2020 15:53:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=erik.kaneda@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A738311022290
	for <linux-nvdimm@lists.01.org>; Fri, 26 Jun 2020 15:53:46 -0700 (PDT)
IronPort-SDR: TaES/VOZl8oxaQ5qDcqrwJPknAbVhe2e6KmJ/PGnpsT9ZYzD3X3VrSFQz3v6Ncdwbu/5oZgKAE
 NsSEEj7Rzu+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210581583"
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800";
   d="scan'208";a="210581583"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 15:53:45 -0700
IronPort-SDR: 08xkWBPQ18acCBCIbmj9OyunyA0yxY9fdwGs0m+VA2a8sUaLMc+tWO7+syvVM5Ypup8z2ZsmAl
 Pw6clghuQuzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800";
   d="scan'208";a="479968307"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2020 15:53:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 26 Jun 2020 15:53:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 26 Jun 2020 15:53:31 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 26 Jun 2020 15:53:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 26 Jun 2020 15:53:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjJ5k98eJ8UukbmuClxTkFMXb8D4QjaGmYXhaXYM2jvdOrUqtoiib00Rbwl5b0Uzvgbod2kDI/i6ztlLlzVI6isEF9gJRf3YZ4aVdHzgO3Xj7eXA+OjJwOC9Vwq3c2A2yzJWDLizyhNSRGrJyIKnCfzXkN5Ae6++QrGep7Rug6MfFDBodOao1DRDAc/dJn/o5JbXusGH1nUfsi6EqsbhYJWeBeTY12QnEHeDEAves+52xpw+oRncYA2ZIA89EV/pUxgqlOedCozRw29MscpJaO5gcF/uuyLrZ+v0tYpsdmxsFwv/AcDsGkRaXQG4TJ/3f52BZOfCAaMl/e1QlpqkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR6b9RgL5F3V2gH8jEGombZyMQdFMTvnWcvO/zF04vc=;
 b=lw+flt4pcdW1ercsmFUKN1JAZ4gijMr6ldzM9z8cVoWUhnaD8K+vQC5NA+km2wKWqeiNN9dT7PlQvgiPbdK99ZdQI9+hg4jxmsK67TgoPIEft+LiEcQ4SKzQ0fq6kf8/C/Vf5yaS1OIaMsFusNXqX0Yy87cOri441+b8bIqz/OtneaIAOosZKYq5utCc8+1HXkAAXauX0sGOE1lkwjRps30shBbWuBqUf7JHEVmBA3l2OBsPH/krnJoFL5OT2w2ZZHVUIN/fTvjSpc6klHkFz6nuPw/+VHj2WuUeaEiJSc4pefRegF7Jvaxsvfd6NG1mXKmrFvtJZY8I6cNbc7ENaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR6b9RgL5F3V2gH8jEGombZyMQdFMTvnWcvO/zF04vc=;
 b=P9WRQ6VjqXNIZm/NQBxTKQgC6vXtRwTBfp7sV08OW6s8oOewUy8gmUpaLDPQjte9aTUCnFdRqJRTpj3s+ESpEYV+uCTdEVH1bvle4+EcajqIDfJW0CC/OKJ86pFHyifN/iLPLHZZqC0ey/MIlZEjuulzaiOtliR+LpAFwvq5YTU=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB1295.namprd11.prod.outlook.com (2603:10b6:300:2b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 22:53:27 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::deb:2fe:1d84:a19f]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::deb:2fe:1d84:a19f%11]) with mapi id 15.20.3131.025; Fri, 26 Jun 2020
 22:53:27 +0000
From: "Kaneda, Erik" <erik.kaneda@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [RFT][PATCH v2 3/4] ACPICA: Preserve memory opregion mappings if
 supported by OS
Thread-Topic: [RFT][PATCH v2 3/4] ACPICA: Preserve memory opregion mappings if
 supported by OS
Thread-Index: AQHWSJ3r9KMXSpAH80ik4s+HK21kMKjrgw4Q
Date: Fri, 26 Jun 2020 22:53:27 +0000
Message-ID: <MWHPR11MB1599FBA57730E5C74B9B4588F0930@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <13749323.0m2ImmhSHx@kreacher>
In-Reply-To: <13749323.0m2ImmhSHx@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.39.104.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 540bc442-6129-4e2b-6da8-08d81a23bd3e
x-ms-traffictypediagnostic: MWHPR11MB1295:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB129567DBA81D292D3D5DEF51F0930@MWHPR11MB1295.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9BnIAXr1fynaDRsoaKVl1xRSdOoH/0pATGGThCWLAu0T/tSJzFxBFjJGbkNJxFkWp8ie0+d1fJzoq2mXUT3+dkpCSAy1miaX2O0dMGTt9TfBvIQImYAM61IyX2S6U1zbMU70uoThz7RHoQt+ybPWVyKAOYt+485UK9KiwR7aJtUWTiahL54T1Xb/gWWzX+6bp8+MEJ3Niff9LIUjQMKqA6hpPqECaRK2HIc6d5fUVjonvSnY+ZTisgf0VHNXK6asUrRqs5KRhWxMJrfCes1S8AQKdaUaugXIcrZE+W18+SGxelVnIkWwMlUWKSngyBkhBewHdHsp9YPkeVTy7eehHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(54906003)(66556008)(26005)(110136005)(66446008)(64756008)(76116006)(71200400001)(52536014)(33656002)(6636002)(66946007)(316002)(66476007)(186003)(7696005)(30864003)(8676002)(2906002)(6506007)(83380400001)(55016002)(86362001)(8936002)(7416002)(5660300002)(53546011)(478600001)(9686003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: E3ijdBQ+CmQ9pHZWq8Tu6Rlt1p+lTyW6mGT1p3Z07O1S1+8Rb34sJG74PXlN5TgBvKPw0T0CHbWwT7NfIXKmdYKvNCHaU1m/QQtT+LnlN+g68b7VtxwgUTYmPWMq+kUUdWfG8UFjc8068dd0OLIUfYv4kPv4j1E5hmf9KaYUXPgdXIdaYZxd5SyelBC3royGyRBDPJH5HR3ywB7097bDa7CP7i4DXhVXwzIf2U04Khpd9P5COF8jc3SroHaxQq0d0G10D0D836kllsKwMqN2fKaanSCc/0GNSdlegUMwYVGivBO3dFPmacxDesHSK8msN22ENpVo/ueBf8gAxtrOcgAsic7cpmldUrdUkxMLPK9XBHqrEej35MOGYlD8ZOoE3TOzPaa6zDDA16Cub5Kxqt5SbDJhyqDA4AezLMzHi5KhIXAyGo4qtW0xSd0dFdRQvbY+9MaMgvV3FiGNPfjCZhh7ocBoy4ac5jIK07UCLkE=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540bc442-6129-4e2b-6da8-08d81a23bd3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 22:53:27.2618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DlZ9VCJerGmJEFIbItvoA0Rm4lWzDBJeBgaHs/NYF+oVR+3ESfY1hjz2O6iINEkXvo3aUo/3XTZxkihQsf3ZHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1295
X-OriginatorOrg: intel.com
Message-ID-Hash: VMCCIROADPGKDX6NBK4MJDVUQXOV4PLI
X-Message-ID-Hash: VMCCIROADPGKDX6NBK4MJDVUQXOV4PLI
X-MailFrom: erik.kaneda@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VMCCIROADPGKDX6NBK4MJDVUQXOV4PLI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Rafael J. Wysocki <rjw@rjwysocki.net>
> Sent: Monday, June 22, 2020 7:02 AM
> To: Williams, Dan J <dan.j.williams@intel.com>; Kaneda, Erik
> <erik.kaneda@intel.com>
> Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len Brown
> <lenb@kernel.org>; Borislav Petkov <bp@alien8.de>; Weiny, Ira
> <ira.weiny@intel.com>; James Morse <james.morse@arm.com>; Myron
> Stowe <myron.stowe@redhat.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; linux-kernel@vger.kernel.org; linux-
> acpi@vger.kernel.org; linux-nvdimm@lists.01.org; Moore, Robert
> <robert.moore@intel.com>
> Subject: [RFT][PATCH v2 3/4] ACPICA: Preserve memory opregion mappings
> if supported by OS
> 
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The ACPICA's strategy with respect to the handling of memory mappings
> associated with memory operation regions is to avoid mapping the
> entire region at once which may be problematic at least in principle
> (for example, it may lead to conflicts with overlapping mappings
> having different attributes created by drivers).  It may also be
> wasteful, because memory opregions on some systems take up vast
> chunks of address space while the fields in those regions actually
> accessed by AML are sparsely distributed.
> 
> For this reason, a one-page "window" is mapped for a given opregion
> on the first memory access through it and if that "window" does not
> cover an address range accessed through that opregion subsequently,
> it is unmapped and a new "window" is mapped to replace it.  Next,
> if the new "window" is not sufficient to access memory through the
> opregion in question in the future, it will be replaced with yet
> another "window" and so on.  That may lead to a suboptimal sequence
> of memory mapping and unmapping operations, for example if two fields
> in one opregion separated from each other by a sufficiently wide
> chunk of unused address space are accessed in an alternating pattern.
> 
> The situation may still be suboptimal if the deferred unmapping
> introduced previously is supported by the OS layer.  For instance,
> the alternating memory access pattern mentioned above may produce
> a relatively long list of mappings to release with substantial
> duplication among the entries in it, which could be avoided if
> acpi_ex_system_memory_space_handler() did not release the mapping
> used by it previously as soon as the current access was not covered
> by it.
> 
> In order to improve that, modify acpi_ex_system_memory_space_handler()
> to take advantage of the memory mappings reference counting at the OS
> level if a suitable interface is provided.
> 
Hi,

> Namely, if ACPI_USE_FAST_PATH_MAPPING is set, the OS is expected to
> implement acpi_os_map_memory_fast_path() that will return NULL if
> there is no mapping covering the given address range known to it.
> If such a mapping is there, however, its reference counter will be
> incremented and a pointer representing the requested virtual address
> will be returned right away without any additional consequences.

I do not fully understand why this is under a #ifdef. Is this to support operating systems that might not want to add support for this behavior?

Also, instead of using the terminology fast_path, I think it would be easier to use terminology that describes the mechanism..
It might be easier for other Operating systems to understand something like acpi_os_map_preserved_memory or acpi_os_map_sysmem_opregion_memory.

Thanks,
Erik
> 
> That allows acpi_ex_system_memory_space_handler() to acquire
> additional references to all new memory mappings with the help
> of acpi_os_map_memory_fast_path() so as to retain them until the
> memory opregions associated with them go away.  The function will
> still use a new "window" mapping if the current one does not
> cover the address range at hand, but it will avoid unmapping the
> current one right away by adding it to a list of "known" mappings
> associated with the given memory opregion which will be deleted at
> the opregion deactivation time.  The mappings in that list can be
> used every time a "new window" is needed so as to avoid overhead
> related to the mapping and unmapping of memory.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpica/acinterp.h |   4 +
>  drivers/acpi/acpica/evrgnini.c |   7 +-
>  drivers/acpi/acpica/exregion.c | 159
> ++++++++++++++++++++++++++++++++-
>  3 files changed, 162 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
> index 1f1026fb06e9..db9c279baa2e 100644
> --- a/drivers/acpi/acpica/acinterp.h
> +++ b/drivers/acpi/acpica/acinterp.h
> @@ -479,8 +479,12 @@ void acpi_ex_pci_cls_to_string(char *dest, u8
> class_code[3]);
> 
>  u8 acpi_is_valid_space_id(u8 space_id);
> 
> +struct acpi_mem_space_context
> *acpi_ex_alloc_mem_space_context(void);
> +
>  void acpi_ex_unmap_region_memory(struct acpi_mem_space_context
> *mem_info);
> 
> +void acpi_ex_unmap_all_region_mappings(struct
> acpi_mem_space_context *mem_info);
> +
>  /*
>   * exregion - default op_region handlers
>   */
> diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
> index 9f33114a74ca..f6c5feea10bc 100644
> --- a/drivers/acpi/acpica/evrgnini.c
> +++ b/drivers/acpi/acpica/evrgnini.c
> @@ -46,10 +46,10 @@ acpi_ev_system_memory_region_setup(acpi_handle
> handle,
>  			local_region_context =
>  			    (struct acpi_mem_space_context
> *)*region_context;
> 
> -			/* Delete a cached mapping if present */
> +			/* Delete memory mappings if present */
> 
>  			if (local_region_context->mapped_length) {
> -
> 	acpi_ex_unmap_region_memory(local_region_context);
> +
> 	acpi_ex_unmap_all_region_mappings(local_region_context);
>  			}
>  			ACPI_FREE(local_region_context);
>  			*region_context = NULL;
> @@ -59,8 +59,7 @@ acpi_ev_system_memory_region_setup(acpi_handle
> handle,
> 
>  	/* Create a new context */
> 
> -	local_region_context =
> -	    ACPI_ALLOCATE_ZEROED(sizeof(struct
> acpi_mem_space_context));
> +	local_region_context = acpi_ex_alloc_mem_space_context();
>  	if (!(local_region_context)) {
>  		return_ACPI_STATUS(AE_NO_MEMORY);
>  	}
> diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
> index af777b7fccb0..9d97b6a67074 100644
> --- a/drivers/acpi/acpica/exregion.c
> +++ b/drivers/acpi/acpica/exregion.c
> @@ -14,6 +14,40 @@
>  #define _COMPONENT          ACPI_EXECUTER
>  ACPI_MODULE_NAME("exregion")
> 
> +struct acpi_mem_mapping {
> +	acpi_physical_address physical_address;
> +	u8 *logical_address;
> +	acpi_size length;
> +	struct acpi_mem_mapping *next_mm;
> +};
> +
> +struct acpi_mm_context {
> +	struct acpi_mem_space_context mem_info;
> +	struct acpi_mem_mapping *first_mm;
> +};
> +
> +/*********************************************************
> ********************
> + *
> + * FUNCTION:    acpi_ex_alloc_mem_space_context
> + *
> + * PARAMETERS:  None
> + *
> + * RETURN:      Pointer to a new region context object.
> + *
> + * DESCRIPTION: Allocate memory for memory operation region
> representation.
> + *
> +
> **********************************************************
> ******************/
> +struct acpi_mem_space_context
> *acpi_ex_alloc_mem_space_context(void)
> +{
> +	ACPI_FUNCTION_TRACE(acpi_ex_alloc_mem_space_context);
> +
> +#ifdef ACPI_USE_FAST_PATH_MAPPING
> +	return ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_mm_context));
> +#else
> +	return ACPI_ALLOCATE_ZEROED(sizeof(struct
> acpi_mem_space_context));
> +#endif
> +}
> +
> 
> /**********************************************************
> *******************
>   *
>   * FUNCTION:    acpi_ex_unmap_region_memory
> @@ -40,6 +74,44 @@ void acpi_ex_unmap_region_memory(struct
> acpi_mem_space_context *mem_info)
>  	return_VOID;
>  }
> 
> +/*********************************************************
> ********************
> + *
> + * FUNCTION:    acpi_ex_unmap_all_region_mappings
> + *
> + * PARAMETERS:  mem_info            - Region specific context
> + *
> + * RETURN:      None
> + *
> + * DESCRIPTION: Unmap all mappings associated with a memory operation
> region.
> + *
> +
> **********************************************************
> ******************/
> +void acpi_ex_unmap_all_region_mappings(struct
> acpi_mem_space_context *mem_info)
> +{
> +#ifdef ACPI_USE_FAST_PATH_MAPPING
> +	struct acpi_mm_context *mm_context = (struct acpi_mm_context
> *)mem_info;
> +	struct acpi_mem_mapping *mm;
> +#endif
> +
> +	ACPI_FUNCTION_TRACE(acpi_ex_unmap_all_region_mappings);
> +
> +	acpi_ex_unmap_region_memory(mem_info);
> +
> +#ifdef ACPI_USE_FAST_PATH_MAPPING
> +	while (mm_context->first_mm) {
> +		mm = mm_context->first_mm;
> +		mm_context->first_mm = mm->next_mm;
> +#ifdef ACPI_USE_DEFERRED_UNMAPPING
> +		acpi_os_unmap_deferred(mm->logical_address, mm-
> >length);
> +#else
> +		acpi_os_unmap_memory(mm->logical_address, mm-
> >length);
> +#endif
> +		ACPI_FREE(mm);
> +	}
> +#endif /* ACPI_USE_FAST_PATH_MAPPING */
> +
> +	return_VOID;
> +}
> +
> 
> /**********************************************************
> *********************
>   *
>   * FUNCTION:    acpi_ex_system_memory_space_handler
> @@ -70,6 +142,10 @@ acpi_ex_system_memory_space_handler(u32
> function,
>  	u32 length;
>  	acpi_size map_length;
>  	acpi_size page_boundary_map_length;
> +#ifdef ACPI_USE_FAST_PATH_MAPPING
> +	struct acpi_mm_context *mm_context = (struct acpi_mm_context
> *)mem_info;
> +	struct acpi_mem_mapping *mm;
> +#endif
>  #ifdef ACPI_MISALIGNMENT_NOT_SUPPORTED
>  	u32 remainder;
>  #endif
> @@ -128,7 +204,7 @@ acpi_ex_system_memory_space_handler(u32
> function,
>  					 mem_info->mapped_length))) {
>  		/*
>  		 * The request cannot be resolved by the current memory
> mapping;
> -		 * Delete the existing mapping and create a new one.
> +		 * Delete the current cached mapping and get a new one.
>  		 */
>  		if (mem_info->mapped_length) {
> 
> @@ -137,6 +213,36 @@ acpi_ex_system_memory_space_handler(u32
> function,
>  			acpi_ex_unmap_region_memory(mem_info);
>  		}
> 
> +#ifdef ACPI_USE_FAST_PATH_MAPPING
> +		/*
> +		 * Look for an existing saved mapping matching the address
> range
> +		 * at hand.  If found, make the OS layer bump up the
> reference
> +		 * counter of that mapping, cache it and carry out the access.
> +		 */
> +		for (mm = mm_context->first_mm; mm; mm = mm-
> >next_mm) {
> +			if (address < mm->physical_address)
> +				continue;
> +
> +			if ((u64)address + length >
> +					(u64)mm->physical_address + mm-
> >length)
> +				continue;
> +
> +			/*
> +			 * When called on a known-existing memory mapping,
> +			 * acpi_os_map_memory_fast_path() must return
> the same
> +			 * logical address as before or NULL.
> +			 */
> +			if (!acpi_os_map_memory_fast_path(mm-
> >physical_address,
> +							  mm->length))
> +				continue;
> +
> +			mem_info->mapped_logical_address = mm-
> >logical_address;
> +			mem_info->mapped_physical_address = mm-
> >physical_address;
> +			mem_info->mapped_length = mm->length;
> +			goto access;
> +		}
> +#endif /* ACPI_USE_FAST_PATH_MAPPING */
> +
>  		/*
>  		 * October 2009: Attempt to map from the requested
> address to the
>  		 * end of the region. However, we will never map more than
> one
> @@ -168,9 +274,8 @@ acpi_ex_system_memory_space_handler(u32
> function,
> 
>  		/* Create a new mapping starting at the address given */
> 
> -		mem_info->mapped_logical_address =
> -		    acpi_os_map_memory(address, map_length);
> -		if (!mem_info->mapped_logical_address) {
> +		logical_addr_ptr = acpi_os_map_memory(address,
> map_length);
> +		if (!logical_addr_ptr) {
>  			ACPI_ERROR((AE_INFO,
>  				    "Could not map memory at 0x%8.8X%8.8X,
> size %u",
>  				    ACPI_FORMAT_UINT64(address),
> @@ -181,10 +286,56 @@ acpi_ex_system_memory_space_handler(u32
> function,
> 
>  		/* Save the physical address and mapping size */
> 
> +		mem_info->mapped_logical_address = logical_addr_ptr;
>  		mem_info->mapped_physical_address = address;
>  		mem_info->mapped_length = map_length;
> +
> +#ifdef ACPI_USE_FAST_PATH_MAPPING
> +		/*
> +		 * Create a new mm list entry to save the new mapping for
> +		 * removal at the operation region deactivation time.
> +		 */
> +		mm = ACPI_ALLOCATE_ZEROED(sizeof(*mm));
> +		if (!mm) {
> +			/*
> +			 * No room to save the new mapping, but this is not
> +			 * critical.  Just log the error and carry out the
> +			 * access as requested.
> +			 */
> +			ACPI_ERROR((AE_INFO,
> +				    "Not enough memory to save memory
> mapping at 0x%8.8X%8.8X, size %u",
> +				    ACPI_FORMAT_UINT64(address),
> +				    (u32)map_length));
> +			goto access;
> +		}
> +		/*
> +		 * Bump up the new mapping's reference counter in the OS
> layer
> +		 * to prevent it from getting dropped prematurely.
> +		 */
> +		if (!acpi_os_map_memory_fast_path(address, map_length))
> {
> +			/*
> +			 * Something has gone wrong, but this is not critical.
> +			 * Log the error, free the mm list entry that won't be
> +			 * used and carry out the access as requested.
> +			 */
> +			ACPI_ERROR((AE_INFO,
> +				    "Unable to save memory mapping at
> 0x%8.8X%8.8X, size %u",
> +				    ACPI_FORMAT_UINT64(address),
> +				    (u32)map_length));
> +			ACPI_FREE(mm);
> +			goto access;
> +		}
> +		mm->physical_address = address;
> +		mm->logical_address = logical_addr_ptr;
> +		mm->length = map_length;
> +		mm->next_mm = mm_context->first_mm;
> +		mm_context->first_mm = mm;
>  	}
> 
> +access:
> +#else /* !ACPI_USE_FAST_PATH_MAPPING */
> +	}
> +#endif /* !ACPI_USE_FAST_PATH_MAPPING */
>  	/*
>  	 * Generate a logical pointer corresponding to the address we want
> to
>  	 * access
> --
> 2.26.2
> 
> 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
