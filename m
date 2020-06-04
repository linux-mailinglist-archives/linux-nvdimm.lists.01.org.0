Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 240811EDA6D
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jun 2020 03:26:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3B560100A4621;
	Wed,  3 Jun 2020 18:21:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 294FF100A4620
	for <linux-nvdimm@lists.01.org>; Wed,  3 Jun 2020 18:21:36 -0700 (PDT)
IronPort-SDR: tLZaM7KYESje8DeVxFeOJIfUKNhwKCLX2U44/IH5ibh1E+GHanVO3ZIHlp5jVDKBzLkbG+Ac0S
 wR/J9jmX4mvw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 18:26:37 -0700
IronPort-SDR: doY/5dr4UI1vYg2Dc2WVCMNOjlrweKfDvmGmxoWUVEHREsBx2HZ7UpDiRGiZr9xZGx+VlOXRaV
 JNZ1AFvFFonw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,470,1583222400";
   d="scan'208";a="471364153"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2020 18:26:37 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 3 Jun 2020 18:26:36 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.51) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 3 Jun 2020 18:26:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVcmBzMeUIkM7wkjLxpsN4nMTxF9nT5unA/uNNV+KnjZyNxHKUPIocwRtF2Db5vxVMrU53khIBEQb83uUcS+ktRMUyPVaAJZQaJSf9wIi+yARL07zTTNOmf/bWzC7JrQRU8AiyZ+M3XHxbAizjzalhBx9XTBiIjRi0jXPTCvcBCp7xCSN44el3GTkWW+mTxj/xRqUJIcY+40tQENs9kIXvtWb6MM5HQ8uUteDIqT0M0xdWnA3d5e9MQetAwAKaCfTWHH9BCFuwV1jgVFG5ZniPghr7F63y33j8BGTU61zoJsfFmguJ0dfcmm+V/fH3RfBZsxR5HHU1B9o1nB56Lj7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyqal7H/ZMqh8AlcDOQUXrB2hz7WmKb2Jq0VKzY10yg=;
 b=VIPqwsbY5mmMhLUghZye8P8h+f/nvZEBUZHnxdRdvbkepFcBZCijVbvbk5t4qRqZ1rJuubHMyiqlVN0pgRkhsSEvzZPpgBwLODQWtC4Ev1PyjTi11t3Yi8M1258DmDHJ2a0usN4SOvjWhM67G1i9/5chgc7gbtS46VVRCfY0PVGtAh45e6xN6juZ+c6MNy+gTr3GOxwGk0ML7dKFC2dLBTjeQgQ1Gp6q7cx3Azw59oFqiDdQCmFZPlGzUHAMg2F4PxpkqEWU9dtA5X5miXEb3j/pbqLQ7uIPd4rJrYsMg9Whuw40B4yZoaxw3lmIwgl9TkevVYuBFojNcShK98XrFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyqal7H/ZMqh8AlcDOQUXrB2hz7WmKb2Jq0VKzY10yg=;
 b=MfnF51wo71D9ueM3gftMpgHc6SIxdg4n4Epe2MLEx9lp1eX4kDhN+ICN+xv6Dc+Gbdxvvi/4LmjfWh2877FJ2BQRu/gB2b623tK1tMrdaC1QRKyn7zZJZvq/IBYyVkWqxli3gO9QeMWTnG9FfN44DjrSQPrg8gyuegaNplRKiaM=
Received: from BN6PR11MB4132.namprd11.prod.outlook.com (2603:10b6:405:81::10)
 by BN6PR11MB1330.namprd11.prod.outlook.com (2603:10b6:404:4a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 4 Jun
 2020 01:26:35 +0000
Received: from BN6PR11MB4132.namprd11.prod.outlook.com
 ([fe80::2d67:42cc:d74f:6e4f]) by BN6PR11MB4132.namprd11.prod.outlook.com
 ([fe80::2d67:42cc:d74f:6e4f%7]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 01:26:35 +0000
From: "Williams, Dan J" <dan.j.williams@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>
Subject: RE: [ndctl PATCH v5 6/6] libndctl,papr_scm: Implement support for
 PAPR_PDSM_HEALTH
Thread-Topic: [ndctl PATCH v5 6/6] libndctl,papr_scm: Implement support for
 PAPR_PDSM_HEALTH
Thread-Index: AQHWNgV2SccHGlmSS0uLW1HXMdo7/qjHsiiw
Date: Thu, 4 Jun 2020 01:26:35 +0000
Message-ID: <BN6PR11MB41326FB69B35A259A3A6FA61C6890@BN6PR11MB4132.namprd11.prod.outlook.com>
References: <20200529220600.225320-1-vaibhav@linux.ibm.com>
 <20200529220600.225320-7-vaibhav@linux.ibm.com>
In-Reply-To: <20200529220600.225320-7-vaibhav@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72659758-51fd-419b-4ddc-08d808265211
x-ms-traffictypediagnostic: BN6PR11MB1330:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1330C2EEC66B500593924578C6890@BN6PR11MB1330.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qD9hgrzhyj1jT/JOijnpChgpU3HN67sgd5qTyK0IBlWJvpvOWxFyaPAML70zVwzW7uu7nHXtMoa9yBgcOt+WH+tA55HYW9mX2T/UXuhNsYwR2sHt8Ag/dEtuP3E1GKVFKth2aCorVd8PLEnnI4OvOqztG4qTdkHwIBeMMb0lxmJU6wEgntmCvHQIrpovC1q0tfladmrKfY51de5N4nUHxb+fdXOznOxRPeDJipDrO4E1SPLxXGH5oscgxuRzEXWES0EWMq1+GWxybETO2pdqIBw9hNTAd0Gb2BU0fe/9NCbxYRsp5gWg9NpvebNlZhhzzfOMUlLOAt78L75FQkeWWODhrUVGvuPnKncQBXy2hIflrb54PAYlTeV9eDh0o/JN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39860400002)(136003)(366004)(396003)(83380400001)(2906002)(64756008)(76116006)(8936002)(66946007)(33656002)(66446008)(66556008)(5660300002)(66476007)(186003)(52536014)(26005)(478600001)(53546011)(107886003)(6506007)(4326008)(86362001)(9686003)(55016002)(71200400001)(8676002)(110136005)(54906003)(7696005)(316002)(142933001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MaJAO1uPdxhBN8NOsbHX4xplHdkbYCZojST58J9OHztOtvLAWmKvwWJLTt5hQyA95uRfv6BeWL7AfDfUnt67JorZqGK881rfp1IAYEwoyxTZdCMl4v+Z4O5c4Q1abbLVvDsil2zuHoHX+dVclfASUudxlTQ6y7Dt8BOvqxCkCmTpXw7dGtnQO1oCIzlxGon4jc/zKNYUGnEqM5YG/B41yQIglj+f+mYb+PlBvh7xjyhIGP6eXqQ8rb2wsSWXO/DmEXExEDx5BEHFVgSiMIm2fAXO6IYrWEFFtc/SqQzkxiAuE7/9T+mgrw9uvsp/QYxSgz1+YJgv40FGyC2lli17LEGz88ZcrCGntTQw2taUDsDA+7Tf4iJ6IrhYpCEoUd9817rZppkk/QwmkivByoY2u0OBuy0FUlAXICcW80SQ/6uv9Z8cYYJtsGHWVgAC/PfDjNkETAIkaulEU1zaf9PqI2HoMaIOR/M3fOm899CYtL7SB9gFAtWFBQG2SWxIGNUx
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72659758-51fd-419b-4ddc-08d808265211
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 01:26:35.0550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F1Jc2jS54eKkjHKPeOISwXhAeVoMrfx3edkstyWShomvmC+uXs5fjYahxLALIrGJpSlzW7yzYNvI8wmnF+bBgh953/muSRtycckXDoJpjFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1330
X-OriginatorOrg: intel.com
Message-ID-Hash: HQKBAJDNZKAEUAMMBO5NHTY4SEPMDK7L
X-Message-ID-Hash: HQKBAJDNZKAEUAMMBO5NHTY4SEPMDK7L
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HQKBAJDNZKAEUAMMBO5NHTY4SEPMDK7L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Vaibhav Jain <vaibhav@linux.ibm.com>
> Sent: Friday, May 29, 2020 3:06 PM
> To: linux-nvdimm@lists.01.org
> Cc: Vaibhav Jain <vaibhav@linux.ibm.com>; Williams, Dan J
> <dan.j.williams@intel.com>; Verma, Vishal L <vishal.l.verma@intel.com>;
> Aneesh Kumar K . V <aneesh.kumar@linux.ibm.com>; Jeff Moyer
> <jmoyer@redhat.com>; Oliver O'Halloran <oohall@gmail.com>; Santosh
> Sivaraj <santosh@fossix.org>; Weiny, Ira <ira.weiny@intel.com>
> Subject: [ndctl PATCH v5 6/6] libndctl,papr_scm: Implement support for
> PAPR_PDSM_HEALTH
> 
> Add support for reporting DIMM health and shutdown state by issuing
> PAPR_PDSM_HEALTH request to papr_scm module. It returns an instance of
> 'struct nd_papr_pdsm_health' as defined in 'papr_pdsm.h'. The patch
> provides support for dimm-ops 'new_smart', 'smart_get_health' &
> 'smart_get_shutdown_state' as newly introduced functions
> papr_new_smart_health(), papr_smart_get_health() &
> papr_smart_get_shutdown_state() respectively. These callbacks should
> enable ndctl to report DIMM health.
> 
> Also a new member 'struct dimm_priv.health' is introduced which holds the
> current health status of the dimm. This member is set inside newly added
> function 'update_dimm_health_v1()' which parses the v1 payload returned
> by the kernel after servicing PAPR_PDSM_HEALTH. The function will also
> update dimm-flags viz 'struct ndctl_dimm.flags.f_*'
> based on the flags set in the returned payload.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> 
> v4..v5:
> * Updated patch description to reflect updated names of struct and
>   defines that have the term 'scm' removed.
> 
> v3..v4:
> * None
> 
> v2..v3:
> * None
> 
> v1..v2:
> * Squashed patch to report nvdimm bad shutdown state with this patch.
> * Switched to new structs/enums as defined in papr_scm_pdsm.h
> ---
>  ndctl/lib/papr.c | 90
> ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 87 insertions(+), 3 deletions(-)
> 
> diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c index
> 1b7870beb631..cb7ff9e0d5bd 100644
> --- a/ndctl/lib/papr.c
> +++ b/ndctl/lib/papr.c
> @@ -42,7 +42,9 @@
> 
>  /* Per dimm data. Holds per-dimm data parsed from the cmd_pkgs */  struct
> dimm_priv {
> -	/* Empty for now */
> +
> +	/* Cache the dimm health status */
> +	struct nd_papr_pdsm_health health;

I don't understand this. The kernel is caching this, why does libndctl need to cache it?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
