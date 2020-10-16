Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C5D290D88
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Oct 2020 23:58:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 08323160BEF6E;
	Fri, 16 Oct 2020 14:58:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.223.81; helo=nam11-dm6-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 02774160BEF59
	for <linux-nvdimm@lists.01.org>; Fri, 16 Oct 2020 14:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkDhnGslLq0LXDnVwzKX2YOchF/Jrzmm+c7HERQgr38bZljRz5AnXSQKQvTX/5qTVYSvuEaoVvZDbogwuOFkop/g65VWM1djyj5S+pv8G8DENMQHzVKvtLD/TBT4cI0/5+gZwSCIsGPD2TwIgB2V9EgNc7ea2MY1fpSRwXOf3v3q27C452aSwup/1P4P8hmNd8yB6qrtQds4LPQV/mWNJDw7qGC3dpfhQ+0YVEZ4iOHtzChdCKNztXWE2UfOB3RWoWG1ijc46SMSDb69OayLqjBmAbOiU8hh+61VgWKrY26YgzE+wqfIBScN/J1UaupmQa4UUvuma1j3ypZhkCNUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOmI+E98kScbK2oItBBB3DMZeaDKLBUECg8H2B57zNA=;
 b=bNbrGQd1cy1grooUJ/kXI9ojrTERmKcMcNCfSJfchYdeFb5jV69K/Al1/XSV1WEC88Zz8fsPmDzGzzfatK06LdkfakT6XIX8tIao1wgDZbfo1u6qWIbsbhU2sOid3bzq0h/7NjI+ohK3gMaeX3xZXimOxciSEbCUlZ5rSffL+n/DeM6DHB29JdDAB5UQqJHrXL1lgMUv7J0TakknVI1DS1qdOCUYMpBdLc5hUCJVL8n/dlobcrFfE2ourVw9Rowc5o89a033lHCP0P6G6/7bUd525yEGuSSkwSdXSQveflDGhqqkCiP1WGUJ/EkPZks8YKa/MF3/2Z8SNs7hmyS3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOmI+E98kScbK2oItBBB3DMZeaDKLBUECg8H2B57zNA=;
 b=UzRmEtuIX9B/Wq8lzVtPF4CNhZR0PfUYq2XLQWG+btQaoudpO/gsfdYgFD4mIetPJatasOQOm1I5zLiydH8N7Fexwu6NGDK1LHC/Dbv2iVfbz6BsJ5de24TyjvYL5ZuOkhs/XXBSAN1hx9v0SLxLytfSuN6iIrM/VomHRQydkiM=
Received: from SN6PR08MB4208.namprd08.prod.outlook.com (2603:10b6:805:3b::21)
 by SN6PR08MB5311.namprd08.prod.outlook.com (2603:10b6:805:9b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 21:58:33 +0000
Received: from SN6PR08MB4208.namprd08.prod.outlook.com
 ([fe80::f459:dd7f:5b2:effa]) by SN6PR08MB4208.namprd08.prod.outlook.com
 ([fe80::f459:dd7f:5b2:effa%7]) with mapi id 15.20.3477.022; Fri, 16 Oct 2020
 21:58:33 +0000
From: "Nabeel Meeramohideen Mohamed (nmeeramohide)" <nmeeramohide@micron.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: RE: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
Thread-Topic: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
Thread-Index: AQHWoLSk7QDKlgB4AkWtKLxj5k5RI6mYUcIAgAJzT5A=
Date: Fri, 16 Oct 2020 21:58:32 +0000
Message-ID: 
 <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org>
In-Reply-To: <20201015080254.GA31136@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=micron.com;
x-originating-ip: [104.129.198.248]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f2588d1-2e21-4f79-8e1a-08d8721ea005
x-ms-traffictypediagnostic: SN6PR08MB5311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <SN6PR08MB5311D3C08448DD7D6839547FB3030@SN6PR08MB5311.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 o+NYI+50hAvknJTQBjjbf9Iwwjgm/2UgN6wi37BbpBPSxu375t8hcNLC3c7rs+++QYTjmHWZWwCSB2ItNIT2mPmaXaWF3NnsbhjPYtOHIZtKpY/bhyGySAglrInBi+DGcU6owMDxjvYiW9UgjuQDs3NQantIxqv6w1I22i87flJXFW+Nvh3ftORQ6/+IiPmYjN19iIhyiJ3x8him3cfrKhUxeqLe+mUf2vm8gtnG/1of4s3NXXoaH2afneS5ivH53W6RVM3EeCK1g2EHg7u+MxIoex6woykzbMN3hhycqYYAj0aYyBVxsFh55/VAvPKZbGDdGbeAXLhpUF9ojI8NEw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB4208.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(26005)(66446008)(8936002)(83380400001)(107886003)(54906003)(33656002)(71200400001)(316002)(478600001)(4326008)(66946007)(55016002)(55236004)(52536014)(64756008)(76116006)(9686003)(66556008)(86362001)(8676002)(66476007)(53546011)(6916009)(2906002)(186003)(7696005)(6506007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 M7/klhDn1/hEBS6NYhNlN2l+0DU8fETi8W1FHnKQoA6wjZ2Vg2g6RfJKn6TlQUKn1qRWkoFKRi3nI/PMsezSZDbSGFqDk6X6dsB9bgV6qPkro4clhaUZmm0AVupTQ/LVP7QicDsmryFnm2CyGddTCPVJDjvWGvpfjc8OJYdtyGn9aw2GRp4lp5Ub2ylAmDg4+CoTfLYqX+SS72vqX5gu3Qn1u5TOeaBBVPj7xxIbjN8yGe0ugrOhQ3zLlw/p5kNku6pxTQ/d8WsusdFvFLpKFednOb+TB1E+NC8FIwAxY7TM9vIh5VWQeCHVi4hKo4rz4DwaxLlo15GrjY45PcTlwNeeIHG89hCtI6WwzBrkO/6bOGrH+0kUwm1whSocx5peIoEzaAVNJ5pyO0bFX7tLPGwU9/9XDDuWNjP14kE12bfnOUItyGzQB3wRvWRouxbEBjyaubQX6BsNY4d46gMwdoJFdXpjU0kMjNEBgVFhxcVIhxQGGOemJaC8wn9vWHhNKjr/vhl+3uf+IECutVDHH+CKHIONnRrNoCwcMDb+YF/7yI88kxx7vBtQJOKVE7D83d9c672X3Tvmkpi7QD308wMgHmD2LEl+JoLbVWubRBYXKB4xR8HhfT3TsZZQ0xguJlE60PE5ljV2KBLsA6xjCg==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB4208.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2588d1-2e21-4f79-8e1a-08d8721ea005
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 21:58:33.0192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23C9R53VGXetxbY6XEeN97ERmbrmSZPouta/SgG6/q46XB2WfoA0mdRjapXXfavVkLPT9gW9OAi74xbSYRIFvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5311
Message-ID-Hash: E33564IE3355G73NDIZ6GOD7JBFROONY
X-Message-ID-Hash: E33564IE3355G73NDIZ6GOD7JBFROONY
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Steve Moyer (smoyer)" <smoyer@micron.com>, "Greg Becker (gbecker)" <gbecker@micron.com>, "Pierre Labat (plabat)" <plabat@micron.com>, "John Groves (jgroves)" <jgroves@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SNAYKQI5W7IELXW4O5GSOKKZKG2V4AZR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

On Thursday, October 15, 2020 2:03 AM, Christoph Hellwig <hch@infradead.org> wrote:
> I don't think this belongs into the kernel.  It is a classic case for
> infrastructure that should be built in userspace.  If anything is
> missing to implement it in userspace with equivalent performance we
> need to improve out interfaces, although io_uring should cover pretty
> much everything you need.

Hi Christoph,

We previously considered moving the mpool object store code to user-space.
However, by implementing mpool as a device driver, we get several benefits
in terms of scalability, performance, and functionality. In doing so, we relied
only on standard interfaces and did not make any changes to the kernel.

(1)  mpool's "mcache map" facility allows us to memory-map (and later unmap)
a collection of logically related objects with a single system call. The objects in
such a collection are created at different times, physically disparate, and may
even reside on different media class volumes.

For our HSE storage engine application, there are commonly 10's to 100's of
objects in a given mcache map, and 75,000 total objects mapped at a given time.

Compared to memory-mapping objects individually, the mcache map facility
scales well because it requires only a single system call and single vm_area_struct
to memory-map a complete collection of objects.

(2) The mcache map reaper mechanism proactively evicts object data from the page
cache based on object-level metrics. This provides significant performance benefit
for many workloads.

For example, we ran YCSB workloads B (95/5 read/write mix)  and C (100% read)
against our HSE storage engine using the mpool driver in a 5.9 kernel.
For each workload, we ran with the reaper turned-on and turned-off.

For workload B, the reaper increased throughput 1.77x, while reducing 99.99% tail
latency for reads by 39% and updates by 99%. For workload C, the reaper increased
throughput by 1.84x, while reducing the 99.99% read tail latency by 63%. These
improvements are even more dramatic with earlier kernels.

(3) The mcache map facility can memory-map objects on NVMe ZNS drives that were
created using the Zone Append command. This patch set does not support ZNS, but
that work is in progress and we will be demonstrating our HSE storage engine
running on mpool with ZNS drives at FMS 2020.

(4) mpool's immutable object model allows the driver to support concurrent reading
of object data directly and memory-mapped without a performance penalty to verify
coherence. This allows background operations, such as LSM-tree compaction, to
operate efficiently and without polluting the page cache.

(5) Representing an mpool as a /dev/mpool/<mpool-name> device file provides a
convenient mechanism for controlling access to and managing the multiple storage
volumes, and in the future pmem devices, that may comprise an logical mpool.

Thanks,
Nabeel
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
