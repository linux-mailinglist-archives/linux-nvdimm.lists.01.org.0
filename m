Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF8827D78E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Sep 2020 22:06:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DFFBD15453348;
	Tue, 29 Sep 2020 13:06:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=rick.p.edgecombe@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D14961542D282
	for <linux-nvdimm@lists.01.org>; Tue, 29 Sep 2020 13:06:07 -0700 (PDT)
IronPort-SDR: Ich9VNpyldP2W2EzsuwfCAyiUB++jIa7ODhWTvJjtIFqIKDpOZDWUy68jq51iqVxDbljDqSn9Z
 RDi9zAA3e0dQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="162340031"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400";
   d="scan'208";a="162340031"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 13:06:06 -0700
IronPort-SDR: VcVE3O2n5Laha4XZ2A4FlwBt8xsol1geTPl7q03FLZby9R3+H0dkJnEwfGRq375qodYFs/VDc6
 V65VQdzWegvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400";
   d="scan'208";a="345390630"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 29 Sep 2020 13:06:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Sep 2020 13:06:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 29 Sep 2020 13:06:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 29 Sep 2020 13:06:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENBop0ePI1rc/FcjS4xrNJ5ze0x4uONCgvsY15Kdra+HLv4X8mV95PPh9WVB7Zq48WY9aBJzDwWsFGQBwQpc13Wn2FaDAjDaGXeXHv3kLGGQ1yjand+YatKmmUsa2W8DRKkcWXrfeYVs977SRDOY15cs5BymbfNEooqM7PGffA4IWg/IKbz34RKQ87bXDVnMF1P5buh9LHm2KrcrW+VCwe8ncxJyqk1X9RuRA4+/TkNY+1tsDgmvaA8HeciqUWdfEcKhxZbw57+sDaLkRmtAR5raNPLdR8Wue4pG2nrPXq7NGmpeZfTE2pLxtaB5o8sitzMXUD2lMnOOr2LCnn0ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koed3BpYmv9VUEcOHyz7SbD00fGiUDop4Xo8houxLng=;
 b=TCZjiQndK5Klfp29RtPXYXD02CnWq2x2mue3odH14NZ3uYjgwLkrIJLi2uppDIZ0Sq7FXX85FoyC8nKWJivW8roYcnbgSjezYmJRloXpBqaslHFuqn7cMGV7+p8vrKKkjeAKypvgzPQV26JDogX53NNkpeK2Vp7YJjVArFUzTbudM8+X0Dk9YpaFMMXObmOqrxIdz/u1KJHOQm8aRMFPU6Z8gHbTXVIgBE+RLTZPsfcvypSreRSU7sFqxuHf8hb/O16ZSzcRtoKDJ26Pq4q073wGHOhyxZP53dn5uWl0rZlGZ0sg9RNElSJdWnofNq9uL4RgF7U7/mJMzlR0b6ywBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koed3BpYmv9VUEcOHyz7SbD00fGiUDop4Xo8houxLng=;
 b=r7t5HExWv1hdNBBWOZviTL67lHH62+oW5lfxWEVnr35DwJwJpaB4HxrGXx+907KoXS4ZbzLQBusxTdZzyLvG/9tis6zLPK7Lcu61TmZtieKoyA7z9NpFlOok6wToWP9PtDnwowoF/QC7lqZokJPXw3mTMuNqpEb86jIkMcE6jy4=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SA0PR11MB4557.namprd11.prod.outlook.com (2603:10b6:806:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Tue, 29 Sep
 2020 20:06:03 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::b901:8e07:4340:6704]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::b901:8e07:4340:6704%7]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 20:06:03 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "rppt@kernel.org" <rppt@kernel.org>
Subject: Re: [PATCH v6 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Thread-Topic: [PATCH v6 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Thread-Index: AQHWlh00WOVRjW6Kw0OmwswTJieWmql/llUAgAB1WIA=
Date: Tue, 29 Sep 2020 20:06:03 +0000
Message-ID: <839fbb26254dc9932dcff3c48a3a4ab038c016ea.camel@intel.com>
References: <20200924132904.1391-1-rppt@kernel.org>
	 <20200924132904.1391-4-rppt@kernel.org>
	 <d466e1f13ff615332fe1f513f6c1d763db28bd9a.camel@intel.com>
	 <20200929130602.GF2142832@kernel.org>
In-Reply-To: <20200929130602.GF2142832@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98a3e0c7-0d63-4378-d126-08d864b317f4
x-ms-traffictypediagnostic: SA0PR11MB4557:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB455769A7B059D65FD6CF3BBDC9320@SA0PR11MB4557.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 33zyXaXOtIT2Gi6nr8USAnRyrrn0ahQhan39d2fVcuqUpjheqX2wOEBfsGkshaAnBD8C+LiKJciUW4iy1SdsHEEdJGqcH+YOd96umFEfPIdZYMx795MNHD/ekCw+ulBuSRVE2bP+ZzIR8Jkj7vpiKK6zo8ec2ii6atpRKf+LBxUwnqelX0a3SuaEO/fKyP7hWe0l8Q+11aO7RjHG8RffDHlX6+UE1oPlmcXMS4OXhT2s3iFusUZ01JrHbCdQrPDeqAdY1/gXmfWCBqQOxjjzRj8wNWNZqmNzJrbaq+qSlTIpd5zP+mRjcDhCQAwr65ro9zQMgGHVY1+Yjcyz22i1B4cq3tO12CznA0n4ipHudFzdpJpBiLY/JgqtWdsM654nwhUSrJOHTemXnO95/hdHp16/10eIOY3fZXaDsiomYcM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(6506007)(186003)(6512007)(26005)(66946007)(76116006)(91956017)(5660300002)(2906002)(83380400001)(71200400001)(316002)(4326008)(478600001)(54906003)(2616005)(36756003)(8676002)(7406005)(7416002)(6916009)(6486002)(8936002)(86362001)(66556008)(66476007)(64756008)(66446008)(219293001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: b3FzD7aP75Zl8mMBqptRH9cBlwAPaDH9PtSbG7uTP32Lo77BSEjkA5V2t37LjO4DdIwqylDeGfnE/GCLHYP/Moig8i4NM43+Pem7wMG3ud2i0cpRXLH0oeVuZDA7YJ9ifILxuircngxIpJ59vMY7qPJq7O3KqB7VF1jLJwYONIgXMjICRPQgpIjGVy1fgTTAt/5QaZhsxcLWbnDIfW8E2e/7AmSEc6C7+s2Al2SJ9GACDOExH/h42FFVaoBUgP8lZ19PU6ZTWi3BElU9y9rOwfMoYVyOwCgjnELR3cdiW/+Uip+TqppGoLxx1wVgBUorEIg71XIeRwq4BiOdvGPwwm6byZagwx2YIQExlI1AhsIzqdDC1kjyI1trkthfaELjLKfDerz9ZdD553MasndxCIfdH9AUUt2tNnbEAjUXJQhNkSKuvaBR4NTi4skpQoCEo2W9gbogV0Kq8nNCRDUz1OnKfFGcMc/Aq4M2FpLJLdx/KUB55mJbCS5DW43rT/KKcFTiFkPOzAAnKnuYcV0UD9Pde+d1tY2NsNFmN+lWatkE6tMkj5idLtMZCmQ7jF3J/aUzGYunGz/niaMOx8XDJg+iZRhHguTwpZ3J8g+FEVVlR9PjAPzUwvUfNaliZfOZsYJPyUY3CTpNzTeVQO3p7g==
Content-ID: <2263CE22901AC047BEFEFC460E5A3197@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a3e0c7-0d63-4378-d126-08d864b317f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 20:06:03.2431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qerPx6uvSfiDlNkAn28LFar8dqkVT0D7PYtTQX37E+jOeHFUu4i91ljcPYyoeqKxGuWJQtakG92lFFpNSzrUBDA8Y8loSYskpx9SPDS4p1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4557
X-OriginatorOrg: intel.com
Message-ID-Hash: PDDFYMOLTANWXYWGSPTTHX2GRHXMLESF
X-Message-ID-Hash: PDDFYMOLTANWXYWGSPTTHX2GRHXMLESF
X-MailFrom: rick.p.edgecombe@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>, "david@redhat.com" <david@redhat.com>, "cl@linux.com" <cl@linux.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "will@kernel.org" <will@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "idan.yaniv@ibm.com" <idan.yaniv@ibm.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "willy@infradead.org" <willy@infradead.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "luto@kernel.org" <luto@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "tglx@linutronix.de" <tglx@linutronix.de>, "lin
 ux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "x86@kernel.org" <x86@kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Reshetova, Elena" <elena.reshetova@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>, "tycho@tycho.ws" <tycho@tycho.ws>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PDDFYMOLTANWXYWGSPTTHX2GRHXMLESF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2020-09-29 at 16:06 +0300, Mike Rapoport wrote:
> On Tue, Sep 29, 2020 at 04:58:44AM +0000, Edgecombe, Rick P wrote:
> > On Thu, 2020-09-24 at 16:29 +0300, Mike Rapoport wrote:
> > > Introduce "memfd_secret" system call with the ability to create
> > > memory
> > > areas visible only in the context of the owning process and not
> > > mapped not
> > > only to other processes but in the kernel page tables as well.
> > > 
> > > The user will create a file descriptor using the memfd_secret()
> > > system call
> > > where flags supplied as a parameter to this system call will
> > > define
> > > the
> > > desired protection mode for the memory associated with that file
> > > descriptor.
> > > 
> > >   Currently there are two protection modes:
> > > 
> > > * exclusive - the memory area is unmapped from the kernel direct
> > > map
> > > and it
> > >                is present only in the page tables of the owning
> > > mm.
> > 
> > Seems like there were some concerns raised around direct map
> > efficiency, but in case you are going to rework this...how does
> > this
> > memory work for the existing kernel functionality that does things
> > like
> > this?
> > 
> > get_user_pages(, &page);
> > ptr = kmap(page);
> > foo = *ptr;
> > 
> > Not sure if I'm missing something, but I think apps could cause the
> > kernel to access a not-present page and oops.
> 
> The idea is that this memory should not be accessible by the kernel,
> so
> the sequence you describe should indeed fail.
> 
> Probably oops would be to noisy and in this case the report needs to
> be
> less verbose.

I was more concerned that it could cause kernel instabilities.

I see, so it should not be accessed even at the userspace address? I
wonder if it should be prevented somehow then. At least
get_user_pages() should be prevented I think. Blocking copy_*_user()
access might not be simple.

I'm also not so sure that a user would never have any possible reason
to copy data from this memory into the kernel, even if it's just
convenience. In which case a user setup could break if a specific
kernel implementation switched to get_user_pages()/kmap() from using
copy_*_user(). So seems maybe a bit thorny without fully blocking
access from the kernel, or deprecating that pattern.

You should probably call out these "no passing data to/from the kernel"
expectations, unless I missed them somewhere.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
