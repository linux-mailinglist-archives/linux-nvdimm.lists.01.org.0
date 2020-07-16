Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BBF2229E6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jul 2020 19:29:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2986311BB486E;
	Thu, 16 Jul 2020 10:29:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 287CB114DE55B
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 10:29:41 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GHMCCs108201;
	Thu, 16 Jul 2020 17:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to; s=corp-2020-01-29;
 bh=ZkLmXaQi9ugUcPGIWCmMgZ6iQMhcjVJkBMoXeOQwmyM=;
 b=RUBQfUgmGKChbgMYUmEvIcVT3+aJZYhwqkHWUKpO5rPrQkilijpWXETaWT4LmQ96BF7y
 P/oKa+3s6SFsI7CYFSlnZRD/x9AVlbiugk+uKy4Ry8kt7WtR+aQai9iIO4jC7DtJl+nn
 HLXPSAGelTdcbvi3LLlduGK4hxHTOObWVHxs731Sz64ppe9UaW/V53mFmddjReVQ0R1n
 akCk8xVzPJF9UjkAW9t0vyjd8Vo5koDzZa6q+UkTP+WAY1yXOTVPZRnX8ROBN0CM41iU
 PDOgoL08ydnGbrdA5iPFyB/T1MKQp/O+1FRVP1IhrnS2BRpSG1rilgv92WJoNmHfN0ON qg==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 3274urjv5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2020 17:29:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GHHlFm071570;
	Thu, 16 Jul 2020 17:29:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 32akr3qw0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2020 17:29:36 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06GHTZVM019031;
	Thu, 16 Jul 2020 17:29:35 GMT
Received: from paddy.uk.oracle.com (/10.175.173.87)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 16 Jul 2020 10:29:35 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v1 0/4] device-dax: Further improvements to subdivision
Date: Thu, 16 Jul 2020 18:29:09 +0100
Message-Id: <20200716172913.19658-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160126
Message-ID-Hash: NZPANO3XYIW7CH2BTUGTQJUEPNEDV4WY
X-Message-ID-Hash: NZPANO3XYIW7CH2BTUGTQJUEPNEDV4WY
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Jason Zeng <jason.zeng@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NZPANO3XYIW7CH2BTUGTQJUEPNEDV4WY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hey,

Here's a small set of improvements that I was hoping you would consider as part
of your Soft-Reserved series[0]; should you think they make sense. It does the
following:

  Patch 1-2: Add an align sysfs attribute, as opposed to being limited to 2M.
  This brings parity to static dax regions, which support 1G.

  Patch 3. Add a module parameter to hmem, to initialize the region as idle
  with full available_size for child devices. When the region is gonna be
  partiotined by default and assigned to guests, doesn't help to
  initialize the region. Also if the majority of the region starts
  non-idle and it's a region which memmap is bigger than System-Ram,
  then there not be enough space for the device to be probed successfully.

  Patch 4: Add an sysfs attribute for range allocation. It is a single entry
  where you pass a range <start>-<end> and where the ordering plus range
  length designate the page_offset. It is meant for recreate the same
  mappings after kexec (retaining the GPA->HPA association), but could
  also allow application to implement their own allocation strategy.

I will submit a separate daxctl counterpart shortly, to help visualize its use.

[0] https://lore.kernel.org/linux-mm/159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com

	Joao

Joao Martins (4):
  device-dax: Make align a per-device property
  device-dax: Add an 'align' attribute
  dax/hmem: Introduce dax_hmem.region_idle parameter
  device-dax: Add a range mapping allocation attribute

 drivers/dax/bus.c         | 166 +++++++++++++++++++++++++++++++++++---
 drivers/dax/dax-private.h |   1 +
 drivers/dax/device.c      |  35 ++++----
 drivers/dax/hmem/hmem.c   |   5 +-
 4 files changed, 177 insertions(+), 30 deletions(-)

-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
