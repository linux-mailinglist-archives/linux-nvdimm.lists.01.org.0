Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166C125C040
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Sep 2020 13:25:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E424E13BEDC8A;
	Thu,  3 Sep 2020 04:24:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.219.246.112; helo=mail1.bemta23.messagelabs.com; envelope-from=ahuang12@lenovo.com; receiver=<UNKNOWN> 
Received: from mail1.bemta23.messagelabs.com (mail1.bemta23.messagelabs.com [67.219.246.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 14A3C13BEDC7C
	for <linux-nvdimm@lists.01.org>; Thu,  3 Sep 2020 04:24:57 -0700 (PDT)
Received: from [100.112.7.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
	by server-1.bemta.az-c.us-east-1.aws.symcld.net id 06/48-04232-882D05F5; Thu, 03 Sep 2020 11:24:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSfUwTZxzu27v2TkLdUcC+dNhhY1ho0kqJupv
  gYJtxXTYydFu2LJtwldpW2tL0yoQ5E9268tGxYIKy1XRlWkHJDB8jQoWANo6vwjowZRE0UMGQ
  Mics2jm2qOv1qtv+uTzP73ne555f8sMR4SJfjGsqrRqLiTJI+QmoVrLMl9dMFRVnnzwnIZuOB
  TBy8PYSSi61ngHk58dnMdLxsAMj7Z0RQM40DHELMJXXeRNTnekPc1WOU49Q1cpAkK9q7w6iqh
  /8h4v4H/D0JnV5ZQlPN3+zyux9ufKafY53FIwX1IF1uJB4DKDzt2frQEIULwHY7alGWWLjwh5
  bCLDkbwD7Jh/yGAKIswhcGHDFyRAKr3qHAEs6AHT8dS9GUKIPgW1r9Qgb4OJC/4NTGEtuARgJ
  +6IBOM4nZHCii2K6pBD5MPjLBT7jQYifAJwIdnMZIZnQwmMX5zDWpIPNdS6ExTtg4PcmlMlBi
  c3Q/mMKMxYQJbBmeDS+xkUuHHRfj3nWEbnwQmsG4wHEBvhg7PtYPEKI4MyiO4YhQUBPfwBhcS
  oMLzyK72kH8PbiJI8VcmGX3x83bYRTbgdg8iFRCMebCtmxDN5pvRLPLINj1ScAizNhz3QgPpf
  AtvoQ2gBynP+p4YwmIUQWbL+0hR1vgo2OEOaMbZYER79ZRJsB2ga2qy16rc5qpPQGuTI7W65U
  5shfkCu3kQrqE/l+RQUt11C0Va5UUIdoBV1l3G8oVZg01i4QPbJSM/ZtL6i5s6rwgTScK00V3
  B0qKhauV5eXVukoWldsqTBoaB9Ix3EpFEgmo1qSRaPVVB7QG6Kn+kSGeKI0RaBkZAFtpoy0Xs
  tKY+BFvCHsOo3g11c80e9V19nTiBA1lZs0YpFgL/OAYB7oKkxP454c/xTYKE4WAA6HI0w0ayx
  GvfX/+jIQ4UCaLBAyKYl6k/XpX5ejhbjRQuMFhUwhK/WvJD7Ktb1dj4/Vr3CuDK7md86MVO+5
  n3P3eLg2B//yV+wz12V0p4af33FDlPFFRF84O/3WWt6eEen844xGQ23ZwL1I7/NpO9r3OV/KE
  svW7F7eefVh7iDnwHfk9t2KE9rIoWuzaZ7XezfIM5PnioZPvsfpvOEs+SjQUi7ZF5K19KvDVc
  sF5yZsjbufyTvyqaSswzm/98PxBEUaiWE/9/UpW/KGebmh3q89BVuzYDpPlLprU2bzgMk38kq
  XW+v/Y/X9Vw/OXQq/+XFtzc6E6YNbmiNyfeZXm33rDTNLgan7RKfZePm87rmkdKFz1xtbj7jb
  SkffaVq4ta0nKCM55tf+lNhG3vXypCito5QyxEJT/wCwRc8bdwQAAA==
X-Env-Sender: ahuang12@lenovo.com
X-Msg-Ref: server-33.tower-406.messagelabs.com!1599132294!469490!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29815 invoked from network); 3 Sep 2020 11:24:56 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-33.tower-406.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Sep 2020 11:24:56 -0000
Received: from reswpmail01.lenovo.com (unknown [10.62.32.20])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Forcepoint Email with ESMTPS id 29B9AAB646C05F7B7034;
	Thu,  3 Sep 2020 19:24:51 +0800 (CST)
Received: from reswpmail04.lenovo.com (10.62.32.23) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5; Thu, 3 Sep 2020
 07:24:50 -0400
Received: from va32wusexedge01.lenovo.com (10.62.123.116) by
 reswpmail04.lenovo.com (10.62.32.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5
 via Frontend Transport; Thu, 3 Sep 2020 04:24:50 -0700
Received: from APC01-PU1-obe.outbound.protection.outlook.com (104.47.126.59)
 by mail.lenovo.com (10.62.123.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1913.5; Thu, 3 Sep 2020 19:24:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5VuZgryDhLDX1oOkYJun16Iv2cjaMrgGhXkGniKltylwI/nSiRAab39ZI8GI8sgnUNVDhSlOl58fIxjEF5K2/9h5EZ9HkBa0eUQTQsAx5j/4qLGCHnCr0Gas39kWOrNhh/Q3FbhvBKm8bJvum6TFTRGz3E4Ftp4bykqDP6DX9Bt/jxsG7iAB92vTT5sAC59zKOB6zAGwgcR4M0JL+aT9nrZgm3m90DlRkveBZo5KQrGZDbkJHu8Et0ad1oZFHu+5bcxdEtxRcyup6WDpMlgn2t2frJfxv/eXq3OF3fqvY6KTLtEII6OPb55P1sPlozKpO6MsJqiCbYDbd3DT14WxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnpUsNrnc/c4X6fDxbD9WIvofeLKr92GCYRu2x/d3/M=;
 b=HY2iCs+C9+UzPItn0gY+RAO9IaDIgWtfoFc3W/HeZui2H7v8kb5DVgKdvWJapUIrdRnmSI7B/T7A/V+iuRfcVLrtivBK8y2umITOcGkFf7hhym8XJ6NfyezFj42fz6whUaNssVPXeRiukJHVfwqc6bJUiiRN2bHYfnLmygfh60Ydp7uuW54KiERMnE54HoW7HKr8eY0Nd86b531dUbAIXeso5sK/A4O9y1oYk+CFe6eX3cGK0PV1RYg896clDGk1UKjxDc1OOoftjvapWSSDJ4CSkq/FC9oslaxvfViMcxGFyx2FQyWCW95FIo8AIxpsvl9bQ7ZLMdMHkqfd+0qQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnpUsNrnc/c4X6fDxbD9WIvofeLKr92GCYRu2x/d3/M=;
 b=x4T/ZoUHEx5c5VYaLaDEdEFWVHo5/DYuQ5gE7SytBh/b5zMdPOkumpHQTxCIUlDuZSxrrvPH2YsEXwnNqJZA97mbwkpWGn43oC+mg2L6RSnesF3dEuu7remRJr5ksKmD33XGqeTDYmpx+ZynMEjzLOM/l+1kB+oUryAATgdmeqU=
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com (2603:1096:202:c::8)
 by HK0PR03MB4674.apcprd03.prod.outlook.com (2603:1096:203:b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5; Thu, 3 Sep
 2020 11:24:47 +0000
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164]) by HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164%7]) with mapi id 15.20.3370.009; Thu, 3 Sep 2020
 11:24:47 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>
Subject: RE: [External]  Re: flood of "dm-X: error: dax access failed" due to
 5.9 commit 231609785cbfb
Thread-Topic: [External]  Re: flood of "dm-X: error: dax access failed" due to
 5.9 commit 231609785cbfb
Thread-Index: AQHWgbH62ZFAESTatkSmSEwLQTG/XqlWl28AgAAqtOA=
Date: Thu, 3 Sep 2020 11:24:47 +0000
Message-ID: <HK2PR0302MB259473EA0BD42B288413C45CB32C0@HK2PR0302MB2594.apcprd03.prod.outlook.com>
References: <20200902160432.GA5513@redhat.com>
 <df0203fa-7f75-53ac-8bf1-79a1c861918e@suse.de>
 <20200902164456.GA5928@redhat.com>
 <4968af50-663d-74cf-1be2-aaed48a380d5@suse.de>
 <20200902165101.GB5928@redhat.com>
 <c6636009-0bb9-ab2e-d453-992a2a53c6ef@suse.de>
 <eac2bcb8-93c7-ae47-c9e3-43c1ac074098@suse.de>
In-Reply-To: <eac2bcb8-93c7-ae47-c9e3-43c1ac074098@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:b011:e002:37e1:4c72:58e5:53e9:1b12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e040adb6-5525-4330-eed9-08d84ffbf741
x-ms-traffictypediagnostic: HK0PR03MB4674:
x-microsoft-antispam-prvs: <HK0PR03MB46744F196014AE51718FF65FB32C0@HK0PR03MB4674.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 95bcz0YHPnx6p2CL1BLgHu7A3ThRZhTHb8KzdldW0hDakWVBv80EF39Ts+GGpV9UvRJk3u/G1aYfynwVRg6IeDo35lSkX2wJ4KSdtefJsw3zxFPQys6Dblh3AVYGMs+tqhXYPdW/1ukY6NY1WHrV0k59O/fi/fDiZz95BOr5RQCodvuPb4/Wq4Ex9YmaJQVa5vlncdjxbnqdBZyvE3N13W/OliGBO0IdF1aNQ5pbR9fOYZ4dHirbyBYZ3vUO9RUxa5PdhQCzO56FyC0teDuFJFsJBzQ8hYSSx74tLg9XbRVoWPZhPbXnr3tLnLGF+JGiN+qU1F6xzSUM3aCP8qwVww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR0302MB2594.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(66946007)(2906002)(86362001)(9686003)(66556008)(316002)(110136005)(54906003)(7696005)(55016002)(66476007)(71200400001)(66446008)(64756008)(8676002)(76116006)(53546011)(4326008)(8936002)(186003)(52536014)(6506007)(83380400001)(5660300002)(478600001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4fiq2tD4I0d7K98XoGPPowbht97eA8gGCc205rU/vB4odDbXQsFXa3Vfc/zGpnfmmENN9s8/dOHRodOXaN/ZEvbqMODXiX7hP5kofQCl3F2B1tVW7gcjzyKHz6ANCTm0uuaK5dlp9YWHXI6TCiVjEJ5aytwQRKzoB99Iv8DAdYzXjlKD7afVL0dJOaQuuQE5z7I/5H36kQ5W5nTasr8D6zi0krO+yQReblzC+m4jP+QnF97HnjTxjITWsGQT8l6s8cH/QdHkX4OeBzx5o9rAtKVPN0yunEf94yDECtb9JOql+9LnGfBuCK0G5aKPjEubaGYEU9iDB0Fo5OGsZhKaARvE2ZQADf6OzOCQJBgKCfxnW1tINjKWFDZ3XH+gPIjbga825fQbCYvUrluodXqItwG7Luudb+ZiFYY08BUUPm6k9a6tjaq2ZDLkmBCFGnCgizFxWwcOqTeEFgAwdwdEo/WJGkXSolCPEvspzsxV6dKz0jTWeDlsl56uVu10sDTeyfNdc58UaWdlUNl5ku9oKHiZwkUXlc90UlDsSkzVfogVUQy2x7YG1FSUoQm5Zmx3cpqFTY8Ii35DE0lMEU9oWBX3GgaV75vmuabp5VV1oBrWGBQE30mcan06EFh9LJ8s89B/c/7M6yOkiB44nssm4GyToXxCVxDnsc+oAO04ttZC5epF390JOhiOuCs0QZceZ7nUgpLIVjnnb5r13WSTHg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR0302MB2594.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e040adb6-5525-4330-eed9-08d84ffbf741
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 11:24:47.5504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JL+Vq/Y8SUB1f9SXA744qDDN14JeRu/MEt9ACrVJjI9jvgldyXebdMT1cuc5rycSpZxhZlCJXbRue+NEv9wBYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB4674
X-OriginatorOrg: lenovo.com
Message-ID-Hash: OXZTTOGS2ZJK32CMEHW3JHHVT6T2GANE
X-Message-ID-Hash: OXZTTOGS2ZJK32CMEHW3JHHVT6T2GANE
X-MailFrom: ahuang12@lenovo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OXZTTOGS2ZJK32CMEHW3JHHVT6T2GANE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> -----Original Message-----
> From: Coly Li <colyli@suse.de>
> Sent: Thursday, September 3, 2020 4:37 PM
> To: Mike Snitzer <snitzer@redhat.com>
> Cc: Jan Kara <jack@suse.com>; Ira Weiny <ira.weiny@intel.com>; Pankaj Gupta
> <pankaj.gupta.linux@gmail.com>; Vishal Verma <vishal.l.verma@intel.com>;
> linux-nvdimm@lists.01.org; Adrian Huang12 <ahuang12@lenovo.com>
> Subject: [External] Re: flood of "dm-X: error: dax access failed" due to 5.9
> commit 231609785cbfb
> 
> On 2020/9/3 13:20, Coly Li wrote:
> > On 2020/9/3 00:51, Mike Snitzer wrote:
> >> On Wed, Sep 02 2020 at 12:46pm -0400, Coly Li <colyli@suse.de> wrote:
> >>
> >>> On 2020/9/3 00:44, Mike Snitzer wrote:
> >>>> On Wed, Sep 02 2020 at 12:40pm -0400, Coly Li <colyli@suse.de>
> >>>> wrote:
> >>>>
> >>>>> On 2020/9/3 00:04, Mike Snitzer wrote:
> >>>>>> 5.9 commit 231609785cbfb ("dax: print error message by pr_info()
> >>>>>> in
> >>>>>> __generic_fsdax_supported()") switched from pr_debug() to pr_info().
> >>>>>>
> >>>>>> The justification in the commit header is really inadequate.  If
> >>>>>> there is a problem that you need to drill in on, repeat the
> >>>>>> testing after enabling the dynamic debugging.
> >>>>>>
> >>>>>> Otherwise, now all DM devices that aren't layered on DAX capable
> >>>>>> devices spew really confusing noise to users when they simply
> >>>>>> activate their non-DAX DM devices:
> >>>>>>
> >>>>>> [66567.129798] dm-6: error: dax access failed (-5) [66567.134400]
> >>>>>> dm-6: error: dax access failed (-5) [66567.139152] dm-6: error:
> >>>>>> dax access failed (-5) [66567.314546] dm-2: error: dax access
> >>>>>> failed (-95) [66567.319380] dm-2: error: dax access failed (-95)
> >>>>>> [66567.324254] dm-2: error: dax access failed (-95)
> >>>>>> [66567.479025] dm-2: error: dax access failed (-95)
> >>>>>> [66567.483713] dm-2: error: dax access failed (-95)
> >>>>>> [66567.488722] dm-2: error: dax access failed (-95)
> >>>>>> [66567.494061] dm-2: error: dax access failed (-95)
> >>>>>> [66567.498823] dm-2: error: dax access failed (-95)
> >>>>>> [66567.503693] dm-2: error: dax access failed (-95)
> >>>>>>
> >>>>>> commit 231609785cbfb must be reverted.
> >>>>>>
> >>>>>> Please advise, thanks.
> >>>>>
> >>>>> Adrian Huang from Lenovo posted a patch, which titled: dax: do not
> >>>>> print error message for non-persistent memory block device
> >>>>>
> >>>>> It fixes the issue, but no response for now. Maybe we should take this fix.
> >>>>
> >>>> OK, yes sounds like it.  It was merged and is commit
> >>>> c2affe920b0e066
> >>>> ("dax: do not print error message for non-persistent memory block
> >>>> device")
> >>>
> >>> Thanks for informing me this patch is merged, I am going to update
> >>> my local one :-)
> >>
> >> So the thing is I'm running v5.9-rc3 (which includes this commit) but
> >> I'm still seeing all these warnings when I run the lvm2 testsuite.
> >> The reason _seems_ to be because the lvm2 testsuite uses brd devices
> >> for test devices.  So there is something about the brd device that
> >> shows commit c2affe920b0e066 isn't enough :(
> >
> > [Resend and CC Adrian Huang]
> >
> > Hi Mike,
> >
> > Could you please apply and test this attached patch based on v5.9-rc3 ?
> >
> > It seems the pointer dax_dev of __generic_fsdax_supported() parameter
> > is not initialized (IMHO this is not a dm bug), therefore the &&
> > should be
> > || to check the dax support state.
> >
> > Also I add two pr_info() to print the variables value, let's see
> > whether my guess makes sense.
> 
> Also I suggest some kind of change like this in drivers/md/dm.c,
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c index
> fb0255d25e4b..566d8208df47 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -818,6 +818,8 @@ int dm_get_table_device(struct mapped_device *md,
> dev_t dev, fmode_t mode,
>                         return -ENOMEM;
>                 }
> 
> +               memset(td, 0, sizeof(struct table_device));
> +

This does not help. See the following log.

-----------------
# lvm2-testsuite --only activate-minor
.......
[ 0:00] #activate-minor.sh:22+ aux prepare_vg 2
[ 0:00] ## preparing ramdisk device...ok (/dev/ram0)
[ 0:01] 6,3160,150710756,-;brd: module loaded
[ 0:01] ## preparing 2 devices...ok
[ 0:01] 6,3161,150730864,-;dax_dev: 0000000000000000
[ 0:01] 6,3162,150730866,-;bdev_dax_supported(): 0
[ 0:01] 6,3163,150730903,-;dax_dev: 0000000000000000
[ 0:01] 6,3164,150730905,-;bdev_dax_supported(): 0
[ 0:01] 6,3165,150731019,-;dax_dev: 0000000000000000
[ 0:01] 6,3166,150731020,-;bdev_dax_supported(): 0
[ 0:01] 6,3167,150731512,-;dax_dev: 0000000000000000
[ 0:01] 6,3168,150731514,-;bdev_dax_supported(): 0
[ 0:01] 6,3169,150731525,-;dax_dev: 0000000000000000
[ 0:01] 6,3170,150731525,-;bdev_dax_supported(): 0
[ 0:01] 6,3171,150731656,-;dax_dev: 0000000000000000
[ 0:01] 6,3172,150731657,-;bdev_dax_supported(): 0
.......
[ 0:01] lvchange $vg/foo -a y
[ 0:01] #activate-minor.sh:25+ lvchange LVMTEST12302vg/foo -a y
[ 0:01]   /tmp/LVMTEST12302.W0HGxyzxst/dev/mapper/LVMTEST12302vg-foo not set up by udev: Falling back to direct node creation.
[ 0:01] 6,3173,150927070,-;dax_dev: 00000000f0a5865d
[ 0:01] 6,3174,150927072,-;bdev_dax_supported(): 0
[ 0:01] 6,3175,150927081,-;dax_dev: 00000000f0a5865d
[ 0:01] 6,3176,150927082,-;bdev_dax_supported(): 0
[ 0:01] 6,3177,150927241,-;dax_dev: 00000000f0a5865d
[ 0:01] 6,3178,150927242,-;bdev_dax_supported(): 0
----------------

>                 td->dm_dev.mode = mode;
>                 td->dm_dev.bdev = NULL;
> 
> 
> The above change may make sure *dax_dev sent into
> __generic_fsdax_supported() is always NULL if the target does not support DAX.
> But IMHO this is not 100% necessary, it just make
> __generic_fsdax_supported() return false faster by the following change in
> previous attached patch,
> 
>  -       if (!dax_dev && !bdev_dax_supported(bdev, blocksize)) {
>  +       if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {
> 
> I am not very familiar with dm code, CMIIW, just for your information.
> 
> Coly Li

-- Adrian
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
