Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD32E286C59
	for <lists+linux-nvdimm@lfdr.de>; Thu,  8 Oct 2020 03:09:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C9BC215482E45;
	Wed,  7 Oct 2020 18:09:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5841A1539973D
	for <linux-nvdimm@lists.01.org>; Wed,  7 Oct 2020 18:09:04 -0700 (PDT)
IronPort-SDR: RYCIpA0I11UrLNE1/YtVqFUJAzq1gxfTGZQSK1yVbyHhSHSFdlghScfD9z7UrtwP/FC3umo080
 ADkwaMW55wXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="165280011"
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400";
   d="scan'208";a="165280011"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 18:09:03 -0700
IronPort-SDR: 0t0XHxpGYakI7sfBKQKueajEDq0hDXtY2CB2OQ4PpJaFm9cEcnY9+7AZfxi0PqWKUnwPbz/ydp
 bF1GTcTuzn4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400";
   d="scan'208";a="355189803"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 18:09:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Oct 2020 18:09:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 7 Oct 2020 18:09:02 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.56) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 7 Oct 2020 18:09:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntvRgpinKBnqqpAEQ6CSfdkEybBPAA1k6Ivo1S6ynOD1ZtKPCy2DnW1WyJJLCOHsvZW6ta/PDtvzYXlo6iHt62SFhGKM18cwQ4VKd1RhUINokL0F2CnziOVmr0wt6V1I9TUXL4IR1NHWntRbuCbzfusYaE2FH7gFeEL0GDALPbD7DCUX5fdo+S5cvcdRfRFLeRwHUm/JZgmb5Y8HyzN3uMr6JPaTZkz4as8jfLTCWs6HtAsSuPGUGt0Xw4QzqxeW9B/4Kq0iGM1PT4NhshP/IbaIqJKxk5S16FK/q+88+7RzVevhqghcp563zw/adwn4WcZRL3zPwMMspZK+1km9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qtx2zfq7NuISEbLNu/Y+fz4yXjvwUrWmdNgFiOsphIg=;
 b=no6i/dYj/GhPByYwb2ottmVvQcwka5YlRcGeQxFjF0I3Vk11yQ+r30GLtMiOMIRL3hm5/3iScYzpfNYWq9l8JhUTHON9hGbfPXQGtN4SNrBpuj57upuZKsAqRhnqblw7LsvNeftIP5hhaZypqmdGYCZrbZJkA2+HB28RzqCMgbxeHPdNdR3VE/V3ySzDSLxfJWVTbh2lfLS+IkWM/do5NGNwkOTwYS5drBKki2wkHBFIky6yNKXnd6FPe6Bum3SLPaydTHYiiFsoXX5h/8OAtgMoB4nkk3Fj63MGlKacGS2idnl0b+MYnaRhvuBUIfTq8qevlXa44DKtzebR+70pHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qtx2zfq7NuISEbLNu/Y+fz4yXjvwUrWmdNgFiOsphIg=;
 b=dGTBn96QBHxm6wqnQuT/U5m8FxEQCevk7EkNqyM+c3yYPDbLFN9YLu7cdoQpy3MuT2o2U9CG4k0NHPvEnoLzMhgNo1KfQwasfTZvv8Vx3owS0CS08dhU5uUhhNNfU//hI4sZCxDoNpEo6WNB9Um65Ug13rqS3/73/kDQ43dSNdY=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3224.namprd11.prod.outlook.com (2603:10b6:a03:77::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Thu, 8 Oct
 2020 01:08:59 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::ecd4:8f8f:fa3d:f63d]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::ecd4:8f8f:fa3d:f63d%7]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 01:08:59 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] build: Use asciidoc instead of asciidoctor on RHEL
Thread-Topic: [ndctl PATCH] build: Use asciidoc instead of asciidoctor on RHEL
Thread-Index: AQHWnEGIoBn/Qs1pVk6F9T60tr17DKmM5q6A
Date: Thu, 8 Oct 2020 01:08:59 +0000
Message-ID: <e643806275e52c5a67da9ca38276b0806a4ad893.camel@intel.com>
References: <160202971887.2226623.15926843846532516993.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160202971887.2226623.15926843846532516993.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dee5c15b-e205-479d-ad66-08d86b26bcb4
x-ms-traffictypediagnostic: BYAPR11MB3224:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB32248008B181E406E0ACAEE3C70B0@BYAPR11MB3224.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mb+BTtjJsGzzS3IJB1/c0qQMXdOJcGzexnMTSihyBeHnkDIsjejXfRo6vSLgk+TPMCoorseUvda5tZU+AjJJjJWtMhiFB7XIlULheOKhSVuwPU0N39lxlUOQ8zSXA9rwpIacbJQiKmouPajQa4a2NRrwGJDT2gJPZQUEknmrcC+OEtJUZmll2i+mySgDZYk+Tz/CAt9SUGYOd7UTBTR60wZ3kSwTOdKKOiI77yAmKKHxjKf7HMg060Y5d3bnwE59LGBQCCZbSxN/Y0DKjtV25McqaRVFsbGVTX/tnAoMgOfFrbG4SzUFbBJftj5QpcqLMgKJFczR+JzAP+R5KGI+GVlQJw71aYxJ01G1Tt676iTlrR0heGr4E7TISTHI7E7vlEblhwAVdgvqA3xoP+xBCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(64756008)(66446008)(66556008)(6506007)(66946007)(8936002)(6486002)(478600001)(5660300002)(66476007)(76116006)(26005)(91956017)(83380400001)(186003)(71200400001)(966005)(316002)(4326008)(83080400001)(8676002)(86362001)(6636002)(2616005)(6512007)(2906002)(6862004)(36756003)(37006003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KyrJbNGao0j9ABcyDfSqruFLg2dms1BeXcGv8OAQkqfIJFww+rWLVAXh8FIl7j0isZTcH34WisqLhwydu0ao9fMycIc9fQEigSSO46jWT8a4iRDZVtbTQzKWClFrbVWWUk9EO6AQq4BFjgx6aZlvT8gVJNISb5SjmEfpC+U/VYD8G55+0PFEZqqlqPBcfpPfIAUzJebSDCSZFUF29iqQADvwtHX6HIIZktAi3dS4YgXiAd3Yby3CPYtLxfMzi1hfJZazzJzC4eHVD8IWrlUap2ccPIx9b9O+OsCbqMHCRiWrzQg6FohJnaHAQZTp0xlf0pg5Mf6TKNYguqEM8wriQHkCtTEyfarrdcOBbgqIDYImW2iwrDUHRT8UjPRt9wrshd0BwSUIS1m8anqiPWSIimSVcKD2iGbyM2EawrN/wbnmtCkGqNKm/3xZz2YTmOzbadD6m1/baaYTfBUUV0gS6IY2CXHvlqRo+20bzrpBgcWunVXkUOK0YN3+XHMdTUDN0hqzOYAWRPjyHjJBmrqJZFAOtY3iu+/45C/Nt9WMEjrI0mKjtYltlcIU23vk5QnbB8vog+u9NwUb81P50/FoJRE4vT+w9mZg1SywjBNJO8WhwMnIJPjcevTzQaCjEofRIkaxh53+UbklbQfaifZcog==
Content-ID: <89F03ABF90D4B047838C2CC1B936F22E@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee5c15b-e205-479d-ad66-08d86b26bcb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 01:08:59.0392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJSbOvqiG9IidYM5IANdnNskRky8qpdsYUk0CHIPsGxdkuYpUJeLAT8honWaXBoQhsdefMQdWC69Si56BMQvMtAn9lYrIL4VwpHJI4yCiAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3224
X-OriginatorOrg: intel.com
Message-ID-Hash: NCBNXONIE6DHRWMFP3L2M35OFU2P7MTT
X-Message-ID-Hash: NCBNXONIE6DHRWMFP3L2M35OFU2P7MTT
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NCBNXONIE6DHRWMFP3L2M35OFU2P7MTT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2020-10-06 at 17:15 -0700, Dan Williams wrote:
> Until RHEL moves to asciidoctor fallback to the old asciidoc for RHEL
> builds.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  ndctl.spec.in |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Thanks Dan - looks good!
I applied this and tested with a copr build for el8, and it all looks
good:

  https://download.copr.fedorainfracloud.org/results/djbw/ndctl/epel-8-x86_64/01698754-ndctl/

> diff --git a/ndctl.spec.in b/ndctl.spec.in
> index 94e15ad309c5..056c53069082 100644
> --- a/ndctl.spec.in
> +++ b/ndctl.spec.in
> @@ -9,7 +9,12 @@ Source0:	https://github.com/pmem/%{name}/archive/v%{version}.tar.gz#/%{name}-%{v
>  Requires:	LNAME%{?_isa} = %{version}-%{release}
>  Requires:	DAX_LNAME%{?_isa} = %{version}-%{release}
>  BuildRequires:	autoconf
> +%if 0%{?rhel} < 9
> +BuildRequires:	asciidoc
> +%define asciidoc --disable-asciidoctor
> +%else
>  BuildRequires:	rubygem-asciidoctor
> +%endif
>  BuildRequires:	xmlto
>  BuildRequires:	automake
>  BuildRequires:	libtool
> @@ -86,7 +91,7 @@ control API for these devices.
>  %build
>  echo %{version} > version
>  ./autogen.sh
> -%configure --disable-static --disable-silent-rules
> +%configure --disable-static --disable-silent-rules %{?asciidoc}
>  make %{?_smp_mflags}
>  
>  %install
> 

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
