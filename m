Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3E712A9B2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Dec 2019 03:22:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2A17410097F27;
	Wed, 25 Dec 2019 18:26:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9E8EE10113665
	for <linux-nvdimm@lists.01.org>; Wed, 25 Dec 2019 18:26:12 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Dec 2019 18:22:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,357,1571727600";
   d="scan'208";a="230002446"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga002.jf.intel.com with ESMTP; 25 Dec 2019 18:22:51 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Dec 2019 18:22:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 25 Dec 2019 18:22:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JANg5tHa80DmONuBJpuU/DzEolgI3k1g+8xqolrTaqrJzTpC4wRM18nl8dPxRvPmTNz+vner1KQm7Y0kLCvnRKRxzFiv8FRlh1nu38KuyVAcnPQIvDiG/DRPxj3Abrma5n1PkZRck57IHhLT3zMG/2XBC63IqaRa/JO4kgO0grSvz8H/x+m/UqqI5gzvFHWevf2TyqKvVfl0ylmfk/QQJiaSEIItkA8ntQO9j8qMKpfrg0LvW4LAKsGWh/ILKzRB90QI/VEdRJNM5Nac2fUdEtsvx6wKla9JqrTONC2Vy32EHqbOTERBJqGcwqCAh5fjTUa7umNfJGsLdn0os9WTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkFMXkcSPUE2dN7l+IBiMSn7jZoK8+oHF2MC3yPEg0k=;
 b=kNou1wMdbwlq26JrUsyJJgZOh5UwmfO0TV3rIJVhe86aLhZU42agB1zrBi1PLQq1nYd6Ad7kJVrzpcJQd7ceHS9SUfH2op1Urx+MuV3z3rlP2bOMosUFWLPSQ083XulQ/BYNGqnMLXTCQS52oF92kBBC/fH09Tves8z+PSk2nmgXciFX8yacBh8vQx0r/LeUJm+FSlYtgV283Hbn1EOyyYt5vorqcNbKtvyq/M+zQO9MzE9Z0ILOyxqT8wUJxF/ovpuH79oBlAc0fIfb4X2FDLvmKl+itpF1ibf42+6NkHwiQ/JPPu4F8kZ73NNtbt+Rbu2P/tV/IsT0Chp+xUOUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkFMXkcSPUE2dN7l+IBiMSn7jZoK8+oHF2MC3yPEg0k=;
 b=R96OWBI1e0eOPsLbCo3iDPZKaiTdzpw5wjvGUl0sa+4b+HkQnZVLrEaRi2s37lIO00mwDUGgVkhsPelJRx8vQEY0Wa50FJ043Pb0uVh0bZLllbL222iO3ANV5uBImv7RrvzrPyBk/W9Alz6p9H5n566Ms0/VXDOuaPmErrVnWQU=
Received: from SN6PR11MB3264.namprd11.prod.outlook.com (52.135.111.80) by
 SN6PR11MB2877.namprd11.prod.outlook.com (52.135.93.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 26 Dec 2019 02:22:49 +0000
Received: from SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::78f3:73f9:eaff:d25c]) by SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::78f3:73f9:eaff:d25c%7]) with mapi id 15.20.2559.017; Thu, 26 Dec 2019
 02:22:49 +0000
From: "Li, Redhairer" <redhairer.li@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH] daxctl: Change region input type from INTEGER to STRING.
Thread-Topic: [PATCH] daxctl: Change region input type from INTEGER to STRING.
Thread-Index: AdWqSy7tSheIw9IbRFeymChi7Sx2XP//fIUA/99j/4CAQ1rRAP//ul5A//9ohUA=
Date: Thu, 26 Dec 2019 02:22:49 +0000
Message-ID: <SN6PR11MB3264617D4EA3C3C4706C7C6D922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
References: <2369E669066F8E42A79A3DF0E43B9E643AC9EB31@pgsmsx114.gar.corp.intel.com>
 <CAPcyv4jTS+JcmH=Oe3Js0dw+Ovu+P6yBKHDZp8xxUT6Rbhpaqw@mail.gmail.com>
 <SN6PR11MB3264D981A619065F1A4EFFB992280@SN6PR11MB3264.namprd11.prod.outlook.com>
 <CAPcyv4iP1NK=2funtr6yp9VhedntKvzkvBsXDkLLXt6FBZYO=A@mail.gmail.com>
 <SN6PR11MB3264C140FEB5C66679095AFF922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB3264C140FEB5C66679095AFF922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTRmYWVmYjktNGZhMC00MWExLWJhZGEtNjU3NWYzMzg0YTMwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQ1NaN29FMXd0bFp0U0d2S1NmbURlaURua1wvUXQ0dkRcL2JvXC9TOGRJUVwveGxSY3BRXC9vem5TYXRZQUMwY1VFaTB3In0=
x-ctpclassification: CTP_NT
dlp-reaction: request-justification,no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=redhairer.li@intel.com;
x-originating-ip: [192.55.52.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 496e903a-d95e-4752-da8c-08d789aa80ad
x-ms-traffictypediagnostic: SN6PR11MB2877:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2877568EBD015C5157ACA492922B0@SN6PR11MB2877.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39860400002)(189003)(199004)(13464003)(81166006)(66446008)(8936002)(81156014)(2906002)(2940100002)(7696005)(66946007)(86362001)(76116006)(53546011)(316002)(33656002)(8676002)(71200400001)(66476007)(66556008)(64756008)(6506007)(4326008)(186003)(26005)(6862004)(478600001)(9686003)(6636002)(55016002)(52536014)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2877;H:SN6PR11MB3264.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QUawtxjJH2uhMuvD0D2PGwGBah6nzHohG+PpEhas+K1Oz8fQfjJ9fyKHO7zg/U0i6YUVuCm9ubazxIeMw0xFkZwoAed86ZYtQ3J9PToWAqy3Oab8YTxUk89pCwqBMGl4uQ0Axt+HjL3OaAv048n2P63nnBgJByRcJUoLNWxsRUCWSFadYrxfKnhJm6MocAuKJup9QvqbOfhp0oJwu4PzC6iVhQPZbintNCRsKc5rN5sSuoHV+06A9D2teVQIKd6zXY8Ubj1I4BS6ou5fOiXiBkegAo8vegSHcEdFvgekqczOHlKJfJP+Nu6rPc6JpAhvgPmZsJKbooxBk5Tvmoh2KtkRH87CtqBVmzOIDEdrGnMTgyVoIjbKOQ2tW7tQ8fbjzdvNOW+MjUaNWBMdDEyLsTiTYimzKKvoI0RnNMmUl6XRFw8wmATFItZCQv5KJ3hu0tMKPv028s/3OniwZ/vEegPhWhhLIOIPLBAAY32e7YYDN4x48TkEfgQ+YwqaN9X2
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 496e903a-d95e-4752-da8c-08d789aa80ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 02:22:49.1178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/u1ZvJrqvV7Qj+xaCuptsmyAj2WICDrHonzH3Z8SvfT9Cf1uR3x1Fl0q0PrYEkxnvSFsqbzf1ePtZzJgVdxEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2877
X-OriginatorOrg: intel.com
Message-ID-Hash: 7WAFAQV6JLNSYCURU3AFOQEMHZELSFJO
X-Message-ID-Hash: 7WAFAQV6JLNSYCURU3AFOQEMHZELSFJO
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7WAFAQV6JLNSYCURU3AFOQEMHZELSFJO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



Build error is solved by following change.

diff --git a/test/Makefile.am b/test/Makefile.am
index 829146d..d764190 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -98,10 +98,10 @@ ack_shutdown_count_set_SOURCES =\
 ack_shutdown_count_set_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS)

 blk_ns_SOURCES = blk_namespaces.c $(testcore)
-blk_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS)
+blk_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS) $(UUID_LIBS)

 pmem_ns_SOURCES = pmem_namespaces.c $(testcore)
-pmem_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS)
+pmem_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS) $(UUID_LIBS)

 dpa_alloc_SOURCES = dpa-alloc.c $(testcore)
 dpa_alloc_LDADD = $(LIBNDCTL_LIB) $(UUID_LIBS) $(KMOD_LIBS)
@@ -143,6 +143,7 @@ device_dax_LDADD = \
                $(LIBNDCTL_LIB) \
                $(KMOD_LIBS) \
                $(JSON_LIBS) \
+               $(UUID_LIBS) \
                ../libutil.a

 smart_notify_SOURCES = smart-notify.c


-----Original Message-----
From: Li, Redhairer 
Sent: Thursday, December 26, 2019 9:48 AM
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org
Subject: RE: [PATCH] daxctl: Change region input type from INTEGER to STRING.

I try "--enable-destructive".
But I always see the following msg when I run "make check" and "make TESTS=daxctl-devices.sh check".
Do I miss anything here?


/usr/bin/ld: blk_namespaces.o: undefined reference to symbol 'uuid_generate@@UUID_1.0'
//lib/x86_64-linux-gnu/libuuid.so.1: error adding symbols: DSO missing from command line
collect2: error: ld returned 1 exit status
Makefile:850: recipe for target 'blk-ns' failed
make[3]: *** [blk-ns] Error 1
Makefile:1477: recipe for target 'check-am' failed
make[2]: *** [check-am] Error 2
Makefile:785: recipe for target 'check-recursive' failed
make[1]: *** [check-recursive] Error 1
Makefile:1079: recipe for target 'check' failed
make: *** [check] Error 2

-----Original Message-----
From: Dan Williams <dan.j.williams@intel.com> 
Sent: Thursday, December 26, 2019 5:18 AM
To: Li, Redhairer <redhairer.li@intel.com>
Cc: linux-nvdimm@lists.01.org
Subject: Re: [PATCH] daxctl: Change region input type from INTEGER to STRING.

On Wed, Dec 25, 2019 at 2:33 AM Li, Redhairer <redhairer.li@intel.com> wrote:
>
> Hi Dan,
>
> I don't see any failure even apply my patch.
> What failure do you observe?

I see the failure in the daxctl-devices.sh unit test. That test and others are included in the "destructive" set of unit tests. They are classified "destructive" because they write to platform persistent memory resources instead of the emulated nfit_test resources. You need to pass "--enable-destructive" to the configure script at build time to enable the destructive tests.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
