Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6A221DB4D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 18:11:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 40E6911812911;
	Mon, 13 Jul 2020 09:10:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B566118128FF
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 09:10:57 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG2sKf153769;
	Mon, 13 Jul 2020 16:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=Yat0tzS6o6GbJahXeNTH6b11qdt4J+iL9R6HwJwqGqE=;
 b=IMOY0gWhOtkGo8eZSGrw1LlsgNqt/wmUZfEEtCmdMlVkt1MrnibFGP4GrboKuk9rnmR6
 iBdd5CCV3RGr2ndYRkKZ0OviXcNEGDE2x3D9CqcP3b9yxurTKBxeEolrAeireQy0H3+Y
 S7KV/KpUtG7Uab4y1Cg26194/DBpRDs3OcRkEpHC3inTrfedunzx14c3KbKO2XZXSi0l
 nck/QBt+4EOkpV/jcBAOBj3ymsIbjo25jrullMFctnk0Zy0lutvufL7O+9c+SRYGUM3Y
 ummw+1PAwUeNur8jQuRj5juM5kvRVBhRMKz77uP5j4rD9pa0xpQ9gB51zfsu+fR25MXP 5w==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 32762n7vcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2020 16:10:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG3XgU138168;
	Mon, 13 Jul 2020 16:08:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 327q0mhx9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2020 16:08:54 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06DG8rCn011378;
	Mon, 13 Jul 2020 16:08:53 GMT
Received: from paddy.uk.oracle.com (/10.175.167.147)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 13 Jul 2020 09:08:53 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v2 00/10] daxctl: Support for sub-dividing soft-reserved regions
Date: Mon, 13 Jul 2020 17:08:27 +0100
Message-Id: <20200713160837.13774-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=979 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130119
Message-ID-Hash: MFA6TPP6DX5JTT32Q4YQDHFNXA7YSUHV
X-Message-ID-Hash: MFA6TPP6DX5JTT32Q4YQDHFNXA7YSUHV
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MFA6TPP6DX5JTT32Q4YQDHFNXA7YSUHV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v1:

* Add a Documentation/daxctl/ entry for each patch that adds commands or new
option.

* Fix functional test suite to only change region 0 and not touch others

* Fix reconfigure-device -s changes (third patch) for better bisection.

v1: https://lore.kernel.org/linux-nvdimm/20200403205900.18035-1-joao.m.martins@oracle.com/

---

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

 * Add test coverage (Tried to cover all range allocation code paths).
 v2 of kernel patches now passes this test suite.

 * Documentation regarding the new command additions.

[0] "device-dax: Support sub-dividing soft-reserved ranges",
https://lore.kernel.org/linux-nvdimm/159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com/

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

 Documentation/daxctl/Makefile.am                   |   6 +-
 Documentation/daxctl/daxctl-create-device.txt      | 105 +++++++
 Documentation/daxctl/daxctl-destroy-device.txt     |  63 +++++
 Documentation/daxctl/daxctl-disable-device.txt     |  58 ++++
 Documentation/daxctl/daxctl-enable-device.txt      |  59 ++++
 Documentation/daxctl/daxctl-reconfigure-device.txt |  16 ++
 daxctl/builtin.h                                   |   4 +
 daxctl/daxctl.c                                    |   4 +
 daxctl/device.c                                    | 310 ++++++++++++++++++++-
 daxctl/lib/libdaxctl.c                             |  67 +++++
 daxctl/lib/libdaxctl.sym                           |   7 +
 daxctl/libdaxctl.h                                 |   3 +
 test/Makefile.am                                   |   1 +
 test/daxctl-create.sh                              | 294 +++++++++++++++++++
 util/filter.c                                      |   2 +-
 15 files changed, 993 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/daxctl/daxctl-create-device.txt
 create mode 100644 Documentation/daxctl/daxctl-destroy-device.txt
 create mode 100644 Documentation/daxctl/daxctl-disable-device.txt
 create mode 100644 Documentation/daxctl/daxctl-enable-device.txt
 create mode 100755 test/daxctl-create.sh

-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
