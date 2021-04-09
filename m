Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79CE3591D0
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Apr 2021 04:03:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D5DE100EAAF0;
	Thu,  8 Apr 2021 19:03:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.159.83; helo=esa6.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4EEE0100EAAEE
	for <linux-nvdimm@lists.01.org>; Thu,  8 Apr 2021 19:03:28 -0700 (PDT)
IronPort-SDR: oZMco7psHXF6s5oZLMDA0TQnTNhQMbDSsIvPSF5cZCwX5DwFj9tWtbLtIvtCEg5ZPp9Z23+Qf7
 jEHH2PPSUldUAWX741y7Qp6F06NyjP9VdHIGxPo9pwcUmbtFOI4sR8b5m7TUmKcixkoUC22FBj
 cVKruL5qNUYJE3poPbkD+vF2+FsM7NVVmdceLyexZkeYebOApaoKuXIUUEpRBP71evVP6MPXyh
 6Bz8TRG39cTM9jVUZpEoyk2fFBdSzKbcK8fGmuz1J0vPfQgtQfmH2JSo7AMns3AnBWYJj0ELbh
 ceY=
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="29475725"
X-IronPort-AV: E=Sophos;i="5.82,208,1613401200";
   d="scan'208";a="29475725"
Received: from mail-ty1jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 11:03:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSEvUZNPZI9yOZJcbZ/6JNBG/5VaRiAAvRuQfeEMWSCpjFroFWayXad+FIcTA8KrM0sO1Vuw4iK8v2u3hlRP0cLUuULYFuRC7xod+jYX7+4G4kdaA6ohZ8rATC54i1pc+iv4hZ/7MZnoDM0IDObdNX2mcQnLTB5Qhbr0ScdFJbehQn0z6asSrzYqBk0p0+OJwDhKBccwsiETA48YN8DKSNs2NYf80pLu/Tpfsp1hWcZnfTPdqquOFyz7KYT+Yfy7Toqb3AxM0gaOUrzM/XnySEQO2+UyGXtUCkQDqaS53auEMopbGGhXw7IdgOrsFmYe/8SpgcL8puR6jQcieDKg5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NP3BMyf7aHrRCg78zy6srjL6Bwqv/WtiAvxl10B4Yo=;
 b=DLwx0bPrUmaPC98+7nIDU/nn5fHPa4gRB+QQ0nT/rdMFXz35g6vxdjpUeV5064no7C9+25CIMtwUFZvaBAN181j7O5fR0743aQLmbHZYULrr8FwPj8gGwyjKooXvrjVTsbnkzTfUg8Q+vtLcxSVOBxubgI8N4xGaJ8321uzji8h4ozwaQjccjSfxPD8eaKnDy9Lp5bQWMzm/GAplT41TrBDgti60smaNHsGw0Ruc9mf5hvLYsJ8bqXuh4xibwftDBPY5WFEbNgTq0L7t6V2ZUOvG1T5Ak7EPeccMGuxeDKa6F30ZKp7BtnlujSGBTaHLg1ZL58NhYFufu7Guwuj17g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NP3BMyf7aHrRCg78zy6srjL6Bwqv/WtiAvxl10B4Yo=;
 b=fRhYnGR0y4jVq+LKh/I4uTagKSLLFYOz0sm1EPwcnx5k+GQKag+KJxmnLVu8BkBm7C9xdh3BochFKDlksMtMNpUNOqYwbMhkYYzEd7Aa88MxkGelMsh6exZJWdEdApCr1VeOg5AC3iRYqtKnFnh43tKkZqWegwbrdh4fZyP6JMw=
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com (2603:1096:603:3f::16)
 by OS3PR01MB5958.jpnprd01.prod.outlook.com (2603:1096:604:d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 9 Apr
 2021 02:03:18 +0000
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::5a:7b3b:1e18:3152]) by OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::5a:7b3b:1e18:3152%4]) with mapi id 15.20.3999.032; Fri, 9 Apr 2021
 02:03:18 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: RE: [PATCH v2 2/3] fsdax: Factor helper: dax_fault_actor()
Thread-Topic: [PATCH v2 2/3] fsdax: Factor helper: dax_fault_actor()
Thread-Index: AQHXK7NeHUl/6B163UaqZ3W4Fds/L6qrH9EAgABQUDA=
Date: Fri, 9 Apr 2021 02:03:18 +0000
Message-ID: 
 <OSAPR01MB2913ED1836FA6BB2C938C962F4739@OSAPR01MB2913.jpnprd01.prod.outlook.com>
References: <20210407133823.828176-1-ruansy.fnst@fujitsu.com>
 <20210407133823.828176-3-ruansy.fnst@fujitsu.com>
 <20210408211032.GX3957620@magnolia>
In-Reply-To: <20210408211032.GX3957620@magnolia>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c6630bb-e94e-4b64-33b3-08d8fafba50e
x-ms-traffictypediagnostic: OS3PR01MB5958:
x-microsoft-antispam-prvs: 
 <OS3PR01MB5958B2F0F3E862C559DEBCC2F4739@OS3PR01MB5958.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QCyoB+cYyldTgA5s2W+NSFVBDH56Nd2by3RGwlfj+flDljH7ZjxGLTfU4HKzsSwd+ozb3hoHbZCnS9l4CVylzogRgM7IQb5RfgeCcszdRi9qzVgVDDhbJq+F4Ks7TyOlRbHGSSRxH0Y44IGrxZI8/mDdduC9nLv5QB2n9zXd1h3vIrQFRPSXAGcUQOGZsri4MJWgaqqTqCpbZ35zUdmAgFgujVN1x0z7N9rjT80vgoI1Sv1YBtMKqdabjaFUcdYqoC1PmOt7833d+3jtq5g734T5tR97K6rI9b8JjOInMiXdTD9/WdqLVP0axsjcixt8+gFJiiwH5HqJzMo5l5pqCgvFW2f3QK2zc+dZsop3HHrI6zdkI825rDCuDAkkJac6VOubxWU/fch9QLdtvQ/ugfLHVT6Tb6OG0s7p5CdXfu3dy8XrSTLuCGGd3YzP/v10D8y9xJ14+2bIBYR1VmzOCDkNnuyYvKDhGPOfj9PtNdnJQmvEfrpC+V/eqvH1T2HuwNJTVSnEZLaf9jtyP4QuOovbsb/bwjXAjwrsLZvIhqFtctFWWOEktF4HDc0O37z0+m3S4iGfm6JtMBTyteXLqIxVRw+k9o758nue+KW3XOqGZFkpPkUaZnzBO9JIx4SlMK5uMlGGVxb4DZSsBWdDqNohnxOo9e57qR7y7jGlj00=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2913.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(53546011)(33656002)(6506007)(38100700001)(186003)(86362001)(6916009)(76116006)(4326008)(30864003)(316002)(52536014)(66446008)(83380400001)(64756008)(66556008)(7416002)(66946007)(8936002)(9686003)(55016002)(478600001)(26005)(2906002)(5660300002)(85182001)(8676002)(66476007)(7696005)(54906003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?VEtDZk1ENFQ3d1RvVXpQSjhhL0dzSjlzY0tNbU9QK0RMM24wUEtLY1N5dmV2?=
 =?gb2312?B?RkxCL0VJYmp3d3NLTThnOXBwRnExMnk4cnhxalZ6REh0Mzl5ZzhGZkdtN1NB?=
 =?gb2312?B?Si9RaFBTdkF4YklMdTZTV3lOVWFiTVlTbHA4VnVObENKYVNrZUZ1bFV2VCtx?=
 =?gb2312?B?Ly9rSlVGMjZOZFV6YUdVNkRzRjk5YUo4Z3FsM1Jxa3BTOURpYmJ2c0dMeTVo?=
 =?gb2312?B?Rk50dGJ2aWlhMXoxQVVHUXdwVHFJanlQb1F3OG1ONDM5bTZna09rVy84Y1RO?=
 =?gb2312?B?VDEvdm5Tc0pZRmlUSjM1V1prNHUzVFFFalV3R1F2NTJOZ0FCOWlPZDJwV0NZ?=
 =?gb2312?B?YzArTWlLVDJGaXhmYVhqL0IwMDVJSEZ2MllEcitFUkZuU3lxald1QnpUYlMr?=
 =?gb2312?B?YnoweXdVMUNiZWtVSE1HcS9kUnlVc3hzc282NXl2NVAxckdrM1U3UHRvN0ov?=
 =?gb2312?B?Y1ByVWJiemFheXJrNXg3bFVxSHBhMmMzVEl4RVZ3TXRjMGcvVzl1QW83Mm14?=
 =?gb2312?B?TVhZcWdDbVpkMy9SbDcyeXozYjVSdmNLRVpOWlQ5UWdjd3NXV05JbHI0TEgr?=
 =?gb2312?B?cnJweG16ZjRvV2prUWJDYWVuSDJhSXRRb0N4dlJTNjg5RGtvSXZYU1ZqUHd4?=
 =?gb2312?B?OURHVWZzdFlpZG9MdWZRaGxWaE0rL29wdGd2b3pVRm43cmRjc2NNR2pyQk1W?=
 =?gb2312?B?eDdxdGY5Zlgva05tek1tZXNvZENDRUsvK3hjNkdPS3c0MVgxRDF4NS96elVB?=
 =?gb2312?B?TzdBa29BOWxMWDVZMkhRelp3QzZrZS9sTWhReTVwM0lvNWM1U2ZPcFJabXhs?=
 =?gb2312?B?NDRnZkY4OHo1emFJeDJOT0ZSTzgvcjlTeFZKOGEvRmdQVFh1aThYL2J0OFJ6?=
 =?gb2312?B?anlVTXYwZXVqcE05bCtoQ2VMUkxydmh2K0pvNkI3YjZDMmVkRlp5enZybW9w?=
 =?gb2312?B?ZEZ3WmREcWx3N1FnWWN0SDR4clN0a084OC9RN3VjYmNKZ1JIN3FaN1dNdmgr?=
 =?gb2312?B?ZmMza01XS25yck8rT3o1WXVnNGZUTXBVZ2RROE1CZTdPTjVEWG42Rkx1M0xJ?=
 =?gb2312?B?ZStHbXJFZUE4Zkt0czh0cVNqTytKbGRJZHhka1lxaDNUQ2Q3NTl1TGFGZm9B?=
 =?gb2312?B?THZIQ3prTk1FQTFhQ1BOMTl4U2dMcWM5dlA0M1VCWW82VW85UkZYbDJtUXFy?=
 =?gb2312?B?QjNtRDJtWjluQ3dYRTZORTBhMjVzamRFWVNwRlNiNDJ3WWo0VzBEUnhMWWI3?=
 =?gb2312?B?OForS0dxWkt0VWVMOGhrUVN6ZXBIS3Q3anZmQ1dSalRVZm56RktYR2JvendS?=
 =?gb2312?B?V3luYXQxbE9RK0tsTUFyU3ZxY3RjamNGNTJHZHdORDVCaUNYejN6UXV6K2Vx?=
 =?gb2312?B?U0k0bEcyNWhFY0YyVDJ2OTM2YzdFRTBDY0JuUm16V1dsSG9FZ2drd1R0N0tY?=
 =?gb2312?B?QVhmUjhkdVhYekhrSlk4RzZsWVRnL1FkNVd3U2crUFBPSDFXSHNqblJva3JB?=
 =?gb2312?B?UnFNMFNWTVJIYVN6eU1wUjE4SURCL2kxanQrYlNwTGJmK3lWOThFVWFZWEpH?=
 =?gb2312?B?SDErVWZzaHJBcGVHdXcvNU52UWdFU3BRZ0JWMU01NFA3MzhPYzhSU0NZZTdB?=
 =?gb2312?B?bmx0Q3NEdURWbHIzQ2JUenpPSDlTWVRMNGZNU3N1T2VvS1B6eGN2V1A0a3V5?=
 =?gb2312?B?aEJDVXZIK3NsaVZWVWtYcjRVKyt0ajRUYTF4Slg3UDFhRFZSanU4U1dkait1?=
 =?gb2312?Q?con8X8w3rAV20C0vhKuu3vxtW14qH3Ck7Rcs5zG?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2913.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6630bb-e94e-4b64-33b3-08d8fafba50e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 02:03:18.4382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h6tSPxz0k6I+crrgapDz4/1yiW59BSdQUrdjYsJw0DOdygJb00S2QDBYSeEKqtWJ2yw5MAGcxAXIirHBhTcThA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5958
Message-ID-Hash: JK66XV3CAFV3GFGDK2DN4IUJXSW2DEPJ
X-Message-ID-Hash: JK66XV3CAFV3GFGDK2DN4IUJXSW2DEPJ
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5ZR7L63LOOZBH3Q7WDQFUCQSCLSFUCVJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Darrick J. Wong <djwong@kernel.org>
> Sent: Friday, April 9, 2021 5:11 AM
> Subject: Re: [PATCH v2 2/3] fsdax: Factor helper: dax_fault_actor()
> 
> On Wed, Apr 07, 2021 at 09:38:22PM +0800, Shiyang Ruan wrote:
> > The core logic in the two dax page fault functions is similar. So,
> > move the logic into a common helper function. Also, to facilitate the
> > addition of new features, such as CoW, switch-case is no longer used
> > to handle different iomap types.
> >
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> >  fs/dax.c | 294
> > ++++++++++++++++++++++++++++---------------------------
> >  1 file changed, 148 insertions(+), 146 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index f843fb8fbbf1..6dea1fc11b46 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -1054,6 +1054,66 @@ static vm_fault_t dax_load_hole(struct xa_state
> *xas,
> >  	return ret;
> >  }
> >
> > +#ifdef CONFIG_FS_DAX_PMD
> > +static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault
> *vmf,
> > +		struct iomap *iomap, void **entry)
> > +{
> > +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> > +	unsigned long pmd_addr = vmf->address & PMD_MASK;
> > +	struct vm_area_struct *vma = vmf->vma;
> > +	struct inode *inode = mapping->host;
> > +	pgtable_t pgtable = NULL;
> > +	struct page *zero_page;
> > +	spinlock_t *ptl;
> > +	pmd_t pmd_entry;
> > +	pfn_t pfn;
> > +
> > +	zero_page = mm_get_huge_zero_page(vmf->vma->vm_mm);
> > +
> > +	if (unlikely(!zero_page))
> > +		goto fallback;
> > +
> > +	pfn = page_to_pfn_t(zero_page);
> > +	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> > +			DAX_PMD | DAX_ZERO_PAGE, false);
> > +
> > +	if (arch_needs_pgtable_deposit()) {
> > +		pgtable = pte_alloc_one(vma->vm_mm);
> > +		if (!pgtable)
> > +			return VM_FAULT_OOM;
> > +	}
> > +
> > +	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
> > +	if (!pmd_none(*(vmf->pmd))) {
> > +		spin_unlock(ptl);
> > +		goto fallback;
> > +	}
> > +
> > +	if (pgtable) {
> > +		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
> > +		mm_inc_nr_ptes(vma->vm_mm);
> > +	}
> > +	pmd_entry = mk_pmd(zero_page, vmf->vma->vm_page_prot);
> > +	pmd_entry = pmd_mkhuge(pmd_entry);
> > +	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
> > +	spin_unlock(ptl);
> > +	trace_dax_pmd_load_hole(inode, vmf, zero_page, *entry);
> > +	return VM_FAULT_NOPAGE;
> > +
> > +fallback:
> > +	if (pgtable)
> > +		pte_free(vma->vm_mm, pgtable);
> > +	trace_dax_pmd_load_hole_fallback(inode, vmf, zero_page, *entry);
> > +	return VM_FAULT_FALLBACK;
> > +}
> > +#else
> > +static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault
> *vmf,
> > +		struct iomap *iomap, void **entry)
> > +{
> > +	return VM_FAULT_FALLBACK;
> > +}
> > +#endif /* CONFIG_FS_DAX_PMD */
> > +
> >  s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)  {
> >  	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK); @@ -1291,6
> > +1351,64 @@ static vm_fault_t dax_fault_cow_page(struct vm_fault *vmf,
> struct iomap *iomap,
> >  	return ret;
> >  }
> >
> > +/**
> > + * dax_fault_actor - Common actor to handle pfn insertion in PTE/PMD fault.
> > + * @vmf:	vm fault instance
> > + * @pfnp:	pfn to be returned
> > + * @xas:	the dax mapping tree of a file
> > + * @entry:	an unlocked dax entry to be inserted
> > + * @pmd:	distinguish whether it is a pmd fault
> > + * @flags:	iomap flags
> > + * @iomap:	from iomap_begin()
> > + * @srcmap:	from iomap_begin(), not equal to iomap if it is a CoW
> > + */
> > +static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
> > +		struct xa_state *xas, void **entry, bool pmd,
> > +		unsigned int flags, struct iomap *iomap, struct iomap *srcmap) {
> > +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> > +	size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
> > +	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
> > +	bool write = vmf->flags & FAULT_FLAG_WRITE;
> > +	bool sync = dax_fault_is_synchronous(flags, vmf->vma, iomap);
> > +	unsigned long entry_flags = pmd ? DAX_PMD : 0;
> > +	int err = 0;
> > +	pfn_t pfn;
> > +
> > +	/* if we are reading UNWRITTEN and HOLE, return a hole. */
> > +	if (!write &&
> > +	    (iomap->type == IOMAP_UNWRITTEN || iomap->type ==
> IOMAP_HOLE)) {
> > +		if (!pmd)
> > +			return dax_load_hole(xas, mapping, entry, vmf);
> > +		else
> > +			return dax_pmd_load_hole(xas, vmf, iomap, entry);
> > +	}
> > +
> > +	if (iomap->type != IOMAP_MAPPED) {
> > +		WARN_ON_ONCE(1);
> > +		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
> > +	}
> > +
> > +	err = dax_iomap_pfn(iomap, pos, size, &pfn);
> > +	if (err)
> > +		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
> > +
> > +	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn, entry_flags,
> > +				  write && !sync);
> > +
> > +	if (sync)
> > +		return dax_fault_synchronous_pfnp(pfnp, pfn);
> > +
> > +	/* insert PMD pfn */
> > +	if (pmd)
> > +		return vmf_insert_pfn_pmd(vmf, pfn, write);
> > +
> > +	/* insert PTE pfn */
> > +	if (write)
> > +		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
> > +	return vmf_insert_mixed(vmf->vma, vmf->address, pfn); }
> > +
> >  static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> >  			       int *iomap_errp, const struct iomap_ops *ops)  { @@
> > -1298,17 +1416,14 @@ static vm_fault_t dax_iomap_pte_fault(struct
> vm_fault *vmf, pfn_t *pfnp,
> >  	struct address_space *mapping = vma->vm_file->f_mapping;
> >  	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
> >  	struct inode *inode = mapping->host;
> > -	unsigned long vaddr = vmf->address;
> >  	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
> >  	struct iomap iomap = { .type = IOMAP_HOLE };
> >  	struct iomap srcmap = { .type = IOMAP_HOLE };
> >  	unsigned flags = IOMAP_FAULT;
> >  	int error, major = 0;
> 
> Hmm, shouldn't major be vm_fault_t since we assign VM_FAULT_MAJOR to it?

Yes, I didn't notice it.  Will fix it in next version.


--
Thanks,
Ruan Shiyang.

> 
> --D
> 
> >  	bool write = vmf->flags & FAULT_FLAG_WRITE;
> > -	bool sync;
> >  	vm_fault_t ret = 0;
> >  	void *entry;
> > -	pfn_t pfn;
> >
> >  	trace_dax_pte_fault(inode, vmf, ret);
> >  	/*
> > @@ -1354,8 +1469,8 @@ static vm_fault_t dax_iomap_pte_fault(struct
> vm_fault *vmf, pfn_t *pfnp,
> >  		goto unlock_entry;
> >  	}
> >  	if (WARN_ON_ONCE(iomap.offset + iomap.length < pos + PAGE_SIZE)) {
> > -		error = -EIO;	/* fs corruption? */
> > -		goto error_finish_iomap;
> > +		ret = VM_FAULT_SIGBUS;	/* fs corruption? */
> > +		goto finish_iomap;
> >  	}
> >
> >  	if (vmf->cow_page) {
> > @@ -1363,49 +1478,19 @@ static vm_fault_t dax_iomap_pte_fault(struct
> vm_fault *vmf, pfn_t *pfnp,
> >  		goto finish_iomap;
> >  	}
> >
> > -	sync = dax_fault_is_synchronous(flags, vma, &iomap);
> > -
> > -	switch (iomap.type) {
> > -	case IOMAP_MAPPED:
> > -		if (iomap.flags & IOMAP_F_NEW) {
> > -			count_vm_event(PGMAJFAULT);
> > -			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> > -			major = VM_FAULT_MAJOR;
> > -		}
> > -		error = dax_iomap_pfn(&iomap, pos, PAGE_SIZE, &pfn);
> > -		if (error < 0)
> > -			goto error_finish_iomap;
> > -
> > -		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
> > -						 0, write && !sync);
> > -
> > -		if (sync) {
> > -			ret = dax_fault_synchronous_pfnp(pfnp, pfn);
> > -			goto finish_iomap;
> > -		}
> > -		trace_dax_insert_mapping(inode, vmf, entry);
> > -		if (write)
> > -			ret = vmf_insert_mixed_mkwrite(vma, vaddr, pfn);
> > -		else
> > -			ret = vmf_insert_mixed(vma, vaddr, pfn);
> > -
> > +	ret = dax_fault_actor(vmf, pfnp, &xas, &entry, false, flags,
> > +			      &iomap, &srcmap);
> > +	if (ret == VM_FAULT_SIGBUS)
> >  		goto finish_iomap;
> > -	case IOMAP_UNWRITTEN:
> > -	case IOMAP_HOLE:
> > -		if (!write) {
> > -			ret = dax_load_hole(&xas, mapping, &entry, vmf);
> > -			goto finish_iomap;
> > -		}
> > -		fallthrough;
> > -	default:
> > -		WARN_ON_ONCE(1);
> > -		error = -EIO;
> > -		break;
> > +
> > +	/* read/write MAPPED, CoW UNWRITTEN */
> > +	if (iomap.flags & IOMAP_F_NEW) {
> > +		count_vm_event(PGMAJFAULT);
> > +		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> > +		major = VM_FAULT_MAJOR;
> >  	}
> >
> > - error_finish_iomap:
> > -	ret = dax_fault_return(error);
> > - finish_iomap:
> > +finish_iomap:
> >  	if (ops->iomap_end) {
> >  		int copied = PAGE_SIZE;
> >
> > @@ -1419,66 +1504,14 @@ static vm_fault_t dax_iomap_pte_fault(struct
> vm_fault *vmf, pfn_t *pfnp,
> >  		 */
> >  		ops->iomap_end(inode, pos, PAGE_SIZE, copied, flags, &iomap);
> >  	}
> > - unlock_entry:
> > +unlock_entry:
> >  	dax_unlock_entry(&xas, entry);
> > - out:
> > +out:
> >  	trace_dax_pte_fault_done(inode, vmf, ret);
> >  	return ret | major;
> >  }
> >
> >  #ifdef CONFIG_FS_DAX_PMD
> > -static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault
> *vmf,
> > -		struct iomap *iomap, void **entry)
> > -{
> > -	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> > -	unsigned long pmd_addr = vmf->address & PMD_MASK;
> > -	struct vm_area_struct *vma = vmf->vma;
> > -	struct inode *inode = mapping->host;
> > -	pgtable_t pgtable = NULL;
> > -	struct page *zero_page;
> > -	spinlock_t *ptl;
> > -	pmd_t pmd_entry;
> > -	pfn_t pfn;
> > -
> > -	zero_page = mm_get_huge_zero_page(vmf->vma->vm_mm);
> > -
> > -	if (unlikely(!zero_page))
> > -		goto fallback;
> > -
> > -	pfn = page_to_pfn_t(zero_page);
> > -	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> > -			DAX_PMD | DAX_ZERO_PAGE, false);
> > -
> > -	if (arch_needs_pgtable_deposit()) {
> > -		pgtable = pte_alloc_one(vma->vm_mm);
> > -		if (!pgtable)
> > -			return VM_FAULT_OOM;
> > -	}
> > -
> > -	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
> > -	if (!pmd_none(*(vmf->pmd))) {
> > -		spin_unlock(ptl);
> > -		goto fallback;
> > -	}
> > -
> > -	if (pgtable) {
> > -		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
> > -		mm_inc_nr_ptes(vma->vm_mm);
> > -	}
> > -	pmd_entry = mk_pmd(zero_page, vmf->vma->vm_page_prot);
> > -	pmd_entry = pmd_mkhuge(pmd_entry);
> > -	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
> > -	spin_unlock(ptl);
> > -	trace_dax_pmd_load_hole(inode, vmf, zero_page, *entry);
> > -	return VM_FAULT_NOPAGE;
> > -
> > -fallback:
> > -	if (pgtable)
> > -		pte_free(vma->vm_mm, pgtable);
> > -	trace_dax_pmd_load_hole_fallback(inode, vmf, zero_page, *entry);
> > -	return VM_FAULT_FALLBACK;
> > -}
> > -
> >  static bool dax_fault_check_fallback(struct vm_fault *vmf, struct xa_state
> *xas,
> >  		pgoff_t max_pgoff)
> >  {
> > @@ -1519,17 +1552,15 @@ static vm_fault_t dax_iomap_pmd_fault(struct
> vm_fault *vmf, pfn_t *pfnp,
> >  	struct address_space *mapping = vma->vm_file->f_mapping;
> >  	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, PMD_ORDER);
> >  	bool write = vmf->flags & FAULT_FLAG_WRITE;
> > -	bool sync;
> > -	unsigned int iomap_flags = (write ? IOMAP_WRITE : 0) | IOMAP_FAULT;
> > +	unsigned int flags = (write ? IOMAP_WRITE : 0) | IOMAP_FAULT;
> >  	struct inode *inode = mapping->host;
> > -	vm_fault_t result = VM_FAULT_FALLBACK;
> > +	vm_fault_t ret = VM_FAULT_FALLBACK;
> >  	struct iomap iomap = { .type = IOMAP_HOLE };
> >  	struct iomap srcmap = { .type = IOMAP_HOLE };
> >  	pgoff_t max_pgoff;
> >  	void *entry;
> >  	loff_t pos;
> >  	int error;
> > -	pfn_t pfn;
> >
> >  	/*
> >  	 * Check whether offset isn't beyond end of file now. Caller is @@
> > -1541,7 +1572,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault
> *vmf, pfn_t *pfnp,
> >  	trace_dax_pmd_fault(inode, vmf, max_pgoff, 0);
> >
> >  	if (xas.xa_index >= max_pgoff) {
> > -		result = VM_FAULT_SIGBUS;
> > +		ret = VM_FAULT_SIGBUS;
> >  		goto out;
> >  	}
> >
> > @@ -1556,7 +1587,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct
> vm_fault *vmf, pfn_t *pfnp,
> >  	 */
> >  	entry = grab_mapping_entry(&xas, mapping, PMD_ORDER);
> >  	if (xa_is_internal(entry)) {
> > -		result = xa_to_internal(entry);
> > +		ret = xa_to_internal(entry);
> >  		goto fallback;
> >  	}
> >
> > @@ -1568,7 +1599,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct
> vm_fault *vmf, pfn_t *pfnp,
> >  	 */
> >  	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd) &&
> >  			!pmd_devmap(*vmf->pmd)) {
> > -		result = 0;
> > +		ret = 0;
> >  		goto unlock_entry;
> >  	}
> >
> > @@ -1578,49 +1609,21 @@ static vm_fault_t dax_iomap_pmd_fault(struct
> vm_fault *vmf, pfn_t *pfnp,
> >  	 * to look up our filesystem block.
> >  	 */
> >  	pos = (loff_t)xas.xa_index << PAGE_SHIFT;
> > -	error = ops->iomap_begin(inode, pos, PMD_SIZE, iomap_flags, &iomap,
> > -			&srcmap);
> > +	error = ops->iomap_begin(inode, pos, PMD_SIZE, flags, &iomap,
> > +&srcmap);
> >  	if (error)
> >  		goto unlock_entry;
> >
> >  	if (iomap.offset + iomap.length < pos + PMD_SIZE)
> >  		goto finish_iomap;
> >
> > -	sync = dax_fault_is_synchronous(iomap_flags, vma, &iomap);
> > -
> > -	switch (iomap.type) {
> > -	case IOMAP_MAPPED:
> > -		error = dax_iomap_pfn(&iomap, pos, PMD_SIZE, &pfn);
> > -		if (error < 0)
> > -			goto finish_iomap;
> > +	ret = dax_fault_actor(vmf, pfnp, &xas, &entry, true, flags,
> > +			      &iomap, &srcmap);
> >
> > -		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
> > -						DAX_PMD, write && !sync);
> > -
> > -		if (sync) {
> > -			result = dax_fault_synchronous_pfnp(pfnp, pfn);
> > -			goto finish_iomap;
> > -		}
> > -
> > -		trace_dax_pmd_insert_mapping(inode, vmf, PMD_SIZE, pfn, entry);
> > -		result = vmf_insert_pfn_pmd(vmf, pfn, write);
> > -		break;
> > -	case IOMAP_UNWRITTEN:
> > -	case IOMAP_HOLE:
> > -		if (WARN_ON_ONCE(write))
> > -			break;
> > -		result = dax_pmd_load_hole(&xas, vmf, &iomap, &entry);
> > -		break;
> > -	default:
> > -		WARN_ON_ONCE(1);
> > -		break;
> > -	}
> > -
> > - finish_iomap:
> > +finish_iomap:
> >  	if (ops->iomap_end) {
> >  		int copied = PMD_SIZE;
> >
> > -		if (result == VM_FAULT_FALLBACK)
> > +		if (ret == VM_FAULT_FALLBACK)
> >  			copied = 0;
> >  		/*
> >  		 * The fault is done by now and there's no way back (other @@
> > -1628,19 +1631,18 @@ static vm_fault_t dax_iomap_pmd_fault(struct
> vm_fault *vmf, pfn_t *pfnp,
> >  		 * Just ignore error from ->iomap_end since we cannot do much
> >  		 * with it.
> >  		 */
> > -		ops->iomap_end(inode, pos, PMD_SIZE, copied, iomap_flags,
> > -				&iomap);
> > +		ops->iomap_end(inode, pos, PMD_SIZE, copied, flags, &iomap);
> >  	}
> > - unlock_entry:
> > +unlock_entry:
> >  	dax_unlock_entry(&xas, entry);
> > - fallback:
> > -	if (result == VM_FAULT_FALLBACK) {
> > +fallback:
> > +	if (ret == VM_FAULT_FALLBACK) {
> >  		split_huge_pmd(vma, vmf->pmd, vmf->address);
> >  		count_vm_event(THP_FAULT_FALLBACK);
> >  	}
> >  out:
> > -	trace_dax_pmd_fault_done(inode, vmf, max_pgoff, result);
> > -	return result;
> > +	trace_dax_pmd_fault_done(inode, vmf, max_pgoff, ret);
> > +	return ret;
> >  }
> >  #else
> >  static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t
> > *pfnp,
> > --
> > 2.31.0
> >
> >
> >
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
