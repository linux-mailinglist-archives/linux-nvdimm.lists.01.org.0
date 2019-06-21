Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 891DF4EE44
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Jun 2019 19:59:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ECE3A2129F114;
	Fri, 21 Jun 2019 10:59:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Softfail (domain owner discourages use of this host)
 identity=mailfrom; client-ip=218.102.23.34; helo=yobosm01.netvigator.com;
 envelope-from=wetzbx@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from yobosm01.netvigator.com (yobosm01.netvigator.com
 [218.102.23.34]) by ml01.01.org (Postfix) with ESMTP id D1B482129F114
 for <linux-nvdimm@lists.01.org>; Fri, 21 Jun 2019 10:59:31 -0700 (PDT)
Received: from wironout4a.netvigator.com (wironout4a.netvigator.com
 [219.76.94.38])
 by yobosm01.netvigator.com (8.14.5/8.14.5) with ESMTP id x5LHxIqM024606
 for <linux-nvdimm@lists.01.org>; Sat, 22 Jun 2019 01:59:30 +0800
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0D+/wAHGg1d/5cXxstkGgEBAQEBHwIBA?=
 =?us-ascii?q?QEBAwEBAQGBRQQBAQEBAwEBgSwCAQEBAQEBAYEIXjQgEiiEFoh7jByJRYVcgzK?=
 =?us-ascii?q?GAxOBZwkBAQETKAIBAYFLgSgGhCMnOgQNAQMBAQQEAQVtijcMQgEBAQECAQYEh?=
 =?us-ascii?q?G4bGAgjDjgDAQc3AiMCDAEBDQEBHQEHCwgUAQSEIkkBAQIcBqB2h0mBFAUBFw2?=
 =?us-ascii?q?DeQGBMBGBaQoZBAoZDWKBQ4EyAgEBAQEBAQEBAYtsgX+EIz6CGkcFgSsBEgGDK?=
 =?us-ascii?q?YJYBIR4iB4CgS6EXYFWgxuBW49SPwkCO4FXgWyOB4NuG49NDhpNhwSNJYkajmu?=
 =?us-ascii?q?BDAYYZ3FwFWyBHIEfghgBhiGIEwE7OjMBYxAEgSCBbINQhgOCQwEB?=
X-IPAS-Result: =?us-ascii?q?A0D+/wAHGg1d/5cXxstkGgEBAQEBHwIBAQEBAwEBAQGBRQQ?=
 =?us-ascii?q?BAQEBAwEBgSwCAQEBAQEBAYEIXjQgEiiEFoh7jByJRYVcgzKGAxOBZwkBAQETK?=
 =?us-ascii?q?AIBAYFLgSgGhCMnOgQNAQMBAQQEAQVtijcMQgEBAQECAQYEhG4bGAgjDjgDAQc?=
 =?us-ascii?q?3AiMCDAEBDQEBHQEHCwgUAQSEIkkBAQIcBqB2h0mBFAUBFw2DeQGBMBGBaQoZB?=
 =?us-ascii?q?AoZDWKBQ4EyAgEBAQEBAQEBAYtsgX+EIz6CGkcFgSsBEgGDKYJYBIR4iB4CgS6?=
 =?us-ascii?q?EXYFWgxuBW49SPwkCO4FXgWyOB4NuG49NDhpNhwSNJYkajmuBDAYYZ3FwFWyBH?=
 =?us-ascii?q?IEfghgBhiGIEwE7OjMBYxAEgSCBbINQhgOCQwEB?=
X-IronPort-AV: E=Sophos;i="5.63,401,1557158400"; 
 d="scan'208,217";a="271723967"
Received: from yckviprion01-02smtp.netvigator.com (HELO
 yironoah01.netvigator.com) ([203.198.23.151])
 by wironout4.netvigator.com with ESMTP; 22 Jun 2019 01:59:30 +0800
Received: from localhost (HELO 5.101.65.69) ([27.76.88.171])
 by yironoah01.netvigator.com with ESMTP; 22 Jun 2019 01:59:22 +0800
Message-ID: <8cde9b090229fc0f2cd244171cc8f854779280ade2@gmail.com>
From: "Theophil" <wetzbx@gmail.com>
To: "ofono" <ofono@ofono.org>, "orienta" <orienta@crp-01.org.br>,
 "linux-nvdimm" <linux-nvdimm@lists.01.org>, "mail" <mail@schouw.org>,
 "natascha.vandenende" <natascha.vandenende@apsbb.com>,
 "lkp" <lkp@lists.01.org>,
 "recruitmentinhouse.tilburg" <recruitmentinhouse.tilburg@olympia.nl>,
 "mbonckus" <mbonckus@hobij.nl>,
 "intel-sgx-kernel-dev" <intel-sgx-kernel-dev@lists.01.org>,
 "fol57.rigo" <fol57.rigo@gmail.com>, "linux-nfc" <linux-nfc@lists.01.org>,
 "intel-vaapi-media" <intel-vaapi-media@lists.01.org>,
 "crva" <crva@ligue54.org>, "tpm2" <tpm2@lists.01.org>,
 "chipsec" <chipsec@lists.01.org>
Subject: Re:(62)  Unique on-line business...
Date: Fri, 21 Jun 2019 21:59:27 +0400
Organization: Theophil
MIME-Version: 1.0
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Reply-To: Theophil <mcglnrvvz@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

To unsubscribe send us an email with the topic 'unsubscribe' [jzlxe]
Selling a unique on-line business [unnrvyw] 
Databases, software, training 3-4 days [huvxvgo] 
Earnings from $3000 per month 7753191 [unlkprt] 
Contact: email.business.group@gmail.com[niietu] 
7753191 [oprvrx] 
[pcolo]  
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
