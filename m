Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B63F222B31
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jul 2020 20:47:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 53A7411078323;
	Thu, 16 Jul 2020 11:47:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 90BF211078320
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 11:47:40 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIcKKk059733;
	Thu, 16 Jul 2020 18:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=Pb1A4lHfdEmCl0YQITyS0pS9mKrVs4zr7g7kzCNzc68=;
 b=Qsd5CHRwIi3Vph8GsVmJ0wxkEkTmiUUpJggLQVle/8zkRrMqhHUrT7EAPTegKvXt03dr
 7Ay86owBhH25T6j5rFAe505+xQeQcKroasnBqMabjPLVJAxLGVdrL4+Il+7vHxehRacT
 7MQtw7XahgfP3MW2rzcyaHJGYtoW/xjhHXyV3eGu+C5rzocUCiy3yHcYyNN/Z1GkUVRI
 sySbfqBnsxh2E5WzDazYwb1+33gWBMbuQmjso4mmgcVqf/eLjEIGLy3VB+1+Yv4dy7sf
 Kr6YZapIZXvodtoGN+vsN0YOVYNG7EDg+wn6LLygqXwZj/mYDMtlWDsqxigCviKTZqph yw==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 3274urk8mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2020 18:47:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIbjMI095944;
	Thu, 16 Jul 2020 18:47:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3030.oracle.com with ESMTP id 327q0u0bj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2020 18:47:36 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06GIlZGn007426;
	Thu, 16 Jul 2020 18:47:35 GMT
Received: from paddy.uk.oracle.com (/10.175.173.87)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 16 Jul 2020 11:47:34 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH ndctl v1 0/8] daxctl: Add device align and range mapping allocation
Date: Thu, 16 Jul 2020 19:46:59 +0100
Message-Id: <20200716184707.23018-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160131
Message-ID-Hash: EPP6ZYG2YHRYOBQAI7LEJI4OVJQQKJRR
X-Message-ID-Hash: EPP6ZYG2YHRYOBQAI7LEJI4OVJQQKJRR
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jason Zeng <jason.zeng@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EPP6ZYG2YHRYOBQAI7LEJI4OVJQQKJRR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hey,

This series builds on top of this one[0] and does the following improvements
to the Soft-Reserved subdivision:

 1) Support for {create,reconfigure}-device for selecting @align (hugepage size).
 Here we add a '-a|--align 4K|2M|1G' option to the existing commands;

 2) Listing improvements for device alignment and mappings;
 Note: Perhaps it is better to hide the mappings by default, and only
       print with -v|--verbose. This would align with ndctl, as the mappings
       info can be quite large.

 3) Allow creating devices from selecting ranges. This allows to keep the
   same GPA->HPA mapping as before we kexec the hypervisor with running guests:

   daxctl list -d dax0.1 > /var/log/dax0.1.json
   kexec -d -l bzImage
   systemctl kexec
   daxctl create -u --restore /var/log/dax0.1.json

   The JSON was what I though it would be easier for an user, given that it is
   the data format daxctl outputs. Alternatives could be adding multiple:
   	--mapping <pgoff>:<start>-<end>

   But that could end up in a gigantic line and a little more
   unmanageable I think.

This series requires this series[0] on top of Dan's patches[1]:

 [0] https://lore.kernel.org/linux-nvdimm/20200716172913.19658-1-joao.m.martins@oracle.com/
 [1] https://lore.kernel.org/linux-nvdimm/159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com/

The only TODO here is docs and improving tests to validate mappings, and test
the restore path.

Suggestions/comments are welcome.

	Joao

Joao Martins (8):
  daxctl: add daxctl_dev_{get,set}_align()
  util/json: Print device align
  daxctl: add align support in reconfigure-device
  daxctl: add align support in create-device
  libdaxctl: add mapping iterator APIs
  daxctl: include mappings when listing
  libdaxctl: add daxctl_dev_set_mapping()
  daxctl: Allow restore devices from JSON metadata

 daxctl/device.c                | 154 +++++++++++++++++++++++++++++++++++++++--
 daxctl/lib/libdaxctl-private.h |   9 +++
 daxctl/lib/libdaxctl.c         | 152 +++++++++++++++++++++++++++++++++++++++-
 daxctl/lib/libdaxctl.sym       |   9 +++
 daxctl/libdaxctl.h             |  16 +++++
 util/json.c                    |  63 ++++++++++++++++-
 util/json.h                    |   3 +
 7 files changed, 396 insertions(+), 10 deletions(-)

-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
