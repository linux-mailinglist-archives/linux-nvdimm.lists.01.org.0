Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED32197C10
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Mar 2020 14:37:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E5E1810FC3603;
	Mon, 30 Mar 2020 05:38:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.71.156.113; helo=esa15.sap.c3s2.iphmx.com; envelope-from=otto.bruggeman@sap.com; receiver=<UNKNOWN> 
Received: from esa15.sap.c3s2.iphmx.com (esa15.sap.c3s2.iphmx.com [216.71.156.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D66431003E998
	for <linux-nvdimm@lists.01.org>; Mon, 30 Mar 2020 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sap.com; i=@sap.com; q=dns/txt; s=it-20190212;
  t=1585571875; x=1617107875;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xI2QmtJ6ahGCuMNDE/cDAcs381emZebxgzjQlgSI8yI=;
  b=G1PdK5CHGXOsDRscMhLBoYQ0fz9wcF6ybwE1/tfdHVZZq+R5PSRmRF2u
   3NDodxIJtKs1h3VRwo3k5dgMUc7v1SpXwYfuToJ18sq43StN1MBVUv1Z6
   I5fAv7Kb9xOpgYYQl3Y5XkaCD7UpeNdmitEnExNMr+xGh9UzIv3NHZYJr
   YXG7yTfIQkiDVznnGXNRiERRjeqpsnyRKWr8zNlChDdHbdbQg7rpyKQi5
   eRn2Q/e/Cwifx8aq2wFYXTdaRKBeTUdR2ZgRfZgmN3sAdJahl9o5aNKij
   JVInLgY/bI5xqJ4ZrOQ6v64UI4f/Jl1mqrhNAjNMq2hG/a5e2wKFzPf8o
   w==;
IronPort-SDR: m+S6lToFIgBZ4TyKTwvpqjjdoTaHfZbe2T1Wi7AMO88ho4PNyzCcU2Tvns4I76G3NV6sDuRn+c
 9s2Z8p55MEhdJzAeyPTINznbEnNEMMgQBcdNTOcO+ajxqTyamKNLkRVGIkmX3/7+sFaeOjmXO1
 wkCWidaDXu1wBiU8QgKwMSxUA3GqfAbJyCrB/cOoCA1pCS6N7r+PU6+Djcrr2kSKg2xoZvlE+y
 X2pcWCpo5+cvgR+I9Fyjh6nRsStnBxhxSc1zQMk1pFJ0lTz27KQDPRIbEa7mLLYM0YuMt3hlJH
 KQnOpV8989DObbpDrKbGsr/L
X-Amp-Result: SKIPPED(no attachment in message)
Received: from smtpgw04.mail.net.sap (HELO smtpgw.sap-ag.de) ([155.56.66.99])
  by esa15.sap.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 30 Mar 2020 14:37:52 +0200
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.111)
 by smtpgw04.sap-ag.de (155.56.66.99) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 30 Mar 2020 14:37:51 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfHHwk2tzqfz812kCYx0dv5fa1sqagDP/Hbbko3Yw8O8eimsPcQctF9tRhG5LoL2Wj+dnuq77lJwRtoT/ClI06vBc/n8+pV6S6Jk91IiC6cbHeRxSD6p17F7dtNW1tmf8aAgmahCXEt8PWs4ujl1W0LStcLqeyfKOOtyMiRZ6LrCiIox3x9imvLCUFcVqbqAeDDLLxGtPt/YZNGvvOSiGQ+sgadvEk1mkvmuKWz3H/bnWpPsKFeoInSUtOykHEUhWD3ZWuBu6rBcSWxXbltejgj8TlygLHo1gWMZTfvWYqr90AJS4AU/m30lAjgtj3sfEU/pz9Aq7fLhBfgKqXE75w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI2QmtJ6ahGCuMNDE/cDAcs381emZebxgzjQlgSI8yI=;
 b=alz7RDKKIIUpmvmAJxU3hJCHh1OJ1Ud/sUxEuaAU/fJf7Q7U0xvobo4rQH5WHqHPSERijBHE3xYuxoX00WXzb5hkxCvQYOaVoGUTGyBzKjMGhL4QkadhTPZRG5c1Yju2OhwI6AZs6odKnqI+x3nfJ35eMQILjlMNV3DblhRt8js48q+ZkcG5CsO6RoM97FR6nxMQcLUKoiify4fwuu2jjvRL3crNqBhyM8IeSWw3na4BCwQWIUSN9YUC7heiYGZAgK/Bdl/tHXMu/X50H1Vfv0EhXn15MsrdkoQGu8EhegEFMTOe5pBOXVMckhDiicrfk4BtrsevSfu7AZAXhEOy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.onmicrosoft.com;
 s=selector2-sap-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI2QmtJ6ahGCuMNDE/cDAcs381emZebxgzjQlgSI8yI=;
 b=Srx08mfIx3H+kALUFqlxLL1ixzP4WoF+cIRym89o9cSikJ9BqkpVJ/RIzC4X65r5xHgjOqbr5vOqQslNyiI+u2EpKIcxatXIWAK16rH1/JvmpD2P5I2dFjR8M8lvrCrvtf3gstmwwqXoPkjJDJ0/g8vHSFUFLmghvi3wLPx+e28=
Received: from AM0PR02MB3842.eurprd02.prod.outlook.com (52.134.80.145) by
 AM0PR02MB3857.eurprd02.prod.outlook.com (52.134.85.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 12:37:50 +0000
Received: from AM0PR02MB3842.eurprd02.prod.outlook.com
 ([fe80::41a9:104d:1efe:6e2]) by AM0PR02MB3842.eurprd02.prod.outlook.com
 ([fe80::41a9:104d:1efe:6e2%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 12:37:49 +0000
From: "Bruggeman, Otto (external - Partner)" <otto.bruggeman@sap.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Mike Snitzer
	<msnitzer@redhat.com>
Subject: RE: Optane nvdimm performance
Thread-Topic: Optane nvdimm performance
Thread-Index: AQHWBghJaSj9hvr+Gk+/gQ/orgjnU6hhE9Ww
Date: Mon, 30 Mar 2020 12:37:48 +0000
Message-ID: <AM0PR02MB3842ACBE359003CFBF32B6C59BCB0@AM0PR02MB3842.eurprd02.prod.outlook.com>
References: <alpine.LRH.2.02.2003291116490.9236@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2003291116490.9236@file01.intranet.prod.int.rdu2.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.16.224.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9c6be91-3482-4ad8-ffc0-08d7d4a72825
x-ms-traffictypediagnostic: AM0PR02MB3857:
x-microsoft-antispam-prvs: <AM0PR02MB385709A4A3866763918AB85D9BCB0@AM0PR02MB3857.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB3842.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(71200400001)(8676002)(6506007)(81166006)(966005)(7116003)(81156014)(7696005)(9686003)(86362001)(53546011)(4326008)(478600001)(5660300002)(52536014)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(3480700007)(110136005)(55016002)(186003)(54906003)(33656002)(26005)(2906002)(8936002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DR72ItQJi8UD303jgSefcuWhZDSib5V879c2s441I95hzJWJWnFD+vf2QGd2yGWOmI+VeqM6U0OuDnKAn6KbdRvTP2ZS4jFIEijYULr7hPPpo2v01VTgK+VJ6ny8M6GN96/ZMLQZdZwUZ/7jNi8XzSR6GKCbxOEn4zWskkA/yav0pAkloN7jV+DvubiDesPrXHDaOfgBK5vUT4BrVsDN4t/ezkAHNgsPbetoWqZsVHfIismny8DFDeOEgBbOt2dqIJiGJ5ScKAbSRA+/xwlQcLiDJBhrynDgYK6u9k+MV2JyoCUrlkrUrUpOacR8eTF1y2SI5CZ/m7x/VDlI/QxGwh1DgfbBI6CVvDq6wjjb26TQiv2fatGpyk68XeB565pxYRgU41KZx7aaJC7O6TFYsMKxh/iiaEumrcLAiUGtf5YZqNrdQEpQCzZaULsKw2kk2OLS/qDSU4HGtOyxviM7xFaOPhml7YiJ2bXxNYxS6l6IQspQ6ANnmaPxxUddD83yXRVCQe8v85MqwtApr4v/2g==
x-ms-exchange-antispam-messagedata: sjhUiPecDBNbbbItQsxGbLDYCxfuCO6ik+pesY1b7XHSKQZMntAOgXUM46b3frogWuZc1XSNECfchcFgofUJkhy0rBHFY1J3efxL2GJVVcJyapkhwiNzFV/nKNNoWM0yQH79fTuYEjNuosIH/KZSow==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c6be91-3482-4ad8-ffc0-08d7d4a72825
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 12:37:49.3550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VpS8K+3rkro0+jJLrcLIvTe1YhD5eNZa8OdK8sDVbFX8KtXBQWXxQSdvI74y1tzPrp/zairaZNFVU7KvYl6jqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3857
Message-ID-Hash: GSRCPXDVOQUPUPTBFGQNSZOX3ZLEPVST
X-Message-ID-Hash: GSRCPXDVOQUPUPTBFGQNSZOX3ZLEPVST
X-MailFrom: otto.bruggeman@sap.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GSRCPXDVOQUPUPTBFGQNSZOX3ZLEPVST/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

FYI Mal sehen was da an antworten kommen...

-----Original Message-----
From: Mikulas Patocka <mpatocka@redhat.com> 
Sent: Sunday, March 29, 2020 10:26 PM
To: Dan Williams <dan.j.williams@intel.com>; Vishal Verma <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>; Ira Weiny <ira.weiny@intel.com>; Mike Snitzer <msnitzer@redhat.com>
Cc: linux-nvdimm@lists.01.org; dm-devel@redhat.com
Subject: Optane nvdimm performance

Hi

I performed some microbenchmarks on a system with real Optane-based nvdimm 
and I found out that the fastest method how to write to persistent memory 
is to fill a cacheline with 8 8-byte writes and then issue clwb or 
clflushopt on the cacheline. With this method, we can achieve 1.6 GB/s 
throughput for linear writes. On the other hand, non-temporal writes 
achieve only 1.3 GB/s.

The results are here:
http://people.redhat.com/~mpatocka/testcases/pmem/microbenchmarks/pmem.txt

The benchmarks here:
http://people.redhat.com/~mpatocka/testcases/pmem/microbenchmarks/

The winning benchmark is this:
http://people.redhat.com/~mpatocka/testcases/pmem/microbenchmarks/thrp-write-8-clwb.c


However, the kernel is not using this fastest method, it is using 
non-temporal stores instead.


I took the novafs filesystem (see git clone 
https://github.com/NVSL/linux-nova), it uses 
__copy_from_user_inatomic_nocache, which calls __copy_user_nocache which 
performs non-temporal stores. I hacked __copy_user_nocache to use clwb 
instead of non-temporal stores and it improved filesystem performance 
significantly.

This is the patch
http://people.redhat.com/~mpatocka/testcases/pmem/benchmarks/copy-nocache.patch 
(for the kernel 5.1 because novafs needs this version) and these are 
benchmark results:
http://people.redhat.com/~mpatocka/testcases/pmem/benchmarks/fs-bench.txt

- you can see that "test2" has twice the write throughput of "test1"


I took the dm-writecache driver, it uses memcpy_flushcache to write data 
to persistent memory. I hacked memcpy_flushcache to use clwb instead of 
non-temporal stores.

The result is - for 512-byte writes, non-temporal stores perform better 
than cache flushing. For 1024-byte and larger writes, cache flushing 
performs better than non-temporal stores. (I also tried to use cached 
writes + clwb for dm-writecache metadata updates, but it had bad 
performance)


Do you have some explanation why nontemporal stores are better for 
512-byte copies and worse for 1024-byte copies? (like filling up some 
buffers inside the CPU)?

In the next email, I'm sending a patch that makes memcpy_flushcache use 
clflushopt for transfers larger than 768 bytes.


Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
