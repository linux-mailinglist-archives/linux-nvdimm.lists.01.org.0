Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5813B270A6D
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Sep 2020 05:38:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E2E9213F6D0A7;
	Fri, 18 Sep 2020 20:38:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.219.250.5; helo=mail1.bemta24.messagelabs.com; envelope-from=ahuang12@lenovo.com; receiver=<UNKNOWN> 
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com [67.219.250.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 99D6D13B55591
	for <linux-nvdimm@lists.01.org>; Fri, 18 Sep 2020 20:38:41 -0700 (PDT)
Received: from [100.112.129.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
	by server-5.bemta.az-a.us-west-2.aws.symcld.net id 2E/A8-53750-E3D756F5; Sat, 19 Sep 2020 03:38:38 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRWlGSWpSXmKPExsWSLveKVdeuNjX
  e4Nl9Tov1p44xW0yfeoHRYu+72awWs6c3M1lc3jWHzaJ54m12i7aNXxktFmx8xOjA4bF4z0sm
  j+7Z/1g83u+7yuZxZsERdo/Pm+QCWKNYM/OS8isSWDNuvvvNVHBboaLh63fWBsYlCl2MXBxCA
  g1MEn8PLGKGcF4xSnza8JwRLvN/6gQghxPI+c0ocXa6CEiCUWAps8SThx9YIJxjLBJNd6awQj
  gbGCW6f30Ga2ER2M0s0fbHGmLWPCaJi39amSCcx4wS72buAFrJwcEmoCVxdlMiSIOIQKTEjlV
  LwJYzC/QzSfQ9WwI2SVjAWeLQkQYWiCIXifYrm9khbCOJrY/msEFsU5XY9eU0WA2vQILEg+Pr
  2CEOj5F4sukvM4jNKRArcezNIrCZjAJiEt9PrWECsZkFxCVuPZkPZksICEgs2XOeGcIWlXj5+
  B/Ua12MEi9On2OFSChIPDv+nR3ClpW4NL+bEcL2lXh9exvUIC2JZbtvQMWzJSbeaWKBsNUkmg
  /sgbLlJFb1PmSZwGg0C8kds4DhwiygKbF+lz5EWFFiSvdD9llgrwlKnJz5hGUBI8sqRoukosz
  0jJLcxMwcXUMDA11DQyNdQ2MDXSNDS73EKt1EvdJi3fLU4hJdI73E8mK94src5JwUvbzUkk2M
  wISWUtB0ewfjv9cf9A4xSnIwKYnyPqlMjRfiS8pPqcxILM6ILyrNSS0+xCjDwaEkwTunGignW
  JSanlqRlpkDTK4waQkOHiURXrUaoDRvcUFibnFmOkTqFKMxx4SXcxcxcxyZu3QRsxBLXn5eqp
  Q4ryhIqQBIaUZpHtwgWNK/xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmY9wfIPTyZeSVw+4B
  JF+gLEd7vf1NATilJREhJNTDN+GEleeX4jSdhapvd2Vn3OL4udAkwmBYSFsu8bI695sQsb9GA
  ZXabt8sUX+xMn3lhUr2xCLc6t6hz+Gv27Hq/27K6fd/c1j5WONKU09J5Pjd51sd8gVCNtopjr
  Bf+zNzyqyb8QoGNzBaTJQ09VXPXMc7+e22W3xsVvZv2e98znVipIvqp41Ui08JJFRJKR4VPT/
  8ZlLbvHkvsa68D676kbbCIMZU/t/Hn4aOr7k4U1f+0YhrvS+mnl/64J5ktT59gsqrtVWEXzyH
  PbWq577g155bX+0z361ONTfGs5TrLIL9ySuumrxpOYfrn1qdpBXh869YU3Nj83FU8MV9UTYF1
  knALn/6DZ9pe4UkeF5RYijMSDbWYi4oTAfyDYgl1BAAA
X-Env-Sender: ahuang12@lenovo.com
X-Msg-Ref: server-18.tower-335.messagelabs.com!1600486716!31260!1
X-Originating-IP: [103.30.234.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7200 invoked from network); 19 Sep 2020 03:38:37 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.5)
  by server-18.tower-335.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Sep 2020 03:38:37 -0000
Received: from HKGWPEMAIL02.lenovo.com (unknown [10.128.3.70])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Forcepoint Email with ESMTPS id 9A0265CB35CCC630C22E;
	Sat, 19 Sep 2020 11:38:35 +0800 (CST)
Received: from HKGWPEMAIL01.lenovo.com (10.128.3.69) by
 HKGWPEMAIL02.lenovo.com (10.128.3.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Sat, 19 Sep 2020 11:38:35 +0800
Received: from HKEXEDGE02.lenovo.com (10.128.62.72) by HKGWPEMAIL01.lenovo.com
 (10.128.3.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4 via Frontend
 Transport; Sat, 19 Sep 2020 11:38:35 +0800
Received: from APC01-HK2-obe.outbound.protection.outlook.com (104.47.124.56)
 by mail.lenovo.com (10.128.62.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Sat, 19 Sep
 2020 11:38:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faZNoX6VwoyTSW0xc13pBYpQXYc8MCVtTVHIjwFrhMHQBdPu7ShckYYZ33PwSf5YLArJJP99nNMGhDIUr0jUd5SCTFx+K9N4BuuqOb/UjFy40wZPNUz+VI2rkZMxqMnVcScJeHda59Jkkm+wNFsVFz7a5vAJvG4lXzetyA2VK5L+zVs6D4eQXYv6+JNdhlqnqeA9swKeby1EcvZwa+y3ZCD8B37OegLN2+x8cssCYG+OBkiUwGPyVYEnCE7QrC0dP+KzRaMslZgZCRaUmSy3P1J7OHp5i6xt26e82WEOXBxLx9VdDi2BjDWmL/2qzXchaV+S5AYgJBIXQcwqFdLTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53svdA6xhZcZ3lHsZnTjpABAw/2AjUFnVhN80/epqO8=;
 b=k4gkQAUT4W9kc1KvV+PCZh87iE7xqEfI19tINT8ewyhF6QvEqhKLi/yRsw/mZkPTbd+wwZkL6XQ1RXXRqnp2KUNApqNo6FOym+0xVCPzgpXyo8cZLKGXukDlBJi10AFDUssRtQeSbrj8jKcl9msF0X29PAS+8vJgmaFy1ECRcCyb68hNpgXdMSOONn5vI4l33SSW+lOgF2cP7e0qhX/A7ddt7F2k/9DNJl4tusFAu6p8e19WEWGsBO3Fp1gi5TN8+eKTJ5ho2H+8IlZHpejN6PsLG240ib5aBxtROak6dMDJIHSQ3FYn8wQHoHTs3X+QiSZHqLvlTkFJsoyLx//7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53svdA6xhZcZ3lHsZnTjpABAw/2AjUFnVhN80/epqO8=;
 b=cdVyN6FKDdbBwWg0IgmRHKS535Htu0xQXBtHPJYqAxN7ZaTM8Wzg3HjZaxZxDWR6xw9StE8yridoCV19MzFMy6gTAQQeWEnD7OpXKIk5OCbUXu+KQJUu7It5YtDxSk9Zxtl0beqhD6kXy4NekuQwC8ii8jh/b8UlN4KhIDW4rSc=
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com (2603:1096:202:c::8)
 by HK2PR03MB4449.apcprd03.prod.outlook.com (2603:1096:202:1f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5; Sat, 19 Sep
 2020 03:38:21 +0000
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164]) by HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164%7]) with mapi id 15.20.3391.009; Sat, 19 Sep 2020
 03:38:21 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: Dan Williams <dan.j.williams@intel.com>, "dm-devel@redhat.com"
	<dm-devel@redhat.com>
Subject: RE: [External]  [PATCH] dm/dax: Fix table reference counts
Thread-Topic: [External]  [PATCH] dm/dax: Fix table reference counts
Thread-Index: AQHWjfe11ZIxZN3pikmRBt5326cygqlvT5EA
Date: Sat, 19 Sep 2020 03:38:20 +0000
Message-ID: <HK2PR0302MB25949288D7E87B5C9CDD60A9B33C0@HK2PR0302MB2594.apcprd03.prod.outlook.com>
References: <160045867590.25663.7548541079217827340.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160045867590.25663.7548541079217827340.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [1.174.62.240]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91b8524d-5de6-4af7-dcbc-08d85c4d7495
x-ms-traffictypediagnostic: HK2PR03MB4449:
x-microsoft-antispam-prvs: <HK2PR03MB44497664BD87A395E14A4EB4B33C0@HK2PR03MB4449.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JCrWxhTizKKDAOk7ivv9s+zgB51QtgqegDxa6FeczzGfiijcf7oRX4fzAeQIQR8GLKXdUzuP59p96EjbXivL2o8uSAqXbFZ5RX1TBpC5qtYHGSDjs7gYP4sjFVD89mo4AtVUkBHUsIFTAeLF5WZn0qPsbbBM38hYe30iMZ6LgnxuAjkrbCtsQjjh273nk9y8bM+Q1YCLT0Od/YEPSVOzwSVwnhyDBdszhggJbh74zFsUfTeuip+HZZCQ+CdBbLHiMExfCWu4RokqkPEwu/zJ1HC7OnqsA4EkSkL/DPr6TwnWcqZog8eCRBL94UGbtOhgLJTLwC333Xn3eLU13J9ys4Gv37oc/omQwHsoqDldqgMNBcWXswMVxqpHGDY9u8aO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR0302MB2594.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(6506007)(110136005)(316002)(26005)(186003)(8936002)(4326008)(66476007)(83380400001)(2906002)(66556008)(7696005)(8676002)(478600001)(64756008)(66446008)(9686003)(66946007)(54906003)(53546011)(71200400001)(86362001)(52536014)(5660300002)(33656002)(76116006)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Tgzkw+00OkDqehMuVqoAR2p/kYsz0kAAWocWJOZOzshVOpiRJlT6MoGdOogpeZDUDaozbQSmg7XWC7Xdf3TizhsP+gkiKtPWcyvl1A0jhHMBWE+n5UwWdKNbJwHKLZIa9SI7Wszpros84bS9YIS+dhms8GcHoz5Or3YWPDRANDaQ8yWStcgC94m43QAUeYxwLU9z7zqnMrUZPPqG0n3WTXvWXiqI6Jdzz5dcYZelPwHVqjyog2PiJvwuDQ2sEgGmsA2SykLic+aSEFucFR+UQdF3dTmvhKmHd5Y4llklaKXWggPeZCBzvEm838RswtmsvMqmeWDNngYK1om4U0882HXexYibHPFk2Co8y0BQMUUFtVOc2Tf3kEPA3EBDLZ2g4FTgt4ExeCIdXZoQ2S7EejosXmMcbA0AcMgHA7uNFTsSFWUC8pFEdUFwByXy2zWEb1UQr8w0vP7/Awg2oFUQpiKdD+RcpDeAk9Rg1KhrDZFHn+pQVk8eXGSIDHkL+A5T004d7Hze86Q4eZwIWjDQzSdECqKxC1NicZ+JV1gDaCBgtfcIv0krG06vStg8KzBNHoZB3p4b1111ljUxH6whufNL/tfih3yykk07LShK+XMV/dx8E2GiSE4vnMd9210tkXTtDQ26SdnQGFJtvQbbAw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR0302MB2594.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b8524d-5de6-4af7-dcbc-08d85c4d7495
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2020 03:38:21.0111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7nHoXS4G7bZb1BvioEKy2KuSvK89UpjEbjHdjy1oxJpJ6pjspAyHFtMfEEnbjaJRyfBqy9p/UO9XfrbDzZZTKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB4449
X-OriginatorOrg: lenovo.com
Message-ID-Hash: 5LWKOFFPDGR7GH457D672GLXA3F5Z7QU
X-Message-ID-Hash: 5LWKOFFPDGR7GH457D672GLXA3F5Z7QU
X-MailFrom: ahuang12@lenovo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5LWKOFFPDGR7GH457D672GLXA3F5Z7QU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Saturday, September 19, 2020 3:51 AM
> To: dm-devel@redhat.com
> Cc: stable@vger.kernel.org; Jan Kara <jack@suse.cz>; Alasdair Kergon
> <agk@redhat.com>; Mike Snitzer <snitzer@redhat.com>; Adrian Huang12
> <ahuang12@lenovo.com>; linux-nvdimm@lists.01.org; linux-
> kernel@vger.kernel.org
> Subject: [External] [PATCH] dm/dax: Fix table reference counts
> 
> A recent fix to the dm_dax_supported() flow uncovered a latent bug. When
> dm_get_live_table() fails it is still required to drop the srcu_read_lock(). Without
> this change the lvm2 test-suite triggers this
> warning:
> 
>     # lvm2-testsuite --only pvmove-abort-all.sh
> 
>     WARNING: lock held when returning to user space!
>     5.9.0-rc5+ #251 Tainted: G           OE
>     ------------------------------------------------
>     lvm/1318 is leaving the kernel with locks still held!
>     1 lock held by lvm/1318:
>      #0: ffff9372abb5a340 (&md->io_barrier){....}-{0:0}, at:
> dm_get_live_table+0x5/0xb0 [dm_mod]
> 
> ...and later on this hang signature:
> 
>     INFO: task lvm:1344 blocked for more than 122 seconds.
>           Tainted: G           OE     5.9.0-rc5+ #251
>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>     task:lvm             state:D stack:    0 pid: 1344 ppid:     1 flags:0x00004000
>     Call Trace:
>      __schedule+0x45f/0xa80
>      ? finish_task_switch+0x249/0x2c0
>      ? wait_for_completion+0x86/0x110
>      schedule+0x5f/0xd0
>      schedule_timeout+0x212/0x2a0
>      ? __schedule+0x467/0xa80
>      ? wait_for_completion+0x86/0x110
>      wait_for_completion+0xb0/0x110
>      __synchronize_srcu+0xd1/0x160
>      ? __bpf_trace_rcu_utilization+0x10/0x10
>      __dm_suspend+0x6d/0x210 [dm_mod]
>      dm_suspend+0xf6/0x140 [dm_mod]
> 
> Fixes: 7bf7eac8d648 ("dax: Arrange for dax_supported check to span multiple
> devices")
> Cc: <stable@vger.kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Reported-by: Adrian Huang <ahuang12@lenovo.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Cool, thanks for the fix. This solves the issue.

Tested-by: Adrian Huang <ahuang12@lenovo.com>

> ---
>  drivers/md/dm.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c index
> fb0255d25e4b..4a40df8af7d3 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1136,15 +1136,16 @@ static bool dm_dax_supported(struct dax_device
> *dax_dev, struct block_device *bd  {
>  	struct mapped_device *md = dax_get_private(dax_dev);
>  	struct dm_table *map;
> +	bool ret = false;
>  	int srcu_idx;
> -	bool ret;
> 
>  	map = dm_get_live_table(md, &srcu_idx);
>  	if (!map)
> -		return false;
> +		goto out;
> 
>  	ret = dm_table_supports_dax(map, device_supports_dax, &blocksize);
> 
> +out:
>  	dm_put_live_table(md, srcu_idx);
> 
>  	return ret;

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
