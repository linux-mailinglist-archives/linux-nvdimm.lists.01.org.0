Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2215A1FC343
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Jun 2020 03:16:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 80BD910FC3712;
	Tue, 16 Jun 2020 18:15:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0ECAE10096677
	for <linux-nvdimm@lists.01.org>; Tue, 16 Jun 2020 18:15:57 -0700 (PDT)
IronPort-SDR: 4jfvw4o8EzhZth246wJ05wp+4aMVnO9NCiK0t8gkj8lG/rVdkXaOq6ILHZOq8g6Oh8DrwItUWC
 4sCH+iCRQutw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 18:15:57 -0700
IronPort-SDR: 6XKvzaYvZkI333oXkdm3hOvg/3mh1mkdI8t1JFwR+IThkr8Qo74Aa/qT+7pu8DQfZzsyk9L0pW
 8SkLJykiHnzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,520,1583222400";
   d="scan'208";a="351921126"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga001.jf.intel.com with ESMTP; 16 Jun 2020 18:15:57 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 18:15:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 18:15:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0KIGg9C6Kvuj+nxfr0pb7P183wPFJpXrfHGPf+ejWQ+ROdbxmeY8rW5YLAxhrNUxICei58Du5/yluMWItOpKr+XJFCaMeiKzwZc8GpL8vg5nRNJq5pnIJUclL6ikgt3VzFc8BIqEgUi3zk/EcF5IDoA4dlcbO/tNXCKM3mEG4dQpebForskuLCr7Xsof7Iq4rmh0VJte2aDMPxPzozki2EYYK7/UPOI8X11xYiGNl3jzpdm0w284OPna7Yzh0ytOQ4taqKFJQvbU+xLiZHVILZsMs0/Escx2zlFPvBRIdR7S+vzO2GVd4dkhiCMa3wUOxMzlMoCrc6kJe/QxItXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5790AA55H4JdUT+IE8gj9wzPQK0vInuHrn+T6DEaReo=;
 b=dfwmNFRmjLSIk+l58wY1/IFZQkmRuS1WjLcMOm9mLDHMPS7Gx/PMJmxTs39qp0aoT0PgEzeyCX5on1Sr12fi/oRzYKpBZQSbwp1ClPyTW7twnUNlq90m+GACSHLKKJtwbypj1reujvgtoMIh9a3/qM7gMU0ZH13EL2GprynJJlE8/461RlSGpCGLsOI+jwQ3zdkGthfnjqAvj0d254RnD/5ZgOzuGr8B7+q5RPDxKAV/9gKwlvniET5Y3nXx2ZMlnmkcGm3WSsFl0N+9gU5IQuMtPx6NtHk3SidOaJB0N61Ce6ZUWACHOKFudznrvAOCrMtBSb9x+qEzBAy5N05hDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5790AA55H4JdUT+IE8gj9wzPQK0vInuHrn+T6DEaReo=;
 b=CJmxwOE9C/oDiv0SBJhwjpblFwGFU4RJ9Dhgxiv81EzSmWsNRfpRg2R3nPOfG/oA3LGw+HvW8WSLiN6DMIa+mksdPnFB2nUAjCgT7kHaQjOHgt7QWCAiQQ2Ncw9EeitDl96gKJgIqmR6RsodxCjZXRHRXI3uNLrV60xdInEkBWY=
Received: from BN6PR11MB4132.namprd11.prod.outlook.com (2603:10b6:405:81::10)
 by BN6PR1101MB2164.namprd11.prod.outlook.com (2603:10b6:405:51::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Wed, 17 Jun
 2020 01:15:55 +0000
Received: from BN6PR11MB4132.namprd11.prod.outlook.com
 ([fe80::f1fa:3128:2198:e48d]) by BN6PR11MB4132.namprd11.prod.outlook.com
 ([fe80::f1fa:3128:2198:e48d%4]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 01:15:55 +0000
From: "Williams, Dan J" <dan.j.williams@intel.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
Thread-Topic: [GIT PULL] General notification queue and key notifications
Thread-Index: AQHWRETZu9Qa754vaUCnrXuOChkHiQ==
Date: Wed, 17 Jun 2020 01:15:55 +0000
Message-ID: <23219b787ed1c20a63017ab53839a0d1c794ec53.camel@intel.com>
References: <1503686.1591113304@warthog.procyon.org.uk>
In-Reply-To: <1503686.1591113304@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [192.55.52.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38604e8c-cc1b-4235-8c91-08d8125bfc0d
x-ms-traffictypediagnostic: BN6PR1101MB2164:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB21648E30E4F434A23B1306CAC69A0@BN6PR1101MB2164.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /44bpQ24wTp2xXq3O0++yewDsqklLahu6RyMUruMb0OFPyu6P0aquLD314x9gPq2Oo/pc4JMKfvcuE2IH34ZJBPbs9CAfvHrScYuxYeLH3Wa6yjjUhlkSLWECiJI1yehMQcC1YrckuqXggBxhPAtEFWGZDaws9KzykLoSbPeLBVefMHeUnDMjvE0TQmn0lFi0NR1J/mBN803HFlty55IdaFpQsn7n7Wxk20ruBqg/J3HfPxpEzPDflecVO2yHQ/BA/c4LAt1kHGB71BkSv2Sygc6cJbXNCmibT6Y5/xVWDQyCXcZ/DkjyLU6b1nFUBn8ZSPuElPaUywg8pvUkvNT6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(36756003)(6512007)(478600001)(4326008)(45080400002)(7416002)(91956017)(110136005)(8676002)(71200400001)(316002)(83380400001)(8936002)(54906003)(2616005)(86362001)(66946007)(66446008)(76116006)(66476007)(66556008)(64756008)(6486002)(6506007)(26005)(15650500001)(5660300002)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: v14VlWprYwg1XKo1s5Jr1maAI+RtSXlt4IntiDE4+MGCRU5ZQT40jW8irLK1b9H23t+ws/nrBNA6w2uiY+7oDJ+IlXHJL07mUtH1Tj+eilvBp0pawUvGwXp+v724F5Ee72lMJdJZCTbHozLAhz02lLGTP2wff66JNPfqGJhzgnxi8GnXB17FgwPoqZfqtUk/5GMaj1iwPmMnpaIYFwqPYrNmUpKaWR+9U9WaD9Ogs71VEQ9qVIcsp3kIx+x9uNy5U0qdVnnEnwbtm+F0hWW2YstWFi7Pd1Lw/CsauxazUQoTG10m3wrOGX2+v7Mgv9CHPs4Y/rQdyIPa9K+b3BBhEYLsa7VfsJQTyA3yU/KvnIoMzMX+yVD+iHqieLvBEVfrs4jy88rb/TUYG2u5AOYBgVs19M17SOOvo4q/1/9ivXlL4VzPR9fpdg0SaY76y+xWr4Gjgb4EsAu9kyPThvcafYHSHvEti5cipgF1ie/t/f8=
Content-ID: <4CECB5C7212778419344C3402AF6ECB4@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 38604e8c-cc1b-4235-8c91-08d8125bfc0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 01:15:55.1906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWZB+zGBKM3Grueufj7dIhI3cRzubqBXgb9EWN8fu5zTM8F3GatD6x+dvRHRBeECyGqmQ6EXn8v4lKEPbDJDpkqOnK/TumqRLS2xeGk0ODQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2164
X-OriginatorOrg: intel.com
Message-ID-Hash: 4PJ3EJM3XMYGUAJBATL6DFKY5TJRERAR
X-Message-ID-Hash: 4PJ3EJM3XMYGUAJBATL6DFKY5TJRERAR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "raven@themaw.net" <raven@themaw.net>, "kzak@redhat.com" <kzak@redhat.com>, "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dray@redhat.com" <dray@redhat.com>, "swhiteho@redhat.com" <swhiteho@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mszeredi@redhat.com" <mszeredi@redhat.com>, "jlayton@redhat.com" <jlayton@redhat.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "andres@anarazel.de" <andres@anarazel.de>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4PJ3EJM3XMYGUAJBATL6DFKY5TJRERAR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi David,

On Tue, 2020-06-02 at 16:55 +0100, David Howells wrote:
> Date: Tue, 02 Jun 2020 16:51:44 +0100
> 
> Hi Linus,
> 
> Can you pull this, please?  It adds a general notification queue
> concept
> and adds an event source for keys/keyrings, such as linking and
> unlinking
> keys and changing their attributes.
[..]

This commit:

>       keys: Make the KEY_NEED_* perms an enum rather than a mask

...upstream as:

    8c0637e950d6 keys: Make the KEY_NEED_* perms an enum rather than a mask

...triggers a regression in the libnvdimm unit test that exercises the
encrypted keys used to store nvdimm passphrases. It results in the
below warning.

---

WARNING: CPU: 15 PID: 6276 at security/keys/permission.c:35 key_task_permission+0xd3/0x140
Modules linked in: nd_blk(OE) nfit_test(OE) device_dax(OE) ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) kvm_intel(E) kvm(E) irqbypass(E) nd_pmem(OE) dax_pmem(OE) nd_btt(OE) dax_p
ct10dif_pclmul(E) nd_e820(OE) nfit(OE) crc32_pclmul(E) libnvdimm(OE) crc32c_intel(E) ghash_clmulni_intel(E) serio_raw(E) encrypted_keys(E) trusted(E) nfit_test_iomap(OE) tpm(E) drm(E)
CPU: 15 PID: 6276 Comm: lt-ndctl Tainted: G           OE     5.7.0-rc6+ #155
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
RIP: 0010:key_task_permission+0xd3/0x140
Code: c8 21 d9 39 d9 75 25 48 83 c4 08 4c 89 e6 48 89 ef 5b 5d 41 5c 41 5d e9 1b a7 00 00 bb 01 00 00 00 83 fa 01 0f 84 68 ff ff ff <0f> 0b 48 83 c4 08 b8 f3 ff ff ff 5b 5d 41 5c 41 5d c3 83 fa 06

RSP: 0018:ffffaddc42db7c90 EFLAGS: 00010297
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffaddc42db7c7c
RDX: 0000000000000000 RSI: ffff985e1c46e840 RDI: ffff985e3a03de01
RBP: ffff985e3a03de01 R08: 0000000000000000 R09: 5461e7bc000002a0
R10: 0000000000000004 R11: 0000000066666666 R12: ffff985e1c46e840
R13: 0000000000000000 R14: ffffaddc42db7cd8 R15: ffff985e248c6540
FS:  00007f863c18a780(0000) GS:ffff985e3bbc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006d3708 CR3: 0000000125a1e006 CR4: 0000000000160ee0
Call Trace:
 lookup_user_key+0xeb/0x6b0
 ? vsscanf+0x3df/0x840
 ? key_validate+0x50/0x50
 ? key_default_cmp+0x20/0x20
 nvdimm_get_user_key_payload.part.0+0x21/0x110 [libnvdimm]
 nvdimm_security_store+0x67d/0xb20 [libnvdimm]
 security_store+0x67/0x1a0 [libnvdimm]
 kernfs_fop_write+0xcf/0x1c0
 vfs_write+0xde/0x1d0
 ksys_write+0x68/0xe0
 do_syscall_64+0x5c/0xa0
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x7f863c624547
Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007ffd61d8f5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffd61d8f640 RCX: 00007f863c624547
RDX: 0000000000000014 RSI: 00007ffd61d8f640 RDI: 0000000000000005
RBP: 0000000000000005 R08: 0000000000000014 R09: 00007ffd61d8f4a0
R10: fffffffffffff455 R11: 0000000000000246 R12: 00000000006dbbf0
R13: 00000000006cd710 R14: 00007f863c18a6a8 R15: 00007ffd61d8fae0
irq event stamp: 36976
hardirqs last  enabled at (36975): [<ffffffff9131fa40>] __slab_alloc+0x70/0x90
hardirqs last disabled at (36976): [<ffffffff910049c7>] trace_hardirqs_off_thunk+0x1a/0x1c
softirqs last  enabled at (35474): [<ffffffff91e00357>] __do_softirq+0x357/0x466
softirqs last disabled at (35467): [<ffffffff910eae96>] irq_exit+0xe6/0xf0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
