Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE22AEB42
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Nov 2020 09:26:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B4E31685A0B8;
	Wed, 11 Nov 2020 00:26:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=borntraeger@de.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 96F361685A0B3
	for <linux-nvdimm@lists.01.org>; Wed, 11 Nov 2020 00:26:32 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AB8O6GC003382;
	Wed, 11 Nov 2020 03:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=cUmKwLEAyQVRF4lV9GFoZMc6wfddiF5gnKiTJOkJ0rA=;
 b=ljchvJrCF3n/yPcTgvcEaNJH5vnnBc6f6YQFukrWrP3f3Kq5PMvqxK77eQXrxD1M8tr5
 iY3tTkcJPINN2IqDUVEN5Gx/7HCVZXVjm6dpBI4sKT64/7Yi6aS5G+TAa5KIg7P9lMFI
 JQLdHro3lm6ZaVHs14R0A2mjN7Qf/5ba4oPJg2tMF1O8oyWfAYmBcrBMSz7FLk0CLF3P
 RaqTnZH8EQ47Pfqg3rPJ3O6YguNQS82reafSzuzJmmSsv9iqaOFPshE85VFYUV04SLwH
 76jxhAgaLCGDc4ufPGo3L+lBJNCZIJ/ct4ja8L7nmGe3a4FHjYrM3grmINd9tPT6d5JE 8A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 34qkt0b0ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2020 03:26:27 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AB8QQbV012197;
	Wed, 11 Nov 2020 03:26:26 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 34qkt0b0k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2020 03:26:26 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AB8Lfv1024018;
	Wed, 11 Nov 2020 08:26:24 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma04ams.nl.ibm.com with ESMTP id 34p26pkay8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2020 08:26:23 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AB8QLkD4194840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2020 08:26:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FD164C040;
	Wed, 11 Nov 2020 08:26:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E2F04C04E;
	Wed, 11 Nov 2020 08:26:20 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.72.90])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2020 08:26:20 +0000 (GMT)
Subject: Re: [PATCH 2/2] mm: simplify follow_pte{,pmd}
To: Christoph Hellwig <hch@lst.de>, Nick Desaulniers <ndesaulniers@google.com>
References: <20201029101432.47011-3-hch@lst.de>
 <20201111022122.1039505-1-ndesaulniers@google.com>
 <20201111081800.GA23492@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <673267d5-93f5-7278-7a9d-a7b35ede6d48@de.ibm.com>
Date: Wed, 11 Nov 2020 09:26:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <20201111081800.GA23492@lst.de>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_02:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=950 suspectscore=0 clxscore=1011 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011110043
Message-ID-Hash: WRP2LQABZQH4WAJP6I4KIFADKZLAIDBH
X-Message-ID-Hash: WRP2LQABZQH4WAJP6I4KIFADKZLAIDBH
X-MailFrom: borntraeger@de.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: akpm@linux-foundation.org, daniel@ffwll.ch, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, clang-built-linux@googlegroups.com, Linux-Next Mailing List <linux-next@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WRP2LQABZQH4WAJP6I4KIFADKZLAIDBH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 11.11.20 09:18, Christoph Hellwig wrote:
> On Tue, Nov 10, 2020 at 06:21:22PM -0800, Nick Desaulniers wrote:
>> Sorry, I think this patch may be causing a regression for us for s390?
>> https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/432129279#L768
>>
>> (via https://lore.kernel.org/linux-mm/20201029101432.47011-3-hch@lst.de)
> 
> Hmm, the call to follow_pte_pmd in the s390 code does not actually exist
> in my tree.

This is a mid-air collision in linux-next between

b2ff5796a934 ("mm: simplify follow_pte{,pmd}")
a67a88b0b8de ("s390/pci: remove races against pte updates")
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
