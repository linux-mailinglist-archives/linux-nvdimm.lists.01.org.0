Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C87264189
	for <lists+linux-nvdimm@lfdr.de>; Thu, 10 Sep 2020 11:22:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B7D281412EDB2;
	Thu, 10 Sep 2020 02:22:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 377CC1412EDB2
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 02:22:32 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08A92jxi016335;
	Thu, 10 Sep 2020 05:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=XV+b+l4EK1i++0wxPJ2Ef+aZ1FchdQdLkP57dxe0STQ=;
 b=AtJd4BZNeENMAcMdUCLP8F39dmPhGUXHWqrxmH6P16iPDqxoU0VDmEUB9CsDPF8aFDoG
 OrN/l+bSqcsBxjdWplYN6Xx8d5p6qahYLoImeD3SwUKmNXfYPcdj9ZBlmdjdaUqWJK1L
 53+0GQ2dMyLBpKtgeXctx4ZOd7bJegOsLkX3p7JNijKfa6SQ7284IHESXmzFxDYQbo+E
 YVrbOdWqcb97ESUdBxHzObLTs6biAmp4JQ94dvMlH6BIUTvJJ/QvP+rHtcj2LwRVO5cS
 +nbw89UF5AT+QAD7BnmP3ADjbXjQrFn+7hw1wy8Gi0Ppbg7vcWO9ipkwphD4xbI1KE8C 3g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 33fg9ejbvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2020 05:22:26 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08A93bvL019978;
	Thu, 10 Sep 2020 05:22:25 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 33fg9ejbuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2020 05:22:24 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08A9Cfpf030248;
	Thu, 10 Sep 2020 09:22:22 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma04ams.nl.ibm.com with ESMTP id 33c2a8dvdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2020 09:22:22 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08A9MJlf37880154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2020 09:22:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74761A405F;
	Thu, 10 Sep 2020 09:22:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 994F4A405B;
	Thu, 10 Sep 2020 09:22:15 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.85.112.148])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Thu, 10 Sep 2020 09:22:15 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 10 Sep 2020 14:52:14 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [PATCH] powerpc/papr_scm: Fix warning triggered by perf_stats_show()
Date: Thu, 10 Sep 2020 14:52:12 +0530
Message-Id: <20200910092212.107674-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_01:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 suspectscore=0 clxscore=1011 adultscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100080
Message-ID-Hash: MIL47BU5BRC7XTPBZWNCYH6VD7RGBYXG
X-Message-ID-Hash: MIL47BU5BRC7XTPBZWNCYH6VD7RGBYXG
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MIL47BU5BRC7XTPBZWNCYH6VD7RGBYXG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A warning is reported by the kernel in case perf_stats_show() returns
an error code. The warning is of the form below:

 papr_scm ibm,persistent-memory:ibm,pmemory@44100001:
 	  Failed to query performance stats, Err:-10
 dev_attr_show: perf_stats_show+0x0/0x1c0 [papr_scm] returned bad count
 fill_read_buffer: dev_attr_show+0x0/0xb0 returned bad count

On investigation it looks like that the compiler is silently truncating the
return value of drc_pmem_query_stats() from 'long' to 'int', since the
variable used to store the return code 'rc' is an 'int'. This
truncated value is then returned back as a 'ssize_t' back from
perf_stats_show() to 'dev_attr_show()' which thinks of it as a large
unsigned number and triggers this warning..

To fix this we update the type of variable 'rc' from 'int' to
'ssize_t' that prevents the compiler from truncating the return value
of drc_pmem_query_stats() and returning correct signed value back from
perf_stats_show().

Fixes: 2d02bf835e573 ('powerpc/papr_scm: Fetch nvdimm performance
       stats from PHYP')
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index a88a707a608aa..9f00b61676ab9 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -785,7 +785,8 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
 static ssize_t perf_stats_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	int index, rc;
+	int index;
+	ssize_t rc;
 	struct seq_buf s;
 	struct papr_scm_perf_stat *stat;
 	struct papr_scm_perf_stats *stats;
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
