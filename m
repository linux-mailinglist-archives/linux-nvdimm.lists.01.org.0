Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7B728882B
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Oct 2020 14:00:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4428D1599040C;
	Fri,  9 Oct 2020 05:00:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8DC671599530D
	for <linux-nvdimm@lists.01.org>; Fri,  9 Oct 2020 05:00:24 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099BYeZ3018528;
	Fri, 9 Oct 2020 08:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=LKFlVv5ejM5a4esJyL2vyoao/NvPAIxWTpeCLYEryQ0=;
 b=jrdIRyInqXb0bjG4rW3u3JovH004X8skc3uSBFv+hd3BX5ASXn/6RVMEQJF6gxrrTij3
 WZcXp2SGJAW7uh92pDClJnvIytjG8gbVve9k/djcnLU723HHQoAo6PSCgn8Ae8u7+j2p
 ArS12YvQwIBS36Aub4ugg58KKnD2DBwWJ2/59u0NqiYKakqiEDzQY+i5UqUf6AH7RwTr
 jF/mc8f82yDvV334x8dggGD9Y+aiv/44BRLFSDRZSWO50dgRUoteE0vYDD6OANm0egyJ
 BJHlAdL4JzQeWTqMDre1yURXyjZdcbniogOTxc7VcL4uscvwj1ru3IXKfNsehwDnZsMj 7g==
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 342px6s27u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2020 08:00:23 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 099Bq37X005513;
	Fri, 9 Oct 2020 12:00:20 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma03ams.nl.ibm.com with ESMTP id 3429hugmcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2020 12:00:20 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 099C0HLV21627278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2020 12:00:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93884AE063;
	Fri,  9 Oct 2020 12:00:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BBAEAE061;
	Fri,  9 Oct 2020 12:00:15 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.77.204.196])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Fri,  9 Oct 2020 12:00:15 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Fri, 09 Oct 2020 17:30:14 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH] libndctl: Fix probe of non-nfit nvdimms
Date: Fri,  9 Oct 2020 17:30:09 +0530
Message-Id: <20201009120009.243108-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_06:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 suspectscore=1 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090082
Message-ID-Hash: XU5H5E4YG7JJOMNKQ4FJEAQUSB7TZUG2
X-Message-ID-Hash: XU5H5E4YG7JJOMNKQ4FJEAQUSB7TZUG2
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XU5H5E4YG7JJOMNKQ4FJEAQUSB7TZUG2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

commit 107a24ff429f ("ndctl/list: Add firmware activation
enumeration") introduced changes in add_dimm() to enumerate the status
of firmware activation. However a branch added in that commit broke
the probe for non-nfit nvdimms like one provided by papr-scm. This
cause an error reported when listing namespaces like below:

$ sudo ndctl list
libndctl: add_dimm: nmem0: probe failed: No such device
libndctl: __sysfs_device_parse: nmem0: add_dev() failed

Do a fix for this by removing the offending branch in the add_dimm()
patch. This continues the flow of add_dimm() probe even if the nfit is
not detected on the associated bus.

Fixes: 107a24ff429fa("ndctl/list: Add firmware activation enumeration")
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/lib/libndctl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 554696386f48..ad521d365ee4 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -1875,9 +1875,6 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 	else
 		dimm->fwa_result = fwa_result_to_result(buf);
 
-	if (!ndctl_bus_has_nfit(bus))
-		goto out;
-
 	/* Check if the given dimm supports nfit */
 	if (ndctl_bus_has_nfit(bus)) {
 		dimm->formats = formats;
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
