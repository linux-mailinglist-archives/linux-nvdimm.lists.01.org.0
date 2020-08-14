Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCDE244FFA
	for <lists+linux-nvdimm@lfdr.de>; Sat, 15 Aug 2020 00:56:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 70968131A5196;
	Fri, 14 Aug 2020 15:56:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8DC8C131A5195
	for <linux-nvdimm@lists.01.org>; Fri, 14 Aug 2020 15:56:16 -0700 (PDT)
IronPort-SDR: hq28ebqKJ2PZ56kv3G6IAiVJEO1wPpZ0QkwITA9ZTdewDxJlVCjpjoPjmftuzCT0t7QrQiro3v
 R8MEjJJfErDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="218826289"
X-IronPort-AV: E=Sophos;i="5.76,313,1592895600";
   d="scan'208";a="218826289"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 15:56:14 -0700
IronPort-SDR: jGxjcOjVPF1nD0sfIwbBtkkq7alEJpkURYLR81SmBfa5skL0MhhytA/vn6ferncs4ZBTFRH5XP
 OeLdqQKeCCpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,313,1592895600";
   d="scan'208";a="291865190"
Received: from fmsmsx601-2.cps.intel.com (HELO fmsmsx601.amr.corp.intel.com) ([10.18.84.211])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2020 15:56:13 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Aug 2020 15:56:13 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 14 Aug 2020 15:56:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 14 Aug 2020 15:55:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkBoi6G4TJjUFL7NR5KGoS5f3LW6qLoR1n3A+7jiVsksZw1mFEHUIHnwdwP4XqJGarIS6VhuDLG4ghI4IMr4AJHKxAk1jyHMBzNWmdYSuaRgBXOheK5NSZFP+Goi2kwe6R1iUKwhq14aDEmWUMVuokoEpv+tCK9RMuXNtEj3gOk47c2oqHW4wVNob/zTTXshbiemrhasYNI4tf/6+/Ue5pNO2PLQr18CkGOiJaorMKLoHp/yM/v+1Eft3UN+5YDBaSjppEAmeKyJRkaQM3WfE7Tt0ZLUfenQ0A3ZhutWI+pVrkrdjs0ZsDkt2oyatbD2pMvewsx1Lxi/yJFPLsfmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSBTxjlCc1k/auq6OVPW2S1EvmNXDCwEPhXFj5G/jDk=;
 b=JGXrftxFrdepfXDDhrJCbWm5+lhBwlmiTCQgit3jPiAGijzBbwnFG7cR+ehYlvINjSQcBt7vPvhR+8I60KqfqblUL617/tl0CNdWxErm0umvEY1GRKhFIdtHddUqqqXl2PWEKwAHQ6fhKOG+jOgb5+5hv1mWpFftxLetJhZ+YcRML2q/5BP3jiOhaASUJEo9l3dqTMmvhFaLHCEmrOhcSwc/rIdqHwkq4nUp010O9nJ9UxraVFo6KHid28fWiwNwN0ZqTOxEItrmAJm93WICDZXcGqUjnhUu931mwEQk9d/Zc8I7dZ3Nia8G9rqcDQVXaWHYjFZ1C41YWjK2KhJhDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSBTxjlCc1k/auq6OVPW2S1EvmNXDCwEPhXFj5G/jDk=;
 b=mBAIbl5395IDubiF7KVhXnLURcqVvrvj9Yd6FDZxvREmZSavOmyr8WtuNDamiBw44vAJQivIaqbXx0Hqk2VPhvVvY1l8u++55lS4t13qXQ22EnI3df8Z7fTzkyeIGzPEo36qHYM2z4IXw9IPnbikdRqaIokvHSTM1t+6pXWGGLg=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3671.namprd11.prod.outlook.com (2603:10b6:a03:b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Fri, 14 Aug
 2020 22:55:29 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::1084:a79c:5a4f:f115]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::1084:a79c:5a4f:f115%5]) with mapi id 15.20.3283.016; Fri, 14 Aug 2020
 22:55:29 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Weiny, Ira" <ira.weiny@intel.com>, "vaibhav@linux.ibm.com"
	<vaibhav@linux.ibm.com>
Subject: Re: [PATCH] libnvdimm: Add a NULL entry to
 'nvdimm_firmware_attributes'
Thread-Topic: [PATCH] libnvdimm: Add a NULL entry to
 'nvdimm_firmware_attributes'
Thread-Index: AQHWckx4y0fiAEVmJkid5IaXXixqHqk31uoAgABgfgA=
Date: Fri, 14 Aug 2020 22:55:29 +0000
Message-ID: <e8ab54c4e147cbfe037a6aa5926d0cd74346a684.camel@intel.com>
References: <20200814150509.225615-1-vaibhav@linux.ibm.com>
	 <20200814171005.GB3142014@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200814171005.GB3142014@iweiny-DESK2.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8be6eaba-c7ce-4aad-19c6-08d840a52461
x-ms-traffictypediagnostic: BYAPR11MB3671:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB36711D0BB3CB0140D3F00DB7C7400@BYAPR11MB3671.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fyZHsV4fjtfGvzMNElJ+M/9p0EKxG4LFr2WUVn5Jg+V5QP9QJTlBGq5wSZ885CoIXEkzPSHA6qdNTA4r9cHLBmTEZSOxO1wBr9TjhfCqx4urfx/efUxD+btLn+J4hLsOop15h1YUpUO+8Mc0tA9Wh0ZmfOuEqdftYEEIzPIPKPQwWohtwh6auKYZTfup9ZWyyW3Z4DzuMHFfb9G8JYUh6Ipbk6vZmETs+rNWLx0gXQVHJkRachkw843P1eBx63O27t4O4Hh1tlBJiQmBoOVX6A6iLyT7uWP6jXowmh55hkC9+AfEwwmx3PfX22X05D2OyVK/tIsrZBOmUFoYfouTNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(54906003)(26005)(4326008)(66446008)(66556008)(66476007)(64756008)(66946007)(110136005)(83380400001)(478600001)(6506007)(316002)(8936002)(6512007)(2616005)(2906002)(71200400001)(6486002)(86362001)(5660300002)(186003)(8676002)(36756003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +b8Ur00uUaKJGUcFTKBf0zywk42EsHZfMt8tAoevw48A5etbS0pgapyDS/0hZotc/K1sOh8AmwOf9d9IAdrPidqDdNnkLondxN1Apg0YsyE4TaUsq3p2SgptHFFIpwfIQipjxZEdoA/DKQ400d1sNJ6TdNl1XTcWt/oxMt+icWtUqq3gzj9Q2btdqqOLt6ogrRsL+z2hrRkDUfQ2wL1zV5q7CkGmJtHwIIC9hWgee1wrm4/m8af9qMBWi3tqya42MI8MaoQXGqDkDPsY2nr4JjiSCaovW5lA+9jz9dWaxw7CvJ43KFILi7T1GaUjihz4tpdLyJz7pyEwK+fIaJuqW7BhA6tvZ3FUUMStjBK+p2AjECya4MyKLQSVYV3a0UvLtDQ/HCMJiqDsm+KDgBmugy73KZP/qKLOHwHLMX49/If0aGmTLOW66/ju5Vv6WXneKp9x3/EfZOY6FpIHi2wMb03iVldSu/9ShIIZHBgzFQe0sJsMVC2BuxoYlzbzAWZzgd7ixx0ZOgiTAla5OPKUmOPuEz9sNkmW1aQbVZ6F1vx0gs7B4X+JRBQ7tIRWHWmu9UytrtcnyqMrnlYbrJc0jdzpNq8W9TgQlv4ZlWNPwyIrf7HaR879YmyBfTILZsGB/w2kf3YHGQaUtQdpscYVdQ==
Content-ID: <7034EB549DB1854E96890AFE09C6BDC9@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be6eaba-c7ce-4aad-19c6-08d840a52461
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 22:55:29.5271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0GWQaKlpvqEWs9xmOPy2uijLTSnikxJBe4ggHU7pudZcfOZT3jg3KDFeWO5+D8lFsOx2H8ZbuAKrUtBpYoolZmmMAgbX8clwXJMxF2k0Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3671
X-OriginatorOrg: intel.com
Message-ID-Hash: Q6RWLYPATQEZ3SVXPMM43PR5SVGO2V4P
X-Message-ID-Hash: Q6RWLYPATQEZ3SVXPMM43PR5SVGO2V4P
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>, "sandipan@linux.ibm.com" <sandipan@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q6RWLYPATQEZ3SVXPMM43PR5SVGO2V4P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2020-08-14 at 10:10 -0700, Ira Weiny wrote:
> On Fri, Aug 14, 2020 at 08:35:09PM +0530, Vaibhav Jain wrote:
> > We recently discovered a kernel oops with 'papr_scm' module while
> > booting ppc64 phyp guest with following back-trace:
> > 
> > BUG: Kernel NULL pointer dereference on write at 0x00000188
> > Faulting instruction address: 0xc0000000005d7084
> > Oops: Kernel access of bad area, sig: 11 [#1]
> > <snip>
> > Call Trace:
> >  internal_create_group+0x128/0x4c0 (unreliable)
> >  internal_create_groups.part.4+0x70/0x130
> >  device_add+0x458/0x9c0
> >  nd_async_device_register+0x28/0xa0 [libnvdimm]
> >  async_run_entry_fn+0x78/0x1f0
> >  process_one_work+0x2c0/0x5b0
> >  worker_thread+0x88/0x650
> >  kthread+0x1a8/0x1b0
> >  ret_from_kernel_thread+0x5c/0x6c
> > 
> > A bisect lead to the 'commit 48001ea50d17f ("PM, libnvdimm: Add runtime
> > firmware activation support")' and on investigation discovered that
> > the newly introduced 'struct attribute *nvdimm_firmware_attributes[]'
> > is missing a terminating NULL entry in the array. This causes a loop
> > in sysfs's 'create_files()' to read garbage beyond bounds of
> > 'nvdimm_firmware_attributes' and trigger the oops.
> > 
> > Fixes: 48001ea50d17f ("PM, libnvdimm: Add runtime firmware activation support")
> > Reported-by: Sandipan Das <sandipan@linux.ibm.com>
> > Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Thanks Vaibhav and Ira. I see this was also reported and fixed by Zqiang
a couple days ago. I'll pick that, merge these trailers and add it to
the fixes queue.

> 
> > ---
> >  drivers/nvdimm/dimm_devs.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> > index 61374def51555..b59032e0859b7 100644
> > --- a/drivers/nvdimm/dimm_devs.c
> > +++ b/drivers/nvdimm/dimm_devs.c
> > @@ -529,6 +529,7 @@ static DEVICE_ATTR_ADMIN_RW(activate);
> >  static struct attribute *nvdimm_firmware_attributes[] = {
> >  	&dev_attr_activate.attr,
> >  	&dev_attr_result.attr,
> > +	NULL,
> >  };
> >  
> >  static umode_t nvdimm_firmware_visible(struct kobject *kobj, struct attribute *a, int n)
> > -- 
> > 2.26.2
> > 
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
