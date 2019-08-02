Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5D87EA74
	for <lists+linux-nvdimm@lfdr.de>; Fri,  2 Aug 2019 04:48:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9C06C2130A4F4;
	Thu,  1 Aug 2019 19:50:34 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=216.71.158.65; helo=esa20.fujitsucc.c3s2.iphmx.com;
 envelope-from=qi.fuli@fujitsu.com; receiver=linux-nvdimm@lists.01.org 
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5697B21309DD6
 for <linux-nvdimm@lists.01.org>; Thu,  1 Aug 2019 19:50:32 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6000,8403,9335"; a="5333286"
X-IronPort-AV: E=Sophos;i="5.64,336,1559487600"; 
   d="scan'208";a="5333286"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/AES256-SHA256;
 02 Aug 2019 11:47:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpIzolJVOOAMIbx1sx/Jm2xNEBSwUXq0rIT+GeKYfej0XkLh09VAS3LWg55yNKqTC1NLTDWFcv/j3ECM0KGzWSzn+ihvjhoteucsj9AVW12xmBUWu/Q/jcm97v+GmAuilPFFySrlSLR2uLC/O3uiCfRqe7lwa9yU39Y2LPZhD+/Y5AZxqopbQXUUt05DduQMR5FRG9/DY5bEC2bxQHoq+77/gWDF/x+YNRsmwsNF9F148SNT/mnfmodImq8M3hRi0yxD1Ltzjg8h7TRJ8W7lCxvV88o1L8Udqc5OY47txDBg3d1wQ3fhcHfPKKGURauLfAd1bm63Na1VSFhplMwibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJit2GPWa2Hi0uneDaxcS9qwLNt9MfRukC4EPpNLUng=;
 b=A4TYMifZB7qIcPI4nAGHq+Z2ur7/hu0n2zTEzIPAwWJDwG4KUHrvvnKxDQfjblSnYpzJU9FOZmcgejk5xos9r58trdevFik9IdABgEGpTnOMjKgTrk/iRqVW+AS1jNURKi3cyngiDxOdtNKJghRXbbSFX4e7pW//t9xFTXuK0vLsvR5lwUlTHeToSr+lghbqiI3Da1NEiQHgU5sbjLdHuykzBcT/n3SLo84F/uCI4BP0NWI2nT9scmA44t/Zc9+Qr4SphN+qJX0rTX1PFI41Yy6UL1qmIvZ/XSzOqT9wNMdLE1r4xYnv+2fqO3lwDMzfPaD0BwDY4Uom4zQi/tMmkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fujitsu.com;dmarc=pass action=none
 header.from=fujitsu.com;dkim=pass header.d=fujitsu.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJit2GPWa2Hi0uneDaxcS9qwLNt9MfRukC4EPpNLUng=;
 b=RGA5anXBUfOR5jCOHUBDPAORfSVGmSltimm3zxmiOt0zhw7nUW/OGdhfiF7063t00MIiySB/mOc8HMR6h3e+ti++r0vc3DIdlBEKN288bzDqqh4Mmwr+ZxIcnStLpQb0QaktrfyJIEh8vVBx6hACkZYTSJMTxNw9fx95ZqytjP8=
Received: from OSAPR01MB4993.jpnprd01.prod.outlook.com (20.179.178.151) by
 OSAPR01MB2353.jpnprd01.prod.outlook.com (52.134.249.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Fri, 2 Aug 2019 02:47:56 +0000
Received: from OSAPR01MB4993.jpnprd01.prod.outlook.com
 ([fe80::9058:1a94:c47f:1fc9]) by OSAPR01MB4993.jpnprd01.prod.outlook.com
 ([fe80::9058:1a94:c47f:1fc9%6]) with mapi id 15.20.2115.005; Fri, 2 Aug 2019
 02:47:56 +0000
From: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
To: 'Vishal Verma' <vishal.l.verma@intel.com>, "linux-nvdimm@lists.01.org"
 <linux-nvdimm@lists.01.org>
Subject: RE: [ndctl PATCH] ndctl/monitor: make the daemon exit message 'info'
 level
Thread-Topic: [ndctl PATCH] ndctl/monitor: make the daemon exit message 'info'
 level
Thread-Index: AQHVSK7p66molICb1kuFxGR4BLH676bnJu8A
Date: Fri, 2 Aug 2019 02:47:56 +0000
Message-ID: <OSAPR01MB499340139C16FA180345D213F7D90@OSAPR01MB4993.jpnprd01.prod.outlook.com>
References: <20190801211908.11684-1-vishal.l.verma@intel.com>
In-Reply-To: <20190801211908.11684-1-vishal.l.verma@intel.com>
Accept-Language: en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
x-shieldmailcheckermailid: c87174afba74406fbe8472406878a93c
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qi.fuli@fujitsu.com; 
x-originating-ip: [180.43.156.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af9e78cf-6814-48c3-c25d-08d716f3d2ab
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:OSAPR01MB2353; 
x-ms-traffictypediagnostic: OSAPR01MB2353:
x-microsoft-antispam-prvs: <OSAPR01MB235381E144F229BB43C80103F7D90@OSAPR01MB2353.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(189003)(199004)(13464003)(85182001)(7696005)(476003)(446003)(66446008)(14444005)(256004)(66556008)(66476007)(11346002)(2501003)(2906002)(102836004)(110136005)(9686003)(7736002)(71190400001)(6116002)(64756008)(76176011)(305945005)(86362001)(3846002)(186003)(15650500001)(54906003)(53546011)(74316002)(6506007)(316002)(26005)(99286004)(71200400001)(81156014)(76116006)(478600001)(81166006)(14454004)(55016002)(25786009)(53936002)(52536014)(33656002)(8676002)(6246003)(66066001)(68736007)(66946007)(5660300002)(8936002)(229853002)(6436002)(4326008)(486006)(777600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:OSAPR01MB2353;
 H:OSAPR01MB4993.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 248cBDNfjczanwlxIdORPCWqu6YG4iu34dRv7PK65UpWa+9BfSfNtFtxEg+gmk0jp1J4QKlq75CMxkOcn5g5rMkpMe3rawJ7RgvF0NV9jqVPVqyR05H6lwKbBajXjLCfQGasHH8MF0jrjfrySNQB4nZWho+RN+8tidymWJlqfesChhw0dzZw1qBAwfGXg5ANzwPQpJS1TYXkRVy/LtuxRZl78h0umpP/eS5HwLAyOs2iKFiZ6bBhx5bEiqk+7w4B+QWv+tesY7du2sdwdBIOBvTEDYeffcyZ0G1oDFTUPJimos5J2YaNCdvFu7i+9X1mIu3e74+KaB6OJ93oxUY8g6cvxWK0FIhOZZZQ5b7zvjNiVJvmkhZieWwyT4rudLlX1nXFkxjCUd9BuURNQqmfvzPu5uWTrQJoyz0VSxWiAik=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9e78cf-6814-48c3-c25d-08d716f3d2ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 02:47:56.2301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qi.fuli@jp.fujitsu.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2353
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

> -----Original Message-----
> From: Vishal Verma [mailto:vishal.l.verma@intel.com]
> Sent: Friday, August 2, 2019 6:19 AM
> To: linux-nvdimm@lists.01.org
> Cc: Vishal Verma <vishal.l.verma@intel.com>; Qi, Fuli/斉 福利
> <qi.fuli@fujitsu.com>; Dan Williams <dan.j.williams@intel.com>; Adam
> Borowski <kilobyte@angband.pl>
> Subject: [ndctl PATCH] ndctl/monitor: make the daemon exit message 'info'
> level
> 
> The 'ndctl monitor daemon started' message is at an 'info' log level,
> but the corresponding exit message (if no DIMMs are found for
> monitoring) was only at a 'debug' level. As a result, on a system
> without NVDIMMs, the sysadmin might see a 'monitor started' message, but
> a monitor wouldn't actually be running. Making the exit message the same
> log level ensures that no confusion arises out of this.
> 
> Cc: QI Fuli <qi.fuli@jp.fujitsu.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Adam Borowski <kilobyte@angband.pl>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  ndctl/monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ndctl/monitor.c b/ndctl/monitor.c
> index 6829a6b..6e7f038 100644
> --- a/ndctl/monitor.c
> +++ b/ndctl/monitor.c
> @@ -646,7 +646,7 @@ int cmd_monitor(int argc, const char **argv, struct
> ndctl_ctx *ctx)
>  		goto out;
> 
>  	if (!mfa.num_dimm) {
> -		dbg(&monitor, "no dimms to monitor\n");
> +		info(&monitor, "no dimms to monitor, exiting\n");
>  		if (!monitor.daemon)
>  			rc = -ENXIO;
>  		goto out;
> --
> 2.20.1

Hi Vishal,

This looks good to me.

Thank you very much.
QI Fuli

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
