Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634B0244B92
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Aug 2020 17:05:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A8BEB12F6E11E;
	Fri, 14 Aug 2020 08:05:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BAE5D12F6E11C
	for <linux-nvdimm@lists.01.org>; Fri, 14 Aug 2020 08:05:37 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07EF4D5p128363;
	Fri, 14 Aug 2020 11:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=9lfdzU0VXKwmw8ic/GIjVJrz9F+3Dca+bz7+pCbHQpU=;
 b=P6TcOYR5rXv5oFiu55rnML7Z4d6gWNhuIFeUHoEeYxkIQbRyqjRlMexsHWWnNxDoqcwF
 w8PV5Oqj4WcXM4vA+gR4pwqHxTXkx7FPfBCGBP0LZpQ4vwb/MZsMMFkL24e8DTySHy/E
 mJTCPfFimlTxovmgcwN1vWupI5+BTlNT8mvmU7Z8Yues0xubQ9gfS7WzowEVGyvFD/nG
 7Mzc5uzNeh6y3u8B6c38ohyPSgJouxe50pmNn8xaxIJi8Bd4rbdzsmF1TImOCLWTMEDN
 0vGYBi7VoPZQ/WEfBG2YzFAZxUdjp516fGhKIi2WSEcZDArLphoeJoJD3kBrWmymTNJD wA==
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0b-001b2d01.pphosted.com with ESMTP id 32wvxb01x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2020 11:05:25 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07EF4H8F028033;
	Fri, 14 Aug 2020 15:05:23 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma06ams.nl.ibm.com with ESMTP id 32skaher6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2020 15:05:23 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07EF5Kvr24445262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2020 15:05:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2550F4C040;
	Fri, 14 Aug 2020 15:05:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9A104C04A;
	Fri, 14 Aug 2020 15:05:17 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.37.20])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Fri, 14 Aug 2020 15:05:17 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Fri, 14 Aug 2020 20:35:16 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [PATCH] libnvdimm: Add a NULL entry to 'nvdimm_firmware_attributes'
Date: Fri, 14 Aug 2020 20:35:09 +0530
Message-Id: <20200814150509.225615-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-14_09:2020-08-14,2020-08-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008140111
Message-ID-Hash: HMPSVB7VHHVCP6GT7JYJDPHQ6IRO4DBN
X-Message-ID-Hash: HMPSVB7VHHVCP6GT7JYJDPHQ6IRO4DBN
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Sandipan Das <sandipan@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HMPSVB7VHHVCP6GT7JYJDPHQ6IRO4DBN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We recently discovered a kernel oops with 'papr_scm' module while
booting ppc64 phyp guest with following back-trace:

BUG: Kernel NULL pointer dereference on write at 0x00000188
Faulting instruction address: 0xc0000000005d7084
Oops: Kernel access of bad area, sig: 11 [#1]
<snip>
Call Trace:
 internal_create_group+0x128/0x4c0 (unreliable)
 internal_create_groups.part.4+0x70/0x130
 device_add+0x458/0x9c0
 nd_async_device_register+0x28/0xa0 [libnvdimm]
 async_run_entry_fn+0x78/0x1f0
 process_one_work+0x2c0/0x5b0
 worker_thread+0x88/0x650
 kthread+0x1a8/0x1b0
 ret_from_kernel_thread+0x5c/0x6c

A bisect lead to the 'commit 48001ea50d17f ("PM, libnvdimm: Add runtime
firmware activation support")' and on investigation discovered that
the newly introduced 'struct attribute *nvdimm_firmware_attributes[]'
is missing a terminating NULL entry in the array. This causes a loop
in sysfs's 'create_files()' to read garbage beyond bounds of
'nvdimm_firmware_attributes' and trigger the oops.

Fixes: 48001ea50d17f ("PM, libnvdimm: Add runtime firmware activation support")
Reported-by: Sandipan Das <sandipan@linux.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 drivers/nvdimm/dimm_devs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 61374def51555..b59032e0859b7 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -529,6 +529,7 @@ static DEVICE_ATTR_ADMIN_RW(activate);
 static struct attribute *nvdimm_firmware_attributes[] = {
 	&dev_attr_activate.attr,
 	&dev_attr_result.attr,
+	NULL,
 };
 
 static umode_t nvdimm_firmware_visible(struct kobject *kobj, struct attribute *a, int n)
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
