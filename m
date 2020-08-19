Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CD5249931
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 11:19:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 34719134F8BD2;
	Wed, 19 Aug 2020 02:19:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 54A52134F0B79
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 02:19:41 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07J8XR0j057281;
	Wed, 19 Aug 2020 05:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=aEtAkvGpkOg2uUlDQkAYVJcVLR0cOsNQ3wNqajETxpg=;
 b=ffxxRpH8XJql+GKXTMun0SP2+V9l3f7s8KJvwMR2I5k2JwbH/KYdP30O0a52QTNq8Sf9
 suru7PKfvWBcNtup5lzAGvCW9yfr+wGYRykur6DtQL7cp7suSKVCOSGM1eXGad6O8ehQ
 fJd5Zdutj7tLBEe21qiJLAJ0lBOIrq1ocI3qNCJJt1Yqj7an0InrL3dxyug29Snz3Mt/
 xyYdU7bqxELlQJWWfTYQw95leCK+yxxReI6bs2ZL2Rju8ySbwQVUmzm1NnNnH7DSQXQ+
 RGA8doW2OFc45zmYhz8VJVtY8xMku68IMXyamtm5Ck+mXC/exFdNYprUj45q+Er0Cm+H ug==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3310ey1p91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2020 05:19:34 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07J8YqY5061975;
	Wed, 19 Aug 2020 05:19:34 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3310ey1p84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2020 05:19:34 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07J9EsFR030390;
	Wed, 19 Aug 2020 09:19:31 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma03fra.de.ibm.com with ESMTP id 3304c911kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2020 09:19:31 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07J9JTu514025006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2020 09:19:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 360E34C04E;
	Wed, 19 Aug 2020 09:19:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F3E94C046;
	Wed, 19 Aug 2020 09:19:26 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.79.211.172])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed, 19 Aug 2020 09:19:26 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Wed, 19 Aug 2020 14:49:25 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Santosh Sivaraj <santosh@fossix.org>, Ira Weiny <ira.weiny@intel.com>,
        "Oliver O'Halloran" <oohall@gmail.com>
Subject: Re: [PATCH] powerpc/papr_scm: Limit the readability of 'perf_stats' sysfs attribute
In-Reply-To: <87imdm9frg.fsf@mpe.ellerman.id.au>
References: <20200813043458.165718-1-vaibhav@linux.ibm.com> <13e82e40-35c7-266c-2ec0-5fcdcb5fb27f@linux.ibm.com> <87imdm9frg.fsf@mpe.ellerman.id.au>
Date: Wed, 19 Aug 2020 14:49:25 +0530
Message-ID: <87imdfgfhe.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_04:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 suspectscore=1
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190073
Message-ID-Hash: A5MO5NVEPGKLLSMRSA6QXDEMOBFZTSHK
X-Message-ID-Hash: A5MO5NVEPGKLLSMRSA6QXDEMOBFZTSHK
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A5MO5NVEPGKLLSMRSA6QXDEMOBFZTSHK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks Aneesh and Mpe for reviewing this patch.

Michael Ellerman <mpe@ellerman.id.au> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
[snip]
>>>   
>>> +	/* Allow access only to perfmon capable users */
>>> +	if (!perfmon_capable())
>>> +		return -EACCES;
>>> +
>>
>> An access check is usually done in open(). This is the read callback IIUC.
>
> Yes. Otherwise an unprivileged user can open the file, and then trick a
> suid program into reading from it.

Agree, but since the 'open()' for this sysfs attribute is handled
by kern-fs, AFAIK dont see any direct way to enforce this policy.

Only other way it seems to me is to convert the 'perf_stats' DEVICE_ATTR_RO
to DEVICE_ATTR_ADMIN_RO.

>
> cheers

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
