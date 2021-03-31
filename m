Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 246E734F7A9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Mar 2021 05:58:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2F55B100EB85D;
	Tue, 30 Mar 2021 20:58:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.159.83; helo=esa6.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 181C0100EB83C
	for <linux-nvdimm@lists.01.org>; Tue, 30 Mar 2021 20:57:59 -0700 (PDT)
IronPort-SDR: aoM1reN2+DCINqEL/T0yblgHp1Ix9lBxdj5zwfxM28q0IsOG0AhTxv7wkMWbvJwJIgpBEFVcuJ
 W2lVSa8oF6VTEgPM/oTcGVoc+rPF0YjqFg4IseTlvjQrLjG3bRCw81p1iKPG4ro6gQTsnqCnjK
 rRwNisa0cq8D47E9h9PxVEEKZpkM6KHL0ClwTzLvsUi/ntb4wYMdvp42donGDORo8u95VdkxmK
 egpbjrmA+HzFwD9e2zg6rajf6VIctQGTyPNz0E2Hg7chgmlSTu3SW+HVknuMjUzN2BerJIaSFo
 7vE=
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="28967601"
X-IronPort-AV: E=Sophos;i="5.81,291,1610377200";
   d="scan'208";a="28967601"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 12:57:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzPgb833wreC2WIuWxFF+icOrJDdUjV1hBZckdqmT1YIwfXcz9Zo9+WQqZjneEfakW6Y66Krec46s7iMU0KJT5uZXal3ya7r0YEdhU5vbFjaN/gmpmHtjhtf/inaFX8AcCEBy9RgZw10e3MkbYm80kVEK8MBtX5uaxDlj4+1cn6xEOa+SetKUNWVx8AFnZFZ+n8CyhlFOKr9l+IXsLeAkeDT+TGlwfCgwLH8hsAHnsuMYQMLwNLhoXSOxfEVJ2iBPTaE1q3r52EwVJG5Mc/SKKyfeGNkYyl3ZTX3d8XYpOx02Ff0MEkJLTRaX0lXOiSlVdSn/BUU/nS5ySHyWh9Yew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eb6XG2eBYXrbFwxm8ulJeg1sFj9CcJAtwBnlzfgzKwM=;
 b=K2lgBBPNlmgIFwQUeV+FGNMyBv5Hs+k3M1it9EfayDBr3t8ugkjsnT4AD0YXPuyCSw1e+trczLk+gG0auWKrjJ/cGuyFVp7Mi30UkVPr1XHStzTm9d4QDx/6WyhWJq1lqoIVBFbESJ02VTWlHx7P76WtGkTcfMTNpEEEyvjTC6XJyGRYjRCfTDXAZU3rYxDyMPNcezs0nQ8PA0Z58lwQt43inCJvi8ti9EWEDiZs7CdZSayNqbiHr8I9y0XFE3NP3S1Ak8sE2auiYmQHyX5qOFaSYnb+rBvY4VE89+24nTkCFQLDwEaAxW03tl4ZFCqIU3CliJgrMmL02IstbbtkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eb6XG2eBYXrbFwxm8ulJeg1sFj9CcJAtwBnlzfgzKwM=;
 b=F5qK6A2ry90rNRCtqwO+epK0G2WOnbWtfhIbvslHQquLEcmIU1AYxruMEDY9QUfYvWdjQ4N+ocp90bcDtK07eE6oRcmgajdWyJLNgGsuExDmf1sGoa+2bJYw4t0Emo3oASFViodv+ZCv0ac1PYMR7CAIIlaV3k7ZvovtBEiuhW8=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB5912.jpnprd01.prod.outlook.com (2603:1096:604:c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 03:57:51 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::68f4:1e20:827c:a2ca]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::68f4:1e20:827c:a2ca%4]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 03:57:51 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: Ritesh Harjani <riteshh@linux.ibm.com>
Subject: RE: [PATCH v3 02/10] fsdax: Factor helper: dax_fault_actor()
Thread-Topic: [PATCH v3 02/10] fsdax: Factor helper: dax_fault_actor()
Thread-Index: AQHXHGKekYLgMQWqbEyRQkBWybbg96qRvxeAgAvHMCA=
Date: Wed, 31 Mar 2021 03:57:51 +0000
Message-ID: 
 <OSBPR01MB29200007EF0099E13CFABAAFF47C9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-3-ruansy.fnst@fujitsu.com>
 <d4daf840-f407-d746-b3e4-35753eb511b3@linux.ibm.com>
In-Reply-To: <d4daf840-f407-d746-b3e4-35753eb511b3@linux.ibm.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d62eee08-1223-40c8-1b36-08d8f3f927d6
x-ms-traffictypediagnostic: OS3PR01MB5912:
x-microsoft-antispam-prvs: 
 <OS3PR01MB5912B61A92A8AADB6E248368F47C9@OS3PR01MB5912.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 aanFN+B4ncPuSaGmb4O+8zkWG4cToaQU8NdAwikjS6afhuUlcLAWyJVWzLGufoPjQAxajls7P/GVb660Pv2xuMm4Vqo8qeaJ5u8U3RsSwXiVv/xwtC1RBq7trvtykYe6OO2skEM3ADwridXnSKMxyM8coH3OTfNAxXxwfXobHXQ+5/xgxV9590yBwU36+mspDCIhmKKy1ti7eGH6TXm7qx2vIwh35sn47NU7eE5OpoH3uYj4ssfGSXq3+6GeYsUiqsykQf3VYc+q6qILTf7Izfi9boTQGjUJUgIE5zw8mMVZ0gJjCkb8WqCGTna0ejO4m5YuUrO/u0Zzr/NfyhwLPpnmghhpaY1OPYbFq4TueZJNT13rnUrAWMxB88Jbm+6HKy95FJAOGcbtXkIDh7CckybfcmBfzDAkx6Excudq3jwS9ONLC49Yb1ec2NF9qeaKrIG0q1N/H2Fp1Az2EOHOXXPMzevKlfde88vodiH3gaSoTnZMtXD7eBUwSzcHJzz1ecdfuedXSKUO2/wdlAFJpCh9Zg440zkfx01u8S6H4KtyVjIODp0C9BvMtdad5UDZb+SuYXHAi2z/wxl6zXk4S+6SX8SVD7pnzyRoKW6TtZqjr8aCkaL8ZzYbQ8UBLvrX+CXPdgNoid/NeQ4XftWsXHebB8j8CHd1cPY9blGa49A=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(7696005)(38100700001)(66446008)(64756008)(71200400001)(5660300002)(6506007)(26005)(54906003)(53546011)(66946007)(85182001)(66556008)(66476007)(76116006)(316002)(186003)(2906002)(478600001)(4326008)(83380400001)(8676002)(52536014)(86362001)(9686003)(33656002)(6916009)(55016002)(8936002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?utf-8?B?NG92dUpEeEFRekYrU1BhRDA4bWNLRkl3MVFKYy9VSnowTGtCb0Y0RnVFcEhQ?=
 =?utf-8?B?aHlJTGNnRlJnc1NzbDkxSTdYL2dUVmx3U3prbklRalRvSHNSRHhSS25PdGVH?=
 =?utf-8?B?S1hMcGtnWTYzQTl5ekZkOVFweWtDbThjRFFDQXU1ZjBpS2VER1M5aWV4aUFJ?=
 =?utf-8?B?SzY5bHVvQWlzWHBIZGt3MUNIaGt6ckNmNzB6NmlaYThNK2FkZzdOTitpRk8r?=
 =?utf-8?B?dnErdzZaUXJhMzRDNEN3YWkrYUhyTUVpUis3WXROMnF3V3EzVHZtam9saUFT?=
 =?utf-8?B?M0gveXo5ZTJuR2hYL215V2tNbWx0NU1UY2JMOTJBTkdJbnAzTlJkVFh6WHVQ?=
 =?utf-8?B?dDFEdXo2ZEZPTmExK1pPQmh5NkhTdVdFSUxPc2h2SFpDQWNqemk2RHR2aG4y?=
 =?utf-8?B?bXpsdGdMdXVtNDlRN0twVFFVdDhUeW5BNDM5VExoTDl1aytrczRXTUZpS2ww?=
 =?utf-8?B?aERYRjRWcXd4SFJDVEVjYVZpTWt6Zk1mWUZyOGNxWnd6ZEp5V21WbFU1QW1W?=
 =?utf-8?B?bWUySGIvc2xWVHVBN08xQi9VRzh5eTVURlpXVHJUeXRYZlUvWndlZHB3R0py?=
 =?utf-8?B?Wm1SRUo5bEdRZTFNWVJZOTJGVTZTOHhEenpUWUNKYk85L3hGZEMxcGx2NHgx?=
 =?utf-8?B?Zy95UmhDclpHTlJqQ0VjTnYvdG9kS3FVcmJ6WXdXUlhqeDJYMGJGQjZxRVNa?=
 =?utf-8?B?SXo1Z3FuUytJcTlydk1YODc0Tjk3QnBKeWNsSk9yQXV0djJHQ3hzNDgvSVc1?=
 =?utf-8?B?YlQxdVIzNnJmclZtcitybWFweXhNOS9Wd3l6cVFmZWRPMmdaQXJjT3UvNEJl?=
 =?utf-8?B?ajZCRkpITGYzUW91ZndPeDg0ZVZmVTNwZnA3WFhGRXFkdWxXUWtFQlRwNzcx?=
 =?utf-8?B?aW4rczBQWGJKY21TQlVzOXFkMHhwT0NjeHZJbnV6T3ZrOTNFOTcveXNpaGVP?=
 =?utf-8?B?Wk1NTkR2TzJwL2wyTmlnQWZJT09NN25vUEU4M0NWbzJtSjBtMk81cHFBblNa?=
 =?utf-8?B?M0pPcWFQM0Ewa29lNldMaTJwcGtsTS90RWVLcWpPQnUyYXJzQW1zd3V3RE5B?=
 =?utf-8?B?eFdLSjBWL3lVTUJvSU9MZTFUUmhxdHlEdjBRNUN2RFdoUHFVTHU4cGs0eWZn?=
 =?utf-8?B?OGIyTVFIZDdJMnJCVGw5dXF1TzhNZ3ZrZ2J0aXkwdTl0S1FIQUgxM2M0eU9l?=
 =?utf-8?B?aDYxZDFEWms2enRxNTNWdDlOdkhZcGdpRDBOb25yUmwzeXA4UEFoMm9GODNi?=
 =?utf-8?B?T1FIWXF1YTRLVW8xVW5JZ0R5SnY3cnhXeC9WczlDVnExMG9PR1M3ak5rZUpP?=
 =?utf-8?B?Z3lMNzRVdWZCNTQxbEYzLzZxUmJvYTgzTEd0QmQ2N2QxOHVwclRtajFGYVcr?=
 =?utf-8?B?dDgrQ2ZwYjZkbzVoV1U2NVZLY2VER2pBcVVaS2JxSGRnYjU4a0w1QW52WjAy?=
 =?utf-8?B?VFU1VzZXMTRSUTVrWk8rd1ZqaEpFaXZ5cXNDTC9WclBLVjMzL2lhb0Ixci9n?=
 =?utf-8?B?M01SOHBUVVpRNTBmY2dkbHVhVEpLQWNma2txK0tTQmJSNTkzQlYrZGZnVXRa?=
 =?utf-8?B?aWFIVmtlV095SndPd0s5OWcxRFlaM2NzQ1N2REkzYzVKL2RLL0Z2YlFhbVF2?=
 =?utf-8?B?dkUvT2QrSVh1VzZYS0VqMERocFR0Q3lSRHYwZTE3SVJZbG5DbDRnRGxick80?=
 =?utf-8?B?VzdJNVdaNExadkMrTXVyOWhZT1U5Vk1OMklaT2ZFRzl0ZEMvK2NBR3JuazBR?=
 =?utf-8?Q?58j6CQpbwivAy6wpynBh7P2Lu+FwA24KJI/mUik?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62eee08-1223-40c8-1b36-08d8f3f927d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 03:57:51.3014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qpybp+n/ZVSgGHXu93s2awD643TdmCwJ0+IqfOEaot6OdmnzScoHnBkrb3nc+fMYmI3mTzvZcH6CqoffAclUPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5912
Message-ID-Hash: 5BVNMYIYQZCJHUJI3YBZ5GK3LF26RCEN
X-Message-ID-Hash: 5BVNMYIYQZCJHUJI3YBZ5GK3LF26RCEN
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JP65CCUITDHEYPGCBHRMYNN57URMYMR2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Ritesh Harjani <riteshh@linux.ibm.com>
> Sent: Tuesday, March 23, 2021 11:48 PM
> Subject: Re: [PATCH v3 02/10] fsdax: Factor helper: dax_fault_actor()
> 
> 
> 
> On 3/19/21 7:22 AM, Shiyang Ruan wrote:
> > The core logic in the two dax page fault functions is similar. So,
> > move the logic into a common helper function. Also, to facilitate the
> > addition of new features, such as CoW, switch-case is no longer used
> > to handle different iomap types.
> >
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > ---
> >   fs/dax.c | 291 +++++++++++++++++++++++++++----------------------------
> >   1 file changed, 145 insertions(+), 146 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 7031e4302b13..33ddad0f3091 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -1053,6 +1053,66 @@ static vm_fault_t dax_load_hole(struct xa_state
> *xas,
> >   	return ret;
> >   }
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
> >   s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
> >   {
> >   	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK); @@
> -1289,6
> > +1349,61 @@ static int dax_fault_cow_page(struct vm_fault *vmf, struct
> iomap *iomap,
> >   	return 0;
> >   }
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
> > +		struct xa_state *xas, void *entry, bool pmd, unsigned int flags,
> > +		struct iomap *iomap, struct iomap *srcmap) {
> > +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> > +	size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
> > +	loff_t pos = (loff_t)xas->xa_offset << PAGE_SHIFT;
> 
> shouldn't we use xa_index here for pos ?
> (loff_t)xas->xa_index << PAGE_SHIFT;
Yes.
> 
> > +	bool write = vmf->flags & FAULT_FLAG_WRITE;
> > +	bool sync = dax_fault_is_synchronous(flags, vmf->vma, iomap);
> > +	int err = 0;
> > +	pfn_t pfn;
> > +
> > +	/* if we are reading UNWRITTEN and HOLE, return a hole. */
> > +	if (!write &&
> > +	    (iomap->type == IOMAP_UNWRITTEN || iomap->type ==
> IOMAP_HOLE)) {
> > +		if (!pmd)
> > +			return dax_load_hole(xas, mapping, &entry, vmf);
> > +		else
> > +			return dax_pmd_load_hole(xas, vmf, iomap, &entry);
> > +	}
> > +
> > +	if (iomap->type != IOMAP_MAPPED) {
> > +		WARN_ON_ONCE(1);
> > +		return VM_FAULT_SIGBUS;
> > +	}
> 
> So now in case if mapping is not mapped, we always cause VM_FAULT_SIGBUG.
> But earlier we were only doing WARN_ON_ONCE(1).
> Can you pls help answer why the change in behavior?
> 

The behavior in PTE fault was always check the error code by dax_fault_return(error) after WARN_ON_ONCE(1).  So, I moved the dax_fault_return() into dax_fault_actor().  But I just found that, in PMD fault, it didn't do this check.  So, I think I should move dax_fault_return() outside the dax_fault_actor() to keep the previous logic.

> 
> 
> 
> > +
> > +	err = dax_iomap_pfn(iomap, pos, size, &pfn);
> > +	if (err)
> > +		return dax_fault_return(err);
> 
> Same case here as well. This could return SIGBUS while earlier I am not sure
> why were we only returning FALLBACK?
> 
Yes.  Thanks for pointing out.
> 
> > +
> > +	entry = dax_insert_entry(xas, mapping, vmf, entry, pfn, 0,
> > +				 write && !sync);
> 
> In dax_insert_entry() we are passing 0 as flags.
> We should be passing DAX_PMD/DAX_PTE no?
> 
My mistake.
> 
> > +
> > +	if (sync)
> > +		return dax_fault_synchronous_pfnp(pfnp, pfn);
> > +
> 
> 
> /* handle PMD case here */
> > +	if (pmd)
> > +		return vmf_insert_pfn_pmd(vmf, pfn, write);
> 
> /* handle PTE case here */
> > +	if (write)
> > +		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
> > +	else
> > +		return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
> > +}
> 
> It is easy to miss the return from if(pmd) case while reading.
> A comment like above could be helpful for code review.
> 
> 
> > +
> >   static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> >   			       int *iomap_errp, const struct iomap_ops *ops)
> >   {
> > @@ -1296,17 +1411,14 @@ static vm_fault_t dax_iomap_pte_fault(struct
> vm_fault *vmf, pfn_t *pfnp,
> >   	struct address_space *mapping = vma->vm_file->f_mapping;
> >   	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
> >   	struct inode *inode = mapping->host;
> > -	unsigned long vaddr = vmf->address;
> >   	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
> >   	struct iomap iomap = { .type = IOMAP_HOLE };
> >   	struct iomap srcmap = { .type = IOMAP_HOLE };
> >   	unsigned flags = IOMAP_FAULT;
> >   	int error, major = 0;
> >   	bool write = vmf->flags & FAULT_FLAG_WRITE;
> > -	bool sync;
> >   	vm_fault_t ret = 0;
> >   	void *entry;
> > -	pfn_t pfn;
> >
> >   	trace_dax_pte_fault(inode, vmf, ret);
> >   	/*
> > @@ -1352,8 +1464,8 @@ static vm_fault_t dax_iomap_pte_fault(struct
> vm_fault *vmf, pfn_t *pfnp,
> >   		goto unlock_entry;
> >   	}
> >   	if (WARN_ON_ONCE(iomap.offset + iomap.length < pos + PAGE_SIZE))
> {
> > -		error = -EIO;	/* fs corruption? */
> > -		goto error_finish_iomap;
> > +		ret = VM_FAULT_SIGBUS;	/* fs corruption? */
> > +		goto finish_iomap;
> >   	}
> >
> >   	if (vmf->cow_page) {
> > @@ -1363,49 +1475,19 @@ static vm_fault_t dax_iomap_pte_fault(struct
> vm_fault *vmf, pfn_t *pfnp,
> >   		goto finish_iomap;
> >   	}
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
> > +	ret = dax_fault_actor(vmf, pfnp, &xas, entry, false, flags,
> > +			      &iomap, &srcmap);
> > +	if (ret == VM_FAULT_SIGBUS)
> >   		goto finish_iomap;
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
> >   	}
> 
> It is much better if above accounting is also done in dax_fault_actor()
> function itself. Then at the end of this function we need to just do
> "return ret"  instead of "return ret | major"
> 
Yes.


--
Thanks,
Ruan Shiyang.
> 
> >
> > - error_finish_iomap:
> > -	ret = dax_fault_return(error);
> > - finish_iomap:
> > +finish_iomap:
> >   	if (ops->iomap_end) {
> >   		int copied = PAGE_SIZE;
> >
> > @@ -1419,66 +1501,14 @@ static vm_fault_t dax_iomap_pte_fault(struct
> vm_fault *vmf, pfn_t *pfnp,
> >   		 */
> >   		ops->iomap_end(inode, pos, PAGE_SIZE, copied, flags, &iomap);
> >   	}
> > - unlock_entry:
> > +unlock_entry:
> >   	dax_unlock_entry(&xas, entry);
> > - out:
> > +out:
> >   	trace_dax_pte_fault_done(inode, vmf, ret);
> >   	return ret | major;
> >   }
> 
> 
> -ritesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
