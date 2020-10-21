Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A042295156
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Oct 2020 19:11:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6CAFE16086DE2;
	Wed, 21 Oct 2020 10:11:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.93.72; helo=nam10-dm6-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 361C816080F2B
	for <linux-nvdimm@lists.01.org>; Wed, 21 Oct 2020 10:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjKUXSRuv592K8SpypVQ5vELoX+oMHIfBrjbEjBn68atEHVPJjsOr/M42nivlLPuUGtihQ69XUUcfFq0/RELjp5KQtGsV4UBrt1LOre4/tC3EeUqNStpvHmPZsUcu3SShnGe6aKAFCRmyNkoynuel07KJmsjpon5SPMnznK/EbqjS4ocvul5hq/Q2HNahWbf8bAlHXbwIUmr3nTC8C7bl9JcYGKrMj3nc9LdgxxfCJ5YPuyKnsQoBpqey+NlIvy/zjP4iSLPN9e0oDKmSmDylQdn5oEXbSYyx8bim4ezI8062NrIhQ/FgL4Z5LnZuPEdhGq0WVYz2RW0X8TJlikjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxyI2XoagPHTKBx2KnltczpaDlF1lNOItv8QjmzeldI=;
 b=QhgVjA/uhqPDXrvWzUeJ6MRGIJcaU89WkTaCwWCfxcYY/EPqJBS8FdIbDyl8BzypFfy16Y+/BpUtD8/SLX3KP3mjCAQu5D8rOtUzX2Pj6Y1X4Sw74SsANWpukQcCYDANw0SmouzmVChk14iVhGYyPKHAJw0l6Uw1tlhUWqjDxA7ASZJl8G5f2nOYNSj2XHjIsX4wZ2VrL1CDkW3WaXmaGP5/VYX43FPmlOb7yA0m+qMu7/90umf2ljku8zMS5T2H2CrUeUOiw/paqQvDZI/MagxGK0qGWct60edOhXxjH+WGnDPuGJcgkErwg1CLf+uP+WJWAe0g6+7xQw1F7md2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxyI2XoagPHTKBx2KnltczpaDlF1lNOItv8QjmzeldI=;
 b=AddmeDN/Qd0xTefwEXewnG1gQvqOM8REI6M9nNiKIN8eVdIZJ8JXr5KcMtJlcJGcMb3vRJhwRpv7fxCd5SVx92POddJH0Iszm33CckcSRP+uo2/DE1FuBB2kSTvoqCLHc/RUK7BeqO58WMZK40NjkT7ZQaoglrtR5XVrNe78pDo=
Received: from SN6PR08MB4208.namprd08.prod.outlook.com (2603:10b6:805:3b::21)
 by SN2PR0801MB2141.namprd08.prod.outlook.com (2603:10b6:804:13::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 21 Oct
 2020 17:10:59 +0000
Received: from SN6PR08MB4208.namprd08.prod.outlook.com
 ([fe80::f459:dd7f:5b2:effa]) by SN6PR08MB4208.namprd08.prod.outlook.com
 ([fe80::f459:dd7f:5b2:effa%7]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 17:10:59 +0000
From: "Nabeel Meeramohideen Mohamed (nmeeramohide)" <nmeeramohide@micron.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: RE: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
Thread-Topic: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
Thread-Index: 
 AQHWoLSk7QDKlgB4AkWtKLxj5k5RI6mYUcIAgAJzT5CAAAw0AIAEt6vwgAGHlACAAUVw0A==
Date: Wed, 21 Oct 2020 17:10:59 +0000
Message-ID: 
 <SN6PR08MB4208A22F5C94AB05439A2703B31C0@SN6PR08MB4208.namprd08.prod.outlook.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org>
 <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
 <SN6PR08MB420843C280D54D7B5B76EB78B31E0@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4iYOk3i0pPgXxDTy47BxWCXqqXS0J6mrY5o+1M_41XoAw@mail.gmail.com>
In-Reply-To: 
 <CAPcyv4iYOk3i0pPgXxDTy47BxWCXqqXS0J6mrY5o+1M_41XoAw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=micron.com;
x-originating-ip: [104.129.198.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c158595-1703-43fd-121d-08d875e447df
x-ms-traffictypediagnostic: SN2PR0801MB2141:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <SN2PR0801MB214155D3A37C9068C60AEB6AB31C0@SN2PR0801MB2141.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kxqQaAfUjrC4vZvBaf7lRXr1S6URp6rbYbMtPCE0YiuXVu5WZz83/Hfj63Zp28CZB38VcHeycnoRUzYHpKB19Fe+ScQq5556WyrX6j1tFEFt+JEN8Lmu8kxzSdjXMsISzKONiH4kp4iRVxlPAdrLUI69Wo+gigO4RJFbfqzYLHnXt96VSaNfwR5x0P0nHqRG71ScrPoX1BO100XwvVnPe28Rl/9DMb3/Ks9UOdmeE6r648ULhvaIY0jPhhKtQadbulSUrvLBYBeJ+aq7QsFy6lGQyC3aZeIvNpFzU7DnDxapPx5Z/1hQuDts3rrnl0sdJxWLctfaxzGbGbIo/rtVnw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB4208.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(64756008)(2906002)(478600001)(7696005)(83380400001)(316002)(54906003)(66446008)(186003)(9686003)(53546011)(33656002)(6506007)(5660300002)(4326008)(55236004)(26005)(66556008)(66476007)(76116006)(66946007)(52536014)(6916009)(107886003)(86362001)(8936002)(8676002)(55016002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 c2CiAab1wO9f4cNS2Q/PnaimLxSggtKOtX8RgjsBSA2ptkYrM/I2Cu6DOC7kMpcM/seFnrF5Gk/lG9sY4xc97d+wrrH3OQoh0vSOvNJ2BdZcB/nmLTTIjuGbAzozKRMeMKY+7meVR6gcXo/cTh9WN5vK3QKll2kO2626IVYRJSpYrnWE8aXC5XmAthV43IQUW1hNtP6ZIogZlBIiovTM3vBx59bTZAiTa0RnqGQH6MGK9OsguCSnjm2DybWwQ+4S6bE3F83ybl6NvYpgkUJMCGfnwjWlV6J0aNfeKXQo9wYnAQBMhTiFvUoUWTMiZu57CdWNXKuv04MoQbeI8BGu3J51Jod3ga4SGVQ+GpMHTt1LzZpDJm2AKfJQAo6J5JfbETOKv+gPDvjVoCda6PIatfw1U96ctv5gnrOy+aOu0E3oAR+UffsRTrkcjAxLxT2gbPhi1RKlNb4aJwBwjJ49p/H5TbmUz60A7dPPLY0iMc8LfkZdJhR809Km8XKDnzbwbk/xR06qeqSBTD+vz1pWLVLu0/qZJ/BILWoT/Ia6pDOHLqwA27WGcMooJ9T7oZ1czV87jPM4h9pTSWn9Aey5A+VGjDLAKIl+o+z7VcWFW3CsakkG3j4hmbjpoWIB9mbfHzvdMcKE2igq2heXrFQYbw==
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB4208.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c158595-1703-43fd-121d-08d875e447df
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 17:10:59.0666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWsZ0v3nkIwdFndjN7I5yHNBK1K1Nf4s4ETpIchNgpBoVWePmyUFHB/05y4DlzTj+WcsIlPLnpuwFiC+PYxOhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR0801MB2141
Message-ID-Hash: 6Q5EDWJ2TPQLPDBGXO3IFZ5LPHFYJXPU
X-Message-ID-Hash: 6Q5EDWJ2TPQLPDBGXO3IFZ5LPHFYJXPU
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Steve Moyer  <smoyer@micron.com>,  Greg Becker  <gbecker@micron.com>, Pierre Labat (plabat) (smoyer gbecker)" <plabat@micron.com>, "John Groves (jgroves)" <jgroves@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FEJDB3CXPGVW34SFOSWGGKQHS5DATR3R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tuesday, October 20, 2020 3:36 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> 
>     What does Linux get from merging mpool?
> 

What Linux gets from merging mpool is a generic object store target with some
unique and beneficial features:

- the ability to allocate objects from multiple classes of media
- facilities to memory-map (and unmap) collections of related objects with similar
lifetimes in a single call
- proactive eviction of object data from the page cache which takes into account
these object relationships and lifetimes
- concurrent access to object data directly and memory mapped to eliminate
page cache pollution from background operations
- a management model that is intentionally patterned after LVM so as to feel
familiar to Linux users

The HSE storage engine, which is built on mpool, consistently demonstrates
throughputs and latencies in real-world applications that are multiples better
than common alternatives.  We believe this represents a concrete example of
the benefits of the mpool object store.

That said, we are very open to ideas on how we can improve the mpool
implementation to be better aligned with existing Linux I/O mechanisms.

Thanks,
Nabeel
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
