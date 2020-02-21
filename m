Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF01167AAB
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Feb 2020 11:21:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E43D910FC3628;
	Fri, 21 Feb 2020 02:22:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.159.247; helo=esa10.fujitsucc.c3s2.iphmx.com; envelope-from=qi.fuli@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DA7E710FC3621
	for <linux-nvdimm@lists.01.org>; Fri, 21 Feb 2020 02:22:35 -0800 (PST)
IronPort-SDR: PJRqTS5vDMxpGRC1FP1Nf/0viH6tU/x4E8E24pUfxQqMl8d7iUjg1Sy0T0B1ueP1iWNf51n6p+
 Q7F32Ktp8lAtMk1jp73HA5AG2GlJdrs8jx5x3+txY+RNkxQ9ZCyYSLSyAckAByhCisSnFwY03W
 qa91eMOkLLsiRcePQzqfiCRM65dKcjK3sMFBL8gIgNDBejEuCOfBaylSC1GDIlGoCz0Ekn4vHO
 4Hz508QaQsAHLLPokSyW8/h5lqOfJxuO4goF0LXwJuhiv4D6P4sqVJarlAXlrbfdQ8W6yNcduY
 sLg=
X-IronPort-AV: E=McAfee;i="6000,8403,9537"; a="10552295"
X-IronPort-AV: E=Sophos;i="5.70,467,1574089200";
   d="scan'208";a="10552295"
Received: from mail-ty1jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 19:21:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHpjjl6u/u2Woox9UguDCQp/OwSNKnXwpcGMo3cKma164scQxCXqgKvkNVznQ3QPP+MJSf8PR1fibXOACTzER1qHp+czWLRu7NentqVF7S3UZKgxG+rILBgAGwut+H/5LxYf9mP72UcDXNiuI9cRXmwxZHeZ4NGsBa9WOhZ/VjzpfuWoac904MPmXLi3F3zPMM45/0li4+ZoHJZhhqX/9uSba0AC1wGb2a4nYopWpRjrqLc6x6syLgO7DL7ZV5JOGJX5DRGshzMH2BgQrh1rBmzYVE1SfXIFJGj11reAUBdZxM/gDv4GiwTVGSTdIDQ1tQ8FhVFSZ6RY1llHRij73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4Ma0HzHRFsAXrbqofA8PaJZBRL2tkN60l/bpwJXmqQ=;
 b=lw9IP7qfEhqSHh9K1w4d+XP6zLQdtHd12w7GH0vki1oSNSGwZy4lwaTBEknVdaFdDwCNNZuuPidVPjBY/JmvplgqQvxYINShOg+1dYkita8VZh5wfDhRirDVX6iUTeG2BuoDv5Duujg1gY98dTUMM79pgLsbT3SoSttg3x0W7xJohFWVC4yr4luePahoVEln5/Iychug0/TinMqbuTdvuMQ5EuNq0ZpLgyQw26M1xSBm64iqbuy3Q6ZoKoZm8xZy9823xhs/iEnsGGVLSSvlo6mk59YEcw7D4kxHC560D11BMFUQ5ezUM62jBU0QK4q8JS0h5Mh9LvyNcqG5NhqbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4Ma0HzHRFsAXrbqofA8PaJZBRL2tkN60l/bpwJXmqQ=;
 b=PCWFzLKd22KzjKQj9itjXKs0kX/1EH2Ya+lerkYyqiB6uZ5t/JEHAmCxMDfhmI/R2ciicrCVT6chLwQViqXybilrYn+BZX5/bhItt/On8AGOdd9hAGudNFlmJj3tNpfFu7D1PLgQvIVHUfU1+BrVKKPOHzv04MPlxVXfgAVzPGM=
Received: from OSBPR01MB3653.jpnprd01.prod.outlook.com (20.178.97.18) by
 OSBSPR01MB0015.jpnprd01.prod.outlook.com (20.178.5.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Fri, 21 Feb 2020 10:21:38 +0000
Received: from OSBPR01MB3653.jpnprd01.prod.outlook.com
 ([fe80::a063:b84c:9d97:44ad]) by OSBPR01MB3653.jpnprd01.prod.outlook.com
 ([fe80::a063:b84c:9d97:44ad%5]) with mapi id 15.20.2750.016; Fri, 21 Feb 2020
 10:21:38 +0000
From: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] ndctl/list: Drop named list objects from verbose
 listing
Thread-Topic: [ndctl PATCH] ndctl/list: Drop named list objects from verbose
 listing
Thread-Index: 
 AQHVpL2ZHqoUlCPxu0a5lVQlwFkJY6gjUl9tgAABZYCAAAMq5oAAC2SAgAATDICAAAIAgIAABU+AgAJ7PYA=
Date: Fri, 21 Feb 2020 10:21:38 +0000
Message-ID: <149112cd-0ae4-02b8-84ba-f13cce5aa45d@jp.fujitsu.com>
References: 
 <157481532698.2805671.8095763752180655226.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49sgj6law0.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4ibE3ssieq=A5diqwRyiT6e3X=kcpQ3aA0vYneBpuSCAA@mail.gmail.com>
 <x49k14ila4r.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4hHU+RC6TZW94UrjFJZ1fsOU8Nug0GP+Mb5mBGW8qk+UQ@mail.gmail.com>
 <03b5da834f0be8bc7110c459f3172732b96e85fa.camel@intel.com>
 <CAPcyv4gVDEum7RiSMXug5fwNC04mEHo5MhAuUW37t4tN9y899A@mail.gmail.com>
 <00abe72085e75c1c54b87635c81352b628211707.camel@intel.com>
In-Reply-To: <00abe72085e75c1c54b87635c81352b628211707.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qi.fuli@fujitsu.com;
x-originating-ip: [180.43.167.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cf60f33-bacf-4ac4-fde9-08d7b6b7d642
x-ms-traffictypediagnostic: OSBSPR01MB0015:
x-microsoft-antispam-prvs: 
 <OSBSPR01MB0015862E60FAA7E30A6F9EFBF7120@OSBSPR01MB0015.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: 
 SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(6506007)(53546011)(6486002)(26005)(6512007)(186003)(31696002)(66446008)(64756008)(66556008)(66476007)(66946007)(86362001)(76116006)(85182001)(110136005)(5660300002)(316002)(2906002)(81156014)(81166006)(8676002)(478600001)(8936002)(4326008)(31686004)(71200400001)(777600001);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBSPR01MB0015;H:OSBPR01MB3653.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 p6X3i2yoAImXnV43QwkKWwchDs/jDh8yZYskZkyge932DJLdh0+U8kCU5E+zKK/Okk1gpMU0YDFnwqzKJWWL+x1qaRHGq+RluLg8pAfFBXtWSp4f9b45FovDSoNGiXuHh7JTZFxFD+9tYjBOBqU9NRTMynzZByeZ4B/hOkjmcuraBibpRD3blsz/fyMJV5llY1Uovxqa+2Ut/hrOW+HMfTusghH0fN66AGaTd7yLVzzzm/fqMsCR6FVjXso30tOeD3E9EOQWGvRoCBpGZRrRY09Q8B2ua9VHjNWCrpO16PWpzYcOUp9KAmaBO2W7xfG6LOrlrpzB9kaxulhxXgp+PM/VKO5jU26QpjE4+f88GBOqD8bGNQ5d8gy1Z6zWg8DFh+ToY6DPs6aQkONKC3JrWEht00jNCFz+eVzwGX66NP1RZ+VE1kwIS8TPRbJL5vC/e4vKI1mYpnTGf1+EUhQW9/Tyn7qFMNPlFTX+6x4uVPk6sW/nC6brMq/n4G/241bs
x-ms-exchange-antispam-messagedata: 
 vC3UrB6rlwREMCLG1DMMKkyUEIiB6bGXuVMyO3aZMLfqBiAxdseR/JDmru4ub9rHQLWogptXIqz32d1ueiwuKLY4spGkMrj0g7fFvvlaaFh8OIv+4TGy7etA54930V2nl9372Yk5N88uOJixC6EpnA==
x-ms-exchange-transport-forked: True
Content-ID: <E2E4D3D0C255134F918E463C8160A79F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf60f33-bacf-4ac4-fde9-08d7b6b7d642
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 10:21:38.5779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZ6pfNYDOgUmcA1rTWzKs6sN46HZeDIqzXUmp4ddFNijHhtbkZ+kueS5UKEIQZvq0dJcfwY8ZOi5KbdEwGHIrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBSPR01MB0015
Message-ID-Hash: XW33Q7BHEJ455AUKWLTICPJBUDYZYPM3
X-Message-ID-Hash: XW33Q7BHEJ455AUKWLTICPJBUDYZYPM3
X-MailFrom: qi.fuli@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XW33Q7BHEJ455AUKWLTICPJBUDYZYPM3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 2/20/20 5:28 AM, Verma, Vishal L wrote:
> On Wed, 2020-02-19 at 12:09 -0800, Dan Williams wrote:
>>>>
>>>> Let's do a compromise, because users also hate nonsensical legacy that
>>>> they can't avoid. How about an environment variable,
>>>> "NDCTL_LIST_LINT", that users can set to opt into the latest /
>>>> cleanest output format with the understanding that the clean up may
>>>> regress scripts that were dependent on the old bugs.
>>>>
>>> Hm, this sounds good in concept, but how about waiting for this cleanup
>>> to go in after the (yes, long pending) config rework. Then this can just
>>> be a global config setting, and we won't have config things coming from
>>> the environment as well (which this would be a first of).
>>
>> That does make some sense, but I notice that git deals with "cosmetic"
>> environment variables (GIT_EDITOR, GIT_PAGER, etc) in addition to its
>> config file. So if we're borrowing from git, I'd also borrow that
>> config vs environment logic.
> 
> True, that's reasonable. I guess I was hoping to avoid, if we can,
> suddenly having a multitude of config sources, but env variables are
> pretty standard and it should be fine to add them.

Hi,

I am sorry for suspending the ndctl global config patch for such a long 
time. If it is not urgent, I would like to implement it.

Thank you.
QI fuli

> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
