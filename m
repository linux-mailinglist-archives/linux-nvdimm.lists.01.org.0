Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC8033E7D8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Mar 2021 04:46:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 95166100EBB92;
	Tue, 16 Mar 2021 20:46:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.71.156.125; helo=esa12.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4EDD1100EBBA0
	for <linux-nvdimm@lists.01.org>; Tue, 16 Mar 2021 20:46:33 -0700 (PDT)
IronPort-SDR: AY2tRktzTmZelxYTOOGv95zO+YHc+MATujKJJHAPOsz1H1YCg36nRHwGE2ZF484D8DlLFFtTn+
 QxdZ1RRKQOj1JHeEaQWbCjsPtGaTxI7HgtCVJxmPZpuvfjwgNZuT9qVA6SI/7fph8jhUqKFxI8
 vEzrl1ApogsqgnEQZWi2+CnGxeUTyF24NigC2X5Ad8XQkWW+ssf8m40qV9GJrmw2l3/KOHY3pb
 obS6vGw/6cyJgssO5kkAuHfMEX1LZ2egd8e1GzkwZtgw49BquMw+EuF1FBvphTVwHzP/WKxKX0
 wxI=
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="28034617"
X-IronPort-AV: E=Sophos;i="5.81,254,1610377200";
   d="scan'208";a="28034617"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 12:46:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcNtrR0zO7BjsVrXueH1xu90WAEUR7DoH+NvQat2JeSi7UK9mlCCFhnWlDd5bdKFHMJt+UzPcnqJOIiLqMBYKOh6yDZ3ts6k9WVezQjxgpIbU4wsFkq0ERB+bPWCWNisJK7jQnnGL9mZV2QqU5WcQgkLDQEG8iCsFNemF2urqUCYHrJbFD7RNm+aFxMlT0kpmr3bXfMqzWAeybOFR6ZoP4fJbCgUphUGJDxppr92wWv1ZCcF7vqNNSAKyLsULy6cHJhO77obXpUX/wAnyuxEtCkMm6cm9vPFDLlg3rDCziqUKCrHPGV1orMe3P3inP0CgyfZdzyLDzHG1tf8eABfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhSMWl6FANZM6f2NcHjyl62YSDgNpFvrRUlXwpXRu5M=;
 b=VleGJVXJCUPgNB6pxb6i/4Win9WyyI9zpmhy9lMx3LEHj+9oyaPRuu840uZUGiAlzJKlVq8c1cKjzF0YsZ40aXiyV9dda5PRQwe+1bG/KVRYlOgoH5MrElrnjy9So719vMqrRIsKz5/pHhWGNeyEdsiAD6CztMueSNGu4xodZfHXrVACkr1AHsfJsxYPxLle1ngOVVNEs4AlT6cA9flSUwXZS5R3a63jExhOzz53YdBqGlydqSFCV2kI8ICaRElcaQRX/Ii7NEjEWFVzQt1yLU3owTG/bC5cEgR3QRoYrHvCMJwQ3B7+h+Iv767lWu9dViHsepGELGnno4aJ35ca8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhSMWl6FANZM6f2NcHjyl62YSDgNpFvrRUlXwpXRu5M=;
 b=O6OMLHEasmkHkDhdPZ7tyL6nX+7j0wfsWiqPcrY6v2a7SpyAAcStYwbTqAg6hftHsG+D9/0BwHbblYEzfxX1X6KLoJdpqH/XgBzVL7ujAbc5vGTRhXlcdHJFpFNfnwOrgzbEHoXsN7nYaa6h8usPdEBbYZKjpvcFM5uOsBmETXs=
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com (2603:1096:603:3f::16)
 by OSYPR01MB5445.jpnprd01.prod.outlook.com (2603:1096:604:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 03:46:26 +0000
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::c447:a3af:7d9:f846]) by OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::c447:a3af:7d9:f846%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 03:46:26 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: zhong jiang <zhongjiang-ali@linux.alibaba.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: RE: [PATCH v3 05/11] mm, fsdax: Refactor memory-failure handler for
 dax mapping
Thread-Topic: [PATCH v3 05/11] mm, fsdax: Refactor memory-failure handler for
 dax mapping
Thread-Index: AQHW/gj8oXKCFpjX90yJ/yLnXTVuwqqGKuWAgAGHziA=
Date: Wed, 17 Mar 2021 03:46:25 +0000
Message-ID: 
 <OSAPR01MB2913D9A487C1D55171C5059EF46A9@OSAPR01MB2913.jpnprd01.prod.outlook.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-6-ruansy.fnst@cn.fujitsu.com>
 <e1be1767-f9c0-e17a-5c14-22bb2f0ca5aa@linux.alibaba.com>
In-Reply-To: <e1be1767-f9c0-e17a-5c14-22bb2f0ca5aa@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89035986-5f36-4bb6-ee60-08d8e8f73d93
x-ms-traffictypediagnostic: OSYPR01MB5445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSYPR01MB544586316A108FF9E8858AA3F46A9@OSYPR01MB5445.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DJgYhbJ97Gq/bvwKOpty3ZzeJ277RNw07ZprwQ71UIjRhht7uN6dTd1DcUfarUhoHe8TIjYVlpba3plT8eMP8CCVzZJ+O9DgJT6bxhGaqCiVkGjfoUJphR1r/1QTqOlyHWWCT+azaqXf9BGYHDJQvRHZO6twLdwvG0ZKSuIrSuGyxVzsnjDqVRYFuHXDxe7/vXNbogGEEPL+eyFVqIjniYovVdYpbOuBw6gEOE425UsqmfI8FL/A4gb1G5PNDT+B0Q6wrZQGEdMfECjmbcTiGhXLixG23GiN0DU2TVZPySQMqMN6yOG4JUg6IPYmgyvE5M5cazAAKDYK5PEOEU0goQo/Oq8OBbu9niQoq+5BZsBgvLgOR8FhKoMuHf/BUCTJyj5qMKGFmxp42l4YP2QlWnlprQU9VtRgZXN7HCjjYnRIjlJWIqV1zSL7FnMxhMVAHRWmMdlJ85OsqhTmf3mjaMBy9OpTW++v7zQIJmWJObfVkZvzOA6jZl/zIdndDHHSu7wpFGg61Vt9ui/OgjYVpdHh9w19rAbOZCP+mk2uwS7Iufb1wxwkLy2LdO1bg0/2
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2913.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(6506007)(7416002)(186003)(71200400001)(316002)(110136005)(66556008)(54906003)(85182001)(66476007)(7696005)(66446008)(64756008)(86362001)(4326008)(55016002)(52536014)(83380400001)(8936002)(107886003)(26005)(9686003)(478600001)(76116006)(33656002)(66946007)(5660300002)(8676002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?utf-8?B?MzRBSUtwSWl5cDFmWVArS3hSZkJvNEZvTVZIZlhEUXVmc2VYUXloREpwT0hm?=
 =?utf-8?B?R29kNkQrZDJ2Y21oV3pXTUtjengzZFlWL05paWxXNDNZMXRUQUs5ZERheDFE?=
 =?utf-8?B?MUhhUXN2RDlLSVZVeHFtY2o1bkVuellKRk00NjFJbTh1TGtPKzJ3bkFXRnRi?=
 =?utf-8?B?SXRMUzZicDB4K3lJNFc0cDZCa0xsUGQveW4yanBRYUpOejlsRFFITlBJNk5Q?=
 =?utf-8?B?RFdnWEk0R0pCNzREbE9KSytrYjM0MkxWSk8rcjY5c01yMzRIaC84WlVISFNP?=
 =?utf-8?B?d1k4ZXNieUhCUFdOamgwL0NMUjViVG9oUHFRcE1oQUFkRUo3Y1l2WW9qTysw?=
 =?utf-8?B?cGx0Sk5RZ0xndjhVaHlORjU5YWI4NFBVbjZ3V3F5Rlhjd000a3p3SkJRc0Jq?=
 =?utf-8?B?UHZXNm03VWFZWXNWcjIwT2d0eU1WUlkybktPbzltcmdLNi96a1NnWWJoU0NH?=
 =?utf-8?B?dkg1U2gwaDhSaUxNMEFWeS9UdnM5c28yb3o1S3BNcWV3enJpNXhjcWtTc0tP?=
 =?utf-8?B?SmlWV0Q3cEQ5Smh5aVNQdkRybWVENFFXQkt3ck42OHV2d21JbDFhWVN3MXpF?=
 =?utf-8?B?N3ZvN0hQb3NmUlR0Z0RSR3oyQ21xQ2FYNzgrZHV6SSt5WW53VTRtYXBFN2tL?=
 =?utf-8?B?RHp1OW0wT3RMRHFlNm95alQ2WDg4MUR4dWs4ME55T2k5RHdIRGFnTUNYVTBQ?=
 =?utf-8?B?c0YyM2Z4YURZMzdOUVZ2MFpnbHM4OVI4UWR4dzFGRm9NR3dhL0pseUN6RFhY?=
 =?utf-8?B?K3FRYndvbklLWURZTHpuNHhnR1FWUHc0NnNKK1YzZ211eFBZYlJtTjErVFJp?=
 =?utf-8?B?WHFLT2kxcjBmMnFiSlpYZ0pkUDRoczk4Sm92dVYwdVB4YlBiaGNRR2VJdm1J?=
 =?utf-8?B?L1JxZkJWOEw4QTdWSlNuNjhWejJTUm8rdDh5UVZ2OERXbFYzMW9ZQnBRMjJo?=
 =?utf-8?B?SC8xUVIxTEJLUTZrc1dyTG80SFp3RjZ5OEh5QUh1U0UweXEyeDhBajJRWjJV?=
 =?utf-8?B?ZERtTEdFd3haalNSRTZOU1NTaFVtR3MxcnB3L2RnRUd0clF3bDZta2toVkor?=
 =?utf-8?B?aTRtMG9jT1BwUnBnZysxTUtaZ09tRXBRc1QrTHlxczk4OFRqdjNycmRjRlA4?=
 =?utf-8?B?V0VmQXV5eHA2QWFFTXNyZU9BQjloOUY1UEUvM1RZVTVoS0lzWmp4cGZLbUQz?=
 =?utf-8?B?MHdGMUt3N21mdnlEYTZrU2ZFbFlpTHJNUjVSUlM4elRqMXBiazhCL0kwdWg3?=
 =?utf-8?B?VTFKSE02Vy9rTXA5SzZ6OVZPNmQxWmZrQm9kcndJck01bmFMNkdVSGcwdlNh?=
 =?utf-8?B?TkhjV2UyZ24yUVhJSWdKSy9vbldFSXZJVjhnSmw4bzRZMjY1b2EzL1R5TEE4?=
 =?utf-8?B?UVZrWmZEdW5SM1diM1htUEhyenM5TmNBVFhxaVl5bUYyUXVGNlRmTTZzUTd0?=
 =?utf-8?B?d1NzdzBYWmNreGZDRHVMazlEQkd3QzlEVE9EMkEwTU9wQUY0UTVyYUZxbE95?=
 =?utf-8?B?M1dQdUFxbGVKdndnbzZsYkpLVTJwS0V1M1pVZEJkdGZwanpHSW5ndXV2Vm9m?=
 =?utf-8?B?Zi9TQml4WnJpSjBONFN4NHJhMTlSWGhWNGdnYWpXK0UxNFdJSUYvTGJRaWhm?=
 =?utf-8?B?dGRFYWh0VzA5aWxGSGxuRnQrQ3BTeE10Wkh1YTZpYTZVUHdRRFlqbk1McG9C?=
 =?utf-8?B?WmdncnFsUDhvNUZJdnVXZm84am9QSmo1UE1FMk5uR2ZxenFNemVrUWtEdDlT?=
 =?utf-8?Q?cdLspVQhXufuSIHp1RFk9YiYyfehN2AlLwDyjdg?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2913.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89035986-5f36-4bb6-ee60-08d8e8f73d93
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 03:46:25.9826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3q7/T8OHRdZP7dVxFUxQjFog5+OAtHOXFrFPBKx1gNqjyC1rNb8WM51223zQJQahybz3n/lUwO1o5QS4qYKXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5445
Message-ID-Hash: F47N34Y42DGVFX67T7XR7ZJIR6LNR47G
X-Message-ID-Hash: F47N34Y42DGVFX67T7XR7ZJIR6LNR47G
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "agk@redhat.com" <agk@redhat.com>, "snitzer@redhat.com" <snitzer@redhat.com>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>, "y-goto@fujitsu.com" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O76XO7TYZ5UYZUNJ54IJFX32KPRUAOI6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: zhong jiang <zhongjiang-ali@linux.alibaba.com>
> Subject: Re: [PATCH v3 05/11] mm, fsdax: Refactor memory-failure handler for
> dax mapping
> 
> > +int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t
> > +index, int flags) {
> > +	const bool unmap_success = true;
> > +	unsigned long pfn, size = 0;
> > +	struct to_kill *tk;
> > +	LIST_HEAD(to_kill);
> > +	int rc = -EBUSY;
> > +	loff_t start;
> > +
> > +	/* load the pfn of the dax mapping file */
> > +	pfn = dax_load_pfn(mapping, index);
> > +	if (!pfn)
> > +		return rc;
> > +	/*
> > +	 * Unlike System-RAM there is no possibility to swap in a
> > +	 * different physical page at a given virtual address, so all
> > +	 * userspace consumption of ZONE_DEVICE memory necessitates
> > +	 * SIGBUS (i.e. MF_MUST_KILL)
> > +	 */
> > +	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
> 
> MF_ACTION_REQUIRED only kill the current execution context. A page can be
> shared when reflink file be mapped by different process. We can not kill all
> process shared the page.  Other process still can access the posioned page ?

AFAIK, the other processes will receive a SIGBUS when accessing this corrupted range.  But I didn't add a testcase for this condition.  I'll test it.  Thanks for pointing out.


--
Thanks,
Ruan Shiyang.

> 
> Thanks,
> zhong jiang
> 
> > +	collect_procs_file(pfn_to_page(pfn), mapping, index, &to_kill,
> > +			   flags & MF_ACTION_REQUIRED);
> > +
> > +	list_for_each_entry(tk, &to_kill, nd)
> > +		if (tk->size_shift)
> > +			size = max(size, 1UL << tk->size_shift);
> > +	if (size) {
> > +		/*
> > +		 * Unmap the largest mapping to avoid breaking up
> > +		 * device-dax mappings which are constant size. The
> > +		 * actual size of the mapping being torn down is
> > +		 * communicated in siginfo, see kill_proc()
> > +		 */
> > +		start = (index << PAGE_SHIFT) & ~(size - 1);
> > +		unmap_mapping_range(mapping, start, start + size, 0);
> > +	}
> > +
> > +	kill_procs(&to_kill, flags & MF_MUST_KILL, !unmap_success,
> > +		   pfn, flags);
> > +	rc = 0;
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(mf_dax_mapping_kill_procs);
> > +
> >   static int memory_failure_hugetlb(unsigned long pfn, int flags)
> >   {
> >   	struct page *p = pfn_to_page(pfn);
> > @@ -1297,7 +1346,7 @@ static int memory_failure_dev_pagemap(unsigned
> long pfn, int flags,
> >   	const bool unmap_success = true;
> >   	unsigned long size = 0;
> >   	struct to_kill *tk;
> > -	LIST_HEAD(tokill);
> > +	LIST_HEAD(to_kill);
> >   	int rc = -EBUSY;
> >   	loff_t start;
> >   	dax_entry_t cookie;
> > @@ -1345,9 +1394,10 @@ static int
> memory_failure_dev_pagemap(unsigned long pfn, int flags,
> >   	 * SIGBUS (i.e. MF_MUST_KILL)
> >   	 */
> >   	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
> > -	collect_procs(page, &tokill, flags & MF_ACTION_REQUIRED);
> > +	collect_procs_file(page, page->mapping, page->index, &to_kill,
> > +			   flags & MF_ACTION_REQUIRED);
> >
> > -	list_for_each_entry(tk, &tokill, nd)
> > +	list_for_each_entry(tk, &to_kill, nd)
> >   		if (tk->size_shift)
> >   			size = max(size, 1UL << tk->size_shift);
> >   	if (size) {
> > @@ -1360,7 +1410,7 @@ static int memory_failure_dev_pagemap(unsigned
> long pfn, int flags,
> >   		start = (page->index << PAGE_SHIFT) & ~(size - 1);
> >   		unmap_mapping_range(page->mapping, start, start + size, 0);
> >   	}
> > -	kill_procs(&tokill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
> > +	kill_procs(&to_kill, flags & MF_MUST_KILL, !unmap_success, pfn,
> > +flags);
> >   	rc = 0;
> >   unlock:
> >   	dax_unlock_page(page, cookie);
> 

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
