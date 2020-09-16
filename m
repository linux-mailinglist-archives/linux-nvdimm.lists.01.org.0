Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFA126BD99
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 09:02:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F057C14343F09;
	Wed, 16 Sep 2020 00:02:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.219.250.4; helo=mail1.bemta24.messagelabs.com; envelope-from=ahuang12@lenovo.com; receiver=<UNKNOWN> 
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com [67.219.250.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E74D313D9A80D
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 00:02:23 -0700 (PDT)
Received: from [100.112.129.88] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
	by server-4.bemta.az-a.us-west-2.aws.symcld.net id A6/16-25315-C78B16F5; Wed, 16 Sep 2020 07:02:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTbVBUZRTmvffu3rvI2nVZ4MRo6U6YUrvDLla
  r/sgcP3ZKRhtKpybFS1zYpWWB3UUWMoFIClcNZkpi+XDVgNBk+ZJYcBiFhAA1ItHQytkBChYI
  lA8zG2jvXqT6c+c553nOc85551wKl5SQwRRrMbNGA6OXCX0J7bBrifxgIxMVVn8jQP1Fbg+pd
  nS14+qCrO9JdVFBNqbOzr9DqvM/6cPUOTUzaBOpcdp+ITXWojlCM9HSJ9RctX9Lauq6398leF
  ugM0QnWvYLtEMXf8WSJucwS3/hAywT3byHHUEiSkJnYmBtlh1Bvh7sRnBs9iG+SLQ53uSJRwg
  c07dILkB0GQ4nOq4jPmgnwO0ox/mgGoH1rykvQ9DNOFQedWG8QSkGFz48LOSDAQROZ4UnoCgh
  HQrXahmuo5TeCu6vfvNqcLoNQXZLA8kR/jQDH/14GeNF0fDnjTGCq5XSKqju13Npgg6B/na7g
  MNiej/M915CnERCx8GR0m1cWkSvg7riQa8jogPhQdfXXkecDoLbgye9GGgpuH7oFvI4AEYG5g
  T8ZjkI2usfCXhiI1RMfrcgWgG9J62IxxFQcWd0QRMKc9d6MG4GoN+Dw7PpfDoEMrsdC72egrP
  HXEQeUtr+MwaPtVBQ/jNu826zDDoLBwk+/zzYm+8LefwclJ8a9WgoD94MtnIRD9fA35Vrbd43
  dCAoGmlHvHwVfGZ1kXYkOoteijbq4rTmBEanlyvDwuRKpUquVK2Xh4crmHQ5o0gxyVNZk1muU
  jCpJoUpLeFdfYzCwJprkec6Y5KyVjWintFJRSt6ksJkAeLk80yUZGl0YkyaljFpo4wpetbUip
  ZTlAzEbzR4uGVGNo61xOr0nht/TAPlJ5OKZzlabEpiEky6OJ7qQuupvJGS0zjlvFLq+f7x8Mx
  pXEIYEg1scJC45RtPAc0VaFMMi3aP/5petCLYX4x8fHwkfkmsMUFn/j/vRkEUkvmLjZyLn85g
  XuzquXzPLlKxUOQdyMz8SwVnYsUjU/NVFyXH91QWLE3eTRzPCvKRbtN3PNHXVrZv9Y4XVGina
  lO8YetP7uSw2pvXlzfgv0cOvnUvduiDaHnYqM1l+XR47919jSdmsguFTaUTBxK6ujM3D7+O5U
  1PDI1lbOnT3q/evaUkI/T8VM187vYqMnLcl9TrB27Xp1euPkTEFxvOtQpjjzJp7shLgRsH6sq
  eTptMjNm55wp7l8npO3NrreXlZ4q1qi9dnbrLefYDZRJcp1tpPfjazOgFZ2Gz8tz4mL8/+LU2
  rVn3akQ8a3slMB+PaCKuVn18SpT6zpLBHS/q86BDEdIp+3xv/fjKDT7PdoXH7nIKDmXUbLBrp
  ivDc20ywqRllKG40cT8A4SO2ZuwBAAA
X-Env-Sender: ahuang12@lenovo.com
X-Msg-Ref: server-8.tower-326.messagelabs.com!1600239738!40866!1
X-Originating-IP: [104.232.225.11]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12304 invoked from network); 16 Sep 2020 07:02:19 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.11)
  by server-8.tower-326.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Sep 2020 07:02:19 -0000
Received: from HKGWPEMAIL04.lenovo.com (unknown [10.128.3.72])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Forcepoint Email with ESMTPS id E31B0C789C03C9D4C266;
	Wed, 16 Sep 2020 03:02:16 -0400 (EDT)
Received: from HKGWPEMAIL01.lenovo.com (10.128.3.69) by
 HKGWPEMAIL04.lenovo.com (10.128.3.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Wed, 16 Sep 2020 15:02:14 +0800
Received: from HKEXEDGE02.lenovo.com (10.128.62.72) by HKGWPEMAIL01.lenovo.com
 (10.128.3.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4 via Frontend
 Transport; Wed, 16 Sep 2020 15:02:14 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (104.47.126.59)
 by mail.lenovo.com (10.128.62.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Wed, 16 Sep
 2020 15:02:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REDwDh21uf4Kq92I1BPAFkoGwYYQeCQaaxFFDUp/PL0+bJlqf+lC3+nvkJ3i3j6hABGLDqmqx9Q82l1GWS/QjjAk/VMZQRtLq86bvr4UiLu03b3LtrA2jcolwTy4DBjje1Rh0TWd1tTCclrQVrHNYAhgxtKYNJaDT6p5w/wGVaeI6HdVwIj5AHiGtD4FrS7C/vl4854bx3N77fD4n5UzzR3fl9mtOpoKK/PRxwyVObBodVHXCecwWrqSiccoxD1WKmuVdl9Q6mkdk0BeY+4OKi1DTDEY8NBjn/nPRoeaYW4n24k+RF6yeXT3v2l0oSq1cZOiZphZSyFwluJtBM/W3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO86RQkQ7fuw3po8/0nHDniY1yI1lvF+EtAJeKFc9P0=;
 b=lHmrTfGdmLA8IVOEvYwFFo1HD2v8Gc04Ejh904UZ1xuEkjJPACO+DxgwuRzqkOTBifb91xZtODul8kjh4Uld1HDU4GFkVcpBVZRHVkyE1KfldtY8eVkGXgkdu/Wf9Bdw9Ugs0VKj9PRkCqFi+QaTNd094rZE/5DAE6NFyW/kIUSmcJ8HRTRBDSg8Opr/4m+62dhnObf5cVG+zZZosUubF64gB2FFW8ylLHJQf43VbPU39k/Le1MCfZ+wT9sEw+krtkPQkW/3K/zTkCtLw86amzXLdVlUKz4F3TxeTyApBJ+RlgKvOUnkdXbDcuFnQJWuYevuQc9iqr3vGCv9YknfAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO86RQkQ7fuw3po8/0nHDniY1yI1lvF+EtAJeKFc9P0=;
 b=xGcU1LnSVbLNyZqYcK5wMRcfGPc/lvMnaI9dc6QHWf8shXpH6vW9bsV9CSjA/EM8VEJYJHsbdpO+CGrzBOh2oH90DUcN6/5jcqayqxsLwanlWr82RQRhNVG1h2G9TQepZeS4jqQYgC0W1GZ5h6ag2aCIdaNqa0akD3jEH1Od2NM=
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com (2603:1096:202:c::8)
 by HK0PR03MB3444.apcprd03.prod.outlook.com (2603:1096:203:53::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.8; Wed, 16 Sep
 2020 07:02:12 +0000
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164]) by HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164%7]) with mapi id 15.20.3391.009; Wed, 16 Sep 2020
 07:02:12 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: Jan Kara <jack@suse.cz>, Adrian Huang <adrianhuang0701@gmail.com>
Subject: RE: [External]  Re: [PATCH 1/1] dax: Fix stack overflow when mounting
 fsdax pmem device
Thread-Topic: [External]  Re: [PATCH 1/1] dax: Fix stack overflow when
 mounting fsdax pmem device
Thread-Index: AQHWizuEGtYqjFvsA02CyQO+yS/hlKlqxvZg
Date: Wed, 16 Sep 2020 07:02:12 +0000
Message-ID: <HK2PR0302MB25945D758119BECF62C7DC73B3210@HK2PR0302MB2594.apcprd03.prod.outlook.com>
References: <20200915075729.12518-1-adrianhuang0701@gmail.com>
 <20200915083716.GA29863@quack2.suse.cz>
In-Reply-To: <20200915083716.GA29863@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:b011:e002:f5de:1462:81a7:657b:8410]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f5951db-c495-4c74-7bf0-08d85a0e6ff3
x-ms-traffictypediagnostic: HK0PR03MB3444:
x-microsoft-antispam-prvs: <HK0PR03MB3444212182F5635C9FFA2027B3210@HK0PR03MB3444.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:324;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SR3SN3cGq4TCGZxH0CWaP97eSd+yeu136lY1lVU4t3jbUqHRLZNmj+EXglw0xSlFTXkJk6wXpvCSU00RV3zpmm8u+9ViixJ5h36rFh8Qh447Bbw/rKQNT1hvazpkwXGqDqrKLTVc8gbg5jK7Ja0No3OMhPmdog1Hc6pMI+4GZW35Xn77FjGkBpeYxYmpd9wKVidwsURxgh1A5JRQWwaEf9y9nssKf/I6c7Z6oQgCVeVtdp70ePqp3XbUgM6pu7Kct4gjmJzWombkqf6O5iA87jSRzYdVhdu8RNiZI8RJ6OSkYuDyfdmMWcb174HSGPKO3CTHoycVfZnCEZr9/tPh0Z0UtvyOaS93uZ0owywyQYnZ3Q6rdWs6sOL7ej/hbddpyeIg/XT2xotuBgWOpszoM2HnKq1+ACO7fPbUXjawFtM911Brbx9CrqZRr7yT6fk/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR0302MB2594.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(5660300002)(8676002)(99936003)(54906003)(4326008)(9686003)(76116006)(66616009)(186003)(6506007)(66476007)(66556008)(64756008)(66446008)(66946007)(52536014)(110136005)(316002)(7696005)(478600001)(2906002)(55016002)(8936002)(71200400001)(33656002)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: EvLyLPJT/y6Sy4wHxiL8A1hgepbcSbL4a7VQGuRzxr0eYXLTXS1tjltIZ+YAMw4OAdpDLt8qv/6mR2JkULdbEehEwMAYp5SDbDkqtL3rZdjseBFs4SO26Ci0Rb8zqbCk4Yv4EyiyiVc+VQCfIjsQKEwA6CETsvvAvx/oq5IDMo5EcnCdiFGETaRIBfQmNaSjcENxwwAyMRCPqzk0DHgXpNgUECMArrUi8L8catrpZct7ruPq+7H+x97+10QhNgOPegAtJZ117ENl+A7umgXRPIbTRTSJwmWJ8oOg8D579cj5p1BjeOlZXZjUeW4Z7JVTT8uiNpLoFG/VeC6ysW5JulUHh5c6bCoJnaNTV0qicy/TUqcmLn67UneuMzuSYke7HrdHBvVAkjyK8t5Ut9OFywGLuq2orvmcbuIeFTdv07vuU9+khQizZLZPzCFjVYNSbLFD651+edgSEMNhupN5dFyZyR+FwX+RRNa+ss5hwk/kYK/0kGNeGQhk0e/nXGicGIJZ6W4skD6fYNA1NTgN7yq8aFVNMVO4puwwMo8EvqUkxgKP3rbU6E/sMLNg7CFGEydpqYkuTPkw3u+dx1SPLKhrFhS3a229dWffGW1wJ0MA7CF7jFzKrxcfscl47P38VJIWIXHlJ0PyF24jwUJd0iEVtVwPP2EdV/wbKjRkRqgOM28iD1C7gy4d5l1MODr133D6GJFWc/hcZdTgnFUq0g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR0302MB2594.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5951db-c495-4c74-7bf0-08d85a0e6ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 07:02:12.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hwx0D5NGY+0pIKZ1YGUmGxowJP35lC2VWpS4BrdfJ8ImYFZaltNPLDtu9IJFXgjercalNcZv3V4Pkz+2QvhlDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3444
X-OriginatorOrg: lenovo.com
Message-ID-Hash: MDXWQ36FCXJXM7TFHEKKDSWDF4CSO72P
X-Message-ID-Hash: MDXWQ36FCXJXM7TFHEKKDSWDF4CSO72P
X-MailFrom: ahuang12@lenovo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="us-ascii"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MDXWQ36FCXJXM7TFHEKKDSWDF4CSO72P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Jan Kara <jack@suse.cz>
> 
> I'm not sure how you can get __generic_fsdax_supported() called for dm-0?
> Possibly because there's another dm device stacked on top of it and
> dm_table_supports_dax() calls generic_fsdax_supported()? That actually seems
> to be a bug in dm_table_supports_dax() (device_supports_dax() in particular).
> I'd think it should be calling dax_supported() instead of
> generic_fsdax_supported() so that proper device callback gets called when
> determining whether a device supports DAX or not.
> 

Yes, you're right. There's another dm device stacked on top of it. 

When applying the following patch and running 'lvm2-testsuite --only activate-minor.sh', the following error messages are observed.

dm-3: error: dax access failed (-95)
dm-3: error: dax access failed (-95)
dm-3: error: dax access failed (-95)

The commands 'lvchange $vg/foo -My --major=255 --minor=123' and 'lvchange $vg/foo -a y' in activate-minor.sh (https://fossies.org/linux/LVM2/test/shell/activate-minor.sh) create another dm device (dm-123) on top of dm-3. Please see the following command output.

# ls -l /dev/mapper
total 0
lrwxrwxrwx. 1 root root       7 Sep 16 02:12 LVMTEST14781pv1 -> ../dm-3
lrwxrwxrwx. 1 root root       9 Sep 16 02:12 LVMTEST14781vg-foo -> ../dm-123
crw-------.      1 root root      10, 236 Sep 16 01:41 control
lrwxrwxrwx. 1 root root       7 Sep 16 01:41 rhel-home -> ../dm-2
lrwxrwxrwx. 1 root root       7 Sep 16 01:41 rhel-root -> ../dm-0
lrwxrwxrwx. 1 root root       7 Sep 16 01:41 rhel-swap -> ../dm-1

# ls -l /dev/dm*
brw-rw----. 1 root disk 253,   0 Sep 16 01:41 /dev/dm-0
brw-rw----. 1 root disk 253,   1 Sep 16 01:41 /dev/dm-1
brw-rw----. 1 root disk 253, 123 Sep 16 02:12 /dev/dm-123
brw-rw----. 1 root disk 253,   2 Sep 16 01:41 /dev/dm-2
brw-rw----. 1 root disk 253,   3 Sep 16 02:12 /dev/dm-3

# dmsetup table
rhel-home: 0 344326144 linear 8:19 16345088
LVMTEST14781vg-foo: 0 1024 linear 253:3 2048
rhel-swap: 0 16343040 linear 8:19 2048
rhel-root: 0 104857600 linear 8:19 360671232
LVMTEST14781pv1: 0 69632 linear 1:0 0

I also use trace-cmd tool (command: trace-cmd record -p function -l '*dax*'  -l '*dm_*' -l 'linear_*')  to record the whole call path:
   dm_get_md_type
   dm_table_supports_dax
      linear_iterate_devices
      device_supports_dax
         __generic_fsdax_supported (dax_dev is valid for dm-3)
            dm_dax_direct_access
               dax_get_private
               dm_dax_get_live_target
               dm_table_find_target
               linear_dax_direct_access
                  bdev_dax_pgoff
                  dax_direct_access (dax_dev is NULL for physical device. Return -EOPNOTSUPP)
            dm_dax_direct_access
               dax_get_private
               dm_dax_get_live_target
               dm_table_find_target
               linear_dax_direct_access
                  bdev_dax_pgoff
                  dax_direct_access (dax_dev is NULL for physical device. Return -EOPNOTSUPP)

Please find the attachment for the full log. You can see three dm_table_supports_dax() calls in the attachment, which aligns with the dmesg output (three dax error messages). 

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e5767c83ea23..11d0541e6f8f 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -85,6 +85,12 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
                return false;
        }

+       if (!dax_dev) {
+               pr_debug("%s: error: dax unsupported by block device\n",
+                               bdevname(bdev, buf));
+               return false;
+       }
+
        err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
        if (err) {
                pr_info("%s: error: unaligned partition for dax\n",
@@ -100,12 +106,6 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
                return false;
        }

-       if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {
-               pr_debug("%s: error: dax unsupported by block device\n",
-                               bdevname(bdev, buf));
-               return false;
-       }
-
        id = dax_read_lock();
        len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
        len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);

-- Adrian
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
