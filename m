Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C282F5734
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 Jan 2021 03:25:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0591B100EB34D;
	Wed, 13 Jan 2021 18:25:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.131.44; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=naoya.horiguchi@nec.com; receiver=<UNKNOWN> 
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-eopbgr1310044.outbound.protection.outlook.com [40.107.131.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C2345100EC1EE
	for <linux-nvdimm@lists.01.org>; Wed, 13 Jan 2021 18:25:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDsS33B2y8skmP7ISeKBw9egZRCOtlFRPEj51EO0oLgsP4aEZJZ9gX2GigFHoT6V4DwMg1AhryokVfvuWcoCmXgUekxG3Sav0zjdPkhBBLgCGnajAc4UKtkHFMLl5Tpe5AksFox+thR0N8w36bijmLGvpsa/dsFoA00HCAivMViovHS4K8oRAml2yR5308d94rT6AMb9n9Vs5ZPX71UXEF4Vct6BvLhRzn3jcGj/2aI8FydK4sxoB7p0S4Mix6rATw08QeBDBmnppOJ4KGjSyEC3HneyJgFwJUBEWLIQVfIbcCn4EBzFBte/3KVxdcWwYgK5FhQfi3PBxZdVSiGNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffJNEF6T/qXBvwcRzp5cGi+lAHbNa7n8uJ0ge3aiKN4=;
 b=lHVF9HP554Q9biq6f/ppXU4a3RdnnmTC3GT341YOoLXp9BvWyyCvz2mfrF3D4NZCZbYnSF6iIG0F0pHnumHsSnVM8AQCygIPgRCn1ZjZENwr950wIuHJw+klIryv5ubTy6bgHA7w2nThH/zjUCej4x4HCNgHWkEcGTcvZTpev8zo29E0VHTyliWpIVqMbarO06r+ldSASqxYP+xVl9PeGLgjuFqV8LKUonv+9IaJ88fKF6XGBLlouSKJ+LEOwnjivJeLgKGdVX8Hi3nKNp8QdsjEI/Sae4A/3PmDKuzkuizHriz6FO1k03S+jYMqt5iqFMUVJHpXwLd3lkqHbto25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffJNEF6T/qXBvwcRzp5cGi+lAHbNa7n8uJ0ge3aiKN4=;
 b=jd60VPXfFrLNCyGBbtXUPfB7N5GEEnVtO9vUrdDYK5cgbIgBodwZW8zj1tRnVIGGQG8Y58h+5TfURbRGuwsjvW3BIsiS2O2xRkT1lX3ub0OMp6WATFzV2WWxQhWL8HM+bHYfnx6Ohsx+2p8rqGaphoymd7CbRpkRspkWv83OV/U=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB3145.jpnprd01.prod.outlook.com (2603:1096:404:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 14 Jan
 2021 02:25:14 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::8453:2ddb:cf2b:d244]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::8453:2ddb:cf2b:d244%7]) with mapi id 15.20.3763.010; Thu, 14 Jan 2021
 02:25:14 +0000
From: =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?=
	<naoya.horiguchi@nec.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 5/5] mm: Fix memory_failure() handling of dax-namespace
 metadata
Thread-Topic: [PATCH v4 5/5] mm: Fix memory_failure() handling of
 dax-namespace metadata
Thread-Index: AQHW6g5QoGBA4uCuj0q8fctl6YAQ5aomZN2A
Date: Thu, 14 Jan 2021 02:25:13 +0000
Message-ID: <20210114022513.GB16873@hori.linux.bs1.fc.nec.co.jp>
References: 
 <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161058501758.1840162.4239831989762604527.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: 
 <161058501758.1840162.4239831989762604527.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61664edf-f746-4f5e-2b39-08d8b833a00a
x-ms-traffictypediagnostic: TY2PR01MB3145:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TY2PR01MB3145E35C038FD22C72EB9892E7A80@TY2PR01MB3145.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pnuM96uB2RjkTzJ/VmP1wH6kZkLJMroMNCLfbWdXXDRk6xjrpuoupZ1x8Nbw/dwU/P7JN7ndCSKxFyUV9G3p0gYNEXUQIJo488d+xjEoCowPGUGdbs3py+7m/wgvaO5uTQGSB8GwetSg5eIJFy8bZTdr3XhCeM1/0IvnzBWWZSOz9LMiZka+UNnPBQrAdvnVSSMwcliGv5kFsW3mzO/0gr9ecF4KrSglHu4Etpms1fiVh8YemXxliZy9WnhVhJ6hj5arcu+MWVXpkS/A7vGYZE+V5eQ9DPm+ua0/7jjidw74873qoM1TiHeMbZt5jNPT50JjGMI2bpQjA9r19apL/YTjamubF/+gGafvCjEA85QtG+dJc1qbQ5evY4xLQjKy++yEy0Vf26a5x8l79VbOBw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(6916009)(8936002)(316002)(64756008)(33656002)(66476007)(66946007)(83380400001)(2906002)(1076003)(54906003)(85182001)(66556008)(4326008)(66446008)(55236004)(76116006)(9686003)(4744005)(5660300002)(6506007)(478600001)(8676002)(6486002)(26005)(186003)(71200400001)(86362001)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?akFXeGxiM1lxS2UySk12S21rWmVuemx6Q1FjYkM0Q1BGbSs2QVcxZVRQ?=
 =?iso-2022-jp?B?OXhqaEc2RTREQlI2anFGNEZzQWFaYks1c2NGOW9GcWo0YXUvVi9UZDJN?=
 =?iso-2022-jp?B?YmE1V1d3cXJJVXEwanp2MEhuMjB6SFJEeUJrOGtPa3FMLzFURlh1NHlH?=
 =?iso-2022-jp?B?OGMrUmticGpheDcwRFZlTGFWNU5wLzlBM2hkaG5menI1elpaL1lTZUhu?=
 =?iso-2022-jp?B?MHBBZVBZUlJoanNCUnJVVHFoZW9pZVA4R3d2allRSENjUE1IMkRFZnA2?=
 =?iso-2022-jp?B?ckMxaFU0S3dRRHVjbDBNaGtpV2tBRHhTbTlwVDNtc0x1ZTFBZ0RjMmZo?=
 =?iso-2022-jp?B?UmtOaVdLZ1FMOWw4WnlzajBmaUMvSzU0dlRwTk5XbmxGUGFqczNmV0VO?=
 =?iso-2022-jp?B?Ti9VNFluMFNYSURzR2hQc3FObmlFQW9tNzF2Wm9aOVJ2dE81b3QwOHF5?=
 =?iso-2022-jp?B?Y3NxU2JXWTZsTHJwd2xmOHRnekV3ZEJKdUNiNVZFdUdwUjdOekd6Tm9J?=
 =?iso-2022-jp?B?N0Z0Y0JkWlNwQUlnK3BzamEyQWpGeVgvVVUvRHhVZ1l5UVlSWW1RaUtP?=
 =?iso-2022-jp?B?QnllUExFV1VWYXZMRjdyWld1TkJmdGJZVWZ2ZXNZUDRCWjVndGZ3aDQw?=
 =?iso-2022-jp?B?QUZHcXRXTWtEa1RmRDcxd0h1ZmtLdk5weG5wMjVOTEsrT2ZhQXJCb1VF?=
 =?iso-2022-jp?B?dHNFdUYwaFkyN0RHYTdENmJ3UlAzTXhtOTZZaWNlc2EzMjhlb0J3ZEJt?=
 =?iso-2022-jp?B?amFxR0llYkhXbU9SR05pQXNQVGNhaXpnRk4yTlVZcE1LcTdUaUwwVGxo?=
 =?iso-2022-jp?B?MDJ0VitJVnhka2tuL0Zud3F4VHR6REVvTFRPY2NFUEF0akNXQmFoRE1H?=
 =?iso-2022-jp?B?dXhUVFk1VEwwakdaT3RhanNSR1hSdDFia3c2eVgvbkx5UWRCd3FPS2w5?=
 =?iso-2022-jp?B?bGgvYjdzS1N2MysremtXWTVncFhCQ2FLWkZKR0hFRVhYYUNqLzYxNGhr?=
 =?iso-2022-jp?B?UGxZam9TY0ZtODRIbko2dk9pUEVhZG1QQWxKVktpd0ZMSnpGeGpYR09I?=
 =?iso-2022-jp?B?SFlPQ1ZvL2Z5U2Vsa0UyOU5ZdlNvSVBtNVRqUEE5T3R2dU54SncvbVVm?=
 =?iso-2022-jp?B?K254NFBsWUlTRERBc05Pb0JlckN0SExVT0Jaa2hkaTZkVnY2RUZnTUVY?=
 =?iso-2022-jp?B?d2pBaTVpRDkxMmYvK1VzREJRNlpnclFuTk52NUJkM25oNGpqSkgzTlJv?=
 =?iso-2022-jp?B?MEs0RVhpTGgrenUvQU5IM0tUUVVDLzlxOEFRNUQvN2d1SUMxbXhkRjhv?=
 =?iso-2022-jp?B?TmI3T1lUK1c1ekhNMExydnppckExM1ZzWVArb1VPcVhTdWUyckIzbEMw?=
 =?iso-2022-jp?B?ckxrOWkyOWFNTWtIelJkUXN1TitxY2d3TGp5K25ZeFVsVzhmZ3ZHaUxW?=
 =?iso-2022-jp?B?NWlnQy9WODJ5elZGWm1OQw==?=
Content-ID: <72F2596AEFC7B74AA8DFA159589A0421@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61664edf-f746-4f5e-2b39-08d8b833a00a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 02:25:14.0029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SAJfhkYLaJGOuAI40QDi8gnI+YEyO1D8jmJE9MR1WgZmPDFhD9GdABhlkbwfiRLqt9CSDfAJebNloJlGgRKFdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3145
Message-ID-Hash: ONUOLIUTOHS7NXO7CJLDSFLMFKFC7TYQ
X-Message-ID-Hash: ONUOLIUTOHS7NXO7CJLDSFLMFKFC7TYQ
X-MailFrom: naoya.horiguchi@nec.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ONUOLIUTOHS7NXO7CJLDSFLMFKFC7TYQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 13, 2021 at 04:43:37PM -0800, Dan Williams wrote:
> Given 'struct dev_pagemap' spans both data pages and metadata pages be
> careful to consult the altmap if present to delineate metadata. In fact
> the pfn_first() helper already identifies the first valid data pfn, so
> export that helper for other code paths via pgmap_pfn_valid().
> 
> Other usage of get_dev_pagemap() are not a concern because those are
> operating on known data pfns having been looked up by get_user_pages().
> I.e. metadata pfns are never user mapped.
> 
> Fixes: 6100e34b2526 ("mm, memory_failure: Teach memory_failure() about dev_pagemap pages")
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks fine to me.

Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
