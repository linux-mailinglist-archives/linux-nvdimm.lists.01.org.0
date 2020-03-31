Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A31988E8
	for <lists+linux-nvdimm@lfdr.de>; Tue, 31 Mar 2020 02:28:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A9BB810FC35A4;
	Mon, 30 Mar 2020 17:28:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.147.86; helo=mx0a-002e3701.pphosted.com; envelope-from=prvs=03591b7fa3=elliott@hpe.com; receiver=<UNKNOWN> 
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 611D910FC3192
	for <linux-nvdimm@lists.01.org>; Mon, 30 Mar 2020 17:28:54 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V0NKkx012711;
	Tue, 31 Mar 2020 00:28:04 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
	by mx0a-002e3701.pphosted.com with ESMTP id 303qjk9df1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2020 00:28:04 +0000
Received: from G9W8456.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.161.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t5009.houston.hpe.com (Postfix) with ESMTPS id 899E270;
	Tue, 31 Mar 2020 00:28:03 +0000 (UTC)
Received: from G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) by
 G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 31 Mar 2020 00:28:03 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W8454.americas.hpqcorp.net (16.216.161.4) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 31 Mar 2020 00:28:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oevEkno+XK3XJ7w/pi7ZaFjWwUrJtD1A97awpwNk/uN2J2y5gs40SZEwkCd4eAZpYDCoShOHHiCnkxwmFSaFcJHAQc+CDVJFIxoONTBJOtDVr9SORQZUH2bC6pYFQwQ35+UpOG9gKXtX34qnxBMrNUrQSWpXE2dTmwO/dGlBnCnepEMKhUfq232exDW/gw05tJzISKTddX5742+AFNLVXfzYquBOezR528TbDvzcWQA1SG7IBEL/e7B+0OowX1gIgvEWPI5uRrNfsOROFmFWCc20cldS+eEecqv7SnUjbA6gRGDJfuFMr/A8Batk2zltdywa+Pj5t8Y/2bQGI+2JpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI6n+BX3RcEDHP6qKjzBAC5STXNbndYnJBlC+9jGfIg=;
 b=Nhg/rfBzW+IHs/+g4t2uFLa1hcnVyRus3E0VBuhRVPP8rGRdVq48S13zMsNLOIvjTGm7S+GmmoHWEdfhNXe/Q4Cp9Bryh8hJ/7VYawBE3NxSbH/ylJ5i2rY95Ozo1M62V//n/ecNC+pa6Lw6/7eSkMbI7JuK2pKlylXcKno+PPWdlcz4JnbaAcDj3I2LGMRGWlvF6Df5NDF0mcm440C/fjFR386OGDX/2cnD/RgaVuDKRHp10ih5+7Z1MZWM2zWa75JuL4zZzoyzZYu9VmxxM3LCmhURFBQFxHcRtJhuS2X2bY3UrEL3I3QXFY+4iXf+WcRR/9fE7DQSk6egcbkJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7514::15) by CS1PR8401MB0519.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7509::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 00:28:01 +0000
Received: from CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6023:914f:6cca:4c98]) by CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6023:914f:6cca:4c98%7]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 00:28:01 +0000
From: "Elliott, Robert (Servers)" <elliott@hpe.com>
To: Mikulas Patocka <mpatocka@redhat.com>,
        Dan Williams
	<dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Mike Snitzer
	<msnitzer@redhat.com>
Subject: RE: [PATCH v2] memcpy_flushcache: use cache flusing for larger
 lengths
Thread-Topic: [PATCH v2] memcpy_flushcache: use cache flusing for larger
 lengths
Thread-Index: AQHWBob+0rIHl10OXEaKSzaWD6MWpKhh0ScQ
Date: Tue, 31 Mar 2020 00:28:01 +0000
Message-ID: <CS1PR8401MB12377197482867F688BF93F7ABC80@CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM>
References: <alpine.LRH.2.02.2003291625590.32108@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2003300729320.9938@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2003300729320.9938@file01.intranet.prod.int.rdu2.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.206.28.217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 487cec50-a767-46f6-87fd-08d7d50a5ee6
x-ms-traffictypediagnostic: CS1PR8401MB0519:
x-microsoft-antispam-prvs: <CS1PR8401MB0519F05506A9C9E69E24D4B6ABC80@CS1PR8401MB0519.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:473;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB1237.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(346002)(376002)(396003)(39860400002)(366004)(55016002)(81166006)(8676002)(81156014)(53546011)(54906003)(316002)(110136005)(7696005)(6506007)(66946007)(71200400001)(66446008)(86362001)(8936002)(33656002)(9686003)(186003)(478600001)(26005)(76116006)(4326008)(2906002)(64756008)(66476007)(52536014)(5660300002)(66556008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JTiLml9JUPekVlsBCXfsfTKyJvTNiV1dZsrkQ1Un/YlbvqvfipcZkX+LNrVVo8xVIp3b3/egS5ou5oA1oVs08NkpeDRQ/PaKsCQuIghIz0tq6pDCp0uHI0xR9+U5GEi+F5l4yY6wsryGkUC+j7KzNiNO7VYLaQCvwvbx8jHL/26De1gvP+RsH67OZaQDwr/l68EBQ2vcDDRT4CliIyP6TTJ7/Ay+1mzMXOEiGjkmfGoaXV1bYNb40szvwQ0pcUDXHxdx49eT9z0r5udsrcWo67+lSzrb4csDz6KtZedb+9jYBDqQsyqvmTeoJFpnhxnAYw4cajs4IJf2Tsu1saisq+c3sKvFgXPdiDaYAZeW2OqMsNkTj/S5tscethihpCdxUBC/eNaBMY0dC2VAJiGWH3oiYS+EzUV23GzR8XXRv/N13v6kApw6k8PdtYtXBc9O
x-ms-exchange-antispam-messagedata: YY8r65q0WyiPF93UJ3S4KRMPdfw+50yiJdr4o79W84aztSzvBEJNAefDIwnPkpark8tFhqZxqNaQSPTkpsB22ZyAlGC9s7whF6RFtMhZ1gGfK4UMJPciju7rFICfrgVhvQePDSEBcZvro0AV2iU2Rw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 487cec50-a767-46f6-87fd-08d7d50a5ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 00:28:01.3750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZ3oXsVHYr/mCTYfW567NqKUugVjIu6HmfzIQdRVGILcGow4hZXCtKY6BpHJRPef
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0519
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_07:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310000
Message-ID-Hash: XNV6A2JKANROO5COLVRKO5XXGL5WJPN7
X-Message-ID-Hash: XNV6A2JKANROO5COLVRKO5XXGL5WJPN7
X-MailFrom: prvs=03591b7fa3=elliott@hpe.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XNV6A2JKANROO5COLVRKO5XXGL5WJPN7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Mikulas Patocka <mpatocka@redhat.com>
> Sent: Monday, March 30, 2020 6:32 AM
> To: Dan Williams <dan.j.williams@intel.com>; Vishal Verma
> <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>; Ira
> Weiny <ira.weiny@intel.com>; Mike Snitzer <msnitzer@redhat.com>
> Cc: linux-nvdimm@lists.01.org; dm-devel@redhat.com
> Subject: [PATCH v2] memcpy_flushcache: use cache flusing for larger
> lengths
> 
> I tested dm-writecache performance on a machine with Optane nvdimm
> and it turned out that for larger writes, cached stores + cache
> flushing perform better than non-temporal stores. This is the
> throughput of dm- writecache measured with this command:
> dd if=/dev/zero of=/dev/mapper/wc bs=64 oflag=direct
> 
> block size	512		1024		2048		4096
> movnti	496 MB/s	642 MB/s	725 MB/s	744 MB/s
> clflushopt	373 MB/s	688 MB/s	1.1 GB/s	1.2 GB/s
> 
> We can see that for smaller block, movnti performs better, but for
> larger blocks, clflushopt has better performance.

There are other interactions to consider... see threads from the last
few years on the linux-nvdimm list.

For example, software generally expects that read()s take a long time and
avoids re-reading from disk; the normal pattern is to hold the data in
memory and read it from there. By using normal stores, CPU caches end up
holding a bunch of persistent memory data that is probably not going to
be read again any time soon, bumping out more useful data. In contrast,
movnti avoids filling the CPU caches.

Another option is the AVX vmovntdq instruction (if available), the
most recent of which does 64-byte (cache line) sized transfers to
zmm registers. There's a hefty context switching overhead (e.g.,
304 clocks), and the CPU often runs AVX instructions at a slower
clock frequency, so it's hard to judge when it's worthwhile.

In user space, glibc faces similar choices for its memcpy() functions;
glibc memcpy() uses non-temporal stores for transfers > 75% of the
L3 cache size divided by the number of cores. For example, with
glibc-2.216-16.fc27 (August 2017), on a Broadwell system with
E5-2699 36 cores 45 MiB L3 cache, non-temporal stores are used
for memcpy()s over 36 MiB.

It'd be nice if glibc, PMDK, and the kernel used the same algorithms.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
