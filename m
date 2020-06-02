Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1081EC1B7
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Jun 2020 20:22:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6F8D010109146;
	Tue,  2 Jun 2020 11:17:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1252210109145
	for <linux-nvdimm@lists.01.org>; Tue,  2 Jun 2020 10:54:19 -0700 (PDT)
IronPort-SDR: t+RU3Po9JTM41WwasHQYQfQaE1WSjnmRwwPH1WOOHzkdooBW9HDab38qVNjS+KohtXSbiB+BUS
 gAqMBViRxjmw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 10:59:11 -0700
IronPort-SDR: 0gm4OlxDEwZomHyQWXJCx9nVPtKcP00Wg2sO323nstdREEVS/UuuSmOqvD8zDpXEIgV2ARvE4F
 1xVlm6b2j1Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,465,1583222400";
   d="scan'208";a="470755986"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jun 2020 10:59:11 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jun 2020 10:59:11 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 2 Jun 2020 10:59:10 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 2 Jun 2020 10:59:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jun 2020 10:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rhy37OJqvAOk4o1x3tWSQ8PjreiRqvxzfaAjmAzkaQd82XhqlHsnrhlpYxqUFIETWeOB3ziIQ7rzIxthVeiIUAG9ChrbwL/mPPEjKxfbjreNmfTCm59hQJyXzVr23zfcGDEZuO9qDgnbXj/ewTIHEjAid/VKYR1WQi8bK71i825aqoWm9vwljNlj2+i+TNfwO/WzUdwPcRQyqJnbqG+rGY7XsM9M4H00HEwiNpCYs4CIeUCw3tTUPbxd2LWnopg0nCs13/e2ecwZgNICIFBqM9PKhiE7RvoyHfvr9+g5lw2akmgxJ9vC1Ro1r53H4f2iQmHzy+naaIZAD4wq8iNsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM+nBe761TCzUmORhvokiqYQ5eO78sjEZnoQ5nz5mdw=;
 b=UGYmmPN+dV0KmIdna05GTG2zMy6A+fS9c5Tua1cjezZm+sTwEetHdrRZAc/UWW4JlqHpZ6mv/8PV5cmfneYt2OveevEWsecS4w/6zIyjb/L6A2XG1O2wW0DEj++P1Ds8tabQONAf3GtGfNsITbkapd6cVOC+vzFONeG06ojC8XQ8qRxmHqAov3FDTWrMET181bS+itK/sthiy3Jn0mBZuX6uJLROm14EmbZdKrp7my6Bv9dUp4XgzlqzrN0wKnkl/aCgCnl6cD30M583/yLhGqjtpqHB1DNg9+Lm6v5KhpEc99cqJpyKI9ayWn1jKj5oVUIVcapJXeD4TA+IRMgEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM+nBe761TCzUmORhvokiqYQ5eO78sjEZnoQ5nz5mdw=;
 b=pwMKY4C7iAhfYOmmkyeDRzki3mOo7T/eFZfnZjIWy2j8MXtKzk7OpSIpFTc6O9xEYwBD47gOLh+QHLd7FueAto4CirdixQmjnNht0fjhBXbPQ31wmb88gAHbGq0cpxJzK1UXK2SRY6yY0/zsbYu5mMRvVbAebhmJstZRDX6NyrU=
Received: from BN6PR11MB4132.namprd11.prod.outlook.com (2603:10b6:405:81::10)
 by BN6PR11MB1250.namprd11.prod.outlook.com (2603:10b6:404:49::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 17:59:08 +0000
Received: from BN6PR11MB4132.namprd11.prod.outlook.com
 ([fe80::2d67:42cc:d74f:6e4f]) by BN6PR11MB4132.namprd11.prod.outlook.com
 ([fe80::2d67:42cc:d74f:6e4f%7]) with mapi id 15.20.3045.022; Tue, 2 Jun 2020
 17:59:08 +0000
From: "Williams, Dan J" <dan.j.williams@intel.com>
To: Jan Kara <jack@suse.cz>
Subject: RE: [RFC PATCH 1/2] libnvdimm: Add prctl control for disabling
 synchronous fault support.
Thread-Topic: [RFC PATCH 1/2] libnvdimm: Add prctl control for disabling
 synchronous fault support.
Thread-Index: AQHWNXvjb3nI77+RVU649p7d89NzNqi/QrYAgAABN4CAAARHAIAAEYmAgACNmYCAAMgYgIAAm4+AgAI+TYCAAhVRMA==
Date: Tue, 2 Jun 2020 17:59:08 +0000
Message-ID: <BN6PR11MB41328EB6F894DB391DC09DAEC68B0@BN6PR11MB4132.namprd11.prod.outlook.com>
References: <20200529054141.156384-1-aneesh.kumar@linux.ibm.com>
 <20200529093310.GL25173@kitsune.suse.cz>
 <6183cf4a-d134-99e5-936e-ef35f530c2ec@linux.ibm.com>
 <20200529095250.GP14550@quack2.suse.cz>
 <7e8ee9e3-4d4d-e4b9-913b-1c2448adc62a@linux.ibm.com>
 <CAPcyv4jrss3dFcCOar3JTFnuN0_pgFNtBPiJzUdKxtiax6pPgQ@mail.gmail.com>
 <7f163562-e7e3-7668-7415-c40e57c32582@linux.ibm.com>
 <CAPcyv4i7k7t8is_6FKAWbWsGHVO0kvj-OqqqJTzw=VS7xtZVvQ@mail.gmail.com>
 <20200601095049.GB3960@quack2.suse.cz>
In-Reply-To: <20200601095049.GB3960@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d6860cc-77db-4d03-cce8-08d8071ea60a
x-ms-traffictypediagnostic: BN6PR11MB1250:
x-microsoft-antispam-prvs: <BN6PR11MB125050C89397B4E5A7548441C68B0@BN6PR11MB1250.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oXxd4tf8HsS1rC6MOWmcMvO9RZpsjitJxNNIT6TYilqKk502As2I+ZBl5PGNFyr/N3LUoUz06fUrEPgQqtHGnpIAnnm6zIn5ErtSieP0gC+OlGFNMPKEB5alHiYeT8AlbF1Ie82OG2S7IzODbMKuE4u3rxdwsKXynW/UAnC/YAvuBOrEIbnQbCfwr/3iMZvlHz4XUak3Do6d1SEQRRIsUtL2Yn+KWgNRU/LWieirD0FGIwxf6CJU3kVJ70Dm9dE7SCqW4oP5Mf9YhhDzkkZTcKeUlKx0gtsYUoVPpweEMaJaQWvf7ZAcfaIJ4FZBnrEccrv8HfP84AxrTsH0KrLAoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(396003)(136003)(39860400002)(86362001)(7696005)(64756008)(66446008)(478600001)(66556008)(66476007)(5660300002)(45080400002)(6506007)(4326008)(76116006)(2906002)(55016002)(8676002)(6916009)(66946007)(52536014)(71200400001)(83380400001)(33656002)(8936002)(186003)(316002)(26005)(9686003)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cvinH+dy4pdEwxdZElJ643GLVnhh+LkfwYA46OfDxWBN9sNYLfOpFwFRxsSvJ/489r7nQ++VB0zaaNYfzwRr7oUS2H9Qu92m0bgW+CXwFg4HaPpYoGXB2fvQ+oMJEwXh46RcF31OeXVNutkZZi4ziwskL/P/XcmbKHpMiDp0BewvMRFoX6p35cexC3DbpX2DE5Qn9UjvekXcvEEZAM0oqrIecHA4nfhrgUS32sEkjMqXe1SZnKRQ8nTfE7dyUNdAtnNFOteeyP6L1VgjLcIIEDdAHCHTdJYtwsFnZ6RrJvxzCONwIpKwNmSFYQn0X4HiE2Zm4Y7748bkk1ZqWWmuj8c4MvcMvsSj9fGvwxaCoUoPCAe+9bOw4jGK5cMkEEQsjpAU4XrI3m9he6SeYglGlP0xjyU6AVGbvZMmhwd43h8oeUNE+pMHgW8pVdhK3bL1/6aICxJ6Xz/KXWT2Wfy9Vr4c1nV8c2R3bWp7xbDxqFiCXF7csI+DovWn0TlzwE08
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6860cc-77db-4d03-cce8-08d8071ea60a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 17:59:08.7175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYxWp2xj8X0npNN3/El7met4s9UBV6XPiS7AxKWSvviOx9snJkR1JDm/0bCmITRGIZZ4xRGmSUMKM4+pecJz7ZwQNsOpD/6F7bj4qDG2Wxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1250
X-OriginatorOrg: intel.com
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Hits: implicit-dest
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; max-recipients; max-size; news-moderation; no-subject; suspicious-header
Message-ID-Hash: BHNN4PQRRXG4MBRCKQ72IZ32XCAGEHKT
X-Message-ID-Hash: BHNN4PQRRXG4MBRCKQ72IZ32XCAGEHKT
X-Mailman-Approved-At: Tue, 02 Jun 2020 18:17:23 -0700
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, =?iso-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>, "jack@suse.de" <jack@suse.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BHNN4PQRRXG4MBRCKQ72IZ32XCAGEHKT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[ forgive formatting, a series of unfortunate events has me using Outlook for the moment ]

> From: Jan Kara <jack@suse.cz>
> > > > These flags are device properties that affect the kernel and
> > > > userspace's handling of persistence.
> > > >
> > >
> > > That will not handle the scenario with multiple applications using
> > > the same fsdax mount point where one is updated to use the new
> > > instruction and the other is not.
> >
> > Right, it needs to be a global setting / flag day to switch from one
> > regime to another. Per-process control is a recipe for disaster.
> 
> First I'd like to mention that hopefully the concern is mostly theoretical since
> as Aneesh wrote above, real persistent memory never shipped for PPC and
> so there are very few apps (if any) using the old way to ensure cache
> flushing.
> 
> But I'd like to understand why do you think per-process control is a recipe for
> disaster? Because from my POV the sysfs interface you propose is actually
> difficult to use in practice. As a distributor, you have hard time picking the
> default because you have a choice between picking safe option which is
> going to confuse users because of failing MAP_SYNC and unsafe option
> where everyone will be happy until someone looses data because of some
> ancient application using wrong instructions to persist data. Poor experience
> for users in either way. And when distro defaults to "safe option", then the
> burden is on the sysadmin to toggle the switch but how is he supposed to
> decide when that is safe? First he has to understand what the problem
> actually is, then he has to audit all the applications using pmem whether they
> use the new instruction - which is IMO a lot of effort if you have a couple of
> applications and practically infeasible if you have more of them.
> So IMO the burden should be *on the application* to declare that it is aware
> of the new instructions to flush pmem on the platform and only to such
> application the kernel should give the trust to use MAP_SYNC mappings.

The "disaster" in my mind is this need to globally change the ABI for persistence semantics for all of Linux because one CPU wants a do over. What does a generic "MAP_SYNC_ENABLE" knob even mean to the existing deployed base of persistent memory applications? Yes, sysfs is awkward, but it's trying to provide some relief without imposing unexplainable semantics on everyone else. I think a comprehensive (overengineered) solution would involve not introducing another "I know what I'm doing" flag to the interface, but maybe requiring applications to call a pmem sync API in something like a vsyscall. Or, also overengineered, some binary translation / interpretation to actively detect and kill applications that deploy the old instructions. Something horrid like on first write fault to a MAP_SYNC try to look ahead in the binary for the correct sync sequence and kill the application otherwise. That would at least provide some enforcement and safety without requiring other architectures to co
 nsider what MAP_SYNC_ENABLE means to them.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
