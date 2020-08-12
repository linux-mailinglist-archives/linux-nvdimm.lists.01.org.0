Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7450C242628
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Aug 2020 09:36:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2B20D12F3F3CA;
	Wed, 12 Aug 2020 00:36:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B418212F3F3C7
	for <linux-nvdimm@lists.01.org>; Wed, 12 Aug 2020 00:36:31 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07C7Wxt2087479;
	Wed, 12 Aug 2020 03:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=En13wJ6AHK/KKkSNmX+M3/+YBNiqcwfYH5rEj6UFq0k=;
 b=It3aLsnc/EZ8g9j/n3XzpRW5zNBuFk9MsHEGfhn+7B8a2pc0s8eLNLnm7iAmQQ1I0onD
 cM2cKY0w2oKVjTkwx+C4i2jZ+NJqCcRbAHZpfkjmpqO9GbaAOMt1XR9x6VCvPyyZdlW3
 5Iyqcr2ntoCoUmgTlHM6pSGxp7nROYfBhzZL301jzAb5Fmw+4aPVIxaldOFhVJEj7Fmr
 2uQsFYkSZ9u/TTUuc2jRDxbnQ9WSSKwMCHi/vXiugIs6noQagiHFDd3tO/6hS07EUVRP
 8kzflrxZEEfDwsj5ZE4zsWkH1Ujv6PUwZvx4Sx9WO3mDI9ucmTFR4JI1Gwqq+41bEesz pw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32v7nyxbqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2020 03:36:24 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07C7X0wv087615;
	Wed, 12 Aug 2020 03:36:23 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32v7nyxbqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2020 03:36:23 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07C7QNsR015815;
	Wed, 12 Aug 2020 07:36:21 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma04ams.nl.ibm.com with ESMTP id 32skp8458v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2020 07:36:21 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07C7aIVW64094680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2020 07:36:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C19D6AE051;
	Wed, 12 Aug 2020 07:36:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D95FAE059;
	Wed, 12 Aug 2020 07:36:15 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.60.7])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed, 12 Aug 2020 07:36:15 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 12 Aug 2020 13:06:14 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH] powerpc/papr_scm: Make access mode of 'perf_stats' attribute file to '0400'
In-Reply-To: <87wo26abmf.fsf@mpe.ellerman.id.au>
References: <20200807123146.11037-1-vaibhav@linux.ibm.com> <87wo26abmf.fsf@mpe.ellerman.id.au>
Date: Wed, 12 Aug 2020 13:06:14 +0530
Message-ID: <87k0y4xqmp.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-11_19:2020-08-11,2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=1 mlxscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008120054
Message-ID-Hash: 43IFEVGFDOUJBZE74CIKRER6U5PPLT7D
X-Message-ID-Hash: 43IFEVGFDOUJBZE74CIKRER6U5PPLT7D
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/43IFEVGFDOUJBZE74CIKRER6U5PPLT7D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Mpe,

Thanks for reviewing this patch. My responses below:

Michael Ellerman <mpe@ellerman.id.au> writes:

> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>> The newly introduced 'perf_stats' attribute uses the default access
>> mode of 0444 letting non-root users access performance stats of an
>> nvdimm and potentially force the kernel into issuing large number of
>> expensive HCALLs. Since the information exposed by this attribute
>> cannot be cached hence its better to ward of access to this attribute
>> from non-root users.
>>
>> Hence this patch updates the access-mode of 'perf_stats' sysfs
>> attribute file to 0400 to make it only readable to root-users.
>
> Or should we ratelimit it?
Ideal consumers of this data will be users with CAP_PERFMON or
CAP_SYS_ADMIN. Also they need up-to-date values for these performance stats
as these values can be time sensitive.

So rate limiting may not be a complete solution since a user running
'perf' might be throttled by another user who is simply reading the
sysfs file contents.

So instead of setting attribute mode to 0400, will add a check for
'perfmon_capable()' in perf_stats_show() denying read access to users
without CAP_PERFMON or CAP_SYS_ADMIN.


> Fixes: ??
Right. I will add this in v2.

>
>> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>
> cheers
>

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
