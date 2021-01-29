Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A9F30871D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 29 Jan 2021 09:44:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4582E100EAB02;
	Fri, 29 Jan 2021 00:44:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 683C4100EB840
	for <linux-nvdimm@lists.01.org>; Fri, 29 Jan 2021 00:44:15 -0800 (PST)
IronPort-SDR: hzlKzRITgu+HeLfPVeYeGr+VJS1PrPibre4Bd8qQ/zblwk6Nljbx8R+47lHfSUViEtbOkW8Edn
 69WYXGP3Hdew==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="244476335"
X-IronPort-AV: E=Sophos;i="5.79,385,1602572400";
   d="scan'208";a="244476335"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 00:44:14 -0800
IronPort-SDR: p0dWcnP8ZLHTeyTJLt0WMGyOIehs+tbaExVi+PBzhruZXACm9nqeS76dViNlj5JHXudf+bcLF9
 5kewKcrxRQFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,385,1602572400";
   d="scan'208";a="354509237"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga003.jf.intel.com with ESMTP; 29 Jan 2021 00:44:13 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 29 Jan 2021 00:44:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 29 Jan 2021 00:44:13 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 29 Jan 2021 00:44:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsQ0EG/Al0shqx7x+9zHM6VKLWstwAZruf2OP+9n8Gkq6QYQdUcx7Ms6ruBql18pCU4RPoF0q/DkKjI4bAKM3A1oLRa2JXxPCEqq98B0Cafrsj95QLnm3+5PP7FiwJKta3vZ0/Jg+G6kuR2a7IiI2i3S48KwgzPN4ds3cT9KRw7gB7My+rXT6A34H42KzQsAwqe98PZS/aV4belsDciMkmpX+LKNweBMTfbFeLIOm5oQvZzhrYwvGdkzL2N9qRq0dD600waI4OpiuaAe+vBi+3rGTY8MIsCmdZUM11mu+15HjGi3aUFSZjOv/0Ga0FjnVpFxfSwPeIMq6gkG+oIxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJItjsBKf7pEj58F6jTR/HD4yL5EAxIbxTUTyyNWEpA=;
 b=nKWAZB70uStiQvNnWPkeplwhhO8bIRv2XooNVARpU7uUGM2hzemSbLO+JEvX1ddrN2lfHceMsQ9dJPoaBq2GUP8FuZngsbryfbW8KqtHfiDuYCrNofxOyjgVpBTlD9b7H+CNw/5aq2bW5dXjcLnCi69EqY0Er7wBsK7qdDBWqCeLICrf+u+TY8Rein7/6D36qHMXGytt2/DYFQAgvZKzOAOTEiPUT4LCw0iVaYhP8jJ+EnlypVcf5H3l+1nRewFhtI8nBHc4bC61TsMBBXJvRUrTF4cRruFr2gnWLU5GyWraX/pojWtbxZhPQdVz0NTesRQQUr9BOkxXXIgR/jkX3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJItjsBKf7pEj58F6jTR/HD4yL5EAxIbxTUTyyNWEpA=;
 b=QAQmbA2USQbYVVLCrQCqkL+jBB3osnMttthnSdZsc0nDp8v5Qgeevj2Gm+cNZbG7rU87oO+Nu8DJtcs1F3bSCJ5DU5cNI5GGBGza2f2hTV5QkV7VZo+CmenE/G8IND2EY1ml+Ut+SZm1oUL7mN/i5GVVZiCvo+ez3n7q/ItM3DY=
Received: from MWHPR11MB1375.namprd11.prod.outlook.com (2603:10b6:300:23::11)
 by CO1PR11MB4947.namprd11.prod.outlook.com (2603:10b6:303:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 29 Jan
 2021 08:44:11 +0000
Received: from MWHPR11MB1375.namprd11.prod.outlook.com
 ([fe80::3171:f7d1:c19:fcd3]) by MWHPR11MB1375.namprd11.prod.outlook.com
 ([fe80::3171:f7d1:c19:fcd3%3]) with mapi id 15.20.3784.019; Fri, 29 Jan 2021
 08:44:11 +0000
From: "Li, Redhairer" <redhairer.li@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting
 relative to seed devices
Thread-Topic: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting
 relative to seed devices
Thread-Index: AQHW6XrcV5Ed68tNgkCZDi+pg3otQqoo62HggBPmEwCAAHubIIABFXlQ
Date: Fri, 29 Jan 2021 08:44:10 +0000
Message-ID: <MWHPR11MB13757BD64B1194191B029C3F92B99@MWHPR11MB1375.namprd11.prod.outlook.com>
References: <20200426095232.27524-1-redhairer.li@intel.com>
 <CAPcyv4gLKSMa4bN446MnRtjdfGaM-Hjy+dcYm316=4EP43G1wg@mail.gmail.com>
 <BL0PR11MB3281CBD1CC9B64389731ECE492AC0@BL0PR11MB3281.namprd11.prod.outlook.com>
 <CAPcyv4gupvktDG2PdCL6SyO4gwC1WoP8PKmPv1gP6pp8i10esQ@mail.gmail.com>
 <MWHPR11MB13753C37B1394CFFE124A30892A70@MWHPR11MB1375.namprd11.prod.outlook.com>
 <CAPcyv4iG9XMfrhKn+vSmU2RjyeaHtiF2pprGJ6t-56uOtPNSJg@mail.gmail.com>
 <MWHPR11MB1375EA493990A3759C8C731592BA9@MWHPR11MB1375.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1375EA493990A3759C8C731592BA9@MWHPR11MB1375.namprd11.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [36.230.140.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3a382c0-d597-4a20-05fd-08d8c4320cad
x-ms-traffictypediagnostic: CO1PR11MB4947:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB4947977DADDE8EE49F586B6292B99@CO1PR11MB4947.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IC3hR19TtZh4t+My9bz0d4YvJn/4Tzr3gFI7/BrntUWzY7Bw1xHirTruRCcENVMhnhPeas7D8/hAQE2Wi3yqcm21NQ4/AN+ssWkK8V8chFmQz8tZuvRww/obZxGJz77mfW/hD66bZt5m0IK9ZHYM6/v3vJs0HIETJM1C1twYcqDzsqs7WPTXmOeb3y1k+tNDFuyutMjnvb9LN0wliydaLxzF2UR/oULR7jD3iPLxuOnESDXL65nXMgGdaW8bFucSBNmD2eZE/qMkyzuQXPcdokSPz/cN82GG7Fth0bWgJ3W+8qxEhReHVf7yj2eaj4vvECojhzCPxkXUKf2SqQql9s1jLGsjwGKEQFAHN4rfZKB8UsgH7S3bUFlwPaTF9Jns5M5mHAt9JTQpozWJqob7LM4KfwCXme4EuFBfhZDfBNiFQW/OKfI+zS9IaS0xQn+Zp4YCzGfzip3wPnWOUp6q/lMdjbHifzWEBMUwf3zzIwhi3kqiLuDOEQcZ9MUy+bmT/iu+Dt9B7Gz3Xz1gR0uJWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(83380400001)(6636002)(316002)(4326008)(66946007)(66446008)(76116006)(26005)(186003)(2906002)(71200400001)(64756008)(66556008)(66476007)(15650500001)(478600001)(7696005)(86362001)(9686003)(33656002)(53546011)(6506007)(8936002)(6862004)(55016002)(5660300002)(52536014)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aVNwaTRmdFZ6dldIalhVWWNmd21nNng4R3Z2MS9SRnJiNHRmdmVTR1Iwc0ZF?=
 =?utf-8?B?YjZCVGhMNnRJL21yN0ZDS3VzRnZ4VGR5SDlOZnRFc3cxWXNndzIwKy9CZzMy?=
 =?utf-8?B?eXQ5bzF6Y1JPeW9nOTZSa011eXdCWU5CVHRRNW9NOHFmd0pNMWkxRWxtQTE0?=
 =?utf-8?B?WXZ5NDZQL1VncG03Nlg4UDJNTmlFR3NqL1pXZkdhS0oyVDRCWWtERmFMdkNT?=
 =?utf-8?B?eG9LQTlPaE5OdGRkT2tUTmpVNDl3aTJ3ZTEzWWhzbzNNR3ByTHRvVW1sUVdl?=
 =?utf-8?B?ZnlodWQ4VnVCYUpCdHBaM29DdTUyYldtL3k1c1BGM3ZyVTdESC9BcmtadWlQ?=
 =?utf-8?B?anBOQ3J1K1Uvdnd6SVB5bUpqU1ppYVd0ZVd4enJuWjM0WFJET1lIdHNyYW1F?=
 =?utf-8?B?SnRpazY1TnNQWlhUY0NJZkNNK1NZN2VORU1nd2ZaY3RpVFdTbjIxYldmcloz?=
 =?utf-8?B?bWk0UlBlRmp5aUo2Zy9uZ0VOWWM2S3RLNUlJVGU2MlhySWdIYnVDaTdWWmNh?=
 =?utf-8?B?a2dEU3F1RkptNmVuVGo4TmVuMVYxNDJQdVBGYmM3Uk9KeWx2YUR2YXVqV0wz?=
 =?utf-8?B?YkZyT0U0Vy82MkZTR1hVdnBBOURzaVBlNDhVb3lxRjhhUWtEeTZqazBhUVlU?=
 =?utf-8?B?d1NoTmVMeGtHK1dqVFpMck0rV254RS9NQXl3R016YkFId00rSWxQb0Z2dFlh?=
 =?utf-8?B?RnA5b0JIVFBDck8wSG9HejQyeE56RGRCM3RkWWhWNTA1ZVVWRzkvYUNpZDM4?=
 =?utf-8?B?ejVNYUY1V0E3N0g2UGZMUE43RURIeVV5N2ZOMXFCUGlxdS9sZVcvYTV6UmEx?=
 =?utf-8?B?L0g1QVl2UUdEL2lyUGlzZmRZdVkva1M3UTZwdHFiUFVSVUNKRUZiU0xMS1NV?=
 =?utf-8?B?TUdtUWVTbEdTN2dnTFZKWHRWN1ZYQTBrWjBvemg5enNBbGcyVjgrZ3hUMGE4?=
 =?utf-8?B?MmVXL3R5djAzY2NFSjNFYjI0Z2dtRnc4NWhyWVlteitkTnRBdEJTQzBETFor?=
 =?utf-8?B?QVhOb0w4WHExNUFYZmZMbzJSMEJWZVRhQ3BwSFkxVWRDZmlGM25hYUpHVFpu?=
 =?utf-8?B?WnEvaXV4UWFHc2F0ZDcvUHVzODR1S3pzbTgwZVltVDIzWWt1alRCZ2NLMXFx?=
 =?utf-8?B?QWxnZE55VHVMbHZsV0twNEJVUngrbFFCSmc5WmZ3dzhJakhvb2VZbjlnay93?=
 =?utf-8?B?ZW54U2t2bVVjNVhxQW85RVNsQzRjVFc2TlBPNE9GdjBJRkhvaDdoYW55TUlO?=
 =?utf-8?B?a2Y2UHl6cmJveEZHN2Y1WWl4SDdEV1FjRkNjYVNXWDdrWEtFVTRFeGlwRlZB?=
 =?utf-8?B?M3UrS1JjdFJrN2hwOVFCRS9HMFlFeUFNZElhYysvbzM5bUNjYzVYeEU5UFBx?=
 =?utf-8?B?STV6TUU3Z3lFL2RnRFNLVUExTDVjN3dmNjRscnNzVy8ycTlidzNqQm1XYlgv?=
 =?utf-8?Q?98Yv1Y4L?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a382c0-d597-4a20-05fd-08d8c4320cad
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 08:44:11.1000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ulC0TICOTQmW8KB4P2u05GgbW3lWzXT9U29WuND0BzlTPc5jKSL6BbZpBigyXkYvPkYxO2E1+DyCg8HVQDlGbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4947
X-OriginatorOrg: intel.com
Message-ID-Hash: GDKMVS5XO7AL3E7KHDTHIBZ46RBNXUYT
X-Message-ID-Hash: GDKMVS5XO7AL3E7KHDTHIBZ46RBNXUYT
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GDKMVS5XO7AL3E7KHDTHIBZ46RBNXUYT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

After update kernel to 5.10-rc4, all tests will PASS with "make check"

-----Original Message-----
From: Li, Redhairer 
Sent: Friday, January 29, 2021 12:16 AM
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: RE: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting relative to seed devices

Resend it base on v71.1.


-----Original Message-----
From: Dan Williams <dan.j.williams@intel.com> 
Sent: Thursday, January 28, 2021 4:47 PM
To: Li, Redhairer <redhairer.li@intel.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting relative to seed devices

On Fri, Jan 15, 2021 at 9:22 AM Li, Redhairer <redhairer.li@intel.com> wrote:
>
> Hi Dan,
>
> Your comment is make sense.
> ndctl_namespace_disable_safe will return 1 if namespace size is 0.
> I send a new patch out for review.

It looks ok but it does not apply to the current tip of tree now v71.1 can you resend?

>
> But I am not sure what do you mean for 2nd patch.
> In cmd_disable_namespace, it already print error if rc<0.
>         rc = do_xaction_namespace(namespace, ACTION_DISABLE, ctx, &disabled);
>         if (rc < 0 && !err_count)
>                 fprintf(stderr, "error disabling namespaces: %s\n",
>                                 strerror(-rc));

Hmm, you're right, once you change to the positive error code the report will just work. Did you give it a try does it fix the accounting problem with just your first patch?

>
> my patch is based on v70 due to latest one will see "FAIL: create.sh" when make check even not include my change.

I know of at least one create.sh failure that was fixed by:

Kernel commit:

2dd2a1740ee1 libnvdimm/namespace: Fix reaping of invalidated block-window-namespace labels

...which is now in v5.11-rc1 and backported to v5.10-rc4. However, that bug only started triggering after ndctl changed to reconfigure namespaces in place with commit:

d4bc247faeda ndctl/namespace: Reconfigure in-place

..which was only merged into ndctl in v71.

Another kernel change that may be causing your failures is:

d1c5246e08eb x86/mm: Fix leak of pmd ptlock

...which was merged for v5.11-rc3 and backported to v5.10.7.

Can you run latest kernel and ndctl and see if you still see the create.sh failure?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
