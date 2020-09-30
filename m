Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187A727F306
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Sep 2020 22:11:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 31664155F0224;
	Wed, 30 Sep 2020 13:11:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=rick.p.edgecombe@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 27FD6155F0224
	for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 13:11:42 -0700 (PDT)
IronPort-SDR: 9yuOtY0fSpRopKnvtmPvsq5ggGU1virf5wlNbS4mGNv1Z6ktUkja+GjTQyEyTkfNolYd4lFws2
 cev4lbuh+tRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="159927709"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400";
   d="scan'208";a="159927709"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 13:11:38 -0700
IronPort-SDR: OJSa4+XxYXqfUPAK9UUbHzPZlmbUVAr1l1Q7Q8Ff2mvdDL7ST+20CxK0HPtAM5hIy0Wg79vzmN
 jKUQqXDMt8Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400";
   d="scan'208";a="385246649"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga001.jf.intel.com with ESMTP; 30 Sep 2020 13:11:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 30 Sep 2020 13:11:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 30 Sep 2020 13:11:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 30 Sep 2020 13:11:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPD52p86GubJjejQnpUrUsQEjbbPBsOKtNdNr/Kj7JumQfMr2uLoT3ZAchSmbpODHFPm3O0V37cfA6qvuAyPjQViCGVQhjKcLqclpBb0deTVhLvYeHH/mv3mWZM46u8ruoJOIsCeyJrDFvh1K1BRe5t5po+InBAarG82ppAFEh3U1R5/UywOy+zZGuCJYeW2Zq2ix9rT8iAlImL0j7GYKeAY9008i2d0s+hY38Pe2m8X7if32+BaJ4ISd6of3v8c/YKyn9CeGi285hezU1snMcLfskzaEIcxvB8b0EEpD/weqgQpOGOQvq0MRo72k7LZ463V+zW/VwUoJnZg+YHySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND/Wbb60HAu47zwB0FSd1hJ1RUJu3tYttZkk7WEv8II=;
 b=EGW05nX7ZVhuojLaVEQodMtYWWii1dffKSStvwm2OI25KDGEn5heD4MX7uiZ1a+ZLr0Mb/LAOqH7of/pCItzVRjKQ9GjQLB2vycI82h0pgCnQc8YYb8+r5eEl2e5PUMbOy7TiW3psGRm/eF1qqg0Tb6NsbpIYH/9YEwplY/cE8Wgm8sZQIXB/4MGTlIbVIwIiHsv6Aocmuivd5/A2ND2RFzXboAxKP3SL4/flGQ8ubrhLScVeFSsmL4yo3tlkl5ZR2xz85a5rnWpq3M23O7/UX6FyI9GsTxh7WjcYvIHJuurcfwVuXznVimHrwV1M6DlciqSy8HiCrbETAvCXhV0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND/Wbb60HAu47zwB0FSd1hJ1RUJu3tYttZkk7WEv8II=;
 b=sGXvtV3AC69ro8aXHNQoO0YLWM1Cp7Ded6vUHq6/Rh3+MO34HVHGOxOkV9VO5xUrEWggVHX7R/w9xfS5MVe/ibKxt6PCw5Mn/Tmju3tMd1SKQtsW8SSYqcuz7CV0pFzu/Y0bowElBRlPizvOfPo38/9zCNV6/ckUguh9dOwh1d0=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SN6PR11MB2798.namprd11.prod.outlook.com (2603:10b6:805:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 30 Sep
 2020 20:11:29 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::b901:8e07:4340:6704]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::b901:8e07:4340:6704%7]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 20:11:28 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "rppt@kernel.org" <rppt@kernel.org>
Subject: Re: [PATCH v6 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Thread-Topic: [PATCH v6 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Thread-Index: AQHWlh00WOVRjW6Kw0OmwswTJieWmql/llUAgAB1WICAAPLTgIAAoQaA
Date: Wed, 30 Sep 2020 20:11:28 +0000
Message-ID: <b5d8e90c5366a42e7ad0a337fba5f2b1bcfe52c2.camel@intel.com>
References: <20200924132904.1391-1-rppt@kernel.org>
	 <20200924132904.1391-4-rppt@kernel.org>
	 <d466e1f13ff615332fe1f513f6c1d763db28bd9a.camel@intel.com>
	 <20200929130602.GF2142832@kernel.org>
	 <839fbb26254dc9932dcff3c48a3a4ab038c016ea.camel@intel.com>
	 <20200930103507.GK2142832@kernel.org>
In-Reply-To: <20200930103507.GK2142832@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44700f8a-7bf0-4121-7e3d-08d8657d043e
x-ms-traffictypediagnostic: SN6PR11MB2798:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2798B89C06725545A0CF0991C9330@SN6PR11MB2798.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h46gdzy0CUu0LhcH9RRgqwg/GTdIxbPkgIO2VnchHlNke5hWKc6OXra30/ROjuWE0cbgHaXtjb3OP7/a4+iymukQ3PfVMEZxzvVvrH8Fa50ghEdGXYjqFNelylnBxjBpLv1X1VF9LELvkJdHrr4C748wtNCEoXMUVuw7XzUq7JZROM/m6Vy9YcheHTBO+UZ73BoC2WRLTT9Ew0Tu8rp5QpjAjeYqJ791RGwHZh2rlEhH5Da+aWRjD2Fga137DKI25M782EjhvISoIIDFlH8lo4bDCzrPn0EjtZs5EnkWZMtv166oD/unQlj99/IYNNCkSsgRUd6v8BjWgwu1CuAjdmS5dKyWlQ5hGsCNuweQGTwg6cESQSwpaUmQMpTkFpShAm5h6c4zKg/fey4HZqPx2c0PmiBXz+f1mK0qMustQ6k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(7416002)(7406005)(5660300002)(2616005)(478600001)(71200400001)(6506007)(83380400001)(64756008)(6916009)(54906003)(66446008)(6512007)(6486002)(76116006)(66946007)(26005)(66476007)(66556008)(91956017)(2906002)(86362001)(8676002)(36756003)(186003)(8936002)(316002)(4326008)(219293001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Vl8tXrLpYvx0Tm4BwsdR2gSzzSOklwI5dCufHzcD6i6c5x9Tc1RJCDRtv68JI6TvOxrN0DUNSqlav4esL1JvpyK0+XR4R6PkwBzQKwooPBLuG4fmS9W1myttV8dIySIN8j2mBHOhHePzg/cdjgwdqRimtPDkbU4dTFnz9YF6HCSLq0nx1vqQ70KALYwfYEEP2/bcUH3vB2ZVN+GD9Xx9K7fhtK2xJP1be0cM5VUz6gBGqDf+D2J1ktL46aCXwGt5K0RT5pgz/1wl001q6NF32X4+3ftZMxvu0h/Bpx+yaQh/7N4qgdHuiC8w+XR8wWhCV48+0kfCGzVXvtd4sSk3fLx2T5/cpiLNpKc6NZG+qjJSIAvmCt+TMDMxVLpg8AXCp/PGnXrlnuPwTVoP2HFiECh/C7pO8lV2mZ3OfY/jzCy6Px2jOEn+GXi5uWtEoywSYqCUeCkqB+dP5J+h7o34P5gwyHyl3dVRQoC+8jeV3eEyGmH7yqHyl5a9gs8K6aZSXg8oUh29u+iWY1LMO11q5whzoDtquooAWx7Sq/kbT//f2Nk4IMD0bfhcW1PRPgqwXks1+k9nv+7xrxFfSqqaq3ZvqlXBleBJaEsdCBNHnMlDUwVSUr2iT8s8nbfLeaWddN/PsrQaoIQz1RCMdsj2Kg==
Content-ID: <82FEBE7E3064664F8F5914ACC287F131@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44700f8a-7bf0-4121-7e3d-08d8657d043e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 20:11:28.7568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXw7HGJz588Qxw7T8ltw2WwSJM7B+Ggfo3k2w3vqhxaQ9Uzcad+V/nTKBJ0KbdMoThaKEoQao3vEAhTa2euENw/09bfj2sNX6g0N6hfw5T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2798
X-OriginatorOrg: intel.com
Message-ID-Hash: MJB3O2NPGMM2LFU57WBQX2Y2ZRJYLTSY
X-Message-ID-Hash: MJB3O2NPGMM2LFU57WBQX2Y2ZRJYLTSY
X-MailFrom: rick.p.edgecombe@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "david@redhat.com" <david@redhat.com>, "cl@linux.com" <cl@linux.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "will@kernel.org" <will@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "idan.yaniv@ibm.com" <idan.yaniv@ibm.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "willy@infradead.org" <willy@infradead.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "luto@kernel.org" <luto@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.
 org>, "x86@kernel.org" <x86@kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Reshetova, Elena" <elena.reshetova@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "mingo@redhat.com" <mingo@redhat.com>, "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "tycho@tycho.ws" <tycho@tycho.ws>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MJB3O2NPGMM2LFU57WBQX2Y2ZRJYLTSY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-09-30 at 13:35 +0300, Mike Rapoport wrote:
> On Tue, Sep 29, 2020 at 08:06:03PM +0000, Edgecombe, Rick P wrote:
> > On Tue, 2020-09-29 at 16:06 +0300, Mike Rapoport wrote:
> > > On Tue, Sep 29, 2020 at 04:58:44AM +0000, Edgecombe, Rick P
> > > wrote:
> > > > On Thu, 2020-09-24 at 16:29 +0300, Mike Rapoport wrote:
> > > > > Introduce "memfd_secret" system call with the ability to
> > > > > create
> > > > > memory
> > > > > areas visible only in the context of the owning process and
> > > > > not
> > > > > mapped not
> > > > > only to other processes but in the kernel page tables as
> > > > > well.
> > > > > 
> > > > > The user will create a file descriptor using the
> > > > > memfd_secret()
> > > > > system call
> > > > > where flags supplied as a parameter to this system call will
> > > > > define
> > > > > the
> > > > > desired protection mode for the memory associated with that
> > > > > file
> > > > > descriptor.
> > > > > 
> > > > >   Currently there are two protection modes:
> > > > > 
> > > > > * exclusive - the memory area is unmapped from the kernel
> > > > > direct
> > > > > map
> > > > > and it
> > > > >                is present only in the page tables of the
> > > > > owning
> > > > > mm.
> > > > 
> > > > Seems like there were some concerns raised around direct map
> > > > efficiency, but in case you are going to rework this...how does
> > > > this
> > > > memory work for the existing kernel functionality that does
> > > > things
> > > > like
> > > > this?
> > > > 
> > > > get_user_pages(, &page);
> > > > ptr = kmap(page);
> > > > foo = *ptr;
> > > > 
> > > > Not sure if I'm missing something, but I think apps could cause
> > > > the
> > > > kernel to access a not-present page and oops.
> > > 
> > > The idea is that this memory should not be accessible by the
> > > kernel,
> > > so
> > > the sequence you describe should indeed fail.
> > > 
> > > Probably oops would be to noisy and in this case the report needs
> > > to
> > > be
> > > less verbose.
> > 
> > I was more concerned that it could cause kernel instabilities.
> 
> I think kernel recovers nicely from such sort of page fault, at least
> on
> x86.

We are talking about the kernel taking a direct map NP fault and
oopsing? Hmm, I thought it should often recover, but stability should
be considered reduced. How could the kernel know whether to release
locks or clean up other state? Pretty sure I've seen deadlocks in this
case.

> > I see, so it should not be accessed even at the userspace address?
> > I
> > wonder if it should be prevented somehow then. At least
> > get_user_pages() should be prevented I think. Blocking
> > copy_*_user()
> > access might not be simple.
> > 
> > I'm also not so sure that a user would never have any possible
> > reason
> > to copy data from this memory into the kernel, even if it's just
> > convenience. In which case a user setup could break if a specific
> > kernel implementation switched to get_user_pages()/kmap() from
> > using
> > copy_*_user(). So seems maybe a bit thorny without fully blocking
> > access from the kernel, or deprecating that pattern.
> > 
> > You should probably call out these "no passing data to/from the
> > kernel"
> > expectations, unless I missed them somewhere.
> 
> You are right, I should have been more explicit in the description of
> the expected behavoir. 
> 
> Our thinking was that copy_*user() would work in the context of the
> process that "owns" the secretmem and gup() would not allow access in
> general, unless requested with certail (yet another) FOLL_ flag.

Hmm, yes. I think one easier thing about this design over the series
Kirill sent out is that the actual page will never transition to and
from unmapped while it's mapped in userspace. If it could transition,
you'd have to worry about a race window between
get_user_pages(FOLL_foo) and the kmap() where the page might get
unmapped.

Without the ability to transition pages though, using this for KVM
guests memory remains a not completely worked through problem since it
has the get_user_pages()/kmap() pattern quite a bit. Did you have an
idea for that? (I thought I saw that use case mentioned somewhere).

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
