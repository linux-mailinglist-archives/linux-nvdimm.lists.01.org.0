Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6239E25C54F
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Sep 2020 17:26:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D233139F1654;
	Thu,  3 Sep 2020 08:26:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.219.246.114; helo=mail1.bemta23.messagelabs.com; envelope-from=ahuang12@lenovo.com; receiver=<UNKNOWN> 
Received: from mail1.bemta23.messagelabs.com (mail1.bemta23.messagelabs.com [67.219.246.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ECA16139F1653
	for <linux-nvdimm@lists.01.org>; Thu,  3 Sep 2020 08:26:40 -0700 (PDT)
Received: from [100.112.6.216] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
	by server-3.bemta.az-c.us-east-1.aws.symcld.net id 95/EA-37059-F2B015F5; Thu, 03 Sep 2020 15:26:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUwbZRzH+/Su7Y21eJS3xyb4R6PLVm1DSzW
  XzC0kzuQWJLKoWzKJcEBpG/tm76qgZgIzi1iXMXUxg1UYFLZss7xskDnGxoCV0YoNzMHGmFJo
  LYUNCThxLxTbHpv63+d73+/zfX6/5DkMES/xJZimjNFYTZRByk9AdbP+BLli466CzLpWgviu0
  icgehbqeMTlYAglQieaALH/8G0BYV9tExAH2u8DYqLGzc3GyB9r7wjIpothLmmvi6DkH5du8M
  nWczdQ8qz3kzz+Xp7eVGQuK+Tpeo6FuJamtLJRh5NfAabEX4IETIxXcOHa4l3AijCAs1M162I
  NwJPXvuGz4iGA/pODaEwAvBmB0+PLXFa4Udh/eVHAijYA7Q+XowUbMBTvRmDkAcaed3Bh0NvN
  Y8U0gEPukajAMD4ug8MdVOxACr4b3h0eizch+CyA90YnuDEjGbfA265OPhv6AM6NjPNYVkFH8
  z0ee9vzcGnsVjwvwgth8MqkIMZiPAv+NnA+zhtwNawM2pEYAzwNrnjOxPMIng4nAvVxhjgOnR
  d9CMupMDwT4bGrHQAwGBjhscZW2OH1rocy4Gi9HbCcCyM/fLvOMjjYO8Vn+X0486g6vjDEN8H
  jR/ayn5+Dpw760Rqgqv3PGCy/BBu6l/gsvwhbjs8jtfHVkuDQ0QDaANBT4JUiq16rY4yU3iBX
  ZmbKlUqVXC1XZREK6mN5scJGyzUUzciVCuojWkGXG4sNJQqThukA0cdWYkEXzoPh+UVFH3gW4
  0pTRZOCXQXixCJzSbmOonUFVptBQ/eBzRiG/3JloA5IUJPZpJFCUUtCNJdk1Wg1ZaV6Q/T5Po
  lCTChNEeXFbBFtoYy0XstaHpCF1YQdjQhWtehsRMTxJkm6qCAWxWNRnc30tOjJrzAKMiTJIsD
  hcMRCi8Zq1DP/9+dAOgakySIy1iLUm5in981FR+FGR/kpOzc2CkP9a0kquKeva1X7ttlac8cW
  Ngr8q4U9fQfP7hzKkZmvKqqFVVtLd7z9vcS3Td7I8RFHrqbfDHfmGXN+BklOpXQ+48IKtfaVI
  bTHg/+qlV8rPoxGCGCRnTnq6npZV/s4m6R6u1Ysqbn5yuuS2Wfy96sbdntvhQQ+m80ubn41pV
  6V82iyXfc5QSY6Ay51gLflrzeFXftOExV3vu4erMp7a7WcZNyPJb/3t8uG7h/a6fm70tUxfcl
  17mbnh06pglEz727yvLAyvudTEPzsvf4ZWfAQ8VqRcsRZaDv2hX6Jsve+8eCdZWrH6/4/05xh
  U1s1Z8Bt3q5GtuckOloGydILWyL5E1lSlNZRShlipal/AEJ6wMWFBAAA
X-Env-Sender: ahuang12@lenovo.com
X-Msg-Ref: server-30.tower-406.messagelabs.com!1599146798!484625!1
X-Originating-IP: [104.232.225.10]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15283 invoked from network); 3 Sep 2020 15:26:38 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.10)
  by server-30.tower-406.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Sep 2020 15:26:38 -0000
Received: from HKGWPEMAIL03.lenovo.com (unknown [10.128.3.71])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Forcepoint Email with ESMTPS id F3C7328430E6927C708B;
	Thu,  3 Sep 2020 11:26:36 -0400 (EDT)
Received: from HKGWPEMAIL04.lenovo.com (10.128.3.72) by
 HKGWPEMAIL03.lenovo.com (10.128.3.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1913.5; Thu, 3 Sep 2020 23:28:17 +0800
Received: from HKEXEDGE01.lenovo.com (10.128.62.71) by HKGWPEMAIL04.lenovo.com
 (10.128.3.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5 via Frontend
 Transport; Thu, 3 Sep 2020 23:28:17 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.125.55)
 by mail.lenovo.com (10.128.62.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5; Thu, 3 Sep 2020
 23:28:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kq49h6ESLUQWYDunie78QhPQ7LddjhBZBA684gDdgjOPXXhrhT7YAelUXbDNJUYFed5GOVAq3zfJVRXUxhEDMO9FchqTOlp/Ysrzo450gx13XgBR/G8ObWQyd9aF5G6TCFuWkElG3kb3ugLVnAYGH0m9KW+GzdWpUCrccV8Qo+HVi2cTJbz+7FrDk0IqWn89HX4r/GZmKFZAPpAVN46thdSU8da0nSRBPmQ6fkmA/h6C4RW85ZlqwzjJ+Bz3/RmXWA+zxIMFqyCCg7M2KfkLOtrJ6zN9Zy3xq9ysJvl51BYyNXrmj9oyk/JTxfb+UnyUAxyHThH32tQ0Hc6JlSrQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPW3rYb9KeQPJMIYeYkPMVN/mGL+Xvg/Dy+9RsbXpl0=;
 b=Dfp7BeWaRozVytLyQYaIm57Lif4Id44crtJytW4K+mXug5npFKeUl0Tu0ipAQX6xmBLIQMueB48mijyKizHBg+r5LN4px2OEHFh1WCxRxidB59ISkNZslIrOTHn5fobciHp2ZOSgJYG44Qd7VeiAj/nbriD0RamU27spxIq3SnQfRIAN//JK4M8i/LMPLqrorQLrtGtM8b59oSNhu36vgxQHMVRMaEL+SCN34Ey2x8Aee0C/BwHEGGPyoiW5UKSpQ3l5+Abn+Af5Z1FzhfRR0kACU574P9tWtAj2JFSLIwzY72cePGxR/AtXb70j+iR9gysrzK6hbNFFo/7VQP9Meg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPW3rYb9KeQPJMIYeYkPMVN/mGL+Xvg/Dy+9RsbXpl0=;
 b=gshr4Kg+oac0CE7iMPoezL7WFvP14MVD56w2u1rvfzIUVg/nQI8EJKaR46/0GT4c9X9SwpsBU1KfsGDwYldGMtA7Pxtat1ZOLYf7oSosYVklK2hoAOBPA74J/6o9J+8NS5vfABoO3Ol/N52RAqz8r5jzp2tv8J6h2MAT5LRVZEM=
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com (2603:1096:202:c::8)
 by HK2PR03MB4337.apcprd03.prod.outlook.com (2603:1096:202:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5; Thu, 3 Sep
 2020 15:26:29 +0000
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164]) by HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164%7]) with mapi id 15.20.3370.009; Thu, 3 Sep 2020
 15:26:28 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: Coly Li <colyli@suse.de>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>
Subject: RE: [External]  [PATCH] dax: fix for do not print error message for
 non-persistent memory block device
Thread-Topic: [External]  [PATCH] dax: fix for do not print error message for
 non-persistent memory block device
Thread-Index: AQHWgelAghvCHxCDAEee5fG8xErBNKlW+1Lg
Date: Thu, 3 Sep 2020 15:26:28 +0000
Message-ID: <HK2PR0302MB25945FB53762074E66FAC9FCB32C0@HK2PR0302MB2594.apcprd03.prod.outlook.com>
References: <20200903115549.17845-1-colyli@suse.de>
In-Reply-To: <20200903115549.17845-1-colyli@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:b011:e002:37e1:4c72:58e5:53e9:1b12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cca28907-cf54-4673-64ad-08d8501dbab9
x-ms-traffictypediagnostic: HK2PR03MB4337:
x-microsoft-antispam-prvs: <HK2PR03MB4337EB0D83CF606FB7A016BEB32C0@HK2PR03MB4337.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0gcjYDc3rJnTN+xyNegLBmc5FRpak4JvvfesGcV8O0pstwj57f/98cZh1NK6CdbMJBl09hZTgq4S4c2lfXLA5qivHhj+dyf/MfK4sdaTRcGXzIl/93stVglbbytfZQ2kWtzcaJem/V76utnxxPHJ6gTMYYfdx+gWa+RCTLozQ/lh8uTWKVcl1L/GgGO4+mxX6nQnvx4mnm5YoOknmkZ+2LfIX0ozpZYaZTH/yPH73YioWg3ijPEae7lSaC+18VKeMzBjJjqGo/Dimxl8dlZj3m0K/g2Cny8JF36Yxhc9fi+7pSQm9ig4lbrvg1XmXsENQslK1JQkY8yLrWA44jC9IQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR0302MB2594.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(64756008)(76116006)(66476007)(8676002)(6506007)(66446008)(9686003)(316002)(186003)(15650500001)(478600001)(2906002)(7696005)(55016002)(54906003)(8936002)(66556008)(66946007)(110136005)(86362001)(53546011)(33656002)(83380400001)(71200400001)(52536014)(5660300002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: z8Q8DnKsUkE4HymlfsMnbgGw6OX3vIfUVrAV/qIL2ppfOkEk5FHQKXxa8lsb3ifGqlh3HJZ2A2nAFe3iPg8V6v0A6uUrYxAIAg7ctiCLja9o8Fr9YftRtttd91PkxSgEynCZlAL7to0mDjXxZ7rojvjZuPjw7MBoZuQPR3s013EiULeR18QGBr8/gbSkOhMvjndo+ip9X13lO2qFvqUg66LolQ1T89+96rYbDTnqrY8nG5IesEgxTLunicrjDK7STITEteCLGniixh+TAuJXfTOTMGQ3AU8oDAKCwXZk75t2r8KHDGWfTk3Mic2BpoJx5EW7az/plS9W7v9GptcjA3vV7kSBciEATzkCpFJlUuFcwYI04SmbcfZBabLsJ1aMRhP46B0j8PLiPtfBhWScubjEidFw/srR7RToTPzEOemBGNfjXwXvXmNje/FSLDAtsa64kg/rngsv/PWyOfAxm6a15YYvPlfms5RgooF0ye6h8WJeuv1ySTeZUN6RMi2K/X+0qF2g1QidjkxiWoJzSC0pnQnNb+X5ICYXYUzkcnX1cpnNqELdyoOe1lVVVFXT+LzrRRCSF65eBqpUGzyI/atw9AA0MjSTqFIpHsNiRirTrxKq8qfJcGxapqwVx8/u8N/0msn22E8XfBKq9rjdyif7qizoKOq0mH5UUHXohhn84XjpAAg0vvyFrHiDOYiy6dFMcWBx10vLQ/kBuLtRcw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR0302MB2594.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca28907-cf54-4673-64ad-08d8501dbab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 15:26:28.9201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6yx7vDhbd///V6G+biIUp9Vori/mJOXHkLWnyrala+wClHflcPbPbMX9P7Hatsm2ij90r7BSRQrCoo9aLcUrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB4337
X-OriginatorOrg: lenovo.com
Message-ID-Hash: KBDXJEEB4NU22BPASU2X5EBJK7XCGSJG
X-Message-ID-Hash: KBDXJEEB4NU22BPASU2X5EBJK7XCGSJG
X-MailFrom: ahuang12@lenovo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "dm-devel@redhat.com" <dm-devel@redhat.com>,
	Jan Kara <jack@suse.com>, Mike Snitzer <snitzer@redhat.com>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Vishal@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KBDXJEEB4NU22BPASU2X5EBJK7XCGSJG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Coly Li <colyli@suse.de>
> Sent: Thursday, September 3, 2020 7:56 PM
> To: linux-nvdimm@lists.01.org
> Cc: dm-devel@redhat.com; Coly Li <colyli@suse.de>; Adrian Huang12
> <ahuang12@lenovo.com>; Ira Weiny <ira.weiny@intel.com>; Jan Kara
> <jack@suse.com>; Mike Snitzer <snitzer@redhat.com>; Pankaj Gupta
> <pankaj.gupta.linux@gmail.com>; Vishal Verma <vishal.l.verma@intel.com>
> Subject: [External] [PATCH] dax: fix for do not print error message for non-
> persistent memory block device
> 
> When calling __generic_fsdax_supported(), a dax-unsupported device may not
> have dax_dev as NULL, e.g. the dax related code block is not enabled by Kconfig.
> 
> Therefore in __generic_fsdax_supported(), to check whether a device supports
> DAX or not, the following order should be performed,
> - If dax_dev pointer is NULL, it means the device driver explicitly
>   announce it doesn't support DAX. Then it is OK to directly return
>   false from __generic_fsdax_supported().
> - If dax_dev pointer is NOT NULL, it might be because the driver doesn't
>   support DAX and not explicitly initialize related data structure. Then
>   bdev_dax_supported() should be called for further check.
> 
> IMHO if device driver desn't explicitly set its dax_dev pointer to NULL, this is not
> a bug. Calling bdev_dax_supported() makes sure they can be recognized as dax-
> unsupported eventually.
> 
> This patch does the following change for the above purpose,
>     -       if (!dax_dev && !bdev_dax_supported(bdev, blocksize)) {
>     +       if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {
> 
> 
> Fixes: c2affe920b0e ("dax: do not print error message for non-persistent
> memory block device")
> Signed-off-by: Coly Li <colyli@suse.de>

The dax error messages ("dm-X: error: dax access failed (-95)") are gone away when executing the command 'lvm2-testsuite --only activate-minor'.

Reviewed-and-Tested-by: Adrian Huang <ahuang12@lenovo.com>

> Cc: Adrian Huang <ahuang12@lenovo.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jan Kara <jack@suse.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/dax/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c index
> 32642634c1bb..e5767c83ea23 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -100,7 +100,7 @@ bool __generic_fsdax_supported(struct dax_device
> *dax_dev,
>  		return false;
>  	}
> 
> -	if (!dax_dev && !bdev_dax_supported(bdev, blocksize)) {
> +	if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {
>  		pr_debug("%s: error: dax unsupported by block device\n",
>  				bdevname(bdev, buf));
>  		return false;
> --
> 2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
