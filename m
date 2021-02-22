Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E77321111
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 08:00:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 14B19100EBBB9;
	Sun, 21 Feb 2021 23:00:03 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.159.83; helo=esa6.fujitsucc.c3s2.iphmx.com; envelope-from=qi.fuli@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 81B9F100EC1EB
	for <linux-nvdimm@lists.01.org>; Sun, 21 Feb 2021 22:59:59 -0800 (PST)
IronPort-SDR: 97OEe7cfKVLsUBG4Q653vwuLbDgZmLImLokf5mJE1tDQUxD1xqSJd7CMBGNmEO1ANtCCteuGeC
 efo38bxBJkoGbsU4V60SbNRL8tACV6yhG7Q4GakhEzBNYXz5U2zqUx0oB9HaAFX2YcbgpTsYHb
 IhT9sZnSNCpSLlXvrrP+Z8FuGoUH7FrTmEJIxAIgqk7rbv+PnaPove0L54twGL0P46twBnSa5N
 z1nNDqioLNXpvzNrgPG0tdegtyg4QRwT/SxWn40m0ItiJ500ybLU67yNBmqfCNN4jI+Mch0GDQ
 kwc=
X-IronPort-AV: E=McAfee;i="6000,8403,9902"; a="26701215"
X-IronPort-AV: E=Sophos;i="5.81,196,1610377200";
   d="scan'208";a="26701215"
Received: from mail-os2jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 15:59:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuK4qfGY0fpv5Opp0jPf2aPz8OYw6ImY7q5wqlq0etE5Wt69RLg+1iBaY9eLdhbaL0aUAPt2Axp909g+aNqgjZqj9ye3FEr58ZZhu/8qnYF2aR9EGBLeqoN/nn1qXNb2TP0sWRDWPAg/U2gpVBxjPlyEXMwxtyI+/Pq+O6ve9rfZ6cwaCGqRpVRn0LxCdWIXfTfKnKDlHPEia52kJ5D3KPPGCuU8ETh5PG6pCXpcminySbrCH8iwwnx7hi5rLuIGQZSk6bWe16ykLYs6yBnDru40OdjXBJXJ0j6+CswzHv1C9jxtmDxJ6ao405swrJtCHKuU6YyFpZkCMoqieTaoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiXiD/MXYO28eXAyC3ODZdQLfs5yrgdjSPg+HGLK1ps=;
 b=ZmOSqLZRvwrd1tpn6+qSwOuIMWujrzraG2Wp1oE0oR6YrVPDjTACmd64Yw5gQ27ht3+mRlO+xBOzpETYEnZNbterGNq2X4Qvo5o62pLaENxkx/1O9rbDf7Fo8Uo6r26YLJFno19bQ7Gq+DkIO3FrYsWayd3qDQtjRPT3OLXyPVhnrrIFe8KE5PTWV3ADm1BlcjUXWDTavz1Q1REIBr/CNXrgBndajMcJ7iV5Wd0yLmGBZq/DNvk4QVXYCrpj9SxmzEPIihWpc7eWbuoXPF289oSo6vgYcNZDmgK51m2Qp/sKIQft4cwuJ0a2cSlVfawpzRyEC/ftj6qEeE5bvVbcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiXiD/MXYO28eXAyC3ODZdQLfs5yrgdjSPg+HGLK1ps=;
 b=BO6NBtdKgGUP1uygHcHOvNPKYdMB1Dy8uSrJe1N3rqel/rLRMmViJVKQkZE5e8bHrPkauQYDHjbiVB+vPd+V0GZGd6lq0Lft9WR6+23H4HUUWYFXS2tvv5nUD9WwXKqJpzTwXkUTWDYtJkpNTAxek57NsZSwEw9/4v+dmMTCSpw=
Received: from TY2PR01MB3660.jpnprd01.prod.outlook.com (2603:1096:404:d2::20)
 by TY1PR01MB1561.jpnprd01.prod.outlook.com (2603:1096:403:3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28; Mon, 22 Feb
 2021 06:59:54 +0000
Received: from TY2PR01MB3660.jpnprd01.prod.outlook.com
 ([fe80::e581:8b94:a754:1169]) by TY2PR01MB3660.jpnprd01.prod.outlook.com
 ([fe80::e581:8b94:a754:1169%7]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 06:59:54 +0000
From: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: [ndctl PATCH] ndctl/test: add checking the presence of jq command
 ahead
Thread-Topic: [ndctl PATCH] ndctl/test: add checking the presence of jq
 command ahead
Thread-Index: AQHW+i93EVR+waI3SE2XFz9InG/pkapj2+Yw
Date: Mon, 22 Feb 2021 06:59:54 +0000
Message-ID: 
 <TY2PR01MB3660C6DED8DEB78CCF40A4FCF7819@TY2PR01MB3660.jpnprd01.prod.outlook.com>
References: <20210203132108.6246-1-qi.fuli@fujitsu.com>
In-Reply-To: <20210203132108.6246-1-qi.fuli@fujitsu.com>
Accept-Language: en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88d9cfe5-6858-4d35-a93d-08d8d6ff7528
x-ms-traffictypediagnostic: TY1PR01MB1561:
x-microsoft-antispam-prvs: 
 <TY1PR01MB15614E4D6AFCC17D974DE256F7819@TY1PR01MB1561.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 JOPGiCJNI2eiU9FOvHWXzC7xMb0WRqC9Y3Ll8wIFR2++J7LA5Epq3a0IOQbsZnF+CZiGprSEjXrHd/u3ba1Rcyn6M/uxRQmMA9j7t3mZCo5n7KKvSlfQkSgX5Ri0LbNrvprGoO2SJZQYQddAfd0Hs/vAmVuZYv3fg7v7C/ZVh6/ENx/U9VE2Fc0bVaWZScvQxHZDjI/ITfMhq/NIcrG+XBK5et9wugyAQPb7vY+yf8z+RbNhXaIr5yRLNFedyaPkZAqHJxQhk+UHzBDOEHGPjtqeh/yevR/tfdIBAEBdbiXWpXoncr2zBPQ7irl8+p3/3G8C37PMfmtKJIkiNC/tLZETZwOueZ8FW69OYW59KuO4t+V8Pg36hGJp6m2nbWIZzS3Iq1f0XoxLkNKZktZAQ/r4idh38j69IKvRi/xAHtdVx80CTva6p55nHNMwDCzamj3F2wYr0De5eusXgkyA/Xbc9ujJf1PBi4tQQbUXOOnbPeSju+Fq5h7kakd5ET4D9tsJyw6fDl0xhZj66d0hddVjXm7fyxpLTsjOpw6QDXBT352YiwtW5Jlu7dJXlXcD1YdvClN1BPqDIoORmoLpIcIl7hFTwZMjhmKMeF/4EE0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3660.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(186003)(7696005)(26005)(66476007)(71200400001)(66946007)(64756008)(478600001)(6506007)(66446008)(66556008)(76116006)(53546011)(52536014)(6916009)(5660300002)(86362001)(966005)(9686003)(55016002)(85182001)(2906002)(8676002)(33656002)(8936002)(316002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?M3ZPaVNoZzFlYWVXQ1EzamFvTDFUa01OVkZUSUdQRlFNdVQ5OTFZRmZ2?=
 =?iso-2022-jp?B?ZGRwZVMyN1Ftei9HWTBWRk9zajFBdElQdVZCOU42N0xNeWtlWXcyakdZ?=
 =?iso-2022-jp?B?RWhTRGxFdEJUYUJFOEhjMnlZaUNFMGk2MEJOMU9xc3VTVlB4alZPVWxq?=
 =?iso-2022-jp?B?cG1aM2ltUVpNaWRRZDFmUmtJMEZFNGIxVFRHelpUZlJIU1kzV2s1bkR3?=
 =?iso-2022-jp?B?MDFYTEp2dFhWTVdQZmpaaUZMTG03UjBmbVlkR3JkZE9lTlZiamFHa0FG?=
 =?iso-2022-jp?B?bENuVEpJeTIxcVFoQ3NHVjdXdVRDSUpvNHBJdU1NcU1WWHVuRVpuN2Iw?=
 =?iso-2022-jp?B?TVZqNExpR2RzbjV4YVQ5c0NJZU1KSlJSaytITkNabTc0ejg2MVZqSmda?=
 =?iso-2022-jp?B?NFAvWCtUNHBwbFNxRWRQVkF1VXdLVXFMODAzQ2pnYkI2UkZYU0lkNzlB?=
 =?iso-2022-jp?B?YmdMOUpjRkMzQnp0dExZR0FqaHZCWGR1OW1UOU5WOExUeHFuVnZXbEJu?=
 =?iso-2022-jp?B?NTZwcU5TYTVBVnRYTmNrNzVmSkN6TzlDVFFueGtFbzFqN3BpQXV0V20y?=
 =?iso-2022-jp?B?T1BDZloxQXBoRzBkVWJsRlpiaG82UFhhYkFiNVJXWmpVU0lWZ0JnaG5r?=
 =?iso-2022-jp?B?bDQ5SEQrSEQwaWtDcW9hYXk1UE1LTkUrT2ZqUUlqTTd1ZHRzLytIZkpT?=
 =?iso-2022-jp?B?YlRqOC9Xa2duVTlPZnRsWnNnNTBHRGJLUDJsMFBIVDdlZFNGS0lkS04x?=
 =?iso-2022-jp?B?T3FFOTdEM1NhQkpoc0ZzazZLL1kzWlp2NGwyNUZpbURQRDNpazhQVHE5?=
 =?iso-2022-jp?B?aVhJUFNkZkIwaElFUU9oODNpTUlsODRnckZqcWMxaTBhbjZCSm94WEVT?=
 =?iso-2022-jp?B?cldmOVl6ck82Smsvem1yMHpmYUszcytHTHcwbGJxTWFYM2t6TnFlTWg0?=
 =?iso-2022-jp?B?ZXVFNTdWU09ScVpVa1JYZzRSTGJHbHhaeDJnSXV1dXEvajBuNFBoR3hV?=
 =?iso-2022-jp?B?SHdnVnFBMUtvUUE5ZjI5RnF3MThIbXBOM05Ic1dWTjZJeVdlUU9DRWlx?=
 =?iso-2022-jp?B?b2dZemVlU1Q0SS9rdzRyNC9QZm00M3dlNFh1MzJRT2xEM3NxK3lMYVNQ?=
 =?iso-2022-jp?B?RkN1S0grMEppSnluWUdIOGhNOGZMZEhGZFZsdlRBNHduYTVkMDhZZC9h?=
 =?iso-2022-jp?B?REVBcGdzZjI0YlkvVTVIL0lTdkdzOStwb0QxdmNyNVEwOUxMUlNva091?=
 =?iso-2022-jp?B?ZU9FUHFSMEFjTkVDNGFLYXVrQngyVkNLYW4xS0lPbThpNHFLWVZySHZV?=
 =?iso-2022-jp?B?UkpWTGhSKy9CL2NBeHJobUJBSStmdnhtd1E2NkxUdTA5WlhMakVSTkhm?=
 =?iso-2022-jp?B?NVNITHNZZEdWNmdxVGttMWsvQ090UDhEUFo5Q0thVmNRQ0pMeW5paW1r?=
 =?iso-2022-jp?B?NHZqNCtLeVBTZXdDOHVUbXZxNHp0bHA5QlI0SWxIc2xpQWYrTHJnOGJM?=
 =?iso-2022-jp?B?WjVqWEw0ZEpueTYrMjU1c2FJdkZpZVZIUktmYmNJa05JQUtKUmdFQUZo?=
 =?iso-2022-jp?B?R3k1VEJCVjR0enpOSm9IOFVONC9Famk4SzRNYjlQQ0MyT01kR0I5aVNa?=
 =?iso-2022-jp?B?UW5NWE8vZzlGZVA5bVN5bitDdmFZcTN3NGNwVmhQVm1uWDBKaDdlUHFM?=
 =?iso-2022-jp?B?czZFQnFaRHdYUTI0QzNneWdUb3JBNE1HZjRDM3VaSHBQa2FEQmE2aEJl?=
 =?iso-2022-jp?B?cjc1MDF6a2pUZEJpcVdEb20vTUtuVEhkVVgvaGF3N3g5S0FlcDlkK1hM?=
 =?iso-2022-jp?B?UVo5T3grT0dxRVl4cENiTXd1djg4b1d4ZTVYejNYakVLNUwwWW9kWVUv?=
 =?iso-2022-jp?B?Rng5YStHeGptM0lLRUN1bGIraGlIem83UnpSRWM4aUdMR2ZSd1pFNnBK?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3660.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d9cfe5-6858-4d35-a93d-08d8d6ff7528
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 06:59:54.2949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3D6ZSZTQ5vZGFokSNx1p2bbQmhw16OnrFoTONepe3Hsdx0v6SoLhoB+u7n2qpLvIy+q7wvMvRmZvySmLfUg+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1561
Message-ID-Hash: 65KLPSX5CGS4P2NGAZTFDAZ557MZCARH
X-Message-ID-Hash: 65KLPSX5CGS4P2NGAZTFDAZ557MZCARH
X-MailFrom: qi.fuli@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7RVX27KNANWW72T7S2BEIHCDWUXHQONT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ping

> -----Original Message-----
> From: QI Fuli <qi.fuli@fujitsu.com>
> Sent: Wednesday, February 3, 2021 10:21 PM
> To: linux-nvdimm@lists.01.org
> Cc: QI Fuli <qi.fuli@fujitsu.com>
> Subject: [ndctl PATCH] ndctl/test: add checking the presence of jq command
> ahead
> 
> Due to the lack of jq command, the result of the test will be 'fail'.
> This patch adds checking the presence of jq commmand ahead.
> If there is no jq command in the system, the test will be marked as 'skip'.
> 
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> Link: https://github.com/pmem/ndctl/issues/141
> ---
>  test/daxdev-errors.sh           | 1 +
>  test/inject-error.sh            | 2 ++
>  test/inject-smart.sh            | 1 +
>  test/label-compat.sh            | 1 +
>  test/max_available_extent_ns.sh | 1 +
>  test/monitor.sh                 | 2 ++
>  test/multi-dax.sh               | 1 +
>  test/sector-mode.sh             | 2 ++
>  8 files changed, 11 insertions(+)
> 
> diff --git a/test/daxdev-errors.sh b/test/daxdev-errors.sh index
> 6281f32..9547d78 100755
> --- a/test/daxdev-errors.sh
> +++ b/test/daxdev-errors.sh
> @@ -9,6 +9,7 @@ rc=77
>  . $(dirname $0)/common
> 
>  check_min_kver "4.12" || do_skip "lacks dax dev error handling"
> +check_prereq "jq"
> 
>  trap 'err $LINENO' ERR
> 
> diff --git a/test/inject-error.sh b/test/inject-error.sh index c636033..7d0b826
> 100755
> --- a/test/inject-error.sh
> +++ b/test/inject-error.sh
> @@ -11,6 +11,8 @@ err_count=8
> 
>  . $(dirname $0)/common
> 
> +check_prereq "jq"
> +
>  trap 'err $LINENO' ERR
> 
>  # sample json:
> diff --git a/test/inject-smart.sh b/test/inject-smart.sh index 94705df..4ca83b8
> 100755
> --- a/test/inject-smart.sh
> +++ b/test/inject-smart.sh
> @@ -166,6 +166,7 @@ do_tests()
>  }
> 
>  check_min_kver "4.19" || do_skip "kernel $KVER may not support smart
> (un)injection"
> +check_prereq "jq"
>  modprobe nfit_test
>  rc=1
> 
> diff --git a/test/label-compat.sh b/test/label-compat.sh index 340b93d..8ab2858
> 100755
> --- a/test/label-compat.sh
> +++ b/test/label-compat.sh
> @@ -10,6 +10,7 @@ BASE=$(dirname $0)
>  . $BASE/common
> 
>  check_min_kver "4.11" || do_skip "may not provide reliable isetcookie values"
> +check_prereq "jq"
> 
>  trap 'err $LINENO' ERR
> 
> diff --git a/test/max_available_extent_ns.sh b/test/max_available_extent_ns.sh
> index 14d741d..343f3c9 100755
> --- a/test/max_available_extent_ns.sh
> +++ b/test/max_available_extent_ns.sh
> @@ -9,6 +9,7 @@ rc=77
>  trap 'err $LINENO' ERR
> 
>  check_min_kver "4.19" || do_skip "kernel $KVER may not support
> max_available_size"
> +check_prereq "jq"
> 
>  init()
>  {
> diff --git a/test/monitor.sh b/test/monitor.sh index cdab5e1..28c5541 100755
> --- a/test/monitor.sh
> +++ b/test/monitor.sh
> @@ -13,6 +13,8 @@ smart_supported_bus=""
> 
>  . $(dirname $0)/common
> 
> +check_prereq "jq"
> +
>  trap 'err $LINENO' ERR
> 
>  check_min_kver "4.15" || do_skip "kernel $KVER may not support monitor
> service"
> diff --git a/test/multi-dax.sh b/test/multi-dax.sh index e932569..8496619
> 100755
> --- a/test/multi-dax.sh
> +++ b/test/multi-dax.sh
> @@ -9,6 +9,7 @@ rc=77
>  . $(dirname $0)/common
> 
>  check_min_kver "4.13" || do_skip "may lack multi-dax support"
> +check_prereq "jq"
> 
>  trap 'err $LINENO' ERR
> 
> diff --git a/test/sector-mode.sh b/test/sector-mode.sh index dd7013e..54fa806
> 100755
> --- a/test/sector-mode.sh
> +++ b/test/sector-mode.sh
> @@ -6,6 +6,8 @@ rc=77
> 
>  . $(dirname $0)/common
> 
> +check_prereq "jq"
> +
>  set -e
>  trap 'err $LINENO' ERR
> 
> --
> 2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
