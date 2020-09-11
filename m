Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC072675C8
	for <lists+linux-nvdimm@lfdr.de>; Sat, 12 Sep 2020 00:20:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1929A1468AFC7;
	Fri, 11 Sep 2020 15:20:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4929D1465BFA0
	for <linux-nvdimm@lists.01.org>; Fri, 11 Sep 2020 15:20:04 -0700 (PDT)
IronPort-SDR: CyQjrcCHoI9deMDlriHEed7UH5Rf8dBUUQCRZnRCNHY08vQJLxE9fCJcspTHcSTZpcCaZYIhkV
 LaA7CQxPqPhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="220417915"
X-IronPort-AV: E=Sophos;i="5.76,417,1592895600";
   d="scan'208";a="220417915"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 15:20:01 -0700
IronPort-SDR: 8cvJHldcyrresWrQS3x287dJWlItvReUYN6fOAjs4k9h+pGUKsaevv9AflHBfLZ/rWFs/MSksZ
 durZcGEVnDeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,417,1592895600";
   d="scan'208";a="334646874"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 11 Sep 2020 15:19:59 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Sep 2020 15:19:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 11 Sep 2020 15:19:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 11 Sep 2020 15:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npXqU+U3Suo3fCYcxhWrdblTo4bGeJNP7rMyiAz19wpjrDr0wVjLhMjY0paEu1+BGRb4Wk1aEHaBH9kYosPMDv0JZcS4NNEDuKiL+Gl8+fQr9K0xIDQmiL68RKzeK+pS69ri5rUmSaOuPl/8AHu+HF24St63Nl8ZZVHh5c4Lufp2q06DToNOh/BwQu1Q/aO4hl0sdT7EOWi6HuVaxo2L/L+JfTzW7vRigywwcLlqFtfl7CDo+fDsnowRNrowGCXRgWXdZ/AlJoBrPZZhic+oF6LkdDy8CCAHBPV9kcalPSCDkkDDQZ1SOc6rHaiRNvA6DCGbmyZ7LIn6bgY6nLvYWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrR07itxW6XbgBunopmkNlBhommBzMR6/y/MAskGCvU=;
 b=YsdmF8qdbo8OInwtrUW+MAeXgGexlqqlYJsfpnfnIY8EPK1fpigG8ZdIGZ9JIIzpoYmfe3LnNMwpaa6NI7oxR5Uoi0luw7jDQn1MQXSM82sjrGZGF8W69sguwNt2U8pc+jfni/Mrgb3Du58+d7LPPxrd2Durq9XcZq6Ew5RA9SfJQx0tUcTjXnRDQjEA4iWaJ8Vs3mEUESpREzH/5hgEjOd0YyH/9wQArSXbnm1r66LIdaa8zS5resXSntPdR8OWTBrSB4sKzULDrQYqFt9fqrrSPSiBY/Jlto1Jxg6MZD80y0Kq11JqecMZZR4tCSgIYhemkyEaWhEv8kcE/uxcSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrR07itxW6XbgBunopmkNlBhommBzMR6/y/MAskGCvU=;
 b=gDPKrq32SnVANjH0/poAXA69oLftCBs9aj3zlsBQSaW6RPoNvCMoRRv6Croy+yzycCfJWNpZ75SwTnvWbzFkifK8zicLxxtndrSQY5myNMgCUevx+Vr7MqLzn9glbGLU6S9e77Z3uqS5jnE4LlrvuP90R8DbYQ3IS1icPAEJ3vE=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2728.namprd11.prod.outlook.com (2603:10b6:a02:ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 22:19:57 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::1084:a79c:5a4f:f115]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::1084:a79c:5a4f:f115%5]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 22:19:57 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: [GIT PULL] libnvdimm fix for v5.9-rc5
Thread-Topic: [GIT PULL] libnvdimm fix for v5.9-rc5
Thread-Index: AQHWiImuY8suMv8okEKNLaH81IaJ5A==
Date: Fri, 11 Sep 2020 22:19:57 +0000
Message-ID: <a0ded0398e87c8c7bcfc2d9f5c9e3af11dda8db0.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [134.134.137.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c3efdff-ca80-43c2-8468-08d856a0d0f7
x-ms-traffictypediagnostic: BYAPR11MB2728:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2728A00666E36A348F2B9043C7240@BYAPR11MB2728.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dqt67xAskA33MzR3899t2OcDlnFU5arcsqI3y3omyQF3GuLU/g6HFI/gwSMRMgBquSW2OdWEIYTBqOZDNaC6ETBZvbAtCG6UB4UEmLawCJzktwHnCdMEbZBm15Dz6eLgAtXFZONk66y2Nz2pikRNhBf0L96dQh4Lm14CGaWN65s/TeJdbwTZBPg2BRVzVPNdCVvuhrBrXgD9yWHBl5UBR7hdWtVUVcBSjf/UxqnAAybyKkrFqC/pGeIHVwAj9hjPSyVKDcLuOp9WHrKniIjS41GorlnkvjsY+O9azJJdz6A7gH+nny0t+bDZo8qHrqT4kLBAqDXvJwt1r4++XcCyOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(66946007)(66556008)(8936002)(316002)(64756008)(66446008)(8676002)(66476007)(2616005)(186003)(54906003)(76116006)(4326008)(91956017)(71200400001)(83380400001)(6486002)(26005)(6506007)(2906002)(478600001)(6916009)(6512007)(5660300002)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BIOwidfUdWPN3CIYfvLPKXrHyiHTy2bpUGP06F1LcduRm7rX5dxeuxtQsdeWPW7qhHtxuhXnd3NQK7uQZLAB5BiEyPRE9WjPnebCXbQNt7VqHtMpONtUxV6nVbQQlCpRNZzDxeNBn+Ewn9Fky56Uk/2JxH1Cyrh3Vp5TOIn94p1/IjQ6njp0P1eWh0iiy436osX9w/YFe3YWl3l9DY8VlDo5YRLRCjL81+MuWBER6gwEYSJVOvW729DdtPEpvAxFvAv1IkEvRFCoQqXcdxuqrH/V4RXc6RGf5e6yzMWOM5iE5CTCPXyJTxN5lkiBcNJBk4DDThCNIHsc+6w5HsOC5hGUCYCI+dBKCbflOyB+y4JIg4R4nudJ7Gz0mr0v2m52uYBVidLCkYcD1SN4bMrJqYMRYqITAV0LvYTgSRsq2QBcDtOjyPe+jkZXIxaQJR/bI+Ms18ChgPwZmXuC4e01NImgKpFZygCY+lt/3E++A6yE1TepwoU+7n9/6aWl79cQfdBdVypb6Hp7oYCcLI2G7XXDZnsj4+jlX9Vac7lf6UzKBX2rGAvObrqOTumkhvFVsuQWMiICKqXsvcHWXWLK4r3exsqWq1WtIiub63gw49AmUVvR/4+EQ4IjYdYPVJ1OleJMdapHUL8Oq5stskTvGQ==
Content-ID: <548E5FFD6DC4394AA1FA7F1A68A68D96@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3efdff-ca80-43c2-8468-08d856a0d0f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 22:19:57.1924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Y7kr/eLpjg5lr8Nrr/Phl3s18WWo1mAW1x24sLUW1jhsA4zzdVJTZhKz4TY/3N7BdI6yCdqQsVCWINamIBBKHWIiodBcha6hbDK9rtH72k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2728
X-OriginatorOrg: intel.com
Message-ID-Hash: H3YKKQXEB3XY7SXFYXJSQQLM7VPZKENB
X-Message-ID-Hash: H3YKKQXEB3XY7SXFYXJSQQLM7VPZKENB
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/H3YKKQXEB3XY7SXFYXJSQQLM7VPZKENB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git
tags/libnvdimm-fix-v5.9-rc5

...to receive another fix for detection of DAX support for block
devices. The previous fix in this area (merged in -rc3) was incomplete,
and this should finally address all the problems.

---

The following changes since commit c2affe920b0e0669650943ac086215cf6519be34:

  dax: do not print error message for non-persistent memory block device (2020-08-20 11:43:18 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-fix-v5.9-rc5

for you to fetch changes up to 6180bb446ab624b9ab8bf201ed251ca87f07b413:

  dax: fix detection of dax support for non-persistent memory block devices (2020-09-03 12:28:03 -0600)

----------------------------------------------------------------
libnvdimm fix for v5.9-rc5

Fix decetion of dax support for block devices. Previous fixes in this
area, which only affected printing of debug messages, had an incorrect
condition for detection of dax. This fix should finally do the right thing.

----------------------------------------------------------------
Coly Li (1):
      dax: fix detection of dax support for non-persistent memory block devices

 drivers/dax/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 32642634c1bb..e5767c83ea23 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -100,7 +100,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 		return false;
 	}
 
-	if (!dax_dev && !bdev_dax_supported(bdev, blocksize)) {
+	if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {
 		pr_debug("%s: error: dax unsupported by block device\n",
 				bdevname(bdev, buf));
 		return false;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
