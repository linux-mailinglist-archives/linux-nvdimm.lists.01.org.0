Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C8812AA21
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Dec 2019 05:01:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CC32A10097F2C;
	Wed, 25 Dec 2019 20:05:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D371F10097F2A
	for <linux-nvdimm@lists.01.org>; Wed, 25 Dec 2019 20:05:15 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Dec 2019 20:01:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,357,1571727600";
   d="scan'208";a="419362904"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga006.fm.intel.com with ESMTP; 25 Dec 2019 20:01:55 -0800
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Dec 2019 20:01:54 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Dec 2019 20:01:54 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 25 Dec 2019 20:01:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0vjBLi/ZCu/ytcsLL3/vnKeIfDnXzjRC9WBiR9Hgpuje/YqCTM+MdUlqEbXLfNYXEgjepUiYMMO2b1CVMUGOKUhl5A/BPjIEPNxmZgKUQUiZrBVGSh2Kpbj+V43Ahio3eMPIhv6IOJh3vK1Or3zVjmb3OLINlSmb4G3RaN+5+MfuFS5tka7KaF5TxgBhxsxagEPxUbon1jTB1nf7Y6PvddQ7wbK79dVb8zw/yrIeuw2y76OjNRUmwXQX10jQbDPGH4V7Yw31+zQC7CIA17fWOZ/smc3bSTAndff5dd0XJvYTk3pCTqJWlm8hBCfnBLRSaaR1nmETccxnNbjAIzkJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBSyjGTzXgcux/Jk/MHwsZYAlaeocNBJ0KdzOi/g79E=;
 b=ORWqJsG5hjoxXUm7LwjOnCPzAuKiHmaIxkJDOwUW6crlgyY04AiMBKQe8FDp+nmWWJkvIcdlT7O1l1T8nJMubCv0BYssNbDIHlgrZ6hfQetrvOeF2exm6f8W6kURwb366l7cc2TiS3UyPaOujbHYmpXpyidOwAG+6A6ObukjC7KnPu6iLbVs2g3ZQgZ+dRLycGLEcbtLbPCHsnXF5LO2HIW+nDjFuWJbBHXzTXFiPtq8I3pWUxf/s3GOnX7Fo+PAoZ18fg3uUGDabIo/6YBBTWtRcv5mptAA0j5y97pAxi23JuwHmKsMRkHYhNa1XuSDzjL/dhNOvsgSqYeIk9MikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBSyjGTzXgcux/Jk/MHwsZYAlaeocNBJ0KdzOi/g79E=;
 b=FMvqF8TazZ7jEQGFrpw++yZTtCOaIhjzTmpUsCzUPYZ5iS/K0VwBWKe5ThouVvZ2mq019VanfwnPfthmcV3vXwp6732B4LMwA8shioBlx4O/+K8RcXEjKPR2luWFsnXRCkUKajgTcWo3ZEWCgJHs8mO9uuxJN8pP8cXcM0qxXlw=
Received: from SN6PR11MB3264.namprd11.prod.outlook.com (52.135.111.80) by
 SN6PR11MB3023.namprd11.prod.outlook.com (52.135.125.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 26 Dec 2019 04:01:50 +0000
Received: from SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::78f3:73f9:eaff:d25c]) by SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::78f3:73f9:eaff:d25c%7]) with mapi id 15.20.2559.017; Thu, 26 Dec 2019
 04:01:49 +0000
From: "Li, Redhairer" <redhairer.li@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH] daxctl: Change region input type from INTEGER to STRING.
Thread-Topic: [PATCH] daxctl: Change region input type from INTEGER to STRING.
Thread-Index: AdWqSy7tSheIw9IbRFeymChi7Sx2XP//fIUA/99j/4CAQ1rRAP//ul5A//9ohUD//saYwA==
Date: Thu, 26 Dec 2019 04:01:49 +0000
Message-ID: <SN6PR11MB32647968C27C92C1D3A5B7D8922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
References: <2369E669066F8E42A79A3DF0E43B9E643AC9EB31@pgsmsx114.gar.corp.intel.com>
 <CAPcyv4jTS+JcmH=Oe3Js0dw+Ovu+P6yBKHDZp8xxUT6Rbhpaqw@mail.gmail.com>
 <SN6PR11MB3264D981A619065F1A4EFFB992280@SN6PR11MB3264.namprd11.prod.outlook.com>
 <CAPcyv4iP1NK=2funtr6yp9VhedntKvzkvBsXDkLLXt6FBZYO=A@mail.gmail.com>
 <SN6PR11MB3264C140FEB5C66679095AFF922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
 <SN6PR11MB3264617D4EA3C3C4706C7C6D922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB3264617D4EA3C3C4706C7C6D922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 4ca44f61-bd44-4563-70fd-08d789b8559c
x-ms-traffictypediagnostic: SN6PR11MB3023:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB302323BAAA545C71F50DE5BC922B0@SN6PR11MB3023.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:112;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(136003)(346002)(13464003)(20264003)(199004)(189003)(478600001)(4326008)(33656002)(71200400001)(316002)(6636002)(6862004)(9686003)(7696005)(55016002)(66476007)(64756008)(66446008)(76116006)(8936002)(5660300002)(186003)(26005)(6506007)(52536014)(66556008)(86362001)(2940100002)(81166006)(66946007)(8676002)(81156014)(53546011)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB3023;H:SN6PR11MB3264.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M/IPrR3GIN1Bq00BMXi/e3iGrpelDfbsWS97fIxZrsG+wGtC/xvXKzFsVqEcKajr1Mj7/yv97s3txKLyF/xsKZCFv8krIEF+c/kprTaPFsvS+FtMRsbECZWjU0vR7JvXIMuBVBxSDcMqAz7ETgV47yEipUqI+TZXdTHKwUFZEuh+iJAmO1xB0GvyuHks1PoqEdx3TUrsYC1NL+r9gE7XkmKLUWeS1D8H1te/5YC9N6nbFhD4ZZeUf15XHNJl2b0RSKoRXOlz5Bhm9Y99sdVApbDzeifUIrB5xZUmZMPcPV4K4UzW0HcfFDnLD3BxfGM94iKEQki2yBz1PD0+fpWb7XUhd0ecJNWaLQk0AQ3Tff3kC3+iwCqJMBSKYr2ucMrSwXA6f4VAs9wN8ovlOBMrB3oGtbWA5t8ZNJjO431Fq58TG3EbXTn/RQSSEWkE6/kAyPcXoLsfqO7Bd7YFcUy7e3TS8jBa05jZf0CSlu+92WOn6oPOvZB7EwoU47PZRV8l3qbbqQvehIGx4Sv9BZM6mQ==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca44f61-bd44-4563-70fd-08d789b8559c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 04:01:49.5920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ML2UfneryMMkZSwW3BxFMMFp22mGjZFY/6H4xn3cSpcGnZDJZdNAAV1D3C0xAGO6WIQR6gMvqMN/Gt5HLWUcYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3023
X-OriginatorOrg: intel.com
Message-ID-Hash: TK4N6W2FAF2Y7US6ROPSWYRS7ZAWV7QB
X-Message-ID-Hash: TK4N6W2FAF2Y7US6ROPSWYRS7ZAWV7QB
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TK4N6W2FAF2Y7US6ROPSWYRS7ZAWV7QB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I saw daxctl-devices.sh is still failed before I apply my patch.

root@ubuntu-red:~/git/ndctl# vi test/test-suite.log
=========================================
   ndctl 67.dirty: test/test-suite.log
=========================================

# TOTAL: 1
# PASS:  0
# SKIP:  0
# XFAIL: 0
# FAIL:  1
# XPASS: 0
# ERROR: 0

.. contents:: :depth: 2

FAIL: daxctl-devices.sh
=======================

+ rc=77
+ . ./common
++ '[' -f ../ndctl/ndctl ']'
++ '[' -x ../ndctl/ndctl ']'
++ export NDCTL=../ndctl/ndctl
++ NDCTL=../ndctl/ndctl
++ '[' -f ../daxctl/daxctl ']'
++ '[' -x ../daxctl/daxctl ']'
++ export DAXCTL=../daxctl/daxctl
++ DAXCTL=../daxctl/daxctl
++ NFIT_TEST_BUS0=nfit_test.0
++ NFIT_TEST_BUS1=nfit_test.1
++ ACPI_BUS=ACPI.NFIT
++ E820_BUS=e820
+ trap 'cleanup $LINENO' ERR
+ find_testdev
+ local rc=77
+ modinfo kmem
filename:       /lib/modules/5.4.0-rc5_red_ndctltest_VM/kernel/drivers/dax/kmem.ko
alias:          dax:t0*
license:        GPL v2
author:         Intel Corporation
srcversion:     A0712EA9D9E63723E6B4CDA
depends:
retpoline:      Y
intree:         Y
name:           kmem
vermagic:       5.4.0-rc5_red_ndctltest_VM SMP mod_unload
signat:         PKCS#7
signer:
sig_key:
sig_hashalgo:   md4
+ testbus=ACPI.NFIT
++ ../ndctl/ndctl list -b ACPI.NFIT -Ni
++ jq -er '.[0].dev | .//""'
+ testdev=namespace0.0
+ [[ ! -n namespace0.0 ]]
+ printf 'Found victim dev: %s on bus: %s\n' namespace0.0 ACPI.NFIT
Found victim dev: namespace0.0 on bus: ACPI.NFIT
+ setup_dev
+ test -n ACPI.NFIT
+ test -n namespace0.0
+ ../ndctl/ndctl destroy-namespace -f -b ACPI.NFIT namespace0.0
destroyed 1 namespace
++ ../ndctl/ndctl create-namespace -b ACPI.NFIT -m devdax -fe namespace0.0 -s 256M
++ jq -er .dev
+ testdev=namespace0.0
+ test -n namespace0.0
+ rc=1
+ daxctl_test
+ local daxdev
++ daxctl_get_dev namespace0.0
++ ../ndctl/ndctl list -n namespace0.0 -X
++ jq -er '.[].daxregion.devices[0].chardev'
+ daxdev=dax0.0
+ test -n dax0.0
+ ../daxctl/daxctl reconfigure-device -N -m system-ram dax0.0
libdaxctl: daxctl_dev_disable: dax0.0: error: device model is dax-class
libdaxctl: daxctl_dev_disable: dax0.0: see man daxctl-migrate-device-model
dax0.0: disable failed: Operation not supported
error reconfiguring devices: Operation not supported
reconfigured 0 devices
++ cleanup 74
++ printf 'Error at line %d\n' 74
Error at line 74
++ [[ -n namespace0.0 ]]
++ reset_dev
++ ../ndctl/ndctl destroy-namespace -f -b ACPI.NFIT namespace0.0
destroyed 1 namespace
++ exit 1
FAIL daxctl-devices.sh (exit status: 1)

-----Original Message-----
From: Li, Redhairer 
Sent: Thursday, December 26, 2019 10:23 AM
To: 'Dan Williams' <dan.j.williams@intel.com>
Cc: 'linux-nvdimm@lists.01.org' <linux-nvdimm@lists.01.org>
Subject: RE: [PATCH] daxctl: Change region input type from INTEGER to STRING.



Build error is solved by following change.

diff --git a/test/Makefile.am b/test/Makefile.am index 829146d..d764190 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -98,10 +98,10 @@ ack_shutdown_count_set_SOURCES =\  ack_shutdown_count_set_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS)

 blk_ns_SOURCES = blk_namespaces.c $(testcore) -blk_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS)
+blk_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS) $(UUID_LIBS)

 pmem_ns_SOURCES = pmem_namespaces.c $(testcore) -pmem_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS)
+pmem_ns_LDADD = $(LIBNDCTL_LIB) $(KMOD_LIBS) $(UUID_LIBS)

 dpa_alloc_SOURCES = dpa-alloc.c $(testcore)  dpa_alloc_LDADD = $(LIBNDCTL_LIB) $(UUID_LIBS) $(KMOD_LIBS) @@ -143,6 +143,7 @@ device_dax_LDADD = \
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
