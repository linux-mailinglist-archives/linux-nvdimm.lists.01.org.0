Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF512DBE91
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 11:25:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C74DC100EC1E3;
	Wed, 16 Dec 2020 02:25:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 459DF100EC1E1
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 02:25:17 -0800 (PST)
IronPort-SDR: 24we+fkaPAcYA+JnyFA3zGu/Pj/4HVosKlkVAJWOd9BJ0RlxpeeJ2+phBXp7vyoAwLivv3MMXT
 SdjS2BHRWjQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="239136620"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400";
   d="scan'208";a="239136620"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 02:25:16 -0800
IronPort-SDR: sfEjGY0uhj4eZv+YgoO7aF6RTqPPWnoB+qYMIt7lIMP+Ve+pQ4MIPJNMYaV7p3dmLv0rRwOP/R
 NelJ20jVun0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400";
   d="scan'208";a="384409953"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 16 Dec 2020 02:25:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Dec 2020 02:25:15 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Dec 2020 02:25:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 16 Dec 2020 02:25:15 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 16 Dec 2020 02:25:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+b1VUzzQJBWZ3tbhGa5oP/NLCoUag/R2Gbmg0DnN5aNMBgBmT/2S0QJqcp/H8Sl5TW8S9UFnSiZtYYZwKNDQ/1qWnWPO9Toq49iX2lhao0eYlPForvgSuDIonKToE78o979c1E+i+8zJDjo9N05KeJrtjjPwfesDEVmqeM1KHC9NLvNG6NUZEn4CtPqii5Hd9KywbcDgarCBznKjQ2y9XZz5EjJgKm4+toflLJnFVlNq1uo0zHkAWIiAyzoXBXI6YrRurQhdRuzuuVQmLBGgCrIM0SqloO/e8qBYqxHxaXIE9RLUQ9x6SIrYaNlB1ano65Z9TbKih2YT75tBleFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4REJo6u66xHkS3M0TM5nHi+ECSESM8EPTBDodmhZ1ak=;
 b=WPMUtUKJ80hDMyD1QH/+xdd+eSMONokZBeEFJiDwKkg+xpt+pCABB2/fA+HgfayNIHQGqss6ZJA1yLrUCt+n0E5giVXVKtmKBhwwuSSpTaRnxpTCKA9nOKxO28o9mM9Hs/LnfrtFPOItNyRzpfFvKfirMB0cny8VVb5qSgdYdk1IUDVGSS6EIpV9Ba93xdwxNBoinlZhcudu8m8TURHfVeXt91Oj5ssf3+/j6qzwX6b3zWN1mejJ+XbEfJPLUbkbqzBfWP76R41EQZMLllJqIKsQDDM902Ke9999vCSGXDpC6ZuBJ0K1YOTgvZbB9Vw+vRZATUQb8xKVpHDPFH5NTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4REJo6u66xHkS3M0TM5nHi+ECSESM8EPTBDodmhZ1ak=;
 b=UMqf+RR1RdOH1qc4rRUsq6gyON/8Zy4kEpTFSmvx8rhIIUDKCY2flPnUfVVy0JTXuZjzBEzqW0uxgH3iF7c/Nf+DQAV0wwPCftbUJNpDiinkwfuYuNWZ8gNQCX7gnN3Xbpdpza0KkgjEHXUSj9+Ghqw/6a391FoFFAu0wT0cI70=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3350.namprd11.prod.outlook.com (2603:10b6:a03:1a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Wed, 16 Dec
 2020 10:25:12 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae%7]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 10:25:12 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>
Subject: Re: [PATCH ndctl v2 10/10] daxctl/test: Add tests for dynamic dax
 regions
Thread-Topic: [PATCH ndctl v2 10/10] daxctl/test: Add tests for dynamic dax
 regions
Thread-Index: AQHWWS/+CocEkUdsuUO3WJ5KKdcmHKkSwLoAgN6XlACACSB9gA==
Date: Wed, 16 Dec 2020 10:25:12 +0000
Message-ID: <68ae54e05494ca82db67107bb1f44b982146b5bf.camel@intel.com>
References: <20200713160837.13774-1-joao.m.martins@oracle.com>
	 <20200713160837.13774-11-joao.m.martins@oracle.com>
	 <5cf76b3d-21db-daf9-dc1d-d38714a9a7c2@oracle.com>
	 <42e0711f-b26b-65af-4f12-efb28b07a096@oracle.com>
In-Reply-To: <42e0711f-b26b-65af-4f12-efb28b07a096@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63716a9b-5a1a-4403-08c9-08d8a1acdf5f
x-ms-traffictypediagnostic: BYAPR11MB3350:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB33503607BD9E4117C9844216C7C50@BYAPR11MB3350.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZYB6OEkzKt9uDYj1KmELsP+RVrJWOE9FR+TDFOM62OxJQysdyKDZScqinm0kz8sEM1hHxUaBT549rQQez+kjJDmEG7rKzWjwftzp27aIp57/DGwgE17HPmCayD0WMcVkVu0gCj4BSncJg955waOqMjd0JbfN8viZybiAmIf7YfA/DAQiQvFhUkMcbLe8LV7+uSv8ZmAsvzrrVh0S5mGR++R/7rK4b2FYoLPaivF+4ZpP1khqFVwC70TaId/OClrDu3W7uy0nQYJ6Pe1C0M40BBmwQ/xeqAS7Ls2aGZolELIOExbCuq7MFZEDOElYzumH9WPp9rx+sDox7paiTpY9NdWdCRpUmCfczMACItjqICGmIZp95EXSOxiO8JHNCUka2kxPSfI1ubd36Qx51wtPhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(53546011)(6506007)(86362001)(6486002)(8676002)(66946007)(8936002)(316002)(66476007)(36756003)(2906002)(4001150100001)(30864003)(66556008)(64756008)(91956017)(76116006)(110136005)(6512007)(186003)(83380400001)(5660300002)(478600001)(71200400001)(26005)(4326008)(66446008)(966005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NUpVQmpWRU9INmNScjg1cDdwZWZ0YnNMQnhQcFR4eFRqa0lXTEZGM2VqVEVR?=
 =?utf-8?B?d3FDOEZhanpuN1FPdkoyVWkxeG55S2oxdG5sTFhVU2NCRURnUWhYc2R6cGRL?=
 =?utf-8?B?cEpaU3VIOVN2aUxtcllYQWdLb3QxV2FHM1lMbytLZGtKLzZ5cWhkbWhWalMw?=
 =?utf-8?B?S1Z0QmFVblQxL2FGZ2c1SFlpQkUzbitodUtPK2hCYnpvZit5ZTlXM2h3Qlo2?=
 =?utf-8?B?NGVBQWg3RmtNT2NBRzY1Z05yZ3FzSy8zRklZSnJFQnJpU2NqZHlLU0pneFln?=
 =?utf-8?B?d3UrZE1BS3o5R2wvNEVyVGR0MnFGVGk0OEpjOTJVZCtoVmdUZVVMSmo5M2ZV?=
 =?utf-8?B?bm5vdjJXTkhPelp2WmxYcThRdDdkZTNvRS9DUjU3N2FKZytITzZRUlBsSW9B?=
 =?utf-8?B?aEJZOXdvQWJIVWNGOE5Bd3BTTEtvU2VsT0kwR3hFbE9XeTU5aG1VWTBsdTFD?=
 =?utf-8?B?eitMMDRZT0pCUnVZdUdES1hWYXRlUjdVUnZWQXRxSWlVdHlPVC9xRFNlQ0dX?=
 =?utf-8?B?aXVDS2NhT2tub0NtSUlJdFoybVZmNk5uWGprTy9aVFcxUXg1Y3RwNDRpM2c0?=
 =?utf-8?B?QkVDVzR2K1F2bUhCQi91TzVhUEJiSGdnWGNwTEtzQm5ibHMxRzJEdFlHQm9v?=
 =?utf-8?B?ZlZQVWN1RjNZbjZxcExsQTF5OEo4cHZsUjEvZUpYTThKNGozbTRXRU5CSjZ2?=
 =?utf-8?B?YUFUWkx4aVNEaDRsWWhncndSUWoxcWFQc3oxTGZmSjltSXZoVW9NTGlCeWFp?=
 =?utf-8?B?VEhhdmV4Q3NzbTRrVEx3OG1ublpaMW9FTEcvQlppNGdTRGE4Z0RaMytBMGhF?=
 =?utf-8?B?amFrQm1VSmJhREQ1cVdvY0VzQ0VsRXBsRzR6OTJjd3VHVWlKa2dHRk9RdDJm?=
 =?utf-8?B?TGtpL0VNeUppSFU3VXNiL1JkN2d0aGJvQTc5UVd6MTNzcU1tVm04Qm9mNDAz?=
 =?utf-8?B?MmViNXNUZEJWUEJ5T29LN1A4VHdGVWliTVprd0dWL3FkMmNCekY2OEZ1WVR6?=
 =?utf-8?B?N25KbXg0aW54R0pzbjBGeWxNNzlteWc3NHFBWmRJSnVySHd6djk5cDUwMkdN?=
 =?utf-8?B?eTl4VlNjMmJaVEdKbVdlNm5iNEI4MHpObkZMQXZaL21kdFhOQ0xIL3FWMk54?=
 =?utf-8?B?cmtLZjc2dklnSWh2cGYvTlcxSWk0bGZsM0pMT3gzODVHNURQZTBBcUF5djhH?=
 =?utf-8?B?SEVaU2NYaCtHNDZjZUVsZ0MrUjJEUS9SNE1NMlhkY0EvcldNS1hxYWVHeE1D?=
 =?utf-8?B?RzZOM0lua1duYkNWZXhKZ3RJR3dlcGgvY2J4Tk1CbjBVY2t5TCtmOTJlWGw1?=
 =?utf-8?Q?75r/Os7gmZFX/dKo0qxQu4nXPYrTFerRQR?=
Content-ID: <78DCC6F0C97ACE479D3D65A36F3BB175@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63716a9b-5a1a-4403-08c9-08d8a1acdf5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 10:25:12.5310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOkfST0ikz2W33YQZABy0sblv1RZBSFN/+MxSyBYCnqNSqC+D+yq20f3T5+ueL+/8LL0mn4dw3EZziogUF9HZ9c7eGUa8Xe8hmXKa+LY9CM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3350
X-OriginatorOrg: intel.com
Message-ID-Hash: 2ZXXCOMNBNMXTBW7PFOT6OOJ4ASUDV5X
X-Message-ID-Hash: 2ZXXCOMNBNMXTBW7PFOT6OOJ4ASUDV5X
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2ZXXCOMNBNMXTBW7PFOT6OOJ4ASUDV5X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2020-12-10 at 15:01 +0000, Joao Martins wrote:
> On 7/21/20 5:49 PM, Joao Martins wrote:
> > On 7/13/20 5:08 PM, Joao Martins wrote:
> > > Add a couple tests which exercise the new sysfs based
> > > interface for Soft-Reserved regions (by EFI/HMAT, or
> > > efi_fake_mem).
> > > 
> > > The tests exercise the daxctl orchestration surrounding
> > > for creating/disabling/destroying/reconfiguring devices.
> > > Furthermore it exercises dax region space allocation
> > > code paths particularly:
> > > 
> > >  1) zeroing out and reconfiguring a dax device from
> > >  its current size to be max available and back to initial
> > >  size
> > > 
> > >  2) creates devices from holes in the beginning,
> > >  middle of the region.
> > > 
> > >  3) reconfigures devices in a interleaving fashion
> > > 
> > >  4) test adjust of the region towards beginning and end
> > > 
> > > The tests assume you pass a valid efi_fake_mem parameter
> > > marked as EFI_MEMORY_SP e.g.
> > > 
> > > 	efi_fake_mem=112G@16G:0x40000
> > > 
> > > Naturally it bails out from the test if hmem device driver
> > > isn't loaded or builtin. If hmem regions are found, only
> > > region 0 is used, and the others remain untouched.
> > > 
> > > Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> > 
> > Following your suggestion[0], I added a couple more validations
> > to this test suite, covering the mappings. So on top of this patch
> > I added the following snip below the scissors mark. Mainly, I check
> > that the size calculated by mappingNNNN is the same as advertised by
> > the sysfs size attribute, thus looping through all the mappings.
> > 
> > Perhaps it would be enough to have just such validation in setup_dev()
> > to catch the bug in [0]. But I went ahead and also validated the test
> > cases where a certain amount of mappings are meant to be created.
> > 
> > My only worry is the last piece in daxctl_test_adjust() where we might
> > be tying too much on how a kernel version picks space from the region;
> > should this logic change in an unforeseeable future (e.g. allowing space
> > at the beginning to be adjusted). Otherwise, if this no concern, let me
> > know and I can resend a v3 with the adjustment below.
> > 
> 
> Ping?

Hi Joao,

Thanks for the patience on these, I've gone through the patches in
preparation for the next release, and they all look mostly fine. I had a
few minor fixups - to the documentation and the test (fixup module name,
and shellcheck complaints). I've appended a diff below of all the fixups
I added.

I've also included the patch below for the mapping size validation. I
think the concern for future kernel layout changes is valid, but if/when
that happens, we can always come back and relax or adjust the test as
needed. So for now, I think having a pickier test should be better than
not having one.

> 
> > ----->8------
> > Subject: Validate @size versus mappingX sizes
> > 
> > [0]
> > https://lore.kernel.org/linux-nvdimm/CAPcyv4hFS7JS9s7cUY=2Ru2kUTRsesxwX1PGnnc_tudJjoDUGw@mail.gmail.com/
> > 
> > ---
> > 
> >  test/daxctl-create.sh | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 63 insertions(+), 1 deletion(-)
> > 

My fixups:

---

 Documentation/daxctl/daxctl-create-device.txt      | 18 +++-----------
 Documentation/daxctl/daxctl-destroy-device.txt     | 22 ++++--------------
 Documentation/daxctl/daxctl-disable-device.txt     | 22 ++++--------------
 Documentation/daxctl/daxctl-enable-device.txt      | 22 ++++--------------
 Documentation/daxctl/daxctl-reconfigure-device.txt | 19 ++++-----------
 Documentation/daxctl/human-option.txt              |  8 +++++++
 Documentation/daxctl/region-option.txt             |  8 +++++++
 Documentation/daxctl/verbose-option.txt            |  5 ++++
 util/filter.c                                      |  2 +-
 test/daxctl-create.sh                              | 76 ++++++++++++++++++++++++++++++------------------------------
 10 files changed, 82 insertions(+), 120 deletions(-)

---

diff --git a/Documentation/daxctl/daxctl-create-device.txt b/Documentation/daxctl/daxctl-create-device.txt
index 648d254..70029ab 100644
--- a/Documentation/daxctl/daxctl-create-device.txt
+++ b/Documentation/daxctl/daxctl-create-device.txt
@@ -71,12 +71,7 @@ EFI memory map with EFI_MEMORY_SP. The resultant ranges mean that it's
 
 OPTIONS
 -------
--r::
---region=::
-	Restrict the operation to devices belonging to the specified region(s).
-	A device-dax region is a contiguous range of memory that hosts one or
-	more /dev/daxX.Y devices, where X is the region id and Y is the device
-	instance id.
+include::region-option.txt[]
 
 -s::
 --size=::
@@ -87,16 +82,9 @@ OPTIONS
 
 	The size must be a multiple of the region alignment.
 
--u::
---human::
-	By default the command will output machine-friendly raw-integer
-	data. Instead, with this flag, numbers representing storage size
-	will be formatted as human readable strings with units, other
-	fields are converted to hexadecimal strings.
+include::human-option.txt[]
 
--v::
---verbose::
-	Emit more debug messages
+include::verbose-option.txt[]
 
 include::../copyright.txt[]
 
diff --git a/Documentation/daxctl/daxctl-destroy-device.txt b/Documentation/daxctl/daxctl-destroy-device.txt
index 1c91cb2..a63ab0c 100644
--- a/Documentation/daxctl/daxctl-destroy-device.txt
+++ b/Documentation/daxctl/daxctl-destroy-device.txt
@@ -38,23 +38,11 @@ Destroys a dax device in 'devdax' mode.
 
 OPTIONS
 -------
--r::
---region=::
-	Restrict the operation to devices belonging to the specified region(s).
-	A device-dax region is a contiguous range of memory that hosts one or
-	more /dev/daxX.Y devices, where X is the region id and Y is the device
-	instance id.
-
--u::
---human::
-	By default the command will output machine-friendly raw-integer
-	data. Instead, with this flag, numbers representing storage size
-	will be formatted as human readable strings with units, other
-	fields are converted to hexadecimal strings.
-
--v::
---verbose::
-	Emit more debug messages
+include::region-option.txt[]
+
+include::human-option.txt[]
+
+include::verbose-option.txt[]
 
 include::../copyright.txt[]
 
diff --git a/Documentation/daxctl/daxctl-disable-device.txt b/Documentation/daxctl/daxctl-disable-device.txt
index 383aeeb..ee9f6e8 100644
--- a/Documentation/daxctl/daxctl-disable-device.txt
+++ b/Documentation/daxctl/daxctl-disable-device.txt
@@ -33,23 +33,11 @@ Disables a dax device in 'devdax' mode.
 
 OPTIONS
 -------
--r::
---region=::
-	Restrict the operation to devices belonging to the specified region(s).
-	A device-dax region is a contiguous range of memory that hosts one or
-	more /dev/daxX.Y devices, where X is the region id and Y is the device
-	instance id.
-
--u::
---human::
-	By default the command will output machine-friendly raw-integer
-	data. Instead, with this flag, numbers representing storage size
-	will be formatted as human readable strings with units, other
-	fields are converted to hexadecimal strings.
-
--v::
---verbose::
-	Emit more debug messages
+include::region-option.txt[]
+
+include::human-option.txt[]
+
+include::verbose-option.txt[]
 
 include::../copyright.txt[]
 
diff --git a/Documentation/daxctl/daxctl-enable-device.txt b/Documentation/daxctl/daxctl-enable-device.txt
index 6410d92..24cdcf3 100644
--- a/Documentation/daxctl/daxctl-enable-device.txt
+++ b/Documentation/daxctl/daxctl-enable-device.txt
@@ -34,23 +34,11 @@ Enables a dax device in 'devdax' mode.
 
 OPTIONS
 -------
--r::
---region=::
-	Restrict the operation to devices belonging to the specified region(s).
-	A device-dax region is a contiguous range of memory that hosts one or
-	more /dev/daxX.Y devices, where X is the region id and Y is the device
-	instance id.
-
--u::
---human::
-	By default the command will output machine-friendly raw-integer
-	data. Instead, with this flag, numbers representing storage size
-	will be formatted as human readable strings with units, other
-	fields are converted to hexadecimal strings.
-
--v::
---verbose::
-	Emit more debug messages
+include::region-option.txt[]
+
+include::human-option.txt[]
+
+include::verbose-option.txt[]
 
 include::../copyright.txt[]
 
diff --git a/Documentation/daxctl/daxctl-reconfigure-device.txt b/Documentation/daxctl/daxctl-reconfigure-device.txt
index 8caae43..9a11ff5 100644
--- a/Documentation/daxctl/daxctl-reconfigure-device.txt
+++ b/Documentation/daxctl/daxctl-reconfigure-device.txt
@@ -121,12 +121,7 @@ refrain from then onlining it.
 
 OPTIONS
 -------
--r::
---region=::
-	Restrict the operation to devices belonging to the specified region(s).
-	A device-dax region is a contiguous range of memory that hosts one or
-	more /dev/daxX.Y devices, where X is the region id and Y is the device
-	instance id.
+include::region-option.txt[]
 
 -s::
 --size=::
@@ -161,16 +156,10 @@ include::movable-options.txt[]
 	to offline the memory on the NUMA node associated with the dax device
 	before converting it back to "devdax" mode.
 
--u::
---human::
-	By default the command will output machine-friendly raw-integer
-	data. Instead, with this flag, numbers representing storage size
-	will be formatted as human readable strings with units, other
-	fields are converted to hexadecimal strings.
 
--v::
---verbose::
-	Emit more debug messages
+include::human-option.txt[]
+
+include::verbose-option.txt[]
 
 include::../copyright.txt[]
 
diff --git a/Documentation/daxctl/human-option.txt b/Documentation/daxctl/human-option.txt
new file mode 100644
index 0000000..2f4de7a
--- /dev/null
+++ b/Documentation/daxctl/human-option.txt
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+-u::
+--human::
+	By default the command will output machine-friendly raw-integer
+	data. Instead, with this flag, numbers representing storage size
+	will be formatted as human readable strings with units, other
+	fields are converted to hexadecimal strings.
diff --git a/Documentation/daxctl/region-option.txt b/Documentation/daxctl/region-option.txt
new file mode 100644
index 0000000..a824e22
--- /dev/null
+++ b/Documentation/daxctl/region-option.txt
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+-r::
+--region=::
+	Restrict the operation to devices belonging to the specified region(s).
+	A device-dax region is a contiguous range of memory that hosts one or
+	more /dev/daxX.Y devices, where X is the region id and Y is the device
+	instance id.
diff --git a/Documentation/daxctl/verbose-option.txt b/Documentation/daxctl/verbose-option.txt
new file mode 100644
index 0000000..cb62c8e
--- /dev/null
+++ b/Documentation/daxctl/verbose-option.txt
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+-v::
+--verbose::
+	Emit more debug messages
diff --git a/util/filter.c b/util/filter.c
index 7c8debb..8c78f32 100644
--- a/util/filter.c
+++ b/util/filter.c
@@ -342,7 +342,7 @@ struct daxctl_region *util_daxctl_region_filter(struct daxctl_region *region,
 		return region;
 
 	if ((sscanf(ident, "%d", &region_id) == 1
-				|| sscanf(ident, "region%d", &region_id) == 1)
+			|| sscanf(ident, "region%d", &region_id) == 1)
 			&& daxctl_region_get_id(region) == region_id)
 		return region;
 
diff --git a/test/daxctl-create.sh b/test/daxctl-create.sh
index 8dbc00f..a4fbe06 100755
--- a/test/daxctl-create.sh
+++ b/test/daxctl-create.sh
@@ -20,8 +20,8 @@ find_testdev()
 
 	# The hmem driver is needed to change the device mode, only
 	# kernels >= v5.6 might have it available. Skip if not.
-	if ! modinfo hmem; then
-		# check if hmem is builtin
+	if ! modinfo dax_hmem; then
+		# check if dax_hmem is builtin
 		if [ ! -d "/sys/module/device_hmem" ]; then
 			printf "Unable to find hmem module\n"
 			exit $rc
@@ -66,7 +66,7 @@ reset_dev()
 	test -n "$testdev"
 
 	"$DAXCTL" disable-device "$testdev"
-	"$DAXCTL" reconfigure-device -s $available "$testdev"
+	"$DAXCTL" reconfigure-device -s "$available" "$testdev"
 	"$DAXCTL" enable-device "$testdev"
 }
 
@@ -76,7 +76,7 @@ reset()
 
 	"$DAXCTL" disable-device -r 0 all
 	"$DAXCTL" destroy-device -r 0 all
-	"$DAXCTL" reconfigure-device -s $available "$testdev"
+	"$DAXCTL" reconfigure-device -s "$available" "$testdev"
 }
 
 clear_dev()
@@ -91,8 +91,8 @@ test_pass()
 
 	# Available size
 	_available_size=$("$DAXCTL" list -r 0 | jq -er '.[0].available_size | .//""')
-	if [[ ! $_available_size == $available ]]; then
-		printf "Unexpected available size $_available_size != $available\n"
+	if [[ ! $_available_size == "$available" ]]; then
+		echo "Unexpected available size $_available_size != $available"
 		exit "$rc"
 	fi
 }
@@ -103,7 +103,7 @@ fail_if_available()
 
 	_size=$("$DAXCTL" list -r 0 | jq -er '.[0].available_size | .//""')
 	if [[ $_size ]]; then
-		printf "Unexpected available size $_size\n"
+		echo "Unexpected available size $_size"
 		exit "$rc"
 	fi
 }
@@ -124,8 +124,8 @@ daxctl_get_size_by_mapping()
 	local _start=0
 	local _end=0
 
-	_start=$(cat $1/start)
-	_end=$(cat $1/end)
+	_start=$(cat "$1"/start)
+	_end=$(cat "$1"/end)
 	((size=size + _end - _start + 1))
 	echo $size
 }
@@ -138,10 +138,10 @@ daxctl_get_nr_mappings()
 	local path=""
 
 	path=$(readlink -f /sys/bus/dax/devices/"$1"/)
-	until ! [ -d $path/mapping$i ]
+	until ! [ -d "$path/mapping$i" ]
 	do
 		_size=$(daxctl_get_size_by_mapping "$path/mapping$i")
-		if [[ $msize == 0 ]]; then
+		if [[ $_size == 0 ]]; then
 			i=0
 			break
 		fi
@@ -151,8 +151,8 @@ daxctl_get_nr_mappings()
 
 	# Return number of mappings if the sizes between size field
 	# and the one computed by mappingNNN are the same
-	_size=$("$DAXCTL" list -d $1 | jq -er '.[0].size | .//""')
-	if [[ ! $_size == $devsize ]]; then
+	_size=$("$DAXCTL" list -d "$1" | jq -er '.[0].size | .//""')
+	if [[ ! $_size == "$devsize" ]]; then
 		echo 0
 	else
 		echo $i
@@ -163,7 +163,7 @@ daxctl_test_multi()
 {
 	local daxdev
 
-	size=$(expr $available / 4)
+	size=$((available / 4))
 
 	if [[ $2 ]]; then
 		"$DAXCTL" disable-device "$testdev"
@@ -171,24 +171,24 @@ daxctl_test_multi()
 	fi
 
 	daxdev_1=$("$DAXCTL" create-device -r 0 -s $size | jq -er '.[].chardev')
-	test -n $daxdev_1
+	test -n "$daxdev_1"
 
 	daxdev_2=$("$DAXCTL" create-device -r 0 -s $size | jq -er '.[].chardev')
-	test -n $daxdev_2
+	test -n "$daxdev_2"
 
 	if [[ ! $2 ]]; then
 		daxdev_3=$("$DAXCTL" create-device -r 0 -s $size | jq -er '.[].chardev')
-		test -n $daxdev_3
+		test -n "$daxdev_3"
 	fi
 
 	# Hole
-	"$DAXCTL" disable-device  $1 &&	"$DAXCTL" destroy-device  $1
+	"$DAXCTL" disable-device  "$1" && "$DAXCTL" destroy-device "$1"
 
 	# Pick space in the created hole and at the end
-	new_size=$(expr $size \* 2)
-	daxdev_4=$("$DAXCTL" create-device -r 0 -s $new_size | jq -er '.[].chardev')
-	test -n $daxdev_4
-	test $(daxctl_get_nr_mappings $daxdev_4) -eq 2
+	new_size=$((size * 2))
+	daxdev_4=$("$DAXCTL" create-device -r 0 -s "$new_size" | jq -er '.[].chardev')
+	test -n "$daxdev_4"
+	test "$(daxctl_get_nr_mappings "$daxdev_4")" -eq 2
 
 	fail_if_available
 
@@ -201,7 +201,7 @@ daxctl_test_multi_reconfig()
 	local ncfgs=$1
 	local daxdev
 
-	size=$(expr $available / $ncfgs)
+	size=$((available / ncfgs))
 
 	test -n "$testdev"
 
@@ -212,19 +212,19 @@ daxctl_test_multi_reconfig()
 	daxdev_1=$("$DAXCTL" create-device -r 0 -s $size | jq -er '.[].chardev')
 	"$DAXCTL" disable-device "$daxdev_1"
 
-	start=$(expr $size + $size)
-	max=$(expr $ncfgs / 2 \* $size)
+	start=$((size + size))
+	max=$((size * ncfgs / 2))
 	for i in $(seq $start $size $max)
 	do
 		"$DAXCTL" disable-device "$testdev"
-		"$DAXCTL" reconfigure-device -s $i "$testdev"
+		"$DAXCTL" reconfigure-device -s "$i" "$testdev"
 
 		"$DAXCTL" disable-device "$daxdev_1"
-		"$DAXCTL" reconfigure-device -s $i "$daxdev_1"
+		"$DAXCTL" reconfigure-device -s "$i" "$daxdev_1"
 	done
 
-	test $(daxctl_get_nr_mappings $testdev) -eq $((ncfgs / 2))
-	test $(daxctl_get_nr_mappings $daxdev_1) -eq $((ncfgs / 2))
+	test "$(daxctl_get_nr_mappings "$testdev")" -eq $((ncfgs / 2))
+	test "$(daxctl_get_nr_mappings "$daxdev_1")" -eq $((ncfgs / 2))
 
 	fail_if_available
 
@@ -237,15 +237,15 @@ daxctl_test_adjust()
 	local ncfgs=4
 	local daxdev
 
-	size=$(expr $available / $ncfgs)
+	size=$((available / ncfgs))
 
 	test -n "$testdev"
 
-	start=$(expr $size + $size)
+	start=$((size + size))
 	for i in $(seq 1 1 $ncfgs)
 	do
-		daxdev=$("$DAXCTL" create-device -r 0 -s $size | jq -er '.[].chardev')
-		test $(daxctl_get_nr_mappings $daxdev) -eq 1
+		daxdev=$("$DAXCTL" create-device -r 0 -s "$size" | jq -er '.[].chardev')
+		test "$(daxctl_get_nr_mappings "$daxdev")" -eq 1
 	done
 
 	daxdev=$(daxctl_get_dev "dax0.1")
@@ -255,18 +255,18 @@ daxctl_test_adjust()
 
 	daxdev=$(daxctl_get_dev "dax0.2")
 	"$DAXCTL" disable-device "$daxdev"
-	"$DAXCTL" reconfigure-device -s $(expr $size \* 2) "$daxdev"
+	"$DAXCTL" reconfigure-device -s $((size * 2)) "$daxdev"
 	# Allocates space at the beginning: expect two mappings as
 	# as don't adjust the mappingX region. This is because we
 	# preserve the relative page_offset of existing allocations
-	test $(daxctl_get_nr_mappings $daxdev) -eq 2
+	test "$(daxctl_get_nr_mappings "$daxdev")" -eq 2
 
 	daxdev=$(daxctl_get_dev "dax0.3")
 	"$DAXCTL" disable-device "$daxdev"
-	"$DAXCTL" reconfigure-device -s $(expr $size \* 2) "$daxdev"
+	"$DAXCTL" reconfigure-device -s $((size * 2)) "$daxdev"
 	# Adjusts space at the end, expect one mapping because we are
 	# able to extend existing region range.
-	test $(daxctl_get_nr_mappings $daxdev) -eq 1
+	test "$(daxctl_get_nr_mappings "$daxdev")" -eq 1
 
 	fail_if_available
 
@@ -293,7 +293,7 @@ daxctl_test1()
 	daxdev=$("$DAXCTL" create-device -r 0 | jq -er '.[].chardev')
 
 	test -n "$daxdev"
-	test $(daxctl_get_nr_mappings $daxdev) -eq 1
+	test "$(daxctl_get_nr_mappings "$daxdev")" -eq 1
 	fail_if_available
 
 	"$DAXCTL" disable-device "$daxdev" && "$DAXCTL" destroy-device "$daxdev"

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
