Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCA012BC5F
	for <lists+linux-nvdimm@lfdr.de>; Sat, 28 Dec 2019 04:08:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2C7291011367D;
	Fri, 27 Dec 2019 19:12:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7F5781011366E
	for <linux-nvdimm@lists.01.org>; Fri, 27 Dec 2019 19:12:01 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 19:08:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,365,1571727600";
   d="scan'208";a="223865737"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga001.fm.intel.com with ESMTP; 27 Dec 2019 19:08:40 -0800
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Dec 2019 19:08:39 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Dec 2019 19:08:38 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 27 Dec 2019 19:08:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHPiIBH7N63Oc9xk/3tLbb1saEGHjvp587ncefcW+pr1l90hj1bRu2H7zzAnq8ktkcNtNyvTlOdQDsS36EqO6LNoZO155cqHGZ+Cu+6SkajXOJ7D25NjeAGeLvydLIVZ9Lz1gedBTPOUBtToZnONjjY2o1PCV1L/lwYNgtx++NPydrpVumPbbdEGHYEsjklqyiN7811hekbfTXyBjv9+h20KpJClr4VaL1rgNlp+I6ac2IFhNyeEthEHqwZhp9rSsT1xgFMUKBH1Kt3jRglJtlWiyiq8QCdcBEI6KN4z4D+NlY9Tbs/5DZPYSB+0oaywRQDkSrhyw4n7Q3E8Mi/QSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXCrER46KjKmZUTcOpPeg7vgvecVV54rHZ4PzQQsZhc=;
 b=L00jM2T9gVz9gUgotBcByXoQUaPLKJofmHRLjMsqRKetzurwlswXUtW/LdGlYALZtTAI2fAn5RlgGxXqq2WWfnnsr5zw/VPtcOSs+W8+l+YTuIizU4H8yZh6POYpWkxssb2bOXaPmzADMHbCyNAs3pydBbO+Q120CPypO0C3uWzYesKMejb19v0pLRib2dMoisCuHwEVkXvdlzTpaCVTsUj46JjU2c4vEU+A7Qw4fzWgtu6HTwPspteVC9iZy0BB16KQpqvIKo/BTUA5aogpZZ3TM75QVLH2Vrwo9MgPfrv49cGnDzqSYMAZ0FFVmevsjcCrkQZpHTOYVOzSSez92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXCrER46KjKmZUTcOpPeg7vgvecVV54rHZ4PzQQsZhc=;
 b=iq5oqu1RE/j7R/16fKjiFGDJ3OKPvX6qaMABCBeG9VrcS7eQYk3fdhDH+KsLENwC1uYVJU6ot9/6Asjo0lsJo28W8FLQ7QJq2O0+184u2TcheCqzQ2udgWhgR9m4BKCQlPvDUSnojtJTtnoeWOG6sNdbgJQhbzKUFKbe1FzS3Kw=
Received: from SN6PR11MB3264.namprd11.prod.outlook.com (52.135.111.80) by
 SN6PR11MB2685.namprd11.prod.outlook.com (52.135.91.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Sat, 28 Dec 2019 03:08:36 +0000
Received: from SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::78f3:73f9:eaff:d25c]) by SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::78f3:73f9:eaff:d25c%7]) with mapi id 15.20.2581.007; Sat, 28 Dec 2019
 03:08:35 +0000
From: "Li, Redhairer" <redhairer.li@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH] daxctl: Change region input type from INTEGER to STRING.
Thread-Topic: [PATCH] daxctl: Change region input type from INTEGER to STRING.
Thread-Index: AdWqSy7tSheIw9IbRFeymChi7Sx2XP//fIUA/99j/4CAQ1rRAP//ul5A//9ohUAARpydAP/90hVA
Date: Sat, 28 Dec 2019 03:08:35 +0000
Message-ID: <SN6PR11MB32645823494C71370EA9936E92250@SN6PR11MB3264.namprd11.prod.outlook.com>
References: <2369E669066F8E42A79A3DF0E43B9E643AC9EB31@pgsmsx114.gar.corp.intel.com>
 <CAPcyv4jTS+JcmH=Oe3Js0dw+Ovu+P6yBKHDZp8xxUT6Rbhpaqw@mail.gmail.com>
 <SN6PR11MB3264D981A619065F1A4EFFB992280@SN6PR11MB3264.namprd11.prod.outlook.com>
 <CAPcyv4iP1NK=2funtr6yp9VhedntKvzkvBsXDkLLXt6FBZYO=A@mail.gmail.com>
 <SN6PR11MB3264C140FEB5C66679095AFF922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
 <SN6PR11MB3264617D4EA3C3C4706C7C6D922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
 <CAPcyv4iFZUzhTG+6L=RExcJOCeLak7aEbX_A=pGga4Bw+467dw@mail.gmail.com>
In-Reply-To: <CAPcyv4iFZUzhTG+6L=RExcJOCeLak7aEbX_A=pGga4Bw+467dw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTA2YzM2YmEtNzFmNi00MDA3LWI4NTItNjNmYTUxODRlYjMwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicXRNdGZUXC9aZUU5a3JmaXV5T3pGQnBjU1A3NTNkbW9qYWpHd0VlQ0F3K05lano5K09vekVnWVVUWlE2YUd2bXoifQ==
x-ctpclassification: CTP_NT
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=redhairer.li@intel.com;
x-originating-ip: [192.198.147.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 173ef966-7e51-4248-baa3-08d78b433a9b
x-ms-traffictypediagnostic: SN6PR11MB2685:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB26852B865C34AF533D1E777A92250@SN6PR11MB2685.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 02652BD10A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(376002)(136003)(396003)(13464003)(199004)(189003)(5660300002)(66946007)(316002)(64756008)(66556008)(66446008)(66476007)(76116006)(6636002)(52536014)(53546011)(26005)(7696005)(6506007)(71200400001)(186003)(2906002)(4326008)(9686003)(33656002)(55016002)(81156014)(6862004)(478600001)(8676002)(86362001)(8936002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2685;H:SN6PR11MB3264.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CpiA3ELB/0L6orlN+wjfuq1qtw3Q0VmaDlre6csElMxMV25Q6s+H3nsxZTNz6yD0J+o3uvsynUvSH28tX970tfTMN0XurgNUisxooISYSyjjDGri2yy6sJj3YQDSXIIg8jmqIiYwM7YEjT7hIYfvUHT7IUCD4GkC287RyZAQmQ0CzmfsRf5MUo5u18z2W3PzZnbEewzkaZG7vNjJu/dlZ74ndgbxrLWodG1I/jjbnU3FgfNmvuPYbqZ5jX1YAWDug6lLT4AB6ZMKmEpJoEBemAKVci+MvDFwsv51jnqI/cym98Sej+OU5R3riQKNpCXQ7k7gd3xzGyPqovbvP768tj5jdoXcR2wnzFWDVLJZ37SAavn/znHFGvJioSAf1nwQLX3ABLyJX3tAZFnV5FXwvUNvZFoddNoc9FYIR0cY4uWwkUiN1MrniUsEdhlFrk3rGImgrYn1/z1Yy8YyduQ1sC6FGdeVzkc7rRrRFAwUwcpwWbeIVsiDP7B+nX62v8N0
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 173ef966-7e51-4248-baa3-08d78b433a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2019 03:08:35.7159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6kmKEhfF5WiUV0axqZq8W/wPeSOx9xSCANJCkAgW8y8RA7595XF94gWpvp5b/H2K42qgZOP9BE/8bekAf4jnYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2685
X-OriginatorOrg: intel.com
Message-ID-Hash: NNX56MBPTVLGQGEHRONNUHIDNXEE44YM
X-Message-ID-Hash: NNX56MBPTVLGQGEHRONNUHIDNXEE44YM
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NNX56MBPTVLGQGEHRONNUHIDNXEE44YM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Yes, I am running this on ubuntu.
And I will sent it as a formal fix patch later.

-----Original Message-----
From: Dan Williams <dan.j.williams@intel.com> 
Sent: Friday, December 27, 2019 1:49 AM
To: Li, Redhairer <redhairer.li@intel.com>
Cc: linux-nvdimm@lists.01.org
Subject: Re: [PATCH] daxctl: Change region input type from INTEGER to STRING.

On Wed, Dec 25, 2019 at 6:22 PM Li, Redhairer <redhairer.li@intel.com> wrote:
>
>
>
> Build error is solved by following change.
>
> diff --git a/test/Makefile.am b/test/Makefile.am index 
> 829146d..d764190 100644
> --- a/test/Makefile.am
> +++ b/test/Makefile.am
> @@ -98,10 +98,10 @@ ack_shutdown_count_set_SOURCES =\  
> ack_shutdown_count_set_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS)
>
>  blk_ns_SOURCES = blk_namespaces.c $(testcore) -blk_ns_LDADD = 
> $(LIBNDCTL_LIB) $(KMOD_LIBS)
> +blk_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS) $(UUID_LIBS)
>
>  pmem_ns_SOURCES = pmem_namespaces.c $(testcore) -pmem_ns_LDADD = 
> $(LIBNDCTL_LIB) $(KMOD_LIBS)
> +pmem_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS) $(UUID_LIBS)
>
>  dpa_alloc_SOURCES = dpa-alloc.c $(testcore)  dpa_alloc_LDADD = 
> $(LIBNDCTL_LIB) $(UUID_LIBS) $(KMOD_LIBS) @@ -143,6 +143,7 @@ 
> device_dax_LDADD = \
>                 $(LIBNDCTL_LIB) \
>                 $(KMOD_LIBS) \
>                 $(JSON_LIBS) \
> +               $(UUID_LIBS) \
>                 ../libutil.a

Ah, sorry about that.

Hmm, are you running this on top of Ubuntu?

We have had a long standing problem whereby Fedora autoincludes some library dependencies and Ubuntu does not.

    011fc692270b ndctl, test: add UUID_LIBS for list_smart_dimm

Please send this as a formal fix patch.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
