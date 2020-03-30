Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B32A7197FFE
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Mar 2020 17:43:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D97B710FC36C4;
	Mon, 30 Mar 2020 08:43:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.159.191; helo=esa3.sap.c3s2.iphmx.com; envelope-from=otto.bruggeman@sap.com; receiver=<UNKNOWN> 
Received: from esa3.sap.c3s2.iphmx.com (esa3.sap.c3s2.iphmx.com [68.232.159.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CE43910FC336D
	for <linux-nvdimm@lists.01.org>; Mon, 30 Mar 2020 08:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sap.com; i=@sap.com; q=dns/txt; s=it-20190212;
  t=1585582979; x=1617118979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qdgro3q/g+hr8uuz/HHucDQ7NFQMtnt12UPmJ7fTwV8=;
  b=dWiFg8njAVdTzbaLBcIBRhWiMzCNHyOBLgZIYefFGzJ2tyJYmIcepkV8
   MDY7dQ775fZuqZ+2braukPY3ZfHIuP7J8rGRTiVD7rHDLwmc9tNi5iLMf
   nQqQ9AlXvhc7UKLG10fj9V0tIjGepib1xewwc4OWspttPFCEIDrRmNFex
   N7/DFlOfPsb6K0C+n70HfvLCrcYAmLEyFLuBZd/CEjTg3MWz1XsQZ7+1q
   kolB1fnjThZg98rE9Pcm2loCrhDdASEjX0EOdS+XVijMdRGMGi3in9R3+
   jawPSArX3qldO8vx44u5e1DtBqixxBtQTI6EIvFG1TPd/PHoBu3dRD+u0
   Q==;
IronPort-SDR: eoGEuhOLQKvtRGdSZgHMw9qvadvEYggMWRzOdmRoTgURdxvixmyf6MZo01ocyCZv6BbuTV0Idy
 doZd9psvsk3AkHGVYqfzGppdJ29S7gRQcKOxYmTFTXnEwg7QCcE2j8nSJG7zu9G69XSuHFyliy
 Ob1QM4e2ufErpM9Hko4QJ4C59xVsscFPFwUYLjEkU0U6ABt5BnukHEr7OC1p1xFk2PrD2EQ9hT
 /pqYw4WUNGKOkFTQYD8mBmX82HJ2H+02BjZuY0z6cavrvSeDObrgv1Fbab/7bSzv0SHugJIYUI
 v6oB+Jqlh4MuRpeI/s1iL3ZS
X-Amp-Result: SKIPPED(no attachment in message)
Received: from smtpgw02.mail.net.sap (HELO smtpgw.sap-ag.de) ([155.56.66.97])
  by esa3.sap.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 30 Mar 2020 17:42:56 +0200
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.174)
 by smtpgw02.sap-ag.de (155.56.66.97) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 30 Mar 2020 17:42:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKR8OT730gdL2DBfeaFYSjxPGKWSXjGmB3GF3lwKcjB5KGmQ1o/UPM+cPgU8dsQVe8yX5dNG5/iwT0uGw2fzi/QCfgsrJqcRzbzY2wmugPAF1GieXvGCmkr3hLk/Apq7YXceun4rXEG0KenXU0q4n+GGXpRnFRKaRNabYAgoUCIO8XJOGib5rSlfRRxhVQr6XzjQ9GIYDsHChHhdvSHfoefIIjq+aeJ9txlaDVAiiPSz4e+DZp+Jh6Kf/0JsM5CNmoPhgZ+vLyQPbJL5WtdBeN8CvQa2JAa8aO0XgYEioJGaXruMbwrEVVsjBI1l05i0FR0AUe0kJAZX1hydoOur6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdgro3q/g+hr8uuz/HHucDQ7NFQMtnt12UPmJ7fTwV8=;
 b=ThISMAouTQNgy/C/kat/yJtINxyyHSFTNENT+xs7c8hSr/O1iHMDDMUwD2e6qxZONcLnEEtkC5RfB/1kab+THamm9+gi0fiB3ihi21k+8s6iwrFCsxfIScEQs6jxM2WshOwuUFw0hXkx9ihCYIe/jE+P/CSWz1t3KmRiyJBihDYNh+xfV2caLXTuhPODCdG4SPI4Il9V9WPeMHPJrC+0ss39bs9NyxyahoCa4yQMiifXUFleIsSdYNFVQlW51L5Djo7/prJXf8zm2bCwNFjqE9vAq05bbk4HbeZutYkloMexnkbCZskH6TrHT1aEgQEn+Ygver/5DCT+CnHO7AYq5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.onmicrosoft.com;
 s=selector2-sap-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdgro3q/g+hr8uuz/HHucDQ7NFQMtnt12UPmJ7fTwV8=;
 b=TBFJEZbgt/Lnk2XYFhYIc0VeJ/9tsE47fdoiL4g2Og2Izz0UH/slKOj1ySydxPT21FeHp0IdTEaUmU59KWYmusO7YtYbrkpZbhDb+6GBv14LyFU70hfcM2NfxuF5S3zkV4C3jNuI5qx3C+KXIca09yKOkRVYzqT0Zm3VE6yirvs=
Received: from AM0PR02MB3842.eurprd02.prod.outlook.com (52.134.80.145) by
 AM0PR02MB5555.eurprd02.prod.outlook.com (20.179.39.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Mon, 30 Mar 2020 15:42:53 +0000
Received: from AM0PR02MB3842.eurprd02.prod.outlook.com
 ([fe80::41a9:104d:1efe:6e2]) by AM0PR02MB3842.eurprd02.prod.outlook.com
 ([fe80::41a9:104d:1efe:6e2%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 15:42:53 +0000
From: "Bruggeman, Otto (external - Partner)" <otto.bruggeman@sap.com>
To: "Bruggeman, Otto (external - Partner)" <otto.bruggeman@sap.com>, "Mikulas
 Patocka" <mpatocka@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Mike Snitzer <msnitzer@redhat.com>
Subject: RE: Optane nvdimm performance
Thread-Topic: Optane nvdimm performance
Thread-Index: AQHWBghJaSj9hvr+Gk+/gQ/orgjnU6hhE9WwgAAzhyA=
Date: Mon, 30 Mar 2020 15:42:52 +0000
Message-ID: <AM0PR02MB38422D6FEBB0D5FB3D23167A9BCB0@AM0PR02MB3842.eurprd02.prod.outlook.com>
References: <alpine.LRH.2.02.2003291116490.9236@file01.intranet.prod.int.rdu2.redhat.com>
 <AM0PR02MB3842ACBE359003CFBF32B6C59BCB0@AM0PR02MB3842.eurprd02.prod.outlook.com>
In-Reply-To: <AM0PR02MB3842ACBE359003CFBF32B6C59BCB0@AM0PR02MB3842.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.16.224.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c8d3b87-7d93-4f26-1096-08d7d4c1027e
x-ms-traffictypediagnostic: AM0PR02MB5555:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR02MB555520B5A0A306790DEBC23B9BCB0@AM0PR02MB5555.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB3842.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(66946007)(186003)(316002)(2940100002)(71200400001)(7116003)(54906003)(3480700007)(966005)(55016002)(110136005)(8936002)(26005)(8676002)(81166006)(2906002)(81156014)(9686003)(86362001)(76116006)(5660300002)(4326008)(66476007)(7696005)(52536014)(33656002)(64756008)(478600001)(6506007)(66556008)(66446008)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E6jCVVk1EcgNV0kXv3iFrlBAPYNnutuXAP2bTH1sBdRyheO0ym1vBGoD71zNudp/LzlmLsMbV6xhIcLpfvpqg5lXzYkzjnXxwreJy6UVUbS8b0k4YK1ExERvBjtSlDLhLijxCHMsYcnlgIUqp5bbvTUHEI0GMTIOXLMJgGjE89o95f7vvmBp6bRub1LgM12/slq7zARSbamgjs1E+I8PhALeb77zN7dwcVTe+Qh4DnLfWnWa/meQvyAGYGrW+zf7ktwhPLPvnEEvQCD/vf8l7A0NNxKK4iOvqSUl+DqH9RI7HlEPX/aYugkl+vvtvCimzxeidrCvAjPu2x1RaCSXez7NmTraq62vRquAWwyn+GD3HByLTBcBF+9YwTu9S4GI6KW/aSl+8UAQWiEWAanC1fPzQy3xFs5zpjnPRnihngMhbr7RvSsNIKTtbTLMyweXDF7n+j8h5ovJbiC8bWFUKxj6wpDuwDkfLx7z28Vw/GGQ089l7bKwCa0BdB6wEMbzV6DTgLhZ4p5qdIozmqIBcA==
x-ms-exchange-antispam-messagedata: 2O8aVlgZBtMl7Y0q8jYX/OJbL2yUcRt0eMBRGxrY7yPf4G0zUS97HOetQ4xpPuTvp8kbxTO5Hch4NlZPXxF0gJgNThqqrXA43oFb1eEowRqXnsOjkPPTooNmiEv4zbEct2X7faIoLav9dncLPphhSQ==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8d3b87-7d93-4f26-1096-08d7d4c1027e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 15:42:52.4061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zkKUOuXpRtA7gS/b3T513qRV+cDqHGpN0tyBbxXCzTQyMhxGzPPXKx9yw8D7mvAFX/RBq5MyRVErVsZ1eItsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5555
Message-ID-Hash: ACQ7J7PMBAFJ6SUXVECLZLVQNFAUYIPG
X-Message-ID-Hash: ACQ7J7PMBAFJ6SUXVECLZLVQNFAUYIPG
X-MailFrom: otto.bruggeman@sap.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ACQ7J7PMBAFJ6SUXVECLZLVQNFAUYIPG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

My apologies, I meant to forward this mail and managed to press the wrong button...

-----Original Message-----
From: Bruggeman, Otto (external - Partner) <otto.bruggeman@sap.com> 
Sent: Monday, March 30, 2020 2:38 PM
To: Mikulas Patocka <mpatocka@redhat.com>; Dan Williams <dan.j.williams@intel.com>; Vishal Verma <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>; Ira Weiny <ira.weiny@intel.com>; Mike Snitzer <msnitzer@redhat.com>
Cc: linux-nvdimm@lists.01.org; dm-devel@redhat.com
Subject: [CAUTION] RE: Optane nvdimm performance

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
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
