Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7558C1BB342
	for <lists+linux-nvdimm@lfdr.de>; Tue, 28 Apr 2020 03:10:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D05B1107B779;
	Mon, 27 Apr 2020 18:09:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5D5121107B772
	for <linux-nvdimm@lists.01.org>; Mon, 27 Apr 2020 18:09:12 -0700 (PDT)
IronPort-SDR: 7u0/wiWnzzz43oBVFrH52PuHg8Ct7v9tLDc5MiMNhTnq0vjjqIB4GSp6HTicdiMh0wJilRYk2z
 Od3gF0eIr5Hg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 18:09:57 -0700
IronPort-SDR: t6CWvKwN/jX8hu3JVmWcMsDRahT2frPVoOg4wbs3OxPrivRE+QPjjAGl87OaLuAcybzATpYJF2
 7GihLgDk1M4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400";
   d="scan'208";a="257458272"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga003.jf.intel.com with ESMTP; 27 Apr 2020 18:09:56 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 27 Apr 2020 18:09:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 27 Apr 2020 18:09:55 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 27 Apr 2020 18:09:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 27 Apr 2020 18:09:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpUuvcvMcKYURsQtHJ+c9nfw959thBE3N7MSwiv9pRTMPHne2YPPyBvLzGAWCMwVVHC3UcbZ4/ARUfYnsHPPJTNAX84P/9HMnmKmVsqt2IUqVVe4f6zC3I7bJ5FyNuNqih74qCjR7U3m5FBcBg8KOmxK+aeIAqDA9zdKdkd5smKLJqK3zjGsJz81r+QFOFJ071tZJN4LJ2vzzUaAa2Q7oxZx6MdhqcZp+wofUz/YZHxqA5ZnxzkVGoTAkJG8Tv23q2CCa+i5DPsnv1Z/m6d9H3oHUkzfzI9I6pzZCWposTH2vf9JOoVvgsDeFNNI8wIJ60V7omiG1jaDHktAbO++wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEbeKvYKcaIHO+5rZiPKEcHEThLIf+HSceWBxpBnFMU=;
 b=hIZDKzVmB7QA15D8IbdiRSSRicbmoDtM1Q/PYWmAESdqbgjYBlO3V6KqsCN/umO8Tvv2EYHtdVDb7Rxba1ZPk8L7pCbwypxlQHoiGPo4k12ySsAHBoj/aucTQjYHL7EBqmUIzfFBYp8OE2gu65A8aSoainIQyM3hnQ+XSGJuccGo1xtZwYyvpBhTk1t5QEu13QlVo3jp416Grh4iqbvUe/daf2KL4B9rz5gtNjRA8OAzMFnoCz5vJ5yXSm2OtUlHRn2e/xoZdk3MypUdjFuB728N/73rFNV5t3mXR3kkMojmIgPYjlth6gxhDzBnIFDPRfZH1oQL1N+VSVGQyLpZ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEbeKvYKcaIHO+5rZiPKEcHEThLIf+HSceWBxpBnFMU=;
 b=oVEOvqtLsnIzW66zB8mxyrt3ZsAH+8H1zo8SzqjLqrB007rtIhorvaj7mNp0C/sEyRWdh38A3Lbvfpj8D+0BeCdydy3XwhM7VNj46m8hzK6KaQYcMRSvaLjb8plt2dk9DGH2s+NRMsygMDyx9Hc8IOE941mA9U7q2M3gniGBFIw=
Received: from BL0PR11MB3281.namprd11.prod.outlook.com (2603:10b6:208:66::33)
 by BL0PR11MB3107.namprd11.prod.outlook.com (2603:10b6:208:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 01:09:51 +0000
Received: from BL0PR11MB3281.namprd11.prod.outlook.com
 ([fe80::9407:1d70:3e2f:14cd]) by BL0PR11MB3281.namprd11.prod.outlook.com
 ([fe80::9407:1d70:3e2f:14cd%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 01:09:51 +0000
From: "Li, Redhairer" <redhairer.li@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting
 relative to seed devices
Thread-Topic: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting
 relative to seed devices
Thread-Index: AQHWG7CUEqHPklcSv0ShOYKNTanBh6iNbjmAgAA9/+A=
Date: Tue, 28 Apr 2020 01:09:51 +0000
Message-ID: <BL0PR11MB3281CBD1CC9B64389731ECE492AC0@BL0PR11MB3281.namprd11.prod.outlook.com>
References: <20200426095232.27524-1-redhairer.li@intel.com>
 <CAPcyv4gLKSMa4bN446MnRtjdfGaM-Hjy+dcYm316=4EP43G1wg@mail.gmail.com>
In-Reply-To: <CAPcyv4gLKSMa4bN446MnRtjdfGaM-Hjy+dcYm316=4EP43G1wg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: request-justification,no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=redhairer.li@intel.com;
x-originating-ip: [36.230.143.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5612827c-2694-4d16-c2c5-08d7eb10da87
x-ms-traffictypediagnostic: BL0PR11MB3107:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB31070C7F0367AC2C0761774992AC0@BL0PR11MB3107.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3281.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(376002)(366004)(346002)(136003)(86362001)(478600001)(6862004)(4326008)(71200400001)(2906002)(7696005)(33656002)(53546011)(6506007)(186003)(81156014)(8936002)(316002)(8676002)(55016002)(9686003)(26005)(52536014)(76116006)(66946007)(64756008)(5660300002)(66446008)(66556008)(66476007)(6636002)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zr58KH02MhnfZWxbzaU2dwuqRE3nlNgaDry3/bdcygJnTVJgQWr7g6ckdJhoyUadJ5pd2MT0ocjtb4MgXqji7Tm6IXlwiTaqUAmDLovxE+syC6AGD9kBArUx968xmF6weygnYK6EO2btX6vCu7RmtvSTf8HnvjCluAJ9DG2TXUhpS9ailCsz9Pi1toh0hA1f4mEzi9GZFKqx6DsuT9oIKs0t2gMP6qSLGoL5GG5NtnpZDHQSX2aWXSrxj7Y0jyN45S7Bd2Dsao86UEJT+issy7dvVZfmgtSU4TDrvr3YZs+xhsxTUckf0NaCPaUY/2gBSMnY3rTcOsQThJcGzT8/3gJ9LB4r9JbHwqtyi46wUFQWq7l8T4nI0c4GVvaKa2LW77wRx6tHsBafnrKXtP51LW5E/+k19lh7z8LDlbNIKJl/DFay17GJ7Fu0m+RrPDep
x-ms-exchange-antispam-messagedata: CEDZTm5H9CcfEOrL5kkzu13esAfrbynuAaPFJ5cxo4nI0KnY84XXlw49vlg80NtR96/mWhKsbGtmaLsJORezsCP1bcZ5/ecbgiBeVwtXf6Tt1SOI6Rzma2+6UdBT+D6f0rJZMhtq2QwZfDbyoZTLWQED5ysEXkONvWVcjDGdrpjA4yNfSURWwl5v4jGLyUgcg3xPNxuBuRfyUhPNkDUxkzCjYi7+eu5NlO2BFp2rRudW+4lLHonzFbxVHqyJbJdpwen8Vdgc5SqZOxaQ1sYyy9VJA5D5PJ42xGc0UaaWxkbRokEeLxpIWyqbT0hEhIyiObPM3xiC9iuYZD6k2b+i7m1xUvilDTicRRTPfhakgJG1SGOvvV0didbFNFhoLK8kGIB7qptk9G6yOYa1iE7ny3zRUdjCPAVon4X/7q1qT57Qoo2LJ6QBw8jne3FFzK/o0BuCFbCNmAre6TyedxdHuIWdHq+z1liG/X1iXX38NSY5eA6RITZ9b92SZgK2Hbu6w/u1Lgd+cOLH2Ls+t4v4cmSAaVWoEysGR2mdNaB6JhdYNDh2sUHfeuriEhGHwlqKWN6RAqilBc2Y1mh/dbKJpd4rk9OSQTzPOmP+FSV0Unlb//P9usq7pPGVUOyyqxLyRSRtE4csqWIyQ4C3oXQCX8aMZDWylWHpb+Qj5y0LhTGNeK6v0w9xue9jWkGiJJbOyvvULGjpS9VJ/CIP5N6K8kEjRGMwAGed8v3S++6XFRFz0DM/Ojgnud4Ega+Kth7NPSe0XUXVQ/y0pAiXWN+ZXP6r0tfPsMpLnbCYnyLgLQs=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5612827c-2694-4d16-c2c5-08d7eb10da87
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 01:09:51.3749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7549q7s+tlv7OqXp4kU1qh47QxS87W4KnfVN6FaBMg4K6pQvpiLaxeilt54TAZeTnt9rCHSc/g0tarVJLq4Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3107
X-OriginatorOrg: intel.com
Message-ID-Hash: Y5CKOA3JPFNLR3FLPJ4NNPAYOFPWTKG6
X-Message-ID-Hash: Y5CKOA3JPFNLR3FLPJ4NNPAYOFPWTKG6
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y5CKOA3JPFNLR3FLPJ4NNPAYOFPWTKG6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

If make this return 0 in the case when size is zero, then seed device will be counted in due to
				case ACTION_DISABLE:
					rc = ndctl_namespace_disable_safe(ndns);
					if (rc == 0)
						(*processed)++;
					break;
I ever think make it return 1.
It also can return correct number which not count in seed device.
But there will be no error msg when I disable seed device.
It will make user confuse.
Eg.
root@ubuntu-red:~/git/ndctl# ndctl/ndctl disable-namespace namespce0.0
disabled 0 namespace

So I follow enable-namespace to return -ENXIO and it will look like
root@ubuntu-red:~/git/ndctl# ndctl/ndctl disable-namespace namespce0.0
error disabling namespaces: No such device or address
disabled 0 namespaces

But no matter return -ENXIO or 1, it will make test/create.sh fail. This is why I modify region.c
+ modprobe nfit_test
+ ../ndctl/ndctl disable-region -b nfit_test.0 all
disabled 0 regions
+ ../ndctl/ndctl zero-labels -b nfit_test.0 all
nmem1: regions active, abort label write
nmem3: regions active, abort label write
nmem0: regions active, abort label write
nmem2: regions active, abort label write
zeroed 0 nmem
++ err 28
+++ basename ./create.sh
++ echo test/create.sh: failed at line 28

-----Original Message-----
From: Dan Williams <dan.j.williams@intel.com> 
Sent: Tuesday, April 28, 2020 4:31 AM
To: Li, Redhairer <redhairer.li@intel.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting relative to seed devices

On Sun, Apr 26, 2020 at 2:53 AM Redhairer Li <redhairer.li@intel.com> wrote:
>
> Seed namespaces are included in "ndctl disable-namespace all". However 
> since the user never "creates" them it is surprising to see 
> "disable-namespace" report 1 more namespace relative to the number 
> that have been created. Catch attempts to disable a zero-sized namespace:
>
> Before:
> {
>   "dev":"namespace1.0",
>   "size":"492.00 MiB (515.90 MB)",
>   "blockdev":"pmem1"
> }
> {
>   "dev":"namespace1.1",
>   "size":"492.00 MiB (515.90 MB)",
>   "blockdev":"pmem1.1"
> }
> {
>   "dev":"namespace1.2",
>   "size":"492.00 MiB (515.90 MB)",
>   "blockdev":"pmem1.2"
> }
> disabled 4 namespaces
>
> After:
> {
>   "dev":"namespace1.0",
>   "size":"492.00 MiB (515.90 MB)",
>   "blockdev":"pmem1"
> }
> {
>   "dev":"namespace1.3",
>   "size":"492.00 MiB (515.90 MB)",
>   "blockdev":"pmem1.3"
> }
> {
>   "dev":"namespace1.1",
>   "size":"492.00 MiB (515.90 MB)",
>   "blockdev":"pmem1.1"
> }
> disabled 3 namespaces
>
> Signed-off-by: Redhairer Li <redhairer.li@intel.com>
> ---
>  ndctl/lib/libndctl.c | 11 ++++++++---
>  ndctl/region.c       |  4 +++-
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c index 
> ee737cb..49f362b 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -4231,6 +4231,7 @@ NDCTL_EXPORT int ndctl_namespace_disable_safe(struct ndctl_namespace *ndns)
>         const char *bdev = NULL;
>         char path[50];
>         int fd;
> +       unsigned long long size = ndctl_namespace_get_size(ndns);
>
>         if (pfn && ndctl_pfn_is_enabled(pfn))
>                 bdev = ndctl_pfn_get_block_device(pfn); @@ -4260,9 
> +4261,13 @@ NDCTL_EXPORT int ndctl_namespace_disable_safe(struct ndctl_namespace *ndns)
>                                         devname, bdev, strerror(errno));
>                         return -errno;
>                 }
> -       } else
> -               ndctl_namespace_disable_invalidate(ndns);
> -
> +       } else {
> +               if (size == 0)
> +                       /* Don't try to disable idle namespace (no capacity allocated) */
> +                       return -ENXIO;
> +               else
> +                       ndctl_namespace_disable_invalidate(ndns);
> +       }

Maybe make this return 0 in the case when size is zero since by definition the namespace must already be disabled if it has zero size.

} else if (size)
    ndctl_namespace_disable_invalidate(ndns);

return 0;

>
> diff --git a/ndctl/region.c b/ndctl/region.c index 7945007..0014bb9 
> 100644
> --- a/ndctl/region.c
> +++ b/ndctl/region.c
> @@ -72,6 +72,7 @@ static int region_action(struct ndctl_region 
> *region, enum device_action mode)  {
>         struct ndctl_namespace *ndns;
>         int rc = 0;
> +       unsigned long long size;
>
>         switch (mode) {
>         case ACTION_ENABLE:
> @@ -80,7 +81,8 @@ static int region_action(struct ndctl_region *region, enum device_action mode)
>         case ACTION_DISABLE:
>                 ndctl_namespace_foreach(region, ndns) {
>                         rc = ndctl_namespace_disable_safe(ndns);
> -                       if (rc)
> +                       size = ndctl_namespace_get_size(ndns);
> +                       if (rc && size != 0)
>                                 return rc;

...then you wouldn't need to have this special case here since
ndctl_namespace_disable_safe() will not fail.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
