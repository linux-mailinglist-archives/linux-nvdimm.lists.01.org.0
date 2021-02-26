Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2B13260FB
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Feb 2021 11:11:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8B38A100EAB43;
	Fri, 26 Feb 2021 02:11:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.71.158.65; helo=esa20.fujitsucc.c3s2.iphmx.com; envelope-from=qi.fuli@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DB38E100EC1E3
	for <linux-nvdimm@lists.01.org>; Fri, 26 Feb 2021 02:11:23 -0800 (PST)
IronPort-SDR: /UC6GYFYvFfK+3n/lGhzHnWFopDQSzDXCuGXjLGr3GLfwssD1nwFb3HKmsfLArYWHgeGEqY/fz
 BgwuqMxkxT/7HcMDVVuf6eCbWZHxgU3JSsrB5q4o9lLvJaTsvpOhrHSw2VEnWjJTAf9X0UsuK6
 WF1IBfb35JGaVdDxA7KPjX5DHp4xryQlrCjq4IfZuf3610CDSpdF1+wKuCrzMpKPxcMkPZS7cD
 42wE5/I9SRRl8v7kXefCXrDuay9FMMr8P9pFqwWSKuOda5YV92gsWaXoLe+XQx5xDJqd1/hO7K
 iHk=
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="26829297"
X-IronPort-AV: E=Sophos;i="5.81,208,1610377200";
   d="scan'208";a="26829297"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 19:11:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcbHE56E2RMNOOtxRE658S8K2OfwPUomwZhZRjpzvu5jKJoOyZ3BViIJz6vZHWsdwsaChyaVhmZizjJo2ze2ouVeI2neheOoq28qTjUEUmzHeQaQmx1Yh4pR9rPdvVFlmkKa4mNbd/6w8mPyGSPxO1kQl5CN5mBF+IiPK5yG6jkHgirM0yY2seroli+CmyET5FLSbPhMw7Qs16wzBBzBDRxY3tzhh1FBgRY4HH+Xn7VJj9t5lQ985F2W71H5TvcDykoE13A0WNxS6P1MJsInQMY6pxZxLcOVql6Ln3VCWTM2Te46U2VeeMsHc418PfWFHkkHQB7LRlnjs9xYe+GymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu4qkZWqEkc4VUMrTpaE1PHvnGRVqtzIwPAZMF9zTFY=;
 b=NdxTR8nvHF3zrGIWyMN1w/8HQoQwrugP0A7VhPNxV88Tr4U18dHfB/yAaMkPFC+l+TOBG1BHRzqkKp6zlvaezlCLlwTxjR6nqiIzcF1AS527zH/Bf8Ekyxg8nHbT9Bksh9nzMOR+YNkk9I+wf1enKuOyseYHFxLUt+RgEltTRfDuJ5TiVSJ15D1TNXpgqc051LP3NCCjLYsTe5PRnylaV5g1C+bUJciP41teE34PRgneHlkF9LDtgJgO8XoWLuUFB3dZegLwuEVAmFXn7QdOcKSchKgIySewEUWcodWu9eQyuHGIreEU+06SzHgecE8Mi6WwPtjizoHZsgBEGkVffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu4qkZWqEkc4VUMrTpaE1PHvnGRVqtzIwPAZMF9zTFY=;
 b=JF+FrQFbZBgPsalGKiPY6EHf6Rl67VJRb4WV+taR7fGlKsZLbt5siYGx3VijeFPCSxlTrgE3E6gjP9cM6rQ35r/BPWz4rh5xIQzzhIDZXbQ52NyCyi3ORHxBQLoZSwBHDgoqYWsCas3dR4Pgpj+k7iiTnygFrobCLfgdmI6ivdk=
Received: from OSBPR01MB3653.jpnprd01.prod.outlook.com (2603:1096:604:44::18)
 by OSAPR01MB1505.jpnprd01.prod.outlook.com (2603:1096:603:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 10:11:18 +0000
Received: from OSBPR01MB3653.jpnprd01.prod.outlook.com
 ([fe80::184a:3e3:dbc4:c984]) by OSBPR01MB3653.jpnprd01.prod.outlook.com
 ([fe80::184a:3e3:dbc4:c984%6]) with mapi id 15.20.3868.034; Fri, 26 Feb 2021
 10:11:18 +0000
From: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
To: 'Santosh Sivaraj' <santosh@fossix.org>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>
Subject: RE: [ndctl PATCH] ndctl/test: add checking the presence of jq command
 ahead
Thread-Topic: [ndctl PATCH] ndctl/test: add checking the presence of jq
 command ahead
Thread-Index: AQHW+i93EVR+waI3SE2XFz9InG/pkapowW4AgAGRtPA=
Date: Fri, 26 Feb 2021 10:11:18 +0000
Message-ID: 
 <OSBPR01MB3653B3E78E16D2AE9957D45BF79D9@OSBPR01MB3653.jpnprd01.prod.outlook.com>
References: <20210203132108.6246-1-qi.fuli@fujitsu.com>
 <87ft1keb17.fsf@santosiv.in.ibm.com>
In-Reply-To: <87ft1keb17.fsf@santosiv.in.ibm.com>
Accept-Language: en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fossix.org; dkim=none (message not signed)
 header.d=none;fossix.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f3d54f3-3037-4e9e-2da9-08d8da3edc13
x-ms-traffictypediagnostic: OSAPR01MB1505:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSAPR01MB150530D561646E264B3635CCF79D9@OSAPR01MB1505.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 J+vtz91stG9cNfbHZ72ywC6oJM5y9z8pV3iWfmSB5NBGXqyXes2Qp8ebXjxRwF26lXEtc8N3uSp+d+qG+Nxum9eJRuGM5oEwCPg5PXnzlSG748A3U9/wby6XcGgEITNSmhFZlWWLQrKphSb55+h0n9mxM3SusdtJhB4qKpM5cG7UJC2HxlqvWwmK2CkScalzC89H9+edLeJktVZAarMySFs4/6rTLxBNltDwbWVUVKAU8mTQBAbqPf3ruAlQcSQSbL0/QrQwI4EiFqFXwxD8EnZ09XmxUCl/860DT16GIAqz7jyusUcn+350mW024s1bDAVDlgrGRJEtOAXh8ApY5Ne91mjA3fYE4kKYe46sZQwIDIaodkFkTJyXviIP87MjYHBpaNMM5HT25RQCblzxRtm9KZ3fBzQZamnBNKZgCUClYPmmgGDVqk9bQuQtxa1FNqkkjd4Vk7Cm6xfRfNgR5sINMiYdQYD2DuqsgBTVNum2hWj25ll6t5YgVsb07ZpcqgScGjW5B+TOT/jzrnR9QZvA1slR6eF5ulKOZ8pLV3NV44ymzC3nhCceA6Mu/M1Rc+6eVnlCv4ggWxgMVrSfZ4vVHHq27sJRAlGZv/9qnxk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB3653.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(76116006)(66556008)(107886003)(66446008)(33656002)(66946007)(6506007)(7696005)(64756008)(186003)(86362001)(66476007)(8676002)(4326008)(71200400001)(26005)(5660300002)(966005)(55016002)(478600001)(52536014)(83380400001)(9686003)(85182001)(316002)(2906002)(8936002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?UU1TOWgvc01xRzlwaDBMaUFod1ZwSDlkc1lXdkxEYmdKaEN2ZFluZ0Qx?=
 =?iso-2022-jp?B?dlVST3B6SWtzTDVpR3lIeVNCWlkwazVlWkY3dHQ3THh5VG13d0licGIz?=
 =?iso-2022-jp?B?T0JqVHkrdFlBSGJTZWhhUkJIbW1WSWpUb1dWem16MjBDd2tVakorSHdH?=
 =?iso-2022-jp?B?K1dJWU9wTUVGVXYveWNEcGtNeVl0WWlCdW9JeEJma0h6MmF6UG9ZNFo3?=
 =?iso-2022-jp?B?Uzh3eVg1cHR0bHJDTjM5QjEvb0ZSZExGRkM2MDFLLzNrVWRHTlFvU01D?=
 =?iso-2022-jp?B?SjYwa2JvbkVCRVp5YmNGZmJDT0VZeXAyVEFPY09WYi9NcHE5OGpoa3c0?=
 =?iso-2022-jp?B?TVg2WHhPQTJBaU9EajZtYW5Gb2xqWXB1cUZmblIrZFlESFhsRjRWVEVh?=
 =?iso-2022-jp?B?bjhiMFFHOGMveVJlMzc5TUZNN0ZoOVNXa3lDMGJ2SDVFTTU3dENCVGxu?=
 =?iso-2022-jp?B?RlE1ZTUraWV6NFZlQUpJZVMwWEdScWRjQTBNUlVBZUx6VE40dWs4b1F5?=
 =?iso-2022-jp?B?RSsvcGxGeTgwdE5rMzdMUmpPTy93K2RFUW5oYjJBT2lHc2p0eDZ6Mncv?=
 =?iso-2022-jp?B?b29nSDJ4QnZwZjN2SjA3TDZ0dE5pSjNYdDlWbUxGR2pybHc3MUhEYm5K?=
 =?iso-2022-jp?B?WStDMU04TjhCSjl4aTZldEdiaTh5NUZ6eUl2bjNrVWRLcmxJcCtzY2RC?=
 =?iso-2022-jp?B?V0xYM2ZXRW9NQlZJdGFGdXRFMU1jLzEvaURBZzFjSVVhNXRKME1XbEZN?=
 =?iso-2022-jp?B?Q0R4dHROcUNvbzhiYVR6NGdldGNDUjlYd21oWDU2TzM3R0JjK0s5WjRJ?=
 =?iso-2022-jp?B?TlFwSUZJcmh1Wkg5Z0xxRXFYT0QvV1l5UGkxdnpGOGg3VjBtL0Nyd2Jr?=
 =?iso-2022-jp?B?aXQvUE82emVtRjM2RVNvdUw5cktFYTRhai9vd01IMGV3YzJQWnRQY2Vu?=
 =?iso-2022-jp?B?OStCd3BYaktTTTQ2ZEFXWmtrMkg1ZlN0OVhseDZCSkR2V2lySklRUEZ0?=
 =?iso-2022-jp?B?dGd1SFJnYTYyV2FWRXIrRFVQcVhUYUdhS0U5cVNqVHZUemh5ZTFMY1Fl?=
 =?iso-2022-jp?B?SlRBQzlGeXZ6bVJJNVVLSExlWC85VmRjaVRSdUxOL2lJMEVWZjAwVFdq?=
 =?iso-2022-jp?B?ZUNQTzh4S2dEdWRPU0g3aWNmZkIvdHEwZzcwelN3dk5tMmkzMlRJS0JP?=
 =?iso-2022-jp?B?RlJNcHFWNW1wd0xYZ0Mzbmp5b0hnRUJwZXcvdi9rdjRMdnBOcE5FblpK?=
 =?iso-2022-jp?B?L0FIZWNIREprUDY5aVFkS3dMYjdjSmZYVWpSMEpIVCtJZjZTQU9ZTG9E?=
 =?iso-2022-jp?B?a0YrbHNlQVJhM0NMazRIMGU4aUVuZ2JhZkxRZzEyWXQzaFdiSjNYcHcr?=
 =?iso-2022-jp?B?SEtndjRiMXZaOGY0NzJKbVM4d2d0QVZtNkQralhhU01XV3VyMzNkUXFu?=
 =?iso-2022-jp?B?cFIycGF4OTJSbEhyeWVTelNQT3BlMWFqanZiVUxoV2hieEdMSTQ5WkpK?=
 =?iso-2022-jp?B?Y1N1ZEl4T1EvOEdTdWI2OSt6YTZkWUJQTEFYU2VweXNPTm51aWs3cXA3?=
 =?iso-2022-jp?B?QTZJWEhHa2R5QXZmUUFveWRwL3hNNjdQc1gwZkt4M2UvVmJZUnR5cVRM?=
 =?iso-2022-jp?B?KzhkYlR3K2VtODJkOGllN01vTktEZE85K0pPR1RjTlpCY0JNdk5LQnJq?=
 =?iso-2022-jp?B?TmRQZmpJQXQrY3F1cHpUZ05WbCt3TkZLQ1l5N2hrVXIzWlRvcExkeXRM?=
 =?iso-2022-jp?B?R2Q5M1pEeTd2QmJUNGpwVzNBdm1YSTZDOC8zNHQwUVdEQUtPYUpPN2Rs?=
 =?iso-2022-jp?B?UmhHcm9uT3Awemx1UXhpTDNjSmdzdEMrNnlZNy8xUDFDM2pIZUlVWlJY?=
 =?iso-2022-jp?B?TEJTMkVHWUJMU3d6bUFtbTBtdkxZQXg3WVd4SzVlVGxiZDNlQ0xzMkZh?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB3653.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3d54f3-3037-4e9e-2da9-08d8da3edc13
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 10:11:18.6797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgRkSdt3ZG2M1vxp27eG/P8PJLEaamnsHJPLA8I9cygJFBRj0SLAz6UlOlU8FkJ7Jpc6yVFKwrrNH/IgRwSL+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1505
Message-ID-Hash: XAWDOTMEDDURAJO4IGSAIQZSZ3JNDBR6
X-Message-ID-Hash: XAWDOTMEDDURAJO4IGSAIQZSZ3JNDBR6
X-MailFrom: qi.fuli@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KNJSSBG6WX7AD3LIONME3RWI6C5DSSJP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> 
> Hi QI,
> 
> QI Fuli <qi.fuli@fujitsu.com> writes:
> 
> > Due to the lack of jq command, the result of the test will be 'fail'.
> > This patch adds checking the presence of jq commmand ahead.
> > If there is no jq command in the system, the test will be marked as 'skip'.
> >
> > Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> > Link: https://github.com/pmem/ndctl/issues/141
> 
> Could this dependency be made part of configure.ac? Something like
> 
> diff --git a/configure.ac b/configure.ac index 5ec8d2f..0f2c6c1 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -65,6 +65,13 @@ fi
>  AC_SUBST([XMLTO])
>  fi
> 
> +AC_CHECK_PROG(JQ, [jq], [$(which jq)], [missing]) if test "x$JQ" =
> +xmissing; then
> +       AC_MSG_ERROR([jq needed to validate tests]) fi
> +AC_SUBST([JQ])
> +
> +
>  AC_C_TYPEOF
>  AC_DEFINE([HAVE_STATEMENT_EXPR], 1, [Define to 1 if you have statement
> expressions.])
> 
> Thanks,
> Santosh

Hi Santosh,

Thank you very much for the comments.
Yes, making this dependency part of configure.ac sounds good.
Meanwhile I think the tests should be improved, because the test result should not be "fail" if there is no jq command in the system.
I will make a V2 patch.

Best,
QI
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
