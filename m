Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B72A525BFE2
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Sep 2020 13:10:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9988813BED6CF;
	Thu,  3 Sep 2020 04:10:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.219.246.113; helo=mail1.bemta23.messagelabs.com; envelope-from=ahuang12@lenovo.com; receiver=<UNKNOWN> 
Received: from mail1.bemta23.messagelabs.com (mail1.bemta23.messagelabs.com [67.219.246.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B4BF713BDCF27
	for <linux-nvdimm@lists.01.org>; Thu,  3 Sep 2020 04:09:58 -0700 (PDT)
Received: from [100.112.7.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
	by server-2.bemta.az-c.us-east-1.aws.symcld.net id 64/7F-40346-50FC05F5; Thu, 03 Sep 2020 11:09:57 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WScUwbdRTH+d1de0fTytGC/GBjk4K6YlpacK4
  EHUy3pPxB7P7TRYEDurahFNYro0iMBZWZ1k7URRm1KSvd5ohLGUNtGZmyFBwwVkEqGQQnkw0L
  iRuiaNgGtr0O9Z/L973Pe9/fe5dHoPw77DRCZTKqDHpKJ2RzMM2v8xwxFlCWSTfbnpV/2hzA5
  d/cXsTki2e7gPztD2dxufVhDy5vvfAnkM+0DSNFuMLXMYcrugZCiMJq38AUdy8H2QpPXxBTXB
  xrUrIPsbT6ilpTOUvT13yKXfdzvunGYCtmBuZ8C+AQfNKMQNfVEIsJQgCeOdbM3iIXvC0IE6w
  DeHNpCreAeAKQp1Hom0qNAEAOY9Bvb2ExQQ+A1vVVEAkw8hIKR+cnAdPvQOCybyXmfAtA18DH
  mAUQBJvMhuO9VMQ3iSyEwenz0RqUvA7geLAPiQABqYbNX93EmSIN7LQ4UEbnwveuDkTzGJkF1
  8/cj+Z5ZDncnGiP9vLJVgR6v2NFdDxZAE8Eg2xmicfhX6NfRGtQMgXOLDijGpIkdA8EUEYnw9
  AvG7HdWgG8vTDBYkAB7B0bixWlw0mnFTC6BHoWb8V0NnzQ/knMtBo67HMx/RT8+sdATO+A3bZ
  5rA3kdvxnjo7wf0FJEfT05zDpDHjCOo93RFdLhCMnF7BOgHWD3RUGrVpjrKG0OrFMKhXLZLni
  3eI8mYR6Q1wpqafFKoo2isNhAy2hG2sqdVUSvcrYC8JnVlXH2ukF68v3JFdAKoEIk3m/DSvL+
  I9V1FY1aihaU2ao16noK2A7QQghTzEeZokGlVplOqzVhY/1EYYEV5jEU0Ywj66jamitmkGjIJ
  9oCzlcKHHjrjv89TtOu1A+pq/Vq9JSeOpIAxlp0NTrt+wenf8kSE8T8EBcXByfW6cy1GiN/+d
  LIIUAQgFPHHHhavXGrVeXwgMh4YGuFZVEBjJS/6I0M5L3e6XTtJGAzLxLFj50i18MUQIh3ogX
  7KJyR163/XFnzvNanj+l8GKe2nY/c630peIDUprXpF47f3zi1eOfvVnqdO1SV+9tEPnv9Rf/Z
  NhcLdGZgkcaOsuP4ee8C6OSPV9mZKhLcSq9U5f1UYv/+7fcl2W29zdfPtqTaW9PmHZiSP7K/t
  yAaPVSg+PJoVeKDu8QyYH06cpr1eZn3E/ES/Z4k7cl7kwSSKWBk9VKjlrel7Wvijtb+K2yct9
  Q8dSR9sF+zRBtSd/+XFvZCzOTjncOHnr+c9+2pom9D65zB3POTTeZbWdzVkSlqQmznLWjp0a6
  PvghYJf87fMcnOtaLs/sFmK0hpJlowaa+gebZef1eQQAAA==
X-Env-Sender: ahuang12@lenovo.com
X-Msg-Ref: server-3.tower-416.messagelabs.com!1599131396!149558!1
X-Originating-IP: [104.232.225.10]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25511 invoked from network); 3 Sep 2020 11:09:56 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.10)
  by server-3.tower-416.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Sep 2020 11:09:56 -0000
Received: from HKGWPEMAIL03.lenovo.com (unknown [10.128.3.71])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Forcepoint Email with ESMTPS id 1F26BACF2D4ECB09FB9B;
	Thu,  3 Sep 2020 07:09:54 -0400 (EDT)
Received: from HKGWPEMAIL02.lenovo.com (10.128.3.70) by
 HKGWPEMAIL03.lenovo.com (10.128.3.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1913.5; Thu, 3 Sep 2020 19:11:37 +0800
Received: from HKGWPEXCH01.lenovo.com (10.128.62.30) by
 HKGWPEMAIL02.lenovo.com (10.128.3.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5
 via Frontend Transport; Thu, 3 Sep 2020 19:09:53 +0800
Received: from APC01-HK2-obe.outbound.protection.outlook.com (104.47.124.54)
 by mail.lenovo.com (10.128.62.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5; Thu, 3 Sep 2020
 19:09:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/ZZhHvFnVqm4hh3mWNlQndAdz33Yj4YVyWVMjHTDrxAxzmCOCJtdhVXouXSv4gwZtA0o/QMmBYfk5RGkvnISQJa2K5Ai59R06cFiG9Q/KTj5nQb8h3LWRVYPEpQX3BDK5MWuIAi4aV+KGU+cnnO+Iu3SPGRectPT8dpcR4xIh649Vywlk9bGK9lRhEV0w4tKGZjk5FNhb/q3RJIyCdrLXjc/VA0FDbsC7P9OjsnTCrmW8TKb98C3b6yN836LLH/ixmagMZO/XvEwkQPxQtNR6X8E0/VJkPq0cjZZKn8EQPwTNaTHKmspZpR7MLky7bqOEh7CmVXIvHR+ClgUuwFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGld2+4J36ociqTMEqGEyFq4maY06x3IEMM16WsdU9E=;
 b=PfbW8gdZ+Vo7HBLzv5pa4rIgqOyjM1OdEMSQh+WU3aL8KJfHlPJOOn+a8xTGWen50FwM+tlsG6iYIJCQWMqZ4abzlKoC5jaWCUBtTcSr0fJoK2QksxNHtcwvP0Hn+8rqUTmEzeBXJxTjPev6NkEGHEGWSpjWZHQvy3b5rnxCWQMgxmQ5KLFr+0HPCGNFw4QEezUmlAK07mtpOSkylg4HpZ0U/i8U0JHXVfldHOgQDqotcFz529Hgr9UXYbmKuYJPkiryIY6JNAC79X+/dp0Jg0u1ODpfSU3eqdY8r9WEI/494fr52qm6IGwlokXDPtlnfr/2CMIjpxlTtFwdFHzwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGld2+4J36ociqTMEqGEyFq4maY06x3IEMM16WsdU9E=;
 b=qFUNaj5a58mrmpVBY6q13N78d08PNaG6018ukulIUt3hNN730J4GhzAcKFD9Qupu7HlS+qpa9WZiTmKgPYlcjSKqsOldm2DIWd0DrZKATdXC4fnJLNLVRSYIUqifvwnH4QByaN0fheuOORiKmsfQ8qfUpR5Qbz3pc+eNAN5xsX8=
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com (2603:1096:202:c::8)
 by HK0PR03MB2977.apcprd03.prod.outlook.com (2603:1096:203:50::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7; Thu, 3 Sep
 2020 11:09:52 +0000
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164]) by HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164%7]) with mapi id 15.20.3370.009; Thu, 3 Sep 2020
 11:09:52 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>
Subject: RE: [External]  Re: flood of "dm-X: error: dax access failed" due to
 5.9 commit 231609785cbfb
Thread-Topic: [External]  Re: flood of "dm-X: error: dax access failed" due to
 5.9 commit 231609785cbfb
Thread-Index: AQHWgbH62ZFAESTatkSmSEwLQTG/XqlWvQKw
Date: Thu, 3 Sep 2020 11:09:52 +0000
Message-ID: <HK2PR0302MB2594E282BC7601E1335773F2B32C0@HK2PR0302MB2594.apcprd03.prod.outlook.com>
References: <20200902160432.GA5513@redhat.com>
 <df0203fa-7f75-53ac-8bf1-79a1c861918e@suse.de>
 <20200902164456.GA5928@redhat.com>
 <4968af50-663d-74cf-1be2-aaed48a380d5@suse.de>
 <20200902165101.GB5928@redhat.com>
 <c6636009-0bb9-ab2e-d453-992a2a53c6ef@suse.de>
In-Reply-To: <c6636009-0bb9-ab2e-d453-992a2a53c6ef@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:b011:e002:37e1:4c72:58e5:53e9:1b12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e76cd140-53f4-4813-c62c-08d84ff9e1d2
x-ms-traffictypediagnostic: HK0PR03MB2977:
x-microsoft-antispam-prvs: <HK0PR03MB2977902726852B4C258568A8B32C0@HK0PR03MB2977.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qDXt/Nq0j4ZgVYv7F6SgZkMgORYjQh4UGy5ewGrwhVzar9oL7krEAJp9LZF925Po3ad+m0zmMPAaeAZweZfXADExa1joHoN9L4ohfVjy8a8ChVnG0mQW1fdQdpQ1Ui2cFHhKEdyPbByLVF32BABrmXNTalJD8ah1nNqpRo6kOM3Lt7k+cdrMv/iWkGAriHjQBjFaxaQg69KhJ5O/2Mdx1aUH0MyHIHnm3EbtbasbS9FuxLusFgAq2+I1h7BslQTHImVUS/fwH9FDWnMK8VeKrwgj8VQH0lOvcJMSpfcWp5OY4Mn/7zvK2Z/2I9RhCv0oTrzWp0f3LPZNYSS6RkUTIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR0302MB2594.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(76116006)(316002)(54906003)(83380400001)(55016002)(9686003)(52536014)(71200400001)(186003)(110136005)(8676002)(64756008)(66946007)(2906002)(66556008)(66476007)(8936002)(66446008)(33656002)(4326008)(86362001)(478600001)(53546011)(5660300002)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vxIIQ0TgciXVgBd5y8oWzMFwdwVKO9K4SUSa5oaGERA4UfWThHEfX6MR2EOZ7ZuFugklqqq1bvDHjR2OGi0zi/OUV4vQVAgANkjK1qDu5av/swKt+vgTsHU7DV4v3EbLthgx2icdsFu3qZRoGud1pB0kcFtSs4xp/Aj4PbpvHrn0aq+un8CsP7cy/ZJQerZp5nB0O89M/Fz+IwVxBvIZvEyinj95r2M4tLw64pxFCdLEzKtK4H25nNT1paLeBk28hToGT0/VXxMHhhpCqVqHSK5u9uqxxiEg8lt2Zkbl4NaW2NHo9Vt8GBH6jDwijkEeF+QbAS/iNrMDI74/Hoz7OwsFaJ13YBfVxhb6X8vnrqC3wANVoIgjXsX4pKPOQDSqmiUyqOErdtsrymTAoswYApWASxLHRlVkiUM2nv7R5s3jlwGeiMPLnv+3ZQdLIvox2m4SggEdqa13RF2gRqvSnuuuWSz2eYcOcWM0JJ7ZUar1J7FM703JIufN6Cl6zooGoSZr09xgqcRB6RUMN1q+Nes4AgG1mQ8MqvaHmBrbR/WuMNxSKDACPJZYPOMiT/UZgS2vOstoeXzyjg+JnpwC6F1lp+jewAqQ+JxLr3yQm/zMMUE+SZ0dfwbzP3bGDZlwBFpMfjhUUnG782eWlyi68E81Z3a7QmVJJFGl/an/rxCOROw04wohvGYk9+qL6BZpvk+xP9nwoNFjgJQvHlS0Fg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR0302MB2594.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76cd140-53f4-4813-c62c-08d84ff9e1d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 11:09:52.5673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/s5LXb8B7UwEOXSJODEow762y27aWx3gMjC6cinB2EULyeYNvlrYAFVTxLP3DNPr0tAmOUXdpv63hPm6Jsqhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB2977
X-OriginatorOrg: lenovo.com
Message-ID-Hash: CNT5ZTYO63AZDITPQS6TPQYUNGHDE6BH
X-Message-ID-Hash: CNT5ZTYO63AZDITPQS6TPQYUNGHDE6BH
X-MailFrom: ahuang12@lenovo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CNT5ZTYO63AZDITPQS6TPQYUNGHDE6BH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Coly,

> -----Original Message-----
> From: Coly Li <colyli@suse.de>
> Sent: Thursday, September 3, 2020 1:20 PM
> To: Mike Snitzer <snitzer@redhat.com>
> Cc: Jan Kara <jack@suse.com>; Ira Weiny <ira.weiny@intel.com>; Pankaj Gupta
> <pankaj.gupta.linux@gmail.com>; Vishal Verma <vishal.l.verma@intel.com>;
> linux-nvdimm@lists.01.org; Adrian Huang12 <ahuang12@lenovo.com>
> Subject: [External] Re: flood of "dm-X: error: dax access failed" due to 5.9
> commit 231609785cbfb
> 
> On 2020/9/3 00:51, Mike Snitzer wrote:
> > On Wed, Sep 02 2020 at 12:46pm -0400,
> > Coly Li <colyli@suse.de> wrote:
> >
> >> On 2020/9/3 00:44, Mike Snitzer wrote:
> >>> On Wed, Sep 02 2020 at 12:40pm -0400, Coly Li <colyli@suse.de>
> >>> wrote:
> >>>
> >>>> On 2020/9/3 00:04, Mike Snitzer wrote:
> >>>>> 5.9 commit 231609785cbfb ("dax: print error message by pr_info()
> >>>>> in
> >>>>> __generic_fsdax_supported()") switched from pr_debug() to pr_info().
> >>>>>
> >>>>> The justification in the commit header is really inadequate.  If
> >>>>> there is a problem that you need to drill in on, repeat the
> >>>>> testing after enabling the dynamic debugging.
> >>>>>
> >>>>> Otherwise, now all DM devices that aren't layered on DAX capable
> >>>>> devices spew really confusing noise to users when they simply
> >>>>> activate their non-DAX DM devices:
> >>>>>
> >>>>> [66567.129798] dm-6: error: dax access failed (-5) [66567.134400]
> >>>>> dm-6: error: dax access failed (-5) [66567.139152] dm-6: error:
> >>>>> dax access failed (-5) [66567.314546] dm-2: error: dax access
> >>>>> failed (-95) [66567.319380] dm-2: error: dax access failed (-95)
> >>>>> [66567.324254] dm-2: error: dax access failed (-95) [66567.479025]
> >>>>> dm-2: error: dax access failed (-95) [66567.483713] dm-2: error:
> >>>>> dax access failed (-95) [66567.488722] dm-2: error: dax access
> >>>>> failed (-95) [66567.494061] dm-2: error: dax access failed (-95)
> >>>>> [66567.498823] dm-2: error: dax access failed (-95) [66567.503693]
> >>>>> dm-2: error: dax access failed (-95)
> >>>>>
> >>>>> commit 231609785cbfb must be reverted.
> >>>>>
> >>>>> Please advise, thanks.
> >>>>
> >>>> Adrian Huang from Lenovo posted a patch, which titled: dax: do not
> >>>> print error message for non-persistent memory block device
> >>>>
> >>>> It fixes the issue, but no response for now. Maybe we should take this fix.
> >>>
> >>> OK, yes sounds like it.  It was merged and is commit c2affe920b0e066
> >>> ("dax: do not print error message for non-persistent memory block
> >>> device")
> >>
> >> Thanks for informing me this patch is merged, I am going to update my
> >> local one :-)
> >
> > So the thing is I'm running v5.9-rc3 (which includes this commit) but
> > I'm still seeing all these warnings when I run the lvm2 testsuite.
> > The reason _seems_ to be because the lvm2 testsuite uses brd devices
> > for test devices.  So there is something about the brd device that
> > shows commit c2affe920b0e066 isn't enough :(
> 
> [Resend and CC Adrian Huang]
> 
> Hi Mike,
> 
> Could you please apply and test this attached patch based on v5.9-rc3 ?
> 
> It seems the pointer dax_dev of __generic_fsdax_supported() parameter is not
> initialized (IMHO this is not a dm bug), therefore the && should be
> || to check the dax support state.
>
> Also I add two pr_info() to print the variables value, let's see whether my guess
> makes sense.

I confirmed that Mike's symptom can be easily reproduced with brd devices after running the tool 'lvm2-testsuite'.

And, Coly's right. The dax_dev pointer is *NOT* NULL when the tool executes the command ' lvchange $vg/foo -a y'. Please see the following log (with applying Coly's patch).

So, the 'if' statement should be logical OR operator instead of logical AND operator. Thanks, Coly.

------------------------------------------------------
# lvm2-testsuite --only activate-minor
....
[ 0:00] aux prepare_vg 2
[ 0:00] #activate-minor.sh:22+ aux prepare_vg 2
[ 0:00] ## preparing ramdisk device...ok (/dev/ram0)
[ 0:01] 6,3160,167857640,-;brd: module loaded
[ 0:01] ## preparing 2 devices...ok
[ 0:01] 6,3161,167877024,-;dax_dev: 0000000000000000
[ 0:01] 6,3162,167877026,-;bdev_dax_supported(): 0
[ 0:01] 6,3163,167877041,-;dax_dev: 0000000000000000
[ 0:01] 6,3164,167877042,-;bdev_dax_supported(): 0
[ 0:01] 6,3165,167877160,-;dax_dev: 0000000000000000
[ 0:01] 6,3166,167877162,-;bdev_dax_supported(): 0
[ 0:01] 6,3167,167877407,-;dax_dev: 0000000000000000
[ 0:01] 6,3168,167877412,-;bdev_dax_supported(): 0
[ 0:01] 6,3169,167877430,-;dax_dev: 0000000000000000
[ 0:01] 6,3170,167877430,-;bdev_dax_supported(): 0
[ 0:01] 6,3171,167877572,-;dax_dev: 0000000000000000
[ 0:01] 6,3172,167877574,-;bdev_dax_supported(): 0
.......
[ 0:01] lvchange $vg/foo -a y
[ 0:01] #activate-minor.sh:25+ lvchange LVMTEST12338vg/foo -a y
[ 0:01]   /tmp/LVMTEST12338.9M4A4QfLHQ/dev/mapper/LVMTEST12338vg-foo not set up by udev: Falling back to direct node creation.
[ 0:01] 6,3173,168081520,-;dax_dev: 000000007f8e88a7
[ 0:01] 6,3174,168081524,-;bdev_dax_supported(): 0
[ 0:01] 6,3175,168081543,-;dax_dev: 000000007f8e88a7
[ 0:01] 6,3176,168081544,-;bdev_dax_supported(): 0
[ 0:01] 6,3177,168081749,-;dax_dev: 000000007f8e88a7
[ 0:01] 6,3178,168081750,-;bdev_dax_supported(): 0
-----------------------------------------------------

> Thanks.
> 
> Coly Li
> 

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
