Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504AE1F0B4E
	for <lists+linux-nvdimm@lfdr.de>; Sun,  7 Jun 2020 15:14:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 58F17100991A7;
	Sun,  7 Jun 2020 06:14:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BADB0100991A7
	for <linux-nvdimm@lists.01.org>; Sun,  7 Jun 2020 06:14:49 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 057D2OC5165880;
	Sun, 7 Jun 2020 09:14:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31g74s9qge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2020 09:14:06 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 057D3QcX168785;
	Sun, 7 Jun 2020 09:14:06 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31g74s9qg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2020 09:14:05 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 057D9vqv006051;
	Sun, 7 Jun 2020 13:14:04 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma04fra.de.ibm.com with ESMTP id 31g2s7rw50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2020 13:14:03 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 057DE1Vx64160092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jun 2020 13:14:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0191A4C044;
	Sun,  7 Jun 2020 13:14:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFDD54C040;
	Sun,  7 Jun 2020 13:13:54 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.68.227])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Sun,  7 Jun 2020 13:13:54 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Sun, 07 Jun 2020 18:43:53 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 2/6] seq_buf: Export seq_buf_printf
Date: Sun,  7 Jun 2020 18:43:35 +0530
Message-Id: <20200607131339.476036-3-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200607131339.476036-1-vaibhav@linux.ibm.com>
References: <20200607131339.476036-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-07_03:2020-06-04,2020-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 adultscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006070096
Message-ID-Hash: 7JZ7ZIGJDB5JXMFXVIJMBJNB5ZCEBGRB
X-Message-ID-Hash: 7JZ7ZIGJDB5JXMFXVIJMBJNB5ZCEBGRB
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>, Piotr Maziarz <piotrx.maziarz@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Christoph Hellwig <hch@infradead.org>, Borislav Petkov <bp@alien8.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7JZ7ZIGJDB5JXMFXVIJMBJNB5ZCEBGRB/>
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
