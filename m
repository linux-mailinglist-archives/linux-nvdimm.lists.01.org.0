Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 723462DC936
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 23:48:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A8DD9100EBBD1;
	Wed, 16 Dec 2020 14:48:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0C4AB100EBBC0
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 14:48:46 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMidi6066031;
	Wed, 16 Dec 2020 22:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=v5mC41TeMQn3EHuqHj4vvF4bmWfIxznvhnKtWkXIopE=;
 b=kYx1vnQwt2ZTxEHdRR0W4m3c2SHx17p/DpuMXEIawVWlunYaAUy91EE3V3Bz/k0+8rxr
 DiWoP1f/2A2xl4MkaQNyqmdFFbutUIzdnOwj4scJollYQkhkkKB8N5pH7Wc03FX91JOj
 RsQ+/A+O8j5CM3FZsv0zk2T2BfyEPAxqoX9whyz39TT3zwltCYi/RH5Mcoa0k4vnyvfs
 xR7Nohkb5B7Sae4zMxJrt1hcI19NCWPdCqMQQHNJ/a6SVrBrk13bRF6HKPSYOXGvIk4E
 pE3jmgl94Au2SwJ0E7TcB6vjhWqYAOhtT3hkpx3qZUR6wcitzq/u5Bq0tEJKL89XS9MG iQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 35cn9rjtr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Dec 2020 22:48:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMjFjw089732;
	Wed, 16 Dec 2020 22:48:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 35e6jte3ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Dec 2020 22:48:44 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BGMmhQv003048;
	Wed, 16 Dec 2020 22:48:43 GMT
Received: from paddy.uk.oracle.com (/10.175.172.71)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 16 Dec 2020 14:48:42 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH daxctl v2 0/5] daxctl: device align support
Date: Wed, 16 Dec 2020 22:48:28 +0000
Message-Id: <20201216224833.6229-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160141
Message-ID-Hash: WB75ESTSIYOBIUWG2AULREWBRSZZ5EYC
X-Message-ID-Hash: WB75ESTSIYOBIUWG2AULREWBRSZZ5EYC
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WB75ESTSIYOBIUWG2AULREWBRSZZ5EYC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hey,

This series adds support for:

 1) {create,reconfigure}-device for selecting @align (hugepage size).
 Here we add a '-a|--align 4K|2M|1G' option to the existing commands;

 2) Listing now displays align (if supported).

Testing requires a 5.10+ kernel. 

v1 -> v2:
  * Fix listing of dax devices on kernels that don't support align;
  * Adds a unit test for align;
  * Remove the mapping part to a later series;

Joao Martins (5):
  daxctl: add daxctl_dev_{get,set}_align()
  util/json: Print device align
  daxctl: add align support in reconfigure-device
  daxctl: add align support in create-device
  daxctl/test: Add a test for daxctl-create with align

 Documentation/daxctl/daxctl-create-device.txt      |  8 +++++
 Documentation/daxctl/daxctl-reconfigure-device.txt | 12 ++++++++
 daxctl/device.c                                    | 32 ++++++++++++++++---
 daxctl/lib/libdaxctl-private.h                     |  1 +
 daxctl/lib/libdaxctl.c                             | 36 ++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym                           |  2 ++
 daxctl/libdaxctl.h                                 |  2 ++
 test/daxctl-create.sh                              | 29 +++++++++++++++++
 util/json.c                                        |  9 +++++-
 9 files changed, 125 insertions(+), 6 deletions(-)

-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
