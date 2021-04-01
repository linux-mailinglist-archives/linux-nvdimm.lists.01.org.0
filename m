Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A06350FBA
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Apr 2021 09:03:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B0379100F2248;
	Thu,  1 Apr 2021 00:03:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.159.90; helo=esa9.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3F608100F2244
	for <linux-nvdimm@lists.01.org>; Thu,  1 Apr 2021 00:03:37 -0700 (PDT)
IronPort-SDR: 0iArf7O9FF/f/rhrQDc+KVcgfD8wC0og3W8iAnlbDfwPMzQT2Ym7IG8LBFlTi3mH007bhKqKbQ
 JKkX1OvzM/Y7uVORCfCdMFVOcuh/IaSJtMQJri0AhbextHHwDHMYHXNCtiJdSZJrgSjzSBdA5X
 /AuKUEYYLewpXLKPx5gyX2600jMaENXsQYqcLo+CJbEQrASyII4Ko1rL54zU9+eFJ9CgZOoXEC
 4NnQd/iEJohugdLro/Sz6Dy/5ISe51PthKrlCGnxSidqMq0Un3vvpE5rGFs/XFBwCF78N36pYU
 CCg=
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="28961230"
X-IronPort-AV: E=Sophos;i="5.81,296,1610377200";
   d="scan'208";a="28961230"
Received: from mail-os2jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 16:03:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdFfO7bSivGG0bLPgePK5pGiocpX+UwpJq9mFcPdAfN6HquqFqQGlCLRFxv5STMdEltFqEMF0M1zeZdbeyeEZf9uSn9bWSfLqMJuuQQe4FC+bCcDW0x6KfYZxfMFfF0K+BnUOvWN8OuXCAgQU+2aS0njuKvwRME1n5XACHLPDDXeJG3MR5bW+mqcr5pBXlC+T87XEeT6Gf/dpZncOwEO4iG+/3k4kLaffrFfyWIfZPcXwHJQdSTT0EV2kU2RBaRnZ2yAXkV82WdaSoCwQxiKpP5P+/oSCdHjHZieO9JbG//oxQ80HhpUd8A6t27j4nmHuRmaZ2HCsquP7xCPjbrm/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ2D0oqL9SKmgpgxMcLnJRE/FwWCwQz2+5/rPbLiu60=;
 b=NyWSHrcUVrOdLfK45rHUUfQ5YKIePWc6xM3TlCjgVQWfpH/CjRTRe9kclfsch/JHCPOCmLD6v9VBeLq2nk90ZvRJxjvq4LemqhekylUOYYHjUBlto+hiyuwDb/d11V/Duy/Wgm46jGpwNojKOwrWvo1RQu6xbpLAl2NJ3DJdYXk20JglvQ9scVODTaspEfIB3fRFxU0BwLf3MGMireDjERpeNhRGU0KHIBKGJc12qqyratHwYzSd0EfRBsWWX2QgvxwL/h5mnaM3T8z7YAGMAWxAA3O1cQI6c1NpzTauhxDSBrIeZ7G7Bj0hZS6260kiMtvgVrqwbp73Eg88sS60hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ2D0oqL9SKmgpgxMcLnJRE/FwWCwQz2+5/rPbLiu60=;
 b=VnSwR6WpTqcFGqZIpkbA64aMiAnxk84oPHACAyT/xLFwISsYEU/PtPteyUKSCS9E20GMZXUyI8CKiCYSWQ/0clKVBCL6+NbWQf8joWaTbSHZciAvxSTOiVrkZ7LEI0nwG1ivcih4xn+AX0hMoKQvQE1TUJh0MJOwlti+NQs2qLk=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSAPR01MB4962.jpnprd01.prod.outlook.com (2603:1096:604:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 07:03:19 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::68f4:1e20:827c:a2ca]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::68f4:1e20:827c:a2ca%4]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 07:03:19 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Subject: RE: [PATCH v3 05/10] fsdax: Replace mmap entry in case of CoW
Thread-Topic: [PATCH v3 05/10] fsdax: Replace mmap entry in case of CoW
Thread-Index: AQHXHGKvSyKT++zpt0u/LvAsYeN2+KqfSsYAgAAGOVA=
Date: Thu, 1 Apr 2021 07:03:19 +0000
Message-ID: 
 <OSBPR01MB2920C6CE58C98BF5A42E1700F47B9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-6-ruansy.fnst@fujitsu.com>
 <20210401063932.tro7a4hhy25zdmho@riteshh-domain>
In-Reply-To: <20210401063932.tro7a4hhy25zdmho@riteshh-domain>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a62cb54-1161-407e-c72d-08d8f4dc3b66
x-ms-traffictypediagnostic: OSAPR01MB4962:
x-microsoft-antispam-prvs: 
 <OSAPR01MB49623987245E19AC70367C39F47B9@OSAPR01MB4962.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 E7zvv22CR1XJeT8t/47pJkHPs3VN2+YauT6S0vikC56zMp8y7bMIc95wxWAzIKZ/0ODwEMBe5QoHaIVwoLsqStn4RraUVt7GxmrZDTV3iX0wJnzoERYP3bPEVyt1UOFgp2w6zC5HrdTJPG3Prf24G5wRVgXWZ3TRG4orAwSf7G7+I7T6XnbJw7L1jKWOsivnF3exG+7WsjnxcviMl4SNHK3vfEmk8RMBX75ZAVXntKiS6Py7cbyY6FHCeIx5l9IPyz+9KCuLDaKAMP94/ayvb6BqHrAW9sWxoy0sQP3SU04SbX1h7FTHgvrpZKA9F954tjHwU7hTKXbORB0s6xYV+RVc3pc7Mua1m9LGnnCoDCRCL4N4EpDv4hnC4mdjl+VZzWrOMzMV/ubBIHo+shS1yNArBN5bKDaCTFvqBgdAsGjP8GrKHxOPMRn4bo0p75it2UsZMSqNKbitrX/ksSJ3rrQwqFsqUnIOB3GosBl4AzMt4/sMchqIxphcd6j6UCNl2oIUBOOpP/8LekqoRamyY1tYwXpPnY6xZ8OoJWhbfEHe5NWCylW2KeYrocHAs6bdDkgfmAMs/1bHuaODCcoeVkivesOe8rpTj/lA41wRq44Idoo1FAyONJdhhNSNIewd3ONbVPvYoAX499I1Dzo9WwSzR7tNJ7MQgRwV4YE9qfE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(26005)(66476007)(186003)(66946007)(2906002)(9686003)(85182001)(4326008)(71200400001)(55016002)(76116006)(8936002)(7416002)(66446008)(8676002)(64756008)(66556008)(6506007)(316002)(6916009)(54906003)(7696005)(478600001)(33656002)(5660300002)(52536014)(53546011)(83380400001)(38100700001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?aUlyM014UDFnRlg5YitZU3FYWkRPbFNrOU9aV2NXaHViOWJ2Tll5eVA2aGZQ?=
 =?gb2312?B?bGxScXVWMmZ0SnN6djVndzlCamQvOXpNOHU2OFREa0tjbDZvTkRqeFEydzRz?=
 =?gb2312?B?b0ZtUEp6SHZ5aGwrbWl3Nk1jZXN6Um0waHdGWlJiNUczakhaV09ldy9XOXI3?=
 =?gb2312?B?V2tPWmtqUFVuaHdpMlAxWTZjUjRnRWkvbG9PckFKc3VTWmxSbHArSlBOemE5?=
 =?gb2312?B?SERPTjdMYkVOQ0d6NWNDaGpNUEo2d3BIcVlWNmhnbVlhQkFLcGFuZkc4cGJJ?=
 =?gb2312?B?WVF4NjJaR1ZFckVCOS83UlR6S1hHZC9ieHZqVVVvdHRPSy82ODQrK2tzdWk2?=
 =?gb2312?B?MlhOSEJaY1hORk9hYXpmTUxQcXBtVHpmaHlCSC9jRjJadE5HNmJ3V2pVZnJE?=
 =?gb2312?B?SDdVejZ2YTdNMWhpYjg1QmozcWJtZDhad0JGZDh3eDNlT0tXVVRlVmxPYmdR?=
 =?gb2312?B?dzNVOW1veDQ2bmNxVHAyMDRmSkRnRGJYTUoydm5XNE9OUTlaMXFFaGpqdXJm?=
 =?gb2312?B?bkJPRFB0cUlXdERrcmRnd1VEdnFaaXkyU0ZoNUdwenlZdDlxSTNyYVhBTE9q?=
 =?gb2312?B?N2NBbFZvNjFsKzB0Vk55bXhHSlVuU2E0RnhlT0dFVjNMRzZ6eUQ2UHFmdGpE?=
 =?gb2312?B?UG1hMEVqRWliTzZtUzVtTXVFb05CVUNWeXhNbzFnVlJTRlZrRDl0TzhaOW5j?=
 =?gb2312?B?SVkxeGdIWldocXcrMDdhNlMzTEs4TlFHL3NZK290d2JlcmpiMkdKTFZGREh5?=
 =?gb2312?B?dEhWZHFZR3lwZEtyS0ZJWGdDTkl4WDlwUkUxcGJDWFhHeVJOVDRqLzhoVjll?=
 =?gb2312?B?V2tZQ3l3a1A3dk5BS21saWhuY3owaXdZckRqRHJnRVhQSkszdkRsNU5EVFJH?=
 =?gb2312?B?ZkNKdGxKVnRxTWF5dDlmY1VZM2ZJS3hDUS9wOVpVOWFXcDgvdlpLWFVBTmVz?=
 =?gb2312?B?YUo0L1J1T0VXRkdEdEg0SzdjZndHREdOdndHeGk5N0haQUJvdEZaWHo5dWYz?=
 =?gb2312?B?aHZBRkJlSEhiWSs4c2NONlNLSllxdjBVOHAwemhydWVZZDlVeFRwajNKdlA5?=
 =?gb2312?B?dk83K2dsakZBRGVlNFZ1RStGRGE0VmVkLzFVYUpMNjBDR0JEa2hBYnQrSG5C?=
 =?gb2312?B?dDB0bDIrd09oN2N3SDE0UlU5eGlCUzVZSXdjQnRTbXBIZXdndERxVERGN2VE?=
 =?gb2312?B?eHdVVWEyVTY0T0VSTFFORU1La1ZXY0szUjh0N3RPbmNZUmo1RS9HL2dwd1da?=
 =?gb2312?B?WE1aK3NZV3ZKTktBd1AyOVlhUnlYUjZnK0hXdFpkMS9IZHE1V0JsQVlIM0xB?=
 =?gb2312?B?TTZMMFF6WUlWNm16dnZNVVFnYVJMb29ZNHp5bEczOEw2KzFRUy8xRGhIUXBk?=
 =?gb2312?B?eDFHdEFlbXN6S2NMWEFSL2U2dmp4VjMvVHFwL3FtTXd3Ykp2V2JLQnJPM3ZH?=
 =?gb2312?B?a2x3Y3A3dWdsOFQzUG1PZnRRZ3Vua011dEVlQlpabjFTNGNoM0VJMCtXQTFm?=
 =?gb2312?B?bm9IamhPN1Z5dGFXaFhSUGI2QzRqZGY5eVVaN2xyR0lJd0MxdXVIM1JzbWpM?=
 =?gb2312?B?b282UG1UY0d5T1MvMUVtOVNjb0YweW5Ibm9BOC9mY2l1REM4Ym1pNloyTGtj?=
 =?gb2312?B?emllQTBsNDJ3WlV3Sm4zNDd6U0ZHK253NU82ZGYxZ054bDQxMjQrNXNQdnNh?=
 =?gb2312?B?REUwZVNJSU1YdjFVMXR1cVlXYzZqWmhFQ3dPVlpnQ3VyV0RQS1p6ckE4M1VR?=
 =?gb2312?Q?4ouHRV+gGQxfs4pHVtKVTJZXb08JXlgB3P5jejM?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a62cb54-1161-407e-c72d-08d8f4dc3b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 07:03:19.7550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3hKtf83gSOC7jYxIJvR/hC6do7QdI0+D+7hw8TwK1xWqAtzUF0DqCTrHSZAoynrqd4MUeGu4EOUjgbjfM3KUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4962
Message-ID-Hash: RVON627Q4R5G6UROV56H4ACYGI33OHQG
X-Message-ID-Hash: RVON627Q4R5G6UROV56H4ACYGI33OHQG
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4KOVEA2DM2TP4UOBPRFNOJQWOZ3Z33BL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Ritesh Harjani <ritesh.list@gmail.com>
> Sent: Thursday, April 1, 2021 2:40 PM
> Subject: Re: [PATCH v3 05/10] fsdax: Replace mmap entry in case of CoW
> 
> On 21/03/19 09:52AM, Shiyang Ruan wrote:
> > We replace the existing entry to the newly allocated one in case of CoW.
> > Also, we mark the entry as PAGECACHE_TAG_TOWRITE so writeback marks
> > this entry as writeprotected.  This helps us snapshots so new write
> > pagefaults after snapshots trigger a CoW.
> >
> 
> Please correct me here. So the flow is like this.
> 1. In case of CoW or a reflinked file, on an mmaped file if write is attempted,
>    Then in DAX fault handler code, ->iomap_begin() on a given filesystem will
>    populate iomap and srcmap. srcmap being from where the read needs to be
>    attempted from and iomap on where the new write should go to.
> 2. So the dax_insert_entry() code as part of the fault handling will take care
>    of removing the old entry and inserting the new pfn entry to xas and mark
>    it with PAGECACHE_TAG_TOWRITE so that dax writeback can mark the
> entry as
>    write protected.
> Is my above understanding correct?

Yes, you are right.

> 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/dax.c | 37 ++++++++++++++++++++++++++-----------
> >  1 file changed, 26 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 181aad97136a..cfe513eb111e 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -722,6 +722,9 @@ static int copy_cow_page_dax(struct block_device
> *bdev, struct dax_device *dax_d
> >  	return 0;
> >  }
> >
> > +#define DAX_IF_DIRTY		(1 << 0)
> > +#define DAX_IF_COW		(1 << 1)
> > +
> >
> small comment expalining this means DAX insert flags used in dax_insert_entry()

OK.  I'll add it.
> 
> >
> >  /*
> >   * By this point grab_mapping_entry() has ensured that we have a locked
> entry
> >   * of the appropriate size so we don't have to worry about
> > downgrading PMDs to @@ -729,16 +732,19 @@ static int
> copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
> >   * already in the tree, we will skip the insertion and just dirty the PMD as
> >   * appropriate.
> >   */
> > -static void *dax_insert_entry(struct xa_state *xas,
> > -		struct address_space *mapping, struct vm_fault *vmf,
> > -		void *entry, pfn_t pfn, unsigned long flags, bool dirty)
> > +static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
> > +		void *entry, pfn_t pfn, unsigned long flags,
> > +		unsigned int insert_flags)
> >  {
> > +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> >  	void *new_entry = dax_make_entry(pfn, flags);
> > +	bool dirty = insert_flags & DAX_IF_DIRTY;
> > +	bool cow = insert_flags & DAX_IF_COW;
> >
> >  	if (dirty)
> >  		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
> >
> > -	if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
> > +	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
> >  		unsigned long index = xas->xa_index;
> >  		/* we are replacing a zero page with block mapping */
> >  		if (dax_is_pmd_entry(entry))
> > @@ -750,7 +756,7 @@ static void *dax_insert_entry(struct xa_state
> > *xas,
> >
> >  	xas_reset(xas);
> >  	xas_lock_irq(xas);
> > -	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> > +	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> >  		void *old;
> >
> >  		dax_disassociate_entry(entry, mapping, false); @@ -774,6 +780,9
> @@
> > static void *dax_insert_entry(struct xa_state *xas,
> >  	if (dirty)
> >  		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
> >
> > +	if (cow)
> > +		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
> > +
> >  	xas_unlock_irq(xas);
> >  	return entry;
> >  }
> > @@ -1098,8 +1107,7 @@ static vm_fault_t dax_load_hole(struct xa_state
> *xas,
> >  	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
> >  	vm_fault_t ret;
> >
> > -	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> > -			DAX_ZERO_PAGE, false);
> > +	*entry = dax_insert_entry(xas, vmf, *entry, pfn, DAX_ZERO_PAGE, 0);
> >
> >  	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
> >  	trace_dax_load_hole(inode, vmf, ret); @@ -1126,8 +1134,8 @@ static
> > vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
> >  		goto fallback;
> >
> >  	pfn = page_to_pfn_t(zero_page);
> > -	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> > -			DAX_PMD | DAX_ZERO_PAGE, false);
> > +	*entry = dax_insert_entry(xas, vmf, *entry, pfn,
> > +				  DAX_PMD | DAX_ZERO_PAGE, 0);
> >
> >  	if (arch_needs_pgtable_deposit()) {
> >  		pgtable = pte_alloc_one(vma->vm_mm); @@ -1431,6 +1439,7 @@
> static
> > vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
> >  	loff_t pos = (loff_t)xas->xa_offset << PAGE_SHIFT;
> >  	bool write = vmf->flags & FAULT_FLAG_WRITE;
> >  	bool sync = dax_fault_is_synchronous(flags, vmf->vma, iomap);
> > +	unsigned int insert_flags = 0;
> >  	int err = 0;
> >  	pfn_t pfn;
> >  	void *kaddr;
> > @@ -1453,8 +1462,14 @@ static vm_fault_t dax_fault_actor(struct vm_fault
> *vmf, pfn_t *pfnp,
> >  	if (err)
> >  		return dax_fault_return(err);
> >
> > -	entry = dax_insert_entry(xas, mapping, vmf, entry, pfn, 0,
> > -				 write && !sync);
> > +	if (write) {
> > +		if (!sync)
> > +			insert_flags |= DAX_IF_DIRTY;
> > +		if (iomap->flags & IOMAP_F_SHARED)
> > +			insert_flags |= DAX_IF_COW;
> > +	}
> > +
> > +	entry = dax_insert_entry(xas, vmf, entry, pfn, 0, insert_flags);
> >
> >  	if (write && srcmap->addr != iomap->addr) {
> >  		err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr, false);
> >
> 
> Rest looks good to me. Please feel free to add
> Reviewed-by: Ritesh Harjani <riteshh@gmail.com>
> 
> sorry about changing my email in between of this code review.
> I am planning to use above gmail id as primary account for all upstream work
> from now.
> 

--
Thanks,
Ruan Shiyang.

> > --
> > 2.30.1
> >
> >
> >
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
