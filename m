Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 287DC293A05
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Oct 2020 13:27:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3613915F525C6;
	Tue, 20 Oct 2020 04:27:21 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sachinp@linux.vnet.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 657DE159ADF46
	for <linux-nvdimm@lists.01.org>; Tue, 20 Oct 2020 04:27:19 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09KB2c1T144699;
	Tue, 20 Oct 2020 07:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=Bac6sF/7FNhGc4sUVLECbjpZSxf1A8UO7K4p4+Evoo4=;
 b=QA/MYTKAHs/H6UBN5EsKnYlumDEU3zC+/42jjMhiplF02b3PfhjuWr/ROshH8eC1qqo4
 9o3guWHVQQqZXc1VglDq+wQ9o12GJH28lGq9BrDAWC3xebtjT3+CH3vtGs4SfjuWyp9R
 rUYCV8vvQHVQXMi74DRlDXgmFaGIyB5i98waeWbW+qDjo+qghCEz2o9bybhjNOuScUrT
 TSd+CiX+bmrR90XRb2EC4fHOz1cHcVlehow1YlpFwZODWpa4WlJe11hHG0/nwwygwxtK
 vpMaiGOy3Y2tC47akaznAXLKicNDmmm9Kc89nHa8o+EueOz0I0yXy/MZIz/iu4ivwxoe Dg==
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 349wsa2b7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2020 07:27:09 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09KBMBk0015902;
	Tue, 20 Oct 2020 11:27:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma05fra.de.ibm.com with ESMTP id 347r881mgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2020 11:27:07 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09KBR48K29098354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2020 11:27:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA4C15204F;
	Tue, 20 Oct 2020 11:27:04 +0000 (GMT)
Received: from [9.199.58.151] (unknown [9.199.58.151])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1CD615204E;
	Tue, 20 Oct 2020 11:27:03 +0000 (GMT)
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: negative count with static key devmap_managed_key
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <87sga9jn4a.fsf@linux.ibm.com>
Date: Tue, 20 Oct 2020 16:57:03 +0530
Message-Id: <422D5C36-A500-4842-8FE4-188ABA111418@linux.vnet.ibm.com>
References: <87wnzljpq0.fsf@linux.ibm.com> <87sga9jn4a.fsf@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailer: Apple Mail (2.3445.104.17)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-20_05:2020-10-20,2020-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200070
Message-ID-Hash: EYIDXJSDRYEVJVN2C4LC5P5C5PAWWIFJ
X-Message-ID-Hash: EYIDXJSDRYEVJVN2C4LC5P5C5PAWWIFJ
X-MailFrom: sachinp@linux.vnet.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EYIDXJSDRYEVJVN2C4LC5P5C5PAWWIFJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On 20-Oct-2020, at 2:22 PM, Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> wrote:
> 
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> Hi Christoph,
>> 
>> commit 6f42193fd86e ("memremap: don't use a separate devm action for
>> devmap_managed_enable_get") changed the static key updates such that we
>> are now calling	devmap_managed_enable_put() without doing the equivalent
>> devmap_managed_enable_get().
>> 
>> devmap_managed_enable_get() is only called for MEMORY_DEVICE_PRIVATE and
>> MEMORY_DEVICE_FS_DAX, But memunmap_pages() get called for other pgmap
>> types too. This result in the below. I can recreate this by repeatedly
>> switching between system-ram and devdax mode for devdax namespace. 
>> 
>> 
> 
> 
> mm/memremap.c | 19 +++++++++++++++----
> 
> modified   mm/memremap.c
> @@ -158,6 +158,16 @@ void memunmap_pages(struct dev_pagemap *pgmap)

This fixes the warning for me.

Thanks
-Sachin
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
