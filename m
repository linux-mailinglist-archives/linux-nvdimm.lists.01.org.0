Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9122719DFFB
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 22:59:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5AA9E10FC51C4;
	Fri,  3 Apr 2020 14:00:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CD33810FC51C1
	for <linux-nvdimm@lists.01.org>; Fri,  3 Apr 2020 14:00:01 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033KhftB120801;
	Fri, 3 Apr 2020 20:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=Dr6RRctD8Ky3/yr1APYq4BSOssO4ZSbS1p6KK94a9kY=;
 b=PniJ6AkB0ao/PjLXZKx9ch4k2d/ohtud8Ham2QFnWsibfAyFYPBSWzv5ohYv7vB4wMFi
 7au1w4v6U3jdelESdFHei8tqGTNrcFAvJcAZ4rvfsR/wkpxvvM7j8t088j6t4RK7C6Fe
 4GHX/UwU1GSoSpPsBDTftOx8a4nwRuhtzP7pTg/w3wLBgHC8WxW/QmZi6E7tCnrwPgz3
 lEOcXXqHwrXKOTW+bj14lDEsv/mFP+Aq5kK90LrzeU7krZrbv7H7M28cPM6g5K33yY5Z
 s+Zb2fuXIixfGedqPJe4hExm+1KuIPkLL1LEyw8q5hefmwYy9outcQKaQ5Ex1XLvMiyI 5Q==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2120.oracle.com with ESMTP id 303yunnsk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 20:59:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033KgEVD047424;
	Fri, 3 Apr 2020 20:59:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3020.oracle.com with ESMTP id 302ga5v01k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 20:59:09 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 033Kx8GU017731;
	Fri, 3 Apr 2020 20:59:08 GMT
Received: from paddy.uk.oracle.com (/10.175.206.152)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 03 Apr 2020 13:59:07 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v1 00/10] daxctl: Support for sub-dividing soft-reserved regions
Date: Fri,  3 Apr 2020 21:58:50 +0100
Message-Id: <20200403205900.18035-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
Message-ID-Hash: 7YU7EL4UN4YTMJ2AJRKRQAWIJT563HA4
X-Message-ID-Hash: 7YU7EL4UN4YTMJ2AJRKRQAWIJT563HA4
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7YU7EL4UN4YTMJ2AJRKRQAWIJT563HA4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hey,

This series introduces the daxctl support for sub-dividing soft-reserved 
regions created by EFI/HMAT/efi_fake_mem. It's the userspace counterpart
of this recent patch series [0].

These new 'dynamic' regions can be partitioned into multiple different devices
which its subdivisions can consist of one or more ranges. This
is in contrast to static dax regions -- created with ndctl-create-namespace
 -m devdax -- which can't be subdivided neither discontiguous. 
 See also cover-letter of [0].

The daxctl changes in these patches are depicted as:

 * {create,destroy,disable,enable}-device:
   
   These orchestrate/manage the sub-division devices.
   It mimmics the same as namespaces equivalent commands.

 * Allow reconfigure-device to change the size of an existing *dynamic* dax
 device.

 * Add test coverage (so far tried to cover all range allocation code paths,
 but I am still fishing for bugs). Additionally, there are bugs so applying 
 [0] may not make it pass the added functional test yet.

I am sending the series earlier (i.e. before the kernel patches get merged)
mainly to share a common unit tests, and also letting others try it out.

The only TODOs left is documentation, and perhaps listing of the mappingX sysfs
entries.

Thoughts, comments appreciated. :)

Thanks!
 Joao

[0] "device-dax: Support sub-dividing soft-reserved ranges",
https://lore.kernel.org/linux-nvdimm/158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com/

Dan Williams (1):
  daxctl: Cleanup whitespace

Joao Martins (9):
  libdaxctl: add daxctl_dev_set_size()
  daxctl: add resize support in reconfigure-device
  daxctl: add command to disable devdax device
  daxctl: add command to enable devdax device
  libdaxctl: add daxctl_region_create_dev()
  daxctl: add command to create device
  libdaxctl: add daxctl_region_destroy_dev()
  daxctl: add command to destroy device
  daxctl/test: Add tests for dynamic dax regions

 daxctl/builtin.h         |   4 +
 daxctl/daxctl.c          |   4 +
 daxctl/device.c          | 310 ++++++++++++++++++++++++++++++++++++++-
 daxctl/lib/libdaxctl.c   |  67 +++++++++
 daxctl/lib/libdaxctl.sym |   7 +
 daxctl/libdaxctl.h       |   3 +
 test/Makefile.am         |   1 +
 test/daxctl-create.sh    | 293 ++++++++++++++++++++++++++++++++++++
 util/filter.c            |   2 +-
 9 files changed, 686 insertions(+), 5 deletions(-)
 create mode 100755 test/daxctl-create.sh

-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
