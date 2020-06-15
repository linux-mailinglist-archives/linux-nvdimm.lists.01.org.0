Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9721F9678
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Jun 2020 14:27:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 532EC110F2E12;
	Mon, 15 Jun 2020 05:27:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3ECBA10113FC6
	for <linux-nvdimm@lists.01.org>; Mon, 15 Jun 2020 05:27:50 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FC2J5Y058780;
	Mon, 15 Jun 2020 08:27:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31mseyfdwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2020 08:27:10 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05FCNxZw129774;
	Mon, 15 Jun 2020 08:27:10 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31mseyfdvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2020 08:27:10 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05FCLYSp030910;
	Mon, 15 Jun 2020 12:27:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma04ams.nl.ibm.com with ESMTP id 31mpe7uhcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2020 12:27:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05FCPmDW58851664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2020 12:25:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 983E04204D;
	Mon, 15 Jun 2020 12:27:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4419542041;
	Mon, 15 Jun 2020 12:27:01 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.96.47])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Mon, 15 Jun 2020 12:27:01 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Mon, 15 Jun 2020 17:57:00 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 2/6] seq_buf: Export seq_buf_printf
Date: Mon, 15 Jun 2020 17:56:40 +0530
Message-Id: <20200615122644.31887-3-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615122644.31887-1-vaibhav@linux.ibm.com>
References: <20200615122644.31887-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_02:2020-06-15,2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 cotscore=-2147483648 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006150098
Message-ID-Hash: AJOKMLKOC4GWXOWFPH3EQPWLYWWX4LYW
X-Message-ID-Hash: AJOKMLKOC4GWXOWFPH3EQPWLYWWX4LYW
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>, Piotr Maziarz <piotrx.maziarz@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Christoph Hellwig <hch@infradead.org>, Borislav Petkov <bp@alien8.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AJOKMLKOC4GWXOWFPH3EQPWLYWWX4LYW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

'seq_buf' provides a very useful abstraction for writing to a string
buffer without needing to worry about it over-flowing. However even
though the API has been stable for couple of years now its still not
exported to kernel loadable modules limiting its usage.

Hence this patch proposes update to 'seq_buf.c' to mark
seq_buf_printf() which is part of the seq_buf API to be exported to
kernel loadable GPL modules. This symbol will be used in later parts
of this patch-set to simplify content creation for a sysfs attribute.

Cc: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Borislav Petkov <bp@alien8.de>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v11..v12:
* None

v10..v11:
* None

v9..v10:
* None

Resend:
* Added ack from Steven Rostedt

v8..v9:
* None

v7..v8:
* Updated the patch title [ Christoph Hellwig ]
* Updated patch description to replace confusing term 'external kernel
  modules' to 'kernel lodable modules'.

Resend:
* Added ack from Steven Rostedt

v6..v7:
* New patch in the series
---
 lib/seq_buf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 4e865d42ab03..707453f5d58e 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -91,6 +91,7 @@ int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(seq_buf_printf);
 
 #ifdef CONFIG_BINARY_PRINTF
 /**
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
