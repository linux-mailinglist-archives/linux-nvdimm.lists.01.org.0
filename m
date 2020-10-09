Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A857289134
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Oct 2020 20:36:32 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E1FC113FD8773;
	Fri,  9 Oct 2020 11:36:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A9D4A13A09DC9
	for <linux-nvdimm@lists.01.org>; Fri,  9 Oct 2020 11:36:27 -0700 (PDT)
IronPort-SDR: nLW+qjWzBHVFc07DxWpKfUW+0osgktIMuWhtuomcMQQAgNei4ugR17PaS3ruyQ+4LvjSCB7Yv3
 rrKM1BXEaXKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="162886618"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="162886618"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:36:26 -0700
IronPort-SDR: pKYHOfDDom2W5XRzyweTRdzL/NEt5f4YXTk5cJ6/cGthW9ZtV9aefY1ofQxBWs/4cmvTbfk77r
 bG2gI7Wu7KWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="343956112"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2020 11:36:26 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 9 Oct 2020 11:36:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 9 Oct 2020 11:36:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 9 Oct 2020 11:36:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5eEbXtASfIXrOjZnNTx3cixO55bwnJwphduHJjdszkpcwWslgL4E5yz2X+md7sglM7nWOpoZZzto0X2VXiCVJCzySDzboj49AWqZaQD4G6r1vgw3rubNKLsdMnJBG6EOv2Iu3SUBkD6Q3InTjL2KLkw8We84m1aFPPjLxkwhBWE1evR//7dLEpmtQIHrouPnyqTr9aPydqgmAT+z4SOZtdzWbBz48I4uU3zMlR0Syg+NAcON0HczlqsaePG71A23wo7miUZNQc3ndJ7LSv4dn7YODg4+/X5q+zmaYqyGK3WVUk7xJzotHXs7z8JqCr9E/DN6PvGZEX97m5txHPMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umHlGNt24zmjQxyevY8NDbbJOYF4fqjvu+x5V5TI1yU=;
 b=dsQJiLDnOIehTFV6DPFJAiHJQl38P5WojOhmcFGXkShh6Iq01JeVzBctrnV515IRYwoJH9RYkRQcv8vK+jjdu+cZUaGi7VmYzJGTo8prgxUZWvMnEdTVxfBSEdpkr5Ds4ytT+48QqSJMcNAokKhjb7jpeqKgQMZD04/GGHvaHYFSIQwTOQ2xtUNKpBYEjX2ZNiV8uYzv2mfY3E4QExSaYbr0h0c/3n1hMXml0tdFmEUq1hVDymY9w+UqiYmWd37ArOgRecdE/xSGpsnScPqR0ywR9HDlP3k6yqO3MaVp3gj5B+ccQWvlGf8ttRyTCxrvP+RBDmDdU40OuApeCzha9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umHlGNt24zmjQxyevY8NDbbJOYF4fqjvu+x5V5TI1yU=;
 b=blt3BzlQ75H0TMWwMvCPZRlnUkop4rzrKJDj5gVlvr6Lf9O3wkzQeMLyItbwNXS8oMOUGm+k0FnMU7D2HkaragSY7W4LkxRYpB90vuJ4PQ7mF3/BZhO2MUZ1zBQxrZwnDfknsC+mk5fO7EpHf0YBhSFcHyaEp5jnEhAscxPKC2k=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by SJ0PR11MB4942.namprd11.prod.outlook.com (2603:10b6:a03:2ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Fri, 9 Oct
 2020 18:36:22 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::ecd4:8f8f:fa3d:f63d]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::ecd4:8f8f:fa3d:f63d%7]) with mapi id 15.20.3433.046; Fri, 9 Oct 2020
 18:36:22 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>
Subject: Re: [ndctl PATCH] libndctl: Fix probe of non-nfit nvdimms
Thread-Topic: [ndctl PATCH] libndctl: Fix probe of non-nfit nvdimms
Thread-Index: AQHWnjPt3S7EHDLwI0m5ReX4Dyi3FqmPmcKA
Date: Fri, 9 Oct 2020 18:36:22 +0000
Message-ID: <145db3d86fa6bddf55c0e7c4aa149984676cd723.camel@intel.com>
References: <20201009120009.243108-1-vaibhav@linux.ibm.com>
In-Reply-To: <20201009120009.243108-1-vaibhav@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bf68800-1b1c-4862-e6f3-08d86c8238dc
x-ms-traffictypediagnostic: SJ0PR11MB4942:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB4942B6F450362B8999B95D26C7080@SJ0PR11MB4942.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: egkUPM6iVY57Nd9rko+623DBA7jCtQSFfNcfwcVgGTd1gUKywp+AEzSot4HMEbhbEVkr+/ZYmjlrsPNRoZaFFkysgaA+I/0iEh+PNSJbHyvM+3aTqn/ueXHUf9bEkC47E2fL6Lbvq75wRPRbvFDDPcAu5k1/cj9pi+3R7+AHoSo3hdV44uPOOXCHTLFvj6RV7hoOyLQsXkoku4ONJuZ3tGZzklr+fnaaJrIp63iZOfS1T5pJ6x7cBqRQRtMW32vHVe5BiW3ItwyKx+dilTQDzoK+1H4Se+eJOFFapqb1m4OkJ6hB+ymWhLJ0JwGxW6WJKoG6gb1K2RcbysEy98WDRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(8676002)(6486002)(5660300002)(8936002)(66946007)(2906002)(76116006)(86362001)(66476007)(66556008)(64756008)(66446008)(316002)(110136005)(6506007)(54906003)(26005)(186003)(478600001)(6512007)(36756003)(2616005)(71200400001)(4326008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jMhw777OBh6UlbISrtGkurU9Yp7AglpUn68Gxn/891IdKhqrYxxLnSxIi/jh3SPg4ciRbg3jyXVQAiZeLglTqh1BAezO7MTn4ae3CUuUHrwQ/pC33KoBu22JMaFJtTveX4Vu7dCb+4Uu4AoH7sdSBGcc65FaX2L3AqC7sYfolo9tdutIDgTNhrEK6qdXOF4VxViC6sMUAKb2xnMtREMe+DUnqJ37JPc+uKK+6rkTO4+79zPICwfX9tMa5DkfJyCde+w6RSBxw3JLGJRxXmCRbR0cNreQ8rNwh+y83HJY0RWg4m6WtIIzlc5eWMC3rt0zaxLGT/B7ku6UJ4jJBmnMJfFtiC92m0rTlvxLv+7Afa/88ic4fHreq4+Ucsy5WLFGWGu4SE4Mce9/GiYtFF58XxjA5KHxOVPHZfSY4Cca86QgP/I62Kupew6BsdKJOmxetSvKoG+gqkCzsTEj4pxSUaWbD84W8e0Jf4ZheoSlupK1zErY0klIbvrOJo89CZLEVWHsiu2KPWHbLaJH/wQOodF6C2uQrhce4EeFvSyI+sXkMrsCxKRy0Ml9NhSDA9h165QKvG/jDsa0Nob4oho9nI18h7KtuSukyfpjpxzLX/6mTsd+AddVrBKo6kGJr5E0JawZ/Ok9EJt0gu3d2arl8g==
Content-ID: <D9ED843FD0DB5F43A9B9D7E31941CCE2@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf68800-1b1c-4862-e6f3-08d86c8238dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2020 18:36:22.6875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8HWZvgfylNJkaHp7M/sqdSn4P890F61Ex/7YGqmFk553lW1tEJFNbOrAljN1xdNaVxX4yW1OUFvwLSnM+w9cRj6N0oH9mFEy/AX7cE7aqGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4942
X-OriginatorOrg: intel.com
Message-ID-Hash: ATITPJUGUNX73HCA4GZQH534PGD5Z76P
X-Message-ID-Hash: ATITPJUGUNX73HCA4GZQH534PGD5Z76P
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ATITPJUGUNX73HCA4GZQH534PGD5Z76P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2020-10-09 at 17:30 +0530, Vaibhav Jain wrote:
> commit 107a24ff429f ("ndctl/list: Add firmware activation
> enumeration") introduced changes in add_dimm() to enumerate the status
> of firmware activation. However a branch added in that commit broke
> the probe for non-nfit nvdimms like one provided by papr-scm. This
> cause an error reported when listing namespaces like below:
> 
> $ sudo ndctl list
> libndctl: add_dimm: nmem0: probe failed: No such device
> libndctl: __sysfs_device_parse: nmem0: add_dev() failed
> 
> Do a fix for this by removing the offending branch in the add_dimm()
> patch. This continues the flow of add_dimm() probe even if the nfit is
> not detected on the associated bus.
> 
> Fixes: 107a24ff429fa("ndctl/list: Add firmware activation enumeration")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  ndctl/lib/libndctl.c | 3 ---
>  1 file changed, 3 deletions(-)

Ah apologies - this snuck in when I reflowed Dan's patches on top of the
papr work for v70.

I expect you'd like a point release with this fix asap?

Is there a way for me to incorporate some papr unit tests into my
release workflow so I can avoid breaking things like this again?

I'll also try to do a better job of pushing things out to the pending
branch more frequently so if you're monitoring that branch, hopefully
things like this will get caught before a release happens :)

> 
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index 554696386f48..ad521d365ee4 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -1875,9 +1875,6 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
>  	else
>  		dimm->fwa_result = fwa_result_to_result(buf);
>  
> -	if (!ndctl_bus_has_nfit(bus))
> -		goto out;
> -
>  	/* Check if the given dimm supports nfit */
>  	if (ndctl_bus_has_nfit(bus)) {
>  		dimm->formats = formats;

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
